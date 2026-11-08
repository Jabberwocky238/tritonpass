#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xf32>, memref<?xf32>, memref<?xf32>, memref<?xi32>, i32, f32, i64, i64, i64, memref<?xi32>) -> (), sym_name = "reduce_segments"}> ({
  ^bb0(%arg21: memref<?xbf16>, %arg22: memref<?xf32>, %arg23: memref<?xf32>, %arg24: memref<?xf32>, %arg25: memref<?xi32>, %arg26: i32, %arg27: f32, %arg28: i64, %arg29: i64, %arg30: i64, %arg31: memref<?xi32>):
    %35 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %36 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %37 = "arith.constant"() <{value = 16 : index}> : () -> index
    %38 = "arith.constant"() <{value = 0 : index}> : () -> index
    %39 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %40 = "arith.constant"() <{value = 2048 : i32}> : () -> i32
    %41 = "arith.constant"() <{value = 65536 : i64}> : () -> i64
    %42 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %43 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %44 = "builtin.unrealized_conversion_cast"(%arg25) : (memref<?xi32>) -> !tt.ptr<i32>
    %45 = "tensor.empty"() : () -> tensor<128xf32>
    %46 = "linalg.fill"(%35, %45) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg72: f32, %arg73: f32):
      "linalg.yield"(%arg72) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %47 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %48 = "arith.index_cast"(%47) : (index) -> i32
    %49 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %50 = "arith.index_cast"(%49) : (index) -> i32
    %51 = "func.call"(%arg31, %48, %arg26) <{callee = @vllm.v1.attention.ops.triton_attention_helpers.find_seq_idx__Pi32_i32_i32_c4_cFalse}> : (memref<?xi32>, i32, i32) -> i32
    %52 = "tt.addptr"(%44, %51) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
    %53 = "tt.load"(%52) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
    %54 = "func.call"(%53, %36) <{callee = @vllm.v1.attention.ops.triton_attention_helpers.cdiv_fn__i32_i32}> : (i32, i32) -> i32
    %55 = "arith.muli"(%54, %43) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %56 = "func.call"(%53, %55) <{callee = @vllm.v1.attention.ops.triton_attention_helpers.cdiv_fn__i32_i32}> : (i32, i32) -> i32
    %57 = "arith.extsi"(%48) : (i32) -> i64
    %58 = "arith.muli"(%57, %42) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %59 = "arith.muli"(%50, %43) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %60 = "arith.extsi"(%59) : (i32) -> i64
    %61 = "arith.addi"(%58, %60) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %62 = "arith.index_cast"(%61) : (i64) -> index
    %63 = "arith.index_cast"(%56) : (i32) -> index
    %64 = "arith.minsi"(%63, %37) : (index, index) -> index
    %65 = "arith.maxsi"(%64, %38) : (index, index) -> index
    %66 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
    "linalg.fill"(%39, %66) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg70: f32, %arg71: f32):
      "linalg.yield"(%arg70) : (f32) -> ()
    }) : (f32, memref<16xf32>) -> ()
    %67 = "memref.subview"(%arg23, %62, %65) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %68 = "memref.subview"(%66, %65) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<16xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%67, %68) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg68: f32, %arg69: f32):
      "linalg.yield"(%arg68) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %69 = "bufferization.to_tensor"(%66) <{restrict, writable}> : (memref<16xf32>) -> tensor<16xf32>
    %70 = "func.call"(%69) <{callee = @triton.language.standard.max__fp32S16S_cNone_cFalse_cTrue_cFalse}> : (tensor<16xf32>) -> f32
    %71 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
    "linalg.fill"(%35, %71) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg66: f32, %arg67: f32):
      "linalg.yield"(%arg66) : (f32) -> ()
    }) : (f32, memref<16xf32>) -> ()
    %72 = "memref.subview"(%arg24, %62, %65) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %73 = "memref.subview"(%71, %65) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<16xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%72, %73) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg64: f32, %arg65: f32):
      "linalg.yield"(%arg64) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %74 = "bufferization.to_tensor"(%71) <{restrict, writable}> : (memref<16xf32>) -> tensor<16xf32>
    %75 = "tensor.empty"() : () -> tensor<16xf32>
    %76 = "linalg.fill"(%70, %75) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg62: f32, %arg63: f32):
      "linalg.yield"(%arg62) : (f32) -> ()
    }) : (f32, tensor<16xf32>) -> tensor<16xf32>
    %77 = "linalg.generic"(%69, %76, %69) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg59: f32, %arg60: f32, %arg61: f32):
      %116 = "arith.subf"(%arg59, %arg60) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%116) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %78 = "linalg.generic"(%77, %77) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg57: f32, %arg58: f32):
      %115 = "math.exp"(%arg57) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%115) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %79 = "linalg.generic"(%74, %78, %74) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg54: f32, %arg55: f32, %arg56: f32):
      %114 = "arith.mulf"(%arg54, %arg55) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%114) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %80 = "func.call"(%79) <{callee = @triton.language.standard.sum__fp32S16S_cNone_cFalse_cNone}> : (tensor<16xf32>) -> f32
    %81 = "arith.muli"(%57, %41) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %82 = "arith.muli"(%50, %40) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %83 = "arith.extsi"(%82) : (i32) -> i64
    %84 = "arith.addi"(%81, %83) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %85 = "arith.index_cast"(%84) : (i64) -> index
    %86 = "memref.reinterpret_cast"(%arg22) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[128, 1]>>
    %87 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x128xf32>
    "linalg.fill"(%35, %87) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg52: f32, %arg53: f32):
      "linalg.yield"(%arg52) : (f32) -> ()
    }) : (f32, memref<16x128xf32>) -> ()
    %88 = "memref.subview"(%86, %85, %65) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[128, 1]>>, index, index) -> memref<?x128xf32, strided<[128, 1], offset: ?>>
    %89 = "memref.subview"(%87, %65) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<16x128xf32>, index) -> memref<?x128xf32, strided<[128, 1]>>
    "linalg.copy"(%88, %89) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg50: f32, %arg51: f32):
      "linalg.yield"(%arg50) : (f32) -> ()
    }) : (memref<?x128xf32, strided<[128, 1], offset: ?>>, memref<?x128xf32, strided<[128, 1]>>) -> ()
    %90 = "bufferization.to_tensor"(%87) <{restrict, writable}> : (memref<16x128xf32>) -> tensor<16x128xf32>
    %91 = "tensor.expand_shape"(%78) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xf32>) -> tensor<16x1xf32>
    %92 = "tensor.empty"() : () -> tensor<16x128xf32>
    %93 = "linalg.generic"(%91, %92) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg48: f32, %arg49: f32):
      "linalg.yield"(%arg48) : (f32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<16x1xf32>, tensor<16x128xf32>) -> tensor<16x128xf32>
    %94 = "linalg.generic"(%90, %93, %90) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg45: f32, %arg46: f32, %arg47: f32):
      %113 = "arith.mulf"(%arg45, %arg46) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%113) : (f32) -> ()
    }) : (tensor<16x128xf32>, tensor<16x128xf32>, tensor<16x128xf32>) -> tensor<16x128xf32>
    %95 = "func.call"(%94) <{callee = @triton.language.standard.sum__fp32S16_128S_c0_cFalse_cNone}> : (tensor<16x128xf32>) -> tensor<128xf32>
    %96 = "arith.cmpf"(%80, %35) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %97 = "linalg.fill"(%80, %45) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg43: f32, %arg44: f32):
      "linalg.yield"(%arg43) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %98 = "linalg.generic"(%95, %97, %95) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg40: f32, %arg41: f32, %arg42: f32):
      %112 = "arith.divf"(%arg40, %arg41) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%112) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %99 = "tensor.empty"() : () -> tensor<128xi1>
    %100 = "linalg.fill"(%96, %99) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg38: i1, %arg39: i1):
      "linalg.yield"(%arg38) : (i1) -> ()
    }) : (i1, tensor<128xi1>) -> tensor<128xi1>
    %101 = "linalg.generic"(%100, %46, %98, %46) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg34: i1, %arg35: f32, %arg36: f32, %arg37: f32):
      %111 = "arith.select"(%arg34, %arg35, %arg36) : (i1, f32, f32) -> f32
      "linalg.yield"(%111) : (f32) -> ()
    }) : (tensor<128xi1>, tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %102 = "arith.muli"(%57, %arg28) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %103 = "arith.extsi"(%50) : (i32) -> i64
    %104 = "arith.muli"(%103, %arg29) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %105 = "arith.addi"(%102, %104) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %106 = "arith.index_cast"(%105) : (i64) -> index
    %107 = "tensor.empty"() : () -> tensor<128xbf16>
    %108 = "linalg.generic"(%101, %107) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg32: f32, %arg33: bf16):
      %110 = "arith.truncf"(%arg32) : (f32) -> bf16
      "linalg.yield"(%110) : (bf16) -> ()
    }) : (tensor<128xf32>, tensor<128xbf16>) -> tensor<128xbf16>
    %109 = "memref.subview"(%arg21, %106) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index) -> memref<128xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%108, %109) <{writable}> : (tensor<128xbf16>, memref<128xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32>, i32, i32) -> i32, sym_name = "vllm.v1.attention.ops.triton_attention_helpers.find_seq_idx__Pi32_i32_i32_c4_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg15: memref<?xi32>, %arg16: i32, %arg17: i32):
    %12 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %13 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %14 = "arith.constant"() <{value = 0 : index}> : () -> index
    %15 = "arith.constant"() <{value = 16 : index}> : () -> index
    %16 = "arith.constant"() <{value = 1 : index}> : () -> index
    %17 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %18 = "builtin.unrealized_conversion_cast"(%arg15) : (memref<?xi32>) -> !tt.ptr<i32>
    %19 = "arith.subi"(%arg17, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %20:2 = "scf.for"(%14, %15, %16, %17, %arg17) ({
    ^bb0(%arg18: index, %arg19: i32, %arg20: i32):
      %22 = "arith.cmpi"(%arg19, %arg20) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %23 = "arith.addi"(%arg19, %arg20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %24 = "arith.divsi"(%23, %13) : (i32, i32) -> i32
      %25 = "arith.minsi"(%24, %19) : (i32, i32) -> i32
      %26 = "arith.maxsi"(%25, %17) : (i32, i32) -> i32
      %27 = "tt.addptr"(%18, %26) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      %28 = "tt.load"(%27) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
      %29 = "arith.cmpi"(%28, %arg16) <{predicate = 3 : i64}> : (i32, i32) -> i1
      %30 = "arith.addi"(%26, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %31 = "arith.select"(%29, %30, %arg19) : (i1, i32, i32) -> i32
      %32 = "arith.select"(%29, %arg20, %26) : (i1, i32, i32) -> i32
      %33 = "arith.select"(%22, %31, %arg19) : (i1, i32, i32) -> i32
      %34 = "arith.select"(%22, %32, %arg20) : (i1, i32, i32) -> i32
      "scf.yield"(%33, %34) : (i32, i32) -> ()
    }) : (index, index, index, i32, i32) -> (i32, i32)
    %21 = "arith.subi"(%20#0, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%21) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "vllm.v1.attention.ops.triton_attention_helpers.cdiv_fn__i32_i32", sym_visibility = "private"}> ({
  ^bb0(%arg13: i32, %arg14: i32):
    %8 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %9 = "arith.addi"(%arg13, %arg14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %10 = "arith.subi"(%9, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %11 = "arith.divsi"(%10, %arg14) : (i32, i32) -> i32
    "func.return"(%11) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<16xf32>) -> f32, sym_name = "triton.language.standard.max__fp32S16S_cNone_cFalse_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg10: tensor<16xf32>):
    %6 = "tt.reduce"(%arg10) <{axis = 0 : i32}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      %7 = "func.call"(%arg11, %arg12) <{callee = @triton.language.standard._elementwise_max__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%7) : (f32) -> ()
    }) : (tensor<16xf32>) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._elementwise_max__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg8: f32, %arg9: f32):
    %5 = "arith.maxnumf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<16xf32>) -> f32, sym_name = "triton.language.standard.sum__fp32S16S_cNone_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg5: tensor<16xf32>):
    %3 = "tt.reduce"(%arg5) <{axis = 0 : i32}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      %4 = "func.call"(%arg6, %arg7) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%4) : (f32) -> ()
    }) : (tensor<16xf32>) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg3: f32, %arg4: f32):
    %2 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<16x128xf32>) -> tensor<128xf32>, sym_name = "triton.language.standard.sum__fp32S16_128S_c0_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<16x128xf32>):
    %0 = "tt.reduce"(%arg0) <{axis = 0 : i32}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %1 = "func.call"(%arg1, %arg2) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%1) : (f32) -> ()
    }) : (tensor<16x128xf32>) -> tensor<128xf32>
    "func.return"(%0) : (tensor<128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

