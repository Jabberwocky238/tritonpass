//! tt 方言的 op 接口（mlirpass 的 [`OpInterfaces`]）：上游的 `canonicalize` 经它认得 tt（与 MLIR 一样，一次贪心跑全部方言的折叠与模式）。
//! - fold：Triton `Ops.cpp` 的 `SplatOp` / `MakeRangeOp` / `ExpandDimsOp` / `ReshapeOp` / `BroadcastOp` / `AddPtrOp` / `FpToFpOp` /
//!   `TransOp::fold`；常量的物化照 `TritonDialect::materializeConstant`（`arith.constant`）；
//! - 规范化模式：`CanonicalizeMaskedLoadPattern`、`…StorePattern`、`BroadcastSplatPattern`、`BroadcastBroadcastPattern`、
//!   `ReshapeOp::canonicalize`；
//! - 内存效应：`tt.load` 读 GlobalMemory（volatile 另有写），没有用处的读是平凡死的。
use mlirformat::{Attribute, Const, Scalar, Type};
use mlirpass::{Body, EffectInstance, EffectKind, Fold, Folded, OpData, OpId, OpInterfaces, Pattern, PatternSet, Rewriter, ValueId};

use crate::ir::dense_values;
use crate::{Ir, Kind};

/// tt 方言的 op 接口。
pub struct TtInterfaces;

impl OpInterfaces for TtInterfaces {
    fn namespace(&self) -> &str {
        "tt"
    }

    fn effects(&self, b: &Body<'_>, op: OpId) -> Option<Vec<EffectInstance>> {
        if !b.is(op, Kind::TtLoad) {
            return None;
        }
        let mut e = vec![EffectInstance { kind: EffectKind::Read, value: Some(b.opd(op, 0)), resource: "GlobalMemory" }];
        if matches!(b[op].get("isVolatile"), Some(Attribute::Bool(true))) {
            e.push(EffectInstance::on(EffectKind::Write, None));
        }
        Some(e)
    }

    fn fold<'a>(&self, b: &mut Body<'a>, op: OpId, _: &[Option<Attribute<'a>>]) -> Fold<'a> {
        TtCanon::fold(b, op).map_or(Fold::Failed, |f| Fold::Results(vec![f]))
    }

    fn materialize<'a>(&self, value: &Attribute<'a>, ty: &Type<'a>) -> Option<OpData<'a>> {
        Some(OpData::build(Kind::ArithConstant.name()).with("value", value.clone()))
            .filter(|_| matches!(value, Attribute::Int { .. } | Attribute::Float { .. } | Attribute::Bool(_) | Attribute::Builtin { .. }) && !matches!(ty, Type::Extended(_)))
    }

    fn canonicalization_patterns(&self, s: &mut PatternSet) {
        s.add(MaskedLoad).add(MaskedStore).add(BroadcastSplat).add(BroadcastBroadcast).add(ReshapeCanon);
        ExpandDimsCanon::patterns(s);
    }
}

/// tt 的 fold。
pub struct TtCanon;

impl TtCanon {
    /// splat 的常量（全部元素相同）。
    fn splat_const<'a>(b: &Body<'a>, v: ValueId) -> Option<Const<'a>> {
        b.constant(v).filter(|c| c.elements && c.values.windows(2).all(|w| w[0] == w[1]))
    }

    fn attr<'a>(c: Const<'a>) -> Option<Folded<'a>> {
        Some(Folded::Attr(c.into()))
    }

    /// 一个 tt op 的 fold：折成常量或一个已有的值。
    fn fold<'a>(b: &Body<'a>, op: OpId) -> Option<Folded<'a>> {
        let k = b.kind(op)?;
        let res_ty = b.ty(*b[op].results.first()?).clone();
        match k {
            // splat(常量标量) ⇒ splat 常量
            Kind::TtSplat => {
                let c = b.constant(b.opd(op, 0)).filter(|c| !c.elements)?;
                Self::attr(Const::splat(c.values[0], res_ty))
            }
            // make_range(s, s + 1) ⇒ splat(s)
            Kind::TtMakeRange => {
                let (s, e) = (b.int_attr(op, "start")?, b.int_attr(op, "end")?);
                (s + 1 == e).then(|| Folded::Attr(Const::splat(crate::ir::integer(32, s), res_ty).into()))
            }
            // expand_dims / reshape 的常量源：splat 换形状，非 splat 重排形状；reshape 到同类型且不许重排 ⇒ 源
            Kind::TtExpandDims | Kind::TtReshape => {
                let src = b.opd(op, 0);
                if k == Kind::TtReshape && *b.ty(src) == res_ty && b[op].get("allow_reorder").is_none() {
                    return Some(Folded::Value(src));
                }
                let c = b.constant(src).filter(|c| c.elements)?;
                let splat = c.values.windows(2).all(|w| w[0] == w[1]);
                Self::attr(if splat { Const::splat(c.values[0], res_ty) } else { Const { ty: res_ty, values: c.values, elements: true } })
            }
            // broadcast 到同类型 ⇒ 源；splat 常量源 ⇒ 换形状
            Kind::TtBroadcast => {
                let src = b.opd(op, 0);
                if *b.ty(src) == res_ty {
                    return Some(Folded::Value(src));
                }
                let c = Self::splat_const(b, src)?;
                Self::attr(Const::splat(c.values[0], res_ty))
            }
            // addptr(p, 0) ⇒ p
            Kind::TtAddptr => (b.const_int(b.opd(op, 1)) == Some(0)).then(|| Folded::Value(b.opd(op, 0))),
            // fp_to_fp 到同类型 ⇒ 源；源是 ±0 ⇒ 同号的 0
            Kind::TtFpToFp => {
                let src = b.opd(op, 0);
                if *b.ty(src) == res_ty {
                    return Some(Folded::Value(src));
                }
                let c = b.constant(src)?;
                let Some(Scalar::Float(f)) = c.values.first().copied() else { return None };
                if !c.values.windows(2).all(|w| w[0] == w[1]) || !f.is_zero() {
                    return None;
                }
                let kind = crate::ir::float_kind(&res_ty)?;
                let zero = crate::ir::float(kind, if f.is_negative() { -0.0 } else { 0.0 });
                Self::attr(if matches!(res_ty, Type::Shaped(_)) { Const::splat(zero, res_ty) } else { Const::scalar(zero, res_ty) })
            }
            // trans(x, 恒等次序) 且类型相同 ⇒ x
            Kind::TtTrans => {
                let order = dense_values(b[op].get("order"));
                let src = b.opd(op, 0);
                (order.iter().enumerate().all(|(i, o)| *o == i as i64) && *b.ty(src) == res_ty).then_some(Folded::Value(src))
            }
            _ => None,
        }
    }
}

