//! `triton-fold-iota-integers`（`FoldIotaIntegers.cpp`）：只由 arange 与标量派生的整型张量，在 select 的条件里折成
//! 「常量张量与铺开的标量比较」：`(s1 + C1) pred (s2 + C2) ⇔ (C1 - C2) pred (s2 - s1)`，左边在 f32 上用 arange 的 sitofp、比较与
//! select 搭出来，右边一个标量 sitofp 后铺开。只改数据的 select（结果是浮点）；条件的合取树拆开，`select(a & b, x, y)` 变成嵌套的
//! select。分析途中建的 op（标量的加减乘）照 C++ 原版当场建：改写不成也留在 IR 里（之后的 canonicalize 收拾），次序相同。
use std::collections::BTreeMap;

use mlirformat::arith::{CmpFPredicate, CmpIPredicate};
use mlirformat::{Attribute, Error, FloatKind, Type};
use mlirpass::{Body, OpId, PatternSet, Rewriter, ValueId, pass, patterns};

use super::uniform_lanes::Canon;
use crate::ir::{TtBuilder, float, int};
use crate::{Ir, Kind};

const MAX_DEPTH: u32 = 24;
const MAX_ELEMENTS: i64 = 1 << 14;
const MAX_STEPS: usize = 16;

#[pass("triton-fold-iota-integers", on = "builtin.module", ty = FoldIotaIntegers)]
pub fn fold_iota_integers<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut set = PatternSet::default();
    IotaRules::patterns(&mut set);
    if body.walk_and_apply(op, &set) {
        Canon::run(body, op)?;
    }
    Ok(())
}

/// 条件是 arange 派生的整型张量比较、结果是浮点的 select ⇒ 常量张量与铺开的标量比较（分析途中建的 op 改写不成也留着，同 C++）。
pub struct IotaRules;

#[patterns]
impl IotaRules {
    #[rewrite("arith.select")]
    fn fold_select_condition(rw: &mut Rewriter<'_, '_>, s: OpId) -> bool {
        let b = &*rw.body;
        if !matches!(b.ty(b.opd(s, 0)), Type::Shaped(_)) || !matches!(b.ty(b.res(s, 0)).element_type(), Type::Float(_)) {
            return false;
        }
        rw.set_before(s);
        let mut f = Folder { c: rw, memo: BTreeMap::new() };
        let Some(next) = f.rewrite_select(s) else { return false };
        rw.replace_op(s, &[next]);
        true
    }
}

/// 只取决于一根轴的一维常量向量。
#[derive(Clone)]
struct Term {
    axis: usize,
    v: Vec<i64>,
}

/// 值 = 标量部分（可为空）+ c0 + Σ 各轴向量。
#[derive(Clone)]
struct Affine {
    scalar: Option<ValueId>,
    shape: Vec<i64>,
    c0: i64,
    terms: Vec<Term>,
}

impl Affine {
    fn add_term(&mut self, axis: usize, mut v: Vec<i64>, sign: i64) {
        v.iter_mut().for_each(|x| *x *= sign);
        if let Some(t) = self.terms.iter_mut().find(|t| t.axis == axis) {
            t.v.iter_mut().zip(&v).for_each(|(a, b)| *a += b);
            return;
        }
        self.terms.push(Term { axis, v });
    }
}

struct Folder<'f, 'r, 'a> {
    c: &'f mut Rewriter<'r, 'a>,
    memo: BTreeMap<ValueId, Option<Affine>>,
}

