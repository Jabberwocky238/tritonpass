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
use mlirpass::{Body, OpId, ValueId, pass};

use crate::ir::{Cursor, integer};
use crate::{Ir, Kind};

#[pass("triton-loop-lower-bound-zero", on = "builtin.module", ty = LoopLowerBoundZero)]
pub fn loop_lower_bound_zero<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut targets = Vec::new();
    body.walk_post(op, &mut |l| {
        if !body.is(l, Kind::ScfFor) || body.const_int(body.opd(l, 2)) != Some(1) || body.const_int(body.opd(l, 0)) == Some(0) {
            return;
        }
        let iv = body[body.entry(l, 0)].args[0];
        if matches!(body.ty(iv), Type::Integer { .. }) && body.ops_in(l).iter().any(|o| body.is(*o, Kind::TtDot)) {
            targets.push(l);
        }
    });
    for l in targets {
        Rebuild::shift_to_zero(body, l);
    }
    Ok(())
}

#[pass("triton-normalize-loop-index", on = "builtin.module", ty = NormalizeLoopIndex)]
pub fn normalize_loop_index<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut targets = Vec::new();
    body.walk_post(op, &mut |l| {
        if body.is(l, Kind::ScfFor) && !matches!(body.ty(body[body.entry(l, 0)].args[0]), Type::Index) {
            targets.push(l);
        }
    });
    for l in targets {
        Rebuild::to_index(body, l);
    }
    Ok(())
}

#[pass("triton-loop-unit-step", on = "builtin.module", ty = LoopUnitStep)]
pub fn loop_unit_step<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut targets = Vec::new();
    body.walk_post(op, &mut |l| {
        if !body.is(l, Kind::ScfFor) || !matches!(body.ty(body[body.entry(l, 0)].args[0]), Type::Index) {
            return;
        }
        if body.const_int(body.opd(l, 2)).is_some_and(|s| s > 1) && body.const_int(body.opd(l, 1)).is_none() {
            targets.push(l);
        }
    });
    for l in targets {
        Rebuild::unit_step(body, l);
    }
    Ok(())
}

/// 换一个新的 scf.for、搬旧循环体。
struct Rebuild;

impl Rebuild {
    /// 新循环建好之后：旧归纳变量的使用换成 `iv`（由 `bridge` 从新归纳变量派生），旧携带值换成新块参数，旧体整段搬过去。
    fn finish(b: &mut Body<'_>, old: OpId, new: OpId, new_block: mlirpass::BlockId, iv: ValueId) {
        let old_block = b.entry(old, 0);
        let old_args = b[old_block].args.to_vec();
        let new_args = b[new_block].args.to_vec();
        b.replace_all_uses(old_args[0], iv);
        for (o, n) in old_args.iter().zip(&new_args).skip(1) {
            b.replace_all_uses(*o, *n);
        }
        b.splice(old_block, None, new_block, None);
        let results = b[new].results.to_vec();
        b.replace_op(old, &results);
    }

    fn shift_to_zero(b: &mut Body<'_>, l: OpId) {
        let (lb, ub, step) = (b.opd(l, 0), b.opd(l, 1), b.opd(l, 2));
        let inits = b[l].operands[3..].to_vec();
        let ty = b.ty(b[b.entry(l, 0)].args[0]).clone();
        let width = ty.int_width().map_or(32, |(w, _)| w);
        let mut c = Cursor::before(b, l);
        let zero = c.constant(integer(width, 0), ty);
        let span = c.binary(Kind::ArithSubi, ub, lb);
        let (new, block) = c.for_loop(zero, span, step, &inits);
        let iv0 = c.body[block].args[0];
        let mut inner = Cursor::end(c.body, block, c.loc.clone());
        let shifted = inner.binary(Kind::ArithAddi, iv0, lb);
        Self::finish(b, l, new, block, shifted);
    }

    fn unit_step(b: &mut Body<'_>, l: OpId) {
        let (lb, ub, step) = (b.opd(l, 0), b.opd(l, 1), b.opd(l, 2));
        let k = b.const_int(step).expect("目标循环的步长是常量");
        let inits = b[l].operands[3..].to_vec();
        let mut c = Cursor::before(b, l);
        let zero = c.constant(integer(64, 0), Type::Index);
        let one = c.constant(integer(64, 1), Type::Index);
        let rounding = c.constant(integer(64, k - 1), Type::Index);
        let span = c.binary(Kind::ArithSubi, ub, lb);
        let rounded = c.binary(Kind::ArithAddi, span, rounding);
        let trips = c.binary(Kind::ArithDivsi, rounded, step);
        let (new, block) = c.for_loop(zero, trips, one, &inits);
        let j = c.body[block].args[0];
        let mut inner = Cursor::end(c.body, block, c.loc.clone());
        let scaled = inner.binary(Kind::ArithMuli, j, step);
        let shifted = inner.binary(Kind::ArithAddi, scaled, lb);
        Self::finish(b, l, new, block, shifted);
    }

    fn to_index(b: &mut Body<'_>, l: OpId) {
        let iv_ty = b.ty(b[b.entry(l, 0)].args[0]).clone();
        let inits = b[l].operands[3..].to_vec();
        let mut c = Cursor::before(b, l);
        let cast = |c: &mut Cursor<'_, '_>, v: ValueId| if matches!(c.body.ty(v), Type::Index) { v } else { c.value(Kind::ArithIndexCast, &[v], Type::Index) };
        let (lb, ub, step) = (c.body.opd(l, 0), c.body.opd(l, 1), c.body.opd(l, 2));
        let (lb, ub, step) = (cast(&mut c, lb), cast(&mut c, ub), cast(&mut c, step));
        let (new, block) = c.for_loop(lb, ub, step, &inits);
        let iv0 = c.body[block].args[0];
        let mut inner = Cursor::end(c.body, block, c.loc.clone());
        let back = inner.value(Kind::ArithIndexCast, &[iv0], iv_ty);
        Self::finish(b, l, new, block, back);
    }
}
