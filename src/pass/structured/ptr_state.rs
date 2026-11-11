//! triton-shared `PtrState`（`PtrAnalysis.cpp` 前半）：一个指针或偏移张量的结构化状态（基址、各维偏移、尺寸、行距、取模、
//! 次序），以及两个状态的加、乘、合并，建 `tts.make_tptr` / `tts.make_gather_scatter_tptr`。
use mlirformat::Type;
use mlirpass::{Body, OpData, ValueId};

use crate::pass::ofr::Ofr;
use crate::ir::{dense_i32, dense_i64, TtBuilder};
use crate::pass::ofr::OfrBuilder;
use mlirpass::Rewriter;
use crate::{Ir, Kind, pointee};

#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct PtrState {
    pub offsets: Vec<Ofr>,
    pub sizes: Vec<Ofr>,
    pub strides: Vec<Ofr>,
    pub shape: Vec<Ofr>,
    pub order: Vec<i64>,
    pub source: Option<ValueId>,
    pub scalar: Option<ValueId>,
}

impl PtrState {
    pub fn rank(&self) -> usize {
        self.offsets.len()
    }

    pub fn is_empty(&self) -> bool {
        self.rank() == 0 && self.source.is_none() && self.scalar.is_none()
    }

    pub fn dim_has_modulo(&self, d: usize) -> bool {
        self.shape[d].int() != Some(0)
    }

    pub fn has_modulo(&self) -> bool {
        (0..self.rank()).any(|d| self.dim_has_modulo(d))
    }

    /// 偏移是张量值的维不是结构化的。
    fn not_structured(b: &Body<'_>, o: Ofr) -> bool {
        o.value().is_some_and(|v| matches!(b.ty(v), Type::Shaped(_)))
    }

    pub fn dim_structured(&self, b: &Body<'_>, d: usize) -> bool {
        !Self::not_structured(b, self.offsets[d])
    }

    pub fn non_structured_dim(&self, b: &Body<'_>) -> usize {
        (0..self.rank()).find(|d| !self.dim_structured(b, *d)).unwrap_or(0)
    }

    pub fn no_structured_dim(&self, b: &Body<'_>) -> bool {
        self.rank() > 0 && self.offsets.iter().all(|o| Self::not_structured(b, *o))
    }

    pub fn is_structured(&self, b: &Body<'_>) -> bool {
        self.offsets.iter().all(|o| !Self::not_structured(b, *o))
    }

    /// 形状里大于 1 的维不止一个（`isNotSingleDim`）。
    fn not_single_dim(b: &Body<'_>, v: ValueId) -> bool {
        b.ty(v).dims().is_some_and(|d| d.iter().filter(|x| **x > 1).count() != 1)
    }

    /// `rebuildAsUnsupportedOp`。
    pub fn rebuild_as_unsupported(&mut self, b: &Body<'_>, v: ValueId) -> bool {
        if Self::not_single_dim(b, v) || !self.is_empty() {
            return false;
        }
        let t = b.ty(v);
        if matches!(t.element_type(), Type::Extended(e) if e.name == "tt.ptr") {
            return false;
        }
        for s in t.dims().unwrap_or_default() {
            if s == 1 {
                self.offsets.push(Ofr::idx(0));
                self.strides.push(Ofr::idx(0));
            } else {
                self.offsets.push(Ofr::V(v));
                self.strides.push(Ofr::idx(1));
            }
            self.sizes.push(Ofr::idx(s));
            self.shape.push(Ofr::idx(0));
        }
        true
    }

    /// `rebuildAsGatherScatter`。
    pub fn rebuild_as_gather_scatter(&mut self, b: &Body<'_>, v: ValueId, dim: usize) -> bool {
        if Self::not_single_dim(b, v) || dim >= self.rank() {
            return false;
        }
        if b.ty(v).dims().unwrap_or_default().get(dim).is_none_or(|s| *s <= 1) {
            return false;
        }
        self.offsets[dim] = Ofr::V(v);
        self.strides[dim] = Ofr::idx(1);
        self.shape[dim] = Ofr::idx(0);
        true
    }

