#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "test_1"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "tensor.empty"() : () -> tensor<4xi32>
    %3 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: i32, %arg15: i32):
      "linalg.yield"(%arg14) : (i32) -> ()
    }) : (i32, tensor<4xi32>) -> tensor<4xi32>
    %4 = "tt.addptr"(%arg0, %arg5) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
    %5 = "tt.load"(%4) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<f32>) -> f32
    %6 = "arith.cmpf"(%5, %0) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    "cf.cond_br"(%6)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    %7 = "tensor.empty"() : () -> tensor<4xi32>
    %8 = "linalg.generic"(%7) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg13: i32):
      %15 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %16 = "arith.index_cast"(%15) : (index) -> i32
      "linalg.yield"(%16) : (i32) -> ()
    }) : (tensor<4xi32>) -> tensor<4xi32>
    %9 = "linalg.generic"(%8, %3, %8) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: i32, %arg11: i32, %arg12: i32):
      %14 = "arith.addi"(%arg10, %arg11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%14) : (i32) -> ()
    }) : (tensor<4xi32>, tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %10 = "tts.make_tptr"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<4x!tt.ptr<f32>>
    %11 = "tensor.empty"() : () -> tensor<4xf32>
    %12 = "linalg.generic"(%9, %11) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: i32, %arg9: f32):
      %13 = "arith.sitofp"(%arg8) : (i32) -> f32
      "linalg.yield"(%13) : (f32) -> ()
    }) : (tensor<4xi32>, tensor<4xf32>) -> tensor<4xf32>
    "tts.store"(%10, %12) <{static_mask_dims = array<i64>}> : (tensor<4x!tt.ptr<f32>>, tensor<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

