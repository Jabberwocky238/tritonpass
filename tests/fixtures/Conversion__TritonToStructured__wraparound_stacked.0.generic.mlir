"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "wrap_stacked_masked_loop_01234567", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = -9.900000e+01 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 3 : index}> : () -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %8 = "arith.index_cast"(%arg2) : (i32) -> index
    %9 = "arith.index_cast"(%arg4) : (i32) -> index
    %10 = "arith.muli"(%9, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %11 = "arith.muli"(%8, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %12 = "arith.index_cast"(%arg5) : (i32) -> index
    %13 = "arith.muli"(%12, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %14 = "arith.index_cast"(%arg6) : (i32) -> index
    %15 = "arith.index_cast"(%arg7) : (i32) -> index
    %16 = "arith.muli"(%arg5, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %17 = "arith.index_cast"(%16) : (i32) -> index
    %18 = "arith.index_cast"(%16) : (i32) -> index
    %19:2 = "scf.for"(%5, %6, %4, %10, %1) ({
    ^bb0(%arg8: i32, %arg9: index, %arg10: index):
      %20 = "tts.make_tptr"(%arg1, %14, %15, %arg10, %1) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 4, 4>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<4x4x!tt.ptr<f32>>
      %21 = "tts.make_tptr"(%arg0, %9, %12, %arg9, %13, %11) <{operandSegmentSizes = array<i32: 1, 2, 2, 1>, order = array<i32>, sizes = array<i64: 4, 4>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: -9223372036854775808, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index, index) -> tensor<4x4x!tt.ptr<f32>>
      %22 = "tts.load"(%21, %0) <{operandSegmentSizes = array<i32: 1, 0, 1>, static_mask_dims = array<i64: 4, 3>}> : (tensor<4x4x!tt.ptr<f32>>, f32) -> tensor<4x4xf32>
      "tts.store"(%20, %22) <{static_mask_dims = array<i64>}> : (tensor<4x4x!tt.ptr<f32>>, tensor<4x4xf32>) -> ()
      %23 = "arith.addi"(%arg9, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %24 = "arith.addi"(%arg10, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%23, %24) : (index, index) -> ()
    }) : (i32, i32, i32, index, index) -> (index, index)
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

