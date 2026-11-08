#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<i1>, !tt.ptr<f32>, !tt.ptr<f32>, tensor<128x128x!tt.ptr<f32>>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<i1>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<f32>, %arg3: tensor<128x128x!tt.ptr<f32>>):
    %0 = "tensor.empty"() : () -> tensor<128xi32>
    %1 = "linalg.generic"(%0) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %31 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %32 = "arith.index_cast"(%31) : (index) -> i32
      "linalg.yield"(%32) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %2 = "tensor.expand_shape"(%1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xi32>) -> tensor<128x1xi32>
    %3 = "tensor.empty"() : () -> tensor<128x128xi32>
    %4 = "linalg.generic"(%2, %3) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<128x1xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
    %5 = "tensor.empty"() : () -> tensor<128xi32>
    %6 = "linalg.generic"(%5) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg28: i32):
      %29 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %30 = "arith.index_cast"(%29) : (index) -> i32
      "linalg.yield"(%30) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %7 = "tensor.expand_shape"(%6) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xi32>) -> tensor<1x128xi32>
    %8 = "tensor.empty"() : () -> tensor<128x128xi32>
    %9 = "linalg.generic"(%7, %8) <{indexing_maps = [#map3, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32):
      "linalg.yield"(%arg26) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x128xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
    %10 = "linalg.generic"(%4, %9, %4) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32, %arg25: i32):
      %28 = "arith.addi"(%arg23, %arg24) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%28) : (i32) -> ()
    }) : (tensor<128x128xi32>, tensor<128x128xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
    %11 = "tensor.empty"() : () -> tensor<128x128x!tt.ptr<i1>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: !tt.ptr<i1>, %arg22: !tt.ptr<i1>):
      "linalg.yield"(%arg21) : (!tt.ptr<i1>) -> ()
    }) : (!tt.ptr<i1>, tensor<128x128x!tt.ptr<i1>>) -> tensor<128x128x!tt.ptr<i1>>
    %13 = "linalg.generic"(%12, %10, %12) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg18: !tt.ptr<i1>, %arg19: i32, %arg20: !tt.ptr<i1>):
      %27 = "tt.addptr"(%arg18, %arg19) : (!tt.ptr<i1>, i32) -> !tt.ptr<i1>
      "linalg.yield"(%27) : (!tt.ptr<i1>) -> ()
    }) : (tensor<128x128x!tt.ptr<i1>>, tensor<128x128xi32>, tensor<128x128x!tt.ptr<i1>>) -> tensor<128x128x!tt.ptr<i1>>
    %14 = "tensor.empty"() : () -> tensor<128x128x!tt.ptr<f32>>
    %15 = "linalg.fill"(%arg1, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: !tt.ptr<f32>):
      "linalg.yield"(%arg16) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<128x128x!tt.ptr<f32>>) -> tensor<128x128x!tt.ptr<f32>>
    %16 = "linalg.generic"(%15, %10, %15) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: i32, %arg15: !tt.ptr<f32>):
      %26 = "tt.addptr"(%arg13, %arg14) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%26) : (!tt.ptr<f32>) -> ()
    }) : (tensor<128x128x!tt.ptr<f32>>, tensor<128x128xi32>, tensor<128x128x!tt.ptr<f32>>) -> tensor<128x128x!tt.ptr<f32>>
    %17 = "tensor.empty"() : () -> tensor<128x128x!tt.ptr<f32>>
    %18 = "linalg.fill"(%arg2, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: !tt.ptr<f32>, %arg12: !tt.ptr<f32>):
      "linalg.yield"(%arg11) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<128x128x!tt.ptr<f32>>) -> tensor<128x128x!tt.ptr<f32>>
    %19 = "linalg.generic"(%18, %10, %18) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg8: !tt.ptr<f32>, %arg9: i32, %arg10: !tt.ptr<f32>):
      %25 = "tt.addptr"(%arg8, %arg9) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%25) : (!tt.ptr<f32>) -> ()
    }) : (tensor<128x128x!tt.ptr<f32>>, tensor<128x128xi32>, tensor<128x128x!tt.ptr<f32>>) -> tensor<128x128x!tt.ptr<f32>>
    %20 = "tt.load"(%13) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<128x128x!tt.ptr<i1>>) -> tensor<128x128xi1>
    %21 = "tt.load"(%16) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<128x128x!tt.ptr<f32>>) -> tensor<128x128xf32>
    %22 = "tt.load"(%19) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<128x128x!tt.ptr<f32>>) -> tensor<128x128xf32>
    %23 = "linalg.generic"(%20, %21, %22, %21) <{indexing_maps = [#map2, #map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg4: i1, %arg5: f32, %arg6: f32, %arg7: f32):
      %24 = "arith.select"(%arg4, %arg5, %arg6) : (i1, f32, f32) -> f32
      "linalg.yield"(%24) : (f32) -> ()
    }) : (tensor<128x128xi1>, tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    "tt.store"(%arg3, %23) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<128x128x!tt.ptr<f32>>, tensor<128x128xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

