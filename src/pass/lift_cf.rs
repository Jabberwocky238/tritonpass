//! `triton-lift-cf-to-scf`（`LiftCfToScf.cpp`）与 `triton-drop-dead-exit-switch`（`DropDeadExitSwitch.cpp`）。
//!
//! 多块的 tt.func（cf 分支，常见写法是复合布尔条件的早退）结构化成单块、用 scf.if 表达分支；只在完全成功（一个 cf.* 都不剩）
//! 时才留下结果，否则回滚、原样留给 P0 按「函数体必须单块」点名拒收。C++ 原版借一个临时 func.func 跑上游原版 pass
//! （上游写死了 func.return）；这里直接在 tt.func 上跑移植来的同一个算法（[`CfgToScf`]），用检查点回滚代替副本。
//!
//! 多出口的 tt.func 结构化之后，末尾留下纯选择器的死链（零结果、分支皆空的 scf.index_switch，喂给它的 scf.if、
//! index_castui）：`triton-drop-dead-exit-switch` 只清这一条特定的链（⛔ 通用 canonicalize：会连带吃掉本该被 P0 点名的死值）。
use mlirformat::Error;
use mlirpass::{Body, OpData, OpId, pass};

use super::cfg_to_scf::{CfgToScf, Lift};
use crate::{Ir, Kind};

#[pass("triton-lift-cf-to-scf", on = "builtin.module", ty = LiftCfToScf)]
pub fn lift_cf_to_scf<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let funcs: Vec<OpId> = body.ops_in(op).into_iter().filter(|o| body.is(*o, Kind::TtFunc) && body[body[*o].regions[0]].blocks.len() > 1).collect();
    for f in funcs {
        let cp = body.checkpoint();
        let region = body[f].regions[0];
        let lifted = CfgToScf::run(body, region) == Lift::Done && !body.ops_in(f).iter().any(|o| matches!(body.kind(*o), Some(Kind::CfBr | Kind::CfCondBr | Kind::CfSwitch)));
        if lifted {
            body.release(cp);
        } else {
            body.rollback(cp);
        }
    }
    Ok(())
}

#[pass("triton-drop-dead-exit-switch", on = "builtin.module", ty = DropDeadExitSwitch)]
pub fn drop_dead_exit_switch<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut changed = true;
    while changed {
        changed = false;
        let candidates: Vec<OpId> = body.ops_in(op).into_iter().filter(|o| matches!(body.kind(*o), Some(Kind::ScfIndexSwitch | Kind::ScfIf | Kind::ArithIndexCastui | Kind::ArithIndexCast))).collect();
        // 内层先处理：先序收集、逆序处理
        for o in candidates.into_iter().rev() {
            if body[o].parent.is_none() {
                continue;
            }
            changed |= match body.kind(o) {
                Some(Kind::ScfIndexSwitch) => DeadExit::switch(body, o),
                Some(Kind::ScfIf) => DeadExit::unused_if(body, o),
                _ => DeadExit::cast(body, o),
            };
        }
    }
    Ok(())
}

struct DeadExit;

impl DeadExit {
    /// 区域「纯空」：只有一条不带操作数的 scf.yield。
    fn trivial(body: &Body<'_>, r: mlirpass::RegionId) -> bool {
        let b = body[r].blocks[0];
        let ops = &body.block_ops(b);
        ops.len() == 1 && body.is(ops[0], Kind::ScfYield) && body[ops[0]].operands.is_empty()
    }

    fn switch(body: &mut Body<'_>, op: OpId) -> bool {
        if !body[op].results.is_empty() || !body[op].regions.iter().all(|r| Self::trivial(body, *r)) {
            return false;
        }
        body.erase(op);
        true
    }

    /// 有结果但一个都没人用的 scf.if：重建成零结果的（两支原样搬过去，各自的 yield 清空操作数）。
    fn unused_if(body: &mut Body<'_>, op: OpId) -> bool {
        if body[op].results.is_empty() || body[op].results.iter().any(|r| !body[*r].uses.is_empty()) {
            return false;
        }
        let mut d = OpData::build(Kind::ScfIf.name()).operands(&[body.opd(op, 0)]);
        d.loc.clone_from(&body[op].loc);
        let new = body.create(d, &[]);
        body.insert_before(new, op);
        for r in body[op].regions.clone() {
            let target = body.add_region(new);
            for b in body.blocks(r) {
                body.remove_block(b);
                let at = body[target].blocks.len();
                body.region_insert(target, at, b);
                body[b].parent = Some(target);
                if let Some(y) = body.terminator(b).filter(|y| body.is(*y, Kind::ScfYield)) {
                    body.set_operands(y, Vec::new());
                }
            }
        }
        body.erase(op);
        true
    }

    fn cast(body: &mut Body<'_>, op: OpId) -> bool {
        if !body[body.res(op, 0)].uses.is_empty() {
            return false;
        }
        body.erase(op);
        true
    }
}
