#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi64>, i32, memref<?xf32>, i32, i32, i32, i32, memref<?xf32>, i32, memref<?xi64>, memref<?xi64>, memref<?xi64>, memref<?xf32>, i32) -> (), sym_name = "_gumbel_sample_kernel"}> ({
  ^bb0(%arg266: memref<?xi64>, %arg267: i32, %arg268: memref<?xf32>, %arg269: i32, %arg270: i32, %arg271: i32, %arg272: i32, %arg273: memref<?xf32>, %arg274: i32, %arg275: memref<?xi64>, %arg276: memref<?xi64>, %arg277: memref<?xi64>, %arg278: memref<?xf32>, %arg279: i32):
    %253 = "arith.constant"() <{value = 1024 : i32}> : () -> i32
    %254 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %255 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %256 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %257 = "arith.index_cast"(%256) : (index) -> i32
    %258 = "arith.extsi"(%257) : (i32) -> i64
    %259 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %260 = "arith.index_cast"(%259) : (index) -> i32
    %261 = "arith.muli"(%260, %253) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %262 = "arith.index_cast"(%261) : (i32) -> index
    %263 = "tensor.empty"() : () -> tensor<1024xi32>
    %264 = "linalg.generic"(%263) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg298: i32):
      %302 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %303 = "arith.index_cast"(%302) : (index) -> i32
      "linalg.yield"(%303) : (i32) -> ()
    }) : (tensor<1024xi32>) -> tensor<1024xi32>
    %265 = "linalg.fill"(%261, %263) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg296: i32, %arg297: i32):
      "linalg.yield"(%arg296) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %266 = "linalg.generic"(%265, %264, %265) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg293: i32, %arg294: i32, %arg295: i32):
      %301 = "arith.addi"(%arg293, %arg294) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%301) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %267 = "linalg.fill"(%arg279, %263) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg291: i32, %arg292: i32):
      "linalg.yield"(%arg291) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %268 = "tensor.empty"() : () -> tensor<1024xi1>
    %269 = "linalg.generic"(%266, %267, %268) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg288: i32, %arg289: i32, %arg290: i1):
      %300 = "arith.cmpi"(%arg288, %arg289) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%300) : (i1) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi1>) -> tensor<1024xi1>
    %270 = "arith.extsi"(%arg274) : (i32) -> i64
    %271 = "arith.muli"(%258, %270) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %272 = "arith.index_cast"(%271) : (i64) -> index
    %273 = "arith.addi"(%262, %254) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %274 = "arith.index_cast"(%arg279) : (i32) -> index
    %275 = "arith.minsi"(%273, %274) : (index, index) -> index
    %276 = "arith.maxsi"(%275, %262) : (index, index) -> index
    %277 = "arith.subi"(%276, %262) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %278 = "arith.addi"(%272, %262) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %279 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
    "linalg.fill"(%255, %279) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg286: f32, %arg287: f32):
      "linalg.yield"(%arg286) : (f32) -> ()
    }) : (f32, memref<1024xf32>) -> ()
    %280 = "memref.subview"(%arg273, %278, %277) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %281 = "memref.subview"(%279, %277) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%280, %281) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg284: f32, %arg285: f32):
      "linalg.yield"(%arg284) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %282 = "bufferization.to_tensor"(%279) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
    %283:2 = "func.call"(%282, %266, %269, %258, %arg275, %arg278, %arg276, %arg277) <{callee = @vllm.v1.worker.gpu.sample.gumbel.gumbel_block_argmax__fp32S1024S_i32S1024S_u1S1024S_i64_Pi64_Pfp32_Pi64_Pi64_cNone_i32_i32_cNone_cNone_i32_i32_cFalse_cFalse_cFalse_cFalse}> : (tensor<1024xf32>, tensor<1024xi32>, tensor<1024xi1>, i64, memref<?xi64>, memref<?xf32>, memref<?xi64>, memref<?xi64>) -> (f32, i32)
    %284 = "arith.addi"(%261, %283#1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %285 = "arith.extsi"(%arg267) : (i32) -> i64
    %286 = "arith.muli"(%258, %285) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %287 = "arith.extsi"(%284) : (i32) -> i64
    %288 = "arith.index_cast"(%286) : (i64) -> index
    %289 = "tensor.empty"() : () -> tensor<1xi64>
    %290 = "linalg.fill"(%287, %289) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg282: i64, %arg283: i64):
      "linalg.yield"(%arg282) : (i64) -> ()
    }) : (i64, tensor<1xi64>) -> tensor<1xi64>
    %291 = "arith.addi"(%288, %259) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %292 = "memref.subview"(%arg266, %291) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi64>, index) -> memref<1xi64, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%290, %292) <{writable}> : (tensor<1xi64>, memref<1xi64, strided<[1], offset: ?>>) -> ()
    %293 = "arith.extsi"(%arg269) : (i32) -> i64
    %294 = "arith.muli"(%258, %293) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %295 = "arith.index_cast"(%294) : (i64) -> index
    %296 = "tensor.empty"() : () -> tensor<1xf32>
    %297 = "linalg.fill"(%283#0, %296) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg280: f32, %arg281: f32):
      "linalg.yield"(%arg280) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %298 = "arith.addi"(%295, %259) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %299 = "memref.subview"(%arg268, %298) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%297, %299) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1024xf32>, tensor<1024xi32>, tensor<1024xi1>, i64, memref<?xi64>, memref<?xf32>, memref<?xi64>, memref<?xi64>) -> (f32, i32), sym_name = "vllm.v1.worker.gpu.sample.gumbel.gumbel_block_argmax__fp32S1024S_i32S1024S_u1S1024S_i64_Pi64_Pfp32_Pi64_Pi64_cNone_i32_i32_cNone_cNone_i32_i32_cFalse_cFalse_cFalse_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg258: tensor<1024xf32>, %arg259: tensor<1024xi32>, %arg260: tensor<1024xi1>, %arg261: i64, %arg262: memref<?xi64>, %arg263: memref<?xf32>, %arg264: memref<?xi64>, %arg265: memref<?xi64>):
    %237 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %238 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %239 = "builtin.unrealized_conversion_cast"(%arg265) : (memref<?xi64>) -> !tt.ptr<i64>
    %240 = "builtin.unrealized_conversion_cast"(%arg264) : (memref<?xi64>) -> !tt.ptr<i64>
    %241 = "builtin.unrealized_conversion_cast"(%arg263) : (memref<?xf32>) -> !tt.ptr<f32>
    %242 = "builtin.unrealized_conversion_cast"(%arg262) : (memref<?xi64>) -> !tt.ptr<i64>
    %243 = "tt.addptr"(%242, %arg261) : (!tt.ptr<i64>, i64) -> !tt.ptr<i64>
    %244 = "tt.load"(%243) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i64>) -> i64
    %245 = "arith.cmpi"(%244, %238) <{predicate = 5 : i64}> : (i64, i64) -> i1
    %246 = "tt.addptr"(%241, %244) : (!tt.ptr<f32>, i64) -> !tt.ptr<f32>
    %247 = "tt.load"(%246, %245, %237) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (!tt.ptr<f32>, i1, f32) -> f32
    %248 = "tt.addptr"(%240, %244) : (!tt.ptr<i64>, i64) -> !tt.ptr<i64>
    %249 = "tt.load"(%248, %245, %238) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (!tt.ptr<i64>, i1, i64) -> i64
    %250 = "tt.addptr"(%239, %arg261) : (!tt.ptr<i64>, i64) -> !tt.ptr<i64>
    %251 = "tt.load"(%250) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i64>) -> i64
    %252:2 = "func.call"(%arg258, %arg259, %arg260, %249, %251, %247) <{callee = @vllm.v1.worker.gpu.sample.gumbel.gumbel_noised_argmax__fp32S1024S_i32S1024S_u1S1024S_i64_i64_fp32_cFalse_cFalse_cFalse}> : (tensor<1024xf32>, tensor<1024xi32>, tensor<1024xi1>, i64, i64, f32) -> (f32, i32)
    "func.return"(%252#0, %252#1) : (f32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1024xf32>, tensor<1024xi32>, tensor<1024xi1>, i64, i64, f32) -> (f32, i32), sym_name = "vllm.v1.worker.gpu.sample.gumbel.gumbel_noised_argmax__fp32S1024S_i32S1024S_u1S1024S_i64_i64_fp32_cFalse_cFalse_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg233: tensor<1024xf32>, %arg234: tensor<1024xi32>, %arg235: tensor<1024xi1>, %arg236: i64, %arg237: i64, %arg238: f32):
    %217 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %218 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %219 = "tensor.empty"() : () -> tensor<1024xf32>
    %220 = "linalg.fill"(%218, %219) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg256: f32, %arg257: f32):
      "linalg.yield"(%arg256) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %221 = "linalg.fill"(%217, %219) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg254: f32, %arg255: f32):
      "linalg.yield"(%arg254) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %222 = "arith.cmpf"(%arg238, %217) <{fastmath = #arith.fastmath<none>, predicate = 13 : i64}> : (f32, f32) -> i1
    %223 = "scf.if"(%222) ({
      %225 = "func.call"(%arg236, %arg237, %arg234) <{callee = @vllm.v1.worker.gpu.sample.gumbel.murmur3_uniform32__i64_i64_i32S1024S}> : (i64, i64, tensor<1024xi32>) -> tensor<1024xf32>
      %226 = "func.call"(%225) <{callee = @vllm.v1.worker.gpu.sample.gumbel._log1p_neg_stable__fp32S1024S}> : (tensor<1024xf32>) -> tensor<1024xf32>
      %227 = "linalg.generic"(%221, %226, %221) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg251: f32, %arg252: f32, %arg253: f32):
        %236 = "arith.subf"(%arg251, %arg252) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%236) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %228 = "linalg.generic"(%227, %227) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg249: f32, %arg250: f32):
        %235 = "math.log"(%arg249) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%235) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %229 = "linalg.generic"(%221, %228, %221) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg246: f32, %arg247: f32, %arg248: f32):
        %234 = "arith.subf"(%arg246, %arg247) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%234) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %230 = "linalg.generic"(%arg233, %229, %arg233) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg243: f32, %arg244: f32, %arg245: f32):
        %233 = "arith.addf"(%arg243, %arg244) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%233) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %231 = "linalg.generic"(%arg235, %230, %220, %230) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg239: i1, %arg240: f32, %arg241: f32, %arg242: f32):
        %232 = "arith.select"(%arg239, %arg240, %arg241) : (i1, f32, f32) -> f32
        "linalg.yield"(%232) : (f32) -> ()
      }) : (tensor<1024xi1>, tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      "scf.yield"(%231) : (tensor<1024xf32>) -> ()
    }, {
      "scf.yield"(%arg233) : (tensor<1024xf32>) -> ()
    }) : (i1) -> tensor<1024xf32>
    %224:2 = "func.call"(%223) <{callee = @triton.language.standard.max__fp32S1024S_c0_cTrue_cTrue_cFalse}> : (tensor<1024xf32>) -> (f32, i32)
    "func.return"(%224#0, %224#1) : (f32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64, tensor<1024xi32>) -> tensor<1024xf32>, sym_name = "vllm.v1.worker.gpu.sample.gumbel.murmur3_uniform32__i64_i64_i32S1024S", sym_visibility = "private"}> ({
  ^bb0(%arg198: i64, %arg199: i64, %arg200: tensor<1024xi32>):
    %188 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %189 = "arith.constant"() <{value = 65535 : i32}> : () -> i32
    %190 = "arith.constant"() <{value = 1.52587891E-5 : f32}> : () -> f32
    %191 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %192 = "arith.constant"() <{value = 2.32830644E-10 : f32}> : () -> f32
    %193 = "tensor.empty"() : () -> tensor<1024xf32>
    %194 = "linalg.fill"(%192, %193) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg231: f32, %arg232: f32):
      "linalg.yield"(%arg231) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %195 = "linalg.fill"(%191, %193) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg229: f32, %arg230: f32):
      "linalg.yield"(%arg229) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %196 = "linalg.fill"(%190, %193) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg227: f32, %arg228: f32):
      "linalg.yield"(%arg227) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %197 = "tensor.empty"() : () -> tensor<1024xi32>
    %198 = "linalg.fill"(%189, %197) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg225: i32, %arg226: i32):
      "linalg.yield"(%arg225) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %199 = "linalg.fill"(%188, %197) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg223: i32, %arg224: i32):
      "linalg.yield"(%arg223) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %200 = "func.call"(%arg198, %arg199, %arg200) <{callee = @vllm.v1.worker.gpu.sample.gumbel.murmur3_hash32__i64_i64_i32S1024S_c0}> : (i64, i64, tensor<1024xi32>) -> tensor<1024xi32>
    %201 = "linalg.generic"(%200, %199, %200) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg220: i32, %arg221: i32, %arg222: i32):
      %216 = "arith.shrui"(%arg220, %arg221) : (i32, i32) -> i32
      "linalg.yield"(%216) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %202 = "linalg.generic"(%200, %198, %200) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg217: i32, %arg218: i32, %arg219: i32):
      %215 = "arith.andi"(%arg217, %arg218) : (i32, i32) -> i32
      "linalg.yield"(%215) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %203 = "linalg.generic"(%201, %193) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg215: i32, %arg216: f32):
      %214 = "arith.sitofp"(%arg215) : (i32) -> f32
      "linalg.yield"(%214) : (f32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xf32>) -> tensor<1024xf32>
    %204 = "linalg.generic"(%203, %196, %203) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg212: f32, %arg213: f32, %arg214: f32):
      %213 = "arith.mulf"(%arg212, %arg213) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%213) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %205 = "linalg.generic"(%202, %193) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg210: i32, %arg211: f32):
      %212 = "arith.sitofp"(%arg210) : (i32) -> f32
      "linalg.yield"(%212) : (f32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xf32>) -> tensor<1024xf32>
    %206 = "linalg.generic"(%205, %195, %205) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg207: f32, %arg208: f32, %arg209: f32):
      %211 = "arith.addf"(%arg207, %arg208) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%211) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %207 = "linalg.generic"(%206, %194, %206) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg204: f32, %arg205: f32, %arg206: f32):
      %210 = "arith.mulf"(%arg204, %arg205) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%210) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %208 = "linalg.generic"(%204, %207, %204) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg201: f32, %arg202: f32, %arg203: f32):
      %209 = "arith.addf"(%arg201, %arg202) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%209) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    "func.return"(%208) : (tensor<1024xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64, tensor<1024xi32>) -> tensor<1024xi32>, sym_name = "vllm.v1.worker.gpu.sample.gumbel.murmur3_hash32__i64_i64_i32S1024S_c0", sym_visibility = "private"}> ({
  ^bb0(%arg190: i64, %arg191: i64, %arg192: tensor<1024xi32>):
    %168 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %169 = "arith.constant"() <{value = 4294967295 : i64}> : () -> i64
    %170 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %171 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %172 = "tensor.empty"() : () -> tensor<1024xi32>
    %173 = "linalg.fill"(%171, %172) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg196: i32, %arg197: i32):
      "linalg.yield"(%arg196) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %174 = "arith.andi"(%arg190, %169) : (i64, i64) -> i64
    %175 = "arith.trunci"(%174) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %176 = "func.call"(%168, %175) <{callee = @vllm.v1.worker.gpu.sample.gumbel._murmur3_mix__u32_u32}> : (i32, i32) -> i32
    %177 = "arith.shrsi"(%arg190, %170) : (i64, i64) -> i64
    %178 = "arith.andi"(%177, %169) : (i64, i64) -> i64
    %179 = "arith.trunci"(%178) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %180 = "func.call"(%176, %179) <{callee = @vllm.v1.worker.gpu.sample.gumbel._murmur3_mix__u32_u32}> : (i32, i32) -> i32
    %181 = "arith.andi"(%arg191, %169) : (i64, i64) -> i64
    %182 = "arith.trunci"(%181) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %183 = "func.call"(%180, %182) <{callee = @vllm.v1.worker.gpu.sample.gumbel._murmur3_mix__u32_u32}> : (i32, i32) -> i32
    %184 = "func.call"(%183, %arg192) <{callee = @vllm.v1.worker.gpu.sample.gumbel._murmur3_mix__u32_u32S1024S}> : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %185 = "linalg.generic"(%184, %173, %184) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg193: i32, %arg194: i32, %arg195: i32):
      %187 = "arith.xori"(%arg193, %arg194) : (i32, i32) -> i32
      "linalg.yield"(%187) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %186 = "func.call"(%185) <{callee = @vllm.v1.worker.gpu.sample.gumbel._murmur3_fmix32__u32S1024S}> : (tensor<1024xi32>) -> tensor<1024xi32>
    "func.return"(%186) : (tensor<1024xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "vllm.v1.worker.gpu.sample.gumbel._murmur3_mix__u32_u32", sym_visibility = "private"}> ({
  ^bb0(%arg188: i32, %arg189: i32):
    %157 = "arith.constant"() <{value = -430675100 : i32}> : () -> i32
    %158 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %159 = "arith.constant"() <{value = 461845907 : i32}> : () -> i32
    %160 = "arith.constant"() <{value = -862048943 : i32}> : () -> i32
    %161 = "arith.muli"(%arg189, %160) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %162 = "func.call"(%161) <{callee = @vllm.v1.worker.gpu.sample.gumbel._murmur3_rotl32__u32_c15}> : (i32) -> i32
    %163 = "arith.muli"(%162, %159) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %164 = "arith.xori"(%arg188, %163) : (i32, i32) -> i32
    %165 = "func.call"(%164) <{callee = @vllm.v1.worker.gpu.sample.gumbel._murmur3_rotl32__u32_c13}> : (i32) -> i32
    %166 = "arith.muli"(%165, %158) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %167 = "arith.addi"(%166, %157) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%167) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "vllm.v1.worker.gpu.sample.gumbel._murmur3_rotl32__u32_c15", sym_visibility = "private"}> ({
  ^bb0(%arg187: i32):
    %152 = "arith.constant"() <{value = 17 : i32}> : () -> i32
    %153 = "arith.constant"() <{value = 15 : i32}> : () -> i32
    %154 = "arith.shli"(%arg187, %153) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %155 = "arith.shrui"(%arg187, %152) : (i32, i32) -> i32
    %156 = "arith.ori"(%154, %155) : (i32, i32) -> i32
    "func.return"(%156) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "vllm.v1.worker.gpu.sample.gumbel._murmur3_rotl32__u32_c13", sym_visibility = "private"}> ({
  ^bb0(%arg186: i32):
    %147 = "arith.constant"() <{value = 19 : i32}> : () -> i32
    %148 = "arith.constant"() <{value = 13 : i32}> : () -> i32
    %149 = "arith.shli"(%arg186, %148) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %150 = "arith.shrui"(%arg186, %147) : (i32, i32) -> i32
    %151 = "arith.ori"(%149, %150) : (i32, i32) -> i32
    "func.return"(%151) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, tensor<1024xi32>) -> tensor<1024xi32>, sym_name = "vllm.v1.worker.gpu.sample.gumbel._murmur3_mix__u32_u32S1024S", sym_visibility = "private"}> ({
  ^bb0(%arg159: i32, %arg160: tensor<1024xi32>):
    %125 = "arith.constant"() <{value = -862048943 : i32}> : () -> i32
    %126 = "arith.constant"() <{value = 461845907 : i32}> : () -> i32
    %127 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %128 = "arith.constant"() <{value = -430675100 : i32}> : () -> i32
    %129 = "tensor.empty"() : () -> tensor<1024xi32>
    %130 = "linalg.fill"(%128, %129) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg184: i32, %arg185: i32):
      "linalg.yield"(%arg184) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %131 = "linalg.fill"(%127, %129) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg182: i32, %arg183: i32):
      "linalg.yield"(%arg182) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %132 = "linalg.fill"(%126, %129) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg180: i32, %arg181: i32):
      "linalg.yield"(%arg180) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %133 = "linalg.fill"(%125, %129) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg178: i32, %arg179: i32):
      "linalg.yield"(%arg178) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %134 = "linalg.generic"(%arg160, %133, %arg160) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg175: i32, %arg176: i32, %arg177: i32):
      %146 = "arith.muli"(%arg175, %arg176) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%146) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %135 = "func.call"(%134) <{callee = @vllm.v1.worker.gpu.sample.gumbel._murmur3_rotl32__u32S1024S_c15}> : (tensor<1024xi32>) -> tensor<1024xi32>
    %136 = "linalg.generic"(%135, %132, %135) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg172: i32, %arg173: i32, %arg174: i32):
      %145 = "arith.muli"(%arg172, %arg173) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%145) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %137 = "linalg.fill"(%arg159, %129) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg170: i32, %arg171: i32):
      "linalg.yield"(%arg170) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %138 = "linalg.generic"(%137, %136, %137) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg167: i32, %arg168: i32, %arg169: i32):
      %144 = "arith.xori"(%arg167, %arg168) : (i32, i32) -> i32
      "linalg.yield"(%144) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %139 = "func.call"(%138) <{callee = @vllm.v1.worker.gpu.sample.gumbel._murmur3_rotl32__u32S1024S_c13}> : (tensor<1024xi32>) -> tensor<1024xi32>
    %140 = "linalg.generic"(%139, %131, %139) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg164: i32, %arg165: i32, %arg166: i32):
      %143 = "arith.muli"(%arg164, %arg165) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%143) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %141 = "linalg.generic"(%140, %130, %140) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg161: i32, %arg162: i32, %arg163: i32):
      %142 = "arith.addi"(%arg161, %arg162) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%142) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    "func.return"(%141) : (tensor<1024xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1024xi32>) -> tensor<1024xi32>, sym_name = "vllm.v1.worker.gpu.sample.gumbel._murmur3_rotl32__u32S1024S_c15", sym_visibility = "private"}> ({
  ^bb0(%arg145: tensor<1024xi32>):
    %114 = "arith.constant"() <{value = 15 : i32}> : () -> i32
    %115 = "arith.constant"() <{value = 17 : i32}> : () -> i32
    %116 = "tensor.empty"() : () -> tensor<1024xi32>
    %117 = "linalg.fill"(%115, %116) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg157: i32, %arg158: i32):
      "linalg.yield"(%arg157) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %118 = "linalg.fill"(%114, %116) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg155: i32, %arg156: i32):
      "linalg.yield"(%arg155) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %119 = "linalg.generic"(%arg145, %118, %arg145) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg152: i32, %arg153: i32, %arg154: i32):
      %124 = "arith.shli"(%arg152, %arg153) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%124) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %120 = "linalg.generic"(%arg145, %117, %arg145) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg149: i32, %arg150: i32, %arg151: i32):
      %123 = "arith.shrui"(%arg149, %arg150) : (i32, i32) -> i32
      "linalg.yield"(%123) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %121 = "linalg.generic"(%119, %120, %119) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg146: i32, %arg147: i32, %arg148: i32):
      %122 = "arith.ori"(%arg146, %arg147) : (i32, i32) -> i32
      "linalg.yield"(%122) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    "func.return"(%121) : (tensor<1024xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1024xi32>) -> tensor<1024xi32>, sym_name = "vllm.v1.worker.gpu.sample.gumbel._murmur3_rotl32__u32S1024S_c13", sym_visibility = "private"}> ({
  ^bb0(%arg131: tensor<1024xi32>):
    %103 = "arith.constant"() <{value = 13 : i32}> : () -> i32
    %104 = "arith.constant"() <{value = 19 : i32}> : () -> i32
    %105 = "tensor.empty"() : () -> tensor<1024xi32>
    %106 = "linalg.fill"(%104, %105) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg143: i32, %arg144: i32):
      "linalg.yield"(%arg143) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %107 = "linalg.fill"(%103, %105) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg141: i32, %arg142: i32):
      "linalg.yield"(%arg141) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %108 = "linalg.generic"(%arg131, %107, %arg131) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg138: i32, %arg139: i32, %arg140: i32):
      %113 = "arith.shli"(%arg138, %arg139) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%113) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %109 = "linalg.generic"(%arg131, %106, %arg131) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg135: i32, %arg136: i32, %arg137: i32):
      %112 = "arith.shrui"(%arg135, %arg136) : (i32, i32) -> i32
      "linalg.yield"(%112) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %110 = "linalg.generic"(%108, %109, %108) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg132: i32, %arg133: i32, %arg134: i32):
      %111 = "arith.ori"(%arg132, %arg133) : (i32, i32) -> i32
      "linalg.yield"(%111) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    "func.return"(%110) : (tensor<1024xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1024xi32>) -> tensor<1024xi32>, sym_name = "vllm.v1.worker.gpu.sample.gumbel._murmur3_fmix32__u32S1024S", sym_visibility = "private"}> ({
  ^bb0(%arg98: tensor<1024xi32>):
    %78 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %79 = "arith.constant"() <{value = -2048144789 : i32}> : () -> i32
    %80 = "arith.constant"() <{value = 13 : i32}> : () -> i32
    %81 = "arith.constant"() <{value = -1028477387 : i32}> : () -> i32
    %82 = "tensor.empty"() : () -> tensor<1024xi32>
    %83 = "linalg.fill"(%81, %82) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg129: i32, %arg130: i32):
      "linalg.yield"(%arg129) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %84 = "linalg.fill"(%80, %82) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg127: i32, %arg128: i32):
      "linalg.yield"(%arg127) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %85 = "linalg.fill"(%79, %82) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg125: i32, %arg126: i32):
      "linalg.yield"(%arg125) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %86 = "linalg.fill"(%78, %82) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg123: i32, %arg124: i32):
      "linalg.yield"(%arg123) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %87 = "linalg.generic"(%arg98, %86, %arg98) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg120: i32, %arg121: i32, %arg122: i32):
      %102 = "arith.shrui"(%arg120, %arg121) : (i32, i32) -> i32
      "linalg.yield"(%102) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %88 = "linalg.generic"(%arg98, %87, %arg98) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg117: i32, %arg118: i32, %arg119: i32):
      %101 = "arith.xori"(%arg117, %arg118) : (i32, i32) -> i32
      "linalg.yield"(%101) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %89 = "linalg.generic"(%88, %85, %88) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg114: i32, %arg115: i32, %arg116: i32):
      %100 = "arith.muli"(%arg114, %arg115) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%100) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %90 = "linalg.generic"(%89, %84, %89) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg111: i32, %arg112: i32, %arg113: i32):
      %99 = "arith.shrui"(%arg111, %arg112) : (i32, i32) -> i32
      "linalg.yield"(%99) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %91 = "linalg.generic"(%89, %90, %89) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg108: i32, %arg109: i32, %arg110: i32):
      %98 = "arith.xori"(%arg108, %arg109) : (i32, i32) -> i32
      "linalg.yield"(%98) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %92 = "linalg.generic"(%91, %83, %91) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg105: i32, %arg106: i32, %arg107: i32):
      %97 = "arith.muli"(%arg105, %arg106) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%97) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %93 = "linalg.generic"(%92, %86, %92) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg102: i32, %arg103: i32, %arg104: i32):
      %96 = "arith.shrui"(%arg102, %arg103) : (i32, i32) -> i32
      "linalg.yield"(%96) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %94 = "linalg.generic"(%92, %93, %92) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg99: i32, %arg100: i32, %arg101: i32):
      %95 = "arith.xori"(%arg99, %arg100) : (i32, i32) -> i32
      "linalg.yield"(%95) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    "func.return"(%94) : (tensor<1024xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1024xf32>) -> tensor<1024xf32>, sym_name = "vllm.v1.worker.gpu.sample.gumbel._log1p_neg_stable__fp32S1024S", sym_visibility = "private"}> ({
  ^bb0(%arg14: tensor<1024xf32>):
    %14 = "arith.constant"() <{value = 1.250000e-01 : f32}> : () -> f32
    %15 = "arith.constant"() <{value = 0.142857149 : f32}> : () -> f32
    %16 = "arith.constant"() <{value = 0.166666672 : f32}> : () -> f32
    %17 = "arith.constant"() <{value = 2.000000e-01 : f32}> : () -> f32
    %18 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
    %19 = "arith.constant"() <{value = 0.333333343 : f32}> : () -> f32
    %20 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %21 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %22 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %23 = "arith.constant"() <{value = 5.96046448E-8 : f32}> : () -> f32
    %24 = "tensor.empty"() : () -> tensor<1024xf32>
    %25 = "linalg.fill"(%23, %24) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg96: f32, %arg97: f32):
      "linalg.yield"(%arg96) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %26 = "linalg.fill"(%22, %24) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg94: f32, %arg95: f32):
      "linalg.yield"(%arg94) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %27 = "linalg.fill"(%21, %24) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg92: f32, %arg93: f32):
      "linalg.yield"(%arg92) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %28 = "linalg.fill"(%20, %24) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg90: f32, %arg91: f32):
      "linalg.yield"(%arg90) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %29 = "linalg.fill"(%19, %24) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg88: f32, %arg89: f32):
      "linalg.yield"(%arg88) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %30 = "linalg.fill"(%18, %24) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg86: f32, %arg87: f32):
      "linalg.yield"(%arg86) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %31 = "linalg.fill"(%17, %24) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg84: f32, %arg85: f32):
      "linalg.yield"(%arg84) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %32 = "linalg.fill"(%16, %24) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg82: f32, %arg83: f32):
      "linalg.yield"(%arg82) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %33 = "linalg.fill"(%15, %24) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg80: f32, %arg81: f32):
      "linalg.yield"(%arg80) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %34 = "linalg.fill"(%14, %24) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg78: f32, %arg79: f32):
      "linalg.yield"(%arg78) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %35 = "linalg.generic"(%arg14, %34, %arg14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg75: f32, %arg76: f32, %arg77: f32):
      %77 = "arith.mulf"(%arg75, %arg76) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%77) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %36 = "linalg.generic"(%35, %33, %35) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg72: f32, %arg73: f32, %arg74: f32):
      %76 = "arith.addf"(%arg72, %arg73) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%76) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %37 = "linalg.generic"(%arg14, %36, %arg14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg69: f32, %arg70: f32, %arg71: f32):
      %75 = "arith.mulf"(%arg69, %arg70) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%75) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %38 = "linalg.generic"(%37, %32, %37) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg66: f32, %arg67: f32, %arg68: f32):
      %74 = "arith.addf"(%arg66, %arg67) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%74) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %39 = "linalg.generic"(%arg14, %38, %arg14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg63: f32, %arg64: f32, %arg65: f32):
      %73 = "arith.mulf"(%arg63, %arg64) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%73) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %40 = "linalg.generic"(%39, %31, %39) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg60: f32, %arg61: f32, %arg62: f32):
      %72 = "arith.addf"(%arg60, %arg61) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%72) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %41 = "linalg.generic"(%arg14, %40, %arg14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg57: f32, %arg58: f32, %arg59: f32):
      %71 = "arith.mulf"(%arg57, %arg58) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%71) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %42 = "linalg.generic"(%41, %30, %41) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg54: f32, %arg55: f32, %arg56: f32):
      %70 = "arith.addf"(%arg54, %arg55) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%70) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %43 = "linalg.generic"(%arg14, %42, %arg14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg51: f32, %arg52: f32, %arg53: f32):
      %69 = "arith.mulf"(%arg51, %arg52) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%69) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %44 = "linalg.generic"(%43, %29, %43) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg48: f32, %arg49: f32, %arg50: f32):
      %68 = "arith.addf"(%arg48, %arg49) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%68) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %45 = "linalg.generic"(%arg14, %44, %arg14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg45: f32, %arg46: f32, %arg47: f32):
      %67 = "arith.mulf"(%arg45, %arg46) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%67) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %46 = "linalg.generic"(%45, %28, %45) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg42: f32, %arg43: f32, %arg44: f32):
      %66 = "arith.addf"(%arg42, %arg43) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%66) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %47 = "linalg.generic"(%arg14, %46, %arg14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg39: f32, %arg40: f32, %arg41: f32):
      %65 = "arith.mulf"(%arg39, %arg40) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%65) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %48 = "linalg.generic"(%47, %27, %47) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg36: f32, %arg37: f32, %arg38: f32):
      %64 = "arith.addf"(%arg36, %arg37) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%64) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %49 = "linalg.generic"(%26, %arg14, %26) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg33: f32, %arg34: f32, %arg35: f32):
      %63 = "arith.subf"(%arg33, %arg34) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%63) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %50 = "linalg.generic"(%49, %48, %49) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg30: f32, %arg31: f32, %arg32: f32):
      %62 = "arith.mulf"(%arg30, %arg31) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%62) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %51 = "linalg.generic"(%27, %arg14, %27) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg27: f32, %arg28: f32, %arg29: f32):
      %61 = "arith.subf"(%arg27, %arg28) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%61) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %52 = "linalg.generic"(%51, %25, %51) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg24: f32, %arg25: f32, %arg26: f32):
      %60 = "arith.maxnumf"(%arg24, %arg25) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%60) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %53 = "linalg.generic"(%52, %52) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg22: f32, %arg23: f32):
      %59 = "math.log"(%arg22) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%59) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %54 = "tensor.empty"() : () -> tensor<1024xi1>
    %55 = "linalg.generic"(%arg14, %30, %54) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32, %arg21: i1):
      %58 = "arith.cmpf"(%arg19, %arg20) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%58) : (i1) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xi1>) -> tensor<1024xi1>
    %56 = "linalg.generic"(%55, %50, %53, %50) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg15: i1, %arg16: f32, %arg17: f32, %arg18: f32):
      %57 = "arith.select"(%arg15, %arg16, %arg17) : (i1, f32, f32) -> f32
      "linalg.yield"(%57) : (f32) -> ()
    }) : (tensor<1024xi1>, tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    "func.return"(%56) : (tensor<1024xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1024xf32>) -> (f32, i32), sym_name = "triton.language.standard.max__fp32S1024S_c0_cTrue_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg8: tensor<1024xf32>):
    %8 = "tensor.empty"() : () -> tensor<1024xi32>
    %9 = "linalg.generic"(%8) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg13: i32):
      %12 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %13 = "arith.index_cast"(%12) : (index) -> i32
      "linalg.yield"(%13) : (i32) -> ()
    }) : (tensor<1024xi32>) -> tensor<1024xi32>
    %10:2 = "tt.reduce"(%arg8, %9) <{axis = 0 : i32}> ({
    ^bb0(%arg9: f32, %arg10: i32, %arg11: f32, %arg12: i32):
      %11:2 = "func.call"(%arg9, %arg10, %arg11, %arg12) <{callee = @triton.language.standard._argmax_combine_tie_break_left__fp32_i32_fp32_i32}> : (f32, i32, f32, i32) -> (f32, i32)
      "tt.reduce.return"(%11#0, %11#1) : (f32, i32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xi32>) -> (f32, i32)
    "func.return"(%10#0, %10#1) : (f32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32, f32, i32) -> (f32, i32), sym_name = "triton.language.standard._argmax_combine_tie_break_left__fp32_i32_fp32_i32", sym_visibility = "private"}> ({
  ^bb0(%arg4: f32, %arg5: i32, %arg6: f32, %arg7: i32):
    %7:2 = "func.call"(%arg4, %arg5, %arg6, %arg7) <{callee = @triton.language.standard._argmax_combine__fp32_i32_fp32_i32_cTrue}> : (f32, i32, f32, i32) -> (f32, i32)
    "func.return"(%7#0, %7#1) : (f32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32, f32, i32) -> (f32, i32), sym_name = "triton.language.standard._argmax_combine__fp32_i32_fp32_i32_cTrue", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: i32, %arg2: f32, %arg3: i32):
    %0 = "arith.cmpf"(%arg0, %arg2) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %1 = "arith.cmpi"(%arg1, %arg3) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %2 = "arith.andi"(%0, %1) : (i1, i1) -> i1
    %3 = "arith.cmpf"(%arg0, %arg2) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
    %4 = "arith.ori"(%3, %2) : (i1, i1) -> i1
    %5 = "arith.select"(%4, %arg0, %arg2) : (i1, f32, f32) -> f32
    %6 = "arith.select"(%4, %arg1, %arg3) : (i1, i32, i32) -> i32
    "func.return"(%5, %6) : (f32, i32) -> ()
  }) : () -> ()
}) : () -> ()

