//! `triton-split-row-axis`（`SplitRowAxis.cpp`）：行轴是「两个下标的乘积」的 tile，改成多维窗口加一次维度折叠。
//!
//! vLLM 注意力的 q tile 行 m 是 (token t = m // c, 头 h = m % c)：行偏移不是 m 的仿射函数。把行轴拆成 (t, h) 两根轴就是普通的
//! 三维窗口 [r, c, W]：读进来之后 tt.reshape 回 [R, W]，写之前先 reshape 成 [r, c, W]。行偏移按「若干项之和，每项是 标量因子 ×
//! （标量 + a·t + b·h）」符号地求出，在 [r, c] 格上重建；列部分原样放进来；mask 拆成行上的前缀约束、列部分、标量条件的合取。
//! 认不出的整个访存原样不动（途中新建的 op 回滚掉）。改写过就在模块上记 `dope.split_row_axis`，再跑一遍 canonicalize。
use mlirformat::arith::CmpIPredicate;
use mlirformat::{Attribute, Error, Type};
use mlirpass::{Body, OpData, OpId, ValueId, pass};

use super::uniform_lanes::Canon;
use crate::ir::{Cursor, dense_i32, int, integer};
use crate::{Ir, Kind};

const MAX_DEPTH: u32 = 24;

#[pass("triton-split-row-axis", on = "builtin.module", ty = SplitRowAxis)]
pub fn split_row_axis<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut targets = Vec::new();
    body.walk_post(op, &mut |o| {
        if matches!(body.kind(o), Some(Kind::TtLoad | Kind::TtStore)) {
            targets.push(o);
        }
    });
    let mut changed = false;
    for t in targets {
        let cp = body.checkpoint();
        if Split::build(body, t) {
            body.release(cp);
            changed = true;
        } else {
            body.rollback(cp);
        }
    }
    if changed {
        let root = body.root;
        body[root].set("dope.split_row_axis", Attribute::Unit);
        Canon::run(body, op)?;
    }
    Ok(())
}

#[derive(Clone, Copy)]
struct Term {
    /// i64 标量因子，`None` 是 1
    scale: Option<ValueId>,
    /// 标量，`None` 是 0
    scalar: Option<ValueId>,
    ct: i64,
    ch: i64,
    sign: i64,
}

type Sym = Vec<Term>;

/// t（axis 0）或 h（axis 1）< bound（i32 标量）。
struct Constraint {
    axis: usize,
    bound: ValueId,
}

struct Splitter<'b, 'a> {
    c: Cursor<'b, 'a>,
    big_r: i64,
    cc: i64,
    r: i64,
    failed: bool,
}

impl Splitter<'_, '_> {
    fn i64c(&mut self, v: i64) -> ValueId {
        self.c.constant(integer(64, i128::from(v)), int(64))
    }

    fn const_of(&mut self, ty: Type<'static>, v: i64) -> ValueId {
        let w = ty.int_width().map_or(32, |(w, _)| w);
        self.c.constant(integer(w, i128::from(v)), ty)
    }

    fn to_i64(&mut self, s: ValueId) -> ValueId {
        match self.c.body.ty(s) {
            Type::Integer { width: 64, .. } => s,
            Type::Integer { width: 32, .. } => self.c.value(Kind::ArithExtsi, &[s], int(64)),
            _ => {
                self.failed = true;
                s
            }
        }
    }

    /// 张量整数常量的 splat 值，或 tt.splat 铺开的标量常量。
    fn splat_constant(b: &Body<'_>, v: ValueId) -> Option<i64> {
        if b.def_of(v, Kind::ArithConstant).is_some() {
            let k = b.constant(v)?;
            if !k.elements || !k.values.windows(2).all(|w| w[0] == w[1]) {
                return None;
            }
            return b.const_int(v).and_then(|x| i64::try_from(x).ok());
        }
        let s = b.def_of(v, Kind::TtSplat)?;
        let src = b.opd(s, 0);
        b.def_of(src, Kind::ArithConstant)?;
        b.const_int(src).and_then(|x| i64::try_from(x).ok())
    }

