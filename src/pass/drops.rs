//! 两个只擦 op 的 pass：`triton-drop-thread-barrier`（`ttg.barrier`：program 内没有线程级并行，可能重叠的全局读写由后端按访问
//! 范围排令牌）、`triton-drop-assume`（`llvm.intr.assume`，tl.assume 的降级形态）。各是一条改写，一遍 walk 跑完。
use mlirformat::Error;
use mlirpass::{Body, OpId, PatternSet, Rewriter, pass, patterns};

/// 擦掉的 op 没有结果，擦了就是。
pub struct Drops;

#[patterns]
impl Drops {
    #[rewrite("ttg.barrier")]
    fn erase_thread_barrier(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        rw.erase_op(op);
        true
    }

    #[rewrite("llvm.intr.assume")]
    fn erase_assume(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        rw.erase_op(op);
        true
    }
}

impl Drops {
    fn run(body: &mut Body<'_>, op: OpId, add: fn(&mut PatternSet)) {
        let mut set = PatternSet::default();
        add(&mut set);
        body.walk_and_apply(op, &set);
    }
}

#[pass("triton-drop-thread-barrier", on = "builtin.module", ty = DropThreadBarrier)]
pub fn drop_thread_barrier<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    Drops::run(body, op, |s| {
        s.add(EraseThreadBarrier);
    });
    Ok(())
}

#[pass("triton-drop-assume", on = "builtin.module", ty = DropAssume)]
pub fn drop_assume<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    Drops::run(body, op, |s| {
        s.add(EraseAssume);
    });
    Ok(())
}
