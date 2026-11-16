// llvm.intr.assume 的 attr-dict 在类型之后（上游的 `$cond … : type($cond) attr-dict`）：带属性的写成 `llvm.intr.assume %c : i1 {…}`。
// 原先读、印都把 attr-dict 放在冒号之前，这样的写法读不进，印出来的 MLIR 也读不回。
// 只读入、印出：流水线里放一个对这份输入什么也不做的 pass（tritonpass 不认空的 `builtin.module()`）。
// RUN: dope-opt %s --pass-pipeline='builtin.module(reconcile-unrealized-casts)'
module {
  tt.func public @assume_attrs(%n: i32) {
    %c0_i32 = arith.constant 0 : i32
    %c16_i32 = arith.constant 16 : i32
    %pos = arith.cmpi sgt, %n, %c0_i32 : i32
    llvm.intr.assume %pos : i1 {tt.note = 1 : i32}
    %small = arith.cmpi slt, %n, %c16_i32 : i32
    llvm.intr.assume %small : i1
    tt.return
  }
}
