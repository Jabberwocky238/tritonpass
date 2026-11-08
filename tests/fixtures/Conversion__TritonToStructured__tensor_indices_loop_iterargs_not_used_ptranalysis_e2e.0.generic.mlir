"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> (), sym_name = "test_1", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = dense<4> : tensor<4xi32>}> : () -> tensor<4xi32>
    %7 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %8 = "ub.poison"() <{value = #ub.poison}> : () -> tensor<4xi32>
    %9 = "ub.poison"() <{value = #ub.poison}> : () -> index
    %10:2 = "scf.for"(%5, %4, %3, %2, %7) ({
    ^bb0(%arg1: i32, %arg2: index, %arg3: tensor<4xi32>):
      %11 = "tts.make_tptr"(%arg0, %1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<f32>, index, index) -> tensor<4x!tt.ptr<f32>>
      %12 = "arith.sitofp"(%arg3) : (tensor<4xi32>) -> tensor<4xf32>
      "tts.store"(%11, %12) <{static_mask_dims = array<i64>}> : (tensor<4x!tt.ptr<f32>>, tensor<4xf32>) -> ()
      %13 = "arith.addi"(%arg2, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "arith.addi"(%arg3, %6) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
      %15 = "ub.poison"() <{value = #ub.poison}> : () -> tensor<4xi32>
      %16 = "ub.poison"() <{value = #ub.poison}> : () -> index
      "scf.yield"(%13, %14) : (index, tensor<4xi32>) -> ()
    }) : (i32, i32, i32, index, tensor<4xi32>) -> (index, tensor<4xi32>)
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

