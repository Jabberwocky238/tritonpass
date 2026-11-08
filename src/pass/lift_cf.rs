//! `triton-lift-cf-to-scf`（`LiftCfToScf.cpp`）与 `triton-drop-dead-exit-switch`（`DropDeadExitSwitch.cpp`）。
//!
//! 多块的 tt.func（cf 分支，常见写法是复合布尔条件的早退）结构化成单块、用 scf.if 表达分支；只在完全成功（一个 cf.* 都不剩）
//! 时才留下结果，否则回滚、原样留给 P0 按「函数体必须单块」点名拒收。C++ 原版借一个临时 func.func 跑上游原版 pass
//! （上游写死了 func.return）；这里直接在 tt.func 上跑移植来的同一个算法（[`CfgToScf`]），用检查点回滚代替副本。
//!
//! 多出口的 tt.func 结构化之后，末尾留下纯选择器的死链（零结果、分支皆空的 scf.index_switch，喂给它的 scf.if、
//! index_castui）：`triton-drop-dead-exit-switch` 只清这一条特定的链（⛔ 通用 canonicalize：会连带吃掉本该被 P0 点名的死值）。
use mlirformat::Error;
use mlirpass::{Body, OpData, OpId, PatternSet, Rewriter, pass, patterns};

use super::cfg_to_scf::{CfgToScf, Lift};
use crate::{Ir, Kind};

/// 多块的 tt.func 结构化成单块：只在完全成功（一个 cf.* 都不剩）时留下，否则回滚到改写之前。
pub struct LiftRules;

#[patterns]
impl LiftRules {
    #[rewrite("tt.func")]
    fn lift_function(rw: &mut Rewriter<'_, '_>, f: OpId) -> bool {
        let region = rw.body[f].regions[0];
        if rw.body[region].blocks.len() <= 1 {
            return false;
        }
        let cp = rw.body.checkpoint();
        let lifted = CfgToScf::run(rw.body, region) == Lift::Done && !rw.body.ops_in(f).iter().any(|o| matches!(rw.body.kind(*o), Some(Kind::CfBr | Kind::CfCondBr | Kind::CfSwitch)));
        if lifted {
            rw.body.release(cp);
            rw.modify(f, |_| {});
        } else {
            rw.body.rollback(cp);
        }
        lifted
    }
}

#[pass("triton-lift-cf-to-scf", on = "builtin.module", ty = LiftCfToScf)]
pub fn lift_cf_to_scf<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut set = PatternSet::default();
    LiftRules::patterns(&mut set);
    body.walk_and_apply(op, &set);
    Ok(())
}

/// 结构化之后末尾留下的纯选择器死链：零结果、分支皆空的 scf.index_switch，喂给它的、结果没人用的 scf.if，没人用的
/// index_cast(ui)。只认这几种（⛔ 通用 canonicalize / greedy：greedy 会顺手删别的死值），反复走到没有一条再命中为止。
pub struct DeadExit;

#[patterns]
impl DeadExit {
    #[rewrite("scf.index_switch")]
    fn empty_switch(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        if !rw.body[op].results.is_empty() || !rw.body[op].regions.iter().all(|r| Self::trivial(rw.body, *r)) {
            return false;
        }
        rw.erase_op(op);
        true
    }

    /// 有结果但一个都没人用的 scf.if：重建成零结果的（两支原样搬过去，各自的 yield 清空操作数）。
    #[rewrite("scf.if")]
    fn unused_if(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        if rw.body[op].results.is_empty() || rw.body[op].results.iter().any(|r| !rw.body[*r].uses.is_empty()) {
            return false;
        }
        let regions = rw.body[op].regions.clone();
        rw.set_before(op);
        let new = rw.create_with(OpData::build(Kind::ScfIf.name()).operands(&[rw.body.opd(op, 0)]), &[], |b, n| {
            for _ in &regions {
                b.add_region(n);
            }
        });
        for (from, into) in regions.iter().zip(rw.body[new].regions.clone()) {
            rw.inline_region_before(*from, into, None);
            for b in rw.body.blocks(into) {
                if let Some(y) = rw.body.terminator(b).filter(|y| rw.body.is(*y, Kind::ScfYield)) {
                    rw.modify(y, |body| body.set_operands(y, Vec::new()));
                }
            }
        }
        rw.erase_op(op);
        true
    }

    #[rewrite("arith.index_castui")]
    fn unused_index_castui(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::unused_cast(rw, op)
    }

    #[rewrite("arith.index_cast")]
    fn unused_index_cast(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::unused_cast(rw, op)
    }
}

impl DeadExit {
    /// 区域「纯空」：只有一条不带操作数的 scf.yield。
    fn trivial(body: &Body<'_>, r: mlirpass::RegionId) -> bool {
        let b = body[r].blocks[0];
        let ops = &body.block_ops(b);
        ops.len() == 1 && body.is(ops[0], Kind::ScfYield) && body[ops[0]].operands.is_empty()
    }

    fn unused_cast(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        if !rw.body[rw.body.res(op, 0)].uses.is_empty() {
            return false;
        }
        rw.erase_op(op);
        true
    }
}

#[pass("triton-drop-dead-exit-switch", on = "builtin.module", ty = DropDeadExitSwitch)]
pub fn drop_dead_exit_switch<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut set = PatternSet::default();
    DeadExit::patterns(&mut set);
    while body.walk_and_apply(op, &set) {}
    Ok(())
}
