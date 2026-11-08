#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1) -> (d0, 0)>
#map3 = affine_map<(d0, d1) -> (0, d1)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map6 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, memref<?xi32>, memref<?xi32>, f32, memref<?xf32>, memref<?xf32>, f32, f32, i64, i64, i64, i64, i64, i64, memref<?xi32>, i64, i64, i64, i64, i64, i64, memref<?xi32>, i32, memref<?xf32>, memref<?xf32>, memref<?xf32>) -> (), sym_name = "kernel_unified_attention"}> ({
  ^bb0(%arg123: memref<?xbf16>, %arg124: memref<?xbf16>, %arg125: memref<?xbf16>, %arg126: memref<?xbf16>, %arg127: memref<?xi32>, %arg128: memref<?xi32>, %arg129: f32, %arg130: memref<?xf32>, %arg131: memref<?xf32>, %arg132: f32, %arg133: f32, %arg134: i64, %arg135: i64, %arg136: i64, %arg137: i64, %arg138: i64, %arg139: i64, %arg140: memref<?xi32>, %arg141: i64, %arg142: i64, %arg143: i64, %arg144: i64, %arg145: i64, %arg146: i64, %arg147: memref<?xi32>, %arg148: i32, %arg149: memref<?xf32>, %arg150: memref<?xf32>, %arg151: memref<?xf32>):
    %144 = "arith.constant"() <{value = 16 : index}> : () -> index
    %145 = "arith.constant"() <{value = 65536 : i64}> : () -> i64
    %146 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %147 = "arith.constant"() <{value = 2048 : i64}> : () -> i64
    %148 = "arith.constant"() <{value = 1 : index}> : () -> index
    %149 = "arith.constant"() <{value = 4 : index}> : () -> index
    %150 = "arith.constant"() <{value = 0 : index}> : () -> index
    %151 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %152 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %153 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %154 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %155 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %156 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %157 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %158 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %159 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %160 = "builtin.unrealized_conversion_cast"(%arg126) : (memref<?xbf16>) -> !tt.ptr<bf16>
    %161 = "builtin.unrealized_conversion_cast"(%arg125) : (memref<?xbf16>) -> !tt.ptr<bf16>
    %162 = "tensor.empty"() : () -> tensor<128x16xbf16>
    %163 = "linalg.fill"(%151, %162) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg366: bf16, %arg367: bf16):
      "linalg.yield"(%arg366) : (bf16) -> ()
    }) : (bf16, tensor<128x16xbf16>) -> tensor<128x16xbf16>
    %164 = "tensor.empty"() : () -> tensor<16x128xbf16>
    %165 = "linalg.fill"(%151, %164) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg364: bf16, %arg365: bf16):
      "linalg.yield"(%arg364) : (bf16) -> ()
    }) : (bf16, tensor<16x128xbf16>) -> tensor<16x128xbf16>
    %166 = "tensor.empty"() : () -> tensor<16x16xf32>
    %167 = "linalg.fill"(%153, %166) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg362: f32, %arg363: f32):
      "linalg.yield"(%arg362) : (f32) -> ()
    }) : (f32, tensor<16x16xf32>) -> tensor<16x16xf32>
    %168 = "tensor.empty"() : () -> tensor<16xi32>
    %169 = "linalg.fill"(%155, %168) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg360: i32, %arg361: i32):
      "linalg.yield"(%arg360) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %170 = "tensor.empty"() : () -> tensor<16xf32>
    %171 = "linalg.fill"(%156, %170) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg358: f32, %arg359: f32):
      "linalg.yield"(%arg358) : (f32) -> ()
    }) : (f32, tensor<16xf32>) -> tensor<16xf32>
    %172 = "linalg.fill"(%146, %168) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg356: i32, %arg357: i32):
      "linalg.yield"(%arg356) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %173 = "linalg.fill"(%152, %168) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg354: i32, %arg355: i32):
      "linalg.yield"(%arg354) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %174 = "linalg.fill"(%157, %168) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg352: i32, %arg353: i32):
      "linalg.yield"(%arg352) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %175 = "linalg.fill"(%159, %168) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg350: i32, %arg351: i32):
      "linalg.yield"(%arg350) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %176 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %177 = "arith.index_cast"(%176) : (index) -> i32
    %178 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %179 = "arith.index_cast"(%178) : (index) -> i32
    %180 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
    %181 = "arith.index_cast"(%180) : (index) -> i32
    %182:5 = "func.call"(%arg147, %arg128, %177, %arg148) <{callee = @vllm.v1.attention.ops.triton_attention_helpers.resolve_seq_and_query_len__Pi32_Pi32_i32_i32_c4}> : (memref<?xi32>, memref<?xi32>, i32, i32) -> (i32, i32, i32, i32, i32)
    %183 = "arith.muli"(%182#1, %159) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %184 = "arith.cmpi"(%183, %182#3) <{predicate = 5 : i64}> : (i32, i32) -> i1
    "cf.cond_br"(%184)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    %185 = "func.call"(%182#4) <{callee = @vllm.v1.attention.ops.triton_attention_helpers.cdiv_fn__i32_c256}> : (i32) -> i32
    %186 = "arith.muli"(%181, %185) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %187 = "arith.muli"(%186, %155) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %188 = "arith.cmpi"(%187, %182#4) <{predicate = 5 : i64}> : (i32, i32) -> i1
    "cf.cond_br"(%188)[^bb1, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    %189 = "linalg.generic"(%168) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg349: i32):
      %417 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %418 = "arith.index_cast"(%417) : (index) -> i32
      "linalg.yield"(%418) : (i32) -> ()
    }) : (tensor<16xi32>) -> tensor<16xi32>
    %190 = "tensor.empty"() : () -> tensor<128xi32>
    %191 = "linalg.generic"(%190) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg348: i32):
      %415 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %416 = "arith.index_cast"(%415) : (index) -> i32
      "linalg.yield"(%416) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %192 = "linalg.generic"(%189, %175, %189) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg345: i32, %arg346: i32, %arg347: i32):
      %414 = "arith.divsi"(%arg345, %arg346) : (i32, i32) -> i32
      "linalg.yield"(%414) : (i32) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %193 = "linalg.fill"(%183, %168) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg343: i32, %arg344: i32):
      "linalg.yield"(%arg343) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %194 = "linalg.generic"(%193, %192, %193) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg340: i32, %arg341: i32, %arg342: i32):
      %413 = "arith.addi"(%arg340, %arg341) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%413) : (i32) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %195 = "linalg.fill"(%182#2, %168) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg338: i32, %arg339: i32):
      "linalg.yield"(%arg338) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %196 = "linalg.generic"(%195, %194, %195) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg335: i32, %arg336: i32, %arg337: i32):
      %412 = "arith.addi"(%arg335, %arg336) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%412) : (i32) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %197 = "arith.muli"(%179, %159) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %198 = "linalg.generic"(%189, %175, %189) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg332: i32, %arg333: i32, %arg334: i32):
      %411 = "arith.remsi"(%arg332, %arg333) : (i32, i32) -> i32
      "linalg.yield"(%411) : (i32) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %199 = "linalg.fill"(%197, %168) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg330: i32, %arg331: i32):
      "linalg.yield"(%arg330) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %200 = "linalg.generic"(%199, %198, %199) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg327: i32, %arg328: i32, %arg329: i32):
      %410 = "arith.addi"(%arg327, %arg328) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%410) : (i32) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %201 = "tensor.expand_shape"(%191) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xi32>) -> tensor<1x128xi32>
    %202 = "tensor.empty"() : () -> tensor<1x128xi64>
    %203 = "linalg.generic"(%201, %202) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg325: i32, %arg326: i64):
      %409 = "arith.extsi"(%arg325) : (i32) -> i64
      "linalg.yield"(%409) : (i64) -> ()
    }) : (tensor<1x128xi32>, tensor<1x128xi64>) -> tensor<1x128xi64>
    %204 = "linalg.fill"(%182#3, %168) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg323: i32, %arg324: i32):
      "linalg.yield"(%arg323) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %205 = "tensor.empty"() : () -> tensor<16xi1>
    %206 = "linalg.generic"(%194, %204, %205) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg320: i32, %arg321: i32, %arg322: i1):
      %408 = "arith.cmpi"(%arg320, %arg321) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%408) : (i1) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi1>) -> tensor<16xi1>
    %207 = "linalg.generic"(%206, %174, %173, %174) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg316: i1, %arg317: i32, %arg318: i32, %arg319: i32):
      %407 = "arith.select"(%arg316, %arg317, %arg318) : (i1, i32, i32) -> i32
      "linalg.yield"(%407) : (i32) -> ()
    }) : (tensor<16xi1>, tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %208 = "linalg.generic"(%207, %173, %205) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg313: i32, %arg314: i32, %arg315: i1):
      %406 = "arith.cmpi"(%arg313, %arg314) <{predicate = 1 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%406) : (i1) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi1>) -> tensor<16xi1>
    %209 = "linalg.generic"(%200, %172, %205) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg310: i32, %arg311: i32, %arg312: i1):
      %405 = "arith.cmpi"(%arg310, %arg311) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%405) : (i1) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi1>) -> tensor<16xi1>
    %210 = "linalg.generic"(%209, %174, %173, %174) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg306: i1, %arg307: i32, %arg308: i32, %arg309: i32):
      %404 = "arith.select"(%arg306, %arg307, %arg308) : (i1, i32, i32) -> i32
      "linalg.yield"(%404) : (i32) -> ()
    }) : (tensor<16xi1>, tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %211 = "linalg.generic"(%210, %173, %205) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg303: i32, %arg304: i32, %arg305: i1):
      %403 = "arith.cmpi"(%arg303, %arg304) <{predicate = 1 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%403) : (i1) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi1>) -> tensor<16xi1>
    %212 = "arith.extsi"(%182#2) : (i32) -> i64
    %213 = "arith.muli"(%212, %arg135) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %214 = "arith.extsi"(%183) : (i32) -> i64
    %215 = "arith.muli"(%214, %arg135) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %216 = "arith.addi"(%213, %215) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %217 = "arith.extsi"(%197) : (i32) -> i64
    %218 = "arith.muli"(%217, %arg136) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %219 = "arith.addi"(%216, %218) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %220 = "arith.index_cast"(%219) : (i64) -> index
    %221 = "arith.subi"(%152, %182#3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %222 = "arith.addi"(%183, %221) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %223 = "arith.subi"(%152, %222) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %224 = "arith.subi"(%146, %197) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %225 = "arith.index_cast"(%arg135) : (i64) -> index
    %226 = "arith.index_cast"(%arg136) : (i64) -> index
    %227 = "memref.reinterpret_cast"(%arg124, %225, %226) <{operandSegmentSizes = array<i32: 1, 0, 0, 2>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, 1>}> : (memref<?xbf16>, index, index) -> memref<1099511627776x1099511627776x1099511627776xbf16, strided<[?, ?, 1]>>
    %228 = "arith.index_cast"(%223) : (i32) -> index
    %229 = "arith.minsi"(%228, %149) : (index, index) -> index
    %230 = "arith.maxsi"(%229, %150) : (index, index) -> index
    %231 = "arith.index_cast"(%224) : (i32) -> index
    %232 = "arith.minsi"(%231, %149) : (index, index) -> index
    %233 = "arith.maxsi"(%232, %150) : (index, index) -> index
    %234 = "arith.minsi"(%230, %149) : (index, index) -> index
    %235 = "arith.minsi"(%233, %149) : (index, index) -> index
    %236 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x4x128xbf16>
    "linalg.fill"(%151, %236) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg301: bf16, %arg302: bf16):
      "linalg.yield"(%arg301) : (bf16) -> ()
    }) : (bf16, memref<4x4x128xbf16>) -> ()
    %237 = "memref.subview"(%227, %220, %234, %235) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: 0, 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, 128>, static_strides = array<i64: 1, 1, 1>}> : (memref<1099511627776x1099511627776x1099511627776xbf16, strided<[?, ?, 1]>>, index, index, index) -> memref<?x?x128xbf16, strided<[?, ?, 1], offset: ?>>
    %238 = "memref.subview"(%236, %234, %235) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, 128>, static_strides = array<i64: 1, 1, 1>}> : (memref<4x4x128xbf16>, index, index) -> memref<?x?x128xbf16, strided<[512, 128, 1]>>
    "linalg.copy"(%237, %238) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg299: bf16, %arg300: bf16):
      "linalg.yield"(%arg299) : (bf16) -> ()
    }) : (memref<?x?x128xbf16, strided<[?, ?, 1], offset: ?>>, memref<?x?x128xbf16, strided<[512, 128, 1]>>) -> ()
    %239 = "bufferization.to_tensor"(%236) <{restrict, writable}> : (memref<4x4x128xbf16>) -> tensor<4x4x128xbf16>
    %240 = "tensor.collapse_shape"(%239) <{reassociation = [[0, 1], [2]]}> : (tensor<4x4x128xbf16>) -> tensor<16x128xbf16>
    %241 = "arith.extsi"(%182#0) : (i32) -> i64
    %242 = "arith.muli"(%241, %arg134) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %243 = "arith.index_cast"(%242) : (i64) -> index
    %244 = "func.call"() <{callee = @vllm.v1.attention.ops.triton_attention_helpers.init_softmax_M__cNone_i32S16S_u1S16S_i32_c16_cFalse_cTrue}> : () -> tensor<16xf32>
    %245 = "func.call"() <{callee = @triton.language.standard.zeros__Tc16_c128T_cfp32}> : () -> tensor<16x128xf32>
    %246 = "arith.subi"(%182#4, %182#3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %247:3 = "func.call"(%246, %182#4, %182#1, %181, %185) <{callee = @"vllm.v1.attention.ops.triton_attention_helpers.compute_tile_loop_bounds__i32_i32_i32_i32_i32_i32_c16_c16_c4_c4_c0_cFalse_cTrue_cTrue_cFalse_c-1_c-1_cFalse_cFalse_c0_cNone_i32"}> : (i32, i32, i32, i32, i32) -> (i32, i32, i32)
    %248 = "arith.index_cast"(%247#0) : (i32) -> index
    %249 = "arith.index_cast"(%247#1) : (i32) -> index
    %250:3 = "scf.for"(%248, %249, %148, %244, %171, %245) ({
    ^bb0(%arg152: index, %arg153: tensor<16xf32>, %arg154: tensor<16xf32>, %arg155: tensor<16x128xf32>):
      %264 = "arith.index_cast"(%arg152) : (index) -> i32
      %265 = "arith.muli"(%264, %155) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %266 = "linalg.fill"(%265, %168) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg297: i32, %arg298: i32):
        "linalg.yield"(%arg297) : (i32) -> ()
      }) : (i32, tensor<16xi32>) -> tensor<16xi32>
      %267 = "linalg.generic"(%266, %189, %266) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg294: i32, %arg295: i32, %arg296: i32):
        %402 = "arith.addi"(%arg294, %arg295) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%402) : (i32) -> ()
      }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
      %268 = "linalg.fill"(%247#2, %168) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg292: i32, %arg293: i32):
        "linalg.yield"(%arg292) : (i32) -> ()
      }) : (i32, tensor<16xi32>) -> tensor<16xi32>
      %269 = "linalg.generic"(%267, %268, %205) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg289: i32, %arg290: i32, %arg291: i1):
        %401 = "arith.cmpi"(%arg289, %arg290) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "linalg.yield"(%401) : (i1) -> ()
      }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi1>) -> tensor<16xi1>
      %270 = "linalg.generic"(%267, %169, %267) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg286: i32, %arg287: i32, %arg288: i32):
        %400 = "arith.divsi"(%arg286, %arg287) : (i32, i32) -> i32
        "linalg.yield"(%400) : (i32) -> ()
      }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
      %271 = "arith.index_cast"(%243) : (index) -> i32
      %272 = "linalg.fill"(%271, %168) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg284: i32, %arg285: i32):
        "linalg.yield"(%arg284) : (i32) -> ()
      }) : (i32, tensor<16xi32>) -> tensor<16xi32>
      %273 = "linalg.generic"(%272, %270, %272) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg281: i32, %arg282: i32, %arg283: i32):
        %399 = "arith.addi"(%arg281, %arg282) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%399) : (i32) -> ()
      }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
      %274 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xi32>
      "scf.for"(%150, %144, %148) ({
      ^bb0(%arg280: index):
        %395 = "tensor.extract"(%273, %arg280) : (tensor<16xi32>, index) -> i32
        %396 = "arith.index_cast"(%395) : (i32) -> index
        %397 = "memref.reinterpret_cast"(%arg127, %396) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
        %398 = "memref.subview"(%274, %arg280) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<16xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
        "memref.copy"(%397, %398) : (memref<1xi32, strided<[1], offset: ?>>, memref<1xi32, strided<[1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      %275 = "bufferization.to_tensor"(%274) <{restrict, writable}> : (memref<16xi32>) -> tensor<16xi32>
      %276 = "tensor.empty"() : () -> tensor<16xi64>
      %277 = "linalg.generic"(%275, %276) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg278: i32, %arg279: i64):
        %394 = "arith.extsi"(%arg278) : (i32) -> i64
        "linalg.yield"(%394) : (i64) -> ()
      }) : (tensor<16xi32>, tensor<16xi64>) -> tensor<16xi64>
      %278 = "tensor.expand_shape"(%277) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xi64>) -> tensor<16x1xi64>
      %279 = "tensor.empty"() : () -> tensor<16x1xi64>
      %280 = "linalg.fill"(%arg144, %279) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg276: i64, %arg277: i64):
        "linalg.yield"(%arg276) : (i64) -> ()
      }) : (i64, tensor<16x1xi64>) -> tensor<16x1xi64>
      %281 = "linalg.generic"(%278, %280, %278) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg273: i64, %arg274: i64, %arg275: i64):
        %393 = "arith.muli"(%arg273, %arg274) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%393) : (i64) -> ()
      }) : (tensor<16x1xi64>, tensor<16x1xi64>, tensor<16x1xi64>) -> tensor<16x1xi64>
      %282 = "arith.extsi"(%179) : (i32) -> i64
      %283 = "arith.muli"(%282, %arg146) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %284 = "linalg.fill"(%283, %279) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg271: i64, %arg272: i64):
        "linalg.yield"(%arg271) : (i64) -> ()
      }) : (i64, tensor<16x1xi64>) -> tensor<16x1xi64>
      %285 = "linalg.generic"(%281, %284, %281) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg268: i64, %arg269: i64, %arg270: i64):
        %392 = "arith.addi"(%arg268, %arg269) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%392) : (i64) -> ()
      }) : (tensor<16x1xi64>, tensor<16x1xi64>, tensor<16x1xi64>) -> tensor<16x1xi64>
      %286 = "tensor.empty"() : () -> tensor<16x128xi64>
      %287 = "linalg.generic"(%285, %286) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg266: i64, %arg267: i64):
        "linalg.yield"(%arg266) : (i64) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<16x1xi64>, tensor<16x128xi64>) -> tensor<16x128xi64>
      %288 = "linalg.generic"(%203, %286) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg264: i64, %arg265: i64):
        "linalg.yield"(%arg264) : (i64) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1x128xi64>, tensor<16x128xi64>) -> tensor<16x128xi64>
      %289 = "linalg.generic"(%287, %288, %287) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg261: i64, %arg262: i64, %arg263: i64):
        %391 = "arith.addi"(%arg261, %arg262) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%391) : (i64) -> ()
      }) : (tensor<16x128xi64>, tensor<16x128xi64>, tensor<16x128xi64>) -> tensor<16x128xi64>
      %290 = "linalg.generic"(%267, %169, %267) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg258: i32, %arg259: i32, %arg260: i32):
        %390 = "arith.remsi"(%arg258, %arg259) : (i32, i32) -> i32
        "linalg.yield"(%390) : (i32) -> ()
      }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
      %291 = "tensor.expand_shape"(%290) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xi32>) -> tensor<16x1xi32>
      %292 = "linalg.generic"(%291, %279) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg256: i32, %arg257: i64):
        %389 = "arith.extsi"(%arg256) : (i32) -> i64
        "linalg.yield"(%389) : (i64) -> ()
      }) : (tensor<16x1xi32>, tensor<16x1xi64>) -> tensor<16x1xi64>
      %293 = "linalg.fill"(%arg145, %279) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg254: i64, %arg255: i64):
        "linalg.yield"(%arg254) : (i64) -> ()
      }) : (i64, tensor<16x1xi64>) -> tensor<16x1xi64>
      %294 = "linalg.generic"(%292, %293, %292) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg251: i64, %arg252: i64, %arg253: i64):
        %388 = "arith.muli"(%arg251, %arg252) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%388) : (i64) -> ()
      }) : (tensor<16x1xi64>, tensor<16x1xi64>, tensor<16x1xi64>) -> tensor<16x1xi64>
      %295 = "linalg.generic"(%294, %286) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg249: i64, %arg250: i64):
        "linalg.yield"(%arg249) : (i64) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<16x1xi64>, tensor<16x128xi64>) -> tensor<16x128xi64>
      %296 = "linalg.generic"(%289, %295, %289) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg246: i64, %arg247: i64, %arg248: i64):
        %387 = "arith.addi"(%arg246, %arg247) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%387) : (i64) -> ()
      }) : (tensor<16x128xi64>, tensor<16x128xi64>, tensor<16x128xi64>) -> tensor<16x128xi64>
      %297 = "tensor.expand_shape"(%277) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 16>}> : (tensor<16xi64>) -> tensor<1x16xi64>
      %298 = "tensor.empty"() : () -> tensor<1x16xi64>
      %299 = "linalg.fill"(%arg141, %298) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg244: i64, %arg245: i64):
        "linalg.yield"(%arg244) : (i64) -> ()
      }) : (i64, tensor<1x16xi64>) -> tensor<1x16xi64>
      %300 = "linalg.generic"(%297, %299, %297) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg241: i64, %arg242: i64, %arg243: i64):
        %386 = "arith.muli"(%arg241, %arg242) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%386) : (i64) -> ()
      }) : (tensor<1x16xi64>, tensor<1x16xi64>, tensor<1x16xi64>) -> tensor<1x16xi64>
      %301 = "arith.muli"(%282, %arg143) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %302 = "linalg.fill"(%301, %298) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg239: i64, %arg240: i64):
        "linalg.yield"(%arg239) : (i64) -> ()
      }) : (i64, tensor<1x16xi64>) -> tensor<1x16xi64>
      %303 = "linalg.generic"(%300, %302, %300) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg236: i64, %arg237: i64, %arg238: i64):
        %385 = "arith.addi"(%arg236, %arg237) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%385) : (i64) -> ()
      }) : (tensor<1x16xi64>, tensor<1x16xi64>, tensor<1x16xi64>) -> tensor<1x16xi64>
      %304 = "tensor.expand_shape"(%191) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xi32>) -> tensor<128x1xi32>
      %305 = "tensor.empty"() : () -> tensor<128x1xi64>
      %306 = "linalg.generic"(%304, %305) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg234: i32, %arg235: i64):
        %384 = "arith.extsi"(%arg234) : (i32) -> i64
        "linalg.yield"(%384) : (i64) -> ()
      }) : (tensor<128x1xi32>, tensor<128x1xi64>) -> tensor<128x1xi64>
      %307 = "tensor.empty"() : () -> tensor<128x16xi64>
      %308 = "linalg.generic"(%303, %307) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg232: i64, %arg233: i64):
        "linalg.yield"(%arg232) : (i64) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1x16xi64>, tensor<128x16xi64>) -> tensor<128x16xi64>
      %309 = "linalg.generic"(%306, %307) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg230: i64, %arg231: i64):
        "linalg.yield"(%arg230) : (i64) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xi64>, tensor<128x16xi64>) -> tensor<128x16xi64>
      %310 = "linalg.generic"(%308, %309, %308) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg227: i64, %arg228: i64, %arg229: i64):
        %383 = "arith.addi"(%arg227, %arg228) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%383) : (i64) -> ()
      }) : (tensor<128x16xi64>, tensor<128x16xi64>, tensor<128x16xi64>) -> tensor<128x16xi64>
      %311 = "tensor.expand_shape"(%290) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 16>}> : (tensor<16xi32>) -> tensor<1x16xi32>
      %312 = "linalg.generic"(%311, %298) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg225: i32, %arg226: i64):
        %382 = "arith.extsi"(%arg225) : (i32) -> i64
        "linalg.yield"(%382) : (i64) -> ()
      }) : (tensor<1x16xi32>, tensor<1x16xi64>) -> tensor<1x16xi64>
      %313 = "linalg.fill"(%arg142, %298) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg223: i64, %arg224: i64):
        "linalg.yield"(%arg223) : (i64) -> ()
      }) : (i64, tensor<1x16xi64>) -> tensor<1x16xi64>
      %314 = "linalg.generic"(%312, %313, %312) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg220: i64, %arg221: i64, %arg222: i64):
        %381 = "arith.muli"(%arg220, %arg221) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%381) : (i64) -> ()
      }) : (tensor<1x16xi64>, tensor<1x16xi64>, tensor<1x16xi64>) -> tensor<1x16xi64>
      %315 = "linalg.generic"(%314, %307) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg218: i64, %arg219: i64):
        "linalg.yield"(%arg218) : (i64) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1x16xi64>, tensor<128x16xi64>) -> tensor<128x16xi64>
      %316 = "linalg.generic"(%310, %315, %310) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg215: i64, %arg216: i64, %arg217: i64):
        %380 = "arith.addi"(%arg215, %arg216) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%380) : (i64) -> ()
      }) : (tensor<128x16xi64>, tensor<128x16xi64>, tensor<128x16xi64>) -> tensor<128x16xi64>
      %317 = "tensor.expand_shape"(%269) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 16>}> : (tensor<16xi1>) -> tensor<1x16xi1>
      %318 = "tensor.empty"() : () -> tensor<128x16xi1>
      %319 = "linalg.generic"(%317, %318) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg213: i1, %arg214: i1):
        "linalg.yield"(%arg213) : (i1) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1x16xi1>, tensor<128x16xi1>) -> tensor<128x16xi1>
      %320 = "tensor.empty"() : () -> tensor<128x16x!tt.ptr<bf16>>
      %321 = "linalg.fill"(%161, %320) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg211: !tt.ptr<bf16>, %arg212: !tt.ptr<bf16>):
        "linalg.yield"(%arg211) : (!tt.ptr<bf16>) -> ()
      }) : (!tt.ptr<bf16>, tensor<128x16x!tt.ptr<bf16>>) -> tensor<128x16x!tt.ptr<bf16>>
      %322 = "linalg.generic"(%321, %316, %321) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg208: !tt.ptr<bf16>, %arg209: i64, %arg210: !tt.ptr<bf16>):
        %379 = "tt.addptr"(%arg208, %arg209) : (!tt.ptr<bf16>, i64) -> !tt.ptr<bf16>
        "linalg.yield"(%379) : (!tt.ptr<bf16>) -> ()
      }) : (tensor<128x16x!tt.ptr<bf16>>, tensor<128x16xi64>, tensor<128x16x!tt.ptr<bf16>>) -> tensor<128x16x!tt.ptr<bf16>>
      %323 = "tt.load"(%322, %319, %163) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<128x16x!tt.ptr<bf16>>, tensor<128x16xi1>, tensor<128x16xbf16>) -> tensor<128x16xbf16>
      %324 = "tensor.expand_shape"(%269) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xi1>) -> tensor<16x1xi1>
      %325 = "tensor.empty"() : () -> tensor<16x128xi1>
      %326 = "linalg.generic"(%324, %325) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg206: i1, %arg207: i1):
        "linalg.yield"(%arg206) : (i1) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<16x1xi1>, tensor<16x128xi1>) -> tensor<16x128xi1>
      %327 = "tensor.empty"() : () -> tensor<16x128x!tt.ptr<bf16>>
      %328 = "linalg.fill"(%160, %327) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg204: !tt.ptr<bf16>, %arg205: !tt.ptr<bf16>):
        "linalg.yield"(%arg204) : (!tt.ptr<bf16>) -> ()
      }) : (!tt.ptr<bf16>, tensor<16x128x!tt.ptr<bf16>>) -> tensor<16x128x!tt.ptr<bf16>>
      %329 = "linalg.generic"(%328, %296, %328) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg201: !tt.ptr<bf16>, %arg202: i64, %arg203: !tt.ptr<bf16>):
        %378 = "tt.addptr"(%arg201, %arg202) : (!tt.ptr<bf16>, i64) -> !tt.ptr<bf16>
        "linalg.yield"(%378) : (!tt.ptr<bf16>) -> ()
      }) : (tensor<16x128x!tt.ptr<bf16>>, tensor<16x128xi64>, tensor<16x128x!tt.ptr<bf16>>) -> tensor<16x128x!tt.ptr<bf16>>
      %330 = "tt.load"(%329, %326, %165) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<16x128x!tt.ptr<bf16>>, tensor<16x128xi1>, tensor<16x128xbf16>) -> tensor<16x128xbf16>
      %331 = "func.call"(%323) <{callee = @vllm.v1.attention.ops.triton_unified_attention._cast_kv_tile__bf16S128_16S_bf16S16_128S_Pfp32_c0}> : (tensor<128x16xbf16>) -> tensor<128x16xbf16>
      %332 = "func.call"(%330) <{callee = @vllm.v1.attention.ops.triton_unified_attention._cast_kv_tile__bf16S16_128S_bf16S16_128S_Pfp32_c0}> : (tensor<16x128xbf16>) -> tensor<16x128xbf16>
      %333 = "tensor.expand_shape"(%194) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xi32>) -> tensor<16x1xi32>
      %334 = "tensor.empty"() : () -> tensor<16x1xi32>
      %335 = "linalg.fill"(%246, %334) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg199: i32, %arg200: i32):
        "linalg.yield"(%arg199) : (i32) -> ()
      }) : (i32, tensor<16x1xi32>) -> tensor<16x1xi32>
      %336 = "linalg.generic"(%335, %333, %335) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg196: i32, %arg197: i32, %arg198: i32):
        %377 = "arith.addi"(%arg196, %arg197) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%377) : (i32) -> ()
      }) : (tensor<16x1xi32>, tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
      %337 = "func.call"(%336, %267) <{callee = @"vllm.v1.attention.ops.triton_attention_helpers.compute_kv_seq_mask__i32S16_1S_i32S16S_i32_i32_cNone_c0_cFalse_c0_cTrue_cFalse_cNone_Pi32_c0_cFalse_c-1_c-1_cFalse"}> : (tensor<16x1xi32>, tensor<16xi32>) -> tensor<16x16xi1>
      %338 = "func.call"() <{callee = @triton.language.standard.zeros__Tc16_c16T_cfp32}> : () -> tensor<16x16xf32>
      %339 = "linalg.fill"(%154, %166) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg194: f32, %arg195: f32):
        "linalg.yield"(%arg194) : (f32) -> ()
      }) : (f32, tensor<16x16xf32>) -> tensor<16x16xf32>
      %340 = "linalg.matmul"(%240, %331, %339) <{indexing_maps = [#map4, #map5, #map6], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg191: bf16, %arg192: bf16, %arg193: f32):
        %373 = "arith.extf"(%arg191) : (bf16) -> f32
        %374 = "arith.extf"(%arg192) : (bf16) -> f32
        %375 = "arith.mulf"(%373, %374) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %376 = "arith.addf"(%arg193, %375) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%376) : (f32) -> ()
      }) : (tensor<16x128xbf16>, tensor<128x16xbf16>, tensor<16x16xf32>) -> tensor<16x16xf32>
      %341 = "linalg.fill"(%arg129, %166) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg189: f32, %arg190: f32):
        "linalg.yield"(%arg189) : (f32) -> ()
      }) : (f32, tensor<16x16xf32>) -> tensor<16x16xf32>
      %342 = "linalg.generic"(%341, %340, %341) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg186: f32, %arg187: f32, %arg188: f32):
        %372 = "arith.mulf"(%arg186, %arg187) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%372) : (f32) -> ()
      }) : (tensor<16x16xf32>, tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
      %343 = "linalg.generic"(%338, %342, %338) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg183: f32, %arg184: f32, %arg185: f32):
        %371 = "arith.addf"(%arg183, %arg184) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%371) : (f32) -> ()
      }) : (tensor<16x16xf32>, tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
      %344 = "tensor.expand_shape"(%211) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xi1>) -> tensor<16x1xi1>
      %345 = "tensor.expand_shape"(%208) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xi1>) -> tensor<16x1xi1>
      %346 = "linalg.generic"(%344, %345, %344) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg180: i1, %arg181: i1, %arg182: i1):
        %370 = "arith.andi"(%arg180, %arg181) : (i1, i1) -> i1
        "linalg.yield"(%370) : (i1) -> ()
      }) : (tensor<16x1xi1>, tensor<16x1xi1>, tensor<16x1xi1>) -> tensor<16x1xi1>
      %347 = "tensor.empty"() : () -> tensor<16x16xi1>
      %348 = "linalg.generic"(%346, %347) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg178: i1, %arg179: i1):
        "linalg.yield"(%arg178) : (i1) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<16x1xi1>, tensor<16x16xi1>) -> tensor<16x16xi1>
      %349 = "linalg.generic"(%348, %337, %348) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg175: i1, %arg176: i1, %arg177: i1):
        %369 = "arith.andi"(%arg175, %arg176) : (i1, i1) -> i1
        "linalg.yield"(%369) : (i1) -> ()
      }) : (tensor<16x16xi1>, tensor<16x16xi1>, tensor<16x16xi1>) -> tensor<16x16xi1>
      %350 = "linalg.generic"(%349, %343, %167, %343) <{indexing_maps = [#map1, #map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg171: i1, %arg172: f32, %arg173: f32, %arg174: f32):
        %368 = "arith.select"(%arg171, %arg172, %arg173) : (i1, f32, f32) -> f32
        "linalg.yield"(%368) : (f32) -> ()
      }) : (tensor<16x16xi1>, tensor<16x16xf32>, tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
      %351:4 = "func.call"(%350, %arg153, %arg154) <{callee = @vllm.v1.attention.ops.triton_attention_helpers.softmax_step__fp32S16_16S_fp32S16S_fp32S16S}> : (tensor<16x16xf32>, tensor<16xf32>, tensor<16xf32>) -> (tensor<16xf32>, tensor<16xf32>, tensor<16x16xf32>, tensor<16xf32>)
      %352 = "tensor.expand_shape"(%351#3) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xf32>) -> tensor<16x1xf32>
      %353 = "tensor.empty"() : () -> tensor<16x128xf32>
      %354 = "linalg.generic"(%352, %353) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg169: f32, %arg170: f32):
        "linalg.yield"(%arg169) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<16x1xf32>, tensor<16x128xf32>) -> tensor<16x128xf32>
      %355 = "linalg.generic"(%arg155, %354, %arg155) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg166: f32, %arg167: f32, %arg168: f32):
        %367 = "arith.mulf"(%arg166, %arg167) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%367) : (f32) -> ()
      }) : (tensor<16x128xf32>, tensor<16x128xf32>, tensor<16x128xf32>) -> tensor<16x128xf32>
      %356 = "tensor.empty"() : () -> tensor<16x16xbf16>
      %357 = "linalg.generic"(%351#2, %356) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg164: f32, %arg165: bf16):
        %366 = "arith.truncf"(%arg164) : (f32) -> bf16
        "linalg.yield"(%366) : (bf16) -> ()
      }) : (tensor<16x16xf32>, tensor<16x16xbf16>) -> tensor<16x16xbf16>
      %358 = "linalg.fill"(%154, %353) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg162: f32, %arg163: f32):
        "linalg.yield"(%arg162) : (f32) -> ()
      }) : (f32, tensor<16x128xf32>) -> tensor<16x128xf32>
      %359 = "linalg.matmul"(%357, %332, %358) <{indexing_maps = [#map4, #map5, #map6], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg159: bf16, %arg160: bf16, %arg161: f32):
        %362 = "arith.extf"(%arg159) : (bf16) -> f32
        %363 = "arith.extf"(%arg160) : (bf16) -> f32
        %364 = "arith.mulf"(%362, %363) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %365 = "arith.addf"(%arg161, %364) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%365) : (f32) -> ()
      }) : (tensor<16x16xbf16>, tensor<16x128xbf16>, tensor<16x128xf32>) -> tensor<16x128xf32>
      %360 = "linalg.generic"(%355, %359, %355) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg156: f32, %arg157: f32, %arg158: f32):
        %361 = "arith.addf"(%arg156, %arg157) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%361) : (f32) -> ()
      }) : (tensor<16x128xf32>, tensor<16x128xf32>, tensor<16x128xf32>) -> tensor<16x128xf32>
      "scf.yield"(%351#0, %351#1, %360) : (tensor<16xf32>, tensor<16xf32>, tensor<16x128xf32>) -> ()
    }) : (index, index, index, tensor<16xf32>, tensor<16xf32>, tensor<16x128xf32>) -> (tensor<16xf32>, tensor<16xf32>, tensor<16x128xf32>)
    %251 = "arith.muli"(%181, %158) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %252 = "arith.extsi"(%251) : (i32) -> i64
    %253 = "arith.muli"(%212, %145) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %254 = "arith.muli"(%214, %145) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %255 = "arith.addi"(%253, %254) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %256 = "arith.muli"(%217, %147) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %257 = "arith.addi"(%255, %256) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %258 = "arith.addi"(%257, %252) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %259 = "arith.index_cast"(%258) : (i64) -> index
    %260 = "memref.reinterpret_cast"(%arg149) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776, 1099511627776>, static_strides = array<i64: 65536, 2048, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776x1099511627776xf32, strided<[65536, 2048, 1]>>
    %261 = "tensor.expand_shape"(%250#2) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 4, 4, 128>}> : (tensor<16x128xf32>) -> tensor<4x4x128xf32>
    %262 = "tensor.extract_slice"(%261, %234, %235) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<4x4x128xf32>, index, index) -> tensor<?x?x128xf32>
    %263 = "memref.subview"(%260, %259, %234, %235) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: 0, 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, 128>, static_strides = array<i64: 1, 1, 1>}> : (memref<1099511627776x1099511627776x1099511627776xf32, strided<[65536, 2048, 1]>>, index, index, index) -> memref<?x?x128xf32, strided<[65536, 2048, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%262, %263) <{writable}> : (tensor<?x?x128xf32>, memref<?x?x128xf32, strided<[65536, 2048, 1], offset: ?>>) -> ()
    "func.call"(%arg150, %arg151, %196, %200, %181, %250#0, %250#1, %208, %211) <{callee = @vllm.v1.attention.ops.triton_attention_helpers.store_segm_reduce_scalars__Pfp32_Pfp32_i32S16S_i32S16S_i32_fp32S16S_fp32S16S_u1S16S_u1S16S_c32_c16}> : (memref<?xf32>, memref<?xf32>, tensor<16xi32>, tensor<16xi32>, i32, tensor<16xf32>, tensor<16xf32>, tensor<16xi1>, tensor<16xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32>, memref<?xi32>, i32, i32) -> (i32, i32, i32, i32, i32), sym_name = "vllm.v1.attention.ops.triton_attention_helpers.resolve_seq_and_query_len__Pi32_Pi32_i32_i32_c4", sym_visibility = "private"}> ({
  ^bb0(%arg119: memref<?xi32>, %arg120: memref<?xi32>, %arg121: i32, %arg122: i32):
    %129 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %130 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %131 = "builtin.unrealized_conversion_cast"(%arg120) : (memref<?xi32>) -> !tt.ptr<i32>
    %132 = "builtin.unrealized_conversion_cast"(%arg119) : (memref<?xi32>) -> !tt.ptr<i32>
    %133 = "func.call"(%arg119, %arg121, %arg122) <{callee = @vllm.v1.attention.ops.triton_attention_helpers.find_seq_idx__Pi32_i32_i32_c4_cTrue}> : (memref<?xi32>, i32, i32) -> i32
    %134 = "tt.addptr"(%132, %133) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
    %135 = "tt.load"(%134) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
    %136 = "arith.divsi"(%135, %130) : (i32, i32) -> i32
    %137 = "arith.addi"(%136, %133) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %138 = "arith.subi"(%arg121, %137) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %139 = "tt.addptr"(%134, %129) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
    %140 = "tt.load"(%139) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
    %141 = "arith.subi"(%140, %135) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %142 = "tt.addptr"(%131, %133) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
    %143 = "tt.load"(%142) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
    "func.return"(%133, %138, %135, %141, %143) : (i32, i32, i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32>, i32, i32) -> i32, sym_name = "vllm.v1.attention.ops.triton_attention_helpers.find_seq_idx__Pi32_i32_i32_c4_cTrue", sym_visibility = "private"}> ({
  ^bb0(%arg113: memref<?xi32>, %arg114: i32, %arg115: i32):
    %103 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %104 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %105 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %106 = "arith.constant"() <{value = 0 : index}> : () -> index
    %107 = "arith.constant"() <{value = 16 : index}> : () -> index
    %108 = "arith.constant"() <{value = 1 : index}> : () -> index
    %109 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %110 = "builtin.unrealized_conversion_cast"(%arg113) : (memref<?xi32>) -> !tt.ptr<i32>
    %111 = "arith.subi"(%arg115, %103) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %112:2 = "scf.for"(%106, %107, %108, %109, %arg115) ({
    ^bb0(%arg116: index, %arg117: i32, %arg118: i32):
      %114 = "arith.cmpi"(%arg117, %arg118) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %115 = "arith.addi"(%arg117, %arg118) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %116 = "arith.divsi"(%115, %104) : (i32, i32) -> i32
      %117 = "arith.minsi"(%116, %111) : (i32, i32) -> i32
      %118 = "arith.maxsi"(%117, %109) : (i32, i32) -> i32
      %119 = "tt.addptr"(%110, %118) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      %120 = "tt.load"(%119) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
      %121 = "arith.divsi"(%120, %105) : (i32, i32) -> i32
      %122 = "arith.addi"(%121, %118) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %123 = "arith.cmpi"(%122, %arg114) <{predicate = 3 : i64}> : (i32, i32) -> i1
      %124 = "arith.addi"(%118, %103) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %125 = "arith.select"(%123, %124, %arg117) : (i1, i32, i32) -> i32
      %126 = "arith.select"(%123, %arg118, %118) : (i1, i32, i32) -> i32
      %127 = "arith.select"(%114, %125, %arg117) : (i1, i32, i32) -> i32
      %128 = "arith.select"(%114, %126, %arg118) : (i1, i32, i32) -> i32
      "scf.yield"(%127, %128) : (i32, i32) -> ()
    }) : (index, index, index, i32, i32) -> (i32, i32)
    %113 = "arith.subi"(%112#0, %103) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%113) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "vllm.v1.attention.ops.triton_attention_helpers.cdiv_fn__i32_c256", sym_visibility = "private"}> ({
  ^bb0(%arg112: i32):
    %99 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %100 = "arith.constant"() <{value = 255 : i32}> : () -> i32
    %101 = "arith.addi"(%arg112, %100) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %102 = "arith.divsi"(%101, %99) : (i32, i32) -> i32
    "func.return"(%102) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<16xf32>, sym_name = "vllm.v1.attention.ops.triton_attention_helpers.init_softmax_M__cNone_i32S16S_u1S16S_i32_c16_cFalse_cTrue", sym_visibility = "private"}> ({
    %96 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %97 = "tensor.empty"() : () -> tensor<16xf32>
    %98 = "linalg.fill"(%96, %97) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg110: f32, %arg111: f32):
      "linalg.yield"(%arg110) : (f32) -> ()
    }) : (f32, tensor<16xf32>) -> tensor<16xf32>
    "func.return"(%98) : (tensor<16xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<16x128xf32>, sym_name = "triton.language.standard.zeros__Tc16_c128T_cfp32", sym_visibility = "private"}> ({
    %93 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %94 = "tensor.empty"() : () -> tensor<16x128xf32>
    %95 = "linalg.fill"(%93, %94) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg108: f32, %arg109: f32):
      "linalg.yield"(%arg108) : (f32) -> ()
    }) : (f32, tensor<16x128xf32>) -> tensor<16x128xf32>
    "func.return"(%95) : (tensor<16x128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, i32, i32, i32) -> (i32, i32, i32), sym_name = "vllm.v1.attention.ops.triton_attention_helpers.compute_tile_loop_bounds__i32_i32_i32_i32_i32_i32_c16_c16_c4_c4_c0_cFalse_cTrue_cTrue_cFalse_c-1_c-1_cFalse_cFalse_c0_cNone_i32", sym_visibility = "private"}> ({
  ^bb0(%arg103: i32, %arg104: i32, %arg105: i32, %arg106: i32, %arg107: i32):
    %80 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %81 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %82 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %83 = "arith.muli"(%arg105, %82) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %84 = "arith.addi"(%arg103, %83) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %85 = "arith.addi"(%84, %82) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %86 = "arith.minsi"(%85, %arg104) : (i32, i32) -> i32
    %87 = "func.call"(%86) <{callee = @vllm.v1.attention.ops.triton_attention_helpers.cdiv_fn__i32_c16}> : (i32) -> i32
    %88 = "arith.muli"(%arg106, %arg107) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %89 = "arith.maxsi"(%88, %80) : (i32, i32) -> i32
    %90 = "arith.addi"(%arg106, %81) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %91 = "arith.muli"(%90, %arg107) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %92 = "arith.minsi"(%91, %87) : (i32, i32) -> i32
    "func.return"(%89, %92, %86) : (i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "vllm.v1.attention.ops.triton_attention_helpers.cdiv_fn__i32_c16", sym_visibility = "private"}> ({
  ^bb0(%arg102: i32):
    %76 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %77 = "arith.constant"() <{value = 15 : i32}> : () -> i32
    %78 = "arith.addi"(%arg102, %77) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %79 = "arith.divsi"(%78, %76) : (i32, i32) -> i32
    "func.return"(%79) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<128x16xbf16>) -> tensor<128x16xbf16>, sym_name = "vllm.v1.attention.ops.triton_unified_attention._cast_kv_tile__bf16S128_16S_bf16S16_128S_Pfp32_c0", sym_visibility = "private"}> ({
  ^bb0(%arg101: tensor<128x16xbf16>):
    "func.return"(%arg101) : (tensor<128x16xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<16x128xbf16>) -> tensor<16x128xbf16>, sym_name = "vllm.v1.attention.ops.triton_unified_attention._cast_kv_tile__bf16S16_128S_bf16S16_128S_Pfp32_c0", sym_visibility = "private"}> ({
  ^bb0(%arg100: tensor<16x128xbf16>):
    "func.return"(%arg100) : (tensor<16x128xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<16x1xi32>, tensor<16xi32>) -> tensor<16x16xi1>, sym_name = "vllm.v1.attention.ops.triton_attention_helpers.compute_kv_seq_mask__i32S16_1S_i32S16S_i32_i32_cNone_c0_cFalse_c0_cTrue_cFalse_cNone_Pi32_c0_cFalse_c-1_c-1_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg91: tensor<16x1xi32>, %arg92: tensor<16xi32>):
    %69 = "tensor.expand_shape"(%arg92) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 16>}> : (tensor<16xi32>) -> tensor<1x16xi32>
    %70 = "tensor.empty"() : () -> tensor<16x16xi32>
    %71 = "linalg.generic"(%69, %70) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg98: i32, %arg99: i32):
      "linalg.yield"(%arg98) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x16xi32>, tensor<16x16xi32>) -> tensor<16x16xi32>
    %72 = "linalg.generic"(%arg91, %70) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg96: i32, %arg97: i32):
      "linalg.yield"(%arg96) : (i32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<16x1xi32>, tensor<16x16xi32>) -> tensor<16x16xi32>
    %73 = "tensor.empty"() : () -> tensor<16x16xi1>
    %74 = "linalg.generic"(%71, %72, %73) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg93: i32, %arg94: i32, %arg95: i1):
      %75 = "arith.cmpi"(%arg93, %arg94) <{predicate = 3 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%75) : (i1) -> ()
    }) : (tensor<16x16xi32>, tensor<16x16xi32>, tensor<16x16xi1>) -> tensor<16x16xi1>
    "func.return"(%74) : (tensor<16x16xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<16x16xf32>, sym_name = "triton.language.standard.zeros__Tc16_c16T_cfp32", sym_visibility = "private"}> ({
    %66 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %67 = "tensor.empty"() : () -> tensor<16x16xf32>
    %68 = "linalg.fill"(%66, %67) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg89: f32, %arg90: f32):
      "linalg.yield"(%arg89) : (f32) -> ()
    }) : (f32, tensor<16x16xf32>) -> tensor<16x16xf32>
    "func.return"(%68) : (tensor<16x16xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<16x16xf32>, tensor<16xf32>, tensor<16xf32>) -> (tensor<16xf32>, tensor<16xf32>, tensor<16x16xf32>, tensor<16xf32>), sym_name = "vllm.v1.attention.ops.triton_attention_helpers.softmax_step__fp32S16_16S_fp32S16S_fp32S16S", sym_visibility = "private"}> ({
  ^bb0(%arg54: tensor<16x16xf32>, %arg55: tensor<16xf32>, %arg56: tensor<16xf32>):
    %37 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %38 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %39 = "tensor.empty"() : () -> tensor<16xf32>
    %40 = "linalg.fill"(%38, %39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg87: f32, %arg88: f32):
      "linalg.yield"(%arg87) : (f32) -> ()
    }) : (f32, tensor<16xf32>) -> tensor<16xf32>
    %41 = "linalg.fill"(%37, %39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg85: f32, %arg86: f32):
      "linalg.yield"(%arg85) : (f32) -> ()
    }) : (f32, tensor<16xf32>) -> tensor<16xf32>
    %42 = "func.call"(%arg54) <{callee = @triton.language.standard.max__fp32S16_16S_c1_cFalse_cTrue_cFalse}> : (tensor<16x16xf32>) -> tensor<16xf32>
    %43 = "linalg.generic"(%arg55, %42, %arg55) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg82: f32, %arg83: f32, %arg84: f32):
      %65 = "arith.maxnumf"(%arg82, %arg83) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%65) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %44 = "tensor.empty"() : () -> tensor<16xi1>
    %45 = "linalg.generic"(%43, %41, %44) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg79: f32, %arg80: f32, %arg81: i1):
      %64 = "arith.cmpf"(%arg79, %arg80) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%64) : (i1) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>, tensor<16xi1>) -> tensor<16xi1>
    %46 = "linalg.generic"(%45, %43, %40, %43) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg75: i1, %arg76: f32, %arg77: f32, %arg78: f32):
      %63 = "arith.select"(%arg75, %arg76, %arg77) : (i1, f32, f32) -> f32
      "linalg.yield"(%63) : (f32) -> ()
    }) : (tensor<16xi1>, tensor<16xf32>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %47 = "tensor.expand_shape"(%46) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xf32>) -> tensor<16x1xf32>
    %48 = "tensor.empty"() : () -> tensor<16x16xf32>
    %49 = "linalg.generic"(%47, %48) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg73: f32, %arg74: f32):
      "linalg.yield"(%arg73) : (f32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<16x1xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
    %50 = "linalg.generic"(%arg54, %49, %arg54) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg70: f32, %arg71: f32, %arg72: f32):
      %62 = "arith.subf"(%arg70, %arg71) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%62) : (f32) -> ()
    }) : (tensor<16x16xf32>, tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
    %51 = "linalg.generic"(%50, %50) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg68: f32, %arg69: f32):
      %61 = "math.exp"(%arg68) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%61) : (f32) -> ()
    }) : (tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
    %52 = "func.call"(%51) <{callee = @triton.language.standard.sum__fp32S16_16S_c1_cFalse_cNone}> : (tensor<16x16xf32>) -> tensor<16xf32>
    %53 = "linalg.generic"(%arg55, %46, %arg55) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg65: f32, %arg66: f32, %arg67: f32):
      %60 = "arith.subf"(%arg65, %arg66) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%60) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %54 = "linalg.generic"(%53, %53) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg63: f32, %arg64: f32):
      %59 = "math.exp"(%arg63) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%59) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %55 = "linalg.generic"(%arg56, %54, %arg56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg60: f32, %arg61: f32, %arg62: f32):
      %58 = "arith.mulf"(%arg60, %arg61) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%58) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %56 = "linalg.generic"(%55, %52, %55) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg57: f32, %arg58: f32, %arg59: f32):
      %57 = "arith.addf"(%arg57, %arg58) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%57) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    "func.return"(%46, %56, %51, %54) : (tensor<16xf32>, tensor<16xf32>, tensor<16x16xf32>, tensor<16xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<16x16xf32>) -> tensor<16xf32>, sym_name = "triton.language.standard.max__fp32S16_16S_c1_cFalse_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg51: tensor<16x16xf32>):
    %35 = "tt.reduce"(%arg51) <{axis = 1 : i32}> ({
    ^bb0(%arg52: f32, %arg53: f32):
      %36 = "func.call"(%arg52, %arg53) <{callee = @triton.language.standard._elementwise_max__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%36) : (f32) -> ()
    }) : (tensor<16x16xf32>) -> tensor<16xf32>
    "func.return"(%35) : (tensor<16xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._elementwise_max__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg49: f32, %arg50: f32):
    %34 = "arith.maxnumf"(%arg49, %arg50) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%34) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<16x16xf32>) -> tensor<16xf32>, sym_name = "triton.language.standard.sum__fp32S16_16S_c1_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg46: tensor<16x16xf32>):
    %32 = "tt.reduce"(%arg46) <{axis = 1 : i32}> ({
    ^bb0(%arg47: f32, %arg48: f32):
      %33 = "func.call"(%arg47, %arg48) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%33) : (f32) -> ()
    }) : (tensor<16x16xf32>) -> tensor<16xf32>
    "func.return"(%32) : (tensor<16xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg44: f32, %arg45: f32):
    %31 = "arith.addf"(%arg44, %arg45) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%31) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, tensor<16xi32>, tensor<16xi32>, i32, tensor<16xf32>, tensor<16xf32>, tensor<16xi1>, tensor<16xi1>) -> (), sym_name = "vllm.v1.attention.ops.triton_attention_helpers.store_segm_reduce_scalars__Pfp32_Pfp32_i32S16S_i32S16S_i32_fp32S16S_fp32S16S_u1S16S_u1S16S_c32_c16", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: tensor<16xi32>, %arg3: tensor<16xi32>, %arg4: i32, %arg5: tensor<16xf32>, %arg6: tensor<16xf32>, %arg7: tensor<16xi1>, %arg8: tensor<16xi1>):
    %0 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<?xf32>) -> !tt.ptr<f32>
    %3 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !tt.ptr<f32>
    %4 = "tensor.empty"() : () -> tensor<16xi32>
    %5 = "linalg.fill"(%0, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg42: i32, %arg43: i32):
      "linalg.yield"(%arg42) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %6 = "tensor.empty"() : () -> tensor<16xi64>
    %7 = "linalg.fill"(%1, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg40: i64, %arg41: i64):
      "linalg.yield"(%arg40) : (i64) -> ()
    }) : (i64, tensor<16xi64>) -> tensor<16xi64>
    %8 = "linalg.generic"(%arg2, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg38: i32, %arg39: i64):
      %30 = "arith.extsi"(%arg38) : (i32) -> i64
      "linalg.yield"(%30) : (i64) -> ()
    }) : (tensor<16xi32>, tensor<16xi64>) -> tensor<16xi64>
    %9 = "linalg.generic"(%8, %7, %8) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg35: i64, %arg36: i64, %arg37: i64):
      %29 = "arith.muli"(%arg35, %arg36) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "linalg.yield"(%29) : (i64) -> ()
    }) : (tensor<16xi64>, tensor<16xi64>, tensor<16xi64>) -> tensor<16xi64>
    %10 = "linalg.generic"(%arg3, %5, %arg3) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg32: i32, %arg33: i32, %arg34: i32):
      %28 = "arith.muli"(%arg32, %arg33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%28) : (i32) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %11 = "linalg.generic"(%10, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: i32, %arg31: i64):
      %27 = "arith.extsi"(%arg30) : (i32) -> i64
      "linalg.yield"(%27) : (i64) -> ()
    }) : (tensor<16xi32>, tensor<16xi64>) -> tensor<16xi64>
    %12 = "linalg.generic"(%9, %11, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg27: i64, %arg28: i64, %arg29: i64):
      %26 = "arith.addi"(%arg27, %arg28) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "linalg.yield"(%26) : (i64) -> ()
    }) : (tensor<16xi64>, tensor<16xi64>, tensor<16xi64>) -> tensor<16xi64>
    %13 = "arith.extsi"(%arg4) : (i32) -> i64
    %14 = "linalg.fill"(%13, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: i64, %arg26: i64):
      "linalg.yield"(%arg25) : (i64) -> ()
    }) : (i64, tensor<16xi64>) -> tensor<16xi64>
    %15 = "linalg.generic"(%12, %14, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg22: i64, %arg23: i64, %arg24: i64):
      %25 = "arith.addi"(%arg22, %arg23) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "linalg.yield"(%25) : (i64) -> ()
    }) : (tensor<16xi64>, tensor<16xi64>, tensor<16xi64>) -> tensor<16xi64>
    %16 = "linalg.generic"(%arg7, %arg8, %arg7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg19: i1, %arg20: i1, %arg21: i1):
      %24 = "arith.andi"(%arg19, %arg20) : (i1, i1) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<16xi1>, tensor<16xi1>, tensor<16xi1>) -> tensor<16xi1>
    %17 = "tensor.empty"() : () -> tensor<16x!tt.ptr<f32>>
    %18 = "linalg.fill"(%3, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: !tt.ptr<f32>, %arg18: !tt.ptr<f32>):
      "linalg.yield"(%arg17) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<16x!tt.ptr<f32>>) -> tensor<16x!tt.ptr<f32>>
    %19 = "linalg.generic"(%18, %15, %18) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg14: !tt.ptr<f32>, %arg15: i64, %arg16: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg14, %arg15) : (!tt.ptr<f32>, i64) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<16x!tt.ptr<f32>>, tensor<16xi64>, tensor<16x!tt.ptr<f32>>) -> tensor<16x!tt.ptr<f32>>
    "tt.store"(%19, %arg5, %16) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<16x!tt.ptr<f32>>, tensor<16xf32>, tensor<16xi1>) -> ()
    %20 = "linalg.fill"(%2, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<16x!tt.ptr<f32>>) -> tensor<16x!tt.ptr<f32>>
    %21 = "linalg.generic"(%20, %15, %20) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i64, %arg11: !tt.ptr<f32>):
      %22 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i64) -> !tt.ptr<f32>
      "linalg.yield"(%22) : (!tt.ptr<f32>) -> ()
    }) : (tensor<16x!tt.ptr<f32>>, tensor<16xi64>, tensor<16x!tt.ptr<f32>>) -> tensor<16x!tt.ptr<f32>>
    "tt.store"(%21, %arg6, %16) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<16x!tt.ptr<f32>>, tensor<16xf32>, tensor<16xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

