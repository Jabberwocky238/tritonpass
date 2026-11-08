//! `OpFoldResult` 与 triton-shared `OpFoldResultUtils.cpp` 的运算：常量就地折，不是常量才建 arith op（建的次序照 C++）。
use mlirformat::arith::CmpIPredicate;
use mlirformat::{Attribute, Type};
use mlirpass::{Body, ValueId};

use crate::ir::{Cursor, TtBuilder, int, integer};
use crate::{Ir, Kind};

/// `OpFoldResult`：值，或整数属性（`width == 0` 是 index）。两个整数属性相等当且仅当值与类型都相等（MLIR 的属性唯一化）。
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Ofr {
    V(ValueId),
    I(i64, u32),
}

impl Ofr {
    /// `getIndexAttr(v)`。
    pub const fn idx(v: i64) -> Self {
        Self::I(v, 0)
    }

    /// `getIntAttr`：整数属性的值。
    pub fn int(self) -> Option<i64> {
        match self {
            Self::I(v, _) => Some(v),
            Self::V(_) => None,
        }
    }

    pub fn value(self) -> Option<ValueId> {
        match self {
            Self::V(v) => Some(v),
            Self::I(..) => None,
        }
    }

    /// 静态数组里的项（动态的写 kDynamic）。
    pub fn static_value(self) -> i64 {
        self.int().unwrap_or(crate::ir::DYNAMIC)
    }

    fn ty(width: u32) -> Type<'static> {
        if width == 0 { Type::Index } else { int(width) }
    }

    /// 标量 `arith.constant` 的整数值（`IntegerAttr`，不是 dense）。
    pub fn scalar_const(b: &Body<'_>, v: ValueId) -> Option<i64> {
        b.def_of(v, Kind::ArithConstant)?;
        if matches!(b.ty(v), Type::Shaped(_)) {
            return None;
        }
        b.const_int(v).and_then(|x| i64::try_from(x).ok())
    }

    /// `hasConstZero`。
    pub fn const_zero(self, b: &Body<'_>) -> bool {
        match self {
            Self::I(v, _) => v == 0,
            Self::V(v) => Self::scalar_const(b, v) == Some(0),
        }
    }

    /// `hasNegativeConst`。
    pub fn negative_const(self, b: &Body<'_>) -> bool {
        match self {
            Self::I(v, _) => v < 0,
            Self::V(v) => Self::scalar_const(b, v).is_some_and(|x| x < 0),
        }
    }
}

/// ⭐ OpFoldResult 的算术（`addOFRs` 一类），在 mlirpass 的 [`Rewriter`] 上建 op。
pub trait OfrBuilder {
    fn index(&mut self, v: i64) -> ValueId;
    fn ofr_value(&mut self, o: Ofr) -> ValueId;
    fn ofr_index(&mut self, o: Ofr) -> ValueId;
    fn ofr_pair(&mut self, l: Ofr, r: Ofr) -> (ValueId, ValueId);
    fn add_ofr(&mut self, l: Ofr, r: Ofr) -> Ofr;
    fn sub_ofr(&mut self, l: Ofr, r: Ofr) -> Ofr;
    fn mul_ofr(&mut self, l: Ofr, r: Ofr) -> Ofr;
    fn minmax_ofr(&mut self, l: Ofr, r: Ofr, max: bool) -> Ofr;
    fn select_ofr(&mut self, c: Ofr, t: Ofr, f: Ofr) -> Ofr;
    fn compare_ofr(&mut self, l: Ofr, r: Ofr, pred: i128, t: Ofr, f: Ofr) -> Ofr;
    fn index_type_cast(&mut self, v: ValueId, target: &Type<'static>) -> ValueId;
    fn expand_ofr_index(&mut self, ofr: Ofr, target: Ofr) -> Ofr;
}

impl<'a, L: mlirpass::Listener<'a> + ?Sized> OfrBuilder for mlirpass::Rewriter<'_, 'a, L> {
    /// `arith.constant v : index`。
    fn index(&mut self, v: i64) -> ValueId {
        self.scalar(integer(64, i128::from(v)), Type::Index)
    }

