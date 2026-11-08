#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %2 = "tensor.empty"() : () -> tensor<512xi32>
    %3 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg36: i32, %arg37: i32):
      "linalg.yield"(%arg36) : (i32) -> ()
    }) : (i32, tensor<512xi32>) -> tensor<512xi32>
    %4 = "tensor.empty"() : () -> tensor<512xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg35: i32):
      %37 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %38 = "arith.index_cast"(%37) : (index) -> i32
      "linalg.yield"(%38) : (i32) -> ()
    }) : (tensor<512xi32>) -> tensor<512xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg32: i32, %arg33: i32, %arg34: i32):
      %36 = "arith.muli"(%arg32, %arg33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%36) : (i32) -> ()
    }) : (tensor<512xi32>, tensor<512xi32>, tensor<512xi32>) -> tensor<512xi32>
    %7 = "tensor.expand_shape"(%6) <{reassociation = [[0, 1]], static_output_shape = array<i64: 512, 1>}> : (tensor<512xi32>) -> tensor<512x1xi32>
    %8 = "tensor.empty"() : () -> tensor<512x256xi32>
    %9 = "linalg.generic"(%7, %8) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: i32, %arg31: i32):
      "linalg.yield"(%arg30) : (i32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<512x1xi32>, tensor<512x256xi32>) -> tensor<512x256xi32>
    %10 = "tensor.empty"() : () -> tensor<256xi32>
    %11 = "linalg.generic"(%10) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg29: i32):
      %34 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %35 = "arith.index_cast"(%34) : (index) -> i32
      "linalg.yield"(%35) : (i32) -> ()
    }) : (tensor<256xi32>) -> tensor<256xi32>
    %12 = "tensor.expand_shape"(%11) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 256>}> : (tensor<256xi32>) -> tensor<1x256xi32>
    %13 = "tensor.empty"() : () -> tensor<512x256xi32>
    %14 = "linalg.generic"(%12, %13) <{indexing_maps = [#map3, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg27: i32, %arg28: i32):
      "linalg.yield"(%arg27) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x256xi32>, tensor<512x256xi32>) -> tensor<512x256xi32>
    %15 = "linalg.generic"(%9, %14, %9) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32, %arg26: i32):
      %33 = "arith.addi"(%arg24, %arg25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%33) : (i32) -> ()
    }) : (tensor<512x256xi32>, tensor<512x256xi32>, tensor<512x256xi32>) -> tensor<512x256xi32>
    %16 = "tensor.empty"() : () -> tensor<512x256x!tt.ptr<bf16>>
    %17 = "linalg.fill"(%arg0, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg22: !tt.ptr<bf16>, %arg23: !tt.ptr<bf16>):
      "linalg.yield"(%arg22) : (!tt.ptr<bf16>) -> ()
    }) : (!tt.ptr<bf16>, tensor<512x256x!tt.ptr<bf16>>) -> tensor<512x256x!tt.ptr<bf16>>
    %18 = "linalg.generic"(%17, %15, %17) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg19: !tt.ptr<bf16>, %arg20: i32, %arg21: !tt.ptr<bf16>):
      %32 = "tt.addptr"(%arg19, %arg20) : (!tt.ptr<bf16>, i32) -> !tt.ptr<bf16>
      "linalg.yield"(%32) : (!tt.ptr<bf16>) -> ()
    }) : (tensor<512x256x!tt.ptr<bf16>>, tensor<512x256xi32>, tensor<512x256x!tt.ptr<bf16>>) -> tensor<512x256x!tt.ptr<bf16>>
    %19 = "tensor.empty"() : () -> tensor<256x!tt.ptr<bf16>>
    %20 = "linalg.fill"(%arg1, %19) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: !tt.ptr<bf16>, %arg18: !tt.ptr<bf16>):
      "linalg.yield"(%arg17) : (!tt.ptr<bf16>) -> ()
    }) : (!tt.ptr<bf16>, tensor<256x!tt.ptr<bf16>>) -> tensor<256x!tt.ptr<bf16>>
    %21 = "linalg.generic"(%20, %11, %20) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg14: !tt.ptr<bf16>, %arg15: i32, %arg16: !tt.ptr<bf16>):
      %31 = "tt.addptr"(%arg14, %arg15) : (!tt.ptr<bf16>, i32) -> !tt.ptr<bf16>
      "linalg.yield"(%31) : (!tt.ptr<bf16>) -> ()
    }) : (tensor<256x!tt.ptr<bf16>>, tensor<256xi32>, tensor<256x!tt.ptr<bf16>>) -> tensor<256x!tt.ptr<bf16>>
    %22 = "tt.load"(%18) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<512x256x!tt.ptr<bf16>>) -> tensor<512x256xbf16>
    %23 = "tensor.empty"() : () -> tensor<256xf32>
    %24 = "linalg.fill"(%0, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, tensor<256xf32>) -> tensor<256xf32>
    %25 = "linalg.reduce"(%22, %24) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg10: bf16, %arg11: f32):
      %29 = "arith.extf"(%arg10) : (bf16) -> f32
      %30 = "arith.addf"(%29, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%30) : (f32) -> ()
    }) : (tensor<512x256xbf16>, tensor<256xf32>) -> tensor<256xf32>
    %26 = "tensor.empty"() : () -> tensor<256xbf16>
    %27 = "linalg.generic"(%25, %26) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: bf16):
      %28 = "arith.truncf"(%arg8) : (f32) -> bf16
      "linalg.yield"(%28) : (bf16) -> ()
    }) : (tensor<256xf32>, tensor<256xbf16>) -> tensor<256xbf16>
    "tt.store"(%21, %27) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<256x!tt.ptr<bf16>>, tensor<256xbf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

