// triton-to-unstructured 遇到秩 0 的 tt.make_tensor_ptr：没有偏移能加上基址的偏移。参照照样取「第一个动态偏移」，越界断言崩溃；
// tritonpass 以前 panic，现在报 t2u 的警告、这条不动。
// RUN: dope-opt %s --triton-to-unstructured

module {
  tt.func public @rank0_block_ptr(%base: !tt.ptr<f16>) {
    %bp = tt.make_tensor_ptr %base, [], [], [] {order = array<i32>} : <tensor<f16>>
    %v = tt.load %bp : !tt.ptr<tensor<f16>>
    tt.store %bp, %v : !tt.ptr<tensor<f16>>
    tt.return
  }
}
