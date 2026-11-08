#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, i32, i32, i32) -> (), sym_name = "silu_forward_kernel_rank_1"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: i32, %arg3: i32, %arg4: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 512 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %5 = "tensor.empty"() : () -> tensor<512xf32>
    %6 = "linalg.fill"(%1, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg26: f32, %arg27: f32):
      "linalg.yield"(%arg26) : (f32) -> ()
    }) : (f32, tensor<512xf32>) -> tensor<512xf32>
    %7 = "linalg.fill"(%3, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: f32, %arg25: f32):
      "linalg.yield"(%arg24) : (f32) -> ()
    }) : (f32, tensor<512xf32>) -> tensor<512xf32>
    %8 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %9 = "arith.index_cast"(%8) : (index) -> i32
    %10 = "arith.extsi"(%9) : (i32) -> i64
    %11 = "arith.muli"(%10, %4) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %12 = "arith.index_cast"(%11) : (i64) -> index
    %13 = "arith.addi"(%12, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %14 = "arith.index_cast"(%arg2) : (i32) -> index
    %15 = "arith.minsi"(%13, %14) : (index, index) -> index
    %16 = "arith.maxsi"(%15, %12) : (index, index) -> index
    %17 = "arith.subi"(%16, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %18 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%0, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg22: bf16, %arg23: bf16):
      "linalg.yield"(%arg22) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %19 = "memref.subview"(%arg0, %12, %17) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %20 = "memref.subview"(%18, %17) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%19, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: bf16, %arg21: bf16):
      "linalg.yield"(%arg20) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %21 = "bufferization.to_tensor"(%18) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %22 = "linalg.generic"(%21, %5) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: bf16, %arg19: f32):
      %36 = "arith.extf"(%arg18) : (bf16) -> f32
      "linalg.yield"(%36) : (f32) -> ()
    }) : (tensor<512xbf16>, tensor<512xf32>) -> tensor<512xf32>
    %23 = "linalg.generic"(%6, %22, %6) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32, %arg17: f32):
      %35 = "arith.subf"(%arg15, %arg16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%35) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
    %24 = "linalg.generic"(%23, %23) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      %34 = "math.exp"(%arg13) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%34) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
    %25 = "linalg.generic"(%24, %7, %24) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32, %arg12: f32):
      %33 = "arith.addf"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%33) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
    %26 = "linalg.generic"(%22, %25, %22) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32, %arg9: f32):
      %32 = "arith.divf"(%arg7, %arg8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%32) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
    %27 = "tensor.empty"() : () -> tensor<512xbf16>
    %28 = "linalg.generic"(%26, %27) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: bf16):
      %31 = "arith.truncf"(%arg5) : (f32) -> bf16
      "linalg.yield"(%31) : (bf16) -> ()
    }) : (tensor<512xf32>, tensor<512xbf16>) -> tensor<512xbf16>
    %29 = "tensor.extract_slice"(%28, %17) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<512xbf16>, index) -> tensor<?xbf16>
    %30 = "memref.subview"(%arg1, %12, %17) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%29, %30) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

