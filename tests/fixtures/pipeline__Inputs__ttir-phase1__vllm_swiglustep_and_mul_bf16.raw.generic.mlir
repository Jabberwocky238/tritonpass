#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, i32, memref<?xbf16>, i32) -> (), sym_name = "_swiglustep_and_mul_kernel"}> ({
  ^bb0(%arg16: memref<?xbf16>, %arg17: i32, %arg18: memref<?xbf16>, %arg19: i32):
    %13 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %14 = "arith.constant"() <{value = -7.000000e+00 : f32}> : () -> f32
    %15 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %16 = "arith.constant"() <{value = 12288 : index}> : () -> index
    %17 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %18 = "arith.constant"() <{value = 1024 : i32}> : () -> i32
    %19 = "tensor.empty"() : () -> tensor<1024xf32>
    %20 = "linalg.fill"(%14, %19) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg51: f32, %arg52: f32):
      "linalg.yield"(%arg51) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %21 = "linalg.fill"(%17, %19) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg49: f32, %arg50: f32):
      "linalg.yield"(%arg49) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %22 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %23 = "arith.index_cast"(%22) : (index) -> i32
    %24 = "arith.extsi"(%23) : (i32) -> i64
    %25 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %26 = "arith.index_cast"(%25) : (index) -> i32
    %27 = "arith.extsi"(%arg17) : (i32) -> i64
    %28 = "arith.muli"(%27, %24) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %29 = "arith.index_cast"(%28) : (i64) -> index
    %30 = "arith.extsi"(%arg19) : (i32) -> i64
    %31 = "arith.muli"(%30, %24) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %32 = "arith.index_cast"(%31) : (i64) -> index
    %33 = "arith.muli"(%26, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %34 = "arith.index_cast"(%33) : (i32) -> index
    %35 = "arith.addi"(%34, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %36 = "arith.minsi"(%35, %16) : (index, index) -> index
    %37 = "arith.maxsi"(%36, %34) : (index, index) -> index
    %38 = "arith.subi"(%37, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %39 = "arith.addi"(%32, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %40 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
    "linalg.fill"(%13, %40) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg47: bf16, %arg48: bf16):
      "linalg.yield"(%arg47) : (bf16) -> ()
    }) : (bf16, memref<1024xbf16>) -> ()
    %41 = "memref.subview"(%arg18, %39, %38) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %42 = "memref.subview"(%40, %38) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%41, %42) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg45: bf16, %arg46: bf16):
      "linalg.yield"(%arg45) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %43 = "bufferization.to_tensor"(%40) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
    %44 = "linalg.generic"(%43, %19) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg43: bf16, %arg44: f32):
      %69 = "arith.extf"(%arg43) : (bf16) -> f32
      "linalg.yield"(%69) : (f32) -> ()
    }) : (tensor<1024xbf16>, tensor<1024xf32>) -> tensor<1024xf32>
    %45 = "arith.addi"(%39, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %46 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
    "linalg.fill"(%13, %46) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg41: bf16, %arg42: bf16):
      "linalg.yield"(%arg41) : (bf16) -> ()
    }) : (bf16, memref<1024xbf16>) -> ()
    %47 = "memref.subview"(%arg18, %45, %38) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %48 = "memref.subview"(%46, %38) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%47, %48) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg39: bf16, %arg40: bf16):
      "linalg.yield"(%arg39) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %49 = "bufferization.to_tensor"(%46) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
    %50 = "linalg.generic"(%49, %19) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg37: bf16, %arg38: f32):
      %68 = "arith.extf"(%arg37) : (bf16) -> f32
      "linalg.yield"(%68) : (f32) -> ()
    }) : (tensor<1024xbf16>, tensor<1024xf32>) -> tensor<1024xf32>
    %51 = "func.call"(%44) <{callee = @triton.language.standard.sigmoid__fp32S1024S}> : (tensor<1024xf32>) -> tensor<1024xf32>
    %52 = "linalg.generic"(%51, %44, %51) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg34: f32, %arg35: f32, %arg36: f32):
      %67 = "arith.mulf"(%arg34, %arg35) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%67) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %53 = "linalg.generic"(%52, %21, %52) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg31: f32, %arg32: f32, %arg33: f32):
      %66 = "arith.minnumf"(%arg31, %arg32) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%66) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %54 = "linalg.generic"(%50, %20, %50) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg28: f32, %arg29: f32, %arg30: f32):
      %65 = "arith.maxnumf"(%arg28, %arg29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%65) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %55 = "linalg.generic"(%54, %21, %54) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg25: f32, %arg26: f32, %arg27: f32):
      %64 = "arith.minnumf"(%arg25, %arg26) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%64) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %56 = "linalg.generic"(%53, %55, %53) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg22: f32, %arg23: f32, %arg24: f32):
      %63 = "arith.mulf"(%arg22, %arg23) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%63) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %57 = "tensor.empty"() : () -> tensor<1024xbf16>
    %58 = "linalg.generic"(%56, %57) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: f32, %arg21: bf16):
      %62 = "arith.truncf"(%arg20) : (f32) -> bf16
      "linalg.yield"(%62) : (bf16) -> ()
    }) : (tensor<1024xf32>, tensor<1024xbf16>) -> tensor<1024xbf16>
    %59 = "arith.addi"(%29, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %60 = "tensor.extract_slice"(%58, %38) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xbf16>, index) -> tensor<?xbf16>
    %61 = "memref.subview"(%arg16, %59, %38) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%60, %61) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1024xf32>) -> tensor<1024xf32>, sym_name = "triton.language.standard.sigmoid__fp32S1024S", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<1024xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "tensor.empty"() : () -> tensor<1024xf32>
    %3 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      "linalg.yield"(%arg14) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %4 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %5 = "linalg.generic"(%4, %arg0, %4) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32, %arg11: f32):
      %12 = "arith.subf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%12) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %6 = "linalg.generic"(%5, %5) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32):
      %11 = "math.exp"(%arg7) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%11) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %7 = "linalg.generic"(%6, %3, %6) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32, %arg6: f32):
      %10 = "arith.addf"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %8 = "linalg.generic"(%3, %7, %3) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %9 = "arith.divf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%9) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    "func.return"(%8) : (tensor<1024xf32>) -> ()
  }) : () -> ()
}) : () -> ()

