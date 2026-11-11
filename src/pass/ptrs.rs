//! 指针的两个改写：`triton-lower-bool-ptr`（`BoolPtr.cpp`）与 `triton-scalar-ptr`（`ScalarPtr.cpp`）。
//!
//! - lower-bool-ptr：bool 缓冲按 i8 交出。所有 `!tt.ptr<i1>`（标量指针与指针张量的元素）换成 `!tt.ptr<i8>`（入口参数、
//!   函数类型、各 op 的结果），i1 到 i8 的 tt.bitcast 随之成了恒等、去掉。P0 已经保证 i1 指针只经 tt.bitcast 使用。
//! - scalar-ptr：入口指针加一串标量 tt.addptr 偏移的标量写（无 mask）直接落成 1 个元素的结构化写（`tts.make_tptr` 加
//!   `tts.store`）——P2 只登记经过 tt.addptr 的指针，裸指针的写会一路留到 P6。只转写、只转无 mask 的、只转根是入口指针参数的。
use mlirformat::{Attribute, Error, FunctionType, Type};
use mlirpass::{Body, Def, OpData, OpId, PatternSet, Rewriter, ValueId, pass, patterns};

use crate::ir::{Ofr, TtBuilder, dense_i64};
use crate::{Ir, Kind, pointee};

/// bool 缓冲按 i8 交出：以 `tt.func` 为根，整个函数一次改完（入口参数、函数类型、各 op 的结果，再去掉成了恒等的 tt.bitcast）。
pub struct LowerBoolPtrRules;

#[patterns]
impl LowerBoolPtrRules {
    #[rewrite("tt.func")]
    fn bool_ptr_to_i8(rw: &mut Rewriter<'_, '_>, f: OpId) -> bool {
        let Some(Attribute::Type(Type::Function(ft))) = rw.body[f].get("function_type").cloned() else { return false };
        let mut inputs = ft.inputs.clone();
        let mut changed = false;
        for (i, t) in ft.inputs.iter().enumerate() {
            if let Some(u) = BoolPtr::to_i8(t) {
                inputs[i] = u.clone();
                changed = true;
                if !rw.body[rw.body[f].regions[0]].blocks.is_empty() {
                    let a = rw.body[rw.body.entry(f, 0)].args[i];
                    rw.body[a].ty = u;
                }
            }
        }
        if changed {
            rw.modify(f, |b| b[f].set("function_type", Attribute::Type(Type::Function(Box::new(FunctionType { inputs, results: ft.results.clone() })))));
        }
        for o in rw.body.ops_in(f) {
            for r in rw.body[o].results.clone() {
                if let Some(u) = BoolPtr::to_i8(rw.body.ty(r)) {
                    rw.modify(o, |b| b[r].ty = u);
                    changed = true;
                }
            }
        }
        let casts: Vec<OpId> = rw.body.ops_in(f).into_iter().filter(|o| rw.body.is(*o, Kind::TtBitcast)).collect();
        for c in casts {
            if rw.body.ty(rw.body.opd(c, 0)) == rw.body.ty(rw.body.res(c, 0)) {
                let src = rw.body.opd(c, 0);
                rw.replace_op(c, &[src]);
                changed = true;
            }
        }
        changed
    }
}

#[pass("triton-lower-bool-ptr", on = "builtin.module", ty = LowerBoolPtr)]
pub fn lower_bool_ptr<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut set = PatternSet::default();
    LowerBoolPtrRules::patterns(&mut set);
    body.walk_and_apply(op, &set);
    Ok(())
}

struct BoolPtr;

impl BoolPtr {
    /// 类型里的 `!tt.ptr<i1>` 换成 `!tt.ptr<i8>`；没有就 `None`。
    fn to_i8<'a>(t: &Type<'a>) -> Option<Type<'a>> {
        let e = t.element_type();
        let Type::Extended(x) = e else { return None };
        if x.name != "tt.ptr" || !matches!(pointee(e), Type::Integer { width: 1, .. }) {
            return None;
        }
        // `!tt.ptr<i1>` / `!tt.ptr<i1, 地址空间>`：换掉第一个参数
        let body = x.body.as_deref().unwrap_or("<i1>");
        let new_body = body.replacen("i1", "i8", 1);
        let ptr = Type::Extended(Box::new(mlirformat::Extended { name: x.name.clone(), body: Some(new_body.into()), params: Vec::new() }));
        Some(match t {
            Type::Shaped(_) => t.with_element(ptr),
            _ => ptr,
        })
    }
}

#[pass("triton-scalar-ptr", on = "builtin.module", ty = ScalarPtr)]
pub fn scalar_ptr<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut set = PatternSet::default();
    ScalarStore::patterns(&mut set);
    body.walk_and_apply(op, &set);
    Ok(())
}

struct ScalarStore;

impl ScalarStore {
    fn entry_argument(b: &Body<'_>, v: ValueId) -> bool {
        let Def::Arg(blk, _) = b[v].def else { return false };
        b.block_owner(blk).is_some_and(|f| b.is(f, Kind::TtFunc) && b.entry(f, 0) == blk)
    }

    /// 沿标量 tt.addptr 链走回入口的指针实参；每段偏移都是整数、根是入口指针实参才成功。偏移从靠近这次写的一段起。
    fn chain(b: &Body<'_>, mut ptr: ValueId) -> Option<(ValueId, Vec<ValueId>)> {
        let mut offsets = Vec::new();
        while let Some(add) = b.def_of(ptr, Kind::TtAddptr) {
            if !matches!(b.ty(b.opd(add, 1)), Type::Integer { .. }) {
                return None;
            }
            offsets.push(b.opd(add, 1));
            ptr = b.opd(add, 0);
        }
        Self::entry_argument(b, ptr).then_some((ptr, offsets))
    }

}

#[patterns]
impl ScalarStore {
    /// 入口指针加一串标量 tt.addptr 偏移、无 mask 的标量写 ⇒ 1 个元素的 `tts.make_tptr` + `tts.store`。
    #[rewrite("tt.store")]
    fn store_as_window(rw: &mut Rewriter<'_, '_>, s: OpId) -> bool {
        let b = &*rw.body;
        let plain = !matches!(b.ty(b.opd(s, 0)), Type::Shaped(_)) && matches!(b.ty(b.opd(s, 0)), Type::Extended(_)) && !matches!(b.ty(b.opd(s, 1)), Type::Shaped(_)) && b[s].operands.len() == 2;
        if !plain {
            return false;
        }
        let Some((root, offsets)) = Self::chain(b, b.opd(s, 0)) else { return false };
        let value = b.opd(s, 1);
        rw.set_before(s);
        let mut total: Option<ValueId> = None;
        for &seg in offsets.iter().rev() {
            let idx = rw.value(Kind::ArithIndexCast, &[seg], Type::Index);
            total = Some(match total {
                None => idx,
                Some(t) => rw.binary(Kind::ArithAddi, t, idx),
            });
        }
        let offset = total.map_or(Ofr::C(0), Ofr::V);
        let root_ty = rw.body.ty(root).clone();
        let ptr_ty = Type::tensor(&[1], root_ty);
        let ptr = rw.make_tptr(root, &[1], &[Ofr::C(1)], &[offset], &[Ofr::C(0)], &[], ptr_ty);
        let vty = Type::tensor(&[1], rw.body.ty(value).clone());
        let tensor = rw.value(Kind::TtSplat, &[value], vty);
        rw.create(OpData::build(Kind::TtsStore.name()).operands(&[ptr, tensor]).with("static_mask_dims", dense_i64(&[])), &[]);
        rw.erase_op(s);
        true
    }
}