    #[allow(clippy::too_many_lines)]
    fn eval(&mut self, v: ValueId, depth: u32) -> Option<Sym> {
        if depth > MAX_DEPTH {
            return None;
        }
        let ty = self.c.body.ty(v).clone();
        let dims = ty.dims()?;
        if !matches!(ty.element_type(), Type::Integer { .. }) || dims.is_empty() || dims.len() > 2 || dims[0] != self.big_r || (dims.len() == 2 && dims[1] != 1) {
            return None;
        }
        let def = self.c.body.def_op(v)?;
        let b = &*self.c.body;
        let k = b.kind(def);
        match k {
            Some(Kind::TtMakeRange) => {
                if b.int_attr(def, "start")? != 0 {
                    return None;
                }
                return Some(vec![Term { scale: None, scalar: None, ct: self.cc, ch: 1, sign: 1 }]);
            }
            Some(Kind::TtSplat) => return Some(vec![Term { scale: None, scalar: Some(b.opd(def, 0)), ct: 0, ch: 0, sign: 1 }]),
            _ => {}
        }
        if let Some(kv) = Self::splat_constant(b, v) {
            let elem = ty.element_type().owned();
            let s = self.const_of(elem, kv);
            return Some(vec![Term { scale: None, scalar: Some(s), ct: 0, ch: 0, sign: 1 }]);
        }
        let b = &*self.c.body;
        match k {
            Some(Kind::TtExpandDims | Kind::ArithExtsi | Kind::ArithTrunci | Kind::ArithIndexCast) => {
                let src = b.opd(def, 0);
                self.eval(src, depth + 1)
            }
            Some(Kind::ArithAddi | Kind::ArithSubi) => {
                let (l, x) = (b.opd(def, 0), b.opd(def, 1));
                let l = self.eval(l, depth + 1);
                let x = self.eval(x, depth + 1);
                let (mut l, x) = (l?, x?);
                let sub = k == Some(Kind::ArithSubi);
                for mut t in x {
                    if sub {
                        t.sign = -t.sign;
                    }
                    l.push(t);
                }
                Some(l)
            }
            Some(Kind::ArithMuli) => {
                let (lv, xv) = (b.opd(def, 0), b.opd(def, 1));
                let l = self.eval(lv, depth + 1);
                let x = self.eval(xv, depth + 1);
                let (l, x) = (l?, x?);
                let (pure, mut other) = if let Some(s) = self.pure_scalar(&l) {
                    (s, x)
                } else if let Some(s) = self.pure_scalar(&x) {
                    (s, l)
                } else {
                    return None;
                };
                for t in &mut other {
                    t.scale = Some(match t.scale {
                        Some(sc) => self.c.binary(Kind::ArithMuli, sc, pure),
                        None => pure,
                    });
                }
                Some(other)
            }
            Some(kk @ (Kind::ArithDivsi | Kind::ArithRemsi)) => {
                let range = b.def_of(b.opd(def, 0), Kind::TtMakeRange)?;
                let divisor = Self::splat_constant(b, b.opd(def, 1))?;
                if b.int_attr(range, "start")? != 0 || divisor != self.cc {
                    return None;
                }
                let div = kk == Kind::ArithDivsi;
                Some(vec![Term { scale: None, scalar: None, ct: i64::from(div), ch: i64::from(!div), sign: 1 }])
            }
            _ => None,
        }
    }

    /// 标量项的和：i32（所有标量与因子都是 i32、不强制宽）或 i64。
    fn scalar_total(&mut self, terms: &[Term], force_wide: bool) -> ValueId {
        let wide = force_wide || terms.iter().any(|t| t.scale.is_some() || t.scalar.is_some_and(|s| matches!(self.c.body.ty(s), Type::Integer { width: 64, .. })));
        let ty = int(if wide { 64 } else { 32 });
        let mut total: Option<ValueId> = None;
        for t in terms {
            let mut term = match t.scalar {
                Some(s) => self.cast(s, &ty),
                None => self.const_of(ty.clone(), 0),
            };
            if let Some(sc) = t.scale {
                let scv = self.cast(sc, &ty);
                term = self.c.binary(Kind::ArithMuli, term, scv);
            }
            if t.sign < 0 {
                let z = self.const_of(ty.clone(), 0);
                term = self.c.binary(Kind::ArithSubi, z, term);
            }
            total = Some(match total {
                Some(tt) => self.c.binary(Kind::ArithAddi, tt, term),
                None => term,
            });
        }
        match total {
            Some(t) => t,
            None => self.const_of(ty, 0),
        }
    }

