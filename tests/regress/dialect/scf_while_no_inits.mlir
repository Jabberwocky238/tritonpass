// 没有携带值的 scf.while：MLIR 不印初值表，写成 `scf.while : () -> () {`（`printInitializationList` 在没有初值时什么也不印）。
// Triton 教程 05-layer-norm 的自旋锁 `while tl.atomic_cas(Lock, 0, 1) == 1: pass` 就是这个样子；原先读不进。
// 只读入、印出：流水线里放一个对这份输入什么也不做的 pass（tritonpass 不认空的 `builtin.module()`）。
// RUN: dope-opt %s --pass-pipeline='builtin.module(reconcile-unrealized-casts)'
module {
  tt.func public @spin_lock(%lock: !tt.ptr<i32>, %count: !tt.ptr<i32>) {
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    scf.while : () -> () {
      %old = tt.atomic_cas acq_rel, gpu, %lock, %c0_i32, %c1_i32 : (!tt.ptr<i32>, i32, i32) -> i32
      %busy = arith.cmpi eq, %old, %c1_i32 : i32
      scf.condition(%busy)
    } do {
      scf.yield
    } attributes {tt.note = 1 : i32}
    %n = scf.while : () -> i32 {
      %v = tt.atomic_rmw add, acq_rel, gpu, %count, %c1_i32 : (!tt.ptr<i32>, i32) -> i32
      %more = arith.cmpi slt, %v, %c1_i32 : i32
      scf.condition(%more) %v : i32
    } do {
    ^bb0(%v: i32):
      scf.yield
    }
    tt.store %count, %n : !tt.ptr<i32>
    tt.return
  }
}
