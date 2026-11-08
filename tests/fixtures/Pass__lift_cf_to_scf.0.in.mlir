// dope-lift-cf-to-scf 单跑：多块的 tt.func（cf 分支，常见写法是复合布尔条件的早退）借一个临时 func.func
// 跑上游原版 lift-cf-to-scf；完全结构化成功才替换原函数体，不完全成功（或根本不是这种形状）原样不动。
// RUN: dope-opt --split-input-file --dope-lift-cf-to-scf %s | FileCheck %s

// ---- 简单两路早退（mean_kernel 一类「复合布尔条件早退」的核心形状）：两个分支都以 tt.return 收尾，
// 没有结果——结构化成单块、scf.if 两个分支都不产出值 ----
// CHECK-LABEL: tt.func public @guard_return(
// CHECK-NOT: cf.cond_br
// CHECK: scf.if
// CHECK: } else {
// CHECK: tt.store
// CHECK: }
// CHECK-NEXT: tt.return
module {
  tt.func public @guard_return(%x: !tt.ptr<f32>, %flag: i32) {
    %c0 = arith.constant 0 : i32
    %cond = arith.cmpi sge, %flag, %c0 : i32
    cf.cond_br %cond, ^bb1, ^bb2
  ^bb1:
    tt.return
  ^bb2:
    %v = arith.constant 1.0 : f32
    tt.store %x, %v : !tt.ptr<f32>
    tt.return
  }
}

// -----

// ---- 已经是单块：没有 cf 分支，原样不动（不建临时函数、不跑上游 pass） ----
// CHECK-LABEL: tt.func public @no_branch(
// CHECK-NEXT: %[[V:.+]] = arith.constant
// CHECK-NEXT: tt.store %{{.+}}, %[[V]]
// CHECK-NEXT: tt.return
module {
  tt.func public @no_branch(%x: !tt.ptr<f32>) {
    %v = arith.constant 1.0 : f32
    tt.store %x, %v : !tt.ptr<f32>
    tt.return
  }
}

// -----

// ---- 真正的循环（cf.br 回边，不是早退）：上游 pass 连这种形状也能结构化（Triton 的前端只从结构化的
// Python 控制流（if/for/while）编出 CFG，实测恒可规约，没见过结构化不了的真实输入）——回边变 scf.while，
// 一样整段替换原函数体；不完全成功时原函数体一个字节都不该动（丢弃临时结果，不留半成品）这条防线留着，
// 没有构造出能触发它的真实输入，按 P0 对 scf.while 的既有拒收兜底 ----
// CHECK-LABEL: tt.func public @back_edge_loop(
// CHECK-NOT: cf.cond_br
// CHECK-NOT: cf.br
// CHECK: scf.while
module {
  tt.func public @back_edge_loop(%x: !tt.ptr<f32>, %n: i32) {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    cf.br ^bb1(%c0 : i32)
  ^bb1(%i: i32):
    %cond = arith.cmpi slt, %i, %n : i32
    cf.cond_br %cond, ^bb2, ^bb3
  ^bb2:
    %v = arith.constant 1.0 : f32
    tt.store %x, %v : !tt.ptr<f32>
    %next = arith.addi %i, %c1 : i32
    cf.br ^bb1(%next : i32)
  ^bb3:
    tt.return
  }
}
