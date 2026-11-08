#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>) -> (), sym_name = "test_1"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "tensor.empty"() : () -> tensor<4xi32>
    %3 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: i32, %arg9: i32):
      "linalg.yield"(%arg8) : (i32) -> ()
    }) : (i32, tensor<4xi32>) -> tensor<4xi32>
    %4 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %5 = "arith.index_cast"(%4) : (index) -> i32
    %6 = "tt.addptr"(%arg0, %5) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
    %7 = "tt.load"(%6) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<f32>) -> f32
    %8 = "arith.cmpf"(%7, %0) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    "cf.cond_br"(%8)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    %9 = "tensor.empty"() : () -> tensor<4xi32>
    %10 = "linalg.generic"(%9) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg7: i32):
      %17 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %18 = "arith.index_cast"(%17) : (index) -> i32
      "linalg.yield"(%18) : (i32) -> ()
    }) : (tensor<4xi32>) -> tensor<4xi32>
    %11 = "linalg.generic"(%10, %3, %10) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg4: i32, %arg5: i32, %arg6: i32):
      %16 = "arith.addi"(%arg4, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%16) : (i32) -> ()
    }) : (tensor<4xi32>, tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %12 = "tts.make_tptr"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<4x!tt.ptr<f32>>
    %13 = "tensor.empty"() : () -> tensor<4xf32>
    %14 = "linalg.generic"(%11, %13) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: i32, %arg3: f32):
      %15 = "arith.sitofp"(%arg2) : (i32) -> f32
      "linalg.yield"(%15) : (f32) -> ()
    }) : (tensor<4xi32>, tensor<4xf32>) -> tensor<4xf32>
    "tts.store"(%12, %14) <{static_mask_dims = array<i64>}> : (tensor<4x!tt.ptr<f32>>, tensor<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

