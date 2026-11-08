#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map5 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map6 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (f32, memref<?xf32>, i32, memref<?xf16>, memref<?xf16>, memref<?xf16>, memref<?xf16>, i32) -> (), sym_name = "_attn_fwd"}> ({
  ^bb0(%arg162: f32, %arg163: memref<?xf32>, %arg164: i32, %arg165: memref<?xf16>, %arg166: memref<?xf16>, %arg167: memref<?xf16>, %arg168: memref<?xf16>, %arg169: i32):
    %159 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %160 = "arith.constant"() <{value = 1.44269502 : f32}> : () -> f32
    %161 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %162 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %163 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %164 = "tensor.empty"() : () -> tensor<128xf32>
    %165 = "linalg.fill"(%159, %164) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg197: f32, %arg198: f32):
      "linalg.yield"(%arg197) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %166 = "linalg.fill"(%162, %164) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg195: f32, %arg196: f32):
      "linalg.yield"(%arg195) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %167 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %168 = "arith.index_cast"(%167) : (index) -> i32
    %169 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %170 = "arith.index_cast"(%169) : (index) -> i32
    %171 = "arith.divsi"(%170, %arg164) : (i32, i32) -> i32
    %172 = "arith.remsi"(%170, %arg164) : (i32, i32) -> i32
    %173 = "arith.muli"(%arg164, %arg169) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %174 = "func.call"(%arg165, %173) <{callee = @"tutorials.06-fused-attention._maybe_make_tensor_desc__Pfp16_Ti32_c128T_Tc128_c1T_Tc128_c128T"}> : (memref<?xf16>, i32) -> !tt.tensordesc<tensor<128x128xf16>>
    %175 = "func.call"(%arg167, %173) <{callee = @"tutorials.06-fused-attention._maybe_make_tensor_desc__Pfp16_Ti32_c128T_Tc128_c1T_Tc64_c128T"}> : (memref<?xf16>, i32) -> !tt.tensordesc<tensor<64x128xf16>>
    %176 = "func.call"(%arg166, %173) <{callee = @"tutorials.06-fused-attention._maybe_make_tensor_desc__Pfp16_Ti32_c128T_Tc128_c1T_Tc64_c128T"}> : (memref<?xf16>, i32) -> !tt.tensordesc<tensor<64x128xf16>>
    %177 = "func.call"(%arg168, %173) <{callee = @"tutorials.06-fused-attention._maybe_make_tensor_desc__Pfp16_Ti32_c128T_Tc128_c1T_Tc128_c128T"}> : (memref<?xf16>, i32) -> !tt.tensordesc<tensor<128x128xf16>>
    %178 = "arith.muli"(%171, %173) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %179 = "arith.muli"(%172, %arg169) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %180 = "arith.addi"(%178, %179) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %181 = "arith.muli"(%168, %163) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %182 = "arith.addi"(%180, %181) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %183 = "arith.index_cast"(%181) : (i32) -> index
    %184 = "tensor.empty"() : () -> tensor<128xi32>
    %185 = "linalg.generic"(%184) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg194: i32):
      %220 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %221 = "arith.index_cast"(%220) : (index) -> i32
      "linalg.yield"(%221) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %186 = "linalg.fill"(%181, %184) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg192: i32, %arg193: i32):
      "linalg.yield"(%arg192) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %187 = "linalg.generic"(%186, %185, %186) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg189: i32, %arg190: i32, %arg191: i32):
      %219 = "arith.addi"(%arg189, %arg190) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%219) : (i32) -> ()
    }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
    %188 = "tensor.empty"() : () -> tensor<64xi32>
    %189 = "linalg.generic"(%188) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg188: i32):
      %217 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %218 = "arith.index_cast"(%217) : (index) -> i32
      "linalg.yield"(%218) : (i32) -> ()
    }) : (tensor<64xi32>) -> tensor<64xi32>
    %190 = "func.call"() <{callee = @triton.language.standard.zeros__Tc128T_cfp32}> : () -> tensor<128xf32>
    %191 = "linalg.generic"(%190, %166, %190) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg185: f32, %arg186: f32, %arg187: f32):
      %216 = "arith.subf"(%arg185, %arg186) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%216) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %192 = "func.call"() <{callee = @triton.language.standard.zeros__Tc128T_cfp32}> : () -> tensor<128xf32>
    %193 = "linalg.generic"(%192, %165, %192) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg182: f32, %arg183: f32, %arg184: f32):
      %215 = "arith.addf"(%arg182, %arg183) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%215) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %194 = "func.call"() <{callee = @triton.language.standard.zeros__Tc128_c128T_cfp32}> : () -> tensor<128x128xf32>
    %195 = "arith.mulf"(%arg162, %160) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %196 = "tt.descriptor_load"(%174, %182, %161) <{cache = 1 : i32, evict = 1 : i32}> : (!tt.tensordesc<tensor<128x128xf16>>, i32, i32) -> tensor<128x128xf16>
    %197:3 = "func.call"(%194, %193, %191, %196, %176, %175, %180, %168, %195) <{callee = @"tutorials.06-fused-attention._attn_fwd_inner__fp32S128_128S_fp32S128S_fp32S128S_fp16S128_128S_TDfp16S64_128S_TDfp16S64_128S_i32_cfp16_i32_fp32_c128_c128_c64_c1_i32S128S_i32S64S_i32_cFalse_cFalse"}> : (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, tensor<128x128xf16>, !tt.tensordesc<tensor<64x128xf16>>, !tt.tensordesc<tensor<64x128xf16>>, i32, i32, f32) -> (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>)
    %198:3 = "func.call"(%197#0, %197#1, %197#2, %196, %176, %175, %180, %168, %195, %187, %189) <{callee = @"tutorials.06-fused-attention._attn_fwd_inner__fp32S128_128S_fp32S128S_fp32S128S_fp16S128_128S_TDfp16S64_128S_TDfp16S64_128S_i32_cfp16_i32_fp32_c128_c128_c64_c2_i32S128S_i32S64S_i32_cFalse_cFalse"}> : (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, tensor<128x128xf16>, !tt.tensordesc<tensor<64x128xf16>>, !tt.tensordesc<tensor<64x128xf16>>, i32, i32, f32, tensor<128xi32>, tensor<64xi32>) -> (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>)
    %199 = "linalg.generic"(%198#1, %198#1) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg180: f32, %arg181: f32):
      %214 = "math.log2"(%arg180) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%214) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %200 = "linalg.generic"(%198#2, %199, %198#2) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg177: f32, %arg178: f32, %arg179: f32):
      %213 = "arith.addf"(%arg177, %arg178) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%213) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %201 = "tensor.expand_shape"(%198#1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
    %202 = "tensor.empty"() : () -> tensor<128x128xf32>
    %203 = "linalg.generic"(%201, %202) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg175: f32, %arg176: f32):
      "linalg.yield"(%arg175) : (f32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    %204 = "linalg.generic"(%198#0, %203, %198#0) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg172: f32, %arg173: f32, %arg174: f32):
      %212 = "arith.divf"(%arg172, %arg173) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%212) : (f32) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    %205 = "arith.muli"(%170, %arg169) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %206 = "arith.index_cast"(%205) : (i32) -> index
    %207 = "arith.addi"(%206, %183) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %208 = "memref.subview"(%arg163, %207) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<128xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%200, %208) <{writable}> : (tensor<128xf32>, memref<128xf32, strided<[1], offset: ?>>) -> ()
    %209 = "tensor.empty"() : () -> tensor<128x128xf16>
    %210 = "linalg.generic"(%204, %209) <{indexing_maps = [#map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg170: f32, %arg171: f16):
      %211 = "arith.truncf"(%arg170) : (f32) -> f16
      "linalg.yield"(%211) : (f16) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xf16>) -> tensor<128x128xf16>
    "tt.descriptor_store"(%177, %210, %182, %161) : (!tt.tensordesc<tensor<128x128xf16>>, tensor<128x128xf16>, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf16>, i32) -> !tt.tensordesc<tensor<128x128xf16>>, sym_name = "tutorials.06-fused-attention._maybe_make_tensor_desc__Pfp16_Ti32_c128T_Tc128_c1T_Tc128_c128T", sym_visibility = "private"}> ({
  ^bb0(%arg160: memref<?xf16>, %arg161: i32):
    %154 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %155 = "arith.constant"() <{value = 128 : i64}> : () -> i64
    %156 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %157 = "builtin.unrealized_conversion_cast"(%arg160) : (memref<?xf16>) -> !tt.ptr<f16>
    %158 = "tt.make_tensor_descriptor"(%157, %arg161, %156, %155, %154) <{padding = 1 : i32}> : (!tt.ptr<f16>, i32, i32, i64, i64) -> !tt.tensordesc<tensor<128x128xf16>>
    "func.return"(%158) : (!tt.tensordesc<tensor<128x128xf16>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf16>, i32) -> !tt.tensordesc<tensor<64x128xf16>>, sym_name = "tutorials.06-fused-attention._maybe_make_tensor_desc__Pfp16_Ti32_c128T_Tc128_c1T_Tc64_c128T", sym_visibility = "private"}> ({
  ^bb0(%arg158: memref<?xf16>, %arg159: i32):
    %149 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %150 = "arith.constant"() <{value = 128 : i64}> : () -> i64
    %151 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %152 = "builtin.unrealized_conversion_cast"(%arg158) : (memref<?xf16>) -> !tt.ptr<f16>
    %153 = "tt.make_tensor_descriptor"(%152, %arg159, %151, %150, %149) <{padding = 1 : i32}> : (!tt.ptr<f16>, i32, i32, i64, i64) -> !tt.tensordesc<tensor<64x128xf16>>
    "func.return"(%153) : (!tt.tensordesc<tensor<64x128xf16>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<128xf32>, sym_name = "triton.language.standard.zeros__Tc128T_cfp32", sym_visibility = "private"}> ({
    %146 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %147 = "tensor.empty"() : () -> tensor<128xf32>
    %148 = "linalg.fill"(%146, %147) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg156: f32, %arg157: f32):
      "linalg.yield"(%arg156) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    "func.return"(%148) : (tensor<128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<128x128xf32>, sym_name = "triton.language.standard.zeros__Tc128_c128T_cfp32", sym_visibility = "private"}> ({
    %143 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %144 = "tensor.empty"() : () -> tensor<128x128xf32>
    %145 = "linalg.fill"(%143, %144) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg154: f32, %arg155: f32):
      "linalg.yield"(%arg154) : (f32) -> ()
    }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
    "func.return"(%145) : (tensor<128x128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, tensor<128x128xf16>, !tt.tensordesc<tensor<64x128xf16>>, !tt.tensordesc<tensor<64x128xf16>>, i32, i32, f32) -> (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>), sym_name = "tutorials.06-fused-attention._attn_fwd_inner__fp32S128_128S_fp32S128S_fp32S128S_fp16S128_128S_TDfp16S64_128S_TDfp16S64_128S_i32_cfp16_i32_fp32_c128_c128_c64_c1_i32S128S_i32S64S_i32_cFalse_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg91: tensor<128x128xf32>, %arg92: tensor<128xf32>, %arg93: tensor<128xf32>, %arg94: tensor<128x128xf16>, %arg95: !tt.tensordesc<tensor<64x128xf16>>, %arg96: !tt.tensordesc<tensor<64x128xf16>>, %arg97: i32, %arg98: i32, %arg99: f32):
    %84 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %85 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %86 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %87 = "arith.constant"() <{value = 64 : index}> : () -> index
    %88 = "arith.constant"() <{value = 0 : index}> : () -> index
    %89 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %90 = "arith.muli"(%arg98, %84) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %91 = "arith.index_cast"(%90) : (i32) -> index
    %92:5 = "scf.for"(%88, %91, %87, %arg91, %arg92, %arg93, %arg97, %arg97) ({
    ^bb0(%arg100: index, %arg101: tensor<128x128xf32>, %arg102: tensor<128xf32>, %arg103: tensor<128xf32>, %arg104: i32, %arg105: i32):
      %93 = "tt.descriptor_load"(%arg95, %arg104, %85) <{cache = 1 : i32, evict = 1 : i32}> : (!tt.tensordesc<tensor<64x128xf16>>, i32, i32) -> tensor<64x128xf16>
      %94 = "tensor.empty"() : () -> tensor<128x64xf16>
      %95 = "linalg.transpose"(%93, %94) <{permutation = array<i64: 1, 0>}> ({
      ^bb0(%arg152: f16, %arg153: f16):
        "linalg.yield"(%arg152) : (f16) -> ()
      }) : (tensor<64x128xf16>, tensor<128x64xf16>) -> tensor<128x64xf16>
      %96 = "tensor.empty"() : () -> tensor<128x64xf32>
      %97 = "linalg.fill"(%89, %96) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg150: f32, %arg151: f32):
        "linalg.yield"(%arg150) : (f32) -> ()
      }) : (f32, tensor<128x64xf32>) -> tensor<128x64xf32>
      %98 = "linalg.matmul"(%arg94, %95, %97) <{indexing_maps = [#map3, #map4, #map5], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg147: f16, %arg148: f16, %arg149: f32):
        %139 = "arith.extf"(%arg147) : (f16) -> f32
        %140 = "arith.extf"(%arg148) : (f16) -> f32
        %141 = "arith.mulf"(%139, %140) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %142 = "arith.addf"(%arg149, %141) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%142) : (f32) -> ()
      }) : (tensor<128x128xf16>, tensor<128x64xf16>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %99 = "func.call"(%98) <{callee = @triton.language.standard.max__fp32S128_64S_c1_cFalse_cTrue_cFalse}> : (tensor<128x64xf32>) -> tensor<128xf32>
      %100 = "tensor.empty"() : () -> tensor<128xf32>
      %101 = "linalg.fill"(%arg99, %100) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg145: f32, %arg146: f32):
        "linalg.yield"(%arg145) : (f32) -> ()
      }) : (f32, tensor<128xf32>) -> tensor<128xf32>
      %102 = "linalg.generic"(%99, %101, %99) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg142: f32, %arg143: f32, %arg144: f32):
        %138 = "arith.mulf"(%arg142, %arg143) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%138) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %103 = "linalg.generic"(%arg103, %102, %arg103) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg139: f32, %arg140: f32, %arg141: f32):
        %137 = "arith.maxnumf"(%arg139, %arg140) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%137) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %104 = "linalg.fill"(%arg99, %96) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg137: f32, %arg138: f32):
        "linalg.yield"(%arg137) : (f32) -> ()
      }) : (f32, tensor<128x64xf32>) -> tensor<128x64xf32>
      %105 = "linalg.generic"(%98, %104, %98) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg134: f32, %arg135: f32, %arg136: f32):
        %136 = "arith.mulf"(%arg134, %arg135) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%136) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %106 = "tensor.expand_shape"(%103) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %107 = "linalg.generic"(%106, %96) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg132: f32, %arg133: f32):
        "linalg.yield"(%arg132) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %108 = "linalg.generic"(%105, %107, %105) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg129: f32, %arg130: f32, %arg131: f32):
        %135 = "arith.subf"(%arg129, %arg130) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%135) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %109 = "linalg.generic"(%108, %108) <{indexing_maps = [#map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg127: f32, %arg128: f32):
        %134 = "math.exp2"(%arg127) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%134) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %110 = "linalg.generic"(%arg103, %103, %arg103) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg124: f32, %arg125: f32, %arg126: f32):
        %133 = "arith.subf"(%arg124, %arg125) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%133) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %111 = "linalg.generic"(%110, %110) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg122: f32, %arg123: f32):
        %132 = "math.exp2"(%arg122) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%132) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %112 = "func.call"(%109) <{callee = @triton.language.standard.sum__fp32S128_64S_c1_cFalse_cNone}> : (tensor<128x64xf32>) -> tensor<128xf32>
      %113 = "tensor.expand_shape"(%111) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %114 = "tensor.empty"() : () -> tensor<128x128xf32>
      %115 = "linalg.generic"(%113, %114) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg120: f32, %arg121: f32):
        "linalg.yield"(%arg120) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %116 = "linalg.generic"(%arg101, %115, %arg101) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg117: f32, %arg118: f32, %arg119: f32):
        %131 = "arith.mulf"(%arg117, %arg118) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%131) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %117 = "tt.descriptor_load"(%arg96, %arg105, %85) <{cache = 1 : i32, evict = 1 : i32}> : (!tt.tensordesc<tensor<64x128xf16>>, i32, i32) -> tensor<64x128xf16>
      %118 = "linalg.generic"(%109, %94) <{indexing_maps = [#map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg115: f32, %arg116: f16):
        %130 = "arith.truncf"(%arg115) : (f32) -> f16
        "linalg.yield"(%130) : (f16) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf16>) -> tensor<128x64xf16>
      %119 = "linalg.matmul"(%118, %117, %116) <{indexing_maps = [#map3, #map4, #map5], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg112: f16, %arg113: f16, %arg114: f32):
        %126 = "arith.extf"(%arg112) : (f16) -> f32
        %127 = "arith.extf"(%arg113) : (f16) -> f32
        %128 = "arith.mulf"(%126, %127) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %129 = "arith.addf"(%arg114, %128) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%129) : (f32) -> ()
      }) : (tensor<128x64xf16>, tensor<64x128xf16>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %120 = "linalg.generic"(%arg102, %111, %arg102) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg109: f32, %arg110: f32, %arg111: f32):
        %125 = "arith.mulf"(%arg109, %arg110) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%125) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %121 = "linalg.generic"(%120, %112, %120) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg106: f32, %arg107: f32, %arg108: f32):
        %124 = "arith.addf"(%arg106, %arg107) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%124) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %122 = "arith.addi"(%arg104, %86) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %123 = "arith.addi"(%arg105, %86) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%119, %121, %103, %122, %123) : (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32) -> ()
    }) : (index, index, index, tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32) -> (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32)
    "func.return"(%92#0, %92#1, %92#2) : (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<128x64xf32>) -> tensor<128xf32>, sym_name = "triton.language.standard.max__fp32S128_64S_c1_cFalse_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg88: tensor<128x64xf32>):
    %82 = "tt.reduce"(%arg88) <{axis = 1 : i32}> ({
    ^bb0(%arg89: f32, %arg90: f32):
      %83 = "func.call"(%arg89, %arg90) <{callee = @triton.language.standard._elementwise_max__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%83) : (f32) -> ()
    }) : (tensor<128x64xf32>) -> tensor<128xf32>
    "func.return"(%82) : (tensor<128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._elementwise_max__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg86: f32, %arg87: f32):
    %81 = "arith.maxnumf"(%arg86, %arg87) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%81) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<128x64xf32>) -> tensor<128xf32>, sym_name = "triton.language.standard.sum__fp32S128_64S_c1_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg83: tensor<128x64xf32>):
    %79 = "tt.reduce"(%arg83) <{axis = 1 : i32}> ({
    ^bb0(%arg84: f32, %arg85: f32):
      %80 = "func.call"(%arg84, %arg85) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%80) : (f32) -> ()
    }) : (tensor<128x64xf32>) -> tensor<128xf32>
    "func.return"(%79) : (tensor<128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg81: f32, %arg82: f32):
    %78 = "arith.addf"(%arg81, %arg82) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%78) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, tensor<128x128xf16>, !tt.tensordesc<tensor<64x128xf16>>, !tt.tensordesc<tensor<64x128xf16>>, i32, i32, f32, tensor<128xi32>, tensor<64xi32>) -> (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>), sym_name = "tutorials.06-fused-attention._attn_fwd_inner__fp32S128_128S_fp32S128S_fp32S128S_fp16S128_128S_TDfp16S64_128S_TDfp16S64_128S_i32_cfp16_i32_fp32_c128_c128_c64_c2_i32S128S_i32S64S_i32_cFalse_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<128x128xf32>, %arg1: tensor<128xf32>, %arg2: tensor<128xf32>, %arg3: tensor<128x128xf16>, %arg4: !tt.tensordesc<tensor<64x128xf16>>, %arg5: !tt.tensordesc<tensor<64x128xf16>>, %arg6: i32, %arg7: i32, %arg8: f32, %arg9: tensor<128xi32>, %arg10: tensor<64xi32>):
    %0 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "arith.constant"() <{value = 64 : index}> : () -> index
    %6 = "arith.constant"() <{value = -1.000000e+06 : f32}> : () -> f32
    %7 = "tensor.empty"() : () -> tensor<128x64xf32>
    %8 = "linalg.fill"(%6, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg79: f32, %arg80: f32):
      "linalg.yield"(%arg79) : (f32) -> ()
    }) : (f32, tensor<128x64xf32>) -> tensor<128x64xf32>
    %9 = "linalg.fill"(%4, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg77: f32, %arg78: f32):
      "linalg.yield"(%arg77) : (f32) -> ()
    }) : (f32, tensor<128x64xf32>) -> tensor<128x64xf32>
    %10 = "arith.muli"(%arg7, %0) <{overflowFlags = #arith.overflow<none>}> {tt.divisibility = dense<128> : tensor<1xi32>} : (i32, i32) -> i32
    %11 = "arith.addi"(%arg7, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %12 = "arith.muli"(%11, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %13 = "arith.addi"(%arg6, %10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %14 = "arith.index_cast"(%10) : (i32) -> index
    %15 = "arith.index_cast"(%12) : (i32) -> index
    %16:5 = "scf.for"(%14, %15, %5, %arg0, %arg1, %arg2, %13, %13) ({
    ^bb0(%arg11: index, %arg12: tensor<128x128xf32>, %arg13: tensor<128xf32>, %arg14: tensor<128xf32>, %arg15: i32, %arg16: i32):
      %17 = "arith.index_cast"(%arg11) : (index) -> i32
      %18 = "tt.descriptor_load"(%arg4, %arg15, %3) <{cache = 1 : i32, evict = 1 : i32}> : (!tt.tensordesc<tensor<64x128xf16>>, i32, i32) -> tensor<64x128xf16>
      %19 = "tensor.empty"() : () -> tensor<128x64xf16>
      %20 = "linalg.transpose"(%18, %19) <{permutation = array<i64: 1, 0>}> ({
      ^bb0(%arg75: f16, %arg76: f16):
        "linalg.yield"(%arg75) : (f16) -> ()
      }) : (tensor<64x128xf16>, tensor<128x64xf16>) -> tensor<128x64xf16>
      %21 = "linalg.matmul"(%arg3, %20, %9) <{indexing_maps = [#map3, #map4, #map5], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg72: f16, %arg73: f16, %arg74: f32):
        %74 = "arith.extf"(%arg72) : (f16) -> f32
        %75 = "arith.extf"(%arg73) : (f16) -> f32
        %76 = "arith.mulf"(%74, %75) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %77 = "arith.addf"(%arg74, %76) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%77) : (f32) -> ()
      }) : (tensor<128x128xf16>, tensor<128x64xf16>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %22 = "tensor.expand_shape"(%arg9) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xi32>) -> tensor<128x1xi32>
      %23 = "tensor.expand_shape"(%arg10) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 64>}> : (tensor<64xi32>) -> tensor<1x64xi32>
      %24 = "tensor.empty"() : () -> tensor<1x64xi32>
      %25 = "linalg.fill"(%17, %24) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg70: i32, %arg71: i32):
        "linalg.yield"(%arg70) : (i32) -> ()
      }) : (i32, tensor<1x64xi32>) -> tensor<1x64xi32>
      %26 = "linalg.generic"(%25, %23, %25) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg67: i32, %arg68: i32, %arg69: i32):
        %73 = "arith.addi"(%arg67, %arg68) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%73) : (i32) -> ()
      }) : (tensor<1x64xi32>, tensor<1x64xi32>, tensor<1x64xi32>) -> tensor<1x64xi32>
      %27 = "tensor.empty"() : () -> tensor<128x64xi32>
      %28 = "linalg.generic"(%22, %27) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg65: i32, %arg66: i32):
        "linalg.yield"(%arg65) : (i32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xi32>, tensor<128x64xi32>) -> tensor<128x64xi32>
      %29 = "linalg.generic"(%26, %27) <{indexing_maps = [#map6, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg63: i32, %arg64: i32):
        "linalg.yield"(%arg63) : (i32) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1x64xi32>, tensor<128x64xi32>) -> tensor<128x64xi32>
      %30 = "tensor.empty"() : () -> tensor<128x64xi1>
      %31 = "linalg.generic"(%28, %29, %30) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg60: i32, %arg61: i32, %arg62: i1):
        %72 = "arith.cmpi"(%arg60, %arg61) <{predicate = 5 : i64}> : (i32, i32) -> i1
        "linalg.yield"(%72) : (i1) -> ()
      }) : (tensor<128x64xi32>, tensor<128x64xi32>, tensor<128x64xi1>) -> tensor<128x64xi1>
      %32 = "linalg.fill"(%arg8, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg58: f32, %arg59: f32):
        "linalg.yield"(%arg58) : (f32) -> ()
      }) : (f32, tensor<128x64xf32>) -> tensor<128x64xf32>
      %33 = "linalg.generic"(%21, %32, %21) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg55: f32, %arg56: f32, %arg57: f32):
        %71 = "arith.mulf"(%arg55, %arg56) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%71) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %34 = "linalg.generic"(%31, %9, %8, %9) <{indexing_maps = [#map2, #map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg51: i1, %arg52: f32, %arg53: f32, %arg54: f32):
        %70 = "arith.select"(%arg51, %arg52, %arg53) : (i1, f32, f32) -> f32
        "linalg.yield"(%70) : (f32) -> ()
      }) : (tensor<128x64xi1>, tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %35 = "linalg.generic"(%33, %34, %33) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg48: f32, %arg49: f32, %arg50: f32):
        %69 = "arith.addf"(%arg48, %arg49) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%69) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %36 = "func.call"(%35) <{callee = @triton.language.standard.max__fp32S128_64S_c1_cFalse_cTrue_cFalse}> : (tensor<128x64xf32>) -> tensor<128xf32>
      %37 = "linalg.generic"(%arg14, %36, %arg14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg45: f32, %arg46: f32, %arg47: f32):
        %68 = "arith.maxnumf"(%arg45, %arg46) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%68) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %38 = "tensor.expand_shape"(%37) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %39 = "linalg.generic"(%38, %7) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg43: f32, %arg44: f32):
        "linalg.yield"(%arg43) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %40 = "linalg.generic"(%35, %39, %35) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg40: f32, %arg41: f32, %arg42: f32):
        %67 = "arith.subf"(%arg40, %arg41) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%67) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %41 = "linalg.generic"(%40, %40) <{indexing_maps = [#map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg38: f32, %arg39: f32):
        %66 = "math.exp2"(%arg38) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%66) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %42 = "linalg.generic"(%arg14, %37, %arg14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg35: f32, %arg36: f32, %arg37: f32):
        %65 = "arith.subf"(%arg35, %arg36) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%65) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %43 = "linalg.generic"(%42, %42) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg33: f32, %arg34: f32):
        %64 = "math.exp2"(%arg33) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%64) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %44 = "func.call"(%41) <{callee = @triton.language.standard.sum__fp32S128_64S_c1_cFalse_cNone}> : (tensor<128x64xf32>) -> tensor<128xf32>
      %45 = "tensor.expand_shape"(%43) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %46 = "tensor.empty"() : () -> tensor<128x128xf32>
      %47 = "linalg.generic"(%45, %46) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg31: f32, %arg32: f32):
        "linalg.yield"(%arg31) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %48 = "linalg.generic"(%arg12, %47, %arg12) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg28: f32, %arg29: f32, %arg30: f32):
        %63 = "arith.mulf"(%arg28, %arg29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%63) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %49 = "tt.descriptor_load"(%arg5, %arg16, %3) <{cache = 1 : i32, evict = 1 : i32}> : (!tt.tensordesc<tensor<64x128xf16>>, i32, i32) -> tensor<64x128xf16>
      %50 = "linalg.generic"(%41, %19) <{indexing_maps = [#map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg26: f32, %arg27: f16):
        %62 = "arith.truncf"(%arg26) : (f32) -> f16
        "linalg.yield"(%62) : (f16) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf16>) -> tensor<128x64xf16>
      %51 = "linalg.matmul"(%50, %49, %48) <{indexing_maps = [#map3, #map4, #map5], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg23: f16, %arg24: f16, %arg25: f32):
        %58 = "arith.extf"(%arg23) : (f16) -> f32
        %59 = "arith.extf"(%arg24) : (f16) -> f32
        %60 = "arith.mulf"(%58, %59) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %61 = "arith.addf"(%arg25, %60) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%61) : (f32) -> ()
      }) : (tensor<128x64xf16>, tensor<64x128xf16>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %52 = "linalg.generic"(%arg13, %43, %arg13) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg20: f32, %arg21: f32, %arg22: f32):
        %57 = "arith.mulf"(%arg20, %arg21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%57) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %53 = "linalg.generic"(%52, %44, %52) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg17: f32, %arg18: f32, %arg19: f32):
        %56 = "arith.addf"(%arg17, %arg18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%56) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %54 = "arith.addi"(%arg15, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %55 = "arith.addi"(%arg16, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%51, %53, %37, %54, %55) : (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32) -> ()
    }) : (index, index, index, tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32) -> (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32)
    "func.return"(%16#0, %16#1, %16#2) : (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

