#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %2 = "tensor.empty"() : () -> tensor<512xi32>
    %3 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg28: i32, %arg29: i32):
      "linalg.yield"(%arg28) : (i32) -> ()
    }) : (i32, tensor<512xi32>) -> tensor<512xi32>
    %4 = "tensor.empty"() : () -> tensor<512xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg27: i32):
      %33 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %34 = "arith.index_cast"(%33) : (index) -> i32
      "linalg.yield"(%34) : (i32) -> ()
    }) : (tensor<512xi32>) -> tensor<512xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32, %arg26: i32):
      %32 = "arith.muli"(%arg24, %arg25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%32) : (i32) -> ()
    }) : (tensor<512xi32>, tensor<512xi32>, tensor<512xi32>) -> tensor<512xi32>
    %7 = "tensor.expand_shape"(%6) <{reassociation = [[0, 1]], static_output_shape = array<i64: 512, 1>}> : (tensor<512xi32>) -> tensor<512x1xi32>
    %8 = "tensor.empty"() : () -> tensor<512x256xi32>
    %9 = "linalg.generic"(%7, %8) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg22: i32, %arg23: i32):
      "linalg.yield"(%arg22) : (i32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<512x1xi32>, tensor<512x256xi32>) -> tensor<512x256xi32>
    %10 = "tensor.empty"() : () -> tensor<256xi32>
    %11 = "linalg.generic"(%10) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg21: i32):
      %30 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %31 = "arith.index_cast"(%30) : (index) -> i32
      "linalg.yield"(%31) : (i32) -> ()
    }) : (tensor<256xi32>) -> tensor<256xi32>
    %12 = "tensor.expand_shape"(%11) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 256>}> : (tensor<256xi32>) -> tensor<1x256xi32>
    %13 = "tensor.empty"() : () -> tensor<512x256xi32>
    %14 = "linalg.generic"(%12, %13) <{indexing_maps = [#map3, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: i32, %arg20: i32):
      "linalg.yield"(%arg19) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x256xi32>, tensor<512x256xi32>) -> tensor<512x256xi32>
    %15 = "linalg.generic"(%9, %14, %9) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: i32, %arg17: i32, %arg18: i32):
      %29 = "arith.addi"(%arg16, %arg17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%29) : (i32) -> ()
    }) : (tensor<512x256xi32>, tensor<512x256xi32>, tensor<512x256xi32>) -> tensor<512x256xi32>
    %16 = "tensor.empty"() : () -> tensor<512x256x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg0, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: !tt.ptr<f32>, %arg15: !tt.ptr<f32>):
      "linalg.yield"(%arg14) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<512x256x!tt.ptr<f32>>) -> tensor<512x256x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %15, %17) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg11: !tt.ptr<f32>, %arg12: i32, %arg13: !tt.ptr<f32>):
      %28 = "tt.addptr"(%arg11, %arg12) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%28) : (!tt.ptr<f32>) -> ()
    }) : (tensor<512x256x!tt.ptr<f32>>, tensor<512x256xi32>, tensor<512x256x!tt.ptr<f32>>) -> tensor<512x256x!tt.ptr<f32>>
    %19 = "tensor.empty"() : () -> tensor<512x!tt.ptr<f32>>
    %20 = "linalg.fill"(%arg1, %19) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: !tt.ptr<f32>):
      "linalg.yield"(%arg9) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<512x!tt.ptr<f32>>) -> tensor<512x!tt.ptr<f32>>
    %21 = "linalg.generic"(%20, %5, %20) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: i32, %arg8: !tt.ptr<f32>):
      %27 = "tt.addptr"(%arg6, %arg7) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%27) : (!tt.ptr<f32>) -> ()
    }) : (tensor<512x!tt.ptr<f32>>, tensor<512xi32>, tensor<512x!tt.ptr<f32>>) -> tensor<512x!tt.ptr<f32>>
    %22 = "tt.load"(%18) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<512x256x!tt.ptr<f32>>) -> tensor<512x256xf32>
    %23 = "tensor.empty"() : () -> tensor<512xf32>
    %24 = "linalg.fill"(%0, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<512xf32>) -> tensor<512xf32>
    %25 = "linalg.reduce"(%22, %24) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %26 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%26) : (f32) -> ()
    }) : (tensor<512x256xf32>, tensor<512xf32>) -> tensor<512xf32>
    "tt.store"(%21, %25) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<512x!tt.ptr<f32>>, tensor<512xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