    fn cast(&mut self, v: ValueId, ty: &Type<'static>) -> ValueId {
        if self.c.body.ty(v).owned() == *ty {
            return v;
        }
        self.c.value(Kind::ArithExtsi, &[v], ty.clone())
    }

    fn pure_scalar(&mut self, sym: &Sym) -> Option<ValueId> {
        if sym.iter().any(|t| t.ct != 0 || t.ch != 0) {
            return None;
        }
        Some(self.scalar_total(sym, true))
    }

    /// 一维向量放到第 `axis` 根轴上，再铺到整个形状。
    fn place(&mut self, vec: ValueId, axis: usize, shape: &[i64]) -> ValueId {
        let rank = shape.len();
        let mut cur = vec;
        let mut cur_shape = vec![self.c.body.ty(vec).dims().map_or(0, |d| d[0])];
        let elem = self.c.body.ty(vec).element_type().clone();
        for _ in 0..axis {
            cur_shape.insert(0, 1);
            cur = self.c.value_with(Kind::TtExpandDims, &[cur], &[("axis", Attribute::of_int(0, int(32)))], Type::tensor(&cur_shape, elem.clone()));
        }
        for _ in axis + 1..rank {
            cur_shape.push(1);
            let a = cur_shape.len() - 1;
            cur = self.c.value_with(Kind::TtExpandDims, &[cur], &[("axis", Attribute::of_int(a as i128, int(32)))], Type::tensor(&cur_shape, elem.clone()));
        }
        if cur_shape == shape {
            return cur;
        }
        self.c.value(Kind::TtBroadcast, &[cur], Type::tensor(shape, elem))
    }

    fn range(&mut self, n: i64, elem: &Type<'static>) -> ValueId {
        let i = self.c.value_with(Kind::TtMakeRange, &[], &[("end", Attribute::of_int(i128::from(n), int(32))), ("start", Attribute::of_int(0, int(32)))], Type::tensor(&[n], int(32)));
        if matches!(elem, Type::Integer { width: 32, .. }) {
            return i;
        }
        self.c.value(Kind::ArithExtsi, &[i], Type::tensor(&[n], elem.clone()))
    }

    fn splat_to(&mut self, s: ValueId, shape: &[i64]) -> ValueId {
        let ty = Type::tensor(shape, self.c.body.ty(s).clone());
        self.c.value(Kind::TtSplat, &[s], ty)
    }

