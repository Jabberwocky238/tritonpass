#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1, 0)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map5 = affine_map<(d0, d1) -> (0, d1)>
#map6 = affine_map<(d0, d1, d2) -> (0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, tensor<32x16x!tt.ptr<bf16>>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>, %arg2: tensor<32x16x!tt.ptr<bf16>>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg38: i32, %arg39: i32):
      "linalg.yield"(%arg38) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg37: i32):
      %51 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %52 = "arith.index_cast"(%51) : (index) -> i32
      "linalg.yield"(%52) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg34: i32, %arg35: i32, %arg36: i32):
      %50 = "arith.muli"(%arg34, %arg35) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%50) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.expand_shape"(%6) <{reassociation = [[0, 1]], static_output_shape = array<i64: 32, 1>}> : (tensor<32xi32>) -> tensor<32x1xi32>
    %8 = "tensor.empty"() : () -> tensor<32x256xi32>
    %9 = "linalg.generic"(%7, %8) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg32: i32, %arg33: i32):
      "linalg.yield"(%arg32) : (i32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<32x1xi32>, tensor<32x256xi32>) -> tensor<32x256xi32>
    %10 = "tensor.expand_shape"(%9) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 32, 256, 1>}> : (tensor<32x256xi32>) -> tensor<32x256x1xi32>
    %11 = "tensor.empty"() : () -> tensor<32x256x16xi32>
    %12 = "linalg.generic"(%10, %11) <{indexing_maps = [#map3, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: i32, %arg31: i32):
      "linalg.yield"(%arg30) : (i32) -> ()
    }) {broadcastDims = array<i64: 2>} : (tensor<32x256x1xi32>, tensor<32x256x16xi32>) -> tensor<32x256x16xi32>
    %13 = "tensor.empty"() : () -> tensor<256xi32>
    %14 = "linalg.generic"(%13) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg29: i32):
      %48 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %49 = "arith.index_cast"(%48) : (index) -> i32
      "linalg.yield"(%49) : (i32) -> ()
    }) : (tensor<256xi32>) -> tensor<256xi32>
    %15 = "tensor.expand_shape"(%14) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 256>}> : (tensor<256xi32>) -> tensor<1x256xi32>
    %16 = "tensor.empty"() : () -> tensor<32x256xi32>
    %17 = "linalg.generic"(%15, %16) <{indexing_maps = [#map5, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg27: i32, %arg28: i32):
      "linalg.yield"(%arg27) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x256xi32>, tensor<32x256xi32>) -> tensor<32x256xi32>
    %18 = "tensor.expand_shape"(%17) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 32, 256, 1>}> : (tensor<32x256xi32>) -> tensor<32x256x1xi32>
    %19 = "tensor.empty"() : () -> tensor<32x256x16xi32>
    %20 = "linalg.generic"(%18, %19) <{indexing_maps = [#map3, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: i32, %arg26: i32):
      "linalg.yield"(%arg25) : (i32) -> ()
    }) {broadcastDims = array<i64: 2>} : (tensor<32x256x1xi32>, tensor<32x256x16xi32>) -> tensor<32x256x16xi32>
    %21 = "tensor.empty"() : () -> tensor<16xi32>
    %22 = "linalg.generic"(%21) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg24: i32):
      %46 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %47 = "arith.index_cast"(%46) : (index) -> i32
      "linalg.yield"(%47) : (i32) -> ()
    }) : (tensor<16xi32>) -> tensor<16xi32>
    %23 = "tensor.expand_shape"(%22) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 16>}> : (tensor<16xi32>) -> tensor<1x16xi32>
    %24 = "tensor.empty"() : () -> tensor<256x16xi32>
    %25 = "linalg.generic"(%23, %24) <{indexing_maps = [#map5, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg22: i32, %arg23: i32):
      "linalg.yield"(%arg22) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x16xi32>, tensor<256x16xi32>) -> tensor<256x16xi32>
    %26 = "tensor.expand_shape"(%25) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 256, 16>}> : (tensor<256x16xi32>) -> tensor<1x256x16xi32>
    %27 = "tensor.empty"() : () -> tensor<32x256x16xi32>
    %28 = "linalg.generic"(%26, %27) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32):
      "linalg.yield"(%arg20) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x256x16xi32>, tensor<32x256x16xi32>) -> tensor<32x256x16xi32>
    %29 = "linalg.generic"(%12, %20, %12) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg17: i32, %arg18: i32, %arg19: i32):
      %45 = "arith.addi"(%arg17, %arg18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%45) : (i32) -> ()
    }) : (tensor<32x256x16xi32>, tensor<32x256x16xi32>, tensor<32x256x16xi32>) -> tensor<32x256x16xi32>
    %30 = "linalg.generic"(%29, %28, %29) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg14: i32, %arg15: i32, %arg16: i32):
      %44 = "arith.addi"(%arg14, %arg15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%44) : (i32) -> ()
    }) : (tensor<32x256x16xi32>, tensor<32x256x16xi32>, tensor<32x256x16xi32>) -> tensor<32x256x16xi32>
    %31 = "tensor.empty"() : () -> tensor<32x256x16x!tt.ptr<bf16>>
    %32 = "linalg.fill"(%arg0, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<bf16>, %arg13: !tt.ptr<bf16>):
      "linalg.yield"(%arg12) : (!tt.ptr<bf16>) -> ()
    }) : (!tt.ptr<bf16>, tensor<32x256x16x!tt.ptr<bf16>>) -> tensor<32x256x16x!tt.ptr<bf16>>
    %33 = "linalg.generic"(%32, %30, %32) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<bf16>, %arg10: i32, %arg11: !tt.ptr<bf16>):
      %43 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<bf16>, i32) -> !tt.ptr<bf16>
      "linalg.yield"(%43) : (!tt.ptr<bf16>) -> ()
    }) : (tensor<32x256x16x!tt.ptr<bf16>>, tensor<32x256x16xi32>, tensor<32x256x16x!tt.ptr<bf16>>) -> tensor<32x256x16x!tt.ptr<bf16>>
    %34 = "tt.load"(%33) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<32x256x16x!tt.ptr<bf16>>) -> tensor<32x256x16xbf16>
    %35 = "tensor.empty"() : () -> tensor<32x16xf32>
    %36 = "linalg.fill"(%0, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32):
      "linalg.yield"(%arg7) : (f32) -> ()
    }) : (f32, tensor<32x16xf32>) -> tensor<32x16xf32>
    %37 = "linalg.reduce"(%34, %36) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg5: bf16, %arg6: f32):
      %41 = "arith.extf"(%arg5) : (bf16) -> f32
      %42 = "arith.addf"(%41, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%42) : (f32) -> ()
    }) : (tensor<32x256x16xbf16>, tensor<32x16xf32>) -> tensor<32x16xf32>
    %38 = "tensor.empty"() : () -> tensor<32x16xbf16>
    %39 = "linalg.generic"(%37, %38) <{indexing_maps = [#map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: bf16):
      %40 = "arith.truncf"(%arg3) : (f32) -> bf16
      "linalg.yield"(%40) : (bf16) -> ()
    }) : (tensor<32x16xf32>, tensor<32x16xbf16>) -> tensor<32x16xbf16>
    "tt.store"(%arg2, %39) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x16x!tt.ptr<bf16>>, tensor<32x16xbf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

