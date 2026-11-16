// tt.make_tensor_descriptor 的 padding 是固有属性，自定义形式写在 attr-dict 里（Triton 的 padding_option="nan" 印成
// `{padding = 2 : i32}`）。读入时要从 attr-dict 里取走，否则通用形式里同一个键印两遍（`<{padding = 1 : i32, padding = 2 : i32}>`）。
// 只读入、印出：流水线里放一个对这份输入什么也不做的 pass（tritonpass 不认空的 `builtin.module()`）。
// RUN: dope-opt %s --pass-pipeline='builtin.module(reconcile-unrealized-casts)'
module {
  tt.func public @descriptors(%base: !tt.ptr<f32>, %n: i32) {
    %c1_i64 = arith.constant 1 : i64
    %c0_i32 = arith.constant 0 : i32
    %nan = tt.make_tensor_descriptor %base, [%n], [%c1_i64] {padding = 2 : i32} : <f32>, <tensor<16xf32>>
    %zero = tt.make_tensor_descriptor %base, [%n], [%c1_i64] : <f32>, <tensor<16xf32>>
    %v = tt.descriptor_load %nan[%c0_i32] : !tt.tensordesc<tensor<16xf32>> -> tensor<16xf32>
    tt.descriptor_store %zero[%c0_i32], %v : !tt.tensordesc<tensor<16xf32>>, tensor<16xf32>
    tt.return
  }
}
