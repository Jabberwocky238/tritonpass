#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, tensor<128x128x!tt.ptr<f32>>, tensor<128x128x!tt.ptr<f32>>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: tensor<128x128x!tt.ptr<f32>>, %arg3: tensor<128x128x!tt.ptr<f32>>, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32):
    %0 = "tensor.empty"() : () -> tensor<128xi32>
    %1 = "linalg.generic"(%0) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg34: i32):
      %28 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %29 = "arith.index_cast"(%28) : (index) -> i32
      "linalg.yield"(%29) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %2 = "tensor.expand_shape"(%1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xi32>) -> tensor<128x1xi32>
    %3 = "tensor.empty"() : () -> tensor<128x128xi32>
    %4 = "linalg.generic"(%2, %3) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg32: i32, %arg33: i32):
      "linalg.yield"(%arg32) : (i32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<128x1xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
    %5 = "tensor.empty"() : () -> tensor<128xi32>
    %6 = "linalg.generic"(%5) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %7 = "tensor.expand_shape"(%6) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xi32>) -> tensor<1x128xi32>
    %8 = "tensor.empty"() : () -> tensor<128x128xi32>
    %9 = "linalg.generic"(%7, %8) <{indexing_maps = [#map3, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x128xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
    %10 = "linalg.generic"(%4, %9, %4) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %25 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<128x128xi32>, tensor<128x128xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
    %11 = "tensor.empty"() : () -> tensor<128x128x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: !tt.ptr<f32>, %arg25: !tt.ptr<f32>):
      "linalg.yield"(%arg24) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<128x128x!tt.ptr<f32>>) -> tensor<128x128x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %10, %12) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: !tt.ptr<f32>, %arg22: i32, %arg23: !tt.ptr<f32>):
      %24 = "tt.addptr"(%arg21, %arg22) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%24) : (!tt.ptr<f32>) -> ()
    }) : (tensor<128x128x!tt.ptr<f32>>, tensor<128x128xi32>, tensor<128x128x!tt.ptr<f32>>) -> tensor<128x128x!tt.ptr<f32>>
    %14 = "tensor.empty"() : () -> tensor<128x128x!tt.ptr<f32>>
    %15 = "linalg.fill"(%arg1, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<128x128x!tt.ptr<f32>>) -> tensor<128x128x!tt.ptr<f32>>
    %16 = "linalg.generic"(%15, %10, %15) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<128x128x!tt.ptr<f32>>, tensor<128x128xi32>, tensor<128x128x!tt.ptr<f32>>) -> tensor<128x128x!tt.ptr<f32>>
    %17 = "tt.load"(%13) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<128x128x!tt.ptr<f32>>) -> tensor<128x128xf32>
    %18 = "tt.load"(%16) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<128x128x!tt.ptr<f32>>) -> tensor<128x128xf32>
    %19 = "linalg.generic"(%17, %18, %17) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32, %arg15: f32):
      %22 = "arith.addf"(%arg13, %arg14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    %20 = "linalg.generic"(%17, %18, %17) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32, %arg12: f32):
      %21 = "arith.subf"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%21) : (f32) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    "tt.store"(%arg2, %19) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<128x128x!tt.ptr<f32>>, tensor<128x128xf32>) -> ()
    "tt.store"(%arg3, %20) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<128x128x!tt.ptr<f32>>, tensor<128x128xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

