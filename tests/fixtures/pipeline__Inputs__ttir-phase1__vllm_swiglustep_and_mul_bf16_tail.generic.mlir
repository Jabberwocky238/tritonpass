#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, i32, memref<?xbf16>, i32) -> (), sym_name = "_swiglustep_and_mul_kernel"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: i32, %arg2: memref<?xbf16>, %arg3: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1500 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %5 = "arith.constant"() <{value = -7.000000e+00 : f32}> : () -> f32
    %6 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 1024 : i32}> : () -> i32
    %8 = "tensor.empty"() : () -> tensor<1024xf32>
    %9 = "linalg.fill"(%1, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg50: f32, %arg51: f32):
      "linalg.yield"(%arg50) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %10 = "linalg.fill"(%4, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg48: f32, %arg49: f32):
      "linalg.yield"(%arg48) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %11 = "linalg.fill"(%5, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg46: f32, %arg47: f32):
      "linalg.yield"(%arg46) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %12 = "linalg.fill"(%6, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg44: f32, %arg45: f32):
      "linalg.yield"(%arg44) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %13 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %14 = "arith.index_cast"(%13) : (index) -> i32
    %15 = "arith.extsi"(%14) : (i32) -> i64
    %16 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %17 = "arith.index_cast"(%16) : (index) -> i32
    %18 = "arith.extsi"(%arg1) : (i32) -> i64
    %19 = "arith.muli"(%18, %15) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %20 = "arith.index_cast"(%19) : (i64) -> index
    %21 = "arith.extsi"(%arg3) : (i32) -> i64
    %22 = "arith.muli"(%21, %15) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %23 = "arith.index_cast"(%22) : (i64) -> index
    %24 = "arith.muli"(%17, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %25 = "arith.index_cast"(%24) : (i32) -> index
    %26 = "arith.addi"(%25, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %27 = "arith.minsi"(%26, %3) : (index, index) -> index
    %28 = "arith.maxsi"(%27, %25) : (index, index) -> index
    %29 = "arith.subi"(%28, %25) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %30 = "arith.addi"(%23, %25) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %31 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
    "linalg.fill"(%0, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg42: bf16, %arg43: bf16):
      "linalg.yield"(%arg42) : (bf16) -> ()
    }) : (bf16, memref<1024xbf16>) -> ()
    %32 = "memref.subview"(%arg2, %30, %29) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %33 = "memref.subview"(%31, %29) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%32, %33) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg40: bf16, %arg41: bf16):
      "linalg.yield"(%arg40) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %34 = "bufferization.to_tensor"(%31) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
    %35 = "linalg.generic"(%34, %8) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg38: bf16, %arg39: f32):
      %67 = "arith.extf"(%arg38) : (bf16) -> f32
      "linalg.yield"(%67) : (f32) -> ()
    }) : (tensor<1024xbf16>, tensor<1024xf32>) -> tensor<1024xf32>
    %36 = "arith.addi"(%30, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %37 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
    "linalg.fill"(%0, %37) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg36: bf16, %arg37: bf16):
      "linalg.yield"(%arg36) : (bf16) -> ()
    }) : (bf16, memref<1024xbf16>) -> ()
    %38 = "memref.subview"(%arg2, %36, %29) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %39 = "memref.subview"(%37, %29) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%38, %39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg34: bf16, %arg35: bf16):
      "linalg.yield"(%arg34) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %40 = "bufferization.to_tensor"(%37) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
    %41 = "linalg.generic"(%40, %8) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg32: bf16, %arg33: f32):
      %66 = "arith.extf"(%arg32) : (bf16) -> f32
      "linalg.yield"(%66) : (f32) -> ()
    }) : (tensor<1024xbf16>, tensor<1024xf32>) -> tensor<1024xf32>
    %42 = "linalg.generic"(%9, %35, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg29: f32, %arg30: f32, %arg31: f32):
      %65 = "arith.subf"(%arg29, %arg30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%65) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %43 = "linalg.generic"(%42, %42) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg27: f32, %arg28: f32):
      %64 = "math.exp"(%arg27) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%64) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %44 = "linalg.generic"(%43, %10, %43) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg24: f32, %arg25: f32, %arg26: f32):
      %63 = "arith.addf"(%arg24, %arg25) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%63) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %45 = "linalg.generic"(%10, %44, %10) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: f32, %arg22: f32, %arg23: f32):
      %62 = "arith.divf"(%arg21, %arg22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%62) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %46 = "linalg.generic"(%45, %35, %45) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg18: f32, %arg19: f32, %arg20: f32):
      %61 = "arith.mulf"(%arg18, %arg19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%61) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %47 = "linalg.generic"(%46, %12, %46) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32, %arg17: f32):
      %60 = "arith.minnumf"(%arg15, %arg16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%60) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %48 = "linalg.generic"(%41, %11, %41) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32, %arg14: f32):
      %59 = "arith.maxnumf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%59) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %49 = "linalg.generic"(%48, %12, %48) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32, %arg11: f32):
      %58 = "arith.minnumf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%58) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %50 = "linalg.generic"(%47, %49, %47) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %57 = "arith.mulf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%57) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %51 = "tensor.empty"() : () -> tensor<1024xbf16>
    %52 = "linalg.generic"(%50, %51) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: bf16):
      %56 = "arith.truncf"(%arg4) : (f32) -> bf16
      "linalg.yield"(%56) : (bf16) -> ()
    }) : (tensor<1024xf32>, tensor<1024xbf16>) -> tensor<1024xbf16>
    %53 = "arith.addi"(%20, %25) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %54 = "tensor.extract_slice"(%52, %29) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xbf16>, index) -> tensor<?xbf16>
    %55 = "memref.subview"(%arg0, %53, %29) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%54, %55) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