/// splat 常量 i1 掩码的值。
fn const_mask(b: &Body<'_>, v: ValueId) -> Option<bool> {
    b.def_of(v, Kind::ArithConstant)?;
    let c = TtCanon::splat_const(b, v)?;
    match c.values.first()? {
        Scalar::Int(i) => Some(!i.is_zero()),
        Scalar::Float(_) => None,
    }
}

/// `load(ptr, splat(1), …)` ⇒ `load(ptr, …)`；`load(ptr, splat(0), other, …)` ⇒ `other`。
struct MaskedLoad;

impl Pattern for MaskedLoad {
    fn name(&self) -> &str {
        "CanonicalizeMaskedLoadPattern"
    }

    fn root(&self) -> Option<&str> {
        Some(Kind::TtLoad.name())
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        if b[op].operands.len() < 2 {
            return false;
        }
        let Some(m) = const_mask(b, b.opd(op, 1)) else { return false };
        if m {
            let ptr = b.opd(op, 0);
            let ty = b.ty(b.res(op, 0)).clone();
            let mut d = OpData::build(Kind::TtLoad.name()).operands(&[ptr]);
            for name in ["boundaryCheck", "padding", "cache", "evict", "isVolatile"] {
                if let Some(a) = b[op].get(name) {
                    d.set(name, a.clone());
                }
            }
            d.set("operandSegmentSizes", crate::ir::dense_i32(&[1, 0, 0]));
            d.loc.clone_from(&b[op].loc);
            rw.replace_with(op, d, &[ty]);
            true
        } else {
            if b[op].operands.len() < 3 {
                return false;
            }
            let other = b.opd(op, 2);
            rw.replace_op(op, &[other]);
            true
        }
    }
}

/// `store(ptr, v, splat(1), …)` ⇒ `store(ptr, v, …)`；`store(ptr, v, splat(0), …)` ⇒ 删掉。
struct MaskedStore;

impl Pattern for MaskedStore {
    fn name(&self) -> &str {
        "CanonicalizeMaskedStorePattern"
    }

    fn root(&self) -> Option<&str> {
        Some(Kind::TtStore.name())
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        if b[op].operands.len() < 3 {
            return false;
        }
        let Some(m) = const_mask(b, b.opd(op, 2)) else { return false };
        if m {
            let (ptr, v) = (b.opd(op, 0), b.opd(op, 1));
            // 照 `StoreOp::build(ptr, value, cache, evict)`：boundaryCheck 回到缺省（空）
            let mut d = OpData::build(Kind::TtStore.name()).operands(&[ptr, v]).with("boundaryCheck", crate::ir::dense_i32(&[]));
            for name in ["cache", "evict"] {
                if let Some(a) = b[op].get(name) {
                    d.set(name, a.clone());
                }
            }
            d.loc.clone_from(&b[op].loc);
            rw.replace_with(op, d, &[]);
        } else {
            rw.erase_op(op);
        }
        true
    }
}

