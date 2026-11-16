// 0 维的块指针：tt.make_tensor_ptr 的三组操作数都空，自定义形式写 `%base, [], [], []`。原先印成 `%base, , [], []`（少了第一组的
// `[]`），两边都读不回。夹具只比通用形式，这里只护住读入这一半；印法照 dope-opt 的重印手工核对过。
// 只读入、印出：流水线里放一个对这份输入什么也不做的 pass（tritonpass 不认空的 `builtin.module()`）。
// RUN: dope-opt %s --pass-pipeline='builtin.module(reconcile-unrealized-casts)'
module {
  tt.func public @rank0_block_ptr(%base: !tt.ptr<f16>) {
    %bp = tt.make_tensor_ptr %base, [], [], [] {order = array<i32>} : <tensor<f16>>
    %v = tt.load %bp : !tt.ptr<tensor<f16>>
    tt.store %bp, %v : !tt.ptr<tensor<f16>>
    tt.return
  }
}
