"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "wrap_side_by_side_masked_loop_01234567", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = -9.900000e+01 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 6 : index}> : () -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %8 = "arith.index_cast"(%arg4) : (i32) -> index
    %9 = "arith.muli"(%8, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %10 = "arith.index_cast"(%arg3) : (i32) -> index
    %11 = "arith.index_cast"(%arg5) : (i32) -> index
    %12 = "arith.muli"(%11, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %13 = "arith.muli"(%10, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %14 = "arith.index_cast"(%arg6) : (i32) -> index
    %15 = "arith.index_cast"(%arg7) : (i32) -> index
    %16 = "arith.muli"(%arg4, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %17 = "arith.index_cast"(%16) : (i32) -> index
    %18 = "arith.muli"(%arg5, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %19 = "arith.index_cast"(%18) : (i32) -> index
    %20:2 = "scf.for"(%5, %6, %4, %9, %1) ({
    ^bb0(%arg8: i32, %arg9: index, %arg10: index):
      %21 = "tts.make_tptr"(%arg1, %14, %15, %arg10, %1) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 4, 4>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<4x4x!tt.ptr<f32>>
      %22 = "tts.make_tptr"(%arg0, %8, %11, %arg9, %12, %13) <{operandSegmentSizes = array<i32: 1, 2, 2, 1>, order = array<i32>, sizes = array<i64: 4, 4>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index, index) -> tensor<4x4x!tt.ptr<f32>>
      %23 = "tts.load"(%22, %0) <{operandSegmentSizes = array<i32: 1, 0, 1>, static_mask_dims = array<i64: 2, 4>}> : (tensor<4x4x!tt.ptr<f32>>, f32) -> tensor<4x4xf32>
      "tts.store"(%21, %23) <{static_mask_dims = array<i64>}> : (tensor<4x4x!tt.ptr<f32>>, tensor<4x4xf32>) -> ()
      %24 = "arith.addi"(%arg9, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %25 = "arith.addi"(%arg10, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%24, %25) : (index, index) -> ()
    }) : (i32, i32, i32, index, index) -> (index, index)
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

