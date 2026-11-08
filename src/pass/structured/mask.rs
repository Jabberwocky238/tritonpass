//! triton-shared `MaskAnalysis.cpp`（改过的那份）：访存的 mask 读成「各维的有效个数」（从 0 起的前缀），
//! 认不出的一维记成非结构化 mask（一维 i1 张量）。分析途中建的 arith op 照 C++ 当场建。
use mlirformat::arith::CmpIPredicate;
use mlirformat::{Attribute, Type};
use mlirpass::{Body, Def, ValueId};

use crate::pass::ofr::Ofr;
use crate::ir::{Cursor, int};
use crate::{Ir, Kind};

#[derive(Debug, Clone, Default)]
pub struct MaskState {
    pub start: Option<Ofr>,
    pub end: Option<Ofr>,
    pub dims: Vec<Ofr>,
    pub masks: Vec<Option<ValueId>>,
    pub scalar: Option<Ofr>,
    pub seen_negative_shift: bool,
}

impl MaskState {
    pub fn rank(&self) -> usize {
        self.dims.len()
    }

    pub fn is_mask(&self) -> bool {
        self.start.is_none() && self.end.is_none() && self.scalar.is_none() && !self.dims.is_empty()
    }

    pub fn unstructured(&self) -> Vec<(usize, ValueId)> {
        self.masks.iter().enumerate().filter_map(|(i, m)| m.map(|m| (i, m))).collect()
    }

    /// 整数常量（标量或 splat）。
    fn const_of(b: &Body<'_>, v: ValueId) -> Option<i128> {
        b.def_of(v, Kind::ArithConstant)?;
        b.const_int(v)
    }

    /// `cmpi ne (select(c, k, 0), 0)`（k 非零）就是 c。
    fn where_bool(b: &Body<'_>, cmp: OpId) -> Option<ValueId> {
        if b.int_attr(cmp, "predicate")? != CmpIPredicate::ne as i128 {
            return None;
        }
        for side in 0..2 {
            if Self::const_of(b, b.opd(cmp, 1 - side)) != Some(0) {
                continue;
            }
            if let Some(s) = b.def_of(b.opd(cmp, side), Kind::ArithSelect)
                && Self::const_of(b, b.opd(s, 1)).is_some_and(|x| x != 0)
                && Self::const_of(b, b.opd(s, 2)) == Some(0)
            {
                return Some(b.opd(s, 0));
            }
        }
        None
    }

    pub fn parse(&mut self, v: ValueId, c: &mut Cursor<'_, '_>) -> bool {
        let def = c.body.def_op(v);
        let k = def.and_then(|d| c.body.kind(d));
        if k == Some(Kind::ArithCmpi)
            && let Some(cond) = Self::where_bool(c.body, def.expect("有"))
        {
            return self.parse(cond, c);
        }
        match k {
            Some(Kind::ArithConstant) => self.parse_constant(v, c),
            _ if matches!(c.body.ty(v), Type::Integer { .. }) => self.parse_int_scalar(v, c),
            Some(Kind::ArithAddi) => self.parse_add(def.expect("有"), c),
            Some(Kind::ArithAndi) => self.parse_and(def.expect("有"), c),
            Some(Kind::ArithCmpi) => self.parse_cmp(def.expect("有"), c),
            Some(Kind::TtMakeRange) => self.parse_range(def.expect("有"), c),
            Some(Kind::TtBroadcast) => self.parse_broadcast(def.expect("有"), c),
            Some(Kind::TtSplat) => self.parse_splat(def.expect("有"), c),
            Some(Kind::TtExpandDims) => self.parse_expand(def.expect("有"), c),
            _ if def.is_none() => self.parse_iter_arg(v, c),
            Some(Kind::ArithExtsi) => {
                let i = c.body.opd(def.expect("有"), 0);
                self.parse(i, c)
            }
            _ => false,
        }
    }

    fn add_state_scalar(&mut self, s: &Self, scalar: Ofr, c: &mut Cursor<'_, '_>) -> bool {
        let (Some(st), Some(en)) = (s.start, s.end) else { return false };
        self.start = Some(c.add_ofr(st, scalar));
        self.end = Some(c.add_ofr(en, scalar));
        self.dims.clone_from(&s.dims);
        true
    }

