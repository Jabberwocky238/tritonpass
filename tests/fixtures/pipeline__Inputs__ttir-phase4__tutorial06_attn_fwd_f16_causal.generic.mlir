#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map4 = affine_map<(d0, d1) -> (d0, d1)>
#map5 = affine_map<(d0, d1) -> (d0, 0)>
#map6 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (f32, memref<?xf32>, i32, memref<?xf16>, memref<?xf16>, memref<?xf16>, memref<?xf16>, i32) -> (), sym_name = "_attn_fwd"}> ({
  ^bb0(%arg0: f32, %arg1: memref<?xf32>, %arg2: i32, %arg3: memref<?xf16>, %arg4: memref<?xf16>, %arg5: memref<?xf16>, %arg6: memref<?xf16>, %arg7: i32):
    %0 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 64 : index}> : () -> index
    %3 = "arith.constant"() <{value = 128 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %5 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %9 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %10 = "arith.constant"() <{value = -1.000000e+06 : f32}> : () -> f32
    %11 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %12 = "arith.constant"() <{value = 1.44269502 : f32}> : () -> f32
    %13 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %14 = "tensor.empty"() : () -> tensor<64xf32>
    %15 = "linalg.fill"(%0, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg193: f32, %arg194: f32):
      "linalg.yield"(%arg193) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    %16 = "linalg.fill"(%6, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg191: f32, %arg192: f32):
      "linalg.yield"(%arg191) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    %17 = "tensor.empty"() : () -> tensor<128xf32>
    %18 = "linalg.fill"(%6, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg189: f32, %arg190: f32):
      "linalg.yield"(%arg189) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %19 = "linalg.fill"(%7, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg187: f32, %arg188: f32):
      "linalg.yield"(%arg187) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %20 = "linalg.fill"(%8, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg185: f32, %arg186: f32):
      "linalg.yield"(%arg185) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %21 = "tensor.empty"() : () -> tensor<128x64xf32>
    %22 = "linalg.fill"(%10, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg183: f32, %arg184: f32):
      "linalg.yield"(%arg183) : (f32) -> ()
    }) : (f32, tensor<128x64xf32>) -> tensor<128x64xf32>
    %23 = "linalg.fill"(%6, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg181: f32, %arg182: f32):
      "linalg.yield"(%arg181) : (f32) -> ()
    }) : (f32, tensor<128x64xf32>) -> tensor<128x64xf32>
    %24 = "tensor.empty"() : () -> tensor<128x128xf32>
    %25 = "linalg.fill"(%6, %24) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg179: f32, %arg180: f32):
      "linalg.yield"(%arg179) : (f32) -> ()
    }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
    %26 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %27 = "arith.index_cast"(%26) : (index) -> i32
    %28 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %29 = "arith.index_cast"(%28) : (index) -> i32
    %30 = "arith.divsi"(%29, %arg2) : (i32, i32) -> i32
    %31 = "arith.remsi"(%29, %arg2) : (i32, i32) -> i32
    %32 = "arith.muli"(%arg2, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %33 = "arith.muli"(%30, %32) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %34 = "arith.muli"(%31, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %35 = "arith.addi"(%33, %34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %36 = "arith.muli"(%27, %13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %37 = "arith.index_cast"(%36) : (i32) -> index
    %38 = "arith.addi"(%35, %36) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %39 = "tensor.empty"() : () -> tensor<128xi32>
    %40 = "linalg.generic"(%39) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg178: i32):
      %249 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %250 = "arith.index_cast"(%249) : (index) -> i32
      "linalg.yield"(%250) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %41 = "tensor.empty"() : () -> tensor<64xi32>
    %42 = "linalg.generic"(%41) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg177: i32):
      %247 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %248 = "arith.index_cast"(%247) : (index) -> i32
      "linalg.yield"(%248) : (i32) -> ()
    }) : (tensor<64xi32>) -> tensor<64xi32>
    %43 = "arith.mulf"(%arg0, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %44 = "arith.index_cast"(%38) : (i32) -> index
    %45 = "memref.reinterpret_cast"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf16>) -> memref<1099511627776x1099511627776xf16, strided<[128, 1]>>
    %46 = "arith.addi"(%44, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %47 = "arith.index_cast"(%32) : (i32) -> index
    %48 = "arith.minsi"(%46, %47) : (index, index) -> index
    %49 = "arith.maxsi"(%48, %44) : (index, index) -> index
    %50 = "arith.subi"(%49, %44) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %51 = "arith.minsi"(%50, %3) : (index, index) -> index
    %52 = "arith.minsi"(%51, %3) : (index, index) -> index
    %53 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x128xf16>
    "linalg.fill"(%4, %53) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg175: f16, %arg176: f16):
      "linalg.yield"(%arg175) : (f16) -> ()
    }) : (f16, memref<128x128xf16>) -> ()
    %54 = "memref.subview"(%45, %44, %52) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf16, strided<[128, 1]>>, index, index) -> memref<?x128xf16, strided<[128, 1], offset: ?>>
    %55 = "memref.subview"(%53, %52) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<128x128xf16>, index) -> memref<?x128xf16, strided<[128, 1]>>
    "linalg.copy"(%54, %55) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg173: f16, %arg174: f16):
      "linalg.yield"(%arg173) : (f16) -> ()
    }) : (memref<?x128xf16, strided<[128, 1], offset: ?>>, memref<?x128xf16, strided<[128, 1]>>) -> ()
    %56 = "bufferization.to_tensor"(%53) <{restrict, writable}> : (memref<128x128xf16>) -> tensor<128x128xf16>
    %57 = "linalg.fill"(%43, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg171: f32, %arg172: f32):
      "linalg.yield"(%arg171) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %58 = "linalg.fill"(%43, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg169: f32, %arg170: f32):
      "linalg.yield"(%arg169) : (f32) -> ()
    }) : (f32, tensor<128x64xf32>) -> tensor<128x64xf32>
    %59:5 = "scf.for"(%1, %37, %2, %25, %19, %20, %35, %35) ({
    ^bb0(%arg109: index, %arg110: tensor<128x128xf32>, %arg111: tensor<128xf32>, %arg112: tensor<128xf32>, %arg113: i32, %arg114: i32):
      %179 = "arith.index_cast"(%arg113) : (i32) -> index
      %180 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf16>) -> memref<1099511627776x1099511627776xf16, strided<[128, 1]>>
      %181 = "arith.addi"(%179, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %182 = "arith.minsi"(%181, %47) : (index, index) -> index
      %183 = "arith.maxsi"(%182, %179) : (index, index) -> index
      %184 = "arith.subi"(%183, %179) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %185 = "arith.minsi"(%184, %2) : (index, index) -> index
      %186 = "arith.minsi"(%185, %2) : (index, index) -> index
      %187 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xf16>
      "linalg.fill"(%4, %187) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg167: f16, %arg168: f16):
        "linalg.yield"(%arg167) : (f16) -> ()
      }) : (f16, memref<64x128xf16>) -> ()
      %188 = "memref.subview"(%180, %179, %186) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf16, strided<[128, 1]>>, index, index) -> memref<?x128xf16, strided<[128, 1], offset: ?>>
      %189 = "memref.subview"(%187, %186) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<64x128xf16>, index) -> memref<?x128xf16, strided<[128, 1]>>
      "linalg.copy"(%188, %189) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg165: f16, %arg166: f16):
        "linalg.yield"(%arg165) : (f16) -> ()
      }) : (memref<?x128xf16, strided<[128, 1], offset: ?>>, memref<?x128xf16, strided<[128, 1]>>) -> ()
      %190 = "bufferization.to_tensor"(%187) <{restrict, writable}> : (memref<64x128xf16>) -> tensor<64x128xf16>
      %191 = "tensor.empty"() : () -> tensor<128x64xf16>
      %192 = "linalg.transpose"(%190, %191) <{permutation = array<i64: 1, 0>}> ({
      ^bb0(%arg163: f16, %arg164: f16):
        "linalg.yield"(%arg163) : (f16) -> ()
      }) : (tensor<64x128xf16>, tensor<128x64xf16>) -> tensor<128x64xf16>
      %193 = "linalg.matmul"(%56, %192, %23) <{indexing_maps = [#map1, #map2, #map3], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg160: f16, %arg161: f16, %arg162: f32):
        %243 = "arith.extf"(%arg160) : (f16) -> f32
        %244 = "arith.extf"(%arg161) : (f16) -> f32
        %245 = "arith.mulf"(%243, %244) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %246 = "arith.addf"(%arg162, %245) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%246) : (f32) -> ()
      }) : (tensor<128x128xf16>, tensor<128x64xf16>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %194 = "linalg.reduce"(%193, %20) <{dimensions = array<i64: 1>}> ({
      ^bb0(%arg158: f32, %arg159: f32):
        %242 = "arith.maxnumf"(%arg158, %arg159) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%242) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128xf32>) -> tensor<128xf32>
      %195 = "linalg.generic"(%194, %57, %194) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg155: f32, %arg156: f32, %arg157: f32):
        %241 = "arith.mulf"(%arg155, %arg156) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%241) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %196 = "linalg.generic"(%arg112, %195, %arg112) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg152: f32, %arg153: f32, %arg154: f32):
        %240 = "arith.maxnumf"(%arg152, %arg153) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%240) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %197 = "linalg.generic"(%193, %58, %193) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg149: f32, %arg150: f32, %arg151: f32):
        %239 = "arith.mulf"(%arg149, %arg150) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%239) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %198 = "tensor.expand_shape"(%196) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %199 = "linalg.generic"(%198, %21) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg147: f32, %arg148: f32):
        "linalg.yield"(%arg147) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %200 = "linalg.generic"(%197, %199, %197) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg144: f32, %arg145: f32, %arg146: f32):
        %238 = "arith.subf"(%arg144, %arg145) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%238) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %201 = "linalg.generic"(%200, %200) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg142: f32, %arg143: f32):
        %237 = "math.exp2"(%arg142) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%237) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %202 = "linalg.generic"(%arg112, %196, %arg112) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg139: f32, %arg140: f32, %arg141: f32):
        %236 = "arith.subf"(%arg139, %arg140) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%236) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %203 = "linalg.generic"(%202, %202) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg137: f32, %arg138: f32):
        %235 = "math.exp2"(%arg137) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%235) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %204 = "linalg.reduce"(%201, %18) <{dimensions = array<i64: 1>}> ({
      ^bb0(%arg135: f32, %arg136: f32):
        %234 = "arith.addf"(%arg135, %arg136) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%234) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128xf32>) -> tensor<128xf32>
      %205 = "tensor.expand_shape"(%203) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %206 = "linalg.generic"(%205, %24) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg133: f32, %arg134: f32):
        "linalg.yield"(%arg133) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %207 = "linalg.generic"(%arg110, %206, %arg110) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg130: f32, %arg131: f32, %arg132: f32):
        %233 = "arith.mulf"(%arg130, %arg131) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%233) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %208 = "arith.index_cast"(%arg114) : (i32) -> index
      %209 = "memref.reinterpret_cast"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf16>) -> memref<1099511627776x1099511627776xf16, strided<[128, 1]>>
      %210 = "arith.addi"(%208, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %211 = "arith.minsi"(%210, %47) : (index, index) -> index
      %212 = "arith.maxsi"(%211, %208) : (index, index) -> index
      %213 = "arith.subi"(%212, %208) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %214 = "arith.minsi"(%213, %2) : (index, index) -> index
      %215 = "arith.minsi"(%214, %2) : (index, index) -> index
      %216 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xf16>
      "linalg.fill"(%4, %216) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg128: f16, %arg129: f16):
        "linalg.yield"(%arg128) : (f16) -> ()
      }) : (f16, memref<64x128xf16>) -> ()
      %217 = "memref.subview"(%209, %208, %215) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf16, strided<[128, 1]>>, index, index) -> memref<?x128xf16, strided<[128, 1], offset: ?>>
      %218 = "memref.subview"(%216, %215) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<64x128xf16>, index) -> memref<?x128xf16, strided<[128, 1]>>
      "linalg.copy"(%217, %218) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg126: f16, %arg127: f16):
        "linalg.yield"(%arg126) : (f16) -> ()
      }) : (memref<?x128xf16, strided<[128, 1], offset: ?>>, memref<?x128xf16, strided<[128, 1]>>) -> ()
      %219 = "bufferization.to_tensor"(%216) <{restrict, writable}> : (memref<64x128xf16>) -> tensor<64x128xf16>
      %220 = "linalg.generic"(%201, %191) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg124: f32, %arg125: f16):
        %232 = "arith.truncf"(%arg124) : (f32) -> f16
        "linalg.yield"(%232) : (f16) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf16>) -> tensor<128x64xf16>
      %221 = "linalg.matmul"(%220, %219, %207) <{indexing_maps = [#map1, #map2, #map3], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg121: f16, %arg122: f16, %arg123: f32):
        %228 = "arith.extf"(%arg121) : (f16) -> f32
        %229 = "arith.extf"(%arg122) : (f16) -> f32
        %230 = "arith.mulf"(%228, %229) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %231 = "arith.addf"(%arg123, %230) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%231) : (f32) -> ()
      }) : (tensor<128x64xf16>, tensor<64x128xf16>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %222 = "linalg.generic"(%arg111, %203, %arg111) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg118: f32, %arg119: f32, %arg120: f32):
        %227 = "arith.mulf"(%arg118, %arg119) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%227) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %223 = "linalg.generic"(%222, %204, %222) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg115: f32, %arg116: f32, %arg117: f32):
        %226 = "arith.addf"(%arg115, %arg116) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%226) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %224 = "arith.addi"(%arg113, %11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %225 = "arith.addi"(%arg114, %11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%221, %223, %196, %224, %225) : (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32) -> ()
    }) : (index, index, index, tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32) -> (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32)
    %60 = "arith.muli"(%27, %13) <{overflowFlags = #arith.overflow<none>}> {tt.divisibility = dense<128> : tensor<1xi32>} : (i32, i32) -> i32
    %61 = "arith.addi"(%27, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %62 = "arith.muli"(%61, %13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %63 = "arith.addi"(%35, %60) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %64 = "arith.index_cast"(%60) : (i32) -> index
    %65 = "arith.index_cast"(%62) : (i32) -> index
    %66:5 = "scf.for"(%64, %65, %2, %59#0, %59#1, %59#2, %63, %63) ({
    ^bb0(%arg20: index, %arg21: tensor<128x128xf32>, %arg22: tensor<128xf32>, %arg23: tensor<128xf32>, %arg24: i32, %arg25: i32):
      %85 = "arith.index_cast"(%arg20) : (index) -> i32
      %86 = "arith.index_cast"(%arg24) : (i32) -> index
      %87 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf16>) -> memref<1099511627776x1099511627776xf16, strided<[128, 1]>>
      %88 = "arith.addi"(%86, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %89 = "arith.minsi"(%88, %47) : (index, index) -> index
      %90 = "arith.maxsi"(%89, %86) : (index, index) -> index
      %91 = "arith.subi"(%90, %86) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %92 = "arith.minsi"(%91, %2) : (index, index) -> index
      %93 = "arith.minsi"(%92, %2) : (index, index) -> index
      %94 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xf16>
      "linalg.fill"(%4, %94) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg107: f16, %arg108: f16):
        "linalg.yield"(%arg107) : (f16) -> ()
      }) : (f16, memref<64x128xf16>) -> ()
      %95 = "memref.subview"(%87, %86, %93) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf16, strided<[128, 1]>>, index, index) -> memref<?x128xf16, strided<[128, 1], offset: ?>>
      %96 = "memref.subview"(%94, %93) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<64x128xf16>, index) -> memref<?x128xf16, strided<[128, 1]>>
      "linalg.copy"(%95, %96) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg105: f16, %arg106: f16):
        "linalg.yield"(%arg105) : (f16) -> ()
      }) : (memref<?x128xf16, strided<[128, 1], offset: ?>>, memref<?x128xf16, strided<[128, 1]>>) -> ()
      %97 = "bufferization.to_tensor"(%94) <{restrict, writable}> : (memref<64x128xf16>) -> tensor<64x128xf16>
      %98 = "tensor.empty"() : () -> tensor<128x64xf16>
      %99 = "linalg.transpose"(%97, %98) <{permutation = array<i64: 1, 0>}> ({
      ^bb0(%arg103: f16, %arg104: f16):
        "linalg.yield"(%arg103) : (f16) -> ()
      }) : (tensor<64x128xf16>, tensor<128x64xf16>) -> tensor<128x64xf16>
      %100 = "linalg.matmul"(%56, %99, %23) <{indexing_maps = [#map1, #map2, #map3], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg100: f16, %arg101: f16, %arg102: f32):
        %175 = "arith.extf"(%arg100) : (f16) -> f32
        %176 = "arith.extf"(%arg101) : (f16) -> f32
        %177 = "arith.mulf"(%175, %176) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %178 = "arith.addf"(%arg102, %177) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%178) : (f32) -> ()
      }) : (tensor<128x128xf16>, tensor<128x64xf16>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %101 = "linalg.generic"(%100, %58, %100) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg97: f32, %arg98: f32, %arg99: f32):
        %174 = "arith.mulf"(%arg97, %arg98) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%174) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %102 = "arith.subi"(%36, %85) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %103 = "linalg.generic"(%40, %17) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg95: i32, %arg96: f32):
        %173 = "arith.sitofp"(%arg95) : (i32) -> f32
        "linalg.yield"(%173) : (f32) -> ()
      }) : (tensor<128xi32>, tensor<128xf32>) -> tensor<128xf32>
      %104 = "linalg.generic"(%103, %18, %103) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg92: f32, %arg93: f32, %arg94: f32):
        %172 = "arith.addf"(%arg92, %arg93) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%172) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %105 = "tensor.expand_shape"(%104) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %106 = "linalg.generic"(%105, %21) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg90: f32, %arg91: f32):
        "linalg.yield"(%arg90) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %107 = "linalg.generic"(%42, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg88: i32, %arg89: f32):
        %171 = "arith.sitofp"(%arg88) : (i32) -> f32
        "linalg.yield"(%171) : (f32) -> ()
      }) : (tensor<64xi32>, tensor<64xf32>) -> tensor<64xf32>
      %108 = "linalg.generic"(%107, %15, %107) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg85: f32, %arg86: f32, %arg87: f32):
        %170 = "arith.mulf"(%arg85, %arg86) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%170) : (f32) -> ()
      }) : (tensor<64xf32>, tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>
      %109 = "linalg.generic"(%108, %16, %108) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg82: f32, %arg83: f32, %arg84: f32):
        %169 = "arith.addf"(%arg82, %arg83) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%169) : (f32) -> ()
      }) : (tensor<64xf32>, tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>
      %110 = "tensor.expand_shape"(%109) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 64>}> : (tensor<64xf32>) -> tensor<1x64xf32>
      %111 = "linalg.generic"(%110, %21) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg80: f32, %arg81: f32):
        "linalg.yield"(%arg80) : (f32) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %112 = "linalg.generic"(%106, %111, %106) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg77: f32, %arg78: f32, %arg79: f32):
        %168 = "arith.addf"(%arg77, %arg78) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%168) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %113 = "arith.subi"(%5, %102) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %114 = "arith.sitofp"(%113) : (i32) -> f32
      %115 = "linalg.fill"(%114, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg75: f32, %arg76: f32):
        "linalg.yield"(%arg75) : (f32) -> ()
      }) : (f32, tensor<128x64xf32>) -> tensor<128x64xf32>
      %116 = "tensor.empty"() : () -> tensor<128x64xi1>
      %117 = "linalg.generic"(%112, %115, %116) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg72: f32, %arg73: f32, %arg74: i1):
        %167 = "arith.cmpf"(%arg72, %arg73) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%167) : (i1) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xi1>) -> tensor<128x64xi1>
      %118 = "linalg.generic"(%117, %23, %22, %23) <{indexing_maps = [#map4, #map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg68: i1, %arg69: f32, %arg70: f32, %arg71: f32):
        %166 = "arith.select"(%arg68, %arg69, %arg70) : (i1, f32, f32) -> f32
        "linalg.yield"(%166) : (f32) -> ()
      }) : (tensor<128x64xi1>, tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %119 = "linalg.generic"(%101, %118, %101) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg65: f32, %arg66: f32, %arg67: f32):
        %165 = "arith.addf"(%arg65, %arg66) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%165) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %120 = "linalg.reduce"(%119, %20) <{dimensions = array<i64: 1>}> ({
      ^bb0(%arg63: f32, %arg64: f32):
        %164 = "arith.maxnumf"(%arg63, %arg64) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%164) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128xf32>) -> tensor<128xf32>
      %121 = "linalg.generic"(%arg23, %120, %arg23) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg60: f32, %arg61: f32, %arg62: f32):
        %163 = "arith.maxnumf"(%arg60, %arg61) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%163) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %122 = "tensor.expand_shape"(%121) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %123 = "linalg.generic"(%122, %21) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg58: f32, %arg59: f32):
        "linalg.yield"(%arg58) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %124 = "linalg.generic"(%119, %123, %119) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg55: f32, %arg56: f32, %arg57: f32):
        %162 = "arith.subf"(%arg55, %arg56) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%162) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %125 = "linalg.generic"(%124, %124) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg53: f32, %arg54: f32):
        %161 = "math.exp2"(%arg53) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%161) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %126 = "linalg.generic"(%arg23, %121, %arg23) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg50: f32, %arg51: f32, %arg52: f32):
        %160 = "arith.subf"(%arg50, %arg51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%160) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %127 = "linalg.generic"(%126, %126) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg48: f32, %arg49: f32):
        %159 = "math.exp2"(%arg48) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%159) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %128 = "linalg.reduce"(%125, %18) <{dimensions = array<i64: 1>}> ({
      ^bb0(%arg46: f32, %arg47: f32):
        %158 = "arith.addf"(%arg46, %arg47) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%158) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128xf32>) -> tensor<128xf32>
      %129 = "tensor.expand_shape"(%127) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %130 = "linalg.generic"(%129, %24) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg44: f32, %arg45: f32):
        "linalg.yield"(%arg44) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %131 = "linalg.generic"(%arg21, %130, %arg21) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg41: f32, %arg42: f32, %arg43: f32):
        %157 = "arith.mulf"(%arg41, %arg42) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%157) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %132 = "arith.index_cast"(%arg25) : (i32) -> index
      %133 = "memref.reinterpret_cast"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf16>) -> memref<1099511627776x1099511627776xf16, strided<[128, 1]>>
      %134 = "arith.addi"(%132, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %135 = "arith.minsi"(%134, %47) : (index, index) -> index
      %136 = "arith.maxsi"(%135, %132) : (index, index) -> index
      %137 = "arith.subi"(%136, %132) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %138 = "arith.minsi"(%137, %2) : (index, index) -> index
      %139 = "arith.minsi"(%138, %2) : (index, index) -> index
      %140 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xf16>
      "linalg.fill"(%4, %140) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg39: f16, %arg40: f16):
        "linalg.yield"(%arg39) : (f16) -> ()
      }) : (f16, memref<64x128xf16>) -> ()
      %141 = "memref.subview"(%133, %132, %139) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf16, strided<[128, 1]>>, index, index) -> memref<?x128xf16, strided<[128, 1], offset: ?>>
      %142 = "memref.subview"(%140, %139) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<64x128xf16>, index) -> memref<?x128xf16, strided<[128, 1]>>
      "linalg.copy"(%141, %142) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg37: f16, %arg38: f16):
        "linalg.yield"(%arg37) : (f16) -> ()
      }) : (memref<?x128xf16, strided<[128, 1], offset: ?>>, memref<?x128xf16, strided<[128, 1]>>) -> ()
      %143 = "bufferization.to_tensor"(%140) <{restrict, writable}> : (memref<64x128xf16>) -> tensor<64x128xf16>
      %144 = "linalg.generic"(%125, %98) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg35: f32, %arg36: f16):
        %156 = "arith.truncf"(%arg35) : (f32) -> f16
        "linalg.yield"(%156) : (f16) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf16>) -> tensor<128x64xf16>
      %145 = "linalg.matmul"(%144, %143, %131) <{indexing_maps = [#map1, #map2, #map3], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg32: f16, %arg33: f16, %arg34: f32):
        %152 = "arith.extf"(%arg32) : (f16) -> f32
        %153 = "arith.extf"(%arg33) : (f16) -> f32
        %154 = "arith.mulf"(%152, %153) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %155 = "arith.addf"(%arg34, %154) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%155) : (f32) -> ()
      }) : (tensor<128x64xf16>, tensor<64x128xf16>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %146 = "linalg.generic"(%arg22, %127, %arg22) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg29: f32, %arg30: f32, %arg31: f32):
        %151 = "arith.mulf"(%arg29, %arg30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%151) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %147 = "linalg.generic"(%146, %128, %146) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg26: f32, %arg27: f32, %arg28: f32):
        %150 = "arith.addf"(%arg26, %arg27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%150) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %148 = "arith.addi"(%arg24, %11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %149 = "arith.addi"(%arg25, %11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%145, %147, %121, %148, %149) : (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32) -> ()
    }) : (index, index, index, tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32) -> (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32)
    %67 = "linalg.generic"(%66#1, %66#1) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: f32, %arg19: f32):
      %84 = "math.log2"(%arg18) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%84) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %68 = "linalg.generic"(%66#2, %67, %66#2) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32, %arg17: f32):
      %83 = "arith.addf"(%arg15, %arg16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%83) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %69 = "tensor.expand_shape"(%66#1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
    %70 = "linalg.generic"(%69, %24) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      "linalg.yield"(%arg13) : (f32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    %71 = "linalg.generic"(%66#0, %70, %66#0) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32, %arg12: f32):
      %82 = "arith.divf"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%82) : (f32) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    %72 = "arith.muli"(%29, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %73 = "arith.index_cast"(%72) : (i32) -> index
    %74 = "arith.addi"(%73, %37) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %75 = "memref.subview"(%arg1, %74) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<128xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%68, %75) <{writable}> : (tensor<128xf32>, memref<128xf32, strided<[1], offset: ?>>) -> ()
    %76 = "tensor.empty"() : () -> tensor<128x128xf16>
    %77 = "linalg.generic"(%71, %76) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f16):
      %81 = "arith.truncf"(%arg8) : (f32) -> f16
      "linalg.yield"(%81) : (f16) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xf16>) -> tensor<128x128xf16>
    %78 = "memref.reinterpret_cast"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf16>) -> memref<1099511627776x1099511627776xf16, strided<[128, 1]>>
    %79 = "tensor.extract_slice"(%77, %52) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (tensor<128x128xf16>, index) -> tensor<?x128xf16>
    %80 = "memref.subview"(%78, %44, %52) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf16, strided<[128, 1]>>, index, index) -> memref<?x128xf16, strided<[128, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%79, %80) <{writable}> : (tensor<?x128xf16>, memref<?x128xf16, strided<[128, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

