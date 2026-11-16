// `AdvanceOp::fold`：偏移全是常量 0 的 tt.advance 折成它的块指针；有一个偏移不是常量 0 就不折。原先不折。
// RUN: dope-opt %s --canonicalize
module {
  tt.func public @advance_fold(%base: !tt.ptr<f16>, %m: i64, %n: i64, %k: i32) {
    %c0_i32 = arith.constant 0 : i32
    %c1_i64 = arith.constant 1 : i64
    %bp = tt.make_tensor_ptr %base, [%m, %n], [%n, %c1_i64], [%c0_i32, %c0_i32] {order = array<i32: 1, 0>} : <tensor<16x16xf16>>
    %zero = tt.advance %bp, [%c0_i32, %c0_i32] : <tensor<16x16xf16>>
    %v = tt.load %zero : !tt.ptr<tensor<16x16xf16>>
    %moved = tt.advance %bp, [%c0_i32, %k] : <tensor<16x16xf16>>
    tt.store %moved, %v : !tt.ptr<tensor<16x16xf16>>
    tt.return
  }
}