    fn add_states(&mut self, l: &Self, r: &Self, c: &mut Cursor<'_, '_>) -> bool {
        if l.scalar.is_some() == r.scalar.is_some() {
            return false;
        }
        self.seen_negative_shift = l.seen_negative_shift || r.seen_negative_shift || l.scalar.is_some_and(|s| s.negative_const(c.body)) || r.scalar.is_some_and(|s| s.negative_const(c.body));
        match l.scalar {
            Some(s) => self.add_state_scalar(r, s, c),
            None => self.add_state_scalar(l, r.scalar.expect("有标量"), c),
        }
    }

    fn min_state_scalar(&mut self, l: &Self, r: &Self, c: &mut Cursor<'_, '_>) -> bool {
        if l.scalar.is_some() == r.scalar.is_some() {
            return false;
        }
        let (s, n) = if l.scalar.is_some() { (l, r) } else { (r, l) };
        for i in 0..n.rank() {
            let d = c.select_ofr(s.scalar.expect("有"), n.dims[i], Ofr::idx(0));
            self.dims.push(d);
        }
        true
    }

    fn min_states(&mut self, l: &Self, r: &Self, c: &mut Cursor<'_, '_>) -> bool {
        if l.rank() != r.rank() {
            return false;
        }
        for i in 0..l.rank() {
            let d = c.minmax_ofr(l.dims[i], r.dims[i], false);
            self.dims.push(d);
        }
        true
    }

    fn parse_constant(&mut self, v: ValueId, c: &mut Cursor<'_, '_>) -> bool {
        let b = &*c.body;
        if matches!(b.ty(v), Type::Shaped(_)) {
            let Some(k) = b.constant(v) else { return false };
            if !k.values.windows(2).all(|w| w[0] == w[1]) || !matches!(k.ty.element_type(), Type::Integer { .. }) {
                return false;
            }
            let Some(x) = b.const_int(v) else { return false };
            // C++ 写的是 `op.getValue()`（常量的属性，不是结果）：物化出来的常量没人用，状态里存的是属性
            c.index(x as i64);
            self.scalar = Some(Ofr::idx(x as i64));
        } else {
            let Some(x) = b.const_int(v) else { return false };
            if !matches!(b.ty(v), Type::Integer { .. } | Type::Index) {
                return false;
            }
            self.scalar = Some(Ofr::idx(x as i64));
        }
        true
    }

    fn parse_int_scalar(&mut self, v: ValueId, c: &mut Cursor<'_, '_>) -> bool {
        if matches!(c.body.ty(v), Type::Integer { width: 1, .. }) {
            self.scalar = Some(Ofr::V(v));
        } else {
            self.scalar = Some(Ofr::V(c.value(Kind::ArithIndexCast, &[v], Type::Index)));
        }
        true
    }

    fn parse_add(&mut self, op: mlirpass::OpId, c: &mut Cursor<'_, '_>) -> bool {
        let (lv, rv) = (c.body.opd(op, 0), c.body.opd(op, 1));
        let mut l = Self::default();
        if !l.parse(lv, c) {
            return false;
        }
        let mut r = Self::default();
        if !r.parse(rv, c) {
            return false;
        }
        self.add_states(&l, &r, c)
    }

    #[allow(clippy::too_many_lines)]
    fn parse_and(&mut self, op: mlirpass::OpId, c: &mut Cursor<'_, '_>) -> bool {
        let ty = c.body.ty(c.body.res(op, 0)).clone();
        if !matches!(ty.element_type(), Type::Integer { width: 1, .. }) {
            return false;
        }
        let (is_bool, rank) = match ty.dims() {
            Some(d) if matches!(ty, Type::Shaped(_)) => (true, d.len()),
            _ => (false, 1),
        };
        let (lv, rv) = (c.body.opd(op, 0), c.body.opd(op, 1));
        let mut l = Self::default();
        if !l.parse(lv, c) && !is_bool {
            return false;
        }
        let mut r = Self::default();
        if !r.parse(rv, c) && !is_bool {
            return false;
        }
        if is_bool {
            if l.masks.len() != rank || l.masks.len() != r.masks.len() {
                return false;
            }
            let shape = ty.dims().unwrap_or_default();
            for i in 0..l.masks.len() {
                let (mut lm, mut rm) = (l.masks[i], r.masks[i]);
                if lm.is_none() && rm.is_none() {
                    self.masks.push(None);
                    continue;
                }
                let size = shape[i];
                let mat = |s: &Self| if s.is_mask() { s.dims.get(i).copied() } else { s.scalar };
                if lm.is_none() {
                    let Some(o) = mat(&l) else { return false };
                    lm = Self::to_unstructured(o, size, c);
                } else if rm.is_none() {
                    let Some(o) = mat(&r) else { return false };
                    rm = Self::to_unstructured(o, size, c);
                }
                match (lm, rm) {
                    (None, r) => self.masks.push(r),
                    (l, None) => self.masks.push(l),
                    (Some(a), Some(b2)) => {
                        let m = c.binary(Kind::ArithAndi, a, b2);
                        self.masks.push(Some(m));
                    }
                }
            }
            if self.unstructured().len() > 1 {
                return false;
            }
        }
        if !l.is_mask() || !r.is_mask() {
            return self.min_state_scalar(&l, &r, c);
        }
        self.min_states(&l, &r, c)
    }