    /// `addState`。
    #[allow(clippy::too_many_lines)]
    pub fn add_state(&mut self, l: &Self, r: &Self, unstructured: bool, c: &mut Rewriter<'_, '_>) -> bool {
        if l.source.is_some() && r.source.is_some() {
            return false;
        }
        self.source = l.source.or(r.source);
        if let (Some(a), Some(s)) = (l.scalar, r.scalar) {
            self.scalar = Some(c.binary(Kind::ArithAddi, a, s));
        } else if l.rank() == 0 {
            self.scalar = l.scalar.or(r.scalar);
        }
        if !l.is_structured(c.body) && !r.is_structured(c.body) && l.non_structured_dim(c.body) != r.non_structured_dim(c.body) {
            return false;
        }
        for i in 0..l.rank() {
            if l.dim_structured(c.body, i) && r.dim_structured(c.body, i) {
                let o = c.add_ofr(l.offsets[i], r.offsets[i]);
                self.offsets.push(o);
                let s = c.add_ofr(l.strides[i], r.strides[i]);
                self.strides.push(s);
            } else if unstructured {
                if l.strides[i].const_zero(c.body) && l.offsets[i].const_zero(c.body) {
                    self.offsets.push(r.offsets[i]);
                    self.strides.push(r.strides[i]);
                } else if r.strides[i].const_zero(c.body) && r.offsets[i].const_zero(c.body) {
                    self.offsets.push(l.offsets[i]);
                    self.strides.push(l.strides[i]);
                } else {
                    let (mut lo, mut ro, mut ls, mut rs) = (l.offsets[i], r.offsets[i], l.strides[i], r.strides[i]);
                    if ls.const_zero(c.body) {
                        ls = Ofr::idx(1);
                    }
                    if rs.const_zero(c.body) {
                        rs = Ofr::idx(1);
                    }
                    if lo != ro && ls != rs {
                        let s = c.expand_ofr_index(ls, lo);
                        lo = c.mul_ofr(lo, s);
                        let s = c.expand_ofr_index(rs, ro);
                        ro = c.mul_ofr(ro, s);
                        ls = Ofr::idx(1);
                        rs = Ofr::idx(1);
                    }
                    if ls == rs {
                        if l.dim_structured(c.body, i) {
                            lo = c.expand_ofr_index(lo, ro);
                        } else {
                            ro = c.expand_ofr_index(ro, lo);
                        }
                        let o = c.add_ofr(lo, ro);
                        self.offsets.push(o);
                        self.strides.push(ls);
                    } else {
                        self.offsets.push(lo);
                        let s = c.add_ofr(ls, rs);
                        self.strides.push(s);
                    }
                }
            } else {
                self.strides.push(Ofr::idx(1));
                self.offsets.push(if l.dim_structured(c.body, i) { r.offsets[i] } else { l.offsets[i] });
            }
            self.sizes.push(l.sizes[i]);
        }
        if l.has_modulo() && r.has_modulo() {
            return false;
        }
        let (lhs, rhs) = if r.has_modulo() { (r, l) } else { (l, r) };
        let mut i = 0;
        while i < lhs.rank() {
            if !lhs.dim_structured(c.body, i) || !rhs.dim_structured(c.body, i) {
                self.shape.push(Ofr::idx(0));
                i += 1;
                continue;
            }
            if !lhs.dim_has_modulo(i) || rhs.offsets[i].const_zero(c.body) {
                self.shape.push(lhs.shape[i]);
            } else if i == 0 && lhs.rank() == 2 && rhs.scalar.is_some() {
                self.shape.push(lhs.shape[1]);
                self.shape.push(lhs.shape[0]);
                break;
            } else {
                return false;
            }
            i += 1;
        }
        true
    }

    /// `mulState`。
    pub fn mul_state(&mut self, l: &Self, r: &Self, unstructured: bool, c: &mut Rewriter<'_, '_>) -> bool {
        if l.source.is_some() && r.source.is_some() {
            return false;
        }
        if l.scalar.is_none() && r.scalar.is_none() {
            return false;
        }
        let (lhs, rhs) = if r.scalar.is_none() && l.scalar.is_some() { (r, l) } else { (l, r) };
        if let (Some(a), Some(s)) = (l.scalar, r.scalar) {
            self.scalar = Some(c.binary(Kind::ArithMuli, a, s));
        }
        let rs = Ofr::V(rhs.scalar.expect("一边是标量"));
        for i in 0..lhs.sizes.len() {
            if lhs.dim_structured(c.body, i) {
                let o = c.mul_ofr(lhs.offsets[i], rs);
                self.offsets.push(o);
                let s = c.mul_ofr(lhs.strides[i], rs);
                self.strides.push(s);
                let sh = c.mul_ofr(lhs.shape[i], rs);
                self.shape.push(sh);
            } else {
                self.offsets.push(lhs.offsets[i]);
                if unstructured {
                    let s = c.mul_ofr(lhs.strides[i], rs);
                    self.strides.push(s);
                } else {
                    self.strides.push(lhs.strides[i]);
                }
                self.shape.push(Ofr::idx(0));
            }
            self.sizes.push(lhs.sizes[i]);
        }
        !rhs.has_modulo()
    }

    /// `mergeUnstructuredState`。
    pub fn merge_unstructured(&mut self, b: &Body<'_>, other: &Self) -> bool {
        if self.is_structured(b) || other.is_structured(b) || other.non_structured_dim(b) != self.non_structured_dim(b) || self.rank() != other.rank() {
            return false;
        }
        let d = other.non_structured_dim(b);
        self.offsets[d] = other.offsets[d];
        self.strides[d] = other.strides[d];
        self.shape[d] = other.shape[d];
        true
    }