    /// 行偏移在 [r, c, 1] 或 [r, c] 格上重建成 i64 张量：splat(S) + t·splat(CT) + h·splat(CH)。
    fn rebuild_row_offset(&mut self, sym: &Sym, shape: &[i64]) -> ValueId {
        let (mut offset, mut coef_t, mut coef_h): (Option<ValueId>, Option<ValueId>, Option<ValueId>) = (None, None, None);
        for t in sym {
            let scaled = |s: &mut Self, mut value: ValueId| {
                if let Some(sc) = t.scale {
                    let x = s.to_i64(sc);
                    value = s.c.binary(Kind::ArithMuli, value, x);
                }
                if t.sign < 0 {
                    let z = s.i64c(0);
                    value = s.c.binary(Kind::ArithSubi, z, value);
                }
                value
            };
            let acc = |s: &mut Self, sum: &mut Option<ValueId>, term: ValueId| {
                *sum = Some(match *sum {
                    Some(x) => s.c.binary(Kind::ArithAddi, x, term),
                    None => term,
                });
            };
            if let Some(sc) = t.scalar {
                let v = self.to_i64(sc);
                let v = scaled(self, v);
                acc(self, &mut offset, v);
            }
            if t.ct != 0 {
                let v = self.i64c(t.ct);
                let v = scaled(self, v);
                acc(self, &mut coef_t, v);
            }
            if t.ch != 0 {
                let v = self.i64c(t.ch);
                let v = scaled(self, v);
                acc(self, &mut coef_h, v);
            }
        }
        let base = match offset {
            Some(o) => o,
            None => self.i64c(0),
        };
        let mut total = self.splat_to(base, shape);
        let i64t = int(64);
        if let Some(ct) = coef_t {
            let r = self.r;
            let rv = self.range(r, &i64t);
            let t_idx = self.place(rv, 0, shape);
            let s = self.splat_to(ct, shape);
            let m = self.c.binary(Kind::ArithMuli, t_idx, s);
            total = self.c.binary(Kind::ArithAddi, total, m);
        }
        if let Some(ch) = coef_h {
            let c = self.cc;
            let cv = self.range(c, &i64t);
            let h_idx = self.place(cv, 1, shape);
            let s = self.splat_to(ch, shape);
            let m = self.c.binary(Kind::ArithMuli, h_idx, s);
            total = self.c.binary(Kind::ArithAddi, total, m);
        }
        total
    }

    /// 行上的 mask：拆成 t、h 轴上的前缀约束的合取；认不出返回 false。
    fn row_constraints(&mut self, v: ValueId, out: &mut Vec<Constraint>, depth: u32) -> bool {
        if depth > MAX_DEPTH {
            return false;
        }
        let Some(def) = self.c.body.def_op(v) else { return false };
        let b = &*self.c.body;
        if b.is(def, Kind::ArithConstant) && b.constant(v).is_some_and(|k| k.elements && k.values.windows(2).all(|w| w[0] == w[1])) && b.const_int(v).is_some_and(|x| x & 1 == 1 || x == -1) {
            return true;
        }
        match b.kind(def) {
            Some(Kind::ArithAndi) => {
                let (l, r) = (b.opd(def, 0), b.opd(def, 1));
                return self.row_constraints(l, out, depth + 1) && self.row_constraints(r, out, depth + 1);
            }
            Some(Kind::TtExpandDims) => {
                let s = b.opd(def, 0);
                return self.row_constraints(s, out, depth + 1);
            }
            Some(Kind::ArithCmpi) => {}
            _ => return false,
        }
        let cmp = def;
        let pred = b.int_attr(cmp, "predicate");
        if pred == Some(CmpIPredicate::ne as i128)
            && let Some(sel) = b.def_of(b.opd(cmp, 0), Kind::ArithSelect)
            && Self::splat_constant(b, b.opd(cmp, 1)) == Some(0)
            && Self::splat_constant(b, b.opd(sel, 1)) == Some(1)
            && Self::splat_constant(b, b.opd(sel, 2)) == Some(0)
        {
            let c = b.opd(sel, 0);
            return self.row_constraints(c, out, depth + 1);
        }
        let (lv, xv) = (b.opd(cmp, 0), b.opd(cmp, 1));
        let l = self.eval(lv, 0);
        let x = self.eval(xv, 0);
        let (Some(l), Some(x)) = (l, x) else { return false };
        let mut pred = pred.unwrap_or(-1);
        let mut diff = l;
        for mut t in x {
            t.sign = -t.sign;
            diff.push(t);
        }
        let (slt, sle, sgt, sge) = (CmpIPredicate::slt as i128, CmpIPredicate::sle as i128, CmpIPredicate::sgt as i128, CmpIPredicate::sge as i128);
        if pred == sgt || pred == sge {
            diff.iter_mut().for_each(|t| t.sign = -t.sign);
            pred = if pred == sgt { slt } else { sle };
        }
        if pred != slt && pred != sle {
            return false;
        }
        let (mut a, mut bco) = (0, 0);
        let mut scalars = Vec::new();
        for t in &diff {
            if t.ct != 0 || t.ch != 0 {
                if t.scale.is_some() || t.scalar.is_some() {
                    return false;
                }
                a += t.sign * t.ct;
                bco += t.sign * t.ch;
                continue;
            }
            scalars.push(*t);
        }
        let sum = self.scalar_total(&scalars, false);
        let axis = match (a, bco) {
            (1, 0) => 0,
            (0, 1) => 1,
            _ => return false,
        };
        let sum_ty = self.c.body.ty(sum).owned();
        let start = self.const_of(sum_ty.clone(), i64::from(pred == sle));
        let mut bound = self.c.binary(Kind::ArithSubi, start, sum);
        if !matches!(sum_ty, Type::Integer { width: 32, .. }) {
            bound = self.c.value(Kind::ArithTrunci, &[bound], int(32));
        }
        out.push(Constraint { axis, bound });
        true
    }
}

