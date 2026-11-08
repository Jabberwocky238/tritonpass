#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, i32, i32, i32) -> (), sym_name = "silu_forward_kernel_rank_1"}> ({
  ^bb0(%arg18: memref<?xbf16>, %arg19: memref<?xbf16>, %arg20: i32, %arg21: i32, %arg22: i32):
    %15 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %16 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %17 = "arith.constant"() <{value = 512 : index}> : () -> index
    %18 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %19 = "arith.index_cast"(%18) : (index) -> i32
    %20 = "arith.extsi"(%19) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__i32_c512}> : () -> ()
    %21 = "arith.muli"(%20, %16) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %22 = "arith.index_cast"(%21) : (i64) -> index
    %23 = "arith.addi"(%22, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %24 = "arith.index_cast"(%arg20) : (i32) -> index
    %25 = "arith.minsi"(%23, %24) : (index, index) -> index
    %26 = "arith.maxsi"(%25, %22) : (index, index) -> index
    %27 = "arith.subi"(%26, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %28 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%15, %28) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg27: bf16, %arg28: bf16):
      "linalg.yield"(%arg27) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %29 = "memref.subview"(%arg18, %22, %27) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %30 = "memref.subview"(%28, %27) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%29, %30) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: bf16, %arg26: bf16):
      "linalg.yield"(%arg25) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %31 = "bufferization.to_tensor"(%28) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %32 = "func.call"(%31) <{callee = @flag_gems.ops.silu.silu_forward__bf16S512S}> : (tensor<512xbf16>) -> tensor<512xf32>
    %33 = "tensor.empty"() : () -> tensor<512xbf16>
    %34 = "linalg.generic"(%32, %33) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: f32, %arg24: bf16):
      %37 = "arith.truncf"(%arg23) : (f32) -> bf16
      "linalg.yield"(%37) : (bf16) -> ()
    }) : (tensor<512xf32>, tensor<512xbf16>) -> tensor<512xbf16>
    %35 = "tensor.extract_slice"(%34, %27) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<512xbf16>, index) -> tensor<?xbf16>
    %36 = "memref.subview"(%arg19, %22, %27) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%35, %36) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__i32_c512", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<512xbf16>) -> tensor<512xf32>, sym_name = "flag_gems.ops.silu.silu_forward__bf16S512S", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<512xbf16>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "tensor.empty"() : () -> tensor<512xf32>
    %3 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: f32, %arg17: f32):
      "linalg.yield"(%arg16) : (f32) -> ()
    }) : (f32, tensor<512xf32>) -> tensor<512xf32>
    %4 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      "linalg.yield"(%arg14) : (f32) -> ()
    }) : (f32, tensor<512xf32>) -> tensor<512xf32>
    %5 = "linalg.generic"(%arg0, %2) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: bf16, %arg13: f32):
      %14 = "arith.extf"(%arg12) : (bf16) -> f32
      "linalg.yield"(%14) : (f32) -> ()
    }) : (tensor<512xbf16>, tensor<512xf32>) -> tensor<512xf32>
    %6 = "linalg.generic"(%4, %5, %4) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32, %arg11: f32):
      %13 = "arith.subf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%13) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
    %7 = "linalg.generic"(%6, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32):
      %12 = "math.exp"(%arg7) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%12) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
    %8 = "linalg.generic"(%7, %3, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32, %arg6: f32):
      %11 = "arith.addf"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%11) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
    %9 = "linalg.generic"(%5, %8, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %10 = "arith.divf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
    "func.return"(%9) : (tensor<512xf32>) -> ()
  }) : () -> ()
}) : () -> ()

