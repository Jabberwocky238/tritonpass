#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, i32, memref<?xbf16>, i32, i32, i32, i32) -> (), sym_name = "add_func_kernel_rank_2"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: i32, %arg3: memref<?xbf16>, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %1 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 512 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 511 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 4096 : i64}> : () -> i64
    %5 = "arith.constant"() <{value = 512 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "arith.constant"() <{value = 0 : index}> : () -> index
    %8 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %9 = "arith.index_cast"(%8) : (index) -> i32
    %10 = "arith.extsi"(%9) : (i32) -> i64
    %11 = "arith.addi"(%arg5, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %12 = "arith.divsi"(%11, %2) : (i32, i32) -> i32
    %13 = "arith.extsi"(%12) : (i32) -> i64
    %14 = "arith.remsi"(%10, %13) : (i64, i64) -> i64
    %15 = "arith.divsi"(%10, %13) : (i64, i64) -> i64
    %16 = "arith.muli"(%14, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %17 = "arith.index_cast"(%16) : (i64) -> index
    %18 = "arith.extsi"(%arg4) : (i32) -> i64
    %19 = "arith.cmpi"(%15, %18) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %20 = "arith.muli"(%15, %4) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %21 = "arith.index_cast"(%20) : (i64) -> index
    %22 = "arith.addi"(%17, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %23 = "arith.index_cast"(%arg5) : (i32) -> index
    %24 = "arith.minsi"(%22, %23) : (index, index) -> index
    %25 = "arith.maxsi"(%24, %17) : (index, index) -> index
    %26 = "arith.subi"(%25, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %27 = "arith.select"(%19, %6, %7) : (i1, index, index) -> index
    %28 = "arith.select"(%19, %26, %7) : (i1, index, index) -> index
    %29 = "arith.muli"(%28, %27) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %30 = "arith.addi"(%17, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %31 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%0, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg28: bf16, %arg29: bf16):
      "linalg.yield"(%arg28) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %32 = "memref.subview"(%arg0, %30, %29) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %33 = "memref.subview"(%31, %29) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%32, %33) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg26: bf16, %arg27: bf16):
      "linalg.yield"(%arg26) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %34 = "bufferization.to_tensor"(%31) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %35 = "tensor.expand_shape"(%34) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 512>}> : (tensor<512xbf16>) -> tensor<1x512xbf16>
    %36 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%0, %36) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: bf16, %arg25: bf16):
      "linalg.yield"(%arg24) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %37 = "memref.subview"(%arg1, %17, %29) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %38 = "memref.subview"(%36, %29) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%37, %38) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg22: bf16, %arg23: bf16):
      "linalg.yield"(%arg22) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %39 = "bufferization.to_tensor"(%36) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %40 = "tensor.expand_shape"(%39) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 512>}> : (tensor<512xbf16>) -> tensor<1x512xbf16>
    %41 = "tensor.empty"() : () -> tensor<1x512xf32>
    %42 = "linalg.generic"(%40, %41) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: bf16, %arg21: f32):
      %57 = "arith.extf"(%arg20) : (bf16) -> f32
      "linalg.yield"(%57) : (f32) -> ()
    }) : (tensor<1x512xbf16>, tensor<1x512xf32>) -> tensor<1x512xf32>
    %43 = "arith.sitofp"(%arg2) : (i32) -> f32
    %44 = "linalg.fill"(%43, %41) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: f32, %arg19: f32):
      "linalg.yield"(%arg18) : (f32) -> ()
    }) : (f32, tensor<1x512xf32>) -> tensor<1x512xf32>
    %45 = "linalg.generic"(%42, %44, %42) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32, %arg17: f32):
      %56 = "arith.mulf"(%arg15, %arg16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%56) : (f32) -> ()
    }) : (tensor<1x512xf32>, tensor<1x512xf32>, tensor<1x512xf32>) -> tensor<1x512xf32>
    %46 = "linalg.generic"(%35, %41) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: bf16, %arg14: f32):
      %55 = "arith.extf"(%arg13) : (bf16) -> f32
      "linalg.yield"(%55) : (f32) -> ()
    }) : (tensor<1x512xbf16>, tensor<1x512xf32>) -> tensor<1x512xf32>
    %47 = "linalg.generic"(%46, %45, %46) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32, %arg12: f32):
      %54 = "arith.addf"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%54) : (f32) -> ()
    }) : (tensor<1x512xf32>, tensor<1x512xf32>, tensor<1x512xf32>) -> tensor<1x512xf32>
    %48 = "tensor.empty"() : () -> tensor<1x512xbf16>
    %49 = "linalg.generic"(%47, %48) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: bf16):
      %53 = "arith.truncf"(%arg8) : (f32) -> bf16
      "linalg.yield"(%53) : (bf16) -> ()
    }) : (tensor<1x512xf32>, tensor<1x512xbf16>) -> tensor<1x512xbf16>
    %50 = "tensor.collapse_shape"(%49) <{reassociation = [[0, 1]]}> : (tensor<1x512xbf16>) -> tensor<512xbf16>
    %51 = "tensor.extract_slice"(%50, %29) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<512xbf16>, index) -> tensor<?xbf16>
    %52 = "memref.subview"(%arg3, %30, %29) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%51, %52) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

