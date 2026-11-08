//! 循环的三个规范化：`triton-loop-lower-bound-zero`（`LoopLowerBoundZero.cpp`）、`triton-normalize-loop-index`
//! （`NormalizeLoopIndex.cpp`）与 `triton-loop-unit-step`（`LoopUnitStep.cpp`）。都新建一个 scf.for、把旧循环体整段搬进去（不克隆），
//! 旧归纳变量换成新的派生值。
//!
//! - lower-bound-zero：体里（含嵌套）有 tt.dot、步长是常量 1、下界不是常量 0 的循环改写成下界为 0、上界为 `ub - lb`，
//!   体里用 `j' + lb`（有的后端不收运行期下界的循环）。别的循环不动。
//! - normalize-loop-index：上下界、步长与归纳变量统一转成 index（合同 N11），体里用 `index_cast(新归纳变量)` 当原来的 i32。
//! - loop-unit-step：上界是运行期值、步长是常量且大于 1 的 index 循环（归约 kernel 按块扫一行：`range(0, N, TILE)`）改成
//!   `range(0, (ub - lb + step - 1) / step)`，体里用 `lb + j * step`（有的后端对运行期上界的循环要步长 1）。轮数与每轮的值都不变，
//!   ub 不超过 lb 时轮数非正、一轮不跑；上界是常数的不动（后端自己展开）。放在分配缓冲与访问摘要之后：摘要的区间求值认原来的
//!   归纳变量区间，换成除法之后丢精度。
use mlirformat::{Error, Type};
use mlirpass::{Body, OpId, PatternSet, Rewriter, ValueId, pass, patterns};

use crate::ir::{TtBuilder, integer};
use crate::{Ir, Kind};

/// 三条循环改写，各一个 pass：新建 scf.for、把旧循环体整段搬进去（`inlineBlockBefore`），旧归纳变量换成新的派生值。
pub struct LoopRules;

#[patterns]
impl LoopRules {
    /// 体里（含嵌套）有 tt.dot、步长常量 1、下界不是常量 0 的整数循环 ⇒ `for j' in [0, ub - lb)`，体里用 `j' + lb`。
    #[rewrite("scf.for")]
    fn shift_to_zero(rw: &mut Rewriter<'_, '_>, l: OpId) -> bool {
        let b = &*rw.body;
        if b.const_int(b.opd(l, 2)) != Some(1) || b.const_int(b.opd(l, 0)) == Some(0) {
            return false;
        }
        let iv = b[b.entry(l, 0)].args[0];
        if !matches!(b.ty(iv), Type::Integer { .. }) || !b.ops_in(l).iter().any(|o| b.is(*o, Kind::TtDot)) {
            return false;
        }
        let (lb, ub, step) = (b.opd(l, 0), b.opd(l, 1), b.opd(l, 2));
        let inits = b[l].operands[3..].to_vec();
        let ty = b.ty(iv).clone();
        let width = ty.int_width().map_or(32, |(w, _)| w);
        rw.set_before(l);
        let zero = rw.scalar(integer(width, 0), ty);
        let span = rw.binary(Kind::ArithSubi, ub, lb);
        let (new, block) = rw.for_loop(zero, span, step, &inits);
        rw.set_end(block);
        let iv0 = rw.body[block].args[0];
        let shifted = rw.binary(Kind::ArithAddi, iv0, lb);
        Self::finish(rw, l, new, block, shifted);
        true
    }

