#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1) -> (d0, 0)>
#map3 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, f32, memref<?xi32>, memref<?xi32>, memref<?xf32>, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, memref<?xf32>, memref<?xf32>) -> (), sym_name = "_fwd_kernel_stage1"}> ({
  ^bb0(%arg21: memref<?xbf16>, %arg22: memref<?xbf16>, %arg23: memref<?xbf16>, %arg24: f32, %arg25: memref<?xi32>, %arg26: memref<?xi32>, %arg27: memref<?xf32>, %arg28: i32, %arg29: i32, %arg30: i32, %arg31: i32, %arg32: i32, %arg33: i32, %arg34: i32, %arg35: i32, %arg36: i32, %arg37: i32, %arg38: i32, %arg39: i32, %arg40: memref<?xf32>, %arg41: memref<?xf32>):
    %18 = "arith.constant"() <{value = 1 : index}> : () -> index
    %19 = "arith.constant"() <{value = 0 : index}> : () -> index
    %20 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %21 = "arith.constant"() <{value = 64 : index}> : () -> index
    %22 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %23 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %24 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %25 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %26 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %27 = "builtin.unrealized_conversion_cast"(%arg23) : (memref<?xbf16>) -> !tt.ptr<bf16>
    %28 = "builtin.unrealized_conversion_cast"(%arg22) : (memref<?xbf16>) -> !tt.ptr<bf16>
    %29 = "tensor.empty"() : () -> tensor<64xf32>
    %30 = "linalg.fill"(%20, %29) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg191: f32, %arg192: f32):
      "linalg.yield"(%arg191) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    %31 = "linalg.fill"(%24, %29) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg189: f32, %arg190: f32):
      "linalg.yield"(%arg189) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    %32 = "tensor.empty"() : () -> tensor<64xi32>
    %33 = "linalg.fill"(%25, %32) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg187: i32, %arg188: i32):
      "linalg.yield"(%arg187) : (i32) -> ()
    }) : (i32, tensor<64xi32>) -> tensor<64xi32>
    %34 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %35 = "arith.index_cast"(%34) : (index) -> i32
    %36 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %37 = "arith.index_cast"(%36) : (index) -> i32
    %38 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
    %39 = "arith.index_cast"(%38) : (index) -> i32
    %40 = "tensor.empty"() : () -> tensor<128xi32>
    %41 = "linalg.generic"(%40) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg186: i32):
      %214 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %215 = "arith.index_cast"(%214) : (index) -> i32
      "linalg.yield"(%215) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %42 = "memref.reinterpret_cast"(%arg26) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %43 = "memref.load"(%42, %34) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %44 = "arith.muli"(%35, %arg29) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %45 = "arith.muli"(%37, %arg30) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %46 = "arith.addi"(%44, %45) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %47 = "arith.index_cast"(%46) : (i32) -> index
    %48 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xbf16>
    %49 = "memref.subview"(%arg21, %47) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index) -> memref<128xbf16, strided<[1], offset: ?>>
    "linalg.copy"(%49, %48) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg184: bf16, %arg185: bf16):
      "linalg.yield"(%arg184) : (bf16) -> ()
    }) : (memref<128xbf16, strided<[1], offset: ?>>, memref<128xbf16>) -> ()
    %50 = "bufferization.to_tensor"(%48) <{restrict, writable}> : (memref<128xbf16>) -> tensor<128xbf16>
    %51 = "func.call"(%43) <{callee = @triton.language.standard.cdiv__i32_c8}> : (i32) -> i32
    %52 = "arith.muli"(%51, %39) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %53 = "arith.addi"(%52, %51) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %54 = "arith.minsi"(%53, %43) : (i32, i32) -> i32
    %55 = "func.call"() <{callee = @triton.language.standard.zeros__Tc128T_cfp32}> : () -> tensor<128xf32>
    %56 = "arith.cmpi"(%54, %52) <{predicate = 4 : i64}> : (i32, i32) -> i1
    "scf.if"(%56) ({
      %57 = "arith.index_cast"(%52) : (i32) -> index
      %58 = "arith.index_cast"(%54) : (i32) -> index
      %59:3 = "scf.for"(%57, %58, %21, %24, %20, %55) ({
      ^bb0(%arg49: index, %arg50: f32, %arg51: f32, %arg52: tensor<128xf32>):
        %78 = "arith.index_cast"(%arg49) : (index) -> i32
        %79 = "linalg.generic"(%32) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
        ^bb0(%arg183: i32):
          %212 = "linalg.index"() <{dim = 0 : i64}> : () -> index
          %213 = "arith.index_cast"(%212) : (index) -> i32
          "linalg.yield"(%213) : (i32) -> ()
        }) : (tensor<64xi32>) -> tensor<64xi32>
        %80 = "linalg.fill"(%78, %32) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg181: i32, %arg182: i32):
          "linalg.yield"(%arg181) : (i32) -> ()
        }) : (i32, tensor<64xi32>) -> tensor<64xi32>
        %81 = "linalg.generic"(%80, %79, %80) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg178: i32, %arg179: i32, %arg180: i32):
          %211 = "arith.addi"(%arg178, %arg179) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%211) : (i32) -> ()
        }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
        %82 = "arith.muli"(%arg28, %35) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %83 = "linalg.generic"(%81, %33, %81) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg175: i32, %arg176: i32, %arg177: i32):
          %210 = "arith.divsi"(%arg175, %arg176) : (i32, i32) -> i32
          "linalg.yield"(%210) : (i32) -> ()
        }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
        %84 = "linalg.fill"(%82, %32) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg173: i32, %arg174: i32):
          "linalg.yield"(%arg173) : (i32) -> ()
        }) : (i32, tensor<64xi32>) -> tensor<64xi32>
        %85 = "linalg.generic"(%84, %83, %84) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg170: i32, %arg171: i32, %arg172: i32):
          %209 = "arith.addi"(%arg170, %arg171) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%209) : (i32) -> ()
        }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
        %86 = "arith.addi"(%arg49, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %87 = "arith.minsi"(%86, %58) : (index, index) -> index
        %88 = "arith.maxsi"(%87, %arg49) : (index, index) -> index
        %89 = "arith.subi"(%88, %arg49) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %90 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xi32>
        "linalg.fill"(%22, %90) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg168: i32, %arg169: i32):
          "linalg.yield"(%arg168) : (i32) -> ()
        }) : (i32, memref<64xi32>) -> ()
        %91 = "arith.minsi"(%89, %21) : (index, index) -> index
        "scf.for"(%19, %91, %18) ({
        ^bb0(%arg167: index):
          %205 = "tensor.extract"(%85, %arg167) : (tensor<64xi32>, index) -> i32
          %206 = "arith.index_cast"(%205) : (i32) -> index
          %207 = "memref.reinterpret_cast"(%arg25, %206) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
          %208 = "memref.subview"(%90, %arg167) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<64xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
          "memref.copy"(%207, %208) : (memref<1xi32, strided<[1], offset: ?>>, memref<1xi32, strided<[1], offset: ?>>) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %92 = "bufferization.to_tensor"(%90) <{restrict, writable}> : (memref<64xi32>) -> tensor<64xi32>
        %93 = "tensor.empty"() : () -> tensor<64xi64>
        %94 = "linalg.generic"(%92, %93) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg165: i32, %arg166: i64):
          %204 = "arith.extsi"(%arg165) : (i32) -> i64
          "linalg.yield"(%204) : (i64) -> ()
        }) : (tensor<64xi32>, tensor<64xi64>) -> tensor<64xi64>
        %95 = "linalg.generic"(%81, %33, %81) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg162: i32, %arg163: i32, %arg164: i32):
          %203 = "arith.remsi"(%arg162, %arg163) : (i32, i32) -> i32
          "linalg.yield"(%203) : (i32) -> ()
        }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
        %96 = "arith.extsi"(%arg31) : (i32) -> i64
        %97 = "linalg.fill"(%96, %93) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg160: i64, %arg161: i64):
          "linalg.yield"(%arg160) : (i64) -> ()
        }) : (i64, tensor<64xi64>) -> tensor<64xi64>
        %98 = "linalg.generic"(%94, %97, %94) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg157: i64, %arg158: i64, %arg159: i64):
          %202 = "arith.muli"(%arg157, %arg158) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%202) : (i64) -> ()
        }) : (tensor<64xi64>, tensor<64xi64>, tensor<64xi64>) -> tensor<64xi64>
        %99 = "linalg.fill"(%arg32, %32) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg155: i32, %arg156: i32):
          "linalg.yield"(%arg155) : (i32) -> ()
        }) : (i32, tensor<64xi32>) -> tensor<64xi32>
        %100 = "linalg.generic"(%95, %99, %95) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg152: i32, %arg153: i32, %arg154: i32):
          %201 = "arith.muli"(%arg152, %arg153) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%201) : (i32) -> ()
        }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
        %101 = "linalg.generic"(%100, %93) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg150: i32, %arg151: i64):
          %200 = "arith.extsi"(%arg150) : (i32) -> i64
          "linalg.yield"(%200) : (i64) -> ()
        }) : (tensor<64xi32>, tensor<64xi64>) -> tensor<64xi64>
        %102 = "linalg.generic"(%98, %101, %98) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg147: i64, %arg148: i64, %arg149: i64):
          %199 = "arith.addi"(%arg147, %arg148) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%199) : (i64) -> ()
        }) : (tensor<64xi64>, tensor<64xi64>, tensor<64xi64>) -> tensor<64xi64>
        %103 = "tensor.expand_shape"(%102) <{reassociation = [[0, 1]], static_output_shape = array<i64: 64, 1>}> : (tensor<64xi64>) -> tensor<64x1xi64>
        %104 = "arith.muli"(%37, %arg33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %105 = "arith.extsi"(%104) : (i32) -> i64
        %106 = "tensor.empty"() : () -> tensor<64x1xi64>
        %107 = "linalg.fill"(%105, %106) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg145: i64, %arg146: i64):
          "linalg.yield"(%arg145) : (i64) -> ()
        }) : (i64, tensor<64x1xi64>) -> tensor<64x1xi64>
        %108 = "linalg.generic"(%103, %107, %103) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg142: i64, %arg143: i64, %arg144: i64):
          %198 = "arith.addi"(%arg142, %arg143) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%198) : (i64) -> ()
        }) : (tensor<64x1xi64>, tensor<64x1xi64>, tensor<64x1xi64>) -> tensor<64x1xi64>
        %109 = "tensor.expand_shape"(%41) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xi32>) -> tensor<1x128xi32>
        %110 = "tensor.empty"() : () -> tensor<1x128xi64>
        %111 = "linalg.generic"(%109, %110) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg140: i32, %arg141: i64):
          %197 = "arith.extsi"(%arg140) : (i32) -> i64
          "linalg.yield"(%197) : (i64) -> ()
        }) : (tensor<1x128xi32>, tensor<1x128xi64>) -> tensor<1x128xi64>
        %112 = "tensor.empty"() : () -> tensor<64x128xi64>
        %113 = "linalg.generic"(%108, %112) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg138: i64, %arg139: i64):
          "linalg.yield"(%arg138) : (i64) -> ()
        }) {broadcastDims = array<i64: 1>} : (tensor<64x1xi64>, tensor<64x128xi64>) -> tensor<64x128xi64>
        %114 = "linalg.generic"(%111, %112) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg136: i64, %arg137: i64):
          "linalg.yield"(%arg136) : (i64) -> ()
        }) {broadcastDims = array<i64: 0>} : (tensor<1x128xi64>, tensor<64x128xi64>) -> tensor<64x128xi64>
        %115 = "linalg.generic"(%113, %114, %113) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg133: i64, %arg134: i64, %arg135: i64):
          %196 = "arith.addi"(%arg133, %arg134) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%196) : (i64) -> ()
        }) : (tensor<64x128xi64>, tensor<64x128xi64>, tensor<64x128xi64>) -> tensor<64x128xi64>
        %116 = "tensor.expand_shape"(%81) <{reassociation = [[0, 1]], static_output_shape = array<i64: 64, 1>}> : (tensor<64xi32>) -> tensor<64x1xi32>
        %117 = "tensor.empty"() : () -> tensor<64x1xi32>
        %118 = "linalg.fill"(%54, %117) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg131: i32, %arg132: i32):
          "linalg.yield"(%arg131) : (i32) -> ()
        }) : (i32, tensor<64x1xi32>) -> tensor<64x1xi32>
        %119 = "tensor.empty"() : () -> tensor<64x1xi1>
        %120 = "linalg.generic"(%116, %118, %119) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg128: i32, %arg129: i32, %arg130: i1):
          %195 = "arith.cmpi"(%arg128, %arg129) <{predicate = 2 : i64}> : (i32, i32) -> i1
          "linalg.yield"(%195) : (i1) -> ()
        }) : (tensor<64x1xi32>, tensor<64x1xi32>, tensor<64x1xi1>) -> tensor<64x1xi1>
        %121 = "tensor.empty"() : () -> tensor<64x128xi1>
        %122 = "linalg.generic"(%120, %121) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg126: i1, %arg127: i1):
          "linalg.yield"(%arg126) : (i1) -> ()
        }) {broadcastDims = array<i64: 1>} : (tensor<64x1xi1>, tensor<64x128xi1>) -> tensor<64x128xi1>
        %123 = "tts.gather"(%28, %115, %122, %23) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (!tt.ptr<bf16>, tensor<64x128xi64>, tensor<64x128xi1>, bf16) -> tensor<64x128xbf16>
        %124 = "tensor.expand_shape"(%50) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xbf16>) -> tensor<1x128xbf16>
        %125 = "tensor.empty"() : () -> tensor<64x128xbf16>
        %126 = "linalg.generic"(%124, %125) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg124: bf16, %arg125: bf16):
          "linalg.yield"(%arg124) : (bf16) -> ()
        }) {broadcastDims = array<i64: 0>} : (tensor<1x128xbf16>, tensor<64x128xbf16>) -> tensor<64x128xbf16>
        %127 = "linalg.generic"(%126, %123, %126) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg121: bf16, %arg122: bf16, %arg123: bf16):
          %194 = "arith.mulf"(%arg121, %arg122) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
          "linalg.yield"(%194) : (bf16) -> ()
        }) : (tensor<64x128xbf16>, tensor<64x128xbf16>, tensor<64x128xbf16>) -> tensor<64x128xbf16>
        %128 = "func.call"(%127) <{callee = @triton.language.standard.sum__bf16S64_128S_c1_cFalse_cNone}> : (tensor<64x128xbf16>) -> tensor<64xbf16>
        %129 = "linalg.generic"(%128, %29) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg119: bf16, %arg120: f32):
          %193 = "arith.extf"(%arg119) : (bf16) -> f32
          "linalg.yield"(%193) : (f32) -> ()
        }) : (tensor<64xbf16>, tensor<64xf32>) -> tensor<64xf32>
        %130 = "linalg.fill"(%arg24, %29) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg117: f32, %arg118: f32):
          "linalg.yield"(%arg117) : (f32) -> ()
        }) : (f32, tensor<64xf32>) -> tensor<64xf32>
        %131 = "linalg.generic"(%129, %130, %129) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg114: f32, %arg115: f32, %arg116: f32):
          %192 = "arith.mulf"(%arg114, %arg115) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%192) : (f32) -> ()
        }) : (tensor<64xf32>, tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>
        %132 = "arith.subi"(%78, %54) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %133 = "linalg.generic"(%79, %29) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg112: i32, %arg113: f32):
          %191 = "arith.sitofp"(%arg112) : (i32) -> f32
          "linalg.yield"(%191) : (f32) -> ()
        }) : (tensor<64xi32>, tensor<64xf32>) -> tensor<64xf32>
        %134 = "linalg.generic"(%133, %30, %133) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg109: f32, %arg110: f32, %arg111: f32):
          %190 = "arith.addf"(%arg109, %arg110) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%190) : (f32) -> ()
        }) : (tensor<64xf32>, tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>
        %135 = "arith.subi"(%22, %132) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %136 = "arith.sitofp"(%135) : (i32) -> f32
        %137 = "linalg.fill"(%136, %29) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg107: f32, %arg108: f32):
          "linalg.yield"(%arg107) : (f32) -> ()
        }) : (f32, tensor<64xf32>) -> tensor<64xf32>
        %138 = "tensor.empty"() : () -> tensor<64xi1>
        %139 = "linalg.generic"(%134, %137, %138) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg104: f32, %arg105: f32, %arg106: i1):
          %189 = "arith.cmpf"(%arg104, %arg105) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
          "linalg.yield"(%189) : (i1) -> ()
        }) : (tensor<64xf32>, tensor<64xf32>, tensor<64xi1>) -> tensor<64xi1>
        %140 = "linalg.generic"(%139, %131, %31, %131) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
        ^bb0(%arg100: i1, %arg101: f32, %arg102: f32, %arg103: f32):
          %188 = "arith.select"(%arg100, %arg101, %arg102) : (i1, f32, f32) -> f32
          "linalg.yield"(%188) : (f32) -> ()
        }) : (tensor<64xi1>, tensor<64xf32>, tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>
        %141 = "arith.extsi"(%arg34) : (i32) -> i64
        %142 = "linalg.fill"(%141, %93) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg98: i64, %arg99: i64):
          "linalg.yield"(%arg98) : (i64) -> ()
        }) : (i64, tensor<64xi64>) -> tensor<64xi64>
        %143 = "linalg.generic"(%94, %142, %94) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg95: i64, %arg96: i64, %arg97: i64):
          %187 = "arith.muli"(%arg95, %arg96) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%187) : (i64) -> ()
        }) : (tensor<64xi64>, tensor<64xi64>, tensor<64xi64>) -> tensor<64xi64>
        %144 = "linalg.fill"(%arg35, %32) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg93: i32, %arg94: i32):
          "linalg.yield"(%arg93) : (i32) -> ()
        }) : (i32, tensor<64xi32>) -> tensor<64xi32>
        %145 = "linalg.generic"(%95, %144, %95) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg90: i32, %arg91: i32, %arg92: i32):
          %186 = "arith.muli"(%arg90, %arg91) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%186) : (i32) -> ()
        }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
        %146 = "linalg.generic"(%145, %93) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg88: i32, %arg89: i64):
          %185 = "arith.extsi"(%arg88) : (i32) -> i64
          "linalg.yield"(%185) : (i64) -> ()
        }) : (tensor<64xi32>, tensor<64xi64>) -> tensor<64xi64>
        %147 = "linalg.generic"(%143, %146, %143) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg85: i64, %arg86: i64, %arg87: i64):
          %184 = "arith.addi"(%arg85, %arg86) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%184) : (i64) -> ()
        }) : (tensor<64xi64>, tensor<64xi64>, tensor<64xi64>) -> tensor<64xi64>
        %148 = "tensor.expand_shape"(%147) <{reassociation = [[0, 1]], static_output_shape = array<i64: 64, 1>}> : (tensor<64xi64>) -> tensor<64x1xi64>
        %149 = "arith.muli"(%37, %arg36) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %150 = "arith.extsi"(%149) : (i32) -> i64
        %151 = "linalg.fill"(%150, %106) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg83: i64, %arg84: i64):
          "linalg.yield"(%arg83) : (i64) -> ()
        }) : (i64, tensor<64x1xi64>) -> tensor<64x1xi64>
        %152 = "linalg.generic"(%148, %151, %148) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg80: i64, %arg81: i64, %arg82: i64):
          %183 = "arith.addi"(%arg80, %arg81) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%183) : (i64) -> ()
        }) : (tensor<64x1xi64>, tensor<64x1xi64>, tensor<64x1xi64>) -> tensor<64x1xi64>
        %153 = "linalg.generic"(%152, %112) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg78: i64, %arg79: i64):
          "linalg.yield"(%arg78) : (i64) -> ()
        }) {broadcastDims = array<i64: 1>} : (tensor<64x1xi64>, tensor<64x128xi64>) -> tensor<64x128xi64>
        %154 = "linalg.generic"(%153, %114, %153) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg75: i64, %arg76: i64, %arg77: i64):
          %182 = "arith.addi"(%arg75, %arg76) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%182) : (i64) -> ()
        }) : (tensor<64x128xi64>, tensor<64x128xi64>, tensor<64x128xi64>) -> tensor<64x128xi64>
        %155 = "tts.gather"(%27, %154, %122, %23) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (!tt.ptr<bf16>, tensor<64x128xi64>, tensor<64x128xi1>, bf16) -> tensor<64x128xbf16>
        %156 = "func.call"(%140) <{callee = @triton.language.standard.max__fp32S64S_c0_cFalse_cTrue_cFalse}> : (tensor<64xf32>) -> f32
        %157 = "arith.maxnumf"(%156, %arg50) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %158 = "arith.subf"(%arg50, %157) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %159 = "math.exp"(%158) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        %160 = "linalg.fill"(%157, %29) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg73: f32, %arg74: f32):
          "linalg.yield"(%arg73) : (f32) -> ()
        }) : (f32, tensor<64xf32>) -> tensor<64xf32>
        %161 = "linalg.generic"(%140, %160, %140) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg70: f32, %arg71: f32, %arg72: f32):
          %181 = "arith.subf"(%arg70, %arg71) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%181) : (f32) -> ()
        }) : (tensor<64xf32>, tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>
        %162 = "linalg.generic"(%161, %161) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg68: f32, %arg69: f32):
          %180 = "math.exp"(%arg68) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
          "linalg.yield"(%180) : (f32) -> ()
        }) : (tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>
        %163 = "tensor.empty"() : () -> tensor<128xf32>
        %164 = "linalg.fill"(%159, %163) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg66: f32, %arg67: f32):
          "linalg.yield"(%arg66) : (f32) -> ()
        }) : (f32, tensor<128xf32>) -> tensor<128xf32>
        %165 = "linalg.generic"(%arg52, %164, %arg52) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg63: f32, %arg64: f32, %arg65: f32):
          %179 = "arith.mulf"(%arg63, %arg64) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%179) : (f32) -> ()
        }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
        %166 = "tensor.expand_shape"(%162) <{reassociation = [[0, 1]], static_output_shape = array<i64: 64, 1>}> : (tensor<64xf32>) -> tensor<64x1xf32>
        %167 = "tensor.empty"() : () -> tensor<64x128xf32>
        %168 = "linalg.generic"(%155, %167) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg61: bf16, %arg62: f32):
          %178 = "arith.extf"(%arg61) : (bf16) -> f32
          "linalg.yield"(%178) : (f32) -> ()
        }) : (tensor<64x128xbf16>, tensor<64x128xf32>) -> tensor<64x128xf32>
        %169 = "linalg.generic"(%166, %167) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg59: f32, %arg60: f32):
          "linalg.yield"(%arg59) : (f32) -> ()
        }) {broadcastDims = array<i64: 1>} : (tensor<64x1xf32>, tensor<64x128xf32>) -> tensor<64x128xf32>
        %170 = "linalg.generic"(%169, %168, %169) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg56: f32, %arg57: f32, %arg58: f32):
          %177 = "arith.mulf"(%arg56, %arg57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%177) : (f32) -> ()
        }) : (tensor<64x128xf32>, tensor<64x128xf32>, tensor<64x128xf32>) -> tensor<64x128xf32>
        %171 = "func.call"(%170) <{callee = @triton.language.standard.sum__fp32S64_128S_c0_cFalse_cNone}> : (tensor<64x128xf32>) -> tensor<128xf32>
        %172 = "linalg.generic"(%165, %171, %165) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg53: f32, %arg54: f32, %arg55: f32):
          %176 = "arith.addf"(%arg53, %arg54) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%176) : (f32) -> ()
        }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
        %173 = "arith.mulf"(%arg51, %159) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %174 = "func.call"(%162) <{callee = @triton.language.standard.sum__fp32S64S_c0_cFalse_cNone}> : (tensor<64xf32>) -> f32
        %175 = "arith.addf"(%173, %174) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "scf.yield"(%157, %175, %172) : (f32, f32, tensor<128xf32>) -> ()
      }) : (index, index, index, f32, f32, tensor<128xf32>) -> (f32, f32, tensor<128xf32>)
      %60 = "arith.muli"(%35, %arg37) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %61 = "arith.muli"(%37, %arg38) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %62 = "arith.addi"(%60, %61) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %63 = "arith.muli"(%39, %arg39) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %64 = "arith.addi"(%62, %63) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %65 = "arith.index_cast"(%64) : (i32) -> index
      %66 = "tensor.empty"() : () -> tensor<128xf32>
      %67 = "linalg.fill"(%59#1, %66) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg47: f32, %arg48: f32):
        "linalg.yield"(%arg47) : (f32) -> ()
      }) : (f32, tensor<128xf32>) -> tensor<128xf32>
      %68 = "linalg.generic"(%59#2, %67, %59#2) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg44: f32, %arg45: f32, %arg46: f32):
        %77 = "arith.divf"(%arg44, %arg45) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%77) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %69 = "memref.subview"(%arg27, %65) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<128xf32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%68, %69) <{writable}> : (tensor<128xf32>, memref<128xf32, strided<[1], offset: ?>>) -> ()
      %70 = "arith.addi"(%64, %26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %71 = "math.log"(%59#1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %72 = "arith.addf"(%59#0, %71) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %73 = "arith.index_cast"(%70) : (i32) -> index
      %74 = "tensor.empty"() : () -> tensor<1xf32>
      %75 = "linalg.fill"(%72, %74) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg42: f32, %arg43: f32):
        "linalg.yield"(%arg42) : (f32) -> ()
      }) : (f32, tensor<1xf32>) -> tensor<1xf32>
      %76 = "memref.subview"(%arg27, %73) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%75, %76) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c8", sym_visibility = "private"}> ({
  ^bb0(%arg20: i32):
    %14 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %15 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %16 = "arith.addi"(%arg20, %15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %17 = "arith.divsi"(%16, %14) : (i32, i32) -> i32
    "func.return"(%17) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<128xf32>, sym_name = "triton.language.standard.zeros__Tc128T_cfp32", sym_visibility = "private"}> ({
    %11 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %12 = "tensor.empty"() : () -> tensor<128xf32>
    %13 = "linalg.fill"(%11, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: f32, %arg19: f32):
      "linalg.yield"(%arg18) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    "func.return"(%13) : (tensor<128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<64x128xbf16>) -> tensor<64xbf16>, sym_name = "triton.language.standard.sum__bf16S64_128S_c1_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg15: tensor<64x128xbf16>):
    %9 = "tt.reduce"(%arg15) <{axis = 1 : i32}> ({
    ^bb0(%arg16: bf16, %arg17: bf16):
      %10 = "func.call"(%arg16, %arg17) <{callee = @triton.language.standard._sum_combine__bf16_bf16}> : (bf16, bf16) -> bf16
      "tt.reduce.return"(%10) : (bf16) -> ()
    }) : (tensor<64x128xbf16>) -> tensor<64xbf16>
    "func.return"(%9) : (tensor<64xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (bf16, bf16) -> bf16, sym_name = "triton.language.standard._sum_combine__bf16_bf16", sym_visibility = "private"}> ({
  ^bb0(%arg13: bf16, %arg14: bf16):
    %8 = "arith.addf"(%arg13, %arg14) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
    "func.return"(%8) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<64xf32>) -> f32, sym_name = "triton.language.standard.max__fp32S64S_c0_cFalse_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg10: tensor<64xf32>):
    %6 = "tt.reduce"(%arg10) <{axis = 0 : i32}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      %7 = "func.call"(%arg11, %arg12) <{callee = @triton.language.standard._elementwise_max__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%7) : (f32) -> ()
    }) : (tensor<64xf32>) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._elementwise_max__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg8: f32, %arg9: f32):
    %5 = "arith.maxnumf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<64x128xf32>) -> tensor<128xf32>, sym_name = "triton.language.standard.sum__fp32S64_128S_c0_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg5: tensor<64x128xf32>):
    %3 = "tt.reduce"(%arg5) <{axis = 0 : i32}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      %4 = "func.call"(%arg6, %arg7) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%4) : (f32) -> ()
    }) : (tensor<64x128xf32>) -> tensor<128xf32>
    "func.return"(%3) : (tensor<128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg3: f32, %arg4: f32):
    %2 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<64xf32>) -> f32, sym_name = "triton.language.standard.sum__fp32S64S_c0_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<64xf32>):
    %0 = "tt.reduce"(%arg0) <{axis = 0 : i32}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %1 = "func.call"(%arg1, %arg2) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%1) : (f32) -> ()
    }) : (tensor<64xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

