#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (0, d1)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map6 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, !tt.ptr<bf16>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>, %arg2: !tt.ptr<bf16>):
    %0 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %2 = "tensor.empty"() : () -> tensor<128xi32>
    %3 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg61: i32, %arg62: i32):
      "linalg.yield"(%arg61) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %4 = "tensor.empty"() : () -> tensor<64xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg59: i32, %arg60: i32):
      "linalg.yield"(%arg59) : (i32) -> ()
    }) : (i32, tensor<64xi32>) -> tensor<64xi32>
    %6 = "tensor.empty"() : () -> tensor<128xi32>
    %7 = "linalg.fill"(%0, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg57: i32, %arg58: i32):
      "linalg.yield"(%arg57) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %8 = "tensor.empty"() : () -> tensor<128xi32>
    %9 = "linalg.generic"(%8) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg56: i32):
      %72 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %73 = "arith.index_cast"(%72) : (index) -> i32
      "linalg.yield"(%73) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %10 = "linalg.generic"(%9, %7, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg53: i32, %arg54: i32, %arg55: i32):
      %71 = "arith.muli"(%arg53, %arg54) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%71) : (i32) -> ()
    }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
    %11 = "tensor.expand_shape"(%10) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xi32>) -> tensor<128x1xi32>
    %12 = "tensor.empty"() : () -> tensor<128x64xi32>
    %13 = "linalg.generic"(%11, %12) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg51: i32, %arg52: i32):
      "linalg.yield"(%arg51) : (i32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<128x1xi32>, tensor<128x64xi32>) -> tensor<128x64xi32>
    %14 = "tensor.empty"() : () -> tensor<64xi32>
    %15 = "linalg.generic"(%14) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg50: i32):
      %69 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %70 = "arith.index_cast"(%69) : (index) -> i32
      "linalg.yield"(%70) : (i32) -> ()
    }) : (tensor<64xi32>) -> tensor<64xi32>
    %16 = "tensor.expand_shape"(%15) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 64>}> : (tensor<64xi32>) -> tensor<1x64xi32>
    %17 = "tensor.empty"() : () -> tensor<128x64xi32>
    %18 = "linalg.generic"(%16, %17) <{indexing_maps = [#map3, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg48: i32, %arg49: i32):
      "linalg.yield"(%arg48) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x64xi32>, tensor<128x64xi32>) -> tensor<128x64xi32>
    %19 = "linalg.generic"(%13, %18, %13) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg45: i32, %arg46: i32, %arg47: i32):
      %68 = "arith.addi"(%arg45, %arg46) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%68) : (i32) -> ()
    }) : (tensor<128x64xi32>, tensor<128x64xi32>, tensor<128x64xi32>) -> tensor<128x64xi32>
    %20 = "tensor.empty"() : () -> tensor<256xi32>
    %21 = "linalg.generic"(%20) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg44: i32):
      %66 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %67 = "arith.index_cast"(%66) : (index) -> i32
      "linalg.yield"(%67) : (i32) -> ()
    }) : (tensor<256xi32>) -> tensor<256xi32>
    %22 = "tensor.expand_shape"(%21) <{reassociation = [[0, 1]], static_output_shape = array<i64: 256, 1>}> : (tensor<256xi32>) -> tensor<256x1xi32>
    %23 = "tensor.empty"() : () -> tensor<256x64xi32>
    %24 = "linalg.generic"(%22, %23) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg42: i32, %arg43: i32):
      "linalg.yield"(%arg42) : (i32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<256x1xi32>, tensor<256x64xi32>) -> tensor<256x64xi32>
    %25 = "tensor.empty"() : () -> tensor<64xi32>
    %26 = "linalg.generic"(%25) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg41: i32):
      %64 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %65 = "arith.index_cast"(%64) : (index) -> i32
      "linalg.yield"(%65) : (i32) -> ()
    }) : (tensor<64xi32>) -> tensor<64xi32>
    %27 = "linalg.generic"(%26, %5, %26) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg38: i32, %arg39: i32, %arg40: i32):
      %63 = "arith.muli"(%arg38, %arg39) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%63) : (i32) -> ()
    }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
    %28 = "tensor.expand_shape"(%27) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 64>}> : (tensor<64xi32>) -> tensor<1x64xi32>
    %29 = "tensor.empty"() : () -> tensor<256x64xi32>
    %30 = "linalg.generic"(%28, %29) <{indexing_maps = [#map3, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg36: i32, %arg37: i32):
      "linalg.yield"(%arg36) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x64xi32>, tensor<256x64xi32>) -> tensor<256x64xi32>
    %31 = "linalg.generic"(%24, %30, %24) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg33: i32, %arg34: i32, %arg35: i32):
      %62 = "arith.addi"(%arg33, %arg34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%62) : (i32) -> ()
    }) : (tensor<256x64xi32>, tensor<256x64xi32>, tensor<256x64xi32>) -> tensor<256x64xi32>
    %32 = "linalg.generic"(%9, %3, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg30: i32, %arg31: i32, %arg32: i32):
      %61 = "arith.muli"(%arg30, %arg31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%61) : (i32) -> ()
    }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
    %33 = "tensor.expand_shape"(%32) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xi32>) -> tensor<128x1xi32>
    %34 = "tensor.empty"() : () -> tensor<128x256xi32>
    %35 = "linalg.generic"(%33, %34) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg28: i32, %arg29: i32):
      "linalg.yield"(%arg28) : (i32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<128x1xi32>, tensor<128x256xi32>) -> tensor<128x256xi32>
    %36 = "tensor.expand_shape"(%21) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 256>}> : (tensor<256xi32>) -> tensor<1x256xi32>
    %37 = "tensor.empty"() : () -> tensor<128x256xi32>
    %38 = "linalg.generic"(%36, %37) <{indexing_maps = [#map3, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32):
      "linalg.yield"(%arg26) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x256xi32>, tensor<128x256xi32>) -> tensor<128x256xi32>
    %39 = "linalg.generic"(%35, %38, %35) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32, %arg25: i32):
      %60 = "arith.addi"(%arg23, %arg24) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%60) : (i32) -> ()
    }) : (tensor<128x256xi32>, tensor<128x256xi32>, tensor<128x256xi32>) -> tensor<128x256xi32>
    %40 = "tensor.empty"() : () -> tensor<128x64x!tt.ptr<bf16>>
    %41 = "linalg.fill"(%arg0, %40) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: !tt.ptr<bf16>, %arg22: !tt.ptr<bf16>):
      "linalg.yield"(%arg21) : (!tt.ptr<bf16>) -> ()
    }) : (!tt.ptr<bf16>, tensor<128x64x!tt.ptr<bf16>>) -> tensor<128x64x!tt.ptr<bf16>>
    %42 = "linalg.generic"(%41, %19, %41) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg18: !tt.ptr<bf16>, %arg19: i32, %arg20: !tt.ptr<bf16>):
      %59 = "tt.addptr"(%arg18, %arg19) : (!tt.ptr<bf16>, i32) -> !tt.ptr<bf16>
      "linalg.yield"(%59) : (!tt.ptr<bf16>) -> ()
    }) : (tensor<128x64x!tt.ptr<bf16>>, tensor<128x64xi32>, tensor<128x64x!tt.ptr<bf16>>) -> tensor<128x64x!tt.ptr<bf16>>
    %43 = "tt.load"(%42) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<128x64x!tt.ptr<bf16>>) -> tensor<128x64xbf16>
    %44 = "tensor.empty"() : () -> tensor<256x64x!tt.ptr<bf16>>
    %45 = "linalg.fill"(%arg1, %44) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: !tt.ptr<bf16>, %arg17: !tt.ptr<bf16>):
      "linalg.yield"(%arg16) : (!tt.ptr<bf16>) -> ()
    }) : (!tt.ptr<bf16>, tensor<256x64x!tt.ptr<bf16>>) -> tensor<256x64x!tt.ptr<bf16>>
    %46 = "linalg.generic"(%45, %31, %45) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg13: !tt.ptr<bf16>, %arg14: i32, %arg15: !tt.ptr<bf16>):
      %58 = "tt.addptr"(%arg13, %arg14) : (!tt.ptr<bf16>, i32) -> !tt.ptr<bf16>
      "linalg.yield"(%58) : (!tt.ptr<bf16>) -> ()
    }) : (tensor<256x64x!tt.ptr<bf16>>, tensor<256x64xi32>, tensor<256x64x!tt.ptr<bf16>>) -> tensor<256x64x!tt.ptr<bf16>>
    %47 = "tt.load"(%46) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<256x64x!tt.ptr<bf16>>) -> tensor<256x64xbf16>
    %48 = "tensor.empty"() : () -> tensor<64x256xbf16>
    %49 = "linalg.transpose"(%47, %48) <{permutation = array<i64: 1, 0>}> ({
    ^bb0(%arg11: bf16, %arg12: bf16):
      "linalg.yield"(%arg11) : (bf16) -> ()
    }) : (tensor<256x64xbf16>, tensor<64x256xbf16>) -> tensor<64x256xbf16>
    %50 = "tensor.empty"() : () -> tensor<128x256x!tt.ptr<bf16>>
    %51 = "linalg.fill"(%arg2, %50) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: !tt.ptr<bf16>, %arg10: !tt.ptr<bf16>):
      "linalg.yield"(%arg9) : (!tt.ptr<bf16>) -> ()
    }) : (!tt.ptr<bf16>, tensor<128x256x!tt.ptr<bf16>>) -> tensor<128x256x!tt.ptr<bf16>>
    %52 = "linalg.generic"(%51, %39, %51) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: !tt.ptr<bf16>, %arg7: i32, %arg8: !tt.ptr<bf16>):
      %57 = "tt.addptr"(%arg6, %arg7) : (!tt.ptr<bf16>, i32) -> !tt.ptr<bf16>
      "linalg.yield"(%57) : (!tt.ptr<bf16>) -> ()
    }) : (tensor<128x256x!tt.ptr<bf16>>, tensor<128x256xi32>, tensor<128x256x!tt.ptr<bf16>>) -> tensor<128x256x!tt.ptr<bf16>>
    %53 = "tt.load"(%52) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<128x256x!tt.ptr<bf16>>) -> tensor<128x256xbf16>
    %54 = "linalg.matmul"(%43, %49, %53) <{indexing_maps = [#map4, #map5, #map6], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: bf16, %arg4: bf16, %arg5: bf16):
      %55 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
      %56 = "arith.addf"(%arg5, %55) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
      "linalg.yield"(%56) : (bf16) -> ()
    }) : (tensor<128x64xbf16>, tensor<64x256xbf16>, tensor<128x256xbf16>) -> tensor<128x256xbf16>
    "tt.store"(%52, %54) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<128x256x!tt.ptr<bf16>>, tensor<128x256xbf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