struct Split;

impl Split {
    /// 偏移的 DAG 里找 arange(0, R) 的除或取模（常数除数）。
    fn find(b: &Body<'_>, root: ValueId) -> Option<(i64, i64)> {
        let mut work = vec![root];
        let mut seen = std::collections::BTreeSet::new();
        while let Some(v) = work.pop() {
            let Some(def) = b.def_op(v) else { continue };
            if !seen.insert(def) {
                continue;
            }
            if matches!(b.kind(def), Some(Kind::ArithDivsi | Kind::ArithRemsi))
                && let Some(range) = b.def_of(b.opd(def, 0), Kind::TtMakeRange)
                && let Some(d) = Splitter::splat_constant(b, b.opd(def, 1))
                && b.int_attr(range, "start") == Some(0)
                && d > 1
            {
                let big_r = b.int_attr(range, "end").unwrap_or(0) as i64;
                if big_r % d == 0 && big_r / d > 1 {
                    return Some((big_r, d));
                }
            }
            work.extend(b[def].operands.iter().copied());
        }
        None
    }

    /// 偏移 = 若干 broadcast 的和（行叶 [R, 1]、列叶 [1, W]）；一维时整个就是行部分。
    fn classify(b: &Body<'_>, off: ValueId, big_r: i64, rows: &mut Vec<ValueId>, cols: &mut Vec<ValueId>, depth: u32) -> bool {
        if depth > MAX_DEPTH {
            return false;
        }
        let Some(d) = b.ty(off).dims() else { return false };
        if d.len() == 1 {
            rows.push(off);
            return true;
        }
        let Some(def) = b.def_op(off) else { return false };
        match b.kind(def) {
            Some(Kind::ArithAddi) => Self::classify(b, b.opd(def, 0), big_r, rows, cols, depth + 1) && Self::classify(b, b.opd(def, 1), big_r, rows, cols, depth + 1),
            Some(Kind::TtBroadcast) => {
                let src = b.opd(def, 0);
                let sd = b.ty(src).dims().unwrap_or_default();
                if sd.len() == 2 && sd[0] == big_r && sd[1] == 1 {
                    rows.push(src);
                } else if sd.len() == 2 && sd[0] == 1 {
                    cols.push(src);
                } else {
                    return false;
                }
                true
            }
            _ => false,
        }
    }

    fn flatten(b: &Body<'_>, v: ValueId, leaves: &mut Vec<ValueId>, depth: u32) {
        if depth < MAX_DEPTH
            && let Some(a) = b.def_of(v, Kind::ArithAndi)
        {
            Self::flatten(b, b.opd(a, 0), leaves, depth + 1);
            Self::flatten(b, b.opd(a, 1), leaves, depth + 1);
            return;
        }
        leaves.push(v);
    }

