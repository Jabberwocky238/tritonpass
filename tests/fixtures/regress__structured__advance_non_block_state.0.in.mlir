// tt.advance 的块指针来自函数实参（不是 tt.make_tensor_ptr）：指针分析只拿到基址，状态不是块指针。
// 参照断言 `state.isBlockPtr()` 崩溃；tritonpass 不改写这条 tt.advance 与随后的读（登记在 tests/divergences/structured.txt）。
// RUN: dope-opt %s --triton-to-structured
module {
  tt.func @advance_arg(%bp: !tt.ptr<tensor<4xf32>>, %out: !tt.ptr<tensor<4xf32>>, %k: i32) {
    %a = tt.advance %bp, [%k] : <tensor<4xf32>>
    %v = tt.load %a : !tt.ptr<tensor<4xf32>>
    tt.store %out, %v : !tt.ptr<tensor<4xf32>>
    tt.return
  }
}
