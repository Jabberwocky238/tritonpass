#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1) -> (d0, 0)>
#map3 = affine_map<(d0, d1) -> (0, d1)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map6 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, memref<?xi32>, memref<?xi32>, f32, memref<?xf32>, memref<?xf32>, f32, f32, i64, i64, i64, i64, i64, i64, memref<?xi32>, i64, i64, i64, i64, i64, i64, memref<?xi32>, i32) -> (), sym_name = "kernel_unified_attention"}> ({
  ^bb0(%arg76: memref<?xbf16>, %arg77: memref<?xbf16>, %arg78: memref<?xbf16>, %arg79: memref<?xbf16>, %arg80: memref<?xi32>, %arg81: memref<?xi32>, %arg82: f32, %arg83: memref<?xf32>, %arg84: memref<?xf32>, %arg85: f32, %arg86: f32, %arg87: i64, %arg88: i64, %arg89: i64, %arg90: i64, %arg91: i64, %arg92: i64, %arg93: memref<?xi32>, %arg94: i64, %arg95: i64, %arg96: i64, %arg97: i64, %arg98: i64, %arg99: i64, %arg100: memref<?xi32>, %arg101: i32):
    %103 = "arith.constant"() <{value = 32 : index}> : () -> index
    %104 = "arith.constant"() <{value = 1 : index}> : () -> index
    %105 = "arith.constant"() <{value = 4 : index}> : () -> index
    %106 = "arith.constant"() <{value = 0 : index}> : () -> index
    %107 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %108 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %109 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %110 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %111 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %112 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %113 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %114 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %115 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %116 = "builtin.unrealized_conversion_cast"(%arg79) : (memref<?xbf16>) -> !tt.ptr<bf16>
    %117 = "builtin.unrealized_conversion_cast"(%arg78) : (memref<?xbf16>) -> !tt.ptr<bf16>
    %118 = "tensor.empty"() : () -> tensor<32x128xbf16>
    %119 = "linalg.fill"(%107, %118) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg319: bf16, %arg320: bf16):
      "linalg.yield"(%arg319) : (bf16) -> ()
    }) : (bf16, tensor<32x128xbf16>) -> tensor<32x128xbf16>
    %120 = "tensor.empty"() : () -> tensor<128x32xbf16>
    %121 = "linalg.fill"(%107, %120) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg317: bf16, %arg318: bf16):
      "linalg.yield"(%arg317) : (bf16) -> ()
    }) : (bf16, tensor<128x32xbf16>) -> tensor<128x32xbf16>
    %122 = "tensor.empty"() : () -> tensor<16x32xf32>
    %123 = "linalg.fill"(%109, %122) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg315: f32, %arg316: f32):
      "linalg.yield"(%arg315) : (f32) -> ()
    }) : (f32, tensor<16x32xf32>) -> tensor<16x32xf32>
    %124 = "tensor.empty"() : () -> tensor<32xi32>
    %125 = "linalg.fill"(%111, %124) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg313: i32, %arg314: i32):
      "linalg.yield"(%arg313) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %126 = "tensor.empty"() : () -> tensor<16xf32>
    %127 = "linalg.fill"(%112, %126) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg311: f32, %arg312: f32):
      "linalg.yield"(%arg311) : (f32) -> ()
    }) : (f32, tensor<16xf32>) -> tensor<16xf32>
    %128 = "tensor.empty"() : () -> tensor<16xi32>
    %129 = "linalg.fill"(%113, %128) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg309: i32, %arg310: i32):
      "linalg.yield"(%arg309) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %130 = "linalg.fill"(%108, %128) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg307: i32, %arg308: i32):
      "linalg.yield"(%arg307) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %131 = "linalg.fill"(%114, %128) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg305: i32, %arg306: i32):
      "linalg.yield"(%arg305) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %132 = "linalg.fill"(%115, %128) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg303: i32, %arg304: i32):
      "linalg.yield"(%arg303) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %133 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %134 = "arith.index_cast"(%133) : (index) -> i32
    %135 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %136 = "arith.index_cast"(%135) : (index) -> i32
    %137:5 = "func.call"(%arg100, %arg81, %134, %arg101) <{callee = @vllm.v1.attention.ops.triton_attention_helpers.resolve_seq_and_query_len__Pi32_Pi32_i32_i32_c4}> : (memref<?xi32>, memref<?xi32>, i32, i32) -> (i32, i32, i32, i32, i32)
    %138 = "arith.muli"(%137#1, %115) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %139 = "arith.cmpi"(%138, %137#3) <{predicate = 5 : i64}> : (i32, i32) -> i1
    "cf.cond_br"(%139)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    %140 = "linalg.generic"(%128) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg302: i32):
      %376 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %377 = "arith.index_cast"(%376) : (index) -> i32
      "linalg.yield"(%377) : (i32) -> ()
    }) : (tensor<16xi32>) -> tensor<16xi32>
    %141 = "tensor.empty"() : () -> tensor<128xi32>
    %142 = "linalg.generic"(%141) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg301: i32):
      %374 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %375 = "arith.index_cast"(%374) : (index) -> i32
      "linalg.yield"(%375) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %143 = "linalg.generic"(%124) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg300: i32):
      %372 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %373 = "arith.index_cast"(%372) : (index) -> i32
      "linalg.yield"(%373) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %144 = "linalg.generic"(%140, %132, %140) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg297: i32, %arg298: i32, %arg299: i32):
      %371 = "arith.divsi"(%arg297, %arg298) : (i32, i32) -> i32
      "linalg.yield"(%371) : (i32) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %145 = "linalg.fill"(%138, %128) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg295: i32, %arg296: i32):
      "linalg.yield"(%arg295) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %146 = "linalg.generic"(%145, %144, %145) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg292: i32, %arg293: i32, %arg294: i32):
      %370 = "arith.addi"(%arg292, %arg293) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%370) : (i32) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %147 = "arith.muli"(%136, %115) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %148 = "linalg.generic"(%140, %132, %140) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg289: i32, %arg290: i32, %arg291: i32):
      %369 = "arith.remsi"(%arg289, %arg290) : (i32, i32) -> i32
      "linalg.yield"(%369) : (i32) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %149 = "linalg.fill"(%147, %128) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg287: i32, %arg288: i32):
      "linalg.yield"(%arg287) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %150 = "linalg.generic"(%149, %148, %149) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg284: i32, %arg285: i32, %arg286: i32):
      %368 = "arith.addi"(%arg284, %arg285) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%368) : (i32) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %151 = "tensor.expand_shape"(%142) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xi32>) -> tensor<1x128xi32>
    %152 = "tensor.empty"() : () -> tensor<1x128xi64>
    %153 = "linalg.generic"(%151, %152) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg282: i32, %arg283: i64):
      %367 = "arith.extsi"(%arg282) : (i32) -> i64
      "linalg.yield"(%367) : (i64) -> ()
    }) : (tensor<1x128xi32>, tensor<1x128xi64>) -> tensor<1x128xi64>
    %154 = "linalg.fill"(%137#3, %128) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg280: i32, %arg281: i32):
      "linalg.yield"(%arg280) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %155 = "tensor.empty"() : () -> tensor<16xi1>
    %156 = "linalg.generic"(%146, %154, %155) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg277: i32, %arg278: i32, %arg279: i1):
      %366 = "arith.cmpi"(%arg277, %arg278) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%366) : (i1) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi1>) -> tensor<16xi1>
    %157 = "linalg.generic"(%156, %131, %130, %131) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg273: i1, %arg274: i32, %arg275: i32, %arg276: i32):
      %365 = "arith.select"(%arg273, %arg274, %arg275) : (i1, i32, i32) -> i32
      "linalg.yield"(%365) : (i32) -> ()
    }) : (tensor<16xi1>, tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %158 = "linalg.generic"(%157, %130, %155) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg270: i32, %arg271: i32, %arg272: i1):
      %364 = "arith.cmpi"(%arg270, %arg271) <{predicate = 1 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%364) : (i1) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi1>) -> tensor<16xi1>
    %159 = "linalg.generic"(%150, %129, %155) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg267: i32, %arg268: i32, %arg269: i1):
      %363 = "arith.cmpi"(%arg267, %arg268) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%363) : (i1) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi1>) -> tensor<16xi1>
    %160 = "linalg.generic"(%159, %131, %130, %131) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg263: i1, %arg264: i32, %arg265: i32, %arg266: i32):
      %362 = "arith.select"(%arg263, %arg264, %arg265) : (i1, i32, i32) -> i32
      "linalg.yield"(%362) : (i32) -> ()
    }) : (tensor<16xi1>, tensor<16xi32>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %161 = "linalg.generic"(%160, %130, %155) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg260: i32, %arg261: i32, %arg262: i1):
      %361 = "arith.cmpi"(%arg260, %arg261) <{predicate = 1 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%361) : (i1) -> ()
    }) : (tensor<16xi32>, tensor<16xi32>, tensor<16xi1>) -> tensor<16xi1>
    %162 = "arith.extsi"(%137#2) : (i32) -> i64
    %163 = "arith.muli"(%162, %arg88) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %164 = "arith.extsi"(%138) : (i32) -> i64
    %165 = "arith.muli"(%164, %arg88) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %166 = "arith.addi"(%163, %165) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %167 = "arith.extsi"(%147) : (i32) -> i64
    %168 = "arith.muli"(%167, %arg89) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %169 = "arith.addi"(%166, %168) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %170 = "arith.index_cast"(%169) : (i64) -> index
    %171 = "arith.subi"(%108, %137#3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %172 = "arith.addi"(%138, %171) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %173 = "arith.subi"(%108, %172) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %174 = "arith.subi"(%113, %147) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %175 = "arith.index_cast"(%arg88) : (i64) -> index
    %176 = "arith.index_cast"(%arg89) : (i64) -> index
    %177 = "memref.reinterpret_cast"(%arg77, %175, %176) <{operandSegmentSizes = array<i32: 1, 0, 0, 2>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, 1>}> : (memref<?xbf16>, index, index) -> memref<1099511627776x1099511627776x1099511627776xbf16, strided<[?, ?, 1]>>
    %178 = "arith.index_cast"(%173) : (i32) -> index
    %179 = "arith.minsi"(%178, %105) : (index, index) -> index
    %180 = "arith.maxsi"(%179, %106) : (index, index) -> index
    %181 = "arith.index_cast"(%174) : (i32) -> index
    %182 = "arith.minsi"(%181, %105) : (index, index) -> index
    %183 = "arith.maxsi"(%182, %106) : (index, index) -> index
    %184 = "arith.minsi"(%180, %105) : (index, index) -> index
    %185 = "arith.minsi"(%183, %105) : (index, index) -> index
    %186 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x4x128xbf16>
    "linalg.fill"(%107, %186) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg258: bf16, %arg259: bf16):
      "linalg.yield"(%arg258) : (bf16) -> ()
    }) : (bf16, memref<4x4x128xbf16>) -> ()
    %187 = "memref.subview"(%177, %170, %184, %185) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: 0, 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, 128>, static_strides = array<i64: 1, 1, 1>}> : (memref<1099511627776x1099511627776x1099511627776xbf16, strided<[?, ?, 1]>>, index, index, index) -> memref<?x?x128xbf16, strided<[?, ?, 1], offset: ?>>
    %188 = "memref.subview"(%186, %184, %185) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, 128>, static_strides = array<i64: 1, 1, 1>}> : (memref<4x4x128xbf16>, index, index) -> memref<?x?x128xbf16, strided<[512, 128, 1]>>
    "linalg.copy"(%187, %188) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg256: bf16, %arg257: bf16):
      "linalg.yield"(%arg256) : (bf16) -> ()
    }) : (memref<?x?x128xbf16, strided<[?, ?, 1], offset: ?>>, memref<?x?x128xbf16, strided<[512, 128, 1]>>) -> ()
    %189 = "bufferization.to_tensor"(%186) <{restrict, writable}> : (memref<4x4x128xbf16>) -> tensor<4x4x128xbf16>
    %190 = "tensor.collapse_shape"(%189) <{reassociation = [[0, 1], [2]]}> : (tensor<4x4x128xbf16>) -> tensor<16x128xbf16>
    %191 = "arith.extsi"(%137#0) : (i32) -> i64
    %192 = "arith.muli"(%191, %arg87) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %193 = "arith.index_cast"(%192) : (i64) -> index
    %194 = "func.call"() <{callee = @vllm.v1.attention.ops.triton_attention_helpers.init_softmax_M__cNone_i32S16S_u1S16S_i32_c16_cFalse_cFalse}> : () -> tensor<16xf32>
    %195 = "func.call"() <{callee = @triton.language.standard.zeros__Tc16_c128T_cfp32}> : () -> tensor<16x128xf32>
    %196 = "arith.subi"(%137#4, %137#3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %197:3 = "func.call"(%196, %137#4, %137#1) <{callee = @"vllm.v1.attention.ops.triton_attention_helpers.compute_tile_loop_bounds__i32_i32_i32_i32_i32_i32_c32_c16_c4_c4_c0_cFalse_cFalse_cTrue_cFalse_c-1_c-1_cFalse_cFalse_c0_cNone_i32"}> : (i32, i32, i32) -> (i32, i32, i32)
    %198 = "arith.index_cast"(%197#0) : (i32) -> index
    %199 = "arith.index_cast"(%197#1) : (i32) -> index
    %200:3 = "scf.for"(%198, %199, %104, %194, %127, %195) ({
    ^bb0(%arg109: index, %arg110: tensor<16xf32>, %arg111: tensor<16xf32>, %arg112: tensor<16x128xf32>):
      %221 = "arith.index_cast"(%arg109) : (index) -> i32
      %222 = "arith.muli"(%221, %113) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %223 = "linalg.fill"(%222, %124) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg254: i32, %arg255: i32):
        "linalg.yield"(%arg254) : (i32) -> ()
      }) : (i32, tensor<32xi32>) -> tensor<32xi32>
      %224 = "linalg.generic"(%223, %143, %223) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg251: i32, %arg252: i32, %arg253: i32):
        %360 = "arith.addi"(%arg251, %arg252) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%360) : (i32) -> ()
      }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
      %225 = "linalg.fill"(%197#2, %124) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg249: i32, %arg250: i32):
        "linalg.yield"(%arg249) : (i32) -> ()
      }) : (i32, tensor<32xi32>) -> tensor<32xi32>
      %226 = "tensor.empty"() : () -> tensor<32xi1>
      %227 = "linalg.generic"(%224, %225, %226) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg246: i32, %arg247: i32, %arg248: i1):
        %359 = "arith.cmpi"(%arg246, %arg247) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "linalg.yield"(%359) : (i1) -> ()
      }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
      %228 = "linalg.generic"(%224, %125, %224) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg243: i32, %arg244: i32, %arg245: i32):
        %358 = "arith.divsi"(%arg243, %arg244) : (i32, i32) -> i32
        "linalg.yield"(%358) : (i32) -> ()
      }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
      %229 = "arith.index_cast"(%193) : (index) -> i32
      %230 = "linalg.fill"(%229, %124) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg241: i32, %arg242: i32):
        "linalg.yield"(%arg241) : (i32) -> ()
      }) : (i32, tensor<32xi32>) -> tensor<32xi32>
      %231 = "linalg.generic"(%230, %228, %230) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg238: i32, %arg239: i32, %arg240: i32):
        %357 = "arith.addi"(%arg238, %arg239) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%357) : (i32) -> ()
      }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
      %232 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32xi32>
      "scf.for"(%106, %103, %104) ({
      ^bb0(%arg237: index):
        %353 = "tensor.extract"(%231, %arg237) : (tensor<32xi32>, index) -> i32
        %354 = "arith.index_cast"(%353) : (i32) -> index
        %355 = "memref.reinterpret_cast"(%arg80, %354) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
        %356 = "memref.subview"(%232, %arg237) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<32xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
        "memref.copy"(%355, %356) : (memref<1xi32, strided<[1], offset: ?>>, memref<1xi32, strided<[1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      %233 = "bufferization.to_tensor"(%232) <{restrict, writable}> : (memref<32xi32>) -> tensor<32xi32>
      %234 = "tensor.empty"() : () -> tensor<32xi64>
      %235 = "linalg.generic"(%233, %234) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg235: i32, %arg236: i64):
        %352 = "arith.extsi"(%arg235) : (i32) -> i64
        "linalg.yield"(%352) : (i64) -> ()
      }) : (tensor<32xi32>, tensor<32xi64>) -> tensor<32xi64>
      %236 = "tensor.expand_shape"(%235) <{reassociation = [[0, 1]], static_output_shape = array<i64: 32, 1>}> : (tensor<32xi64>) -> tensor<32x1xi64>
      %237 = "tensor.empty"() : () -> tensor<32x1xi64>
      %238 = "linalg.fill"(%arg97, %237) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg233: i64, %arg234: i64):
        "linalg.yield"(%arg233) : (i64) -> ()
      }) : (i64, tensor<32x1xi64>) -> tensor<32x1xi64>
      %239 = "linalg.generic"(%236, %238, %236) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg230: i64, %arg231: i64, %arg232: i64):
        %351 = "arith.muli"(%arg230, %arg231) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%351) : (i64) -> ()
      }) : (tensor<32x1xi64>, tensor<32x1xi64>, tensor<32x1xi64>) -> tensor<32x1xi64>
      %240 = "arith.extsi"(%136) : (i32) -> i64
      %241 = "arith.muli"(%240, %arg99) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %242 = "linalg.fill"(%241, %237) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg228: i64, %arg229: i64):
        "linalg.yield"(%arg228) : (i64) -> ()
      }) : (i64, tensor<32x1xi64>) -> tensor<32x1xi64>
      %243 = "linalg.generic"(%239, %242, %239) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg225: i64, %arg226: i64, %arg227: i64):
        %350 = "arith.addi"(%arg225, %arg226) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%350) : (i64) -> ()
      }) : (tensor<32x1xi64>, tensor<32x1xi64>, tensor<32x1xi64>) -> tensor<32x1xi64>
      %244 = "tensor.empty"() : () -> tensor<32x128xi64>
      %245 = "linalg.generic"(%243, %244) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg223: i64, %arg224: i64):
        "linalg.yield"(%arg223) : (i64) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<32x1xi64>, tensor<32x128xi64>) -> tensor<32x128xi64>
      %246 = "linalg.generic"(%153, %244) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg221: i64, %arg222: i64):
        "linalg.yield"(%arg221) : (i64) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1x128xi64>, tensor<32x128xi64>) -> tensor<32x128xi64>
      %247 = "linalg.generic"(%245, %246, %245) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg218: i64, %arg219: i64, %arg220: i64):
        %349 = "arith.addi"(%arg218, %arg219) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%349) : (i64) -> ()
      }) : (tensor<32x128xi64>, tensor<32x128xi64>, tensor<32x128xi64>) -> tensor<32x128xi64>
      %248 = "linalg.generic"(%224, %125, %224) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg215: i32, %arg216: i32, %arg217: i32):
        %348 = "arith.remsi"(%arg215, %arg216) : (i32, i32) -> i32
        "linalg.yield"(%348) : (i32) -> ()
      }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
      %249 = "tensor.expand_shape"(%248) <{reassociation = [[0, 1]], static_output_shape = array<i64: 32, 1>}> : (tensor<32xi32>) -> tensor<32x1xi32>
      %250 = "linalg.generic"(%249, %237) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg213: i32, %arg214: i64):
        %347 = "arith.extsi"(%arg213) : (i32) -> i64
        "linalg.yield"(%347) : (i64) -> ()
      }) : (tensor<32x1xi32>, tensor<32x1xi64>) -> tensor<32x1xi64>
      %251 = "linalg.fill"(%arg98, %237) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg211: i64, %arg212: i64):
        "linalg.yield"(%arg211) : (i64) -> ()
      }) : (i64, tensor<32x1xi64>) -> tensor<32x1xi64>
      %252 = "linalg.generic"(%250, %251, %250) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg208: i64, %arg209: i64, %arg210: i64):
        %346 = "arith.muli"(%arg208, %arg209) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%346) : (i64) -> ()
      }) : (tensor<32x1xi64>, tensor<32x1xi64>, tensor<32x1xi64>) -> tensor<32x1xi64>
      %253 = "linalg.generic"(%252, %244) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg206: i64, %arg207: i64):
        "linalg.yield"(%arg206) : (i64) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<32x1xi64>, tensor<32x128xi64>) -> tensor<32x128xi64>
      %254 = "linalg.generic"(%247, %253, %247) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg203: i64, %arg204: i64, %arg205: i64):
        %345 = "arith.addi"(%arg203, %arg204) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%345) : (i64) -> ()
      }) : (tensor<32x128xi64>, tensor<32x128xi64>, tensor<32x128xi64>) -> tensor<32x128xi64>
      %255 = "tensor.expand_shape"(%235) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 32>}> : (tensor<32xi64>) -> tensor<1x32xi64>
      %256 = "tensor.empty"() : () -> tensor<1x32xi64>
      %257 = "linalg.fill"(%arg94, %256) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg201: i64, %arg202: i64):
        "linalg.yield"(%arg201) : (i64) -> ()
      }) : (i64, tensor<1x32xi64>) -> tensor<1x32xi64>
      %258 = "linalg.generic"(%255, %257, %255) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg198: i64, %arg199: i64, %arg200: i64):
        %344 = "arith.muli"(%arg198, %arg199) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%344) : (i64) -> ()
      }) : (tensor<1x32xi64>, tensor<1x32xi64>, tensor<1x32xi64>) -> tensor<1x32xi64>
      %259 = "arith.muli"(%240, %arg96) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %260 = "linalg.fill"(%259, %256) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg196: i64, %arg197: i64):
        "linalg.yield"(%arg196) : (i64) -> ()
      }) : (i64, tensor<1x32xi64>) -> tensor<1x32xi64>
      %261 = "linalg.generic"(%258, %260, %258) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg193: i64, %arg194: i64, %arg195: i64):
        %343 = "arith.addi"(%arg193, %arg194) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%343) : (i64) -> ()
      }) : (tensor<1x32xi64>, tensor<1x32xi64>, tensor<1x32xi64>) -> tensor<1x32xi64>
      %262 = "tensor.expand_shape"(%142) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xi32>) -> tensor<128x1xi32>
      %263 = "tensor.empty"() : () -> tensor<128x1xi64>
      %264 = "linalg.generic"(%262, %263) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg191: i32, %arg192: i64):
        %342 = "arith.extsi"(%arg191) : (i32) -> i64
        "linalg.yield"(%342) : (i64) -> ()
      }) : (tensor<128x1xi32>, tensor<128x1xi64>) -> tensor<128x1xi64>
      %265 = "tensor.empty"() : () -> tensor<128x32xi64>
      %266 = "linalg.generic"(%261, %265) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg189: i64, %arg190: i64):
        "linalg.yield"(%arg189) : (i64) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1x32xi64>, tensor<128x32xi64>) -> tensor<128x32xi64>
      %267 = "linalg.generic"(%264, %265) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg187: i64, %arg188: i64):
        "linalg.yield"(%arg187) : (i64) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xi64>, tensor<128x32xi64>) -> tensor<128x32xi64>
      %268 = "linalg.generic"(%266, %267, %266) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg184: i64, %arg185: i64, %arg186: i64):
        %341 = "arith.addi"(%arg184, %arg185) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%341) : (i64) -> ()
      }) : (tensor<128x32xi64>, tensor<128x32xi64>, tensor<128x32xi64>) -> tensor<128x32xi64>
      %269 = "tensor.expand_shape"(%248) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 32>}> : (tensor<32xi32>) -> tensor<1x32xi32>
      %270 = "linalg.generic"(%269, %256) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg182: i32, %arg183: i64):
        %340 = "arith.extsi"(%arg182) : (i32) -> i64
        "linalg.yield"(%340) : (i64) -> ()
      }) : (tensor<1x32xi32>, tensor<1x32xi64>) -> tensor<1x32xi64>
      %271 = "linalg.fill"(%arg95, %256) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg180: i64, %arg181: i64):
        "linalg.yield"(%arg180) : (i64) -> ()
      }) : (i64, tensor<1x32xi64>) -> tensor<1x32xi64>
      %272 = "linalg.generic"(%270, %271, %270) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg177: i64, %arg178: i64, %arg179: i64):
        %339 = "arith.muli"(%arg177, %arg178) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%339) : (i64) -> ()
      }) : (tensor<1x32xi64>, tensor<1x32xi64>, tensor<1x32xi64>) -> tensor<1x32xi64>
      %273 = "linalg.generic"(%272, %265) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg175: i64, %arg176: i64):
        "linalg.yield"(%arg175) : (i64) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1x32xi64>, tensor<128x32xi64>) -> tensor<128x32xi64>
      %274 = "linalg.generic"(%268, %273, %268) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg172: i64, %arg173: i64, %arg174: i64):
        %338 = "arith.addi"(%arg172, %arg173) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        "linalg.yield"(%338) : (i64) -> ()
      }) : (tensor<128x32xi64>, tensor<128x32xi64>, tensor<128x32xi64>) -> tensor<128x32xi64>
      %275 = "tensor.expand_shape"(%227) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 32>}> : (tensor<32xi1>) -> tensor<1x32xi1>
      %276 = "tensor.empty"() : () -> tensor<128x32xi1>
      %277 = "linalg.generic"(%275, %276) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg170: i1, %arg171: i1):
        "linalg.yield"(%arg170) : (i1) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1x32xi1>, tensor<128x32xi1>) -> tensor<128x32xi1>
      %278 = "tensor.empty"() : () -> tensor<128x32x!tt.ptr<bf16>>
      %279 = "linalg.fill"(%117, %278) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg168: !tt.ptr<bf16>, %arg169: !tt.ptr<bf16>):
        "linalg.yield"(%arg168) : (!tt.ptr<bf16>) -> ()
      }) : (!tt.ptr<bf16>, tensor<128x32x!tt.ptr<bf16>>) -> tensor<128x32x!tt.ptr<bf16>>
      %280 = "linalg.generic"(%279, %274, %279) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg165: !tt.ptr<bf16>, %arg166: i64, %arg167: !tt.ptr<bf16>):
        %337 = "tt.addptr"(%arg165, %arg166) : (!tt.ptr<bf16>, i64) -> !tt.ptr<bf16>
        "linalg.yield"(%337) : (!tt.ptr<bf16>) -> ()
      }) : (tensor<128x32x!tt.ptr<bf16>>, tensor<128x32xi64>, tensor<128x32x!tt.ptr<bf16>>) -> tensor<128x32x!tt.ptr<bf16>>
      %281 = "tt.load"(%280, %277, %121) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<128x32x!tt.ptr<bf16>>, tensor<128x32xi1>, tensor<128x32xbf16>) -> tensor<128x32xbf16>
      %282 = "tensor.expand_shape"(%227) <{reassociation = [[0, 1]], static_output_shape = array<i64: 32, 1>}> : (tensor<32xi1>) -> tensor<32x1xi1>
      %283 = "tensor.empty"() : () -> tensor<32x128xi1>
      %284 = "linalg.generic"(%282, %283) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg163: i1, %arg164: i1):
        "linalg.yield"(%arg163) : (i1) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<32x1xi1>, tensor<32x128xi1>) -> tensor<32x128xi1>
      %285 = "tensor.empty"() : () -> tensor<32x128x!tt.ptr<bf16>>
      %286 = "linalg.fill"(%116, %285) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg161: !tt.ptr<bf16>, %arg162: !tt.ptr<bf16>):
        "linalg.yield"(%arg161) : (!tt.ptr<bf16>) -> ()
      }) : (!tt.ptr<bf16>, tensor<32x128x!tt.ptr<bf16>>) -> tensor<32x128x!tt.ptr<bf16>>
      %287 = "linalg.generic"(%286, %254, %286) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg158: !tt.ptr<bf16>, %arg159: i64, %arg160: !tt.ptr<bf16>):
        %336 = "tt.addptr"(%arg158, %arg159) : (!tt.ptr<bf16>, i64) -> !tt.ptr<bf16>
        "linalg.yield"(%336) : (!tt.ptr<bf16>) -> ()
      }) : (tensor<32x128x!tt.ptr<bf16>>, tensor<32x128xi64>, tensor<32x128x!tt.ptr<bf16>>) -> tensor<32x128x!tt.ptr<bf16>>
      %288 = "tt.load"(%287, %284, %119) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<32x128x!tt.ptr<bf16>>, tensor<32x128xi1>, tensor<32x128xbf16>) -> tensor<32x128xbf16>
      %289 = "func.call"(%281) <{callee = @vllm.v1.attention.ops.triton_unified_attention._cast_kv_tile__bf16S128_32S_bf16S16_128S_Pfp32_c0}> : (tensor<128x32xbf16>) -> tensor<128x32xbf16>
      %290 = "func.call"(%288) <{callee = @vllm.v1.attention.ops.triton_unified_attention._cast_kv_tile__bf16S32_128S_bf16S16_128S_Pfp32_c0}> : (tensor<32x128xbf16>) -> tensor<32x128xbf16>
      %291 = "tensor.expand_shape"(%146) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xi32>) -> tensor<16x1xi32>
      %292 = "tensor.empty"() : () -> tensor<16x1xi32>
      %293 = "linalg.fill"(%196, %292) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg156: i32, %arg157: i32):
        "linalg.yield"(%arg156) : (i32) -> ()
      }) : (i32, tensor<16x1xi32>) -> tensor<16x1xi32>
      %294 = "linalg.generic"(%293, %291, %293) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg153: i32, %arg154: i32, %arg155: i32):
        %335 = "arith.addi"(%arg153, %arg154) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%335) : (i32) -> ()
      }) : (tensor<16x1xi32>, tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
      %295 = "func.call"(%294, %224) <{callee = @"vllm.v1.attention.ops.triton_attention_helpers.compute_kv_seq_mask__i32S16_1S_i32S32S_i32_i32_cNone_c0_cFalse_c0_cTrue_cFalse_cNone_Pi32_c0_cFalse_c-1_c-1_cFalse"}> : (tensor<16x1xi32>, tensor<32xi32>) -> tensor<16x32xi1>
      %296 = "func.call"() <{callee = @triton.language.standard.zeros__Tc16_c32T_cfp32}> : () -> tensor<16x32xf32>
      %297 = "linalg.fill"(%110, %122) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg151: f32, %arg152: f32):
        "linalg.yield"(%arg151) : (f32) -> ()
      }) : (f32, tensor<16x32xf32>) -> tensor<16x32xf32>
      %298 = "linalg.matmul"(%190, %289, %297) <{indexing_maps = [#map4, #map5, #map6], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg148: bf16, %arg149: bf16, %arg150: f32):
        %331 = "arith.extf"(%arg148) : (bf16) -> f32
        %332 = "arith.extf"(%arg149) : (bf16) -> f32
        %333 = "arith.mulf"(%331, %332) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %334 = "arith.addf"(%arg150, %333) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%334) : (f32) -> ()
      }) : (tensor<16x128xbf16>, tensor<128x32xbf16>, tensor<16x32xf32>) -> tensor<16x32xf32>
      %299 = "linalg.fill"(%arg82, %122) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg146: f32, %arg147: f32):
        "linalg.yield"(%arg146) : (f32) -> ()
      }) : (f32, tensor<16x32xf32>) -> tensor<16x32xf32>
      %300 = "linalg.generic"(%299, %298, %299) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg143: f32, %arg144: f32, %arg145: f32):
        %330 = "arith.mulf"(%arg143, %arg144) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%330) : (f32) -> ()
      }) : (tensor<16x32xf32>, tensor<16x32xf32>, tensor<16x32xf32>) -> tensor<16x32xf32>
      %301 = "linalg.generic"(%296, %300, %296) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg140: f32, %arg141: f32, %arg142: f32):
        %329 = "arith.addf"(%arg140, %arg141) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%329) : (f32) -> ()
      }) : (tensor<16x32xf32>, tensor<16x32xf32>, tensor<16x32xf32>) -> tensor<16x32xf32>
      %302 = "tensor.expand_shape"(%161) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xi1>) -> tensor<16x1xi1>
      %303 = "tensor.expand_shape"(%158) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xi1>) -> tensor<16x1xi1>
      %304 = "linalg.generic"(%302, %303, %302) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg137: i1, %arg138: i1, %arg139: i1):
        %328 = "arith.andi"(%arg137, %arg138) : (i1, i1) -> i1
        "linalg.yield"(%328) : (i1) -> ()
      }) : (tensor<16x1xi1>, tensor<16x1xi1>, tensor<16x1xi1>) -> tensor<16x1xi1>
      %305 = "tensor.empty"() : () -> tensor<16x32xi1>
      %306 = "linalg.generic"(%304, %305) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg135: i1, %arg136: i1):
        "linalg.yield"(%arg135) : (i1) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<16x1xi1>, tensor<16x32xi1>) -> tensor<16x32xi1>
      %307 = "linalg.generic"(%306, %295, %306) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg132: i1, %arg133: i1, %arg134: i1):
        %327 = "arith.andi"(%arg132, %arg133) : (i1, i1) -> i1
        "linalg.yield"(%327) : (i1) -> ()
      }) : (tensor<16x32xi1>, tensor<16x32xi1>, tensor<16x32xi1>) -> tensor<16x32xi1>
      %308 = "linalg.generic"(%307, %301, %123, %301) <{indexing_maps = [#map1, #map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg128: i1, %arg129: f32, %arg130: f32, %arg131: f32):
        %326 = "arith.select"(%arg128, %arg129, %arg130) : (i1, f32, f32) -> f32
        "linalg.yield"(%326) : (f32) -> ()
      }) : (tensor<16x32xi1>, tensor<16x32xf32>, tensor<16x32xf32>, tensor<16x32xf32>) -> tensor<16x32xf32>
      %309:4 = "func.call"(%308, %arg110, %arg111) <{callee = @vllm.v1.attention.ops.triton_attention_helpers.softmax_step__fp32S16_32S_fp32S16S_fp32S16S}> : (tensor<16x32xf32>, tensor<16xf32>, tensor<16xf32>) -> (tensor<16xf32>, tensor<16xf32>, tensor<16x32xf32>, tensor<16xf32>)
      %310 = "tensor.expand_shape"(%309#3) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xf32>) -> tensor<16x1xf32>
      %311 = "tensor.empty"() : () -> tensor<16x128xf32>
      %312 = "linalg.generic"(%310, %311) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg126: f32, %arg127: f32):
        "linalg.yield"(%arg126) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<16x1xf32>, tensor<16x128xf32>) -> tensor<16x128xf32>
      %313 = "linalg.generic"(%arg112, %312, %arg112) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg123: f32, %arg124: f32, %arg125: f32):
        %325 = "arith.mulf"(%arg123, %arg124) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%325) : (f32) -> ()
      }) : (tensor<16x128xf32>, tensor<16x128xf32>, tensor<16x128xf32>) -> tensor<16x128xf32>
      %314 = "tensor.empty"() : () -> tensor<16x32xbf16>
      %315 = "linalg.generic"(%309#2, %314) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg121: f32, %arg122: bf16):
        %324 = "arith.truncf"(%arg121) : (f32) -> bf16
        "linalg.yield"(%324) : (bf16) -> ()
      }) : (tensor<16x32xf32>, tensor<16x32xbf16>) -> tensor<16x32xbf16>
      %316 = "linalg.fill"(%110, %311) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg119: f32, %arg120: f32):
        "linalg.yield"(%arg119) : (f32) -> ()
      }) : (f32, tensor<16x128xf32>) -> tensor<16x128xf32>
      %317 = "linalg.matmul"(%315, %290, %316) <{indexing_maps = [#map4, #map5, #map6], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg116: bf16, %arg117: bf16, %arg118: f32):
        %320 = "arith.extf"(%arg116) : (bf16) -> f32
        %321 = "arith.extf"(%arg117) : (bf16) -> f32
        %322 = "arith.mulf"(%320, %321) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %323 = "arith.addf"(%arg118, %322) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%323) : (f32) -> ()
      }) : (tensor<16x32xbf16>, tensor<32x128xbf16>, tensor<16x128xf32>) -> tensor<16x128xf32>
      %318 = "linalg.generic"(%313, %317, %313) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg113: f32, %arg114: f32, %arg115: f32):
        %319 = "arith.addf"(%arg113, %arg114) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%319) : (f32) -> ()
      }) : (tensor<16x128xf32>, tensor<16x128xf32>, tensor<16x128xf32>) -> tensor<16x128xf32>
      "scf.yield"(%309#0, %309#1, %318) : (tensor<16xf32>, tensor<16xf32>, tensor<16x128xf32>) -> ()
    }) : (index, index, index, tensor<16xf32>, tensor<16xf32>, tensor<16x128xf32>) -> (tensor<16xf32>, tensor<16xf32>, tensor<16x128xf32>)
    %201 = "tensor.expand_shape"(%200#1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xf32>) -> tensor<16x1xf32>
    %202 = "tensor.empty"() : () -> tensor<16x128xf32>
    %203 = "linalg.generic"(%201, %202) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg107: f32, %arg108: f32):
      "linalg.yield"(%arg107) : (f32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<16x1xf32>, tensor<16x128xf32>) -> tensor<16x128xf32>
    %204 = "linalg.generic"(%200#2, %203, %200#2) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg104: f32, %arg105: f32, %arg106: f32):
      %220 = "arith.divf"(%arg104, %arg105) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%220) : (f32) -> ()
    }) : (tensor<16x128xf32>, tensor<16x128xf32>, tensor<16x128xf32>) -> tensor<16x128xf32>
    %205 = "tensor.empty"() : () -> tensor<16x128xbf16>
    %206 = "linalg.generic"(%204, %205) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg102: f32, %arg103: bf16):
      %219 = "arith.truncf"(%arg102) : (f32) -> bf16
      "linalg.yield"(%219) : (bf16) -> ()
    }) : (tensor<16x128xf32>, tensor<16x128xbf16>) -> tensor<16x128xbf16>
    %207 = "arith.muli"(%162, %arg90) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %208 = "arith.muli"(%164, %arg90) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %209 = "arith.addi"(%207, %208) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %210 = "arith.muli"(%167, %arg91) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %211 = "arith.addi"(%209, %210) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %212 = "arith.index_cast"(%211) : (i64) -> index
    %213 = "arith.index_cast"(%arg90) : (i64) -> index
    %214 = "arith.index_cast"(%arg91) : (i64) -> index
    %215 = "memref.reinterpret_cast"(%arg76, %213, %214) <{operandSegmentSizes = array<i32: 1, 0, 0, 2>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, 1>}> : (memref<?xbf16>, index, index) -> memref<1099511627776x1099511627776x1099511627776xbf16, strided<[?, ?, 1]>>
    %216 = "tensor.expand_shape"(%206) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 4, 4, 128>}> : (tensor<16x128xbf16>) -> tensor<4x4x128xbf16>
    %217 = "tensor.extract_slice"(%216, %184, %185) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<4x4x128xbf16>, index, index) -> tensor<?x?x128xbf16>
    %218 = "memref.subview"(%215, %212, %184, %185) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: 0, 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, 128>, static_strides = array<i64: 1, 1, 1>}> : (memref<1099511627776x1099511627776x1099511627776xbf16, strided<[?, ?, 1]>>, index, index, index) -> memref<?x?x128xbf16, strided<[?, ?, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%217, %218) <{writable}> : (tensor<?x?x128xbf16>, memref<?x?x128xbf16, strided<[?, ?, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32>, memref<?xi32>, i32, i32) -> (i32, i32, i32, i32, i32), sym_name = "vllm.v1.attention.ops.triton_attention_helpers.resolve_seq_and_query_len__Pi32_Pi32_i32_i32_c4", sym_visibility = "private"}> ({
  ^bb0(%arg72: memref<?xi32>, %arg73: memref<?xi32>, %arg74: i32, %arg75: i32):
    %88 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %89 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %90 = "builtin.unrealized_conversion_cast"(%arg73) : (memref<?xi32>) -> !tt.ptr<i32>
    %91 = "builtin.unrealized_conversion_cast"(%arg72) : (memref<?xi32>) -> !tt.ptr<i32>
    %92 = "func.call"(%arg72, %arg74, %arg75) <{callee = @vllm.v1.attention.ops.triton_attention_helpers.find_seq_idx__Pi32_i32_i32_c4_cTrue}> : (memref<?xi32>, i32, i32) -> i32
    %93 = "tt.addptr"(%91, %92) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
    %94 = "tt.load"(%93) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
    %95 = "arith.divsi"(%94, %89) : (i32, i32) -> i32
    %96 = "arith.addi"(%95, %92) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %97 = "arith.subi"(%arg74, %96) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %98 = "tt.addptr"(%93, %88) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
    %99 = "tt.load"(%98) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
    %100 = "arith.subi"(%99, %94) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %101 = "tt.addptr"(%90, %92) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
    %102 = "tt.load"(%101) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
    "func.return"(%92, %97, %94, %100, %102) : (i32, i32, i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32>, i32, i32) -> i32, sym_name = "vllm.v1.attention.ops.triton_attention_helpers.find_seq_idx__Pi32_i32_i32_c4_cTrue", sym_visibility = "private"}> ({
  ^bb0(%arg66: memref<?xi32>, %arg67: i32, %arg68: i32):
    %62 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %63 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %64 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %65 = "arith.constant"() <{value = 0 : index}> : () -> index
    %66 = "arith.constant"() <{value = 16 : index}> : () -> index
    %67 = "arith.constant"() <{value = 1 : index}> : () -> index
    %68 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %69 = "builtin.unrealized_conversion_cast"(%arg66) : (memref<?xi32>) -> !tt.ptr<i32>
    %70 = "arith.subi"(%arg68, %62) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %71:2 = "scf.for"(%65, %66, %67, %68, %arg68) ({
    ^bb0(%arg69: index, %arg70: i32, %arg71: i32):
      %73 = "arith.cmpi"(%arg70, %arg71) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %74 = "arith.addi"(%arg70, %arg71) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %75 = "arith.divsi"(%74, %63) : (i32, i32) -> i32
      %76 = "arith.minsi"(%75, %70) : (i32, i32) -> i32
      %77 = "arith.maxsi"(%76, %68) : (i32, i32) -> i32
      %78 = "tt.addptr"(%69, %77) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      %79 = "tt.load"(%78) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
      %80 = "arith.divsi"(%79, %64) : (i32, i32) -> i32
      %81 = "arith.addi"(%80, %77) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %82 = "arith.cmpi"(%81, %arg67) <{predicate = 3 : i64}> : (i32, i32) -> i1
      %83 = "arith.addi"(%77, %62) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %84 = "arith.select"(%82, %83, %arg70) : (i1, i32, i32) -> i32
      %85 = "arith.select"(%82, %arg71, %77) : (i1, i32, i32) -> i32
      %86 = "arith.select"(%73, %84, %arg70) : (i1, i32, i32) -> i32
      %87 = "arith.select"(%73, %85, %arg71) : (i1, i32, i32) -> i32
      "scf.yield"(%86, %87) : (i32, i32) -> ()
    }) : (index, index, index, i32, i32) -> (i32, i32)
    %72 = "arith.subi"(%71#0, %62) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%72) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<16xf32>, sym_name = "vllm.v1.attention.ops.triton_attention_helpers.init_softmax_M__cNone_i32S16S_u1S16S_i32_c16_cFalse_cFalse", sym_visibility = "private"}> ({
    %59 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %60 = "tensor.empty"() : () -> tensor<16xf32>
    %61 = "linalg.fill"(%59, %60) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg64: f32, %arg65: f32):
      "linalg.yield"(%arg64) : (f32) -> ()
    }) : (f32, tensor<16xf32>) -> tensor<16xf32>
    "func.return"(%61) : (tensor<16xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<16x128xf32>, sym_name = "triton.language.standard.zeros__Tc16_c128T_cfp32", sym_visibility = "private"}> ({
    %56 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %57 = "tensor.empty"() : () -> tensor<16x128xf32>
    %58 = "linalg.fill"(%56, %57) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg62: f32, %arg63: f32):
      "linalg.yield"(%arg62) : (f32) -> ()
    }) : (f32, tensor<16x128xf32>) -> tensor<16x128xf32>
    "func.return"(%58) : (tensor<16x128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, i32) -> (i32, i32, i32), sym_name = "vllm.v1.attention.ops.triton_attention_helpers.compute_tile_loop_bounds__i32_i32_i32_i32_i32_i32_c32_c16_c4_c4_c0_cFalse_cFalse_cTrue_cFalse_c-1_c-1_cFalse_cFalse_c0_cNone_i32", sym_visibility = "private"}> ({
  ^bb0(%arg59: i32, %arg60: i32, %arg61: i32):
    %49 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %50 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %51 = "arith.muli"(%arg61, %50) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %52 = "arith.addi"(%arg59, %51) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %53 = "arith.addi"(%52, %50) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %54 = "arith.minsi"(%53, %arg60) : (i32, i32) -> i32
    %55 = "func.call"(%54) <{callee = @vllm.v1.attention.ops.triton_attention_helpers.cdiv_fn__i32_c32}> : (i32) -> i32
    "func.return"(%49, %55, %54) : (i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "vllm.v1.attention.ops.triton_attention_helpers.cdiv_fn__i32_c32", sym_visibility = "private"}> ({
  ^bb0(%arg58: i32):
    %45 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %46 = "arith.constant"() <{value = 31 : i32}> : () -> i32
    %47 = "arith.addi"(%arg58, %46) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %48 = "arith.divsi"(%47, %45) : (i32, i32) -> i32
    "func.return"(%48) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<128x32xbf16>) -> tensor<128x32xbf16>, sym_name = "vllm.v1.attention.ops.triton_unified_attention._cast_kv_tile__bf16S128_32S_bf16S16_128S_Pfp32_c0", sym_visibility = "private"}> ({
  ^bb0(%arg57: tensor<128x32xbf16>):
    "func.return"(%arg57) : (tensor<128x32xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<32x128xbf16>) -> tensor<32x128xbf16>, sym_name = "vllm.v1.attention.ops.triton_unified_attention._cast_kv_tile__bf16S32_128S_bf16S16_128S_Pfp32_c0", sym_visibility = "private"}> ({
  ^bb0(%arg56: tensor<32x128xbf16>):
    "func.return"(%arg56) : (tensor<32x128xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<16x1xi32>, tensor<32xi32>) -> tensor<16x32xi1>, sym_name = "vllm.v1.attention.ops.triton_attention_helpers.compute_kv_seq_mask__i32S16_1S_i32S32S_i32_i32_cNone_c0_cFalse_c0_cTrue_cFalse_cNone_Pi32_c0_cFalse_c-1_c-1_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg47: tensor<16x1xi32>, %arg48: tensor<32xi32>):
    %38 = "tensor.expand_shape"(%arg48) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 32>}> : (tensor<32xi32>) -> tensor<1x32xi32>
    %39 = "tensor.empty"() : () -> tensor<16x32xi32>
    %40 = "linalg.generic"(%38, %39) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg54: i32, %arg55: i32):
      "linalg.yield"(%arg54) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x32xi32>, tensor<16x32xi32>) -> tensor<16x32xi32>
    %41 = "linalg.generic"(%arg47, %39) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg52: i32, %arg53: i32):
      "linalg.yield"(%arg52) : (i32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<16x1xi32>, tensor<16x32xi32>) -> tensor<16x32xi32>
    %42 = "tensor.empty"() : () -> tensor<16x32xi1>
    %43 = "linalg.generic"(%40, %41, %42) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg49: i32, %arg50: i32, %arg51: i1):
      %44 = "arith.cmpi"(%arg49, %arg50) <{predicate = 3 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%44) : (i1) -> ()
    }) : (tensor<16x32xi32>, tensor<16x32xi32>, tensor<16x32xi1>) -> tensor<16x32xi1>
    "func.return"(%43) : (tensor<16x32xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<16x32xf32>, sym_name = "triton.language.standard.zeros__Tc16_c32T_cfp32", sym_visibility = "private"}> ({
    %35 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %36 = "tensor.empty"() : () -> tensor<16x32xf32>
    %37 = "linalg.fill"(%35, %36) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg45: f32, %arg46: f32):
      "linalg.yield"(%arg45) : (f32) -> ()
    }) : (f32, tensor<16x32xf32>) -> tensor<16x32xf32>
    "func.return"(%37) : (tensor<16x32xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<16x32xf32>, tensor<16xf32>, tensor<16xf32>) -> (tensor<16xf32>, tensor<16xf32>, tensor<16x32xf32>, tensor<16xf32>), sym_name = "vllm.v1.attention.ops.triton_attention_helpers.softmax_step__fp32S16_32S_fp32S16S_fp32S16S", sym_visibility = "private"}> ({
  ^bb0(%arg10: tensor<16x32xf32>, %arg11: tensor<16xf32>, %arg12: tensor<16xf32>):
    %6 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %8 = "tensor.empty"() : () -> tensor<16xf32>
    %9 = "linalg.fill"(%7, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg43: f32, %arg44: f32):
      "linalg.yield"(%arg43) : (f32) -> ()
    }) : (f32, tensor<16xf32>) -> tensor<16xf32>
    %10 = "linalg.fill"(%6, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg41: f32, %arg42: f32):
      "linalg.yield"(%arg41) : (f32) -> ()
    }) : (f32, tensor<16xf32>) -> tensor<16xf32>
    %11 = "func.call"(%arg10) <{callee = @triton.language.standard.max__fp32S16_32S_c1_cFalse_cTrue_cFalse}> : (tensor<16x32xf32>) -> tensor<16xf32>
    %12 = "linalg.generic"(%arg11, %11, %arg11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg38: f32, %arg39: f32, %arg40: f32):
      %34 = "arith.maxnumf"(%arg38, %arg39) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%34) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %13 = "tensor.empty"() : () -> tensor<16xi1>
    %14 = "linalg.generic"(%12, %10, %13) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg35: f32, %arg36: f32, %arg37: i1):
      %33 = "arith.cmpf"(%arg35, %arg36) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%33) : (i1) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>, tensor<16xi1>) -> tensor<16xi1>
    %15 = "linalg.generic"(%14, %12, %9, %12) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg31: i1, %arg32: f32, %arg33: f32, %arg34: f32):
      %32 = "arith.select"(%arg31, %arg32, %arg33) : (i1, f32, f32) -> f32
      "linalg.yield"(%32) : (f32) -> ()
    }) : (tensor<16xi1>, tensor<16xf32>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %16 = "tensor.expand_shape"(%15) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xf32>) -> tensor<16x1xf32>
    %17 = "tensor.empty"() : () -> tensor<16x32xf32>
    %18 = "linalg.generic"(%16, %17) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: f32, %arg30: f32):
      "linalg.yield"(%arg29) : (f32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<16x1xf32>, tensor<16x32xf32>) -> tensor<16x32xf32>
    %19 = "linalg.generic"(%arg10, %18, %arg10) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: f32, %arg27: f32, %arg28: f32):
      %31 = "arith.subf"(%arg26, %arg27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%31) : (f32) -> ()
    }) : (tensor<16x32xf32>, tensor<16x32xf32>, tensor<16x32xf32>) -> tensor<16x32xf32>
    %20 = "linalg.generic"(%19, %19) <{indexing_maps = [#map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: f32, %arg25: f32):
      %30 = "math.exp"(%arg24) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%30) : (f32) -> ()
    }) : (tensor<16x32xf32>, tensor<16x32xf32>) -> tensor<16x32xf32>
    %21 = "func.call"(%20) <{callee = @triton.language.standard.sum__fp32S16_32S_c1_cFalse_cNone}> : (tensor<16x32xf32>) -> tensor<16xf32>
    %22 = "linalg.generic"(%arg11, %15, %arg11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: f32, %arg22: f32, %arg23: f32):
      %29 = "arith.subf"(%arg21, %arg22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%29) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %23 = "linalg.generic"(%22, %22) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32):
      %28 = "math.exp"(%arg19) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%28) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %24 = "linalg.generic"(%arg12, %23, %arg12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: f32, %arg17: f32, %arg18: f32):
      %27 = "arith.mulf"(%arg16, %arg17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%27) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %25 = "linalg.generic"(%24, %21, %24) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32, %arg15: f32):
      %26 = "arith.addf"(%arg13, %arg14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%26) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    "func.return"(%15, %25, %20, %23) : (tensor<16xf32>, tensor<16xf32>, tensor<16x32xf32>, tensor<16xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<16x32xf32>) -> tensor<16xf32>, sym_name = "triton.language.standard.max__fp32S16_32S_c1_cFalse_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg7: tensor<16x32xf32>):
    %4 = "tt.reduce"(%arg7) <{axis = 1 : i32}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %5 = "func.call"(%arg8, %arg9) <{callee = @triton.language.standard._elementwise_max__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%5) : (f32) -> ()
    }) : (tensor<16x32xf32>) -> tensor<16xf32>
    "func.return"(%4) : (tensor<16xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._elementwise_max__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg5: f32, %arg6: f32):
    %3 = "arith.maxnumf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<16x32xf32>) -> tensor<16xf32>, sym_name = "triton.language.standard.sum__fp32S16_32S_c1_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<16x32xf32>):
    %1 = "tt.reduce"(%arg2) <{axis = 1 : i32}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%2) : (f32) -> ()
    }) : (tensor<16x32xf32>) -> tensor<16xf32>
    "func.return"(%1) : (tensor<16xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