    /// `ofrToValue`。
    fn ofr_value(&mut self, o: Ofr) -> ValueId {
        match o {
            Ofr::V(v) => v,
            Ofr::I(v, w) => self.scalar(integer(if w == 0 { 64 } else { w }, i128::from(v)), Ofr::ty(w)),
        }
    }

    /// `ofrToIndexValue`。
    fn ofr_index(&mut self, o: Ofr) -> ValueId {
        match o {
            Ofr::V(v) => {
                if matches!(self.body.ty(v), Type::Index) {
                    v
                } else {
                    self.value(Kind::ArithIndexCast, &[v], Type::Index)
                }
            }
            Ofr::I(v, _) => self.index(v),
        }
    }

    fn ofr_pair(&mut self, l: Ofr, r: Ofr) -> (ValueId, ValueId) {
        let lv = match l {
            Ofr::V(v) => v,
            Ofr::I(c, _) => self.index(c),
        };
        let rv = match r {
            Ofr::V(v) => v,
            Ofr::I(c, _) => self.index(c),
        };
        (lv, rv)
    }

    /// `addOFRs`。
    fn add_ofr(&mut self, l: Ofr, r: Ofr) -> Ofr {
        match (l.int(), r.int()) {
            (None, Some(0)) => return l,
            (Some(0), None) => return r,
            (Some(a), Some(b)) => return Ofr::idx(a + b),
            _ => {}
        }
        let (lv, rv) = self.ofr_pair(l, r);
        Ofr::V(self.binary(Kind::ArithAddi, lv, rv))
    }

    /// `subOFRs`。
    fn sub_ofr(&mut self, l: Ofr, r: Ofr) -> Ofr {
        match (l.int(), r.int()) {
            (None, Some(0)) => return l,
            (Some(a), Some(b)) => return Ofr::idx(a - b),
            _ => {}
        }
        let (lv, rv) = self.ofr_pair(l, r);
        Ofr::V(self.binary(Kind::ArithSubi, lv, rv))
    }

    /// `mulOFRs`（值是标量常量的也当常量看）。
    fn mul_ofr(&mut self, l: Ofr, r: Ofr) -> Ofr {
        let li = l.int().or_else(|| l.value().and_then(|v| Ofr::scalar_const(self.body, v)));
        let ri = r.int().or_else(|| r.value().and_then(|v| Ofr::scalar_const(self.body, v)));
        if let Some(a) = li {
            if a == 0 {
                return l;
            }
            if a == 1 {
                return r;
            }
        }
        if let Some(b) = ri {
            if b == 0 {
                return r;
            }
            if b == 1 {
                return l;
            }
        }
        if let (Some(a), Some(b)) = (li, ri) {
            return Ofr::idx(a * b);
        }
        let lv = match (li, l) {
            (Some(a), _) => self.index(a),
            (None, Ofr::V(v)) => v,
            (None, Ofr::I(..)) => unreachable!("整数属性已有值"),
        };
        let rv = match (ri, r) {
            (Some(b), _) => self.index(b),
            (None, Ofr::V(v)) => v,
            (None, Ofr::I(..)) => unreachable!("整数属性已有值"),
        };
        Ofr::V(self.binary(Kind::ArithMuli, lv, rv))
    }

    /// `minOFRs` / `maxOFRs`。
    fn minmax_ofr(&mut self, l: Ofr, r: Ofr, max: bool) -> Ofr {
        if let (Some(a), Some(b)) = (l.int(), r.int()) {
            return Ofr::idx(if max { a.max(b) } else { a.min(b) });
        }
        let (lv, rv) = self.ofr_pair(l, r);
        Ofr::V(self.binary(if max { Kind::ArithMaxsi } else { Kind::ArithMinsi }, lv, rv))
    }

    /// `selectOFRs`。
    fn select_ofr(&mut self, c: Ofr, t: Ofr, f: Ofr) -> Ofr {
        let tv = self.ofr_index(t);
        let fv = self.ofr_index(f);
        let cv = self.ofr_value(c);
        Ofr::V(self.select(cv, tv, fv))
    }

