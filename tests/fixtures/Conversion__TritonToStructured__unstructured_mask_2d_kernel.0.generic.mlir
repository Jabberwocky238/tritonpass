"builtin.module"() ({
  "tt.func"() <{arg_attrs = [{tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {}, {tt.divisibility = 16 : i32}], function_type = (!tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<i8>, !tt.ptr<i8>, i32, i32) -> (), sym_name = "generic_mask_2d_kernel", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<i8>, %arg3: !tt.ptr<i8>, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = -2.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 16 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 8 : index}> : () -> index
    %5 = "arith.constant"() <{value = dense<0> : tensor<16xi32>}> : () -> tensor<16xi32>
    %6 = "arith.constant"() <{value = dense<0> : tensor<8xi32>}> : () -> tensor<8xi32>
    %7 = "tts.make_tptr"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 8>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<i8>) -> tensor<8x!tt.ptr<i8>>
    %8 = "arith.index_cast"(%arg4) : (i32) -> index
    %9 = "arith.minsi"(%8, %4) : (index, index) -> index
    %10 = "arith.maxsi"(%9, %3) : (index, index) -> index
    %11 = "tts.load"(%7, %10, %2) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<8x!tt.ptr<i8>>, index, i8) -> tensor<8xi8>
    %12 = "arith.extsi"(%11) : (tensor<8xi8>) -> tensor<8xi32>
    %13 = "arith.cmpi"(%12, %6) <{predicate = 1 : i64}> : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi1>
    %14 = "tts.make_tptr"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<i8>) -> tensor<16x!tt.ptr<i8>>
    %15 = "arith.index_cast"(%arg5) : (i32) -> index
    %16 = "arith.minsi"(%15, %1) : (index, index) -> index
    %17 = "arith.maxsi"(%16, %3) : (index, index) -> index
    %18 = "tts.load"(%14, %17, %2) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<16x!tt.ptr<i8>>, index, i8) -> tensor<16xi8>
    %19 = "arith.extsi"(%18) : (tensor<16xi8>) -> tensor<16xi32>
    %20 = "arith.cmpi"(%19, %5) <{predicate = 1 : i64}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi1>
    %21 = "arith.minsi"(%17, %1) : (index, index) -> index
    %22 = "tt.make_range"() <{end = 8 : i32, start = 0 : i32}> : () -> tensor<8xi32>
    %23 = "tts.make_gather_scatter_tptr"(%arg0, %22, %1, %13) <{gather_scatter_dim = 0 : i32, operandSegmentSizes = array<i32: 1, 1, 1, 0, 1>, sizes = array<i64: 8, 16>, static_offsets = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, tensor<8xi32>, index, tensor<8xi1>) -> !tt.ptr<tensor<8x16xf32>>
    %24 = "tts.load"(%23, %21, %0) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: 0, -9223372036854775808>}> : (!tt.ptr<tensor<8x16xf32>>, index, f32) -> tensor<8x16xf32>
    %25 = "arith.minsi"(%10, %4) : (index, index) -> index
    %26 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %27 = "tts.make_gather_scatter_tptr"(%arg1, %26, %1, %20) <{gather_scatter_dim = 1 : i32, operandSegmentSizes = array<i32: 1, 1, 1, 0, 1>, sizes = array<i64: 8, 16>, static_offsets = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, tensor<16xi32>, index, tensor<16xi1>) -> !tt.ptr<tensor<8x16xf32>>
    "tts.store"(%27, %24, %25) <{static_mask_dims = array<i64: -9223372036854775808, 0>}> : (!tt.ptr<tensor<8x16xf32>>, tensor<8x16xf32>, index) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

