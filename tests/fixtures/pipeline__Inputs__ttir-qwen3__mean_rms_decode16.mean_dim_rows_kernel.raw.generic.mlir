#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32) -> (), sym_name = "mean_dim_rows_kernel"}> ({
  ^bb0(%arg10: memref<?xf32>, %arg11: memref<?xf32>, %arg12: i32, %arg13: i32):
    %13 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %14 = "arith.constant"() <{value = 0 : index}> : () -> index
    %15 = "arith.constant"() <{value = 1 : index}> : () -> index
    %16 = "arith.constant"() <{value = 512 : index}> : () -> index
    %17 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %18 = "arith.constant"() <{value = 8 : index}> : () -> index
    %19 = "arith.constant"() <{value = 6.000000e+00 : f32}> : () -> f32
    %20 = "arith.constant"() <{value = 5.000000e+00 : f32}> : () -> f32
    %21 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %22 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
    %23 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %24 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %25 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %26 = "arith.constant"() <{value = 6 : i32}> : () -> i32
    %27 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %28 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %29 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %30 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %31 = "arith.constant"() <{value = 512 : i32}> : () -> i32
    %32 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %33 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %34 = "tensor.empty"() : () -> tensor<8xf32>
    %35 = "linalg.fill"(%13, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg178: f32, %arg179: f32):
      "linalg.yield"(%arg178) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %36 = "linalg.fill"(%19, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg176: f32, %arg177: f32):
      "linalg.yield"(%arg176) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %37 = "linalg.fill"(%20, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg174: f32, %arg175: f32):
      "linalg.yield"(%arg174) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %38 = "linalg.fill"(%21, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg172: f32, %arg173: f32):
      "linalg.yield"(%arg172) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %39 = "linalg.fill"(%22, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg170: f32, %arg171: f32):
      "linalg.yield"(%arg170) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %40 = "linalg.fill"(%23, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg168: f32, %arg169: f32):
      "linalg.yield"(%arg168) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %41 = "linalg.fill"(%24, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg166: f32, %arg167: f32):
      "linalg.yield"(%arg166) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %42 = "linalg.fill"(%17, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg164: f32, %arg165: f32):
      "linalg.yield"(%arg164) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %43 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %44 = "arith.index_cast"(%43) : (index) -> i32
    %45 = "arith.muli"(%44, %33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %46 = "arith.index_cast"(%45) : (i32) -> index
    %47 = "tensor.empty"() : () -> tensor<8xi32>
    %48 = "linalg.generic"(%47) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg163: i32):
      %303 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %304 = "arith.index_cast"(%303) : (index) -> i32
      "linalg.yield"(%304) : (i32) -> ()
    }) : (tensor<8xi32>) -> tensor<8xi32>
    %49 = "func.call"() <{callee = @triton.language.standard.zeros__Tc8T_cfp32}> : () -> tensor<8xf32>
    %50 = "arith.subi"(%arg12, %32) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %51 = "arith.minsi"(%45, %50) : (i32, i32) -> i32
    %52 = "func.call"() <{callee = @triton.language.standard.zeros__Tc512T_cfp32}> : () -> tensor<512xf32>
    %53 = "func.call"(%arg13) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %54 = "arith.index_cast"(%53) : (i32) -> index
    %55 = "scf.for"(%14, %54, %15, %52) ({
    ^bb0(%arg154: index, %arg155: tensor<512xf32>):
      %286 = "arith.index_cast"(%arg154) : (index) -> i32
      %287 = "arith.muli"(%286, %31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %288 = "arith.index_cast"(%287) : (i32) -> index
      %289 = "arith.muli"(%51, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %290 = "arith.index_cast"(%289) : (i32) -> index
      %291 = "arith.addi"(%288, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %292 = "arith.index_cast"(%arg13) : (i32) -> index
      %293 = "arith.minsi"(%291, %292) : (index, index) -> index
      %294 = "arith.maxsi"(%293, %288) : (index, index) -> index
      %295 = "arith.subi"(%294, %288) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %296 = "arith.addi"(%290, %288) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %297 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%17, %297) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg161: f32, %arg162: f32):
        "linalg.yield"(%arg161) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %298 = "memref.subview"(%arg11, %296, %295) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %299 = "memref.subview"(%297, %295) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%298, %299) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg159: f32, %arg160: f32):
        "linalg.yield"(%arg159) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %300 = "bufferization.to_tensor"(%297) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %301 = "linalg.generic"(%arg155, %300, %arg155) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg156: f32, %arg157: f32, %arg158: f32):
        %302 = "arith.addf"(%arg156, %arg157) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%302) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%301) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %56 = "func.call"(%55) <{callee = @triton.language.standard.sum__fp32S512S_c0_cFalse_cNone}> : (tensor<512xf32>) -> f32
    %57 = "arith.sitofp"(%arg13) : (i32) -> f32
    %58 = "arith.divf"(%56, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %59 = "linalg.fill"(%58, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg152: f32, %arg153: f32):
      "linalg.yield"(%arg152) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %60 = "linalg.generic"(%48, %34) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg150: i32, %arg151: f32):
      %285 = "arith.sitofp"(%arg150) : (i32) -> f32
      "linalg.yield"(%285) : (f32) -> ()
    }) : (tensor<8xi32>, tensor<8xf32>) -> tensor<8xf32>
    %61 = "linalg.generic"(%60, %42, %60) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg147: f32, %arg148: f32, %arg149: f32):
      %284 = "arith.addf"(%arg147, %arg148) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%284) : (f32) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %62 = "tensor.empty"() : () -> tensor<8xi1>
    %63 = "linalg.generic"(%61, %42, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg144: f32, %arg145: f32, %arg146: i1):
      %283 = "arith.cmpf"(%arg144, %arg145) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%283) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %64 = "linalg.generic"(%63, %59, %49, %59) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg140: i1, %arg141: f32, %arg142: f32, %arg143: f32):
      %282 = "arith.select"(%arg140, %arg141, %arg142) : (i1, f32, f32) -> f32
      "linalg.yield"(%282) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %65 = "arith.addi"(%45, %32) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %66 = "arith.minsi"(%65, %50) : (i32, i32) -> i32
    %67 = "func.call"() <{callee = @triton.language.standard.zeros__Tc512T_cfp32}> : () -> tensor<512xf32>
    %68 = "func.call"(%arg13) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %69 = "arith.index_cast"(%68) : (i32) -> index
    %70 = "scf.for"(%14, %69, %15, %67) ({
    ^bb0(%arg131: index, %arg132: tensor<512xf32>):
      %265 = "arith.index_cast"(%arg131) : (index) -> i32
      %266 = "arith.muli"(%265, %31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %267 = "arith.index_cast"(%266) : (i32) -> index
      %268 = "arith.muli"(%66, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %269 = "arith.index_cast"(%268) : (i32) -> index
      %270 = "arith.addi"(%267, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %271 = "arith.index_cast"(%arg13) : (i32) -> index
      %272 = "arith.minsi"(%270, %271) : (index, index) -> index
      %273 = "arith.maxsi"(%272, %267) : (index, index) -> index
      %274 = "arith.subi"(%273, %267) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %275 = "arith.addi"(%269, %267) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %276 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%17, %276) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg138: f32, %arg139: f32):
        "linalg.yield"(%arg138) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %277 = "memref.subview"(%arg11, %275, %274) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %278 = "memref.subview"(%276, %274) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%277, %278) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg136: f32, %arg137: f32):
        "linalg.yield"(%arg136) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %279 = "bufferization.to_tensor"(%276) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %280 = "linalg.generic"(%arg132, %279, %arg132) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg133: f32, %arg134: f32, %arg135: f32):
        %281 = "arith.addf"(%arg133, %arg134) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%281) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%280) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %71 = "func.call"(%70) <{callee = @triton.language.standard.sum__fp32S512S_c0_cFalse_cNone}> : (tensor<512xf32>) -> f32
    %72 = "arith.divf"(%71, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %73 = "linalg.fill"(%72, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg129: f32, %arg130: f32):
      "linalg.yield"(%arg129) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %74 = "linalg.generic"(%61, %41, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg126: f32, %arg127: f32, %arg128: i1):
      %264 = "arith.cmpf"(%arg126, %arg127) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%264) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %75 = "linalg.generic"(%74, %73, %64, %73) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg122: i1, %arg123: f32, %arg124: f32, %arg125: f32):
      %263 = "arith.select"(%arg122, %arg123, %arg124) : (i1, f32, f32) -> f32
      "linalg.yield"(%263) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %76 = "arith.addi"(%45, %30) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %77 = "arith.minsi"(%76, %50) : (i32, i32) -> i32
    %78 = "func.call"() <{callee = @triton.language.standard.zeros__Tc512T_cfp32}> : () -> tensor<512xf32>
    %79 = "func.call"(%arg13) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %80 = "arith.index_cast"(%79) : (i32) -> index
    %81 = "scf.for"(%14, %80, %15, %78) ({
    ^bb0(%arg113: index, %arg114: tensor<512xf32>):
      %246 = "arith.index_cast"(%arg113) : (index) -> i32
      %247 = "arith.muli"(%246, %31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %248 = "arith.index_cast"(%247) : (i32) -> index
      %249 = "arith.muli"(%77, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %250 = "arith.index_cast"(%249) : (i32) -> index
      %251 = "arith.addi"(%248, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %252 = "arith.index_cast"(%arg13) : (i32) -> index
      %253 = "arith.minsi"(%251, %252) : (index, index) -> index
      %254 = "arith.maxsi"(%253, %248) : (index, index) -> index
      %255 = "arith.subi"(%254, %248) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %256 = "arith.addi"(%250, %248) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %257 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%17, %257) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg120: f32, %arg121: f32):
        "linalg.yield"(%arg120) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %258 = "memref.subview"(%arg11, %256, %255) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %259 = "memref.subview"(%257, %255) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%258, %259) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg118: f32, %arg119: f32):
        "linalg.yield"(%arg118) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %260 = "bufferization.to_tensor"(%257) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %261 = "linalg.generic"(%arg114, %260, %arg114) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg115: f32, %arg116: f32, %arg117: f32):
        %262 = "arith.addf"(%arg115, %arg116) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%262) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%261) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %82 = "func.call"(%81) <{callee = @triton.language.standard.sum__fp32S512S_c0_cFalse_cNone}> : (tensor<512xf32>) -> f32
    %83 = "arith.divf"(%82, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %84 = "linalg.fill"(%83, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg111: f32, %arg112: f32):
      "linalg.yield"(%arg111) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %85 = "linalg.generic"(%61, %40, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg108: f32, %arg109: f32, %arg110: i1):
      %245 = "arith.cmpf"(%arg108, %arg109) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%245) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %86 = "linalg.generic"(%85, %84, %75, %84) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg104: i1, %arg105: f32, %arg106: f32, %arg107: f32):
      %244 = "arith.select"(%arg104, %arg105, %arg106) : (i1, f32, f32) -> f32
      "linalg.yield"(%244) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %87 = "arith.addi"(%45, %29) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %88 = "arith.minsi"(%87, %50) : (i32, i32) -> i32
    %89 = "func.call"() <{callee = @triton.language.standard.zeros__Tc512T_cfp32}> : () -> tensor<512xf32>
    %90 = "func.call"(%arg13) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %91 = "arith.index_cast"(%90) : (i32) -> index
    %92 = "scf.for"(%14, %91, %15, %89) ({
    ^bb0(%arg95: index, %arg96: tensor<512xf32>):
      %227 = "arith.index_cast"(%arg95) : (index) -> i32
      %228 = "arith.muli"(%227, %31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %229 = "arith.index_cast"(%228) : (i32) -> index
      %230 = "arith.muli"(%88, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %231 = "arith.index_cast"(%230) : (i32) -> index
      %232 = "arith.addi"(%229, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %233 = "arith.index_cast"(%arg13) : (i32) -> index
      %234 = "arith.minsi"(%232, %233) : (index, index) -> index
      %235 = "arith.maxsi"(%234, %229) : (index, index) -> index
      %236 = "arith.subi"(%235, %229) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %237 = "arith.addi"(%231, %229) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %238 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%17, %238) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg102: f32, %arg103: f32):
        "linalg.yield"(%arg102) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %239 = "memref.subview"(%arg11, %237, %236) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %240 = "memref.subview"(%238, %236) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%239, %240) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg100: f32, %arg101: f32):
        "linalg.yield"(%arg100) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %241 = "bufferization.to_tensor"(%238) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %242 = "linalg.generic"(%arg96, %241, %arg96) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg97: f32, %arg98: f32, %arg99: f32):
        %243 = "arith.addf"(%arg97, %arg98) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%243) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%242) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %93 = "func.call"(%92) <{callee = @triton.language.standard.sum__fp32S512S_c0_cFalse_cNone}> : (tensor<512xf32>) -> f32
    %94 = "arith.divf"(%93, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %95 = "linalg.fill"(%94, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg93: f32, %arg94: f32):
      "linalg.yield"(%arg93) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %96 = "linalg.generic"(%61, %39, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg90: f32, %arg91: f32, %arg92: i1):
      %226 = "arith.cmpf"(%arg90, %arg91) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%226) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %97 = "linalg.generic"(%96, %95, %86, %95) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg86: i1, %arg87: f32, %arg88: f32, %arg89: f32):
      %225 = "arith.select"(%arg86, %arg87, %arg88) : (i1, f32, f32) -> f32
      "linalg.yield"(%225) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %98 = "arith.addi"(%45, %28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %99 = "arith.minsi"(%98, %50) : (i32, i32) -> i32
    %100 = "func.call"() <{callee = @triton.language.standard.zeros__Tc512T_cfp32}> : () -> tensor<512xf32>
    %101 = "func.call"(%arg13) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %102 = "arith.index_cast"(%101) : (i32) -> index
    %103 = "scf.for"(%14, %102, %15, %100) ({
    ^bb0(%arg77: index, %arg78: tensor<512xf32>):
      %208 = "arith.index_cast"(%arg77) : (index) -> i32
      %209 = "arith.muli"(%208, %31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %210 = "arith.index_cast"(%209) : (i32) -> index
      %211 = "arith.muli"(%99, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %212 = "arith.index_cast"(%211) : (i32) -> index
      %213 = "arith.addi"(%210, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %214 = "arith.index_cast"(%arg13) : (i32) -> index
      %215 = "arith.minsi"(%213, %214) : (index, index) -> index
      %216 = "arith.maxsi"(%215, %210) : (index, index) -> index
      %217 = "arith.subi"(%216, %210) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %218 = "arith.addi"(%212, %210) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %219 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%17, %219) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg84: f32, %arg85: f32):
        "linalg.yield"(%arg84) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %220 = "memref.subview"(%arg11, %218, %217) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %221 = "memref.subview"(%219, %217) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%220, %221) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg82: f32, %arg83: f32):
        "linalg.yield"(%arg82) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %222 = "bufferization.to_tensor"(%219) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %223 = "linalg.generic"(%arg78, %222, %arg78) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg79: f32, %arg80: f32, %arg81: f32):
        %224 = "arith.addf"(%arg79, %arg80) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%224) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%223) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %104 = "func.call"(%103) <{callee = @triton.language.standard.sum__fp32S512S_c0_cFalse_cNone}> : (tensor<512xf32>) -> f32
    %105 = "arith.divf"(%104, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %106 = "linalg.fill"(%105, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg75: f32, %arg76: f32):
      "linalg.yield"(%arg75) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %107 = "linalg.generic"(%61, %38, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg72: f32, %arg73: f32, %arg74: i1):
      %207 = "arith.cmpf"(%arg72, %arg73) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%207) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %108 = "linalg.generic"(%107, %106, %97, %106) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg68: i1, %arg69: f32, %arg70: f32, %arg71: f32):
      %206 = "arith.select"(%arg68, %arg69, %arg70) : (i1, f32, f32) -> f32
      "linalg.yield"(%206) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %109 = "arith.addi"(%45, %27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %110 = "arith.minsi"(%109, %50) : (i32, i32) -> i32
    %111 = "func.call"() <{callee = @triton.language.standard.zeros__Tc512T_cfp32}> : () -> tensor<512xf32>
    %112 = "func.call"(%arg13) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %113 = "arith.index_cast"(%112) : (i32) -> index
    %114 = "scf.for"(%14, %113, %15, %111) ({
    ^bb0(%arg59: index, %arg60: tensor<512xf32>):
      %189 = "arith.index_cast"(%arg59) : (index) -> i32
      %190 = "arith.muli"(%189, %31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %191 = "arith.index_cast"(%190) : (i32) -> index
      %192 = "arith.muli"(%110, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %193 = "arith.index_cast"(%192) : (i32) -> index
      %194 = "arith.addi"(%191, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %195 = "arith.index_cast"(%arg13) : (i32) -> index
      %196 = "arith.minsi"(%194, %195) : (index, index) -> index
      %197 = "arith.maxsi"(%196, %191) : (index, index) -> index
      %198 = "arith.subi"(%197, %191) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %199 = "arith.addi"(%193, %191) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %200 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%17, %200) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg66: f32, %arg67: f32):
        "linalg.yield"(%arg66) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %201 = "memref.subview"(%arg11, %199, %198) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %202 = "memref.subview"(%200, %198) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%201, %202) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg64: f32, %arg65: f32):
        "linalg.yield"(%arg64) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %203 = "bufferization.to_tensor"(%200) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %204 = "linalg.generic"(%arg60, %203, %arg60) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg61: f32, %arg62: f32, %arg63: f32):
        %205 = "arith.addf"(%arg61, %arg62) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%205) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%204) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %115 = "func.call"(%114) <{callee = @triton.language.standard.sum__fp32S512S_c0_cFalse_cNone}> : (tensor<512xf32>) -> f32
    %116 = "arith.divf"(%115, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %117 = "linalg.fill"(%116, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg57: f32, %arg58: f32):
      "linalg.yield"(%arg57) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %118 = "linalg.generic"(%61, %37, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg54: f32, %arg55: f32, %arg56: i1):
      %188 = "arith.cmpf"(%arg54, %arg55) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%188) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %119 = "linalg.generic"(%118, %117, %108, %117) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg50: i1, %arg51: f32, %arg52: f32, %arg53: f32):
      %187 = "arith.select"(%arg50, %arg51, %arg52) : (i1, f32, f32) -> f32
      "linalg.yield"(%187) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %120 = "arith.addi"(%45, %26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %121 = "arith.minsi"(%120, %50) : (i32, i32) -> i32
    %122 = "func.call"() <{callee = @triton.language.standard.zeros__Tc512T_cfp32}> : () -> tensor<512xf32>
    %123 = "func.call"(%arg13) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %124 = "arith.index_cast"(%123) : (i32) -> index
    %125 = "scf.for"(%14, %124, %15, %122) ({
    ^bb0(%arg41: index, %arg42: tensor<512xf32>):
      %170 = "arith.index_cast"(%arg41) : (index) -> i32
      %171 = "arith.muli"(%170, %31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %172 = "arith.index_cast"(%171) : (i32) -> index
      %173 = "arith.muli"(%121, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %174 = "arith.index_cast"(%173) : (i32) -> index
      %175 = "arith.addi"(%172, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %176 = "arith.index_cast"(%arg13) : (i32) -> index
      %177 = "arith.minsi"(%175, %176) : (index, index) -> index
      %178 = "arith.maxsi"(%177, %172) : (index, index) -> index
      %179 = "arith.subi"(%178, %172) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %180 = "arith.addi"(%174, %172) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %181 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%17, %181) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg48: f32, %arg49: f32):
        "linalg.yield"(%arg48) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %182 = "memref.subview"(%arg11, %180, %179) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %183 = "memref.subview"(%181, %179) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%182, %183) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg46: f32, %arg47: f32):
        "linalg.yield"(%arg46) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %184 = "bufferization.to_tensor"(%181) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %185 = "linalg.generic"(%arg42, %184, %arg42) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg43: f32, %arg44: f32, %arg45: f32):
        %186 = "arith.addf"(%arg43, %arg44) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%186) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%185) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %126 = "func.call"(%125) <{callee = @triton.language.standard.sum__fp32S512S_c0_cFalse_cNone}> : (tensor<512xf32>) -> f32
    %127 = "arith.divf"(%126, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %128 = "linalg.fill"(%127, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg39: f32, %arg40: f32):
      "linalg.yield"(%arg39) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %129 = "linalg.generic"(%61, %36, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg36: f32, %arg37: f32, %arg38: i1):
      %169 = "arith.cmpf"(%arg36, %arg37) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%169) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %130 = "linalg.generic"(%129, %128, %119, %128) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg32: i1, %arg33: f32, %arg34: f32, %arg35: f32):
      %168 = "arith.select"(%arg32, %arg33, %arg34) : (i1, f32, f32) -> f32
      "linalg.yield"(%168) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %131 = "arith.addi"(%45, %25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %132 = "arith.minsi"(%131, %50) : (i32, i32) -> i32
    %133 = "func.call"() <{callee = @triton.language.standard.zeros__Tc512T_cfp32}> : () -> tensor<512xf32>
    %134 = "func.call"(%arg13) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %135 = "arith.index_cast"(%134) : (i32) -> index
    %136 = "scf.for"(%14, %135, %15, %133) ({
    ^bb0(%arg23: index, %arg24: tensor<512xf32>):
      %151 = "arith.index_cast"(%arg23) : (index) -> i32
      %152 = "arith.muli"(%151, %31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %153 = "arith.index_cast"(%152) : (i32) -> index
      %154 = "arith.muli"(%132, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %155 = "arith.index_cast"(%154) : (i32) -> index
      %156 = "arith.addi"(%153, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %157 = "arith.index_cast"(%arg13) : (i32) -> index
      %158 = "arith.minsi"(%156, %157) : (index, index) -> index
      %159 = "arith.maxsi"(%158, %153) : (index, index) -> index
      %160 = "arith.subi"(%159, %153) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %161 = "arith.addi"(%155, %153) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %162 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%17, %162) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg30: f32, %arg31: f32):
        "linalg.yield"(%arg30) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %163 = "memref.subview"(%arg11, %161, %160) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %164 = "memref.subview"(%162, %160) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%163, %164) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg28: f32, %arg29: f32):
        "linalg.yield"(%arg28) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %165 = "bufferization.to_tensor"(%162) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %166 = "linalg.generic"(%arg24, %165, %arg24) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg25: f32, %arg26: f32, %arg27: f32):
        %167 = "arith.addf"(%arg25, %arg26) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%167) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%166) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %137 = "func.call"(%136) <{callee = @triton.language.standard.sum__fp32S512S_c0_cFalse_cNone}> : (tensor<512xf32>) -> f32
    %138 = "arith.divf"(%137, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %139 = "linalg.fill"(%138, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: f32, %arg22: f32):
      "linalg.yield"(%arg21) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %140 = "linalg.generic"(%61, %35, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg18: f32, %arg19: f32, %arg20: i1):
      %150 = "arith.cmpf"(%arg18, %arg19) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%150) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %141 = "linalg.generic"(%140, %139, %130, %139) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg14: i1, %arg15: f32, %arg16: f32, %arg17: f32):
      %149 = "arith.select"(%arg14, %arg15, %arg16) : (i1, f32, f32) -> f32
      "linalg.yield"(%149) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %142 = "arith.addi"(%46, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %143 = "arith.index_cast"(%arg12) : (i32) -> index
    %144 = "arith.minsi"(%142, %143) : (index, index) -> index
    %145 = "arith.maxsi"(%144, %46) : (index, index) -> index
    %146 = "arith.subi"(%145, %46) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %147 = "tensor.extract_slice"(%141, %146) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<8xf32>, index) -> tensor<?xf32>
    %148 = "memref.subview"(%arg10, %46, %146) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%147, %148) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<8xf32>, sym_name = "triton.language.standard.zeros__Tc8T_cfp32", sym_visibility = "private"}> ({
    %10 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %11 = "tensor.empty"() : () -> tensor<8xf32>
    %12 = "linalg.fill"(%10, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    "func.return"(%12) : (tensor<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<512xf32>, sym_name = "triton.language.standard.zeros__Tc512T_cfp32", sym_visibility = "private"}> ({
    %7 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %8 = "tensor.empty"() : () -> tensor<512xf32>
    %9 = "linalg.fill"(%7, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<512xf32>) -> tensor<512xf32>
    "func.return"(%9) : (tensor<512xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c512", sym_visibility = "private"}> ({
  ^bb0(%arg5: i32):
    %3 = "arith.constant"() <{value = 512 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 511 : i32}> : () -> i32
    %5 = "arith.addi"(%arg5, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "arith.divsi"(%5, %3) : (i32, i32) -> i32
    "func.return"(%6) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<512xf32>) -> f32, sym_name = "triton.language.standard.sum__fp32S512S_c0_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<512xf32>):
    %1 = "tt.reduce"(%arg2) <{axis = 0 : i32}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%2) : (f32) -> ()
    }) : (tensor<512xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