    /// `compareOFRs`。
    fn compare_ofr(&mut self, l: Ofr, r: Ofr, pred: i128, t: Ofr, f: Ofr) -> Ofr {
        if let (Some(a), Some(b)) = (l.int(), r.int()) {
            let p = |x: CmpIPredicate| x as i128 == pred;
            let truth = if p(CmpIPredicate::eq) {
                a == b
            } else if p(CmpIPredicate::ne) {
                a != b
            } else if p(CmpIPredicate::slt) || p(CmpIPredicate::ult) {
                a < b
            } else if p(CmpIPredicate::sle) || p(CmpIPredicate::ule) {
                a <= b
            } else if p(CmpIPredicate::sgt) || p(CmpIPredicate::ugt) {
                a > b
            } else {
                a >= b
            };
            return if truth { t } else { f };
        }
        let lv = self.ofr_index(l);
        let rv = self.ofr_index(r);
        let ty = self.body.ty(lv).i1_like();
        let c = self.value_with(Kind::ArithCmpi, &[lv, rv], &[("predicate", Attribute::of_int(pred, int(64)))], ty);
        self.select_ofr(Ofr::V(c), t, f)
    }

    /// `indexTypeCast`。
    fn index_type_cast(&mut self, v: ValueId, target: &Type<'static>) -> ValueId {
        let ty = self.body.ty(v).clone();
        if matches!(target, Type::Index) || matches!(ty, Type::Index) {
            return self.value(Kind::ArithIndexCast, &[v], target.clone());
        }
        let (tw, w) = (target.int_width().map_or(0, |x| x.0), ty.int_width().map_or(0, |x| x.0));
        self.value(if tw > w { Kind::ArithExtsi } else { Kind::ArithTrunci }, &[v], target.clone())
    }

    /// `expandOFRIndex`：`ofr` 换成与 `target` 同类型（标量铺开、换元素类型、换形状）。
    fn expand_ofr_index(&mut self, ofr: Ofr, target: Ofr) -> Ofr {
        let Ofr::V(tv) = target else { return ofr };
        let tty = self.body.ty(tv).owned();
        let v = match ofr {
            Ofr::V(v) => v,
            Ofr::I(c, w) => self.scalar(integer(if w == 0 { 64 } else { w }, i128::from(c)), Ofr::ty(w)),
        };
        let ty = self.body.ty(v).owned();
        if tty == ty {
            return ofr;
        }
        let tshaped = matches!(tty, Type::Shaped(_));
        let shaped = matches!(ty, Type::Shaped(_));
        if tshaped && !shaped {
            let te = tty.element_type().owned();
            let v = if te != ty { self.index_type_cast(v, &te) } else { v };
            return Ofr::V(self.value(Kind::TtSplat, &[v], tty));
        }
        if tshaped && shaped {
            let (te, e) = (tty.element_type().owned(), ty.element_type().owned());
            if tty.dims() != ty.dims() {
                let dims = tty.dims().unwrap_or_default();
                let mut shape_values = Vec::new();
                for d in &dims {
                    shape_values.push(self.index(*d));
                }
                let st = Type::tensor(&[dims.len() as i64], Type::Index);
                // C++ 的 `ReshapeOp::create(b, loc, ty, v, shapeTensor)`：shapeTensor 落在 `bool allowReorder` 上（非空即 true），
                // 不是操作数；from_elements 照建（死的，之后被收拾掉）
                let _shape = self.value(Kind::TensorFromElements, &shape_values, st);
                return Ofr::V(self.value_with(Kind::TtReshape, &[v], &[("allow_reorder", Attribute::Unit)], tty));
            }
            if matches!(te, Type::Index) || matches!(e, Type::Index) {
                return Ofr::V(self.value(Kind::ArithIndexCast, &[v], tty));
            }
            let (tw, w) = (te.int_width().map_or(0, |x| x.0), e.int_width().map_or(0, |x| x.0));
            return Ofr::V(self.value(if tw > w { Kind::ArithExtsi } else { Kind::ArithTrunci }, &[v], tty));
        }
        Ofr::V(self.index_type_cast(v, &tty))
    }
}

impl Cursor<'_, '_> {
    /// `arith.constant v : index`。
    pub fn index(&mut self, v: i64) -> ValueId {
        self.constant(integer(64, i128::from(v)), Type::Index)
    }

