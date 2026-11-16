"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>) -> (), sym_name = "holed_row_mask", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = dense<1> : tensor<4xi32>}> : () -> tensor<4xi32>
    %1 = "arith.constant"() <{value = dense<8> : tensor<4x1xi32>}> : () -> tensor<4x1xi32>
    %2 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %3 = "tt.make_range"() <{end = 8 : i32, start = 0 : i32}> : () -> tensor<8xi32>
    %4 = "arith.cmpi"(%2, %0) <{predicate = 1 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %5 = "tt.expand_dims"(%4) <{axis = 1 : i32}> : (tensor<4xi1>) -> tensor<4x1xi1>
    %6 = "tt.broadcast"(%5) : (tensor<4x1xi1>) -> tensor<4x8xi1>
    %7 = "tt.expand_dims"(%2) <{axis = 1 : i32}> : (tensor<4xi32>) -> tensor<4x1xi32>
    %8 = "arith.muli"(%7, %1) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x1xi32>, tensor<4x1xi32>) -> tensor<4x1xi32>
    %9 = "tt.broadcast"(%8) : (tensor<4x1xi32>) -> tensor<4x8xi32>
    %10 = "tt.expand_dims"(%3) <{axis = 0 : i32}> : (tensor<8xi32>) -> tensor<1x8xi32>
    %11 = "tt.broadcast"(%10) : (tensor<1x8xi32>) -> tensor<4x8xi32>
    %12 = "arith.addi"(%9, %11) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x8xi32>, tensor<4x8xi32>) -> tensor<4x8xi32>
    %13 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 4, 8>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 0, 0>}> : (!tt.ptr<f32>) -> tensor<4x8x!tt.ptr<f32>>
    %14 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<4x8x!tt.ptr<f32>>
    %15 = "arith.constant"() <{value = 8 : index}> : () -> index
    %16 = "tts.make_tptr"(%arg0, %15) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 4, 8>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, index) -> tensor<4x8x!tt.ptr<f32>>
    %17 = "tt.addptr"(%14, %12) : (tensor<4x8x!tt.ptr<f32>>, tensor<4x8xi32>) -> tensor<4x8x!tt.ptr<f32>>
    %18 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %19 = "arith.trunci"(%18) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %20 = "arith.index_cast"(%15) : (index) -> i32
    %21 = "arith.divui"(%19, %20) : (i32, i32) -> i32
    %22 = "tensor.splat"(%21) : (i32) -> tensor<4xi32>
    %23 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %24 = "arith.addi"(%22, %23) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %25 = "tts.make_gather_scatter_tptr"(%arg0, %24, %15, %4) <{gather_scatter_dim = 0 : i32, operandSegmentSizes = array<i32: 1, 1, 1, 0, 1>, sizes = array<i64: 4, 8>, static_offsets = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, tensor<4xi32>, index, tensor<4xi1>) -> !tt.ptr<tensor<4x8xf32>>
    %26 = "tts.load"(%25) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64: 0, 8>}> : (!tt.ptr<tensor<4x8xf32>>) -> tensor<4x8xf32>
    %27 = "tts.make_tptr"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 4, 8>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 0, 0>}> : (!tt.ptr<f32>) -> tensor<4x8x!tt.ptr<f32>>
    %28 = "tt.splat"(%arg1) : (!tt.ptr<f32>) -> tensor<4x8x!tt.ptr<f32>>
    %29 = "arith.constant"() <{value = 8 : index}> : () -> index
    %30 = "tts.make_tptr"(%arg1, %29) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 4, 8>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, index) -> tensor<4x8x!tt.ptr<f32>>
    %31 = "tt.addptr"(%28, %12) : (tensor<4x8x!tt.ptr<f32>>, tensor<4x8xi32>) -> tensor<4x8x!tt.ptr<f32>>
    %32 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %33 = "arith.trunci"(%32) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %34 = "arith.index_cast"(%29) : (index) -> i32
    %35 = "arith.divui"(%33, %34) : (i32, i32) -> i32
    %36 = "tensor.splat"(%35) : (i32) -> tensor<4xi32>
    %37 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %38 = "arith.addi"(%36, %37) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %39 = "tts.make_gather_scatter_tptr"(%arg1, %38, %29, %4) <{gather_scatter_dim = 0 : i32, operandSegmentSizes = array<i32: 1, 1, 1, 0, 1>, sizes = array<i64: 4, 8>, static_offsets = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, tensor<4xi32>, index, tensor<4xi1>) -> !tt.ptr<tensor<4x8xf32>>
    "tts.store"(%39, %26) <{static_mask_dims = array<i64: 0, 8>}> : (!tt.ptr<tensor<4x8xf32>>, tensor<4x8xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>) -> (), sym_name = "holed_col_mask", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = dense<1> : tensor<8xi32>}> : () -> tensor<8xi32>
    %1 = "arith.constant"() <{value = dense<8> : tensor<4x1xi32>}> : () -> tensor<4x1xi32>
    %2 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %3 = "tt.make_range"() <{end = 8 : i32, start = 0 : i32}> : () -> tensor<8xi32>
    %4 = "arith.cmpi"(%3, %0) <{predicate = 1 : i64}> : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi1>
    %5 = "tt.expand_dims"(%4) <{axis = 0 : i32}> : (tensor<8xi1>) -> tensor<1x8xi1>
    %6 = "tt.broadcast"(%5) : (tensor<1x8xi1>) -> tensor<4x8xi1>
    %7 = "tt.expand_dims"(%2) <{axis = 1 : i32}> : (tensor<4xi32>) -> tensor<4x1xi32>
    %8 = "arith.muli"(%7, %1) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x1xi32>, tensor<4x1xi32>) -> tensor<4x1xi32>
    %9 = "tt.broadcast"(%8) : (tensor<4x1xi32>) -> tensor<4x8xi32>
    %10 = "tt.expand_dims"(%3) <{axis = 0 : i32}> : (tensor<8xi32>) -> tensor<1x8xi32>
    %11 = "tt.broadcast"(%10) : (tensor<1x8xi32>) -> tensor<4x8xi32>
    %12 = "arith.addi"(%9, %11) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x8xi32>, tensor<4x8xi32>) -> tensor<4x8xi32>
    %13 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 4, 8>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 0, 0>}> : (!tt.ptr<f32>) -> tensor<4x8x!tt.ptr<f32>>
    %14 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<4x8x!tt.ptr<f32>>
    %15 = "arith.constant"() <{value = 8 : index}> : () -> index
    %16 = "tts.make_tptr"(%arg0, %15) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 4, 8>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, index) -> tensor<4x8x!tt.ptr<f32>>
    %17 = "tt.addptr"(%14, %12) : (tensor<4x8x!tt.ptr<f32>>, tensor<4x8xi32>) -> tensor<4x8x!tt.ptr<f32>>
    %18 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %19 = "arith.trunci"(%18) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %20 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %21 = "arith.trunci"(%20) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %22 = "arith.divui"(%19, %21) : (i32, i32) -> i32
    %23 = "tensor.splat"(%22) : (i32) -> tensor<8xi32>
    %24 = "tt.make_range"() <{end = 8 : i32, start = 0 : i32}> : () -> tensor<8xi32>
    %25 = "arith.addi"(%23, %24) <{overflowFlags = #arith.overflow<none>}> : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    %26 = "tts.make_gather_scatter_tptr"(%arg0, %25, %15, %4) <{gather_scatter_dim = 1 : i32, operandSegmentSizes = array<i32: 1, 1, 1, 0, 1>, sizes = array<i64: 4, 8>, static_offsets = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, tensor<8xi32>, index, tensor<8xi1>) -> !tt.ptr<tensor<4x8xf32>>
    %27 = "tts.load"(%26) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64: 4, 0>}> : (!tt.ptr<tensor<4x8xf32>>) -> tensor<4x8xf32>
    %28 = "tts.make_tptr"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 4, 8>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 0, 0>}> : (!tt.ptr<f32>) -> tensor<4x8x!tt.ptr<f32>>
    %29 = "tt.splat"(%arg1) : (!tt.ptr<f32>) -> tensor<4x8x!tt.ptr<f32>>
    %30 = "arith.constant"() <{value = 8 : index}> : () -> index
    %31 = "tts.make_tptr"(%arg1, %30) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 4, 8>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, index) -> tensor<4x8x!tt.ptr<f32>>
    %32 = "tt.addptr"(%29, %12) : (tensor<4x8x!tt.ptr<f32>>, tensor<4x8xi32>) -> tensor<4x8x!tt.ptr<f32>>
    %33 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %34 = "arith.trunci"(%33) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %35 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %36 = "arith.trunci"(%35) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %37 = "arith.divui"(%34, %36) : (i32, i32) -> i32
    %38 = "tensor.splat"(%37) : (i32) -> tensor<8xi32>
    %39 = "tt.make_range"() <{end = 8 : i32, start = 0 : i32}> : () -> tensor<8xi32>
    %40 = "arith.addi"(%38, %39) <{overflowFlags = #arith.overflow<none>}> : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    %41 = "tts.make_gather_scatter_tptr"(%arg1, %40, %30, %4) <{gather_scatter_dim = 1 : i32, operandSegmentSizes = array<i32: 1, 1, 1, 0, 1>, sizes = array<i64: 4, 8>, static_offsets = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, tensor<8xi32>, index, tensor<8xi1>) -> !tt.ptr<tensor<4x8xf32>>
    "tts.store"(%41, %27) <{static_mask_dims = array<i64: 4, 0>}> : (!tt.ptr<tensor<4x8xf32>>, tensor<4x8xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