    /// 结构化的有效个数换成一维 i1 mask（满的不要）。
    fn to_unstructured(o: Ofr, size: i64, c: &mut Cursor<'_, '_>) -> Option<ValueId> {
        if o.int() == Some(size) {
            return None;
        }
        let t = Type::tensor(&[size], int(32));
        let range = c.value_with(Kind::TtMakeRange, &[], &[("end", Attribute::of_int(i128::from(size), int(32))), ("start", Attribute::of_int(0, int(32)))], t.clone());
        let v = c.ofr_index(o);
        let v = c.value(Kind::ArithIndexCastui, &[v], int(32));
        let v = c.value(Kind::TtSplat, &[v], t);
        Some(c.cmpi(CmpIPredicate::ult, range, v))
    }

    /// `peelPositiveScale`：不回绕的 `c * x`（c 是正常数，可经 extsi）拆成 `(x, c)`。
    fn peel_scale(b: &Body<'_>, v: ValueId) -> (ValueId, i64) {
        let mut inner = v;
        while let Some(e) = b.def_of(inner, Kind::ArithExtsi) {
            inner = b.opd(e, 0);
        }
        let Some(mul) = b.def_of(inner, Kind::ArithMuli) else { return (v, 1) };
        for (x, k) in [(b.opd(mul, 0), b.opd(mul, 1)), (b.opd(mul, 1), b.opd(mul, 0))] {
            if let Some(s) = Self::const_of(b, k)
                && s > 0
                && i64::try_from(s).is_ok()
                && Self::can_peel(b, mul, x, s as i64)
            {
                return (x, s as i64);
            }
        }
        (v, 1)
    }

    fn can_peel(b: &Body<'_>, mul: mlirpass::OpId, mut x: ValueId, scale: i64) -> bool {
        // overflowFlags 含 nsw（位 0）
        let nsw = match b[mul].get("overflowFlags") {
            Some(Attribute::Extended { ext, .. }) => ext.body.as_deref().is_some_and(|s| s.contains("nsw")),
            _ => false,
        };
        if scale == 1 || nsw {
            return true;
        }
        let Some((pw, _)) = b.ty(b.res(mul, 0)).element_type().int_width() else { return false };
        let sw = b.ty(b.opd(mul, 0)).element_type().int_width().map_or(0, |x| x.0);
        if pw != sw {
            return false;
        }
        loop {
            match b.def_op(x).and_then(|d| b.kind(d)) {
                Some(Kind::ArithExtsi | Kind::TtExpandDims | Kind::TtBroadcast) => x = b.opd(b.def_op(x).expect("有"), 0),
                _ => break,
            }
        }
        let Some(r) = b.def_of(x, Kind::TtMakeRange) else { return false };
        let (s, e) = (b.int_attr(r, "start").unwrap_or(0), b.int_attr(r, "end").unwrap_or(0));
        if s >= e {
            return false;
        }
        let max_index = e as i64 - 1;
        let rw = b.ty(b.res(r, 0)).element_type().int_width().map_or(32, |x| x.0);
        let range_max = if rw >= 64 { i64::MAX } else { (1i64 << (rw - 1)) - 1 };
        let product_max = if pw >= 64 { i64::MAX } else { (1i64 << (pw - 1)) - 1 };
        max_index <= range_max && max_index <= product_max / scale
    }

    fn ceil_div(n: Ofr, d: i64, c: &mut Cursor<'_, '_>) -> Ofr {
        if let Some(v) = n.int() {
            return Ofr::idx(v.div_euclid(d) + i64::from(v.rem_euclid(d) != 0));
        }
        let dv = c.index(d);
        Ofr::V(c.binary(Kind::ArithCeildivsi, n.value().expect("值"), dv))
    }

