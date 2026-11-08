//! 指针的两个改写：`triton-lower-bool-ptr`（`BoolPtr.cpp`）与 `triton-scalar-ptr`（`ScalarPtr.cpp`）。
//!
//! - lower-bool-ptr：bool 缓冲按 i8 交出。所有 `!tt.ptr<i1>`（标量指针与指针张量的元素）换成 `!tt.ptr<i8>`（入口参数、
//!   函数类型、各 op 的结果），i1 到 i8 的 tt.bitcast 随之成了恒等、去掉。P0 已经保证 i1 指针只经 tt.bitcast 使用。
//! - scalar-ptr：入口指针加一串标量 tt.addptr 偏移的标量写（无 mask）直接落成 1 个元素的结构化写（`tts.make_tptr` 加
//!   `tts.store`）——P2 只登记经过 tt.addptr 的指针，裸指针的写会一路留到 P6。只转写、只转无 mask 的、只转根是入口指针参数的。
use mlirformat::{Attribute, Error, FunctionType, Type};
use mlirpass::{Body, Def, OpData, OpId, ValueId, pass};

use crate::ir::{Cursor, Ofr, dense_i64};
use crate::{Ir, Kind, pointee};

#[pass("triton-lower-bool-ptr", on = "builtin.module", ty = LowerBoolPtr)]
pub fn lower_bool_ptr<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let top = body.top_block(op);
    let funcs: Vec<OpId> = body.ops(top).filter(|f| body.is(*f, Kind::TtFunc)).collect();
    for f in funcs {
        let Some(Attribute::Type(Type::Function(ft))) = body[f].get("function_type").cloned() else { continue };
        let mut inputs = ft.inputs.clone();
        let mut changed = false;
        for (i, t) in ft.inputs.iter().enumerate() {
            if let Some(u) = BoolPtr::to_i8(t) {
                inputs[i] = u.clone();
                changed = true;
                if !body[body[f].regions[0]].blocks.is_empty() {
                    let a = body[body.entry(f, 0)].args[i];
                    body[a].ty = u;
                }
            }
        }
        if changed {
            body[f].set("function_type", Attribute::Type(Type::Function(FunctionType { inputs, results: ft.results.clone() })));
        }
        for o in body.ops_in(f) {
            for r in body[o].results.clone() {
                if let Some(u) = BoolPtr::to_i8(body.ty(r)) {
                    body[r].ty = u;
                }
            }
        }
        let casts: Vec<OpId> = body.ops_in(f).into_iter().filter(|o| body.is(*o, Kind::TtBitcast)).collect();
        for c in casts {
            if body.ty(body.opd(c, 0)) == body.ty(body.res(c, 0)) {
                let src = body.opd(c, 0);
                body.replace_op(c, &[src]);
            }
        }
    }
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
        let ptr = Type::Extended(mlirformat::Extended { name: x.name.clone(), body: Some(new_body.into()), params: Vec::new() });
        Some(match t {
            Type::Shaped(_) => t.with_element(ptr),
            _ => ptr,
        })
    }
}

#[pass("triton-scalar-ptr", on = "builtin.module", ty = ScalarPtr)]
pub fn scalar_ptr<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut stores = Vec::new();
    body.walk_post(op, &mut |s| {
        if body.is(s, Kind::TtStore) && !matches!(body.ty(body.opd(s, 0)), Type::Shaped(_)) && matches!(body.ty(body.opd(s, 0)), Type::Extended(_)) && !matches!(body.ty(body.opd(s, 1)), Type::Shaped(_)) && body[s].operands.len() == 2 {
            stores.push(s);
        }
    });
    for s in stores {
        ScalarStore::rewrite(body, s);
    }
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

    fn rewrite(b: &mut Body<'_>, s: OpId) {
        let Some((root, offsets)) = Self::chain(b, b.opd(s, 0)) else { return };
        let value = b.opd(s, 1);
        let mut c = Cursor::before(b, s);
        let mut total: Option<ValueId> = None;
        for &seg in offsets.iter().rev() {
            let idx = c.value(Kind::ArithIndexCast, &[seg], Type::Index);
            total = Some(match total {
                None => idx,
                Some(t) => c.binary(Kind::ArithAddi, t, idx),
            });
        }
        let offset = total.map_or(Ofr::C(0), Ofr::V);
        let root_ty = c.body.ty(root).clone();
        let ptr_ty = Type::tensor(&[1], root_ty);
        let ptr = c.make_tptr(root, &[1], &[Ofr::C(1)], &[offset], &[Ofr::C(0)], &[], ptr_ty);
        let vty = Type::tensor(&[1], c.body.ty(value).clone());
        let tensor = c.value(Kind::TtSplat, &[value], vty);
        c.create(OpData::build(Kind::TtsStore.name()).operands(&[ptr, tensor]).with("static_mask_dims", dense_i64(&[])), &[]);
        b.erase(s);
    }
}
