// `TransOp::fold`：trans(trans(x)) 原地合成一次（次序 = applyPermutation(内层, 外层)），合成出恒等次序再折成 x；
// splat 常量的 trans 折成换了形状的 splat 常量；非 splat 的常量不折。原先只折恒等次序。
// RUN: dope-opt %s --canonicalize
module {
  tt.func public @trans_folds(%p: !tt.ptr<f32>, %x: tensor<2x4x8xf32>, %y: tensor<4x8xf32>) {
    %t0 = tt.trans %x {order = array<i32: 1, 2, 0>} : tensor<2x4x8xf32> -> tensor<4x8x2xf32>
    %t1 = tt.trans %t0 {order = array<i32: 2, 0, 1>} : tensor<4x8x2xf32> -> tensor<2x4x8xf32>
    %t2 = tt.trans %x {order = array<i32: 2, 0, 1>} : tensor<2x4x8xf32> -> tensor<8x2x4xf32>
    %t3 = tt.trans %t2 {order = array<i32: 0, 2, 1>} : tensor<8x2x4xf32> -> tensor<8x4x2xf32>
    %t4 = tt.trans %y {order = array<i32: 1, 0>} : tensor<4x8xf32> -> tensor<8x4xf32>
    %t5 = tt.trans %t4 {order = array<i32: 1, 0>} : tensor<8x4xf32> -> tensor<4x8xf32>
    %t6 = tt.trans %t5 {order = array<i32: 1, 0>} : tensor<4x8xf32> -> tensor<8x4xf32>
    %one = arith.constant dense<1.000000e+00> : tensor<4x8xf32>
    %t7 = tt.trans %one {order = array<i32: 1, 0>} : tensor<4x8xf32> -> tensor<8x4xf32>
    %iota = arith.constant dense<[[1.0, 2.0], [3.0, 4.0]]> : tensor<2x2xf32>
    %t8 = tt.trans %iota {order = array<i32: 1, 0>} : tensor<2x2xf32> -> tensor<2x2xf32>
    tt.print "t" {hex = false, isSigned = array<i32: 0, 0, 0, 0, 0, 0>} : %t1, %t3, %t6, %t7, %t8, %t4 : tensor<2x4x8xf32>, tensor<8x4x2xf32>, tensor<8x4xf32>, tensor<8x4xf32>, tensor<2x2xf32>, tensor<8x4xf32>
    tt.return
  }
}
