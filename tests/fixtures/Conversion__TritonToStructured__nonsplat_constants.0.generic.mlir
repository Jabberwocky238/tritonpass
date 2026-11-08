"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>) -> (), sym_name = "nonsplat_mask"}> ({
  ^bb0(%arg5: !tt.ptr<f32>, %arg6: !tt.ptr<f32>):
    %24 = "arith.constant"() <{value = dense<[true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false]> : tensor<16xi1>}> : () -> tensor<16xi1>
    %25 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %26 = "tts.make_tptr"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 0>}> : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %27 = "tt.splat"(%arg5) : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %28 = "tts.make_tptr"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %29 = "tt.addptr"(%27, %25) : (tensor<16x!tt.ptr<f32>>, tensor<16xi32>) -> tensor<16x!tt.ptr<f32>>
    %30 = "tts.make_tptr"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 0>}> : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %31 = "tt.splat"(%arg6) : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %32 = "tts.make_tptr"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %33 = "tt.addptr"(%31, %25) : (tensor<16x!tt.ptr<f32>>, tensor<16xi32>) -> tensor<16x!tt.ptr<f32>>
    %34 = "tt.load"(%29, %24) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<16x!tt.ptr<f32>>, tensor<16xi1>) -> tensor<16xf32>
    "tts.store"(%32, %34) <{static_mask_dims = array<i64>}> : (tensor<16x!tt.ptr<f32>>, tensor<16xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>) -> (), sym_name = "nonsplat_offset"}> ({
  ^bb0(%arg3: !tt.ptr<f32>, %arg4: !tt.ptr<f32>):
    %14 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : tensor<16xi32>}> : () -> tensor<16xi32>
    %15 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %16 = "tts.make_tptr"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 0>}> : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %17 = "tt.splat"(%arg3) : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %18 = "tt.addptr"(%17, %14) : (tensor<16x!tt.ptr<f32>>, tensor<16xi32>) -> tensor<16x!tt.ptr<f32>>
    %19 = "tts.make_tptr"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 0>}> : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %20 = "tt.splat"(%arg4) : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %21 = "tts.make_tptr"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %22 = "tt.addptr"(%20, %15) : (tensor<16x!tt.ptr<f32>>, tensor<16xi32>) -> tensor<16x!tt.ptr<f32>>
    %23 = "tt.load"(%18) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<16x!tt.ptr<f32>>) -> tensor<16xf32>
    "tts.store"(%21, %23) <{static_mask_dims = array<i64>}> : (tensor<16x!tt.ptr<f32>>, tensor<16xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "andi_mask"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = dense<15> : tensor<16xi32>}> : () -> tensor<16xi32>
    %1 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %2 = "tt.splat"(%arg2) : (i32) -> tensor<16xi32>
    %3 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 0>}> : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %4 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %5 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %6 = "tt.addptr"(%4, %1) : (tensor<16x!tt.ptr<f32>>, tensor<16xi32>) -> tensor<16x!tt.ptr<f32>>
    %7 = "tts.make_tptr"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 0>}> : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %8 = "tt.splat"(%arg1) : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %9 = "tts.make_tptr"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %10 = "tt.addptr"(%8, %1) : (tensor<16x!tt.ptr<f32>>, tensor<16xi32>) -> tensor<16x!tt.ptr<f32>>
    %11 = "arith.andi"(%1, %0) : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %12 = "arith.cmpi"(%11, %2) <{predicate = 2 : i64}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi1>
    %13 = "tt.load"(%6, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<16x!tt.ptr<f32>>, tensor<16xi1>) -> tensor<16xf32>
    "tts.store"(%9, %13) <{static_mask_dims = array<i64>}> : (tensor<16x!tt.ptr<f32>>, tensor<16xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

