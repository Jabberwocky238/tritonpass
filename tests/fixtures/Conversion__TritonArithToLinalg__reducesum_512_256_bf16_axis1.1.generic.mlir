#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %2 = "tensor.empty"() : () -> tensor<512xi32>
    %3 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: i32, %arg31: i32):
      "linalg.yield"(%arg30) : (i32) -> ()
    }) : (i32, tensor<512xi32>) -> tensor<512xi32>
    %4 = "tensor.empty"() : () -> tensor<512xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg29: i32):
      %37 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %38 = "arith.index_cast"(%37) : (index) -> i32
      "linalg.yield"(%38) : (i32) -> ()
    }) : (tensor<512xi32>) -> tensor<512xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %36 = "arith.muli"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%36) : (i32) -> ()
    }) : (tensor<512xi32>, tensor<512xi32>, tensor<512xi32>) -> tensor<512xi32>
    %7 = "tensor.expand_shape"(%6) <{reassociation = [[0, 1]], static_output_shape = array<i64: 512, 1>}> : (tensor<512xi32>) -> tensor<512x1xi32>
    %8 = "tensor.empty"() : () -> tensor<512x256xi32>
    %9 = "linalg.generic"(%7, %8) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<512x1xi32>, tensor<512x256xi32>) -> tensor<512x256xi32>
    %10 = "tensor.empty"() : () -> tensor<256xi32>
    %11 = "linalg.generic"(%10) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg23: i32):
      %34 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %35 = "arith.index_cast"(%34) : (index) -> i32
      "linalg.yield"(%35) : (i32) -> ()
    }) : (tensor<256xi32>) -> tensor<256xi32>
    %12 = "tensor.expand_shape"(%11) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 256>}> : (tensor<256xi32>) -> tensor<1x256xi32>
    %13 = "tensor.empty"() : () -> tensor<512x256xi32>
    %14 = "linalg.generic"(%12, %13) <{indexing_maps = [#map3, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32):
      "linalg.yield"(%arg21) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x256xi32>, tensor<512x256xi32>) -> tensor<512x256xi32>
    %15 = "linalg.generic"(%9, %14, %9) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32, %arg20: i32):
      %33 = "arith.addi"(%arg18, %arg19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%33) : (i32) -> ()
    }) : (tensor<512x256xi32>, tensor<512x256xi32>, tensor<512x256xi32>) -> tensor<512x256xi32>
    %16 = "tensor.empty"() : () -> tensor<512x256x!tt.ptr<bf16>>
    %17 = "linalg.fill"(%arg0, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: !tt.ptr<bf16>, %arg17: !tt.ptr<bf16>):
      "linalg.yield"(%arg16) : (!tt.ptr<bf16>) -> ()
    }) : (!tt.ptr<bf16>, tensor<512x256x!tt.ptr<bf16>>) -> tensor<512x256x!tt.ptr<bf16>>
    %18 = "linalg.generic"(%17, %15, %17) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg13: !tt.ptr<bf16>, %arg14: i32, %arg15: !tt.ptr<bf16>):
      %32 = "tt.addptr"(%arg13, %arg14) : (!tt.ptr<bf16>, i32) -> !tt.ptr<bf16>
      "linalg.yield"(%32) : (!tt.ptr<bf16>) -> ()
    }) : (tensor<512x256x!tt.ptr<bf16>>, tensor<512x256xi32>, tensor<512x256x!tt.ptr<bf16>>) -> tensor<512x256x!tt.ptr<bf16>>
    %19 = "tensor.empty"() : () -> tensor<512x!tt.ptr<bf16>>
    %20 = "linalg.fill"(%arg1, %19) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: !tt.ptr<bf16>, %arg12: !tt.ptr<bf16>):
      "linalg.yield"(%arg11) : (!tt.ptr<bf16>) -> ()
    }) : (!tt.ptr<bf16>, tensor<512x!tt.ptr<bf16>>) -> tensor<512x!tt.ptr<bf16>>
    %21 = "linalg.generic"(%20, %5, %20) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg8: !tt.ptr<bf16>, %arg9: i32, %arg10: !tt.ptr<bf16>):
      %31 = "tt.addptr"(%arg8, %arg9) : (!tt.ptr<bf16>, i32) -> !tt.ptr<bf16>
      "linalg.yield"(%31) : (!tt.ptr<bf16>) -> ()
    }) : (tensor<512x!tt.ptr<bf16>>, tensor<512xi32>, tensor<512x!tt.ptr<bf16>>) -> tensor<512x!tt.ptr<bf16>>
    %22 = "tt.load"(%18) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<512x256x!tt.ptr<bf16>>) -> tensor<512x256xbf16>
    %23 = "tensor.empty"() : () -> tensor<512xf32>
    %24 = "linalg.fill"(%0, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<512xf32>) -> tensor<512xf32>
    %25 = "linalg.reduce"(%22, %24) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg4: bf16, %arg5: f32):
      %29 = "arith.extf"(%arg4) : (bf16) -> f32
      %30 = "arith.addf"(%29, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%30) : (f32) -> ()
    }) : (tensor<512x256xbf16>, tensor<512xf32>) -> tensor<512xf32>
    %26 = "tensor.empty"() : () -> tensor<512xbf16>
    %27 = "linalg.generic"(%25, %26) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: bf16):
      %28 = "arith.truncf"(%arg2) : (f32) -> bf16
      "linalg.yield"(%28) : (bf16) -> ()
    }) : (tensor<512xf32>, tensor<512xbf16>) -> tensor<512xbf16>
    "tt.store"(%21, %27) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<512x!tt.ptr<bf16>>, tensor<512xbf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

