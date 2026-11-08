#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1) -> (0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, 0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, f32, memref<?xi32>, memref<?xi32>, memref<?xf32>, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, memref<?xf32>, memref<?xf32>) -> (), sym_name = "_fwd_kernel_stage1"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xbf16>, %arg3: f32, %arg4: memref<?xi32>, %arg5: memref<?xi32>, %arg6: memref<?xf32>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32, %arg15: i32, %arg16: i32, %arg17: i32, %arg18: i32, %arg19: memref<?xf32>, %arg20: memref<?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 64 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %6 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %8 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %9 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %10 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %11 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<?xbf16>) -> !tt.ptr<bf16>
    %12 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<?xbf16>) -> !tt.ptr<bf16>
    %13 = "tensor.empty"() : () -> tensor<64xf32>
    %14 = "linalg.fill"(%2, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg186: f32, %arg187: f32):
      "linalg.yield"(%arg186) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    %15 = "tensor.empty"() : () -> tensor<128xf32>
    %16 = "linalg.fill"(%2, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg184: f32, %arg185: f32):
      "linalg.yield"(%arg184) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %17 = "linalg.fill"(%8, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg182: f32, %arg183: f32):
      "linalg.yield"(%arg182) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    %18 = "tensor.empty"() : () -> tensor<64xi32>
    %19 = "linalg.fill"(%9, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg180: i32, %arg181: i32):
      "linalg.yield"(%arg180) : (i32) -> ()
    }) : (i32, tensor<64xi32>) -> tensor<64xi32>
    %20 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %21 = "arith.index_cast"(%20) : (index) -> i32
    %22 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %23 = "arith.index_cast"(%22) : (index) -> i32
    %24 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
    %25 = "arith.index_cast"(%24) : (index) -> i32
    %26 = "tensor.empty"() : () -> tensor<128xi32>
    %27 = "linalg.generic"(%26) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg179: i32):
      %211 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %212 = "arith.index_cast"(%211) : (index) -> i32
      "linalg.yield"(%212) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %28 = "memref.reinterpret_cast"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %29 = "memref.load"(%28, %20) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %30 = "arith.muli"(%21, %arg8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %31 = "arith.muli"(%23, %arg9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %32 = "arith.addi"(%30, %31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %33 = "arith.index_cast"(%32) : (i32) -> index
    %34 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xbf16>
    %35 = "memref.subview"(%arg0, %33) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index) -> memref<128xbf16, strided<[1], offset: ?>>
    "linalg.copy"(%35, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg177: bf16, %arg178: bf16):
      "linalg.yield"(%arg177) : (bf16) -> ()
    }) : (memref<128xbf16, strided<[1], offset: ?>>, memref<128xbf16>) -> ()
    %36 = "bufferization.to_tensor"(%34) <{restrict, writable}> : (memref<128xbf16>) -> tensor<128xbf16>
    %37 = "arith.addi"(%29, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %38 = "arith.divsi"(%37, %7) : (i32, i32) -> i32
    %39 = "arith.muli"(%38, %25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %40 = "arith.addi"(%39, %38) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %41 = "arith.minsi"(%40, %29) : (i32, i32) -> i32
    %42 = "arith.cmpi"(%41, %39) <{predicate = 4 : i64}> : (i32, i32) -> i1
    "scf.if"(%42) ({
      %43 = "linalg.generic"(%18) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
      ^bb0(%arg176: i32):
        %209 = "linalg.index"() <{dim = 0 : i64}> : () -> index
        %210 = "arith.index_cast"(%209) : (index) -> i32
        "linalg.yield"(%210) : (i32) -> ()
      }) : (tensor<64xi32>) -> tensor<64xi32>
      %44 = "arith.muli"(%arg7, %21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %45 = "arith.extsi"(%arg10) : (i32) -> i64
      %46 = "tensor.empty"() : () -> tensor<64xi64>
      %47 = "linalg.fill"(%45, %46) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg174: i64, %arg175: i64):
        "linalg.yield"(%arg174) : (i64) -> ()
      }) : (i64, tensor<64xi64>) -> tensor<64xi64>
      %48 = "linalg.fill"(%arg11, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg172: i32, %arg173: i32):
        "linalg.yield"(%arg172) : (i32) -> ()
      }) : (i32, tensor<64xi32>) -> tensor<64xi32>
      %49 = "arith.muli"(%23, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %50 = "arith.extsi"(%49) : (i32) -> i64
      %51 = "tensor.empty"() : () -> tensor<64x1xi64>
      %52 = "linalg.fill"(%50, %51) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg170: i64, %arg171: i64):
        "linalg.yield"(%arg170) : (i64) -> ()
      }) : (i64, tensor<64x1xi64>) -> tensor<64x1xi64>
      %53 = "tensor.expand_shape"(%27) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xi32>) -> tensor<1x128xi32>
      %54 = "tensor.empty"() : () -> tensor<1x128xi64>
      %55 = "linalg.generic"(%53, %54) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg168: i32, %arg169: i64):
        %208 = "arith.extsi"(%arg168) : (i32) -> i64
        "linalg.yield"(%208) : (i64) -> ()
      }) : (tensor<1x128xi32>, tensor<1x128xi64>) -> tensor<1x128xi64>
      %56 = "tensor.empty"() : () -> tensor<64x128xi64>
      %57 = "linalg.generic"(%55, %56) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg166: i64, %arg167: i64):
        "linalg.yield"(%arg166) : (i64) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1x128xi64>, tensor<64x128xi64>) -> tensor<64x128xi64>
      %58 = "tensor.empty"() : () -> tensor<64x1xi32>
      %59 = "linalg.fill"(%41, %58) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg164: i32, %arg165: i32):
        "linalg.yield"(%arg164) : (i32) -> ()
      }) : (i32, tensor<64x1xi32>) -> tensor<64x1xi32>
      %60 = "tensor.expand_shape"(%36) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xbf16>) -> tensor<1x128xbf16>
      %61 = "tensor.empty"() : () -> tensor<64x128xbf16>
      %62 = "linalg.generic"(%60, %61) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg162: bf16, %arg163: bf16):
        "linalg.yield"(%arg162) : (bf16) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1x128xbf16>, tensor<64x128xbf16>) -> tensor<64x128xbf16>
      %63 = "linalg.fill"(%arg3, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg160: f32, %arg161: f32):
        "linalg.yield"(%arg160) : (f32) -> ()
      }) : (f32, tensor<64xf32>) -> tensor<64xf32>
      %64 = "arith.extsi"(%arg13) : (i32) -> i64
      %65 = "linalg.fill"(%64, %46) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg158: i64, %arg159: i64):
        "linalg.yield"(%arg158) : (i64) -> ()
      }) : (i64, tensor<64xi64>) -> tensor<64xi64>
      %66 = "linalg.fill"(%arg14, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg156: i32, %arg157: i32):
        "linalg.yield"(%arg156) : (i32) -> ()
      }) : (i32, tensor<64xi32>) -> tensor<64xi32>
      %67 = "arith.muli"(%23, %arg15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %68 = "arith.extsi"(%67) : (i32) -> i64
      %69 = "linalg.fill"(%68, %51) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg154: i64, %arg155: i64):
        "linalg.yield"(%arg154) : (i64) -> ()
      }) : (i64, tensor<64x1xi64>) -> tensor<64x1xi64>
      %70 = "arith.index_cast"(%39) : (i32) -> index
      %71 = "arith.index_cast"(%41) : (i32) -> index
      %72:3 = "scf.for"(%70, %71, %3, %8, %2, %16) ({
      ^bb0(%arg28: index, %arg29: f32, %arg30: f32, %arg31: tensor<128xf32>):
        %90 = "arith.index_cast"(%arg28) : (index) -> i32
        %91 = "linalg.fill"(%90, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg152: i32, %arg153: i32):
          "linalg.yield"(%arg152) : (i32) -> ()
        }) : (i32, tensor<64xi32>) -> tensor<64xi32>
        %92 = "linalg.generic"(%91, %43, %91) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg149: i32, %arg150: i32, %arg151: i32):
          %207 = "arith.addi"(%arg149, %arg150) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%207) : (i32) -> ()
        }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
        %93 = "linalg.generic"(%92, %19, %92) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg146: i32, %arg147: i32, %arg148: i32):
          %206 = "arith.divsi"(%arg146, %arg147) : (i32, i32) -> i32
          "linalg.yield"(%206) : (i32) -> ()
        }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
        %94 = "linalg.fill"(%44, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg144: i32, %arg145: i32):
          "linalg.yield"(%arg144) : (i32) -> ()
        }) : (i32, tensor<64xi32>) -> tensor<64xi32>
        %95 = "linalg.generic"(%94, %93, %94) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg141: i32, %arg142: i32, %arg143: i32):
          %205 = "arith.addi"(%arg141, %arg142) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%205) : (i32) -> ()
        }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
        %96 = "arith.addi"(%arg28, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %97 = "arith.minsi"(%96, %71) : (index, index) -> index
        %98 = "arith.maxsi"(%97, %arg28) : (index, index) -> index
        %99 = "arith.subi"(%98, %arg28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %100 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xi32>
        "linalg.fill"(%4, %100) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg139: i32, %arg140: i32):
          "linalg.yield"(%arg139) : (i32) -> ()
        }) : (i32, memref<64xi32>) -> ()
        %101 = "arith.minsi"(%99, %3) : (index, index) -> index
        "scf.for"(%1, %101, %0) ({
        ^bb0(%arg138: index):
          %201 = "tensor.extract"(%95, %arg138) : (tensor<64xi32>, index) -> i32
          %202 = "arith.index_cast"(%201) : (i32) -> index
          %203 = "memref.reinterpret_cast"(%arg4, %202) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
          %204 = "memref.subview"(%100, %arg138) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<64xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
          "memref.copy"(%203, %204) : (memref<1xi32, strided<[1], offset: ?>>, memref<1xi32, strided<[1], offset: ?>>) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %102 = "bufferization.to_tensor"(%100) <{restrict, writable}> : (memref<64xi32>) -> tensor<64xi32>
        %103 = "linalg.generic"(%102, %46) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg136: i32, %arg137: i64):
          %200 = "arith.extsi"(%arg136) : (i32) -> i64
          "linalg.yield"(%200) : (i64) -> ()
        }) : (tensor<64xi32>, tensor<64xi64>) -> tensor<64xi64>
        %104 = "linalg.generic"(%92, %19, %92) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg133: i32, %arg134: i32, %arg135: i32):
          %199 = "arith.remsi"(%arg133, %arg134) : (i32, i32) -> i32
          "linalg.yield"(%199) : (i32) -> ()
        }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
        %105 = "linalg.generic"(%103, %47, %103) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg130: i64, %arg131: i64, %arg132: i64):
          %198 = "arith.muli"(%arg130, %arg131) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%198) : (i64) -> ()
        }) : (tensor<64xi64>, tensor<64xi64>, tensor<64xi64>) -> tensor<64xi64>
        %106 = "linalg.generic"(%104, %48, %104) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg127: i32, %arg128: i32, %arg129: i32):
          %197 = "arith.muli"(%arg127, %arg128) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%197) : (i32) -> ()
        }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
        %107 = "linalg.generic"(%106, %46) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg125: i32, %arg126: i64):
          %196 = "arith.extsi"(%arg125) : (i32) -> i64
          "linalg.yield"(%196) : (i64) -> ()
        }) : (tensor<64xi32>, tensor<64xi64>) -> tensor<64xi64>
        %108 = "linalg.generic"(%105, %107, %105) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg122: i64, %arg123: i64, %arg124: i64):
          %195 = "arith.addi"(%arg122, %arg123) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%195) : (i64) -> ()
        }) : (tensor<64xi64>, tensor<64xi64>, tensor<64xi64>) -> tensor<64xi64>
        %109 = "tensor.expand_shape"(%108) <{reassociation = [[0, 1]], static_output_shape = array<i64: 64, 1>}> : (tensor<64xi64>) -> tensor<64x1xi64>
        %110 = "linalg.generic"(%109, %52, %109) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg119: i64, %arg120: i64, %arg121: i64):
          %194 = "arith.addi"(%arg119, %arg120) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%194) : (i64) -> ()
        }) : (tensor<64x1xi64>, tensor<64x1xi64>, tensor<64x1xi64>) -> tensor<64x1xi64>
        %111 = "linalg.generic"(%110, %56) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg117: i64, %arg118: i64):
          "linalg.yield"(%arg117) : (i64) -> ()
        }) {broadcastDims = array<i64: 1>} : (tensor<64x1xi64>, tensor<64x128xi64>) -> tensor<64x128xi64>
        %112 = "linalg.generic"(%111, %57, %111) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg114: i64, %arg115: i64, %arg116: i64):
          %193 = "arith.addi"(%arg114, %arg115) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%193) : (i64) -> ()
        }) : (tensor<64x128xi64>, tensor<64x128xi64>, tensor<64x128xi64>) -> tensor<64x128xi64>
        %113 = "tensor.expand_shape"(%92) <{reassociation = [[0, 1]], static_output_shape = array<i64: 64, 1>}> : (tensor<64xi32>) -> tensor<64x1xi32>
        %114 = "tensor.empty"() : () -> tensor<64x1xi1>
        %115 = "linalg.generic"(%113, %59, %114) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg111: i32, %arg112: i32, %arg113: i1):
          %192 = "arith.cmpi"(%arg111, %arg112) <{predicate = 2 : i64}> : (i32, i32) -> i1
          "linalg.yield"(%192) : (i1) -> ()
        }) : (tensor<64x1xi32>, tensor<64x1xi32>, tensor<64x1xi1>) -> tensor<64x1xi1>
        %116 = "tensor.empty"() : () -> tensor<64x128xi1>
        %117 = "linalg.generic"(%115, %116) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg109: i1, %arg110: i1):
          "linalg.yield"(%arg109) : (i1) -> ()
        }) {broadcastDims = array<i64: 1>} : (tensor<64x1xi1>, tensor<64x128xi1>) -> tensor<64x128xi1>
        %118 = "tts.gather"(%12, %112, %117, %5) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (!tt.ptr<bf16>, tensor<64x128xi64>, tensor<64x128xi1>, bf16) -> tensor<64x128xbf16>
        %119 = "linalg.generic"(%62, %118, %62) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg106: bf16, %arg107: bf16, %arg108: bf16):
          %191 = "arith.mulf"(%arg106, %arg107) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
          "linalg.yield"(%191) : (bf16) -> ()
        }) : (tensor<64x128xbf16>, tensor<64x128xbf16>, tensor<64x128xbf16>) -> tensor<64x128xbf16>
        %120 = "linalg.reduce"(%119, %14) <{dimensions = array<i64: 1>}> ({
        ^bb0(%arg104: bf16, %arg105: f32):
          %189 = "arith.extf"(%arg104) : (bf16) -> f32
          %190 = "arith.addf"(%189, %arg105) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%190) : (f32) -> ()
        }) : (tensor<64x128xbf16>, tensor<64xf32>) -> tensor<64xf32>
        %121 = "tensor.empty"() : () -> tensor<64xbf16>
        %122 = "linalg.generic"(%120, %121) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg102: f32, %arg103: bf16):
          %188 = "arith.truncf"(%arg102) : (f32) -> bf16
          "linalg.yield"(%188) : (bf16) -> ()
        }) : (tensor<64xf32>, tensor<64xbf16>) -> tensor<64xbf16>
        %123 = "linalg.generic"(%122, %13) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg100: bf16, %arg101: f32):
          %187 = "arith.extf"(%arg100) : (bf16) -> f32
          "linalg.yield"(%187) : (f32) -> ()
        }) : (tensor<64xbf16>, tensor<64xf32>) -> tensor<64xf32>
        %124 = "linalg.generic"(%123, %63, %123) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg97: f32, %arg98: f32, %arg99: f32):
          %186 = "arith.mulf"(%arg97, %arg98) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%186) : (f32) -> ()
        }) : (tensor<64xf32>, tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>
        %125 = "arith.subi"(%90, %41) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %126 = "linalg.generic"(%43, %13) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg95: i32, %arg96: f32):
          %185 = "arith.sitofp"(%arg95) : (i32) -> f32
          "linalg.yield"(%185) : (f32) -> ()
        }) : (tensor<64xi32>, tensor<64xf32>) -> tensor<64xf32>
        %127 = "linalg.generic"(%126, %14, %126) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg92: f32, %arg93: f32, %arg94: f32):
          %184 = "arith.addf"(%arg92, %arg93) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%184) : (f32) -> ()
        }) : (tensor<64xf32>, tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>
        %128 = "arith.subi"(%4, %125) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %129 = "arith.sitofp"(%128) : (i32) -> f32
        %130 = "linalg.fill"(%129, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg90: f32, %arg91: f32):
          "linalg.yield"(%arg90) : (f32) -> ()
        }) : (f32, tensor<64xf32>) -> tensor<64xf32>
        %131 = "tensor.empty"() : () -> tensor<64xi1>
        %132 = "linalg.generic"(%127, %130, %131) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg87: f32, %arg88: f32, %arg89: i1):
          %183 = "arith.cmpf"(%arg87, %arg88) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
          "linalg.yield"(%183) : (i1) -> ()
        }) : (tensor<64xf32>, tensor<64xf32>, tensor<64xi1>) -> tensor<64xi1>
        %133 = "linalg.generic"(%132, %124, %17, %124) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
        ^bb0(%arg83: i1, %arg84: f32, %arg85: f32, %arg86: f32):
          %182 = "arith.select"(%arg83, %arg84, %arg85) : (i1, f32, f32) -> f32
          "linalg.yield"(%182) : (f32) -> ()
        }) : (tensor<64xi1>, tensor<64xf32>, tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>
        %134 = "linalg.generic"(%103, %65, %103) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg80: i64, %arg81: i64, %arg82: i64):
          %181 = "arith.muli"(%arg80, %arg81) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%181) : (i64) -> ()
        }) : (tensor<64xi64>, tensor<64xi64>, tensor<64xi64>) -> tensor<64xi64>
        %135 = "linalg.generic"(%104, %66, %104) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg77: i32, %arg78: i32, %arg79: i32):
          %180 = "arith.muli"(%arg77, %arg78) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%180) : (i32) -> ()
        }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
        %136 = "linalg.generic"(%135, %46) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg75: i32, %arg76: i64):
          %179 = "arith.extsi"(%arg75) : (i32) -> i64
          "linalg.yield"(%179) : (i64) -> ()
        }) : (tensor<64xi32>, tensor<64xi64>) -> tensor<64xi64>
        %137 = "linalg.generic"(%134, %136, %134) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg72: i64, %arg73: i64, %arg74: i64):
          %178 = "arith.addi"(%arg72, %arg73) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%178) : (i64) -> ()
        }) : (tensor<64xi64>, tensor<64xi64>, tensor<64xi64>) -> tensor<64xi64>
        %138 = "tensor.expand_shape"(%137) <{reassociation = [[0, 1]], static_output_shape = array<i64: 64, 1>}> : (tensor<64xi64>) -> tensor<64x1xi64>
        %139 = "linalg.generic"(%138, %69, %138) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg69: i64, %arg70: i64, %arg71: i64):
          %177 = "arith.addi"(%arg69, %arg70) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%177) : (i64) -> ()
        }) : (tensor<64x1xi64>, tensor<64x1xi64>, tensor<64x1xi64>) -> tensor<64x1xi64>
        %140 = "linalg.generic"(%139, %56) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg67: i64, %arg68: i64):
          "linalg.yield"(%arg67) : (i64) -> ()
        }) {broadcastDims = array<i64: 1>} : (tensor<64x1xi64>, tensor<64x128xi64>) -> tensor<64x128xi64>
        %141 = "linalg.generic"(%140, %57, %140) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg64: i64, %arg65: i64, %arg66: i64):
          %176 = "arith.addi"(%arg64, %arg65) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%176) : (i64) -> ()
        }) : (tensor<64x128xi64>, tensor<64x128xi64>, tensor<64x128xi64>) -> tensor<64x128xi64>
        %142 = "tts.gather"(%11, %141, %117, %5) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (!tt.ptr<bf16>, tensor<64x128xi64>, tensor<64x128xi1>, bf16) -> tensor<64x128xbf16>
        %143 = "tensor.empty"() : () -> tensor<f32>
        %144 = "linalg.fill"(%8, %143) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg62: f32, %arg63: f32):
          "linalg.yield"(%arg62) : (f32) -> ()
        }) : (f32, tensor<f32>) -> tensor<f32>
        %145 = "linalg.reduce"(%133, %144) <{dimensions = array<i64: 0>}> ({
        ^bb0(%arg60: f32, %arg61: f32):
          %175 = "arith.maxnumf"(%arg60, %arg61) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%175) : (f32) -> ()
        }) : (tensor<64xf32>, tensor<f32>) -> tensor<f32>
        %146 = "tensor.extract"(%145) : (tensor<f32>) -> f32
        %147 = "arith.maxnumf"(%146, %arg29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %148 = "arith.subf"(%arg29, %147) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %149 = "math.exp"(%148) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        %150 = "linalg.fill"(%147, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg58: f32, %arg59: f32):
          "linalg.yield"(%arg58) : (f32) -> ()
        }) : (f32, tensor<64xf32>) -> tensor<64xf32>
        %151 = "linalg.generic"(%133, %150, %133) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg55: f32, %arg56: f32, %arg57: f32):
          %174 = "arith.subf"(%arg55, %arg56) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%174) : (f32) -> ()
        }) : (tensor<64xf32>, tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>
        %152 = "linalg.generic"(%151, %151) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg53: f32, %arg54: f32):
          %173 = "math.exp"(%arg53) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
          "linalg.yield"(%173) : (f32) -> ()
        }) : (tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>
        %153 = "linalg.fill"(%149, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg51: f32, %arg52: f32):
          "linalg.yield"(%arg51) : (f32) -> ()
        }) : (f32, tensor<128xf32>) -> tensor<128xf32>
        %154 = "linalg.generic"(%arg31, %153, %arg31) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg48: f32, %arg49: f32, %arg50: f32):
          %172 = "arith.mulf"(%arg48, %arg49) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%172) : (f32) -> ()
        }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
        %155 = "tensor.expand_shape"(%152) <{reassociation = [[0, 1]], static_output_shape = array<i64: 64, 1>}> : (tensor<64xf32>) -> tensor<64x1xf32>
        %156 = "tensor.empty"() : () -> tensor<64x128xf32>
        %157 = "linalg.generic"(%142, %156) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg46: bf16, %arg47: f32):
          %171 = "arith.extf"(%arg46) : (bf16) -> f32
          "linalg.yield"(%171) : (f32) -> ()
        }) : (tensor<64x128xbf16>, tensor<64x128xf32>) -> tensor<64x128xf32>
        %158 = "linalg.generic"(%155, %156) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg44: f32, %arg45: f32):
          "linalg.yield"(%arg44) : (f32) -> ()
        }) {broadcastDims = array<i64: 1>} : (tensor<64x1xf32>, tensor<64x128xf32>) -> tensor<64x128xf32>
        %159 = "linalg.generic"(%158, %157, %158) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg41: f32, %arg42: f32, %arg43: f32):
          %170 = "arith.mulf"(%arg41, %arg42) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%170) : (f32) -> ()
        }) : (tensor<64x128xf32>, tensor<64x128xf32>, tensor<64x128xf32>) -> tensor<64x128xf32>
        %160 = "linalg.reduce"(%159, %16) <{dimensions = array<i64: 0>}> ({
        ^bb0(%arg39: f32, %arg40: f32):
          %169 = "arith.addf"(%arg39, %arg40) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%169) : (f32) -> ()
        }) : (tensor<64x128xf32>, tensor<128xf32>) -> tensor<128xf32>
        %161 = "linalg.generic"(%154, %160, %154) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg36: f32, %arg37: f32, %arg38: f32):
          %168 = "arith.addf"(%arg36, %arg37) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%168) : (f32) -> ()
        }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
        %162 = "arith.mulf"(%arg30, %149) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %163 = "linalg.fill"(%2, %143) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg34: f32, %arg35: f32):
          "linalg.yield"(%arg34) : (f32) -> ()
        }) : (f32, tensor<f32>) -> tensor<f32>
        %164 = "linalg.reduce"(%152, %163) <{dimensions = array<i64: 0>}> ({
        ^bb0(%arg32: f32, %arg33: f32):
          %167 = "arith.addf"(%arg32, %arg33) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%167) : (f32) -> ()
        }) : (tensor<64xf32>, tensor<f32>) -> tensor<f32>
        %165 = "tensor.extract"(%164) : (tensor<f32>) -> f32
        %166 = "arith.addf"(%162, %165) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "scf.yield"(%147, %166, %161) : (f32, f32, tensor<128xf32>) -> ()
      }) : (index, index, index, f32, f32, tensor<128xf32>) -> (f32, f32, tensor<128xf32>)
      %73 = "arith.muli"(%21, %arg16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %74 = "arith.muli"(%23, %arg17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %75 = "arith.addi"(%73, %74) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %76 = "arith.muli"(%25, %arg18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %77 = "arith.addi"(%75, %76) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %78 = "arith.index_cast"(%77) : (i32) -> index
      %79 = "linalg.fill"(%72#1, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg26: f32, %arg27: f32):
        "linalg.yield"(%arg26) : (f32) -> ()
      }) : (f32, tensor<128xf32>) -> tensor<128xf32>
      %80 = "linalg.generic"(%72#2, %79, %72#2) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg23: f32, %arg24: f32, %arg25: f32):
        %89 = "arith.divf"(%arg23, %arg24) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%89) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %81 = "memref.subview"(%arg6, %78) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<128xf32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%80, %81) <{writable}> : (tensor<128xf32>, memref<128xf32, strided<[1], offset: ?>>) -> ()
      %82 = "arith.addi"(%77, %10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %83 = "math.log"(%72#1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %84 = "arith.addf"(%72#0, %83) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %85 = "arith.index_cast"(%82) : (i32) -> index
      %86 = "tensor.empty"() : () -> tensor<1xf32>
      %87 = "linalg.fill"(%84, %86) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg21: f32, %arg22: f32):
        "linalg.yield"(%arg21) : (f32) -> ()
      }) : (f32, tensor<1xf32>) -> tensor<1xf32>
      %88 = "memref.subview"(%arg6, %85) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%87, %88) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

