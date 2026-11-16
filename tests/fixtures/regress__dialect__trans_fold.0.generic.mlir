"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, tensor<2x4x8xf32>, tensor<4x8xf32>) -> (), sym_name = "trans_folds", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: tensor<2x4x8xf32>, %arg2: tensor<4x8xf32>):
    %0 = "arith.constant"() <{value = dense<1.000000e+00> : tensor<8x4xf32>}> : () -> tensor<8x4xf32>
    %1 = "arith.constant"() <{value = dense<[[1.000000e+00, 2.000000e+00], [3.000000e+00, 4.000000e+00]]> : tensor<2x2xf32>}> : () -> tensor<2x2xf32>
    %2 = "tt.trans"(%arg1) <{order = array<i32: 2, 1, 0>}> : (tensor<2x4x8xf32>) -> tensor<8x4x2xf32>
    %3 = "tt.trans"(%arg2) <{order = array<i32: 1, 0>}> : (tensor<4x8xf32>) -> tensor<8x4xf32>
    %4 = "tt.trans"(%arg2) <{order = array<i32: 1, 0>}> : (tensor<4x8xf32>) -> tensor<8x4xf32>
    %5 = "tt.trans"(%1) <{order = array<i32: 1, 0>}> : (tensor<2x2xf32>) -> tensor<2x2xf32>
    "tt.print"(%arg1, %2, %4, %0, %5, %3) <{hex = false, isSigned = array<i32: 0, 0, 0, 0, 0, 0>, prefix = "t"}> : (tensor<2x4x8xf32>, tensor<8x4x2xf32>, tensor<8x4xf32>, tensor<8x4xf32>, tensor<2x2xf32>, tensor<8x4xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