    /// `ofrToValue`。
    pub fn ofr_value(&mut self, o: Ofr) -> ValueId {
        match o {
            Ofr::V(v) => v,
            Ofr::I(v, w) => self.constant(integer(if w == 0 { 64 } else { w }, i128::from(v)), Ofr::ty(w)),
        }
    }

    /// `ofrToIndexValue`。
    pub fn ofr_index(&mut self, o: Ofr) -> ValueId {
        match o {
            Ofr::V(v) => {
                if matches!(self.body.ty(v), Type::Index) {
                    v
                } else {
                    self.value(Kind::ArithIndexCast, &[v], Type::Index)
                }
            }
            Ofr::I(v, _) => self.index(v),
        }
    }

    fn ofr_pair(&mut self, l: Ofr, r: Ofr) -> (ValueId, ValueId) {
        let lv = match l {
            Ofr::V(v) => v,
            Ofr::I(c, _) => self.index(c),
        };
        let rv = match r {
            Ofr::V(v) => v,
            Ofr::I(c, _) => self.index(c),
        };
        (lv, rv)
    }

    /// `addOFRs`。
    pub fn add_ofr(&mut self, l: Ofr, r: Ofr) -> Ofr {
        match (l.int(), r.int()) {
            (None, Some(0)) => return l,
            (Some(0), None) => return r,
            (Some(a), Some(b)) => return Ofr::idx(a + b),
            _ => {}
        }
        let (lv, rv) = self.ofr_pair(l, r);
        Ofr::V(self.binary(Kind::ArithAddi, lv, rv))
    }

    /// `subOFRs`。
    pub fn sub_ofr(&mut self, l: Ofr, r: Ofr) -> Ofr {
        match (l.int(), r.int()) {
            (None, Some(0)) => return l,
            (Some(a), Some(b)) => return Ofr::idx(a - b),
            _ => {}
        }
        let (lv, rv) = self.ofr_pair(l, r);
        Ofr::V(self.binary(Kind::ArithSubi, lv, rv))
    }

    /// `mulOFRs`（值是标量常量的也当常量看）。
    pub fn mul_ofr(&mut self, l: Ofr, r: Ofr) -> Ofr {
        let li = l.int().or_else(|| l.value().and_then(|v| Ofr::scalar_const(self.body, v)));
        let ri = r.int().or_else(|| r.value().and_then(|v| Ofr::scalar_const(self.body, v)));
        if let Some(a) = li {
            if a == 0 {
                return l;
            }
            if a == 1 {
                return r;
            }
        }
        if let Some(b) = ri {
            if b == 0 {
                return r;
            }
            if b == 1 {
                return l;
            }
        }
        if let (Some(a), Some(b)) = (li, ri) {
            return Ofr::idx(a * b);
        }
        let lv = match (li, l) {
            (Some(a), _) => self.index(a),
            (None, Ofr::V(v)) => v,
            (None, Ofr::I(..)) => unreachable!("整数属性已有值"),
        };
        let rv = match (ri, r) {
            (Some(b), _) => self.index(b),
            (None, Ofr::V(v)) => v,
            (None, Ofr::I(..)) => unreachable!("整数属性已有值"),
        };
        Ofr::V(self.binary(Kind::ArithMuli, lv, rv))
    }

    /// `minOFRs` / `maxOFRs`。
    pub fn minmax_ofr(&mut self, l: Ofr, r: Ofr, max: bool) -> Ofr {
        if let (Some(a), Some(b)) = (l.int(), r.int()) {
            return Ofr::idx(if max { a.max(b) } else { a.min(b) });
        }
        let (lv, rv) = self.ofr_pair(l, r);
        Ofr::V(self.binary(if max { Kind::ArithMaxsi } else { Kind::ArithMinsi }, lv, rv))
    }

    /// `selectOFRs`。
    pub fn select_ofr(&mut self, c: Ofr, t: Ofr, f: Ofr) -> Ofr {
        let tv = self.ofr_index(t);
        let fv = self.ofr_index(f);
        let cv = self.ofr_value(c);
        Ofr::V(self.select(cv, tv, fv))
    }

