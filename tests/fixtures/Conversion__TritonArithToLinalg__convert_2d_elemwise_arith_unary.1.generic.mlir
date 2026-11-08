#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<i32>, !tt.ptr<f16>, tensor<128x128x!tt.ptr<bf16>>, tensor<128x128x!tt.ptr<f32>>, tensor<128x128x!tt.ptr<f32>>, tensor<128x128x!tt.ptr<f32>>, tensor<128x128x!tt.ptr<f32>>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<i32>, %arg2: !tt.ptr<f16>, %arg3: tensor<128x128x!tt.ptr<bf16>>, %arg4: tensor<128x128x!tt.ptr<f32>>, %arg5: tensor<128x128x!tt.ptr<f32>>, %arg6: tensor<128x128x!tt.ptr<f32>>, %arg7: tensor<128x128x!tt.ptr<f32>>):
    %0 = "tensor.empty"() : () -> tensor<128xi32>
    %1 = "linalg.generic"(%0) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg41: i32):
      %42 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %43 = "arith.index_cast"(%42) : (index) -> i32
      "linalg.yield"(%43) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %2 = "tensor.expand_shape"(%1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xi32>) -> tensor<128x1xi32>
    %3 = "tensor.empty"() : () -> tensor<128x128xi32>
    %4 = "linalg.generic"(%2, %3) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg39: i32, %arg40: i32):
      "linalg.yield"(%arg39) : (i32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<128x1xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
    %5 = "tensor.empty"() : () -> tensor<128xi32>
    %6 = "linalg.generic"(%5) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg38: i32):
      %40 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %41 = "arith.index_cast"(%40) : (index) -> i32
      "linalg.yield"(%41) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %7 = "tensor.expand_shape"(%6) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xi32>) -> tensor<1x128xi32>
    %8 = "tensor.empty"() : () -> tensor<128x128xi32>
    %9 = "linalg.generic"(%7, %8) <{indexing_maps = [#map3, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg36: i32, %arg37: i32):
      "linalg.yield"(%arg36) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x128xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
    %10 = "linalg.generic"(%4, %9, %4) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg33: i32, %arg34: i32, %arg35: i32):
      %39 = "arith.addi"(%arg33, %arg34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%39) : (i32) -> ()
    }) : (tensor<128x128xi32>, tensor<128x128xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
    %11 = "tensor.empty"() : () -> tensor<128x128x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg31: !tt.ptr<f32>, %arg32: !tt.ptr<f32>):
      "linalg.yield"(%arg31) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<128x128x!tt.ptr<f32>>) -> tensor<128x128x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %10, %12) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg28: !tt.ptr<f32>, %arg29: i32, %arg30: !tt.ptr<f32>):
      %38 = "tt.addptr"(%arg28, %arg29) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%38) : (!tt.ptr<f32>) -> ()
    }) : (tensor<128x128x!tt.ptr<f32>>, tensor<128x128xi32>, tensor<128x128x!tt.ptr<f32>>) -> tensor<128x128x!tt.ptr<f32>>
    %14 = "tensor.empty"() : () -> tensor<128x128x!tt.ptr<i32>>
    %15 = "linalg.fill"(%arg1, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg26: !tt.ptr<i32>, %arg27: !tt.ptr<i32>):
      "linalg.yield"(%arg26) : (!tt.ptr<i32>) -> ()
    }) : (!tt.ptr<i32>, tensor<128x128x!tt.ptr<i32>>) -> tensor<128x128x!tt.ptr<i32>>
    %16 = "linalg.generic"(%15, %10, %15) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg23: !tt.ptr<i32>, %arg24: i32, %arg25: !tt.ptr<i32>):
      %37 = "tt.addptr"(%arg23, %arg24) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      "linalg.yield"(%37) : (!tt.ptr<i32>) -> ()
    }) : (tensor<128x128x!tt.ptr<i32>>, tensor<128x128xi32>, tensor<128x128x!tt.ptr<i32>>) -> tensor<128x128x!tt.ptr<i32>>
    %17 = "tensor.empty"() : () -> tensor<128x128x!tt.ptr<f16>>
    %18 = "linalg.fill"(%arg2, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: !tt.ptr<f16>, %arg22: !tt.ptr<f16>):
      "linalg.yield"(%arg21) : (!tt.ptr<f16>) -> ()
    }) : (!tt.ptr<f16>, tensor<128x128x!tt.ptr<f16>>) -> tensor<128x128x!tt.ptr<f16>>
    %19 = "linalg.generic"(%18, %10, %18) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg18: !tt.ptr<f16>, %arg19: i32, %arg20: !tt.ptr<f16>):
      %36 = "tt.addptr"(%arg18, %arg19) : (!tt.ptr<f16>, i32) -> !tt.ptr<f16>
      "linalg.yield"(%36) : (!tt.ptr<f16>) -> ()
    }) : (tensor<128x128x!tt.ptr<f16>>, tensor<128x128xi32>, tensor<128x128x!tt.ptr<f16>>) -> tensor<128x128x!tt.ptr<f16>>
    %20 = "tt.load"(%13) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<128x128x!tt.ptr<f32>>) -> tensor<128x128xf32>
    %21 = "tt.load"(%16) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<128x128x!tt.ptr<i32>>) -> tensor<128x128xi32>
    %22 = "tt.load"(%19) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<128x128x!tt.ptr<f16>>) -> tensor<128x128xf16>
    %23 = "tensor.empty"() : () -> tensor<128x128xbf16>
    %24 = "linalg.generic"(%20, %23) <{indexing_maps = [#map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: f32, %arg17: bf16):
      %35 = "arith.truncf"(%arg16) : (f32) -> bf16
      "linalg.yield"(%35) : (bf16) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xbf16>) -> tensor<128x128xbf16>
    %25 = "linalg.generic"(%20, %20) <{indexing_maps = [#map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %34 = "math.exp"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%34) : (f32) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    %26 = "tensor.empty"() : () -> tensor<128x128xf32>
    %27 = "linalg.generic"(%21, %26) <{indexing_maps = [#map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: i32, %arg13: f32):
      %33 = "arith.sitofp"(%arg12) : (i32) -> f32
      "linalg.yield"(%33) : (f32) -> ()
    }) : (tensor<128x128xi32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    %28 = "tensor.empty"() : () -> tensor<128x128xf32>
    %29 = "linalg.generic"(%22, %28) <{indexing_maps = [#map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f16, %arg11: f32):
      %32 = "arith.extf"(%arg10) : (f16) -> f32
      "linalg.yield"(%32) : (f32) -> ()
    }) : (tensor<128x128xf16>, tensor<128x128xf32>) -> tensor<128x128xf32>
    %30 = "linalg.generic"(%20, %20) <{indexing_maps = [#map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %31 = "math.sqrt"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%31) : (f32) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    "tt.store"(%arg3, %24) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<128x128x!tt.ptr<bf16>>, tensor<128x128xbf16>) -> ()
    "tt.store"(%arg4, %25) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<128x128x!tt.ptr<f32>>, tensor<128x128xf32>) -> ()
    "tt.store"(%arg5, %27) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<128x128x!tt.ptr<f32>>, tensor<128x128xf32>) -> ()
    "tt.store"(%arg6, %29) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<128x128x!tt.ptr<f32>>, tensor<128x128xf32>) -> ()
    "tt.store"(%arg7, %30) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<128x128x!tt.ptr<f32>>, tensor<128x128xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

