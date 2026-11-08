#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32) -> (), sym_name = "mean_dim_rows_kernel"}> ({
  ^bb0(%arg10: memref<?xf32>, %arg11: memref<?xf32>, %arg12: i32):
    %13 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %14 = "arith.constant"() <{value = 0 : index}> : () -> index
    %15 = "arith.constant"() <{value = 1 : index}> : () -> index
    %16 = "arith.constant"() <{value = 512 : index}> : () -> index
    %17 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %18 = "arith.constant"() <{value = 8 : index}> : () -> index
    %19 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %20 = "arith.constant"() <{value = 6.000000e+00 : f32}> : () -> f32
    %21 = "arith.constant"() <{value = 5.000000e+00 : f32}> : () -> f32
    %22 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %23 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
    %24 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %25 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %26 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %27 = "arith.constant"() <{value = 6 : i32}> : () -> i32
    %28 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %29 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %30 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %31 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %32 = "arith.constant"() <{value = 512 : i32}> : () -> i32
    %33 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %34 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %35 = "tensor.empty"() : () -> tensor<8xf32>
    %36 = "linalg.fill"(%13, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg177: f32, %arg178: f32):
      "linalg.yield"(%arg177) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %37 = "linalg.fill"(%20, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg175: f32, %arg176: f32):
      "linalg.yield"(%arg175) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %38 = "linalg.fill"(%21, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg173: f32, %arg174: f32):
      "linalg.yield"(%arg173) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %39 = "linalg.fill"(%22, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg171: f32, %arg172: f32):
      "linalg.yield"(%arg171) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %40 = "linalg.fill"(%23, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg169: f32, %arg170: f32):
      "linalg.yield"(%arg169) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %41 = "linalg.fill"(%24, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg167: f32, %arg168: f32):
      "linalg.yield"(%arg167) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %42 = "linalg.fill"(%25, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg165: f32, %arg166: f32):
      "linalg.yield"(%arg165) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %43 = "linalg.fill"(%17, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg163: f32, %arg164: f32):
      "linalg.yield"(%arg163) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %44 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %45 = "arith.index_cast"(%44) : (index) -> i32
    %46 = "arith.muli"(%45, %34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %47 = "arith.index_cast"(%46) : (i32) -> index
    %48 = "tensor.empty"() : () -> tensor<8xi32>
    %49 = "linalg.generic"(%48) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg162: i32):
      %302 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %303 = "arith.index_cast"(%302) : (index) -> i32
      "linalg.yield"(%303) : (i32) -> ()
    }) : (tensor<8xi32>) -> tensor<8xi32>
    %50 = "func.call"() <{callee = @triton.language.standard.zeros__Tc8T_cfp32}> : () -> tensor<8xf32>
    %51 = "arith.minsi"(%46, %19) : (i32, i32) -> i32
    %52 = "func.call"() <{callee = @triton.language.standard.zeros__Tc512T_cfp32}> : () -> tensor<512xf32>
    %53 = "func.call"(%arg12) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %54 = "arith.index_cast"(%53) : (i32) -> index
    %55 = "scf.for"(%14, %54, %15, %52) ({
    ^bb0(%arg153: index, %arg154: tensor<512xf32>):
      %285 = "arith.index_cast"(%arg153) : (index) -> i32
      %286 = "arith.muli"(%285, %32) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %287 = "arith.index_cast"(%286) : (i32) -> index
      %288 = "arith.muli"(%51, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %289 = "arith.index_cast"(%288) : (i32) -> index
      %290 = "arith.addi"(%287, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %291 = "arith.index_cast"(%arg12) : (i32) -> index
      %292 = "arith.minsi"(%290, %291) : (index, index) -> index
      %293 = "arith.maxsi"(%292, %287) : (index, index) -> index
      %294 = "arith.subi"(%293, %287) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %295 = "arith.addi"(%289, %287) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %296 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%17, %296) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg160: f32, %arg161: f32):
        "linalg.yield"(%arg160) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %297 = "memref.subview"(%arg11, %295, %294) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %298 = "memref.subview"(%296, %294) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%297, %298) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg158: f32, %arg159: f32):
        "linalg.yield"(%arg158) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %299 = "bufferization.to_tensor"(%296) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %300 = "linalg.generic"(%arg154, %299, %arg154) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg155: f32, %arg156: f32, %arg157: f32):
        %301 = "arith.addf"(%arg155, %arg156) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%301) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%300) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %56 = "func.call"(%55) <{callee = @triton.language.standard.sum__fp32S512S_c0_cFalse_cNone}> : (tensor<512xf32>) -> f32
    %57 = "arith.sitofp"(%arg12) : (i32) -> f32
    %58 = "arith.divf"(%56, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %59 = "linalg.fill"(%58, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg151: f32, %arg152: f32):
      "linalg.yield"(%arg151) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %60 = "linalg.generic"(%49, %35) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg149: i32, %arg150: f32):
      %284 = "arith.sitofp"(%arg149) : (i32) -> f32
      "linalg.yield"(%284) : (f32) -> ()
    }) : (tensor<8xi32>, tensor<8xf32>) -> tensor<8xf32>
    %61 = "linalg.generic"(%60, %43, %60) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg146: f32, %arg147: f32, %arg148: f32):
      %283 = "arith.addf"(%arg146, %arg147) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%283) : (f32) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %62 = "tensor.empty"() : () -> tensor<8xi1>
    %63 = "linalg.generic"(%61, %43, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg143: f32, %arg144: f32, %arg145: i1):
      %282 = "arith.cmpf"(%arg143, %arg144) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%282) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %64 = "linalg.generic"(%63, %59, %50, %59) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg139: i1, %arg140: f32, %arg141: f32, %arg142: f32):
      %281 = "arith.select"(%arg139, %arg140, %arg141) : (i1, f32, f32) -> f32
      "linalg.yield"(%281) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %65 = "arith.addi"(%46, %33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %66 = "arith.minsi"(%65, %19) : (i32, i32) -> i32
    %67 = "func.call"() <{callee = @triton.language.standard.zeros__Tc512T_cfp32}> : () -> tensor<512xf32>
    %68 = "func.call"(%arg12) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %69 = "arith.index_cast"(%68) : (i32) -> index
    %70 = "scf.for"(%14, %69, %15, %67) ({
    ^bb0(%arg130: index, %arg131: tensor<512xf32>):
      %264 = "arith.index_cast"(%arg130) : (index) -> i32
      %265 = "arith.muli"(%264, %32) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %266 = "arith.index_cast"(%265) : (i32) -> index
      %267 = "arith.muli"(%66, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %268 = "arith.index_cast"(%267) : (i32) -> index
      %269 = "arith.addi"(%266, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %270 = "arith.index_cast"(%arg12) : (i32) -> index
      %271 = "arith.minsi"(%269, %270) : (index, index) -> index
      %272 = "arith.maxsi"(%271, %266) : (index, index) -> index
      %273 = "arith.subi"(%272, %266) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %274 = "arith.addi"(%268, %266) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %275 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%17, %275) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg137: f32, %arg138: f32):
        "linalg.yield"(%arg137) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %276 = "memref.subview"(%arg11, %274, %273) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %277 = "memref.subview"(%275, %273) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%276, %277) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg135: f32, %arg136: f32):
        "linalg.yield"(%arg135) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %278 = "bufferization.to_tensor"(%275) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %279 = "linalg.generic"(%arg131, %278, %arg131) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg132: f32, %arg133: f32, %arg134: f32):
        %280 = "arith.addf"(%arg132, %arg133) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%280) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%279) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %71 = "func.call"(%70) <{callee = @triton.language.standard.sum__fp32S512S_c0_cFalse_cNone}> : (tensor<512xf32>) -> f32
    %72 = "arith.divf"(%71, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %73 = "linalg.fill"(%72, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg128: f32, %arg129: f32):
      "linalg.yield"(%arg128) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %74 = "linalg.generic"(%61, %42, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg125: f32, %arg126: f32, %arg127: i1):
      %263 = "arith.cmpf"(%arg125, %arg126) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%263) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %75 = "linalg.generic"(%74, %73, %64, %73) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg121: i1, %arg122: f32, %arg123: f32, %arg124: f32):
      %262 = "arith.select"(%arg121, %arg122, %arg123) : (i1, f32, f32) -> f32
      "linalg.yield"(%262) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %76 = "arith.addi"(%46, %31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %77 = "arith.minsi"(%76, %19) : (i32, i32) -> i32
    %78 = "func.call"() <{callee = @triton.language.standard.zeros__Tc512T_cfp32}> : () -> tensor<512xf32>
    %79 = "func.call"(%arg12) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %80 = "arith.index_cast"(%79) : (i32) -> index
    %81 = "scf.for"(%14, %80, %15, %78) ({
    ^bb0(%arg112: index, %arg113: tensor<512xf32>):
      %245 = "arith.index_cast"(%arg112) : (index) -> i32
      %246 = "arith.muli"(%245, %32) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %247 = "arith.index_cast"(%246) : (i32) -> index
      %248 = "arith.muli"(%77, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %249 = "arith.index_cast"(%248) : (i32) -> index
      %250 = "arith.addi"(%247, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %251 = "arith.index_cast"(%arg12) : (i32) -> index
      %252 = "arith.minsi"(%250, %251) : (index, index) -> index
      %253 = "arith.maxsi"(%252, %247) : (index, index) -> index
      %254 = "arith.subi"(%253, %247) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %255 = "arith.addi"(%249, %247) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %256 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%17, %256) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg119: f32, %arg120: f32):
        "linalg.yield"(%arg119) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %257 = "memref.subview"(%arg11, %255, %254) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %258 = "memref.subview"(%256, %254) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%257, %258) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg117: f32, %arg118: f32):
        "linalg.yield"(%arg117) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %259 = "bufferization.to_tensor"(%256) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %260 = "linalg.generic"(%arg113, %259, %arg113) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg114: f32, %arg115: f32, %arg116: f32):
        %261 = "arith.addf"(%arg114, %arg115) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%261) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%260) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %82 = "func.call"(%81) <{callee = @triton.language.standard.sum__fp32S512S_c0_cFalse_cNone}> : (tensor<512xf32>) -> f32
    %83 = "arith.divf"(%82, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %84 = "linalg.fill"(%83, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg110: f32, %arg111: f32):
      "linalg.yield"(%arg110) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %85 = "linalg.generic"(%61, %41, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg107: f32, %arg108: f32, %arg109: i1):
      %244 = "arith.cmpf"(%arg107, %arg108) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%244) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %86 = "linalg.generic"(%85, %84, %75, %84) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg103: i1, %arg104: f32, %arg105: f32, %arg106: f32):
      %243 = "arith.select"(%arg103, %arg104, %arg105) : (i1, f32, f32) -> f32
      "linalg.yield"(%243) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %87 = "arith.addi"(%46, %30) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %88 = "arith.minsi"(%87, %19) : (i32, i32) -> i32
    %89 = "func.call"() <{callee = @triton.language.standard.zeros__Tc512T_cfp32}> : () -> tensor<512xf32>
    %90 = "func.call"(%arg12) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %91 = "arith.index_cast"(%90) : (i32) -> index
    %92 = "scf.for"(%14, %91, %15, %89) ({
    ^bb0(%arg94: index, %arg95: tensor<512xf32>):
      %226 = "arith.index_cast"(%arg94) : (index) -> i32
      %227 = "arith.muli"(%226, %32) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %228 = "arith.index_cast"(%227) : (i32) -> index
      %229 = "arith.muli"(%88, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %230 = "arith.index_cast"(%229) : (i32) -> index
      %231 = "arith.addi"(%228, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %232 = "arith.index_cast"(%arg12) : (i32) -> index
      %233 = "arith.minsi"(%231, %232) : (index, index) -> index
      %234 = "arith.maxsi"(%233, %228) : (index, index) -> index
      %235 = "arith.subi"(%234, %228) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %236 = "arith.addi"(%230, %228) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %237 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%17, %237) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg101: f32, %arg102: f32):
        "linalg.yield"(%arg101) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %238 = "memref.subview"(%arg11, %236, %235) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %239 = "memref.subview"(%237, %235) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%238, %239) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg99: f32, %arg100: f32):
        "linalg.yield"(%arg99) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %240 = "bufferization.to_tensor"(%237) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %241 = "linalg.generic"(%arg95, %240, %arg95) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg96: f32, %arg97: f32, %arg98: f32):
        %242 = "arith.addf"(%arg96, %arg97) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%242) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%241) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %93 = "func.call"(%92) <{callee = @triton.language.standard.sum__fp32S512S_c0_cFalse_cNone}> : (tensor<512xf32>) -> f32
    %94 = "arith.divf"(%93, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %95 = "linalg.fill"(%94, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg92: f32, %arg93: f32):
      "linalg.yield"(%arg92) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %96 = "linalg.generic"(%61, %40, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg89: f32, %arg90: f32, %arg91: i1):
      %225 = "arith.cmpf"(%arg89, %arg90) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%225) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %97 = "linalg.generic"(%96, %95, %86, %95) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg85: i1, %arg86: f32, %arg87: f32, %arg88: f32):
      %224 = "arith.select"(%arg85, %arg86, %arg87) : (i1, f32, f32) -> f32
      "linalg.yield"(%224) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %98 = "arith.addi"(%46, %29) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %99 = "arith.minsi"(%98, %19) : (i32, i32) -> i32
    %100 = "func.call"() <{callee = @triton.language.standard.zeros__Tc512T_cfp32}> : () -> tensor<512xf32>
    %101 = "func.call"(%arg12) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %102 = "arith.index_cast"(%101) : (i32) -> index
    %103 = "scf.for"(%14, %102, %15, %100) ({
    ^bb0(%arg76: index, %arg77: tensor<512xf32>):
      %207 = "arith.index_cast"(%arg76) : (index) -> i32
      %208 = "arith.muli"(%207, %32) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %209 = "arith.index_cast"(%208) : (i32) -> index
      %210 = "arith.muli"(%99, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %211 = "arith.index_cast"(%210) : (i32) -> index
      %212 = "arith.addi"(%209, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %213 = "arith.index_cast"(%arg12) : (i32) -> index
      %214 = "arith.minsi"(%212, %213) : (index, index) -> index
      %215 = "arith.maxsi"(%214, %209) : (index, index) -> index
      %216 = "arith.subi"(%215, %209) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %217 = "arith.addi"(%211, %209) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %218 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%17, %218) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg83: f32, %arg84: f32):
        "linalg.yield"(%arg83) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %219 = "memref.subview"(%arg11, %217, %216) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %220 = "memref.subview"(%218, %216) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%219, %220) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg81: f32, %arg82: f32):
        "linalg.yield"(%arg81) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %221 = "bufferization.to_tensor"(%218) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %222 = "linalg.generic"(%arg77, %221, %arg77) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg78: f32, %arg79: f32, %arg80: f32):
        %223 = "arith.addf"(%arg78, %arg79) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%223) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%222) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %104 = "func.call"(%103) <{callee = @triton.language.standard.sum__fp32S512S_c0_cFalse_cNone}> : (tensor<512xf32>) -> f32
    %105 = "arith.divf"(%104, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %106 = "linalg.fill"(%105, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg74: f32, %arg75: f32):
      "linalg.yield"(%arg74) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %107 = "linalg.generic"(%61, %39, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg71: f32, %arg72: f32, %arg73: i1):
      %206 = "arith.cmpf"(%arg71, %arg72) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%206) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %108 = "linalg.generic"(%107, %106, %97, %106) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg67: i1, %arg68: f32, %arg69: f32, %arg70: f32):
      %205 = "arith.select"(%arg67, %arg68, %arg69) : (i1, f32, f32) -> f32
      "linalg.yield"(%205) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %109 = "arith.addi"(%46, %28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %110 = "arith.minsi"(%109, %19) : (i32, i32) -> i32
    %111 = "func.call"() <{callee = @triton.language.standard.zeros__Tc512T_cfp32}> : () -> tensor<512xf32>
    %112 = "func.call"(%arg12) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %113 = "arith.index_cast"(%112) : (i32) -> index
    %114 = "scf.for"(%14, %113, %15, %111) ({
    ^bb0(%arg58: index, %arg59: tensor<512xf32>):
      %188 = "arith.index_cast"(%arg58) : (index) -> i32
      %189 = "arith.muli"(%188, %32) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %190 = "arith.index_cast"(%189) : (i32) -> index
      %191 = "arith.muli"(%110, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %192 = "arith.index_cast"(%191) : (i32) -> index
      %193 = "arith.addi"(%190, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %194 = "arith.index_cast"(%arg12) : (i32) -> index
      %195 = "arith.minsi"(%193, %194) : (index, index) -> index
      %196 = "arith.maxsi"(%195, %190) : (index, index) -> index
      %197 = "arith.subi"(%196, %190) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %198 = "arith.addi"(%192, %190) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %199 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%17, %199) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg65: f32, %arg66: f32):
        "linalg.yield"(%arg65) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %200 = "memref.subview"(%arg11, %198, %197) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %201 = "memref.subview"(%199, %197) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%200, %201) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg63: f32, %arg64: f32):
        "linalg.yield"(%arg63) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %202 = "bufferization.to_tensor"(%199) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %203 = "linalg.generic"(%arg59, %202, %arg59) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg60: f32, %arg61: f32, %arg62: f32):
        %204 = "arith.addf"(%arg60, %arg61) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%204) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%203) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %115 = "func.call"(%114) <{callee = @triton.language.standard.sum__fp32S512S_c0_cFalse_cNone}> : (tensor<512xf32>) -> f32
    %116 = "arith.divf"(%115, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %117 = "linalg.fill"(%116, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg56: f32, %arg57: f32):
      "linalg.yield"(%arg56) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %118 = "linalg.generic"(%61, %38, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg53: f32, %arg54: f32, %arg55: i1):
      %187 = "arith.cmpf"(%arg53, %arg54) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%187) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %119 = "linalg.generic"(%118, %117, %108, %117) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg49: i1, %arg50: f32, %arg51: f32, %arg52: f32):
      %186 = "arith.select"(%arg49, %arg50, %arg51) : (i1, f32, f32) -> f32
      "linalg.yield"(%186) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %120 = "arith.addi"(%46, %27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %121 = "arith.minsi"(%120, %19) : (i32, i32) -> i32
    %122 = "func.call"() <{callee = @triton.language.standard.zeros__Tc512T_cfp32}> : () -> tensor<512xf32>
    %123 = "func.call"(%arg12) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %124 = "arith.index_cast"(%123) : (i32) -> index
    %125 = "scf.for"(%14, %124, %15, %122) ({
    ^bb0(%arg40: index, %arg41: tensor<512xf32>):
      %169 = "arith.index_cast"(%arg40) : (index) -> i32
      %170 = "arith.muli"(%169, %32) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %171 = "arith.index_cast"(%170) : (i32) -> index
      %172 = "arith.muli"(%121, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %173 = "arith.index_cast"(%172) : (i32) -> index
      %174 = "arith.addi"(%171, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %175 = "arith.index_cast"(%arg12) : (i32) -> index
      %176 = "arith.minsi"(%174, %175) : (index, index) -> index
      %177 = "arith.maxsi"(%176, %171) : (index, index) -> index
      %178 = "arith.subi"(%177, %171) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %179 = "arith.addi"(%173, %171) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %180 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%17, %180) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg47: f32, %arg48: f32):
        "linalg.yield"(%arg47) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %181 = "memref.subview"(%arg11, %179, %178) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %182 = "memref.subview"(%180, %178) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%181, %182) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg45: f32, %arg46: f32):
        "linalg.yield"(%arg45) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %183 = "bufferization.to_tensor"(%180) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %184 = "linalg.generic"(%arg41, %183, %arg41) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg42: f32, %arg43: f32, %arg44: f32):
        %185 = "arith.addf"(%arg42, %arg43) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%185) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%184) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %126 = "func.call"(%125) <{callee = @triton.language.standard.sum__fp32S512S_c0_cFalse_cNone}> : (tensor<512xf32>) -> f32
    %127 = "arith.divf"(%126, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %128 = "linalg.fill"(%127, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg38: f32, %arg39: f32):
      "linalg.yield"(%arg38) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %129 = "linalg.generic"(%61, %37, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg35: f32, %arg36: f32, %arg37: i1):
      %168 = "arith.cmpf"(%arg35, %arg36) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%168) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %130 = "linalg.generic"(%129, %128, %119, %128) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg31: i1, %arg32: f32, %arg33: f32, %arg34: f32):
      %167 = "arith.select"(%arg31, %arg32, %arg33) : (i1, f32, f32) -> f32
      "linalg.yield"(%167) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %131 = "arith.addi"(%46, %26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %132 = "arith.minsi"(%131, %19) : (i32, i32) -> i32
    %133 = "func.call"() <{callee = @triton.language.standard.zeros__Tc512T_cfp32}> : () -> tensor<512xf32>
    %134 = "func.call"(%arg12) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %135 = "arith.index_cast"(%134) : (i32) -> index
    %136 = "scf.for"(%14, %135, %15, %133) ({
    ^bb0(%arg22: index, %arg23: tensor<512xf32>):
      %150 = "arith.index_cast"(%arg22) : (index) -> i32
      %151 = "arith.muli"(%150, %32) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %152 = "arith.index_cast"(%151) : (i32) -> index
      %153 = "arith.muli"(%132, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %154 = "arith.index_cast"(%153) : (i32) -> index
      %155 = "arith.addi"(%152, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %156 = "arith.index_cast"(%arg12) : (i32) -> index
      %157 = "arith.minsi"(%155, %156) : (index, index) -> index
      %158 = "arith.maxsi"(%157, %152) : (index, index) -> index
      %159 = "arith.subi"(%158, %152) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %160 = "arith.addi"(%154, %152) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %161 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
      "linalg.fill"(%17, %161) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg29: f32, %arg30: f32):
        "linalg.yield"(%arg29) : (f32) -> ()
      }) : (f32, memref<512xf32>) -> ()
      %162 = "memref.subview"(%arg11, %160, %159) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %163 = "memref.subview"(%161, %159) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%162, %163) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg27: f32, %arg28: f32):
        "linalg.yield"(%arg27) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %164 = "bufferization.to_tensor"(%161) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
      %165 = "linalg.generic"(%arg23, %164, %arg23) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg24: f32, %arg25: f32, %arg26: f32):
        %166 = "arith.addf"(%arg24, %arg25) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%166) : (f32) -> ()
      }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
      "scf.yield"(%165) : (tensor<512xf32>) -> ()
    }) : (index, index, index, tensor<512xf32>) -> tensor<512xf32>
    %137 = "func.call"(%136) <{callee = @triton.language.standard.sum__fp32S512S_c0_cFalse_cNone}> : (tensor<512xf32>) -> f32
    %138 = "arith.divf"(%137, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %139 = "linalg.fill"(%138, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: f32, %arg21: f32):
      "linalg.yield"(%arg20) : (f32) -> ()
    }) : (f32, tensor<8xf32>) -> tensor<8xf32>
    %140 = "linalg.generic"(%61, %36, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg17: f32, %arg18: f32, %arg19: i1):
      %149 = "arith.cmpf"(%arg17, %arg18) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%149) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %141 = "linalg.generic"(%140, %139, %130, %139) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg13: i1, %arg14: f32, %arg15: f32, %arg16: f32):
      %148 = "arith.select"(%arg13, %arg14, %arg15) : (i1, f32, f32) -> f32
      "linalg.yield"(%148) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %142 = "arith.addi"(%47, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %143 = "arith.minsi"(%142, %15) : (index, index) -> index
    %144 = "arith.maxsi"(%143, %47) : (index, index) -> index
    %145 = "arith.subi"(%144, %47) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %146 = "tensor.extract_slice"(%141, %145) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<8xf32>, index) -> tensor<?xf32>
    %147 = "memref.subview"(%arg10, %47, %145) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%146, %147) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
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