    /// `compareOFRs`。
    pub fn compare_ofr(&mut self, l: Ofr, r: Ofr, pred: i128, t: Ofr, f: Ofr) -> Ofr {
        if let (Some(a), Some(b)) = (l.int(), r.int()) {
            let p = |x: CmpIPredicate| x as i128 == pred;
            let truth = if p(CmpIPredicate::eq) {
                a == b
            } else if p(CmpIPredicate::ne) {
                a != b
            } else if p(CmpIPredicate::slt) || p(CmpIPredicate::ult) {
                a < b
            } else if p(CmpIPredicate::sle) || p(CmpIPredicate::ule) {
                a <= b
            } else if p(CmpIPredicate::sgt) || p(CmpIPredicate::ugt) {
                a > b
            } else {
                a >= b
            };
            return if truth { t } else { f };
        }
        let lv = self.ofr_index(l);
        let rv = self.ofr_index(r);
        let ty = self.body.ty(lv).i1_like();
        let c = self.value_with(Kind::ArithCmpi, &[lv, rv], &[("predicate", Attribute::of_int(pred, int(64)))], ty);
        self.select_ofr(Ofr::V(c), t, f)
    }

    /// `indexTypeCast`。
    pub fn index_type_cast(&mut self, v: ValueId, target: &Type<'static>) -> ValueId {
        let ty = self.body.ty(v).clone();
        if matches!(target, Type::Index) || matches!(ty, Type::Index) {
            return self.value(Kind::ArithIndexCast, &[v], target.clone());
        }
        let (tw, w) = (target.int_width().map_or(0, |x| x.0), ty.int_width().map_or(0, |x| x.0));
        self.value(if tw > w { Kind::ArithExtsi } else { Kind::ArithTrunci }, &[v], target.clone())
    }

    /// `expandOFRIndex`：`ofr` 换成与 `target` 同类型（标量铺开、换元素类型、换形状）。
    pub fn expand_ofr_index(&mut self, ofr: Ofr, target: Ofr) -> Ofr {
        let Ofr::V(tv) = target else { return ofr };
        let tty = self.body.ty(tv).owned();
        let v = match ofr {
            Ofr::V(v) => v,
            Ofr::I(c, w) => self.constant(integer(if w == 0 { 64 } else { w }, i128::from(c)), Ofr::ty(w)),
        };
        let ty = self.body.ty(v).owned();
        if tty == ty {
            return ofr;
        }
        let tshaped = matches!(tty, Type::Shaped(_));
        let shaped = matches!(ty, Type::Shaped(_));
        if tshaped && !shaped {
            let te = tty.element_type().owned();
            let v = if te != ty { self.index_type_cast(v, &te) } else { v };
            return Ofr::V(self.value(Kind::TtSplat, &[v], tty));
        }
        if tshaped && shaped {
            let (te, e) = (tty.element_type().owned(), ty.element_type().owned());
            if tty.dims() != ty.dims() {
                let dims = tty.dims().unwrap_or_default();
                let mut shape_values = Vec::new();
                for d in &dims {
                    shape_values.push(self.index(*d));
                }
                let st = Type::tensor(&[dims.len() as i64], Type::Index);
                // C++ 的 `ReshapeOp::create(b, loc, ty, v, shapeTensor)`：shapeTensor 落在 `bool allowReorder` 上（非空即 true），
                // 不是操作数；from_elements 照建（死的，之后被收拾掉）
                let _shape = self.value(Kind::TensorFromElements, &shape_values, st);
                return Ofr::V(self.value_with(Kind::TtReshape, &[v], &[("allow_reorder", Attribute::Unit)], tty));
            }
            if matches!(te, Type::Index) || matches!(e, Type::Index) {
                return Ofr::V(self.value(Kind::ArithIndexCast, &[v], tty));
            }
            let (tw, w) = (te.int_width().map_or(0, |x| x.0), e.int_width().map_or(0, |x| x.0));
            return Ofr::V(self.value(if tw > w { Kind::ArithExtsi } else { Kind::ArithTrunci }, &[v], tty));
        }
        Ofr::V(self.index_type_cast(v, &tty))
    }
}
