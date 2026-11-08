"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32) -> (), sym_name = "mask_ld_st_scalar"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "arith.cmpi"(%arg4, %3) <{predicate = 4 : i64}> : (i32, i32) -> i1
    %5 = "arith.index_cast"(%arg6) : (i32) -> index
    %6 = "tts.make_tptr"(%arg1, %5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 2, 1>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 0>}> : (!tt.ptr<f32>, index) -> tensor<2x1x!tt.ptr<f32>>
    %7 = "arith.index_cast"(%arg3) : (i32) -> index
    %8 = "arith.minsi"(%7, %2) : (index, index) -> index
    %9 = "arith.maxsi"(%8, %1) : (index, index) -> index
    %10 = "arith.select"(%4, %9, %1) : (i1, index, index) -> index
    %11 = "arith.select"(%4, %0, %1) : (i1, index, index) -> index
    %12 = "tts.load"(%6, %10, %11) <{operandSegmentSizes = array<i32: 1, 2, 0>, static_mask_dims = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<2x1x!tt.ptr<f32>>, index, index) -> tensor<2x1xf32>
    %13 = "arith.index_cast"(%arg5) : (i32) -> index
    %14 = "tts.make_tptr"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 2, 1>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 0>}> : (!tt.ptr<f32>, index) -> tensor<2x1x!tt.ptr<f32>>
    %15 = "arith.index_cast"(%arg2) : (i32) -> index
    %16 = "arith.minsi"(%15, %2) : (index, index) -> index
    %17 = "arith.maxsi"(%16, %1) : (index, index) -> index
    %18 = "arith.select"(%4, %17, %1) : (i1, index, index) -> index
    %19 = "tts.load"(%14, %18, %11) <{operandSegmentSizes = array<i32: 1, 2, 0>, static_mask_dims = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<2x1x!tt.ptr<f32>>, index, index) -> tensor<2x1xf32>
    "tts.store"(%6, %12, %10, %11) <{static_mask_dims = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<2x1x!tt.ptr<f32>>, tensor<2x1xf32>, index, index) -> ()
    "tts.store"(%14, %19, %18, %11) <{static_mask_dims = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<2x1x!tt.ptr<f32>>, tensor<2x1xf32>, index, index) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

