// dope-normalize-loop-index 单跑：scf.for 的上下界、步长与归纳变量统一转成 index，循环体与携带值不变。
// Triton 生成的 scf.for 归纳变量一律是 i32（合同 N11 要求的是 index，见 Contract.cpp 的 checkFor）；这条
// 转换补在 P0 之后、结构化分析之前。
// RUN: dope-opt --split-input-file --dope-normalize-loop-index %s | FileCheck %s

// ---- 没有携带值：上下界与步长都转 index，循环体内归纳变量的使用换成转回 i32 的那个值 ----
// CHECK-LABEL: tt.func public @no_iter_args(
// CHECK: %[[LO:.+]] = arith.index_cast %{{.+}} : i32 to index
// CHECK: %[[HI:.+]] = arith.index_cast %{{.+}} : i32 to index
// CHECK: %[[STEP:.+]] = arith.index_cast %{{.+}} : i32 to index
// CHECK: scf.for %[[IV:.+]] = %[[LO]] to %[[HI]] step %[[STEP]] {
// CHECK:   %[[BACK:.+]] = arith.index_cast %[[IV]] : index to i32
// CHECK:   arith.muli %[[BACK]], %{{.+}} : i32
// CHECK: }
module {
  tt.func public @no_iter_args(%x: !tt.ptr<f32>, %n: i32, %stride: i32) {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    scf.for %i = %c0 to %n step %c1 : i32 {
      %off = arith.muli %i, %stride : i32
      %p = tt.addptr %x, %off : !tt.ptr<f32>, i32
      %v = arith.constant 1.0 : f32
      tt.store %p, %v : !tt.ptr<f32>
    }
    tt.return
  }
}

// -----

// ---- 带携带值（f32 累加器，vLLM softmax 的 max_val/sum_exp 那种写法）：iter_arg 的类型不变，
// 块参数直接换，不转换；循环体自己的终结符（scf.yield）原样跟着搬过去 ----
// CHECK-LABEL: tt.func public @with_f32_iter_arg(
// CHECK: scf.for %{{.+}} = %{{.+}} to %{{.+}} step %{{.+}} iter_args(%[[ACC:.+]] = %{{.+}}) -> (f32) {
// CHECK:   %[[NEXT:.+]] = arith.addf %[[ACC]], %{{.+}} : f32
// CHECK:   scf.yield %[[NEXT]] : f32
// CHECK: }
module {
  tt.func public @with_f32_iter_arg(%x: !tt.ptr<f32>, %n: i32) -> f32 {
    %c0 = arith.constant 0 : i32
    %c1024 = arith.constant 1024 : i32
    %init = arith.constant 0.0 : f32
    %r = scf.for %i = %c0 to %n step %c1024 iter_args(%acc = %init) -> (f32) : i32 {
      %p = tt.addptr %x, %i : !tt.ptr<f32>, i32
      %v = tt.load %p : !tt.ptr<f32>
      %next = arith.addf %acc, %v : f32
      scf.yield %next : f32
    }
    tt.return %r : f32
  }
}

// -----

// ---- 已经是 index：原样跳过，不插多余的 index_cast（手写的 lit 夹具常是这个形状）；上下界都用编译期
// 常量，输入里一个 index_cast 都没有，输出也不该有 ----
// CHECK-LABEL: tt.func public @already_index(
// CHECK-NOT: arith.index_cast
// CHECK: scf.for %{{.+}} = %{{.+}} to %{{.+}} step %{{.+}} {
module {
  tt.func public @already_index(%x: !tt.ptr<f32>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    scf.for %i = %c0 to %c4 step %c1 {
      %v = arith.constant 1.0 : f32
      tt.store %x, %v : !tt.ptr<f32>
    }
    tt.return
  }
}