    #[allow(clippy::too_many_lines)]
    fn parse_cmp(&mut self, op: mlirpass::OpId, c: &mut Cursor<'_, '_>) -> bool {
        let rty = c.body.ty(c.body.res(op, 0)).clone();
        let mut cmp_dim: Option<usize>;
        let cmp_v = c.body.res(op, 0);
        if let (Type::Shaped(_), Some(shape)) = (&rty, rty.dims()) {
            cmp_dim = None;
            let mut many = false;
            for (r, s) in shape.iter().enumerate() {
                if *s != 1 {
                    if cmp_dim.is_some() {
                        many = true;
                        break;
                    }
                    cmp_dim = Some(r);
                }
            }
            if many {
                cmp_dim = None;
            }
            self.masks = vec![None; shape.len()];
            if let Some(d) = cmp_dim {
                let mut m = cmp_v;
                if shape.len() > 1 {
                    let flat = Type::tensor(&[shape[d]], rty.element_type().clone());
                    // 压掉长 1 的维：每个结果维对应一组源维
                    let mut groups: Vec<Vec<i64>> = Vec::new();
                    let mut cur: Vec<i64> = Vec::new();
                    for i in 0..shape.len() {
                        cur.push(i as i64);
                        if i == d {
                            groups.push(core::mem::take(&mut cur));
                        }
                    }
                    if let Some(last) = groups.last_mut() {
                        last.extend(cur);
                    }
                    let reassoc = Attribute::Array(groups.into_iter().map(|g| Attribute::Array(g.into_iter().map(crate::ir::i64_attr).collect())).collect());
                    m = c.value_with(Kind::TensorCollapseShape, &[cmp_v], &[("reassociation", reassoc)], flat);
                }
                self.masks[d] = Some(m);
            }
        } else {
            cmp_dim = Some(0);
            self.masks.push(Some(cmp_v));
        }
        let pred = c.body.int_attr(op, "predicate").unwrap_or(-1);
        let (slt, ult, sge) = (CmpIPredicate::slt as i128, CmpIPredicate::ult as i128, CmpIPredicate::sge as i128);
        if pred != slt && pred != ult && pred != sge {
            return false;
        }
        let (lv, rv) = (c.body.opd(op, 0), c.body.opd(op, 1));
        let mut rhs = Self::default();
        if pred == sge {
            if !rhs.parse(rv, c) || rhs.scalar.is_none() {
                return false;
            }
            if !rhs.scalar.expect("有").const_zero(c.body) {
                return false;
            }
        }
        let (lhs_v, scale) = if pred == slt || pred == sge { Self::peel_scale(c.body, lv) } else { (lv, 1) };
        let mut lhs = Self::default();
        if !lhs.parse(lhs_v, c) {
            return false;
        }
        if pred != sge && (!rhs.parse(rv, c) || rhs.scalar.is_none()) {
            return false;
        }
        if pred == sge && lhs.seen_negative_shift {
            return false;
        }
        if scale != 1 {
            rhs.scalar = Some(Self::ceil_div(rhs.scalar.expect("有"), scale, c));
        }
        let mut dim: Option<usize> = if lhs.scalar.is_some() && rhs.scalar.is_some() { Some(0) } else { None };
        for i in 0..lhs.rank() {
            if lhs.dims[i].int() != Some(1) {
                if dim.is_some() {
                    return false;
                }
                dim = Some(i);
            }
        }
        let dim = dim.unwrap_or(0);
        let new_dim = if let Some(ls) = lhs.scalar {
            let d = lhs.dims.get(dim).copied().unwrap_or(Ofr::idx(0));
            c.compare_ofr(ls, rhs.scalar.expect("有"), pred, d, Ofr::idx(0))
        } else if pred == slt || pred == ult {
            let (Some(st), Some(en)) = (lhs.start, lhs.end) else { return false };
            let e = c.minmax_ofr(en, rhs.scalar.expect("有"), false);
            let e = c.minmax_ofr(e, st, true);
            c.sub_ofr(e, st)
        } else {
            lhs.dims[dim]
        };
        for i in 0..lhs.rank() {
            self.dims.push(if i == dim { new_dim } else { lhs.dims[i] });
        }
        if let Some(d) = cmp_dim
            && let Some(m) = self.masks.get_mut(d)
        {
            *m = None;
        }
        true
    }