impl Folder<'_, '_, '_> {
    fn i32_tensor(t: &Type<'_>) -> bool {
        let Some(d) = t.dims() else { return false };
        matches!(t, Type::Shaped(_)) && matches!(t.element_type(), Type::Integer { width: 32, .. }) && d.iter().all(|x| *x >= 0) && d.iter().product::<i64>() <= MAX_ELEMENTS
    }

    fn i32(&mut self, v: i64) -> ValueId {
        self.c.i32(v)
    }

    fn scalar_combine(&mut self, x: Option<ValueId>, y: Option<ValueId>, sub: bool) -> Option<ValueId> {
        match (x, y) {
            (None, None) => None,
            (x, None) => x,
            (None, Some(y)) => Some(if sub {
                let z = self.i32(0);
                self.c.binary(Kind::ArithSubi, z, y)
            } else {
                y
            }),
            (Some(x), Some(y)) => Some(self.c.binary(if sub { Kind::ArithSubi } else { Kind::ArithAddi }, x, y)),
        }
    }

    fn affine(&mut self, v: ValueId, depth: u32) -> Option<Affine> {
        if depth > MAX_DEPTH || !Self::i32_tensor(self.c.body.ty(v)) {
            return None;
        }
        if let Some(r) = self.memo.get(&v) {
            return r.clone();
        }
        let r = self.compute(v, depth);
        self.memo.insert(v, r.clone());
        r
    }

    /// 整数常量张量的元素（i32）。
    fn dense_ints(&self, v: ValueId) -> Option<Vec<i64>> {
        let b = &*self.c.body;
        b.def_of(v, Kind::ArithConstant)?;
        let k = b.constant(v)?;
        k.values.iter().map(|s| match s {
            mlirformat::Scalar::Int(i) => i64::try_from(i.signed()).ok(),
            mlirformat::Scalar::Float(_) => None,
        }).collect()
    }

    #[allow(clippy::too_many_lines)]
    fn compute(&mut self, v: ValueId, depth: u32) -> Option<Affine> {
        let shape = self.c.body.ty(v).dims()?;
        let mut out = Affine { scalar: None, shape: shape.clone(), c0: 0, terms: Vec::new() };
        if let Some(data) = self.dense_ints(v) {
            if data.windows(2).all(|w| w[0] == w[1]) {
                out.c0 = *data.first()?;
                return Some(out);
            }
            if shape.len() != 1 {
                return None;
            }
            out.add_term(0, data, 1);
            return Some(out);
        }
        let def = self.c.body.def_op(v)?;
        let b = &*self.c.body;
        match b.kind(def) {
            Some(Kind::TtMakeRange) => {
                let start = b.int_attr(def, "start")? as i64;
                out.add_term(0, (0..shape[0]).map(|i| start + i).collect(), 1);
                Some(out)
            }
            Some(Kind::TtSplat) => {
                let src = b.opd(def, 0);
                if !matches!(b.ty(src), Type::Integer { width: 32, .. }) {
                    return None;
                }
                out.scalar = Some(src);
                Some(out)
            }
            Some(k @ (Kind::ArithAddi | Kind::ArithSubi)) => {
                let (lv, rv) = (b.opd(def, 0), b.opd(def, 1));
                let l = self.affine(lv, depth + 1);
                let r = self.affine(rv, depth + 1);
                let (l, r) = (l?, r?);
                let sub = k == Kind::ArithSubi;
                let mut out = l.clone();
                out.scalar = self.scalar_combine(l.scalar, r.scalar, sub);
                out.c0 = if sub { l.c0 - r.c0 } else { l.c0 + r.c0 };
                for t in &r.terms {
                    out.add_term(t.axis, t.v.clone(), if sub { -1 } else { 1 });
                }
                Some(out)
            }
            Some(Kind::ArithMuli) => {
                let (lv, rv) = (b.opd(def, 0), b.opd(def, 1));
                let l = self.affine(lv, depth + 1);
                let r = self.affine(rv, depth + 1);
                let (l, r) = (l?, r?);
                let plain = |a: &Affine| a.scalar.is_none() && a.terms.is_empty();
                let (k, mut out) = if plain(&l) {
                    (l.c0, r)
                } else if plain(&r) {
                    (r.c0, l)
                } else {
                    return None;
                };
                if let Some(s) = out.scalar {
                    let kv = self.i32(k);
                    out.scalar = Some(self.c.binary(Kind::ArithMuli, s, kv));
                }
                out.c0 *= k;
                out.terms.iter_mut().for_each(|t| t.v.iter_mut().for_each(|x| *x *= k));
                Some(out)
            }
            Some(k @ (Kind::ArithDivsi | Kind::ArithRemsi)) => {
                let (lv, rv) = (b.opd(def, 0), b.opd(def, 1));
                let l = self.affine(lv, depth + 1);
                let r = self.affine(rv, depth + 1);
                let (l, r) = (l?, r?);
                if l.scalar.is_some() || r.scalar.is_some() || !r.terms.is_empty() || r.c0 == 0 || l.terms.len() > 1 {
                    return None;
                }
                let div = k == Kind::ArithDivsi;
                let c = r.c0;
                let apply = |x: i64| if div { x / c } else { x % c };
                if l.terms.is_empty() {
                    out.c0 = apply(l.c0);
                    return Some(out);
                }
                let data = l.terms[0].v.iter().map(|x| apply(x + l.c0)).collect();
                out.add_term(l.terms[0].axis, data, 1);
                Some(out)
            }
            Some(Kind::TtExpandDims) => {
                let axis = b.int_attr(def, "axis")? as usize;
                let src = b.opd(def, 0);
                let mut out = self.affine(src, depth + 1)?;
                out.shape = shape;
                out.terms.iter_mut().filter(|t| t.axis >= axis).for_each(|t| t.axis += 1);
                Some(out)
            }
            Some(Kind::TtBroadcast) => {
                let src = b.opd(def, 0);
                let mut out = self.affine(src, depth + 1)?;
                if out.shape.len() != shape.len() {
                    return None;
                }
                out.shape = shape;
                Some(out)
            }
            _ => None,
        }
    }

    /// f32 的 splat 常量张量（形状同 `like`）。
    fn f32_splat(&mut self, value: f64, shape: &[i64]) -> ValueId {
        self.c.scalar(float(FloatKind::F32, value), Type::tensor(shape, Type::Float(FloatKind::F32)))
    }

    fn cmpf(&mut self, pred: CmpFPredicate, l: ValueId, r: ValueId) -> ValueId {
        let ty = self.c.body.ty(l).i1_like();
        let attrs = [("predicate", Attribute::of_int(pred as i128, int(64)))];
        self.c.value_with(Kind::ArithCmpf, &[l, r], &attrs, ty)
    }

    /// 一根轴上的一维常量向量建成 f32 一维张量：等差就是 v0 + a·idx，否则 v0 + Σ 台阶。
    #[allow(clippy::cast_precision_loss)]
    fn axis_vector(&mut self, v: &[i64]) -> Option<ValueId> {
        let n = v.len() as i64;
        let f32t = Type::tensor(&[n], Type::Float(FloatKind::F32));
        let idx = self.c.value_with(Kind::TtMakeRange, &[], &[("end", Attribute::of_int(i128::from(n), int(32))), ("start", Attribute::of_int(0, int(32)))], Type::tensor(&[n], int(32)));
        let idxf = self.c.value(Kind::ArithSitofp, &[idx], f32t);
        let slope = v.get(1).map_or(0, |x| x - v[0]);
        let arithmetic = v.iter().enumerate().all(|(i, x)| *x == v[0] + slope * i as i64);
        let mut result = self.f32_splat(v[0] as f32 as f64, &[n]);
        if arithmetic {
            if slope != 0 {
                let term = if slope == 1 {
                    idxf
                } else {
                    let s = self.f32_splat(slope as f32 as f64, &[n]);
                    self.c.binary(Kind::ArithMulf, idxf, s)
                };
                result = self.c.binary(Kind::ArithAddf, result, term);
            }
            return Some(result);
        }
        let steps = v.windows(2).filter(|w| w[0] != w[1]).count();
        if steps > MAX_STEPS {
            return None;
        }
        let zero = self.f32_splat(0.0, &[n]);
        for i in 1..v.len() {
            if v[i] == v[i - 1] {
                continue;
            }
            let at = self.f32_splat(i as f32 as f64, &[n]);
            let ge = self.cmpf(CmpFPredicate::oge, idxf, at);
            let d = self.f32_splat((v[i] - v[i - 1]) as f32 as f64, &[n]);
            let step = self.c.select(ge, d, zero);
            result = self.c.binary(Kind::ArithAddf, result, step);
        }
        Some(result)
    }

    /// 一维向量放到第 `axis` 根轴上（两边补维），再铺成整个形状。
    fn place_on_axis(&mut self, vec: ValueId, axis: usize, shape: &[i64]) -> ValueId {
        let rank = shape.len();
        let mut cur = vec;
        let mut cur_shape = vec![self.c.body.ty(vec).dims().map_or(0, |d| d[0])];
        for _ in 0..axis {
            cur_shape.insert(0, 1);
            cur = self.expand(cur, 0, &cur_shape);
        }
        for _ in axis + 1..rank {
            cur_shape.push(1);
            let a = cur_shape.len() - 1;
            cur = self.expand(cur, a, &cur_shape);
        }
        if cur_shape == shape {
            return cur;
        }
        self.c.value(Kind::TtBroadcast, &[cur], Type::tensor(shape, Type::Float(FloatKind::F32)))
    }

    fn expand(&mut self, v: ValueId, axis: usize, new_shape: &[i64]) -> ValueId {
        let elem = self.c.body.ty(v).element_type().clone();
        self.c.value_with(Kind::TtExpandDims, &[v], &[("axis", Attribute::of_int(axis as i128, int(32)))], Type::tensor(new_shape, elem))
    }

    /// cmpi ⇒ f32 上的比较。
    fn fold_compare(&mut self, cmp: OpId) -> Option<ValueId> {
        let p = self.c.body.int_attr(cmp, "predicate")?;
        let pred = [
            (CmpIPredicate::slt, CmpFPredicate::olt),
            (CmpIPredicate::sle, CmpFPredicate::ole),
            (CmpIPredicate::sgt, CmpFPredicate::ogt),
            (CmpIPredicate::sge, CmpFPredicate::oge),
            (CmpIPredicate::eq, CmpFPredicate::oeq),
            (CmpIPredicate::ne, CmpFPredicate::une),
        ]
        .into_iter()
        .find(|(i, _)| *i as i128 == p)?
        .1;
        let (lv, rv) = (self.c.body.opd(cmp, 0), self.c.body.opd(cmp, 1));
        let l = self.affine(lv, 0);
        let r = self.affine(rv, 0);
        let (l, r) = (l?, r?);
        let mut d = l.clone();
        d.scalar = self.scalar_combine(l.scalar, r.scalar, true);
        d.c0 = l.c0 - r.c0;
        for t in &r.terms {
            d.add_term(t.axis, t.v.clone(), -1);
        }
        let shape = self.c.body.ty(lv).dims()?;
        let f32t = Type::tensor(&shape, Type::Float(FloatKind::F32));
        let mut sum: Option<ValueId> = None;
        for t in &d.terms {
            let vec = self.axis_vector(&t.v)?;
            let placed = self.place_on_axis(vec, t.axis, &shape);
            sum = Some(match sum {
                Some(s) => self.c.binary(Kind::ArithAddf, s, placed),
                None => placed,
            });
        }
        let sum = match sum {
            Some(s) => s,
            None => self.f32_splat(0.0, &shape),
        };
        let bound = if d.c0 != 0 {
            let c0 = self.i32(d.c0);
            self.scalar_combine(d.scalar, Some(c0), false)
        } else {
            d.scalar
        };
        let negated = match bound {
            Some(bv) => {
                let z = self.i32(0);
                self.c.binary(Kind::ArithSubi, z, bv)
            }
            None => self.i32(0),
        };
        let bound_f = self.c.value(Kind::ArithSitofp, &[negated], Type::Float(FloatKind::F32));
        let bound_t = self.c.value(Kind::TtSplat, &[bound_f], f32t);
        Some(self.cmpf(pred, sum, bound_t))
    }

    /// `cmpi ne (select(c, splat 1, splat 0), splat 0)` 就是 c。
    fn select_condition(&self, cmp: OpId) -> Option<ValueId> {
        let b = &*self.c.body;
        if b.int_attr(cmp, "predicate")? != CmpIPredicate::ne as i128 {
            return None;
        }
        let s = b.def_of(b.opd(cmp, 0), Kind::ArithSelect)?;
        let is = |v: ValueId, want: i128| b.def_of(v, Kind::ArithConstant).is_some() && matches!(b.ty(v), Type::Shaped(_)) && b.const_int(v) == Some(want);
        (is(b.opd(cmp, 1), 0) && is(b.opd(s, 1), 1) && is(b.opd(s, 2), 0)).then(|| b.opd(s, 0))
    }

    /// 合取树的叶子，外面套着的 expand_dims / broadcast（由外向内）。
    fn collect(&self, v: ValueId, chain: Vec<OpId>, leaves: &mut Vec<(ValueId, Vec<OpId>)>, depth: u32) {
        if depth > MAX_DEPTH {
            return;
        }
        let b = &*self.c.body;
        let def = b.def_op(v);
        match def.and_then(|d| b.kind(d)) {
            Some(Kind::TtBroadcast | Kind::TtExpandDims) => {
                let d = def.expect("有定义");
                let mut c = chain;
                c.push(d);
                self.collect(b.opd(d, 0), c, leaves, depth + 1);
            }
            Some(Kind::ArithAndi) => {
                let d = def.expect("有定义");
                self.collect(b.opd(d, 0), chain.clone(), leaves, depth + 1);
                self.collect(b.opd(d, 1), chain, leaves, depth + 1);
            }
            Some(Kind::ArithCmpi) if self.select_condition(def.expect("有定义")).is_some() => {
                let inner = self.select_condition(def.expect("有定义")).expect("认出");
                self.collect(inner, chain, leaves, depth + 1);
            }
            _ => leaves.push((v, chain)),
        }
    }

    /// 一个叶子提升成整个形状上的 f32 比较。
    fn lift_leaf(&mut self, base: ValueId, chain: &[OpId], full: &Type<'_>) -> Option<ValueId> {
        let full_shape = full.dims()?;
        let def = self.c.body.def_op(base);
        if let Some(s) = def.filter(|d| self.c.body.is(*d, Kind::TtSplat))
            && matches!(self.c.body.ty(self.c.body.opd(s, 0)), Type::Integer { width: 1, .. })
        {
            let src = self.c.body.opd(s, 0);
            return Some(self.c.value(Kind::TtSplat, &[src], Type::tensor(&full_shape, int(1))));
        }
        let cmp = def.filter(|d| self.c.body.is(*d, Kind::ArithCmpi))?;
        let mut operands = Vec::new();
        for v in [self.c.body.opd(cmp, 0), self.c.body.opd(cmp, 1)] {
            let mut lifted = v;
            for &o in chain.iter().rev() {
                let elem = self.c.body.ty(lifted).element_type().clone();
                let rshape = self.c.body.ty(self.c.body.res(o, 0)).dims()?;
                lifted = if self.c.body.is(o, Kind::TtExpandDims) {
                    let axis = self.c.body.int_attr(o, "axis")? as usize;
                    self.expand(lifted, axis, &rshape)
                } else {
                    self.c.value(Kind::TtBroadcast, &[lifted], Type::tensor(&rshape, elem))
                };
            }
            operands.push(lifted);
        }
        if self.c.body.ty(operands[0]).dims()? != full_shape {
            return None;
        }
        let pred = self.c.body.int_attr(cmp, "predicate")?;
        let lifted = self.c.value_with(Kind::ArithCmpi, &operands, &[("predicate", Attribute::of_int(pred, int(64)))], self.c.body.ty(operands[0]).i1_like());
        let lcmp = self.c.body.def_op(lifted)?;
        self.fold_compare(lcmp)
    }

    fn rewrite_select(&mut self, s: OpId) -> Option<ValueId> {
        let full = self.c.body.ty(self.c.body.opd(s, 0)).clone();
        let mut leaves = Vec::new();
        self.collect(self.c.body.opd(s, 0), Vec::new(), &mut leaves, 0);
        let mut lifted = Vec::new();
        for (base, chain) in &leaves {
            lifted.push(self.lift_leaf(*base, chain, &full)?);
        }
        let (t, f) = (self.c.body.opd(s, 1), self.c.body.opd(s, 2));
        let mut result = t;
        for l in lifted.into_iter().rev() {
            result = self.c.select(l, result, f);
        }
        Some(result)
    }
}
