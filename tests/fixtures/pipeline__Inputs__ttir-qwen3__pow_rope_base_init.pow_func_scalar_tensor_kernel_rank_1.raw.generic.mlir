#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (f32, memref<?xf32>, memref<?xf32>, i32, i32, i32) -> (), sym_name = "pow_func_scalar_tensor_kernel_rank_1"}> ({
  ^bb0(%arg7: f32, %arg8: memref<?xf32>, %arg9: memref<?xf32>, %arg10: i32, %arg11: i32, %arg12: i32):
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %6 = "arith.constant"() <{value = 64 : index}> : () -> index
    %7 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %8 = "arith.index_cast"(%7) : (index) -> i32
    %9 = "arith.extsi"(%8) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__i32_c64}> : () -> ()
    %10 = "arith.muli"(%9, %5) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %11 = "arith.index_cast"(%10) : (i64) -> index
    %12 = "arith.addi"(%11, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %13 = "arith.index_cast"(%arg10) : (i32) -> index
    %14 = "arith.minsi"(%12, %13) : (index, index) -> index
    %15 = "arith.maxsi"(%14, %11) : (index, index) -> index
    %16 = "arith.subi"(%15, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %17 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xf32>
    "linalg.fill"(%4, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (f32, memref<64xf32>) -> ()
    %18 = "memref.subview"(%arg8, %11, %16) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %19 = "memref.subview"(%17, %16) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<64xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%18, %19) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      "linalg.yield"(%arg13) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %20 = "bufferization.to_tensor"(%17) <{restrict, writable}> : (memref<64xf32>) -> tensor<64xf32>
    %21 = "func.call"(%arg7, %20) <{callee = @flag_gems.ops.pow.pow_func_scalar_tensor__fp32_fp32S64S}> : (f32, tensor<64xf32>) -> tensor<64xf32>
    %22 = "tensor.extract_slice"(%21, %16) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<64xf32>, index) -> tensor<?xf32>
    %23 = "memref.subview"(%arg9, %11, %16) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%22, %23) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__i32_c64", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, tensor<64xf32>) -> tensor<64xf32>, sym_name = "flag_gems.ops.pow.pow_func_scalar_tensor__fp32_fp32S64S", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: tensor<64xf32>):
    %0 = "tensor.empty"() : () -> tensor<64xf32>
    %1 = "linalg.fill"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    %2 = "linalg.generic"(%1, %arg1, %1) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %3 = "math.powf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) : (tensor<64xf32>, tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>
    "func.return"(%2) : (tensor<64xf32>) -> ()
  }) : () -> ()
}) : () -> ()

