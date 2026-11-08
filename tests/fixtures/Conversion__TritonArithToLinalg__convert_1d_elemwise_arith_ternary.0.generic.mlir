#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<i1>, !tt.ptr<f32>, !tt.ptr<f32>, tensor<1024x!tt.ptr<f32>>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<i1>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<f32>, %arg3: tensor<1024x!tt.ptr<f32>>, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32):
    %0 = "tensor.empty"() : () -> tensor<1024xi32>
    %1 = "linalg.generic"(%0) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg29: i32):
      %19 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %20 = "arith.index_cast"(%19) : (index) -> i32
      "linalg.yield"(%20) : (i32) -> ()
    }) : (tensor<1024xi32>) -> tensor<1024xi32>
    %2 = "tensor.empty"() : () -> tensor<1024x!tt.ptr<i1>>
    %3 = "linalg.fill"(%arg0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg27: !tt.ptr<i1>, %arg28: !tt.ptr<i1>):
      "linalg.yield"(%arg27) : (!tt.ptr<i1>) -> ()
    }) : (!tt.ptr<i1>, tensor<1024x!tt.ptr<i1>>) -> tensor<1024x!tt.ptr<i1>>
    %4 = "linalg.generic"(%3, %1, %3) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg24: !tt.ptr<i1>, %arg25: i32, %arg26: !tt.ptr<i1>):
      %18 = "tt.addptr"(%arg24, %arg25) : (!tt.ptr<i1>, i32) -> !tt.ptr<i1>
      "linalg.yield"(%18) : (!tt.ptr<i1>) -> ()
    }) : (tensor<1024x!tt.ptr<i1>>, tensor<1024xi32>, tensor<1024x!tt.ptr<i1>>) -> tensor<1024x!tt.ptr<i1>>
    %5 = "tensor.empty"() : () -> tensor<1024x!tt.ptr<f32>>
    %6 = "linalg.fill"(%arg1, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg22: !tt.ptr<f32>, %arg23: !tt.ptr<f32>):
      "linalg.yield"(%arg22) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<1024x!tt.ptr<f32>>) -> tensor<1024x!tt.ptr<f32>>
    %7 = "linalg.generic"(%6, %1, %6) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: i32, %arg21: !tt.ptr<f32>):
      %17 = "tt.addptr"(%arg19, %arg20) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%17) : (!tt.ptr<f32>) -> ()
    }) : (tensor<1024x!tt.ptr<f32>>, tensor<1024xi32>, tensor<1024x!tt.ptr<f32>>) -> tensor<1024x!tt.ptr<f32>>
    %8 = "tensor.empty"() : () -> tensor<1024x!tt.ptr<f32>>
    %9 = "linalg.fill"(%arg2, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: !tt.ptr<f32>, %arg18: !tt.ptr<f32>):
      "linalg.yield"(%arg17) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<1024x!tt.ptr<f32>>) -> tensor<1024x!tt.ptr<f32>>
    %10 = "linalg.generic"(%9, %1, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg14: !tt.ptr<f32>, %arg15: i32, %arg16: !tt.ptr<f32>):
      %16 = "tt.addptr"(%arg14, %arg15) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%16) : (!tt.ptr<f32>) -> ()
    }) : (tensor<1024x!tt.ptr<f32>>, tensor<1024xi32>, tensor<1024x!tt.ptr<f32>>) -> tensor<1024x!tt.ptr<f32>>
    %11 = "tt.load"(%4) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<1024x!tt.ptr<i1>>) -> tensor<1024xi1>
    %12 = "tt.load"(%7) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<1024x!tt.ptr<f32>>) -> tensor<1024xf32>
    %13 = "tt.load"(%10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<1024x!tt.ptr<f32>>) -> tensor<1024xf32>
    %14 = "linalg.generic"(%11, %12, %13, %12) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg10: i1, %arg11: f32, %arg12: f32, %arg13: f32):
      %15 = "arith.select"(%arg10, %arg11, %arg12) : (i1, f32, f32) -> f32
      "linalg.yield"(%15) : (f32) -> ()
    }) : (tensor<1024xi1>, tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    "tt.store"(%arg3, %14) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<1024x!tt.ptr<f32>>, tensor<1024xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