    fn parse_iter_arg(&mut self, v: ValueId, c: &mut Cursor<'_, '_>) -> bool {
        let Def::Arg(blk, idx) = c.body[v].def else { return false };
        let Some(f) = c.body.block_owner(blk).filter(|f| c.body.is(*f, Kind::ScfFor)) else { return false };
        let mut p = c.body.parent_op(f);
        while let Some(o) = p {
            if c.body.is(o, Kind::ScfFor) {
                return false;
            }
            p = c.body.parent_op(o);
        }
        if idx == 0 {
            return false;
        }
        let arg_index = idx as usize - 1;
        let init = c.body.opd(f, 3 + arg_index);
        let Some(gs) = c.body.def_of(init, Kind::TtsGetStructuredState) else { return false };
        let tv = c.body.opd(gs, 0);
        let mut lhs = Self::default();
        {
            let mut inner = Cursor::before(c.body, f);
            inner.loc.clone_from(&c.loc);
            if !lhs.parse(tv, &mut inner) {
                return false;
            }
        }
        let offset = c.body[c.body.entry(f, 0)].args[arg_index + 2];
        if lhs.scalar.is_some() {
            let d = c.body.ty(v).dims();
            if !matches!(c.body.ty(v), Type::Shaped(_)) || d.as_deref() != Some(&[1]) {
                return false;
            }
            self.dims.push(Ofr::idx(1));
            self.scalar = Some(Ofr::V(offset));
            return true;
        }
        self.dims = lhs.dims.clone();
        let (Some(st), Some(en)) = (lhs.start, lhs.end) else { return false };
        let dist = c.sub_ofr(en, st);
        self.start = Some(Ofr::V(offset));
        self.end = Some(c.add_ofr(Ofr::V(offset), dist));
        true
    }

    fn parse_range(&mut self, op: mlirpass::OpId, c: &mut Cursor<'_, '_>) -> bool {
        let b = &*c.body;
        let shape = b.ty(b.res(op, 0)).dims().unwrap_or_default();
        let (s, e) = (b.int_attr(op, "start").unwrap_or(0) as i64, b.int_attr(op, "end").unwrap_or(0) as i64);
        let stride = (e - s + shape[0] - 1) / shape[0];
        if stride != 1 {
            return false;
        }
        self.start = Some(Ofr::idx(s));
        self.end = Some(Ofr::idx(e));
        self.dims.push(Ofr::idx(shape[0]));
        true
    }

    fn parse_broadcast(&mut self, op: mlirpass::OpId, c: &mut Cursor<'_, '_>) -> bool {
        let src = c.body.opd(op, 0);
        let ss = c.body.ty(src).dims().unwrap_or_default();
        let ds = c.body.ty(c.body.res(op, 0)).dims().unwrap_or_default();
        if !self.parse(src, c) || self.dims.len() != ss.len() {
            return false;
        }
        for i in 0..ss.len() {
            if ss[i] < ds[i] {
                self.dims[i] = Ofr::idx(ds[i]);
            }
        }
        true
    }

    fn parse_splat(&mut self, op: mlirpass::OpId, c: &mut Cursor<'_, '_>) -> bool {
        let src = c.body.opd(op, 0);
        let ds = c.body.ty(c.body.res(op, 0)).dims().unwrap_or_default();
        if !matches!(c.body.ty(src), Type::Integer { .. }) || !self.parse(src, c) {
            return false;
        }
        for s in &ds {
            self.dims.push(Ofr::idx(*s));
        }
        if matches!(c.body.ty(src), Type::Integer { width: 1, .. }) {
            self.masks = vec![None; ds.len()];
        }
        true
    }

    fn parse_expand(&mut self, op: mlirpass::OpId, c: &mut Cursor<'_, '_>) -> bool {
        let ds = c.body.ty(c.body.res(op, 0)).dims().unwrap_or_default();
        let axis = c.body.int_attr(op, "axis").unwrap_or(0) as usize;
        let src = c.body.opd(op, 0);
        let sty = c.body.ty(src).clone();
        let ss = sty.dims().unwrap_or_default();
        let is_bool = matches!(sty.element_type(), Type::Integer { width: 1, .. });
        let ok = self.parse(src, c);
        if !ok && (!is_bool || (ss.len() > 1 && self.masks.len() != ss.len())) {
            return false;
        }
        if is_bool {
            if ss.len() == 1 {
                self.masks.resize(ds.len(), None);
                self.masks[axis] = None;
                if ok {
                    self.masks[1 - axis] = None;
                } else {
                    self.dims = vec![Ofr::idx(ss[0])];
                    self.masks[1 - axis] = Some(src);
                }
            } else {
                if !ok {
                    let u = self.unstructured();
                    if u.len() != 1 {
                        return false;
                    }
                    let (d, _) = u[0];
                    self.dims[d] = Ofr::idx(ss[d]);
                }
                self.masks.insert(axis, None);
            }
        }
        self.dims.insert(axis, Ofr::idx(1));
        true
    }
}

use mlirpass::OpId;
