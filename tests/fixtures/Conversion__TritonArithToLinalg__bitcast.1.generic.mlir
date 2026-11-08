#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<i32>, !tt.ptr<f32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: !tt.ptr<f32>):
    %0 = "tensor.empty"() : () -> tensor<1024xi32>
    %1 = "linalg.generic"(%0) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg14: i32):
      %14 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %15 = "arith.index_cast"(%14) : (index) -> i32
      "linalg.yield"(%15) : (i32) -> ()
    }) : (tensor<1024xi32>) -> tensor<1024xi32>
    %2 = "tensor.empty"() : () -> tensor<1024x!tt.ptr<i32>>
    %3 = "linalg.fill"(%arg0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<i32>, %arg13: !tt.ptr<i32>):
      "linalg.yield"(%arg12) : (!tt.ptr<i32>) -> ()
    }) : (!tt.ptr<i32>, tensor<1024x!tt.ptr<i32>>) -> tensor<1024x!tt.ptr<i32>>
    %4 = "linalg.generic"(%3, %1, %3) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<i32>, %arg10: i32, %arg11: !tt.ptr<i32>):
      %13 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      "linalg.yield"(%13) : (!tt.ptr<i32>) -> ()
    }) : (tensor<1024x!tt.ptr<i32>>, tensor<1024xi32>, tensor<1024x!tt.ptr<i32>>) -> tensor<1024x!tt.ptr<i32>>
    %5 = "tensor.empty"() : () -> tensor<1024x!tt.ptr<f32>>
    %6 = "linalg.fill"(%arg1, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: !tt.ptr<f32>, %arg8: !tt.ptr<f32>):
      "linalg.yield"(%arg7) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<1024x!tt.ptr<f32>>) -> tensor<1024x!tt.ptr<f32>>
    %7 = "linalg.generic"(%6, %1, %6) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg4: !tt.ptr<f32>, %arg5: i32, %arg6: !tt.ptr<f32>):
      %12 = "tt.addptr"(%arg4, %arg5) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%12) : (!tt.ptr<f32>) -> ()
    }) : (tensor<1024x!tt.ptr<f32>>, tensor<1024xi32>, tensor<1024x!tt.ptr<f32>>) -> tensor<1024x!tt.ptr<f32>>
    %8 = "tt.load"(%4) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<1024x!tt.ptr<i32>>) -> tensor<1024xi32>
    %9 = "tensor.empty"() : () -> tensor<1024xf32>
    %10 = "linalg.generic"(%8, %9) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: i32, %arg3: f32):
      %11 = "arith.bitcast"(%arg2) : (i32) -> f32
      "linalg.yield"(%11) : (f32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xf32>) -> tensor<1024xf32>
    "tt.store"(%7, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<1024x!tt.ptr<f32>>, tensor<1024xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

