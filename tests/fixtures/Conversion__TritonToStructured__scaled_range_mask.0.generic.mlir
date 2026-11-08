"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> tensor<4x8xf32>, sym_name = "dilated_row_mask", sym_visibility = "public"}> ({
  ^bb0(%arg9: !tt.ptr<f32>):
    %62 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %63 = "arith.constant"() <{value = 8 : index}> : () -> index
    %64 = "tts.make_tptr"(%arg9, %63) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 4, 8>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, index) -> tensor<4x8x!tt.ptr<f32>>
    %65 = "tts.load"(%64, %62) <{operandSegmentSizes = array<i32: 1, 0, 1>, static_mask_dims = array<i64: 3, 8>}> : (tensor<4x8x!tt.ptr<f32>>, f32) -> tensor<4x8xf32>
    "tt.return"(%65) : (tensor<4x8xf32>) -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> tensor<4x8xf32>, sym_name = "dilated_row_mask_ceildiv_extsi", sym_visibility = "public"}> ({
  ^bb0(%arg8: !tt.ptr<f32>):
    %58 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %59 = "arith.constant"() <{value = 8 : index}> : () -> index
    %60 = "tts.make_tptr"(%arg8, %59) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 4, 8>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, index) -> tensor<4x8x!tt.ptr<f32>>
    %61 = "tts.load"(%60, %58) <{operandSegmentSizes = array<i32: 1, 0, 1>, static_mask_dims = array<i64: 3, 8>}> : (tensor<4x8x!tt.ptr<f32>>, f32) -> tensor<4x8xf32>
    "tt.return"(%61) : (tensor<4x8xf32>) -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> (tensor<4xf32>, tensor<4xf32>, tensor<4xf32>), sym_name = "unsupported_scaled_predicates", sym_visibility = "public"}> ({
  ^bb0(%arg7: !tt.ptr<f32>):
    %44 = "arith.constant"() <{value = dense<-9.000000e+00> : tensor<4xf32>}> : () -> tensor<4xf32>
    %45 = "arith.constant"() <{value = dense<2> : tensor<4xi32>}> : () -> tensor<4xi32>
    %46 = "arith.constant"() <{value = dense<3> : tensor<4xi32>}> : () -> tensor<4xi32>
    %47 = "arith.constant"() <{value = dense<1> : tensor<4xi32>}> : () -> tensor<4xi32>
    %48 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %49 = "arith.muli"(%48, %45) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %50 = "arith.cmpi"(%49, %46) <{predicate = 3 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %51 = "arith.cmpi"(%49, %46) <{predicate = 4 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %52 = "arith.cmpi"(%49, %47) <{predicate = 5 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %53 = "tt.splat"(%arg7) : (!tt.ptr<f32>) -> tensor<4x!tt.ptr<f32>>
    %54 = "tt.addptr"(%53, %48) : (tensor<4x!tt.ptr<f32>>, tensor<4xi32>) -> tensor<4x!tt.ptr<f32>>
    %55 = "tt.load"(%54, %50, %44) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<4x!tt.ptr<f32>>, tensor<4xi1>, tensor<4xf32>) -> tensor<4xf32>
    %56 = "tt.load"(%54, %51, %44) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<4x!tt.ptr<f32>>, tensor<4xi1>, tensor<4xf32>) -> tensor<4xf32>
    %57 = "tt.load"(%54, %52, %44) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<4x!tt.ptr<f32>>, tensor<4xi1>, tensor<4xf32>) -> tensor<4xf32>
    "tt.return"(%55, %56, %57) : (tensor<4xf32>, tensor<4xf32>, tensor<4xf32>) -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> tensor<4xf32>, sym_name = "overflow_lower_mask", sym_visibility = "public"}> ({
  ^bb0(%arg6: !tt.ptr<f32>):
    %35 = "arith.constant"() <{value = dense<-9.000000e+00> : tensor<4xf32>}> : () -> tensor<4xf32>
    %36 = "arith.constant"() <{value = dense<1073741824> : tensor<4xi32>}> : () -> tensor<4xi32>
    %37 = "arith.constant"() <{value = dense<0> : tensor<4xi32>}> : () -> tensor<4xi32>
    %38 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %39 = "arith.muli"(%38, %36) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %40 = "arith.cmpi"(%39, %37) <{predicate = 5 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %41 = "tt.splat"(%arg6) : (!tt.ptr<f32>) -> tensor<4x!tt.ptr<f32>>
    %42 = "tt.addptr"(%41, %38) : (tensor<4x!tt.ptr<f32>>, tensor<4xi32>) -> tensor<4x!tt.ptr<f32>>
    %43 = "tt.load"(%42, %40, %35) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<4x!tt.ptr<f32>>, tensor<4xi1>, tensor<4xf32>) -> tensor<4xf32>
    "tt.return"(%43) : (tensor<4xf32>) -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> tensor<4xf32>, sym_name = "overflow_lower_mask_extsi", sym_visibility = "public"}> ({
  ^bb0(%arg5: !tt.ptr<f32>):
    %25 = "arith.constant"() <{value = dense<-9.000000e+00> : tensor<4xf32>}> : () -> tensor<4xf32>
    %26 = "arith.constant"() <{value = dense<1073741824> : tensor<4xi32>}> : () -> tensor<4xi32>
    %27 = "arith.constant"() <{value = dense<0> : tensor<4xi64>}> : () -> tensor<4xi64>
    %28 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %29 = "arith.muli"(%28, %26) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %30 = "arith.extsi"(%29) : (tensor<4xi32>) -> tensor<4xi64>
    %31 = "arith.cmpi"(%30, %27) <{predicate = 5 : i64}> : (tensor<4xi64>, tensor<4xi64>) -> tensor<4xi1>
    %32 = "tt.splat"(%arg5) : (!tt.ptr<f32>) -> tensor<4x!tt.ptr<f32>>
    %33 = "tt.addptr"(%32, %28) : (tensor<4x!tt.ptr<f32>>, tensor<4xi32>) -> tensor<4x!tt.ptr<f32>>
    %34 = "tt.load"(%33, %31, %25) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<4x!tt.ptr<f32>>, tensor<4xi1>, tensor<4xf32>) -> tensor<4xf32>
    "tt.return"(%34) : (tensor<4xf32>) -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> tensor<4xf32>, sym_name = "overflow_upper_mask", sym_visibility = "public"}> ({
  ^bb0(%arg4: !tt.ptr<f32>):
    %16 = "arith.constant"() <{value = dense<-9.000000e+00> : tensor<4xf32>}> : () -> tensor<4xf32>
    %17 = "arith.constant"() <{value = dense<1073741824> : tensor<4xi32>}> : () -> tensor<4xi32>
    %18 = "arith.constant"() <{value = dense<1> : tensor<4xi32>}> : () -> tensor<4xi32>
    %19 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %20 = "arith.muli"(%19, %17) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %21 = "arith.cmpi"(%20, %18) <{predicate = 2 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %22 = "tt.splat"(%arg4) : (!tt.ptr<f32>) -> tensor<4x!tt.ptr<f32>>
    %23 = "tt.addptr"(%22, %19) : (tensor<4x!tt.ptr<f32>>, tensor<4xi32>) -> tensor<4x!tt.ptr<f32>>
    %24 = "tt.load"(%23, %21, %16) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<4x!tt.ptr<f32>>, tensor<4xi1>, tensor<4xf32>) -> tensor<4xf32>
    "tt.return"(%24) : (tensor<4xf32>) -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> tensor<4xf32>, sym_name = "overflow_upper_mask_extsi", sym_visibility = "public"}> ({
  ^bb0(%arg3: !tt.ptr<f32>):
    %6 = "arith.constant"() <{value = dense<-9.000000e+00> : tensor<4xf32>}> : () -> tensor<4xf32>
    %7 = "arith.constant"() <{value = dense<1073741824> : tensor<4xi32>}> : () -> tensor<4xi32>
    %8 = "arith.constant"() <{value = dense<1> : tensor<4xi64>}> : () -> tensor<4xi64>
    %9 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %10 = "arith.muli"(%9, %7) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %11 = "arith.extsi"(%10) : (tensor<4xi32>) -> tensor<4xi64>
    %12 = "arith.cmpi"(%11, %8) <{predicate = 2 : i64}> : (tensor<4xi64>, tensor<4xi64>) -> tensor<4xi1>
    %13 = "tt.splat"(%arg3) : (!tt.ptr<f32>) -> tensor<4x!tt.ptr<f32>>
    %14 = "tt.addptr"(%13, %9) : (tensor<4x!tt.ptr<f32>>, tensor<4xi32>) -> tensor<4x!tt.ptr<f32>>
    %15 = "tt.load"(%14, %12, %6) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<4x!tt.ptr<f32>>, tensor<4xi1>, tensor<4xf32>) -> tensor<4xf32>
    "tt.return"(%15) : (tensor<4xf32>) -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> tensor<4xf32>, sym_name = "safe_widen_before_scaled_mask", sym_visibility = "public"}> ({
  ^bb0(%arg2: !tt.ptr<f32>):
    %3 = "arith.constant"() <{value = -9.000000e+00 : f32}> : () -> f32
    %4 = "tts.make_tptr"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<4x!tt.ptr<f32>>
    %5 = "tts.load"(%4, %3) <{operandSegmentSizes = array<i32: 1, 0, 1>, static_mask_dims = array<i64: 3>}> : (tensor<4x!tt.ptr<f32>>, f32) -> tensor<4xf32>
    "tt.return"(%5) : (tensor<4xf32>) -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> tensor<1xf32>, sym_name = "scaled_singleton_upper_mask", sym_visibility = "public"}> ({
  ^bb0(%arg1: !tt.ptr<f32>):
    %2 = "arith.constant"() <{value = dense<-9.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    "tt.return"(%2) : (tensor<1xf32>) -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> tensor<1xf32>, sym_name = "scaled_singleton_lower_mask", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>):
    %0 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 1>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 0>}> : (!tt.ptr<f32>) -> tensor<1x!tt.ptr<f32>>
    %1 = "tts.load"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<1x!tt.ptr<f32>>) -> tensor<1xf32>
    "tt.return"(%1) : (tensor<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

