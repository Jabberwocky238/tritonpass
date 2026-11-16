// triton-to-unstructured 把 tts.make_tptr 的基址换回实参、基址的偏移加到第一个动态偏移上；基址不是实参（tt.int_to_ptr、
// tt.addptr 的结果）而偏移全是静态的时候没有动态偏移可加。参照照样取第一个动态偏移，越界断言崩溃；tritonpass 把第 0 维的
// 偏移换成同值的动态操作数再加（登记在 tests/divergences/structured.txt）。
// 第一块：tt.int_to_ptr 出来的基址（triton-to-structured 建的 tts.make_tptr，偏移 [0]）；
// 第二块：手写的 tts.make_tptr，基址是 tt.addptr %arg0, %k，偏移 [5]：结果的偏移应是 k + 5。
// RUN: dope-opt %s --split-input-file --triton-to-structured --triton-to-unstructured
module {
  tt.func @int_to_ptr_base(%arg0: !tt.ptr<i64>, %arg1: !tt.ptr<f16>) {
    %0 = tt.load %arg0 : !tt.ptr<i64>
    %1 = tt.int_to_ptr %0 : i64 -> !tt.ptr<f16>
    %2 = tt.make_range {end = 32 : i32, start = 0 : i32} : tensor<32xi32>
    %3 = tt.splat %1 : !tt.ptr<f16> -> tensor<32x!tt.ptr<f16>>
    %4 = tt.addptr %3, %2 : tensor<32x!tt.ptr<f16>>, tensor<32xi32>
    %5 = tt.load %4 : tensor<32x!tt.ptr<f16>>
    %6 = tt.splat %arg1 : !tt.ptr<f16> -> tensor<32x!tt.ptr<f16>>
    %7 = tt.addptr %6, %2 : tensor<32x!tt.ptr<f16>>, tensor<32xi32>
    tt.store %7, %5 : tensor<32x!tt.ptr<f16>>
    tt.return
  }
}

// -----

module {
  tt.func @addptr_base(%arg0: !tt.ptr<f16>, %arg1: !tt.ptr<f16>, %k: i32) {
    %p = tt.addptr %arg0, %k : !tt.ptr<f16>, i32
    %t = tts.make_tptr %p to sizes: [32], strides: [1], offsets: [5], shape: [0], order: [] : <f16> to tensor<32x!tt.ptr<f16>>
    %v = "tts.load"(%t) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<f16>>) -> tensor<32xf16>
    %o = tts.make_tptr %arg1 to sizes: [32], strides: [1], offsets: [0], shape: [0], order: [] : <f16> to tensor<32x!tt.ptr<f16>>
    "tts.store"(%o, %v) <{static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<f16>>, tensor<32xf16>) -> ()
    tt.return
  }
}
