"builtin.module"() ({
  "tt.func"() <{arg_attrs = [{tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {}, {}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}], function_type = (!tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<i32>, i32, i32, i32, i32) -> (), sym_name = "generic_mask_2d_non_continuous_load_kernel", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<i32>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32):
    %0 = "arith.constant"() <{value = -2.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 16 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 4 : index}> : () -> index
    %5 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %6 = "tt.splat"(%arg3) : (i32) -> tensor<4xi32>
    %7 = "arith.cmpi"(%5, %6) <{predicate = 2 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %8 = "tts.make_tptr"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<i32>) -> tensor<4x!tt.ptr<i32>>
    %9 = "arith.index_cast"(%arg3) : (i32) -> index
    %10 = "arith.minsi"(%9, %4) : (index, index) -> index
    %11 = "arith.maxsi"(%10, %3) : (index, index) -> index
    %12 = "tts.load"(%8, %11, %2) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<4x!tt.ptr<i32>>, index, i32) -> tensor<4xi32>
    %13 = "tt.splat"(%arg4) : (i32) -> tensor<4xi32>
    %14 = "arith.cmpi"(%12, %13) <{predicate = 2 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %15 = "arith.andi"(%14, %7) : (tensor<4xi1>, tensor<4xi1>) -> tensor<4xi1>
    %16 = "arith.index_cast"(%arg6) : (i32) -> index
    %17 = "arith.index_cast"(%arg5) : (i32) -> index
    %18 = "arith.minsi"(%17, %1) : (index, index) -> index
    %19 = "arith.maxsi"(%18, %3) : (index, index) -> index
    %20 = "arith.minsi"(%19, %1) : (index, index) -> index
    %21 = "tts.make_gather_scatter_tptr"(%arg0, %12, %16, %15) <{gather_scatter_dim = 0 : i32, operandSegmentSizes = array<i32: 1, 1, 1, 0, 1>, sizes = array<i64: 4, 16>, static_offsets = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, tensor<4xi32>, index, tensor<4xi1>) -> !tt.ptr<tensor<4x16xf32>>
    %22 = "tts.load"(%21, %20, %0) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: 0, -9223372036854775808>}> : (!tt.ptr<tensor<4x16xf32>>, index, f32) -> tensor<4x16xf32>
    %23 = "tts.make_tptr"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 4, 16>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, index) -> tensor<4x16x!tt.ptr<f32>>
    %24 = "arith.minsi"(%11, %4) : (index, index) -> index
    "tts.store"(%23, %22, %24, %20) <{static_mask_dims = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<4x16x!tt.ptr<f32>>, tensor<4x16xf32>, index, index) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

