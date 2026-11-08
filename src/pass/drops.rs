//! 三个只擦 op 的 pass：`triton-drop-thread-barrier`（`ttg.barrier`：program 内没有线程级并行，可能重叠的全局读写由后端按访问
//! 范围排令牌）、`triton-drop-assume`（`llvm.intr.assume`，tl.assume 的降级形态）。
use mlirformat::Error;
use mlirpass::{Body, OpId, pass};

use crate::{Ir, Kind};

fn erase_all(body: &mut Body<'_>, root: OpId, k: Kind) {
    let ops: Vec<OpId> = body.ops_in(root).into_iter().filter(|o| body.is(*o, k)).collect();
    for o in ops {
        body.erase(o);
    }
}

#[pass("triton-drop-thread-barrier", on = "builtin.module", ty = DropThreadBarrier)]
pub fn drop_thread_barrier<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    erase_all(body, op, Kind::TtgBarrier);
    Ok(())
}

#[pass("triton-drop-assume", on = "builtin.module", ty = DropAssume)]
pub fn drop_assume<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    erase_all(body, op, Kind::LlvmIntrAssume);
    Ok(())
}