/// `broadcast(splat(x))` ⇒ `splat(x)`。
struct BroadcastSplat;

impl Pattern for BroadcastSplat {
    fn name(&self) -> &str {
        "BroadcastSplatPattern"
    }

    fn root(&self) -> Option<&str> {
        Some(Kind::TtBroadcast.name())
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let Some(s) = b.def_of(b.opd(op, 0), Kind::TtSplat) else { return false };
        let x = b.opd(s, 0);
        let ty = b.ty(b.res(op, 0)).clone();
        let mut d = OpData::build(Kind::TtSplat.name()).operands(&[x]);
        d.loc.clone_from(&b[op].loc);
        rw.replace_with(op, d, &[ty]);
        true
    }
}

/// `broadcast(broadcast(x))` ⇒ `broadcast(x)`。
struct BroadcastBroadcast;

impl Pattern for BroadcastBroadcast {
    fn name(&self) -> &str {
        "BroadcastBroadcastPattern"
    }

    fn root(&self) -> Option<&str> {
        Some(Kind::TtBroadcast.name())
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let Some(inner) = b.def_of(b.opd(op, 0), Kind::TtBroadcast) else { return false };
        let x = b.opd(inner, 0);
        let ty = b.ty(b.res(op, 0)).clone();
        let mut d = OpData::build(Kind::TtBroadcast.name()).operands(&[x]);
        d.loc.clone_from(&b[op].loc);
        rw.replace_with(op, d, &[ty]);
        true
    }
}

/// `ReshapeOp::canonicalize`：reshape(reshape) ⇒ reshape（任一许重排就许）；reshape(splat) ⇒ splat。
struct ReshapeCanon;

impl Pattern for ReshapeCanon {
    fn name(&self) -> &str {
        "ReshapeOp::canonicalize"
    }

    fn root(&self) -> Option<&str> {
        Some(Kind::TtReshape.name())
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        if b[op].get("efficient_layout").is_some() {
            return false;
        }
        let src = b.opd(op, 0);
        let ty = b.ty(b.res(op, 0)).clone();
        let loc = b[op].loc.clone();
        if let Some(parent) = b.def_of(src, Kind::TtReshape) {
            let reorder = b[op].get("allow_reorder").is_some() || b[parent].get("allow_reorder").is_some();
            let mut d = OpData::build(Kind::TtReshape.name()).operands(&[b.opd(parent, 0)]);
            if reorder {
                d.set("allow_reorder", Attribute::Unit);
            }
            d.loc = loc;
            rw.replace_with(op, d, &[ty]);
            return true;
        }
        if let Some(s) = b.def_of(src, Kind::TtSplat) {
            let mut d = OpData::build(Kind::TtSplat.name()).operands(&[b.opd(s, 0)]);
            d.loc = loc;
            rw.replace_with(op, d, &[ty]);
            return true;
        }
        false
    }
}

/// `ExpandDimsOp::canonicalize`。
pub struct ExpandDimsCanon;

#[mlirpass::patterns]
impl ExpandDimsCanon {
    /// expand_dims(splat x) ⇒ splat x；expand_dims(broadcast x) ⇒ broadcast(expand_dims x)。
    #[rewrite("tt.expand_dims")]
    fn expand_dims_of_splat_or_broadcast(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let src = b.opd(op, 0);
        let Some(def) = b.def_op(src) else { return false };
        let rt = b.ty(b.res(op, 0)).clone();
        if b.is(def, Kind::TtSplat) {
            let x = b.opd(def, 0);
            rw.replace_with(op, OpData::build(Kind::TtSplat.name()).operands(&[x]), &[rt]);
            return true;
        }
        if b.is(def, Kind::TtBroadcast) {
            let x = b.opd(def, 0);
            let xt = b.ty(x).clone();
            let axis = b.int_attr(op, "axis").unwrap_or(0) as usize;
            let mut shape = xt.dims().unwrap_or_default();
            shape.insert(axis, 1);
            let et = Type::tensor(&shape, xt.element_type().clone());
            let attr = b[op].get("axis").cloned().expect("axis");
            let bloc = b[def].loc.clone();
            rw.set_before(op);
            let e = rw.create(OpData::build(Kind::TtExpandDims.name()).operands(&[x]).with("axis", attr), &[et]);
            let ev = rw.body.res(e, 0);
            let mut d = OpData::build(Kind::TtBroadcast.name()).operands(&[ev]);
            d.loc = bloc;
            let nb = rw.create(d, &[rt]);
            let nv = rw.body.res(nb, 0);
            rw.replace_op(op, &[nv]);
            return true;
        }
        false
    }
}
