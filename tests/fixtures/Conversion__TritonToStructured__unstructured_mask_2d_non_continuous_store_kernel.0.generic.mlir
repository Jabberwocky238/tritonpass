"builtin.module"() ({
  "tt.func"() <{arg_attrs = [{tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {}, {}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}], function_type = (!tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<i32>, i32, i32, i32, i32) -> (), sym_name = "generic_mask_2d_non_continuous_store_kernel", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<i32>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32):
    %0 = "arith.constant"() <{value = -2.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 8 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 16 : index}> : () -> index
    %5 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %6 = "tt.splat"(%arg5) : (i32) -> tensor<16xi32>
    %7 = "tts.make_tptr"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<i32>) -> tensor<16x!tt.ptr<i32>>
    %8 = "arith.index_cast"(%arg5) : (i32) -> index
    %9 = "arith.minsi"(%8, %4) : (index, index) -> index
    %10 = "arith.maxsi"(%9, %3) : (index, index) -> index
    %11 = "tts.load"(%7, %10, %2) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<16x!tt.ptr<i32>>, index, i32) -> tensor<16xi32>
    %12 = "arith.cmpi"(%11, %6) <{predicate = 2 : i64}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi1>
    %13 = "tt.splat"(%arg3) : (i32) -> tensor<16xi32>
    %14 = "arith.cmpi"(%5, %13) <{predicate = 2 : i64}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi1>
    %15 = "arith.andi"(%12, %14) : (tensor<16xi1>, tensor<16xi1>) -> tensor<16xi1>
    %16 = "arith.index_cast"(%arg6) : (i32) -> index
    %17 = "tts.make_tptr"(%arg0, %16) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 8, 16>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, index) -> tensor<8x16x!tt.ptr<f32>>
    %18 = "arith.index_cast"(%arg4) : (i32) -> index
    %19 = "arith.minsi"(%18, %1) : (index, index) -> index
    %20 = "arith.maxsi"(%19, %3) : (index, index) -> index
    %21 = "arith.index_cast"(%arg3) : (i32) -> index
    %22 = "arith.minsi"(%21, %4) : (index, index) -> index
    %23 = "arith.maxsi"(%22, %3) : (index, index) -> index
    %24 = "arith.minsi"(%20, %1) : (index, index) -> index
    %25 = "arith.minsi"(%23, %4) : (index, index) -> index
    %26 = "tts.load"(%17, %24, %25, %0) <{operandSegmentSizes = array<i32: 1, 2, 1>, static_mask_dims = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<8x16x!tt.ptr<f32>>, index, index, f32) -> tensor<8x16xf32>
    %27 = "tts.make_gather_scatter_tptr"(%arg1, %11, %16, %15) <{gather_scatter_dim = 1 : i32, operandSegmentSizes = array<i32: 1, 1, 1, 0, 1>, sizes = array<i64: 8, 16>, static_offsets = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, tensor<16xi32>, index, tensor<16xi1>) -> !tt.ptr<tensor<8x16xf32>>
    "tts.store"(%27, %26, %24) <{static_mask_dims = array<i64: -9223372036854775808, 0>}> : (!tt.ptr<tensor<8x16xf32>>, tensor<8x16xf32>, index) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

