"builtin.module"() ({
  "tt.func"() <{arg_attrs = [{tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {}, {}, {}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}], function_type = (!tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<i32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "generic_mask_3d_non_continuous_store_kernel", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<i32>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = -2.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 8 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 16 : index}> : () -> index
    %6 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %7 = "tt.splat"(%arg6) : (i32) -> tensor<16xi32>
    %8 = "tts.make_tptr"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<i32>) -> tensor<16x!tt.ptr<i32>>
    %9 = "arith.index_cast"(%arg6) : (i32) -> index
    %10 = "arith.minsi"(%9, %5) : (index, index) -> index
    %11 = "arith.maxsi"(%10, %4) : (index, index) -> index
    %12 = "tts.load"(%8, %11, %3) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<16x!tt.ptr<i32>>, index, i32) -> tensor<16xi32>
    %13 = "arith.cmpi"(%12, %7) <{predicate = 2 : i64}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi1>
    %14 = "tt.splat"(%arg3) : (i32) -> tensor<16xi32>
    %15 = "arith.cmpi"(%6, %14) <{predicate = 2 : i64}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi1>
    %16 = "arith.andi"(%13, %15) : (tensor<16xi1>, tensor<16xi1>) -> tensor<16xi1>
    %17 = "arith.index_cast"(%arg7) : (i32) -> index
    %18 = "arith.index_cast"(%arg8) : (i32) -> index
    %19 = "tts.make_tptr"(%arg0, %17, %18) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, order = array<i32>, sizes = array<i64: 4, 8, 16>, static_offsets = array<i64: 0, 0, 0>, static_shape = array<i64: 0, 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, 1>}> : (!tt.ptr<f32>, index, index) -> tensor<4x8x16x!tt.ptr<f32>>
    %20 = "arith.index_cast"(%arg4) : (i32) -> index
    %21 = "arith.minsi"(%20, %2) : (index, index) -> index
    %22 = "arith.maxsi"(%21, %4) : (index, index) -> index
    %23 = "arith.index_cast"(%arg5) : (i32) -> index
    %24 = "arith.minsi"(%23, %1) : (index, index) -> index
    %25 = "arith.maxsi"(%24, %4) : (index, index) -> index
    %26 = "arith.index_cast"(%arg3) : (i32) -> index
    %27 = "arith.minsi"(%26, %5) : (index, index) -> index
    %28 = "arith.maxsi"(%27, %4) : (index, index) -> index
    %29 = "arith.minsi"(%25, %1) : (index, index) -> index
    %30 = "arith.minsi"(%28, %5) : (index, index) -> index
    %31 = "arith.minsi"(%22, %2) : (index, index) -> index
    %32 = "arith.minsi"(%29, %1) : (index, index) -> index
    %33 = "arith.minsi"(%30, %5) : (index, index) -> index
    %34 = "tts.load"(%19, %31, %32, %33, %0) <{operandSegmentSizes = array<i32: 1, 3, 1>, static_mask_dims = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<4x8x16x!tt.ptr<f32>>, index, index, index, f32) -> tensor<4x8x16xf32>
    %35 = "tts.make_gather_scatter_tptr"(%arg1, %12, %17, %18, %16) <{gather_scatter_dim = 2 : i32, operandSegmentSizes = array<i32: 1, 1, 2, 0, 1>, sizes = array<i64: 4, 8, 16>, static_offsets = array<i64: 0, 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, 1>}> : (!tt.ptr<f32>, tensor<16xi32>, index, index, tensor<16xi1>) -> !tt.ptr<tensor<4x8x16xf32>>
    "tts.store"(%35, %34, %31, %32) <{static_mask_dims = array<i64: -9223372036854775808, -9223372036854775808, 0>}> : (!tt.ptr<tensor<4x8x16xf32>>, tensor<4x8x16xf32>, index, index) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

