#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32) -> (), sym_name = "mean_dim_rows_kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32, %arg3: i32):
    %0 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 512 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "arith.constant"() <{value = 8 : index}> : () -> index
    %6 = "arith.constant"() <{value = 6.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 5.000000e+00 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %9 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
    %10 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %11 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %12 = "arith.constant"() <{value = 511 : i32}> : () -> i32
    %13 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %14 = "arith.constant"() <{value = 6 : i32}> : () -> i32
    %15 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %16 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %17 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %18 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %19 = "arith.constant"() <{value = 512 : i32}> : () -> i32
    %20 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %21 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %22 = "tensor.empty"() : () -> tensor<8xf32>
    %23 = "linalg.fill"(%0, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg188: f32, %arg189: f32):
      "linalg.yield"(%arg188) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %24 = "linalg.fill"(%6, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg186: f32, %arg187: f32):
      "linalg.yield"(%arg186) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %25 = "linalg.fill"(%7, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg184: f32, %arg185: f32):
      "linalg.yield"(%arg184) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %26 = "linalg.fill"(%8, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg182: f32, %arg183: f32):
      "linalg.yield"(%arg182) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %27 = "linalg.fill"(%9, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg180: f32, %arg181: f32):
      "linalg.yield"(%arg180) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %28 = "linalg.fill"(%10, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg178: f32, %arg179: f32):
      "linalg.yield"(%arg178) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %29 = "linalg.fill"(%11, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg176: f32, %arg177: f32):
      "linalg.yield"(%arg176) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %30 = "linalg.fill"(%4, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg174: f32, %arg175: f32):
      "linalg.yield"(%arg174) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %31 = "tensor.empty"() : () -> tensor<512xf32>
    %32 = "linalg.fill"(%4, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg172: f32, %arg173: f32):
      "linalg.yield"(%arg172) : (f32) -> ()
    }) : (f32, tensor<512xf32>) -> tensor<512xf32>
    %33 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %34 = "arith.index_cast"(%33) : (index) -> i32
    %35 = "arith.muli"(%34, %21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %36 = "arith.index_cast"(%35) : (i32) -> index
    %37 = "tensor.empty"() : () -> tensor<8xi32>
    %38 = "linalg.generic"(%37) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg171: i32):
      %289 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %290 = "arith.index_cast"(%289) : (index) -> i32
      "linalg.yield"(%290) : (i32) -> ()
    }) : (tensor<8xi32>) -> tensor<8xi32>
    %39 = "arith.subi"(%arg2, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %40 = "arith.minsi"(%35, %39) : (i32, i32) -> i32
    %41 = "arith.addi"(%arg3, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %42 = "arith.divsi"(%41, %19) : (i32, i32) -> i32
    %43 = "arith.muli"(%40, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %44 = "arith.index_cast"(%43) : (i32) -> index
    %45 = "arith.index_cast"(%42) : (i32) -> index
    %46 = "scf.for"(%1, %45, %2, %32) ({
    ^bb0(%arg162: index, %arg163: tensor<512xf32>):
      %274 = "arith.index_cast"(%arg162) : (index) -> i32
      %275 = "arith.muli"(%274, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %276 = "arith.index_cast"(%275) : (i32) -> index
      %277 = "arith.addi"(%276, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %278 = "arith.index_cast"(%arg3) : (i32) -> index
      %279 = "arith.minsi"(%277, %278) : (index, index) -> index
      %280 = "arith.maxsi"(%279, %276) : (index, index) -> index
      %281 = "arith.subi"(%280, %276) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %282 = "arith.addi"(%44, %276) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %283 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%4, %283) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg169: f32, %arg170: f32):
        "linalg.yield"(%arg169) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %284 = "memref.subview"(%arg1, %282, %281) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %285 = "memref.subview"(%283, %281) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%284, %285) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg167: f32, %arg168: f32):
        "linalg.yield"(%arg167) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %286 = "bufferization.to_tensor"(%283) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %287 = "linalg.generic"(%arg163, %286, %arg163) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg164: f32, %arg165: f32, %arg166: f32):
        %288 = "arith.addf"(%arg164, %arg165) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%288) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%287) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %47 = "tensor.empty"() : () -> tensor<f32>
    %48 = "linalg.fill"(%4, %47) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg160: f32, %arg161: f32):
      "linalg.yield"(%arg160) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %49 = "linalg.reduce"(%46, %48) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg158: f32, %arg159: f32):
      %273 = "arith.addf"(%arg158, %arg159) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%273) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<f32>) -> tensor<f32>
    %50 = "tensor.extract"(%49) : (tensor<f32>) -> f32
    %51 = "arith.sitofp"(%arg3) : (i32) -> f32
    %52 = "arith.divf"(%50, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %53 = "linalg.fill"(%52, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg156: f32, %arg157: f32):
      "linalg.yield"(%arg156) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %54 = "linalg.generic"(%38, %22) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg154: i32, %arg155: f32):
      %272 = "arith.sitofp"(%arg154) : (i32) -> f32
      "linalg.yield"(%272) : (f32) -> ()
    }) : (tensor<8xi32>, tensor<8xf32>) -> tensor<8xf32>
    %55 = "linalg.generic"(%54, %30, %54) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg151: f32, %arg152: f32, %arg153: f32):
      %271 = "arith.addf"(%arg151, %arg152) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%271) : (f32) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %56 = "tensor.empty"() : () -> tensor<8xi1>
    %57 = "linalg.generic"(%55, %30, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg148: f32, %arg149: f32, %arg150: i1):
      %270 = "arith.cmpf"(%arg148, %arg149) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%270) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %58 = "linalg.generic"(%57, %53, %30, %53) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg144: i1, %arg145: f32, %arg146: f32, %arg147: f32):
      %269 = "arith.select"(%arg144, %arg145, %arg146) : (i1, f32, f32) -> f32
      "linalg.yield"(%269) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %59 = "arith.addi"(%35, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %60 = "arith.minsi"(%59, %39) : (i32, i32) -> i32
    %61 = "arith.muli"(%60, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %62 = "arith.index_cast"(%61) : (i32) -> index
    %63 = "scf.for"(%1, %45, %2, %32) ({
    ^bb0(%arg135: index, %arg136: tensor<512xf32>):
      %254 = "arith.index_cast"(%arg135) : (index) -> i32
      %255 = "arith.muli"(%254, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %256 = "arith.index_cast"(%255) : (i32) -> index
      %257 = "arith.addi"(%256, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %258 = "arith.index_cast"(%arg3) : (i32) -> index
      %259 = "arith.minsi"(%257, %258) : (index, index) -> index
      %260 = "arith.maxsi"(%259, %256) : (index, index) -> index
      %261 = "arith.subi"(%260, %256) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %262 = "arith.addi"(%62, %256) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %263 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%4, %263) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg142: f32, %arg143: f32):
        "linalg.yield"(%arg142) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %264 = "memref.subview"(%arg1, %262, %261) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %265 = "memref.subview"(%263, %261) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%264, %265) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg140: f32, %arg141: f32):
        "linalg.yield"(%arg140) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %266 = "bufferization.to_tensor"(%263) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %267 = "linalg.generic"(%arg136, %266, %arg136) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg137: f32, %arg138: f32, %arg139: f32):
        %268 = "arith.addf"(%arg137, %arg138) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%268) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%267) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %64 = "linalg.reduce"(%63, %48) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg133: f32, %arg134: f32):
      %253 = "arith.addf"(%arg133, %arg134) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%253) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<f32>) -> tensor<f32>
    %65 = "tensor.extract"(%64) : (tensor<f32>) -> f32
    %66 = "arith.divf"(%65, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %67 = "linalg.fill"(%66, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg131: f32, %arg132: f32):
      "linalg.yield"(%arg131) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %68 = "linalg.generic"(%55, %29, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg128: f32, %arg129: f32, %arg130: i1):
      %252 = "arith.cmpf"(%arg128, %arg129) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%252) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %69 = "linalg.generic"(%68, %67, %58, %67) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg124: i1, %arg125: f32, %arg126: f32, %arg127: f32):
      %251 = "arith.select"(%arg124, %arg125, %arg126) : (i1, f32, f32) -> f32
      "linalg.yield"(%251) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %70 = "arith.addi"(%35, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %71 = "arith.minsi"(%70, %39) : (i32, i32) -> i32
    %72 = "arith.muli"(%71, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %73 = "arith.index_cast"(%72) : (i32) -> index
    %74 = "scf.for"(%1, %45, %2, %32) ({
    ^bb0(%arg115: index, %arg116: tensor<512xf32>):
      %236 = "arith.index_cast"(%arg115) : (index) -> i32
      %237 = "arith.muli"(%236, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %238 = "arith.index_cast"(%237) : (i32) -> index
      %239 = "arith.addi"(%238, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %240 = "arith.index_cast"(%arg3) : (i32) -> index
      %241 = "arith.minsi"(%239, %240) : (index, index) -> index
      %242 = "arith.maxsi"(%241, %238) : (index, index) -> index
      %243 = "arith.subi"(%242, %238) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %244 = "arith.addi"(%73, %238) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %245 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%4, %245) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg122: f32, %arg123: f32):
        "linalg.yield"(%arg122) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %246 = "memref.subview"(%arg1, %244, %243) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %247 = "memref.subview"(%245, %243) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%246, %247) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg120: f32, %arg121: f32):
        "linalg.yield"(%arg120) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %248 = "bufferization.to_tensor"(%245) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %249 = "linalg.generic"(%arg116, %248, %arg116) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg117: f32, %arg118: f32, %arg119: f32):
        %250 = "arith.addf"(%arg117, %arg118) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%250) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%249) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %75 = "linalg.reduce"(%74, %48) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg113: f32, %arg114: f32):
      %235 = "arith.addf"(%arg113, %arg114) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%235) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<f32>) -> tensor<f32>
    %76 = "tensor.extract"(%75) : (tensor<f32>) -> f32
    %77 = "arith.divf"(%76, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %78 = "linalg.fill"(%77, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg111: f32, %arg112: f32):
      "linalg.yield"(%arg111) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %79 = "linalg.generic"(%55, %28, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg108: f32, %arg109: f32, %arg110: i1):
      %234 = "arith.cmpf"(%arg108, %arg109) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%234) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %80 = "linalg.generic"(%79, %78, %69, %78) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg104: i1, %arg105: f32, %arg106: f32, %arg107: f32):
      %233 = "arith.select"(%arg104, %arg105, %arg106) : (i1, f32, f32) -> f32
      "linalg.yield"(%233) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %81 = "arith.addi"(%35, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %82 = "arith.minsi"(%81, %39) : (i32, i32) -> i32
    %83 = "arith.muli"(%82, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %84 = "arith.index_cast"(%83) : (i32) -> index
    %85 = "scf.for"(%1, %45, %2, %32) ({
    ^bb0(%arg95: index, %arg96: tensor<512xf32>):
      %218 = "arith.index_cast"(%arg95) : (index) -> i32
      %219 = "arith.muli"(%218, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %220 = "arith.index_cast"(%219) : (i32) -> index
      %221 = "arith.addi"(%220, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %222 = "arith.index_cast"(%arg3) : (i32) -> index
      %223 = "arith.minsi"(%221, %222) : (index, index) -> index
      %224 = "arith.maxsi"(%223, %220) : (index, index) -> index
      %225 = "arith.subi"(%224, %220) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %226 = "arith.addi"(%84, %220) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %227 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%4, %227) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg102: f32, %arg103: f32):
        "linalg.yield"(%arg102) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %228 = "memref.subview"(%arg1, %226, %225) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %229 = "memref.subview"(%227, %225) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%228, %229) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg100: f32, %arg101: f32):
        "linalg.yield"(%arg100) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %230 = "bufferization.to_tensor"(%227) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %231 = "linalg.generic"(%arg96, %230, %arg96) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg97: f32, %arg98: f32, %arg99: f32):
        %232 = "arith.addf"(%arg97, %arg98) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%232) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%231) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %86 = "linalg.reduce"(%85, %48) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg93: f32, %arg94: f32):
      %217 = "arith.addf"(%arg93, %arg94) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%217) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<f32>) -> tensor<f32>
    %87 = "tensor.extract"(%86) : (tensor<f32>) -> f32
    %88 = "arith.divf"(%87, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %89 = "linalg.fill"(%88, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg91: f32, %arg92: f32):
      "linalg.yield"(%arg91) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %90 = "linalg.generic"(%55, %27, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg88: f32, %arg89: f32, %arg90: i1):
      %216 = "arith.cmpf"(%arg88, %arg89) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%216) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %91 = "linalg.generic"(%90, %89, %80, %89) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg84: i1, %arg85: f32, %arg86: f32, %arg87: f32):
      %215 = "arith.select"(%arg84, %arg85, %arg86) : (i1, f32, f32) -> f32
      "linalg.yield"(%215) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %92 = "arith.addi"(%35, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %93 = "arith.minsi"(%92, %39) : (i32, i32) -> i32
    %94 = "arith.muli"(%93, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %95 = "arith.index_cast"(%94) : (i32) -> index
    %96 = "scf.for"(%1, %45, %2, %32) ({
    ^bb0(%arg75: index, %arg76: tensor<512xf32>):
      %200 = "arith.index_cast"(%arg75) : (index) -> i32
      %201 = "arith.muli"(%200, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %202 = "arith.index_cast"(%201) : (i32) -> index
      %203 = "arith.addi"(%202, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %204 = "arith.index_cast"(%arg3) : (i32) -> index
      %205 = "arith.minsi"(%203, %204) : (index, index) -> index
      %206 = "arith.maxsi"(%205, %202) : (index, index) -> index
      %207 = "arith.subi"(%206, %202) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %208 = "arith.addi"(%95, %202) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %209 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%4, %209) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg82: f32, %arg83: f32):
        "linalg.yield"(%arg82) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %210 = "memref.subview"(%arg1, %208, %207) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %211 = "memref.subview"(%209, %207) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%210, %211) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg80: f32, %arg81: f32):
        "linalg.yield"(%arg80) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %212 = "bufferization.to_tensor"(%209) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %213 = "linalg.generic"(%arg76, %212, %arg76) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg77: f32, %arg78: f32, %arg79: f32):
        %214 = "arith.addf"(%arg77, %arg78) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%214) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%213) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %97 = "linalg.reduce"(%96, %48) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg73: f32, %arg74: f32):
      %199 = "arith.addf"(%arg73, %arg74) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%199) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<f32>) -> tensor<f32>
    %98 = "tensor.extract"(%97) : (tensor<f32>) -> f32
    %99 = "arith.divf"(%98, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %100 = "linalg.fill"(%99, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg71: f32, %arg72: f32):
      "linalg.yield"(%arg71) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %101 = "linalg.generic"(%55, %26, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg68: f32, %arg69: f32, %arg70: i1):
      %198 = "arith.cmpf"(%arg68, %arg69) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%198) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %102 = "linalg.generic"(%101, %100, %91, %100) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg64: i1, %arg65: f32, %arg66: f32, %arg67: f32):
      %197 = "arith.select"(%arg64, %arg65, %arg66) : (i1, f32, f32) -> f32
      "linalg.yield"(%197) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %103 = "arith.addi"(%35, %15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %104 = "arith.minsi"(%103, %39) : (i32, i32) -> i32
    %105 = "arith.muli"(%104, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %106 = "arith.index_cast"(%105) : (i32) -> index
    %107 = "scf.for"(%1, %45, %2, %32) ({
    ^bb0(%arg55: index, %arg56: tensor<512xf32>):
      %182 = "arith.index_cast"(%arg55) : (index) -> i32
      %183 = "arith.muli"(%182, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %184 = "arith.index_cast"(%183) : (i32) -> index
      %185 = "arith.addi"(%184, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %186 = "arith.index_cast"(%arg3) : (i32) -> index
      %187 = "arith.minsi"(%185, %186) : (index, index) -> index
      %188 = "arith.maxsi"(%187, %184) : (index, index) -> index
      %189 = "arith.subi"(%188, %184) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %190 = "arith.addi"(%106, %184) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %191 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%4, %191) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg62: f32, %arg63: f32):
        "linalg.yield"(%arg62) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %192 = "memref.subview"(%arg1, %190, %189) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %193 = "memref.subview"(%191, %189) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%192, %193) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg60: f32, %arg61: f32):
        "linalg.yield"(%arg60) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %194 = "bufferization.to_tensor"(%191) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %195 = "linalg.generic"(%arg56, %194, %arg56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg57: f32, %arg58: f32, %arg59: f32):
        %196 = "arith.addf"(%arg57, %arg58) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%196) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%195) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %108 = "linalg.reduce"(%107, %48) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg53: f32, %arg54: f32):
      %181 = "arith.addf"(%arg53, %arg54) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%181) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<f32>) -> tensor<f32>
    %109 = "tensor.extract"(%108) : (tensor<f32>) -> f32
    %110 = "arith.divf"(%109, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %111 = "linalg.fill"(%110, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg51: f32, %arg52: f32):
      "linalg.yield"(%arg51) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %112 = "linalg.generic"(%55, %25, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg48: f32, %arg49: f32, %arg50: i1):
      %180 = "arith.cmpf"(%arg48, %arg49) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%180) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %113 = "linalg.generic"(%112, %111, %102, %111) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg44: i1, %arg45: f32, %arg46: f32, %arg47: f32):
      %179 = "arith.select"(%arg44, %arg45, %arg46) : (i1, f32, f32) -> f32
      "linalg.yield"(%179) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %114 = "arith.addi"(%35, %14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %115 = "arith.minsi"(%114, %39) : (i32, i32) -> i32
    %116 = "arith.muli"(%115, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %117 = "arith.index_cast"(%116) : (i32) -> index
    %118 = "scf.for"(%1, %45, %2, %32) ({
    ^bb0(%arg35: index, %arg36: tensor<512xf32>):
      %164 = "arith.index_cast"(%arg35) : (index) -> i32
      %165 = "arith.muli"(%164, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %166 = "arith.index_cast"(%165) : (i32) -> index
      %167 = "arith.addi"(%166, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %168 = "arith.index_cast"(%arg3) : (i32) -> index
      %169 = "arith.minsi"(%167, %168) : (index, index) -> index
      %170 = "arith.maxsi"(%169, %166) : (index, index) -> index
      %171 = "arith.subi"(%170, %166) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %172 = "arith.addi"(%117, %166) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %173 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%4, %173) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg42: f32, %arg43: f32):
        "linalg.yield"(%arg42) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %174 = "memref.subview"(%arg1, %172, %171) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %175 = "memref.subview"(%173, %171) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%174, %175) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg40: f32, %arg41: f32):
        "linalg.yield"(%arg40) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %176 = "bufferization.to_tensor"(%173) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %177 = "linalg.generic"(%arg36, %176, %arg36) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg37: f32, %arg38: f32, %arg39: f32):
        %178 = "arith.addf"(%arg37, %arg38) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%178) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%177) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %119 = "linalg.reduce"(%118, %48) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg33: f32, %arg34: f32):
      %163 = "arith.addf"(%arg33, %arg34) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%163) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<f32>) -> tensor<f32>
    %120 = "tensor.extract"(%119) : (tensor<f32>) -> f32
    %121 = "arith.divf"(%120, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %122 = "linalg.fill"(%121, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg31: f32, %arg32: f32):
      "linalg.yield"(%arg31) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %123 = "linalg.generic"(%55, %24, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg28: f32, %arg29: f32, %arg30: i1):
      %162 = "arith.cmpf"(%arg28, %arg29) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%162) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %124 = "linalg.generic"(%123, %122, %113, %122) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg24: i1, %arg25: f32, %arg26: f32, %arg27: f32):
      %161 = "arith.select"(%arg24, %arg25, %arg26) : (i1, f32, f32) -> f32
      "linalg.yield"(%161) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %125 = "arith.addi"(%35, %13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %126 = "arith.minsi"(%125, %39) : (i32, i32) -> i32
    %127 = "arith.muli"(%126, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %128 = "arith.index_cast"(%127) : (i32) -> index
    %129 = "scf.for"(%1, %45, %2, %32) ({
    ^bb0(%arg15: index, %arg16: tensor<512xf32>):
      %146 = "arith.index_cast"(%arg15) : (index) -> i32
      %147 = "arith.muli"(%146, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %148 = "arith.index_cast"(%147) : (i32) -> index
      %149 = "arith.addi"(%148, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %150 = "arith.index_cast"(%arg3) : (i32) -> index
      %151 = "arith.minsi"(%149, %150) : (index, index) -> index
      %152 = "arith.maxsi"(%151, %148) : (index, index) -> index
      %153 = "arith.subi"(%152, %148) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %154 = "arith.addi"(%128, %148) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %155 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%4, %155) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg22: f32, %arg23: f32):
        "linalg.yield"(%arg22) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %156 = "memref.subview"(%arg1, %154, %153) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %157 = "memref.subview"(%155, %153) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%156, %157) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg20: f32, %arg21: f32):
        "linalg.yield"(%arg20) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %158 = "bufferization.to_tensor"(%155) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %159 = "linalg.generic"(%arg16, %158, %arg16) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg17: f32, %arg18: f32, %arg19: f32):
        %160 = "arith.addf"(%arg17, %arg18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%160) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%159) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %130 = "linalg.reduce"(%129, %48) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      %145 = "arith.addf"(%arg13, %arg14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%145) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<f32>) -> tensor<f32>
    %131 = "tensor.extract"(%130) : (tensor<f32>) -> f32
    %132 = "arith.divf"(%131, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %133 = "linalg.fill"(%132, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      "linalg.yield"(%arg11) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %134 = "linalg.generic"(%55, %23, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32, %arg10: i1):
      %144 = "arith.cmpf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%144) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %135 = "linalg.generic"(%134, %133, %124, %133) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg4: i1, %arg5: f32, %arg6: f32, %arg7: f32):
      %143 = "arith.select"(%arg4, %arg5, %arg6) : (i1, f32, f32) -> f32
      "linalg.yield"(%143) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %136 = "arith.addi"(%36, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %137 = "arith.index_cast"(%arg2) : (i32) -> index
    %138 = "arith.minsi"(%136, %137) : (index, index) -> index
    %139 = "arith.maxsi"(%138, %36) : (index, index) -> index
    %140 = "arith.subi"(%139, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %141 = "tensor.extract_slice"(%135, %140) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<8xf32>, index) -> tensor<?xf32>
    %142 = "memref.subview"(%arg0, %36, %140) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%141, %142) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