    #[allow(clippy::too_many_lines)]
    fn build(body: &mut Body<'_>, op: OpId) -> bool {
        let is_load = body.is(op, Kind::TtLoad);
        let ptr = body.opd(op, 0);
        let ptr_ty = body.ty(ptr).clone();
        let Some(pd) = ptr_ty.dims().filter(|d| !d.is_empty() && d.len() <= 2) else { return false };
        let Some(add) = body.def_of(ptr, Kind::TtAddptr) else { return false };
        let Some(base) = body.def_of(body.opd(add, 0), Kind::TtSplat) else { return false };
        let Some((big_r, cc)) = Self::find(body, body.opd(add, 1)) else { return false };
        if big_r != pd[0] {
            return false;
        }
        let column = pd.len() == 1;
        let w = if column { 1 } else { pd[1] };
        let shape3 = vec![big_r / cc, cc, w];
        let (mut rows, mut cols) = (Vec::new(), Vec::new());
        if !Self::classify(body, body.opd(add, 1), big_r, &mut rows, &mut cols, 0) || rows.is_empty() {
            return false;
        }
        let mask = if is_load {
            (body[op].operands.len() >= 2).then(|| body.opd(op, 1))
        } else {
            (body[op].operands.len() >= 3).then(|| body.opd(op, 2))
        };
        let base_src = body.opd(base, 0);
        let ptr_elem = ptr_ty.element_type().clone();
        let mut s = Splitter { c: Cursor::before(body, op), big_r, cc, r: big_r / cc, failed: false };
        let mut row_shape = shape3.clone();
        *row_shape.last_mut().expect("三维") = 1;
        let mut row_offset: Option<ValueId> = None;
        for leaf in rows {
            let Some(sym) = s.eval(leaf, 0) else { return false };
            if s.failed {
                return false;
            }
            let part = s.rebuild_row_offset(&sym, &row_shape);
            row_offset = Some(match row_offset {
                Some(r) => s.c.binary(Kind::ArithAddi, r, part),
                None => part,
            });
        }
        let row_offset = row_offset.expect("有行叶");
        let i64t = int(64);
        let offset3 = if !column {
            let mut o = s.c.value(Kind::TtBroadcast, &[row_offset], Type::tensor(&shape3, i64t.clone()));
            for leaf in cols {
                let mut col = leaf;
                let ct = s.c.body.ty(col).clone();
                if !matches!(ct.element_type(), Type::Integer { width: 64, .. }) {
                    col = s.c.value(Kind::ArithExtsi, &[col], ct.with_element(i64t.clone()));
                }
                let mut d = s.c.body.ty(col).dims().unwrap_or_default();
                d.insert(0, 1);
                col = s.c.value_with(Kind::TtExpandDims, &[col], &[("axis", Attribute::of_int(0, int(32)))], Type::tensor(&d, i64t.clone()));
                col = s.c.value(Kind::TtBroadcast, &[col], Type::tensor(&shape3, i64t.clone()));
                o = s.c.binary(Kind::ArithAddi, o, col);
            }
            o
        } else if !cols.is_empty() {
            return false;
        } else {
            let r1 = s.range(1, &i64t);
            let p = s.place(r1, 2, &shape3);
            s.c.binary(Kind::ArithAddi, row_offset, p)
        };

        let mut mask3: Option<ValueId> = None;
        if let Some(m) = mask {
            let mut leaves = Vec::new();
            Self::flatten(s.c.body, m, &mut leaves, 0);
            let mut constraints = Vec::new();
            let mut col_masks = Vec::new();
            let mut scalar_cond: Option<ValueId> = None;
            for leaf in leaves {
                let def = s.c.body.def_op(leaf);
                let k = def.and_then(|d| s.c.body.kind(d));
                if k == Some(Kind::TtBroadcast) {
                    let src = s.c.body.opd(def.expect("有"), 0);
                    let sd = s.c.body.ty(src).dims().unwrap_or_default();
                    if !column && sd.len() == 2 && sd[0] == big_r && sd[1] == 1 {
                        if !s.row_constraints(src, &mut constraints, 0) {
                            return false;
                        }
                        continue;
                    }
                    if !column && sd.len() == 2 && sd[0] == 1 {
                        col_masks.push(src);
                        continue;
                    }
                    return false;
                }
                if k == Some(Kind::TtSplat) {
                    let src = s.c.body.opd(def.expect("有"), 0);
                    scalar_cond = Some(match scalar_cond {
                        Some(sc) => s.c.binary(Kind::ArithAndi, sc, src),
                        None => src,
                    });
                    continue;
                }
                if column {
                    if !s.row_constraints(leaf, &mut constraints, 0) {
                        return false;
                    }
                    continue;
                }
                return false;
            }
            let mask_ty = Type::tensor(&shape3, int(1));
            let mut conj = |s: &mut Splitter<'_, '_>, part: ValueId| {
                mask3 = Some(match mask3 {
                    Some(m) => s.c.binary(Kind::ArithAndi, m, part),
                    None => part,
                });
            };
            for con in &constraints {
                let n = if con.axis == 0 { s.r } else { s.cc };
                let idx = s.range(n, &int(32));
                let bound = s.splat_to(con.bound, &[n]);
                let part = s.c.cmpi(CmpIPredicate::slt, idx, bound);
                let placed = s.place(part, con.axis, &shape3);
                conj(&mut s, placed);
            }
            for col in col_masks {
                let mut d = s.c.body.ty(col).dims().unwrap_or_default();
                d.insert(0, 1);
                let e = s.c.value_with(Kind::TtExpandDims, &[col], &[("axis", Attribute::of_int(0, int(32)))], Type::tensor(&d, int(1)));
                let bc = s.c.value(Kind::TtBroadcast, &[e], mask_ty.clone());
                conj(&mut s, bc);
            }
            if let Some(sc) = scalar_cond {
                let sp = s.c.value(Kind::TtSplat, &[sc], mask_ty.clone());
                conj(&mut s, sp);
            }
        }
        let ptr3_ty = Type::tensor(&shape3, ptr_elem);
        let splat_base = s.c.value(Kind::TtSplat, &[base_src], ptr3_ty.clone());
        let ptr3 = s.c.value(Kind::TtAddptr, &[splat_base, offset3], ptr3_ty);
        if is_load {
            let other = (s.c.body[op].operands.len() >= 3).then(|| s.c.body.opd(op, 2));
            let mut other3 = None;
            if let Some(o) = other {
                let oelem = s.c.body.ty(o).element_type().owned();
                if let Some(sp) = s.c.body.def_of(o, Kind::TtSplat) {
                    let src = s.c.body.opd(sp, 0);
                    other3 = Some(s.c.value(Kind::TtSplat, &[src], Type::tensor(&shape3, oelem)));
                } else {
                    let Some(k) = s.c.body.constant(o).filter(|k| k.elements && k.values.windows(2).all(|w| w[0] == w[1])) else { return false };
                    other3 = Some(s.c.constant(k.values[0], Type::tensor(&shape3, oelem)));
                }
            }
            let value_ty = s.c.body.ty(s.c.body.res(op, 0)).clone();
            let mut operands = vec![ptr3];
            operands.extend(mask3);
            operands.extend(other3);
            let mut d = OpData::build(Kind::TtLoad.name()).operands(&operands).with("operandSegmentSizes", dense_i32(&[1, i64::from(mask3.is_some()), i64::from(other3.is_some())]));
            for n in ["boundaryCheck", "padding", "cache", "evict", "isVolatile"] {
                if let Some(a) = s.c.body[op].get(n) {
                    d.set(n, a.clone());
                }
            }
            let l3 = s.c.create(d, &[Type::tensor(&shape3, value_ty.element_type().clone())]);
            let lv = s.c.body.res(l3, 0);
            let reshaped = s.c.value(Kind::TtReshape, &[lv], value_ty);
            body.replace_op(op, &[reshaped]);
        } else {
            let value = s.c.body.opd(op, 1);
            let velem = s.c.body.ty(value).element_type().clone();
            let v3 = s.c.value(Kind::TtReshape, &[value], Type::tensor(&shape3, velem));
            let mut operands = vec![ptr3, v3];
            operands.extend(mask3);
            let mut d = OpData::build(Kind::TtStore.name()).operands(&operands).with("boundaryCheck", dense_i32(&[]));
            for n in ["cache", "evict"] {
                if let Some(a) = s.c.body[op].get(n) {
                    d.set(n, a.clone());
                }
            }
            s.c.create(d, &[]);
            body.erase(op);
        }
        true
    }
}
