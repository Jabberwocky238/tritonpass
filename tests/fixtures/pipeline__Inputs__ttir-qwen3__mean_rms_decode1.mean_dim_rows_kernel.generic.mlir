#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32) -> (), sym_name = "mean_dim_rows_kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 512 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "arith.constant"() <{value = 8 : index}> : () -> index
    %6 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 6.000000e+00 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = 5.000000e+00 : f32}> : () -> f32
    %9 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %10 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
    %11 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %12 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %13 = "arith.constant"() <{value = 511 : i32}> : () -> i32
    %14 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %15 = "arith.constant"() <{value = 6 : i32}> : () -> i32
    %16 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %17 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %18 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %19 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %20 = "arith.constant"() <{value = 512 : i32}> : () -> i32
    %21 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %22 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %23 = "tensor.empty"() : () -> tensor<8xf32>
    %24 = "linalg.fill"(%0, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg187: f32, %arg188: f32):
      "linalg.yield"(%arg187) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %25 = "linalg.fill"(%7, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg185: f32, %arg186: f32):
      "linalg.yield"(%arg185) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %26 = "linalg.fill"(%8, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg183: f32, %arg184: f32):
      "linalg.yield"(%arg183) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %27 = "linalg.fill"(%9, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg181: f32, %arg182: f32):
      "linalg.yield"(%arg181) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %28 = "linalg.fill"(%10, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg179: f32, %arg180: f32):
      "linalg.yield"(%arg179) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %29 = "linalg.fill"(%11, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg177: f32, %arg178: f32):
      "linalg.yield"(%arg177) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %30 = "linalg.fill"(%12, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg175: f32, %arg176: f32):
      "linalg.yield"(%arg175) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %31 = "linalg.fill"(%4, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg173: f32, %arg174: f32):
      "linalg.yield"(%arg173) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %32 = "tensor.empty"() : () -> tensor<512xf32>
    %33 = "linalg.fill"(%4, %32) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg171: f32, %arg172: f32):
      "linalg.yield"(%arg171) : (f32) -> ()
    }) : (f32, tensor<512xf32>) -> tensor<512xf32>
    %34 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %35 = "arith.index_cast"(%34) : (index) -> i32
    %36 = "arith.muli"(%35, %22) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %37 = "arith.index_cast"(%36) : (i32) -> index
    %38 = "tensor.empty"() : () -> tensor<8xi32>
    %39 = "linalg.generic"(%38) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg170: i32):
      %288 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %289 = "arith.index_cast"(%288) : (index) -> i32
      "linalg.yield"(%289) : (i32) -> ()
    }) : (tensor<8xi32>) -> tensor<8xi32>
    %40 = "arith.minsi"(%36, %6) : (i32, i32) -> i32
    %41 = "arith.addi"(%arg2, %13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %42 = "arith.divsi"(%41, %20) : (i32, i32) -> i32
    %43 = "arith.muli"(%40, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %44 = "arith.index_cast"(%43) : (i32) -> index
    %45 = "arith.index_cast"(%42) : (i32) -> index
    %46 = "scf.for"(%1, %45, %2, %33) ({
    ^bb0(%arg161: index, %arg162: tensor<512xf32>):
      %273 = "arith.index_cast"(%arg161) : (index) -> i32
      %274 = "arith.muli"(%273, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %275 = "arith.index_cast"(%274) : (i32) -> index
      %276 = "arith.addi"(%275, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %277 = "arith.index_cast"(%arg2) : (i32) -> index
      %278 = "arith.minsi"(%276, %277) : (index, index) -> index
      %279 = "arith.maxsi"(%278, %275) : (index, index) -> index
      %280 = "arith.subi"(%279, %275) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %281 = "arith.addi"(%44, %275) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %282 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%4, %282) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg168: f32, %arg169: f32):
        "linalg.yield"(%arg168) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %283 = "memref.subview"(%arg1, %281, %280) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %284 = "memref.subview"(%282, %280) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%283, %284) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg166: f32, %arg167: f32):
        "linalg.yield"(%arg166) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %285 = "bufferization.to_tensor"(%282) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %286 = "linalg.generic"(%arg162, %285, %arg162) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg163: f32, %arg164: f32, %arg165: f32):
        %287 = "arith.addf"(%arg163, %arg164) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%287) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%286) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %47 = "tensor.empty"() : () -> tensor<f32>
    %48 = "linalg.fill"(%4, %47) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg159: f32, %arg160: f32):
      "linalg.yield"(%arg159) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %49 = "linalg.reduce"(%46, %48) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg157: f32, %arg158: f32):
      %272 = "arith.addf"(%arg157, %arg158) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%272) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<f32>) -> tensor<f32>
    %50 = "tensor.extract"(%49) : (tensor<f32>) -> f32
    %51 = "arith.sitofp"(%arg2) : (i32) -> f32
    %52 = "arith.divf"(%50, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %53 = "linalg.fill"(%52, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg155: f32, %arg156: f32):
      "linalg.yield"(%arg155) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %54 = "linalg.generic"(%39, %23) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg153: i32, %arg154: f32):
      %271 = "arith.sitofp"(%arg153) : (i32) -> f32
      "linalg.yield"(%271) : (f32) -> ()
    }) : (tensor<8xi32>, tensor<8xf32>) -> tensor<8xf32>
    %55 = "linalg.generic"(%54, %31, %54) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg150: f32, %arg151: f32, %arg152: f32):
      %270 = "arith.addf"(%arg150, %arg151) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%270) : (f32) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %56 = "tensor.empty"() : () -> tensor<8xi1>
    %57 = "linalg.generic"(%55, %31, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg147: f32, %arg148: f32, %arg149: i1):
      %269 = "arith.cmpf"(%arg147, %arg148) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%269) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %58 = "linalg.generic"(%57, %53, %31, %53) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg143: i1, %arg144: f32, %arg145: f32, %arg146: f32):
      %268 = "arith.select"(%arg143, %arg144, %arg145) : (i1, f32, f32) -> f32
      "linalg.yield"(%268) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %59 = "arith.addi"(%36, %21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %60 = "arith.minsi"(%59, %6) : (i32, i32) -> i32
    %61 = "arith.muli"(%60, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %62 = "arith.index_cast"(%61) : (i32) -> index
    %63 = "scf.for"(%1, %45, %2, %33) ({
    ^bb0(%arg134: index, %arg135: tensor<512xf32>):
      %253 = "arith.index_cast"(%arg134) : (index) -> i32
      %254 = "arith.muli"(%253, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %255 = "arith.index_cast"(%254) : (i32) -> index
      %256 = "arith.addi"(%255, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %257 = "arith.index_cast"(%arg2) : (i32) -> index
      %258 = "arith.minsi"(%256, %257) : (index, index) -> index
      %259 = "arith.maxsi"(%258, %255) : (index, index) -> index
      %260 = "arith.subi"(%259, %255) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %261 = "arith.addi"(%62, %255) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %262 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%4, %262) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg141: f32, %arg142: f32):
        "linalg.yield"(%arg141) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %263 = "memref.subview"(%arg1, %261, %260) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %264 = "memref.subview"(%262, %260) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%263, %264) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg139: f32, %arg140: f32):
        "linalg.yield"(%arg139) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %265 = "bufferization.to_tensor"(%262) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %266 = "linalg.generic"(%arg135, %265, %arg135) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg136: f32, %arg137: f32, %arg138: f32):
        %267 = "arith.addf"(%arg136, %arg137) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%267) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%266) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %64 = "linalg.reduce"(%63, %48) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg132: f32, %arg133: f32):
      %252 = "arith.addf"(%arg132, %arg133) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%252) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<f32>) -> tensor<f32>
    %65 = "tensor.extract"(%64) : (tensor<f32>) -> f32
    %66 = "arith.divf"(%65, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %67 = "linalg.fill"(%66, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg130: f32, %arg131: f32):
      "linalg.yield"(%arg130) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %68 = "linalg.generic"(%55, %30, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg127: f32, %arg128: f32, %arg129: i1):
      %251 = "arith.cmpf"(%arg127, %arg128) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%251) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %69 = "linalg.generic"(%68, %67, %58, %67) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg123: i1, %arg124: f32, %arg125: f32, %arg126: f32):
      %250 = "arith.select"(%arg123, %arg124, %arg125) : (i1, f32, f32) -> f32
      "linalg.yield"(%250) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %70 = "arith.addi"(%36, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %71 = "arith.minsi"(%70, %6) : (i32, i32) -> i32
    %72 = "arith.muli"(%71, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %73 = "arith.index_cast"(%72) : (i32) -> index
    %74 = "scf.for"(%1, %45, %2, %33) ({
    ^bb0(%arg114: index, %arg115: tensor<512xf32>):
      %235 = "arith.index_cast"(%arg114) : (index) -> i32
      %236 = "arith.muli"(%235, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %237 = "arith.index_cast"(%236) : (i32) -> index
      %238 = "arith.addi"(%237, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %239 = "arith.index_cast"(%arg2) : (i32) -> index
      %240 = "arith.minsi"(%238, %239) : (index, index) -> index
      %241 = "arith.maxsi"(%240, %237) : (index, index) -> index
      %242 = "arith.subi"(%241, %237) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %243 = "arith.addi"(%73, %237) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %244 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%4, %244) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg121: f32, %arg122: f32):
        "linalg.yield"(%arg121) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %245 = "memref.subview"(%arg1, %243, %242) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %246 = "memref.subview"(%244, %242) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%245, %246) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg119: f32, %arg120: f32):
        "linalg.yield"(%arg119) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %247 = "bufferization.to_tensor"(%244) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %248 = "linalg.generic"(%arg115, %247, %arg115) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg116: f32, %arg117: f32, %arg118: f32):
        %249 = "arith.addf"(%arg116, %arg117) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%249) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%248) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %75 = "linalg.reduce"(%74, %48) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg112: f32, %arg113: f32):
      %234 = "arith.addf"(%arg112, %arg113) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%234) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<f32>) -> tensor<f32>
    %76 = "tensor.extract"(%75) : (tensor<f32>) -> f32
    %77 = "arith.divf"(%76, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %78 = "linalg.fill"(%77, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg110: f32, %arg111: f32):
      "linalg.yield"(%arg110) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %79 = "linalg.generic"(%55, %29, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg107: f32, %arg108: f32, %arg109: i1):
      %233 = "arith.cmpf"(%arg107, %arg108) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%233) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %80 = "linalg.generic"(%79, %78, %69, %78) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg103: i1, %arg104: f32, %arg105: f32, %arg106: f32):
      %232 = "arith.select"(%arg103, %arg104, %arg105) : (i1, f32, f32) -> f32
      "linalg.yield"(%232) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %81 = "arith.addi"(%36, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %82 = "arith.minsi"(%81, %6) : (i32, i32) -> i32
    %83 = "arith.muli"(%82, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %84 = "arith.index_cast"(%83) : (i32) -> index
    %85 = "scf.for"(%1, %45, %2, %33) ({
    ^bb0(%arg94: index, %arg95: tensor<512xf32>):
      %217 = "arith.index_cast"(%arg94) : (index) -> i32
      %218 = "arith.muli"(%217, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %219 = "arith.index_cast"(%218) : (i32) -> index
      %220 = "arith.addi"(%219, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %221 = "arith.index_cast"(%arg2) : (i32) -> index
      %222 = "arith.minsi"(%220, %221) : (index, index) -> index
      %223 = "arith.maxsi"(%222, %219) : (index, index) -> index
      %224 = "arith.subi"(%223, %219) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %225 = "arith.addi"(%84, %219) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %226 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%4, %226) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg101: f32, %arg102: f32):
        "linalg.yield"(%arg101) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %227 = "memref.subview"(%arg1, %225, %224) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %228 = "memref.subview"(%226, %224) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%227, %228) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg99: f32, %arg100: f32):
        "linalg.yield"(%arg99) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %229 = "bufferization.to_tensor"(%226) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %230 = "linalg.generic"(%arg95, %229, %arg95) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg96: f32, %arg97: f32, %arg98: f32):
        %231 = "arith.addf"(%arg96, %arg97) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%231) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%230) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %86 = "linalg.reduce"(%85, %48) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg92: f32, %arg93: f32):
      %216 = "arith.addf"(%arg92, %arg93) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%216) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<f32>) -> tensor<f32>
    %87 = "tensor.extract"(%86) : (tensor<f32>) -> f32
    %88 = "arith.divf"(%87, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %89 = "linalg.fill"(%88, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg90: f32, %arg91: f32):
      "linalg.yield"(%arg90) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %90 = "linalg.generic"(%55, %28, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg87: f32, %arg88: f32, %arg89: i1):
      %215 = "arith.cmpf"(%arg87, %arg88) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%215) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %91 = "linalg.generic"(%90, %89, %80, %89) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg83: i1, %arg84: f32, %arg85: f32, %arg86: f32):
      %214 = "arith.select"(%arg83, %arg84, %arg85) : (i1, f32, f32) -> f32
      "linalg.yield"(%214) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %92 = "arith.addi"(%36, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %93 = "arith.minsi"(%92, %6) : (i32, i32) -> i32
    %94 = "arith.muli"(%93, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %95 = "arith.index_cast"(%94) : (i32) -> index
    %96 = "scf.for"(%1, %45, %2, %33) ({
    ^bb0(%arg74: index, %arg75: tensor<512xf32>):
      %199 = "arith.index_cast"(%arg74) : (index) -> i32
      %200 = "arith.muli"(%199, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %201 = "arith.index_cast"(%200) : (i32) -> index
      %202 = "arith.addi"(%201, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %203 = "arith.index_cast"(%arg2) : (i32) -> index
      %204 = "arith.minsi"(%202, %203) : (index, index) -> index
      %205 = "arith.maxsi"(%204, %201) : (index, index) -> index
      %206 = "arith.subi"(%205, %201) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %207 = "arith.addi"(%95, %201) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %208 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%4, %208) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg81: f32, %arg82: f32):
        "linalg.yield"(%arg81) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %209 = "memref.subview"(%arg1, %207, %206) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %210 = "memref.subview"(%208, %206) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%209, %210) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg79: f32, %arg80: f32):
        "linalg.yield"(%arg79) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %211 = "bufferization.to_tensor"(%208) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %212 = "linalg.generic"(%arg75, %211, %arg75) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg76: f32, %arg77: f32, %arg78: f32):
        %213 = "arith.addf"(%arg76, %arg77) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%213) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%212) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %97 = "linalg.reduce"(%96, %48) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg72: f32, %arg73: f32):
      %198 = "arith.addf"(%arg72, %arg73) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%198) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<f32>) -> tensor<f32>
    %98 = "tensor.extract"(%97) : (tensor<f32>) -> f32
    %99 = "arith.divf"(%98, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %100 = "linalg.fill"(%99, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg70: f32, %arg71: f32):
      "linalg.yield"(%arg70) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %101 = "linalg.generic"(%55, %27, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg67: f32, %arg68: f32, %arg69: i1):
      %197 = "arith.cmpf"(%arg67, %arg68) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%197) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %102 = "linalg.generic"(%101, %100, %91, %100) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg63: i1, %arg64: f32, %arg65: f32, %arg66: f32):
      %196 = "arith.select"(%arg63, %arg64, %arg65) : (i1, f32, f32) -> f32
      "linalg.yield"(%196) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %103 = "arith.addi"(%36, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %104 = "arith.minsi"(%103, %6) : (i32, i32) -> i32
    %105 = "arith.muli"(%104, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %106 = "arith.index_cast"(%105) : (i32) -> index
    %107 = "scf.for"(%1, %45, %2, %33) ({
    ^bb0(%arg54: index, %arg55: tensor<512xf32>):
      %181 = "arith.index_cast"(%arg54) : (index) -> i32
      %182 = "arith.muli"(%181, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %183 = "arith.index_cast"(%182) : (i32) -> index
      %184 = "arith.addi"(%183, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %185 = "arith.index_cast"(%arg2) : (i32) -> index
      %186 = "arith.minsi"(%184, %185) : (index, index) -> index
      %187 = "arith.maxsi"(%186, %183) : (index, index) -> index
      %188 = "arith.subi"(%187, %183) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %189 = "arith.addi"(%106, %183) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %190 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%4, %190) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg61: f32, %arg62: f32):
        "linalg.yield"(%arg61) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %191 = "memref.subview"(%arg1, %189, %188) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %192 = "memref.subview"(%190, %188) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%191, %192) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg59: f32, %arg60: f32):
        "linalg.yield"(%arg59) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %193 = "bufferization.to_tensor"(%190) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %194 = "linalg.generic"(%arg55, %193, %arg55) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg56: f32, %arg57: f32, %arg58: f32):
        %195 = "arith.addf"(%arg56, %arg57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%195) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%194) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %108 = "linalg.reduce"(%107, %48) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg52: f32, %arg53: f32):
      %180 = "arith.addf"(%arg52, %arg53) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%180) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<f32>) -> tensor<f32>
    %109 = "tensor.extract"(%108) : (tensor<f32>) -> f32
    %110 = "arith.divf"(%109, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %111 = "linalg.fill"(%110, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg50: f32, %arg51: f32):
      "linalg.yield"(%arg50) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %112 = "linalg.generic"(%55, %26, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg47: f32, %arg48: f32, %arg49: i1):
      %179 = "arith.cmpf"(%arg47, %arg48) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%179) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %113 = "linalg.generic"(%112, %111, %102, %111) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg43: i1, %arg44: f32, %arg45: f32, %arg46: f32):
      %178 = "arith.select"(%arg43, %arg44, %arg45) : (i1, f32, f32) -> f32
      "linalg.yield"(%178) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %114 = "arith.addi"(%36, %15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %115 = "arith.minsi"(%114, %6) : (i32, i32) -> i32
    %116 = "arith.muli"(%115, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %117 = "arith.index_cast"(%116) : (i32) -> index
    %118 = "scf.for"(%1, %45, %2, %33) ({
    ^bb0(%arg34: index, %arg35: tensor<512xf32>):
      %163 = "arith.index_cast"(%arg34) : (index) -> i32
      %164 = "arith.muli"(%163, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %165 = "arith.index_cast"(%164) : (i32) -> index
      %166 = "arith.addi"(%165, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %167 = "arith.index_cast"(%arg2) : (i32) -> index
      %168 = "arith.minsi"(%166, %167) : (index, index) -> index
      %169 = "arith.maxsi"(%168, %165) : (index, index) -> index
      %170 = "arith.subi"(%169, %165) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %171 = "arith.addi"(%117, %165) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %172 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%4, %172) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg41: f32, %arg42: f32):
        "linalg.yield"(%arg41) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %173 = "memref.subview"(%arg1, %171, %170) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %174 = "memref.subview"(%172, %170) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%173, %174) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg39: f32, %arg40: f32):
        "linalg.yield"(%arg39) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %175 = "bufferization.to_tensor"(%172) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %176 = "linalg.generic"(%arg35, %175, %arg35) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg36: f32, %arg37: f32, %arg38: f32):
        %177 = "arith.addf"(%arg36, %arg37) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%177) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%176) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %119 = "linalg.reduce"(%118, %48) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg32: f32, %arg33: f32):
      %162 = "arith.addf"(%arg32, %arg33) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%162) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<f32>) -> tensor<f32>
    %120 = "tensor.extract"(%119) : (tensor<f32>) -> f32
    %121 = "arith.divf"(%120, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %122 = "linalg.fill"(%121, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: f32, %arg31: f32):
      "linalg.yield"(%arg30) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %123 = "linalg.generic"(%55, %25, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg27: f32, %arg28: f32, %arg29: i1):
      %161 = "arith.cmpf"(%arg27, %arg28) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%161) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %124 = "linalg.generic"(%123, %122, %113, %122) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg23: i1, %arg24: f32, %arg25: f32, %arg26: f32):
      %160 = "arith.select"(%arg23, %arg24, %arg25) : (i1, f32, f32) -> f32
      "linalg.yield"(%160) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %125 = "arith.addi"(%36, %14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %126 = "arith.minsi"(%125, %6) : (i32, i32) -> i32
    %127 = "arith.muli"(%126, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %128 = "arith.index_cast"(%127) : (i32) -> index
    %129 = "scf.for"(%1, %45, %2, %33) ({
    ^bb0(%arg14: index, %arg15: tensor<512xf32>):
      %145 = "arith.index_cast"(%arg14) : (index) -> i32
      %146 = "arith.muli"(%145, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %147 = "arith.index_cast"(%146) : (i32) -> index
      %148 = "arith.addi"(%147, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %149 = "arith.index_cast"(%arg2) : (i32) -> index
      %150 = "arith.minsi"(%148, %149) : (index, index) -> index
      %151 = "arith.maxsi"(%150, %147) : (index, index) -> index
      %152 = "arith.subi"(%151, %147) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %153 = "arith.addi"(%128, %147) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %154 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%4, %154) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg21: f32, %arg22: f32):
        "linalg.yield"(%arg21) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %155 = "memref.subview"(%arg1, %153, %152) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %156 = "memref.subview"(%154, %152) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%155, %156) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg19: f32, %arg20: f32):
        "linalg.yield"(%arg19) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %157 = "bufferization.to_tensor"(%154) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %158 = "linalg.generic"(%arg15, %157, %arg15) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg16: f32, %arg17: f32, %arg18: f32):
        %159 = "arith.addf"(%arg16, %arg17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%159) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%158) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %130 = "linalg.reduce"(%129, %48) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      %144 = "arith.addf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%144) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<f32>) -> tensor<f32>
    %131 = "tensor.extract"(%130) : (tensor<f32>) -> f32
    %132 = "arith.divf"(%131, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %133 = "linalg.fill"(%132, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %134 = "linalg.generic"(%55, %24, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32, %arg9: i1):
      %143 = "arith.cmpf"(%arg7, %arg8) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%143) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %135 = "linalg.generic"(%134, %133, %124, %133) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg3: i1, %arg4: f32, %arg5: f32, %arg6: f32):
      %142 = "arith.select"(%arg3, %arg4, %arg5) : (i1, f32, f32) -> f32
      "linalg.yield"(%142) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %136 = "arith.addi"(%37, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %137 = "arith.minsi"(%136, %2) : (index, index) -> index
    %138 = "arith.maxsi"(%137, %37) : (index, index) -> index
    %139 = "arith.subi"(%138, %37) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %140 = "tensor.extract_slice"(%135, %139) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<8xf32>, index) -> tensor<?xf32>
    %141 = "memref.subview"(%arg0, %37, %139) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%140, %141) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