    /// 上下界、步长与归纳变量不是 index 的循环 ⇒ 统一转成 index（合同 N11），体里用 `index_cast(新归纳变量)`。
    #[rewrite("scf.for")]
    fn to_index(rw: &mut Rewriter<'_, '_>, l: OpId) -> bool {
        let b = &*rw.body;
        let iv_ty = b.ty(b[b.entry(l, 0)].args[0]).clone();
        if matches!(iv_ty, Type::Index) {
            return false;
        }
        let inits = b[l].operands[3..].to_vec();
        let (lb, ub, step) = (b.opd(l, 0), b.opd(l, 1), b.opd(l, 2));
        rw.set_before(l);
        let cast = |rw: &mut Rewriter<'_, '_>, v: ValueId| if matches!(rw.body.ty(v), Type::Index) { v } else { rw.value(Kind::ArithIndexCast, &[v], Type::Index) };
        let (lb, ub, step) = (cast(rw, lb), cast(rw, ub), cast(rw, step));
        let (new, block) = rw.for_loop(lb, ub, step, &inits);
        rw.set_end(block);
        let iv0 = rw.body[block].args[0];
        let back = rw.value(Kind::ArithIndexCast, &[iv0], iv_ty);
        Self::finish(rw, l, new, block, back);
        true
    }

    /// 上界是运行期值、步长常量 > 1 的 index 循环 ⇒ `for j in [0, (ub - lb + step - 1) / step)`，体里用 `lb + j * step`。
    #[rewrite("scf.for")]
    fn unit_step(rw: &mut Rewriter<'_, '_>, l: OpId) -> bool {
        let b = &*rw.body;
        if !matches!(b.ty(b[b.entry(l, 0)].args[0]), Type::Index) || b.const_int(b.opd(l, 1)).is_some() {
            return false;
        }
        let Some(k) = b.const_int(b.opd(l, 2)).filter(|s| *s > 1) else { return false };
        let (lb, ub, step) = (b.opd(l, 0), b.opd(l, 1), b.opd(l, 2));
        let inits = b[l].operands[3..].to_vec();
        rw.set_before(l);
        let zero = rw.scalar(integer(64, 0), Type::Index);
        let one = rw.scalar(integer(64, 1), Type::Index);
        let rounding = rw.scalar(integer(64, k - 1), Type::Index);
        let span = rw.binary(Kind::ArithSubi, ub, lb);
        let rounded = rw.binary(Kind::ArithAddi, span, rounding);
        let trips = rw.binary(Kind::ArithDivsi, rounded, step);
        let (new, block) = rw.for_loop(zero, trips, one, &inits);
        rw.set_end(block);
        let j = rw.body[block].args[0];
        let scaled = rw.binary(Kind::ArithMuli, j, step);
        let shifted = rw.binary(Kind::ArithAddi, scaled, lb);
        Self::finish(rw, l, new, block, shifted);
        true
    }
}

impl LoopRules {
    /// 旧体整段搬进新循环（旧归纳变量换成 `iv`，携带值换成新块参数），旧循环换成新循环的结果。
    fn finish(rw: &mut Rewriter<'_, '_>, old: OpId, new: OpId, new_block: mlirpass::BlockId, iv: ValueId) {
        let old_block = rw.body.entry(old, 0);
        let mut args = vec![iv];
        args.extend(rw.body[new_block].args[1..].iter().copied());
        rw.inline_block_before(old_block, new_block, None, &args);
        let results = rw.body[new].results.to_vec();
        rw.replace_op(old, &results);
    }

    fn run(body: &mut Body<'_>, op: OpId, add: fn(&mut PatternSet)) {
        let mut set = PatternSet::default();
        add(&mut set);
        body.walk_and_apply(op, &set);
    }
}

#[pass("triton-loop-lower-bound-zero", on = "builtin.module", ty = LoopLowerBoundZero)]
pub fn loop_lower_bound_zero<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    LoopRules::run(body, op, |s| {
        s.add(ShiftToZero);
    });
    Ok(())
}

#[pass("triton-normalize-loop-index", on = "builtin.module", ty = NormalizeLoopIndex)]
pub fn normalize_loop_index<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    LoopRules::run(body, op, |s| {
        s.add(ToIndex);
    });
    Ok(())
}

#[pass("triton-loop-unit-step", on = "builtin.module", ty = LoopUnitStep)]
pub fn loop_unit_step<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    LoopRules::run(body, op, |s| {
        s.add(UnitStep);
    });
    Ok(())
}
