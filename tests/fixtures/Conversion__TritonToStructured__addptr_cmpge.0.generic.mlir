"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f16>) -> tensor<16x16xf16>, sym_name = "test_masked_load", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f16>):
    %0 = "arith.constant"() <{value = dense<0> : tensor<1x16xi64>}> : () -> tensor<1x16xi64>
    %1 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %2 = "tt.get_program_id"() <{axis = 1 : i32}> : () -> i32
    %3 = "arith.muli"(%2, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "arith.extsi"(%3) : (i32) -> i64
    %5 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16, 16>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 0, 0>}> : (!tt.ptr<f16>) -> tensor<16x16x!tt.ptr<f16>>
    %6 = "tt.splat"(%arg0) : (!tt.ptr<f16>) -> tensor<16x16x!tt.ptr<f16>>
    %7 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %8 = "arith.extsi"(%7) : (tensor<16xi32>) -> tensor<16xi64>
    %9 = "tt.expand_dims"(%8) <{axis = 1 : i32}> : (tensor<16xi64>) -> tensor<16x1xi64>
    %10 = "tt.broadcast"(%9) : (tensor<16x1xi64>) -> tensor<16x16xi64>
    %11 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16, 16>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, 0>}> : (!tt.ptr<f16>) -> tensor<16x16x!tt.ptr<f16>>
    %12 = "tt.addptr"(%6, %10) : (tensor<16x16x!tt.ptr<f16>>, tensor<16x16xi64>) -> tensor<16x16x!tt.ptr<f16>>
    %13 = "tt.splat"(%4) : (i64) -> tensor<16xi64>
    %14 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %15 = "arith.extsi"(%14) : (tensor<16xi32>) -> tensor<16xi64>
    %16 = "arith.addi"(%13, %15) <{overflowFlags = #arith.overflow<none>}> : (tensor<16xi64>, tensor<16xi64>) -> tensor<16xi64>
    %17 = "tt.expand_dims"(%16) <{axis = 0 : i32}> : (tensor<16xi64>) -> tensor<1x16xi64>
    %18 = "arith.cmpi"(%17, %0) <{predicate = 5 : i64}> : (tensor<1x16xi64>, tensor<1x16xi64>) -> tensor<1x16xi1>
    %19 = "tt.broadcast"(%18) : (tensor<1x16xi1>) -> tensor<16x16xi1>
    %20 = "tensor.collapse_shape"(%18) <{reassociation = [[0, 1]]}> : (tensor<1x16xi1>) -> tensor<16xi1>
    %21 = "arith.constant"() <{value = 0 : index}> : () -> index
    %22 = "arith.index_cast"(%4) : (i64) -> index
    %23 = "arith.constant"() <{value = 16 : index}> : () -> index
    %24 = "arith.addi"(%23, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %25 = "tts.load"(%11) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64: 16, 16>}> : (tensor<16x16x!tt.ptr<f16>>) -> tensor<16x16xf16>
    "tt.return"(%25) : (tensor<16x16xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f16>) -> (), sym_name = "test_masked_store", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f16>):
    %0 = "arith.constant"() <{value = dense<0> : tensor<16x1xi64>}> : () -> tensor<16x1xi64>
    %1 = "arith.constant"() <{value = dense<1.500000e+01> : tensor<16x16xf16>}> : () -> tensor<16x16xf16>
    %2 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16, 16>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 0, 0>}> : (!tt.ptr<f16>) -> tensor<16x16x!tt.ptr<f16>>
    %3 = "tt.splat"(%arg0) : (!tt.ptr<f16>) -> tensor<16x16x!tt.ptr<f16>>
    %4 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %5 = "arith.extsi"(%4) : (tensor<16xi32>) -> tensor<16xi64>
    %6 = "tt.expand_dims"(%5) <{axis = 1 : i32}> : (tensor<16xi64>) -> tensor<16x1xi64>
    %7 = "tt.broadcast"(%6) : (tensor<16x1xi64>) -> tensor<16x16xi64>
    %8 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16, 16>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, 0>}> : (!tt.ptr<f16>) -> tensor<16x16x!tt.ptr<f16>>
    %9 = "tt.addptr"(%3, %7) : (tensor<16x16x!tt.ptr<f16>>, tensor<16x16xi64>) -> tensor<16x16x!tt.ptr<f16>>
    %10 = "arith.cmpi"(%6, %0) <{predicate = 5 : i64}> : (tensor<16x1xi64>, tensor<16x1xi64>) -> tensor<16x1xi1>
    %11 = "tt.broadcast"(%10) : (tensor<16x1xi1>) -> tensor<16x16xi1>
    %12 = "tensor.collapse_shape"(%10) <{reassociation = [[0, 1]]}> : (tensor<16x1xi1>) -> tensor<16xi1>
    %13 = "arith.constant"() <{value = 0 : index}> : () -> index
    "tts.store"(%8, %1) <{static_mask_dims = array<i64: 16, 16>}> : (tensor<16x16x!tt.ptr<f16>>, tensor<16x16xf16>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> tensor<4xf32>, sym_name = "test_negative_shift_lower_bound", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = dense<-1> : tensor<4xi32>}> : () -> tensor<4xi32>
    %1 = "arith.constant"() <{value = dense<0> : tensor<4xi32>}> : () -> tensor<4xi32>
    %2 = "arith.constant"() <{value = dense<4> : tensor<4xi32>}> : () -> tensor<4xi32>
    %3 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %4 = "arith.addi"(%3, %0) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %5 = "arith.cmpi"(%4, %1) <{predicate = 5 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %6 = "arith.cmpi"(%4, %2) <{predicate = 2 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %7 = "arith.andi"(%5, %6) : (tensor<4xi1>, tensor<4xi1>) -> tensor<4xi1>
    %8 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 0>}> : (!tt.ptr<f32>) -> tensor<4x!tt.ptr<f32>>
    %9 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<4x!tt.ptr<f32>>
    %10 = "arith.constant"() <{value = -1 : index}> : () -> index
    %11 = "tts.make_tptr"(%arg0, %10) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<4x!tt.ptr<f32>>
    %12 = "tt.addptr"(%9, %4) : (tensor<4x!tt.ptr<f32>>, tensor<4xi32>) -> tensor<4x!tt.ptr<f32>>
    %13 = "arith.constant"() <{value = 0 : index}> : () -> index
    %14 = "arith.constant"() <{value = -1 : index}> : () -> index
    %15 = "arith.constant"() <{value = -1 : index}> : () -> index
    %16 = "arith.constant"() <{value = 4 : index}> : () -> index
    %17 = "tt.load"(%12, %7) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<4x!tt.ptr<f32>>, tensor<4xi1>) -> tensor<4xf32>
    "tt.return"(%17) : (tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, i32) -> tensor<4xf32>, sym_name = "test_nested_negative_shift_lower_bound", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: i32):
    %0 = "arith.constant"() <{value = dense<-1> : tensor<4xi32>}> : () -> tensor<4xi32>
    %1 = "arith.constant"() <{value = dense<0> : tensor<4xi32>}> : () -> tensor<4xi32>
    %2 = "arith.constant"() <{value = dense<6> : tensor<4xi32>}> : () -> tensor<4xi32>
    %3 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %4 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %5 = "arith.addi"(%4, %0) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %6 = "arith.muli"(%arg1, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %7 = "arith.index_cast"(%6) : (i32) -> index
    %8 = "tt.splat"(%6) : (i32) -> tensor<4xi32>
    %9 = "arith.addi"(%5, %8) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %10 = "arith.cmpi"(%9, %1) <{predicate = 5 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %11 = "arith.cmpi"(%9, %2) <{predicate = 2 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %12 = "arith.andi"(%10, %11) : (tensor<4xi1>, tensor<4xi1>) -> tensor<4xi1>
    %13 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 0>}> : (!tt.ptr<f32>) -> tensor<4x!tt.ptr<f32>>
    %14 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<4x!tt.ptr<f32>>
    %15 = "arith.constant"() <{value = -1 : index}> : () -> index
    %16 = "arith.addi"(%15, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %17 = "tts.make_tptr"(%arg0, %16) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<4x!tt.ptr<f32>>
    %18 = "tt.addptr"(%14, %9) : (tensor<4x!tt.ptr<f32>>, tensor<4xi32>) -> tensor<4x!tt.ptr<f32>>
    %19 = "arith.constant"() <{value = 0 : index}> : () -> index
    %20 = "arith.constant"() <{value = -1 : index}> : () -> index
    %21 = "arith.index_cast"(%6) : (i32) -> index
    %22 = "arith.constant"() <{value = -1 : index}> : () -> index
    %23 = "arith.addi"(%22, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %24 = "arith.constant"() <{value = 3 : index}> : () -> index
    %25 = "arith.addi"(%24, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %26 = "arith.constant"() <{value = -1 : index}> : () -> index
    %27 = "arith.index_cast"(%6) : (i32) -> index
    %28 = "arith.constant"() <{value = -1 : index}> : () -> index
    %29 = "arith.addi"(%28, %27) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %30 = "arith.constant"() <{value = 3 : index}> : () -> index
    %31 = "arith.addi"(%30, %27) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %32 = "arith.constant"() <{value = 6 : index}> : () -> index
    %33 = "arith.constant"() <{value = 6 : index}> : () -> index
    %34 = "arith.minsi"(%31, %33) : (index, index) -> index
    %35 = "arith.maxsi"(%34, %29) : (index, index) -> index
    %36 = "arith.subi"(%35, %29) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %37 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %38 = "arith.index_castui"(%36) : (index) -> i32
    %39 = "tt.splat"(%38) : (i32) -> tensor<4xi32>
    %40 = "arith.cmpi"(%37, %39) <{predicate = 6 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %41 = "arith.andi"(%10, %40) : (tensor<4xi1>, tensor<4xi1>) -> tensor<4xi1>
    %42 = "tt.load"(%18, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<4x!tt.ptr<f32>>, tensor<4xi1>) -> tensor<4xf32>
    "tt.return"(%42) : (tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