    fn static_sizes(&self) -> Vec<i64> {
        self.sizes.iter().map(|s| s.int().unwrap_or(0)).collect()
    }

    /// `tts.make_tptr`：次序空是张量指针，非空是块指针。
    pub fn make_tptr(&self, c: &mut Rewriter<'_, '_>) -> ValueId {
        let src = self.source.expect("有基址");
        let sizes = self.static_sizes();
        let base_ty = c.body.ty(src).clone();
        let ty = if self.order.is_empty() {
            Type::tensor(&sizes, base_ty)
        } else {
            let inner = Type::tensor(&sizes, pointee(&base_ty));
            Self::ptr_to(&base_ty, &inner)
        };
        let to = |xs: &[Ofr]| xs.iter().map(|o| crate::ir::Ofr::from(*o)).collect::<Vec<_>>();
        c.make_tptr(src, &sizes, &to(&self.strides), &to(&self.offsets), &to(&self.shape), &self.order, ty)
    }

    /// `!tt.ptr<inner>`，地址空间照 `like`。
    pub fn ptr_to<'a>(like: &Type<'a>, inner: &Type<'_>) -> Type<'a> {
        let space = match like {
            Type::Extended(e) => e.body.as_deref().and_then(|b| b.rsplit_once(',').map(|(_, s)| s.trim_end_matches('>').trim().to_string())),
            _ => None,
        };
        let body = match space {
            Some(s) => format!("<{inner}, {s}>"),
            None => format!("<{inner}>"),
        };
        Type::Extended(Box::new(mlirformat::Extended { name: "tt.ptr".into(), body: Some(body.into()), params: Vec::new() }))
    }

    /// `tts.make_gather_scatter_tptr`（非结构化的那一维的偏移先压成一维）。
    pub fn make_gather_scatter(&mut self, c: &mut Rewriter<'_, '_>) -> ValueId {
        let sizes = self.static_sizes();
        let d = self.non_structured_dim(c.body);
        let mut off = self.offsets[d].value().expect("非结构化维的偏移是值");
        let oty = c.body.ty(off).clone();
        let od = oty.dims().unwrap_or_default();
        if od.len() > 1 {
            let n: i64 = od.iter().product();
            let reassoc = mlirformat::Attribute::Array(vec![mlirformat::Attribute::Array((0..od.len()).map(|i| crate::ir::i64_attr(i as i64)).collect())]);
            let cty = Type::tensor(&[n], oty.element_type().clone());
            off = c.value_with(Kind::TensorCollapseShape, &[off], &[("reassociation", reassoc)], cty);
            self.offsets[d] = Ofr::V(off);
        }
        let src = self.source.expect("有基址");
        Self::gather_scatter_op(c, src, off, None, d, &sizes, &self.strides, &self.offsets)
    }

    /// `MakeGatherScatterTensorPtrOp::build`。
    pub fn gather_scatter_op(c: &mut Rewriter<'_, '_>, base: ValueId, off: ValueId, mask: Option<ValueId>, dim: usize, sizes: &[i64], strides: &[Ofr], offsets: &[Ofr]) -> ValueId {
        let (mut st_off, mut dyn_off) = (Vec::new(), Vec::new());
        for (i, o) in offsets.iter().enumerate() {
            if i == dim {
                st_off.push(0);
            } else {
                st_off.push(o.static_value());
                dyn_off.extend(o.value());
            }
        }
        let dyn_str: Vec<ValueId> = strides.iter().filter_map(|s| s.value()).collect();
        let st_str: Vec<i64> = strides.iter().map(|s| s.static_value()).collect();
        let base_ty = c.body.ty(base).clone();
        let elem = pointee(&base_ty);
        let ty = if mask.is_some() && matches!(c.body.ty(off), Type::Integer { .. } | Type::Index) {
            PtrState::ptr_to(&base_ty, &elem)
        } else {
            PtrState::ptr_to(&base_ty, &Type::tensor(sizes, elem))
        };
        let mut operands = vec![base, off];
        operands.extend(&dyn_str);
        operands.extend(&dyn_off);
        operands.extend(mask);
        let d = OpData::build(Kind::TtsMakeGatherScatterTptr.name())
            .operands(&operands)
            .with("gather_scatter_dim", mlirformat::Attribute::of_int(dim as i128, crate::ir::int(32)))
            .with("operandSegmentSizes", dense_i32(&[1, 1, dyn_str.len() as i64, dyn_off.len() as i64, i64::from(mask.is_some())]))
            .with("sizes", dense_i64(sizes))
            .with("static_offsets", dense_i64(&st_off))
            .with("static_strides", dense_i64(&st_str));
        let o = c.create(d, &[ty]);
        c.body.res(o, 0)
    }
}

impl From<Ofr> for crate::ir::Ofr {
    fn from(o: Ofr) -> Self {
        match o {
            Ofr::V(v) => Self::V(v),
            Ofr::I(c, _) => Self::C(c),
        }
    }
}
