#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map5 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (f32, memref<?xf32>, i32, memref<?xf16>, memref<?xf16>, memref<?xf16>, memref<?xf16>, i32) -> (), sym_name = "_attn_fwd"}> ({
  ^bb0(%arg81: f32, %arg82: memref<?xf32>, %arg83: i32, %arg84: memref<?xf16>, %arg85: memref<?xf16>, %arg86: memref<?xf16>, %arg87: memref<?xf16>, %arg88: i32):
    %79 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %80 = "arith.constant"() <{value = 1.44269502 : f32}> : () -> f32
    %81 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %82 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %83 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %84 = "tensor.empty"() : () -> tensor<128xf32>
    %85 = "linalg.fill"(%79, %84) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg109: f32, %arg110: f32):
      "linalg.yield"(%arg109) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %86 = "linalg.fill"(%82, %84) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg107: f32, %arg108: f32):
      "linalg.yield"(%arg107) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %87 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %88 = "arith.index_cast"(%87) : (index) -> i32
    %89 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %90 = "arith.index_cast"(%89) : (index) -> i32
    %91 = "arith.divsi"(%90, %arg83) : (i32, i32) -> i32
    %92 = "arith.remsi"(%90, %arg83) : (i32, i32) -> i32
    %93 = "arith.muli"(%arg83, %arg88) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %94 = "func.call"(%arg84, %93) <{callee = @"tutorials.06-fused-attention._maybe_make_tensor_desc__Pfp16_Ti32_c128T_Tc128_c1T_Tc128_c128T"}> : (memref<?xf16>, i32) -> !tt.tensordesc<tensor<128x128xf16>>
    %95 = "func.call"(%arg86, %93) <{callee = @"tutorials.06-fused-attention._maybe_make_tensor_desc__Pfp16_Ti32_c128T_Tc128_c1T_Tc64_c128T"}> : (memref<?xf16>, i32) -> !tt.tensordesc<tensor<64x128xf16>>
    %96 = "func.call"(%arg85, %93) <{callee = @"tutorials.06-fused-attention._maybe_make_tensor_desc__Pfp16_Ti32_c128T_Tc128_c1T_Tc64_c128T"}> : (memref<?xf16>, i32) -> !tt.tensordesc<tensor<64x128xf16>>
    %97 = "func.call"(%arg87, %93) <{callee = @"tutorials.06-fused-attention._maybe_make_tensor_desc__Pfp16_Ti32_c128T_Tc128_c1T_Tc128_c128T"}> : (memref<?xf16>, i32) -> !tt.tensordesc<tensor<128x128xf16>>
    %98 = "arith.muli"(%91, %93) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %99 = "arith.muli"(%92, %arg88) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %100 = "arith.addi"(%98, %99) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %101 = "arith.muli"(%88, %83) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %102 = "arith.addi"(%100, %101) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %103 = "arith.index_cast"(%101) : (i32) -> index
    %104 = "func.call"() <{callee = @triton.language.standard.zeros__Tc128T_cfp32}> : () -> tensor<128xf32>
    %105 = "linalg.generic"(%104, %86, %104) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg104: f32, %arg105: f32, %arg106: f32):
      %129 = "arith.subf"(%arg104, %arg105) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%129) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %106 = "func.call"() <{callee = @triton.language.standard.zeros__Tc128T_cfp32}> : () -> tensor<128xf32>
    %107 = "linalg.generic"(%106, %85, %106) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg101: f32, %arg102: f32, %arg103: f32):
      %128 = "arith.addf"(%arg101, %arg102) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%128) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %108 = "func.call"() <{callee = @triton.language.standard.zeros__Tc128_c128T_cfp32}> : () -> tensor<128x128xf32>
    %109 = "arith.mulf"(%arg81, %80) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %110 = "tt.descriptor_load"(%94, %102, %81) <{cache = 1 : i32, evict = 1 : i32}> : (!tt.tensordesc<tensor<128x128xf16>>, i32, i32) -> tensor<128x128xf16>
    %111:3 = "func.call"(%108, %107, %105, %110, %96, %95, %100, %109, %arg88) <{callee = @"tutorials.06-fused-attention._attn_fwd_inner__fp32S128_128S_fp32S128S_fp32S128S_fp16S128_128S_TDfp16S64_128S_TDfp16S64_128S_i32_cfp16_i32_fp32_c128_c128_c64_c3_i32S128S_i32S64S_i32_cFalse_cFalse"}> : (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, tensor<128x128xf16>, !tt.tensordesc<tensor<64x128xf16>>, !tt.tensordesc<tensor<64x128xf16>>, i32, f32, i32) -> (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>)
    %112 = "linalg.generic"(%111#1, %111#1) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg99: f32, %arg100: f32):
      %127 = "math.log2"(%arg99) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%127) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %113 = "linalg.generic"(%111#2, %112, %111#2) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg96: f32, %arg97: f32, %arg98: f32):
      %126 = "arith.addf"(%arg96, %arg97) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%126) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %114 = "tensor.expand_shape"(%111#1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
    %115 = "tensor.empty"() : () -> tensor<128x128xf32>
    %116 = "linalg.generic"(%114, %115) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg94: f32, %arg95: f32):
      "linalg.yield"(%arg94) : (f32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    %117 = "linalg.generic"(%111#0, %116, %111#0) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg91: f32, %arg92: f32, %arg93: f32):
      %125 = "arith.divf"(%arg91, %arg92) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%125) : (f32) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    %118 = "arith.muli"(%90, %arg88) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %119 = "arith.index_cast"(%118) : (i32) -> index
    %120 = "arith.addi"(%119, %103) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %121 = "memref.subview"(%arg82, %120) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<128xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%113, %121) <{writable}> : (tensor<128xf32>, memref<128xf32, strided<[1], offset: ?>>) -> ()
    %122 = "tensor.empty"() : () -> tensor<128x128xf16>
    %123 = "linalg.generic"(%117, %122) <{indexing_maps = [#map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg89: f32, %arg90: f16):
      %124 = "arith.truncf"(%arg89) : (f32) -> f16
      "linalg.yield"(%124) : (f16) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xf16>) -> tensor<128x128xf16>
    "tt.descriptor_store"(%97, %123, %102, %81) : (!tt.tensordesc<tensor<128x128xf16>>, tensor<128x128xf16>, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf16>, i32) -> !tt.tensordesc<tensor<128x128xf16>>, sym_name = "tutorials.06-fused-attention._maybe_make_tensor_desc__Pfp16_Ti32_c128T_Tc128_c1T_Tc128_c128T", sym_visibility = "private"}> ({
  ^bb0(%arg79: memref<?xf16>, %arg80: i32):
    %74 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %75 = "arith.constant"() <{value = 128 : i64}> : () -> i64
    %76 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %77 = "builtin.unrealized_conversion_cast"(%arg79) : (memref<?xf16>) -> !tt.ptr<f16>
    %78 = "tt.make_tensor_descriptor"(%77, %arg80, %76, %75, %74) <{padding = 1 : i32}> : (!tt.ptr<f16>, i32, i32, i64, i64) -> !tt.tensordesc<tensor<128x128xf16>>
    "func.return"(%78) : (!tt.tensordesc<tensor<128x128xf16>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf16>, i32) -> !tt.tensordesc<tensor<64x128xf16>>, sym_name = "tutorials.06-fused-attention._maybe_make_tensor_desc__Pfp16_Ti32_c128T_Tc128_c1T_Tc64_c128T", sym_visibility = "private"}> ({
  ^bb0(%arg77: memref<?xf16>, %arg78: i32):
    %69 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %70 = "arith.constant"() <{value = 128 : i64}> : () -> i64
    %71 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %72 = "builtin.unrealized_conversion_cast"(%arg77) : (memref<?xf16>) -> !tt.ptr<f16>
    %73 = "tt.make_tensor_descriptor"(%72, %arg78, %71, %70, %69) <{padding = 1 : i32}> : (!tt.ptr<f16>, i32, i32, i64, i64) -> !tt.tensordesc<tensor<64x128xf16>>
    "func.return"(%73) : (!tt.tensordesc<tensor<64x128xf16>>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<128xf32>, sym_name = "triton.language.standard.zeros__Tc128T_cfp32", sym_visibility = "private"}> ({
    %66 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %67 = "tensor.empty"() : () -> tensor<128xf32>
    %68 = "linalg.fill"(%66, %67) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg75: f32, %arg76: f32):
      "linalg.yield"(%arg75) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    "func.return"(%68) : (tensor<128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<128x128xf32>, sym_name = "triton.language.standard.zeros__Tc128_c128T_cfp32", sym_visibility = "private"}> ({
    %63 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %64 = "tensor.empty"() : () -> tensor<128x128xf32>
    %65 = "linalg.fill"(%63, %64) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg73: f32, %arg74: f32):
      "linalg.yield"(%arg73) : (f32) -> ()
    }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
    "func.return"(%65) : (tensor<128x128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, tensor<128x128xf16>, !tt.tensordesc<tensor<64x128xf16>>, !tt.tensordesc<tensor<64x128xf16>>, i32, f32, i32) -> (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>), sym_name = "tutorials.06-fused-attention._attn_fwd_inner__fp32S128_128S_fp32S128S_fp32S128S_fp16S128_128S_TDfp16S64_128S_TDfp16S64_128S_i32_cfp16_i32_fp32_c128_c128_c64_c3_i32S128S_i32S64S_i32_cFalse_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg10: tensor<128x128xf32>, %arg11: tensor<128xf32>, %arg12: tensor<128xf32>, %arg13: tensor<128x128xf16>, %arg14: !tt.tensordesc<tensor<64x128xf16>>, %arg15: !tt.tensordesc<tensor<64x128xf16>>, %arg16: i32, %arg17: f32, %arg18: i32):
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %8 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %9 = "arith.constant"() <{value = 64 : index}> : () -> index
    %10 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %11 = "arith.index_cast"(%arg18) : (i32) -> index
    %12:5 = "scf.for"(%6, %11, %9, %arg10, %arg11, %arg12, %arg16, %arg16) ({
    ^bb0(%arg19: index, %arg20: tensor<128x128xf32>, %arg21: tensor<128xf32>, %arg22: tensor<128xf32>, %arg23: i32, %arg24: i32):
      %13 = "tt.descriptor_load"(%arg14, %arg23, %8) <{cache = 1 : i32, evict = 1 : i32}> : (!tt.tensordesc<tensor<64x128xf16>>, i32, i32) -> tensor<64x128xf16>
      %14 = "tensor.empty"() : () -> tensor<128x64xf16>
      %15 = "linalg.transpose"(%13, %14) <{permutation = array<i64: 1, 0>}> ({
      ^bb0(%arg71: f16, %arg72: f16):
        "linalg.yield"(%arg71) : (f16) -> ()
      }) : (tensor<64x128xf16>, tensor<128x64xf16>) -> tensor<128x64xf16>
      %16 = "tensor.empty"() : () -> tensor<128x64xf32>
      %17 = "linalg.fill"(%10, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg69: f32, %arg70: f32):
        "linalg.yield"(%arg69) : (f32) -> ()
      }) : (f32, tensor<128x64xf32>) -> tensor<128x64xf32>
      %18 = "linalg.matmul"(%arg13, %15, %17) <{indexing_maps = [#map3, #map4, #map5], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg66: f16, %arg67: f16, %arg68: f32):
        %59 = "arith.extf"(%arg66) : (f16) -> f32
        %60 = "arith.extf"(%arg67) : (f16) -> f32
        %61 = "arith.mulf"(%59, %60) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %62 = "arith.addf"(%arg68, %61) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%62) : (f32) -> ()
      }) : (tensor<128x128xf16>, tensor<128x64xf16>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %19 = "func.call"(%18) <{callee = @triton.language.standard.max__fp32S128_64S_c1_cFalse_cTrue_cFalse}> : (tensor<128x64xf32>) -> tensor<128xf32>
      %20 = "tensor.empty"() : () -> tensor<128xf32>
      %21 = "linalg.fill"(%arg17, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg64: f32, %arg65: f32):
        "linalg.yield"(%arg64) : (f32) -> ()
      }) : (f32, tensor<128xf32>) -> tensor<128xf32>
      %22 = "linalg.generic"(%19, %21, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg61: f32, %arg62: f32, %arg63: f32):
        %58 = "arith.mulf"(%arg61, %arg62) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%58) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %23 = "linalg.generic"(%arg22, %22, %arg22) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg58: f32, %arg59: f32, %arg60: f32):
        %57 = "arith.maxnumf"(%arg58, %arg59) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%57) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %24 = "linalg.fill"(%arg17, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg56: f32, %arg57: f32):
        "linalg.yield"(%arg56) : (f32) -> ()
      }) : (f32, tensor<128x64xf32>) -> tensor<128x64xf32>
      %25 = "linalg.generic"(%18, %24, %18) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg53: f32, %arg54: f32, %arg55: f32):
        %56 = "arith.mulf"(%arg53, %arg54) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%56) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %26 = "tensor.expand_shape"(%23) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %27 = "linalg.generic"(%26, %16) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg51: f32, %arg52: f32):
        "linalg.yield"(%arg51) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %28 = "linalg.generic"(%25, %27, %25) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg48: f32, %arg49: f32, %arg50: f32):
        %55 = "arith.subf"(%arg48, %arg49) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%55) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %29 = "linalg.generic"(%28, %28) <{indexing_maps = [#map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg46: f32, %arg47: f32):
        %54 = "math.exp2"(%arg46) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%54) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %30 = "linalg.generic"(%arg22, %23, %arg22) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg43: f32, %arg44: f32, %arg45: f32):
        %53 = "arith.subf"(%arg43, %arg44) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%53) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %31 = "linalg.generic"(%30, %30) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg41: f32, %arg42: f32):
        %52 = "math.exp2"(%arg41) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%52) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %32 = "func.call"(%29) <{callee = @triton.language.standard.sum__fp32S128_64S_c1_cFalse_cNone}> : (tensor<128x64xf32>) -> tensor<128xf32>
      %33 = "tensor.expand_shape"(%31) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %34 = "tensor.empty"() : () -> tensor<128x128xf32>
      %35 = "linalg.generic"(%33, %34) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg39: f32, %arg40: f32):
        "linalg.yield"(%arg39) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %36 = "linalg.generic"(%arg20, %35, %arg20) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg36: f32, %arg37: f32, %arg38: f32):
        %51 = "arith.mulf"(%arg36, %arg37) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%51) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %37 = "tt.descriptor_load"(%arg15, %arg24, %8) <{cache = 1 : i32, evict = 1 : i32}> : (!tt.tensordesc<tensor<64x128xf16>>, i32, i32) -> tensor<64x128xf16>
      %38 = "linalg.generic"(%29, %14) <{indexing_maps = [#map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg34: f32, %arg35: f16):
        %50 = "arith.truncf"(%arg34) : (f32) -> f16
        "linalg.yield"(%50) : (f16) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf16>) -> tensor<128x64xf16>
      %39 = "linalg.matmul"(%38, %37, %36) <{indexing_maps = [#map3, #map4, #map5], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg31: f16, %arg32: f16, %arg33: f32):
        %46 = "arith.extf"(%arg31) : (f16) -> f32
        %47 = "arith.extf"(%arg32) : (f16) -> f32
        %48 = "arith.mulf"(%46, %47) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %49 = "arith.addf"(%arg33, %48) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%49) : (f32) -> ()
      }) : (tensor<128x64xf16>, tensor<64x128xf16>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %40 = "linalg.generic"(%arg21, %31, %arg21) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg28: f32, %arg29: f32, %arg30: f32):
        %45 = "arith.mulf"(%arg28, %arg29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%45) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %41 = "linalg.generic"(%40, %32, %40) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg25: f32, %arg26: f32, %arg27: f32):
        %44 = "arith.addf"(%arg25, %arg26) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%44) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %42 = "arith.addi"(%arg23, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %43 = "arith.addi"(%arg24, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%39, %41, %23, %42, %43) : (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32) -> ()
    }) : (index, index, index, tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32) -> (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32)
    "func.return"(%12#0, %12#1, %12#2) : (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<128x64xf32>) -> tensor<128xf32>, sym_name = "triton.language.standard.max__fp32S128_64S_c1_cFalse_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg7: tensor<128x64xf32>):
    %4 = "tt.reduce"(%arg7) <{axis = 1 : i32}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %5 = "func.call"(%arg8, %arg9) <{callee = @triton.language.standard._elementwise_max__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%5) : (f32) -> ()
    }) : (tensor<128x64xf32>) -> tensor<128xf32>
    "func.return"(%4) : (tensor<128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._elementwise_max__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg5: f32, %arg6: f32):
    %3 = "arith.maxnumf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<128x64xf32>) -> tensor<128xf32>, sym_name = "triton.language.standard.sum__fp32S128_64S_c1_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<128x64xf32>):
    %1 = "tt.reduce"(%arg2) <{axis = 1 : i32}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%2) : (f32) -> ()
    }) : (tensor<128x64xf32>) -> tensor<128xf32>
    "func.return"(%1) : (tensor<128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

