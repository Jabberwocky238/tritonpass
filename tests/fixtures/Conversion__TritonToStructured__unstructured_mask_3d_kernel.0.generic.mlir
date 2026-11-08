"builtin.module"() ({
  "tt.func"() <{arg_attrs = [{tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {}, {}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}], function_type = (!tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<i8>, !tt.ptr<i8>, i32, i32, i32, i32, i32) -> (), sym_name = "generic_mask_3d_kernel", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<i8>, %arg3: !tt.ptr<i8>, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = -2.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "arith.constant"() <{value = 16 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.constant"() <{value = 8 : index}> : () -> index
    %7 = "arith.constant"() <{value = dense<0> : tensor<16xi32>}> : () -> tensor<16xi32>
    %8 = "arith.constant"() <{value = dense<0> : tensor<8xi32>}> : () -> tensor<8xi32>
    %9 = "tts.make_tptr"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 8>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<i8>) -> tensor<8x!tt.ptr<i8>>
    %10 = "arith.index_cast"(%arg5) : (i32) -> index
    %11 = "arith.minsi"(%10, %6) : (index, index) -> index
    %12 = "arith.maxsi"(%11, %5) : (index, index) -> index
    %13 = "tts.load"(%9, %12, %4) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<8x!tt.ptr<i8>>, index, i8) -> tensor<8xi8>
    %14 = "arith.extsi"(%13) : (tensor<8xi8>) -> tensor<8xi32>
    %15 = "arith.cmpi"(%14, %8) <{predicate = 1 : i64}> : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi1>
    %16 = "tts.make_tptr"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<i8>) -> tensor<16x!tt.ptr<i8>>
    %17 = "arith.index_cast"(%arg6) : (i32) -> index
    %18 = "arith.minsi"(%17, %3) : (index, index) -> index
    %19 = "arith.maxsi"(%18, %5) : (index, index) -> index
    %20 = "tts.load"(%16, %19, %4) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<16x!tt.ptr<i8>>, index, i8) -> tensor<16xi8>
    %21 = "arith.extsi"(%20) : (tensor<16xi8>) -> tensor<16xi32>
    %22 = "arith.cmpi"(%21, %7) <{predicate = 1 : i64}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi1>
    %23 = "arith.index_cast"(%arg7) : (i32) -> index
    %24 = "arith.index_cast"(%arg8) : (i32) -> index
    %25 = "arith.index_cast"(%arg4) : (i32) -> index
    %26 = "arith.minsi"(%25, %2) : (index, index) -> index
    %27 = "arith.maxsi"(%26, %5) : (index, index) -> index
    %28 = "arith.minsi"(%19, %3) : (index, index) -> index
    %29 = "arith.minsi"(%27, %2) : (index, index) -> index
    %30 = "arith.minsi"(%28, %3) : (index, index) -> index
    %31 = "arith.divui"(%0, %arg8) : (i32, i32) -> i32
    %32 = "tensor.splat"(%31) : (i32) -> tensor<8xi32>
    %33 = "tt.make_range"() <{end = 8 : i32, start = 0 : i32}> : () -> tensor<8xi32>
    %34 = "arith.addi"(%32, %33) <{overflowFlags = #arith.overflow<none>}> : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    %35 = "tts.make_gather_scatter_tptr"(%arg0, %34, %23, %24, %15) <{gather_scatter_dim = 1 : i32, operandSegmentSizes = array<i32: 1, 1, 2, 0, 1>, sizes = array<i64: 4, 8, 16>, static_offsets = array<i64: 0, 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, 1>}> : (!tt.ptr<f32>, tensor<8xi32>, index, index, tensor<8xi1>) -> !tt.ptr<tensor<4x8x16xf32>>
    %36 = "tts.load"(%35, %29, %30, %1) <{operandSegmentSizes = array<i32: 1, 2, 1>, static_mask_dims = array<i64: -9223372036854775808, 0, -9223372036854775808>}> : (!tt.ptr<tensor<4x8x16xf32>>, index, index, f32) -> tensor<4x8x16xf32>
    %37 = "arith.minsi"(%12, %6) : (index, index) -> index
    %38 = "arith.minsi"(%37, %6) : (index, index) -> index
    %39 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %40 = "tts.make_gather_scatter_tptr"(%arg1, %39, %23, %24, %22) <{gather_scatter_dim = 2 : i32, operandSegmentSizes = array<i32: 1, 1, 2, 0, 1>, sizes = array<i64: 4, 8, 16>, static_offsets = array<i64: 0, 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, 1>}> : (!tt.ptr<f32>, tensor<16xi32>, index, index, tensor<16xi1>) -> !tt.ptr<tensor<4x8x16xf32>>
    "tts.store"(%40, %36, %29, %38) <{static_mask_dims = array<i64: -9223372036854775808, -9223372036854775808, 0>}> : (!tt.ptr<tensor<4x8x16xf32>>, tensor<4x8x16xf32>, index, index) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

