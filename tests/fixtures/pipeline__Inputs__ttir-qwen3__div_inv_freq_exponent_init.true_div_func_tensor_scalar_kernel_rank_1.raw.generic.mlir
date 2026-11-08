#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, i32, memref<?xf32>, i32, i32, i32) -> (), sym_name = "true_div_func_tensor_scalar_kernel_rank_1"}> ({
  ^bb0(%arg7: memref<?xf32>, %arg8: i32, %arg9: memref<?xf32>, %arg10: i32, %arg11: i32, %arg12: i32):
    %5 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %6 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %7 = "arith.constant"() <{value = 64 : index}> : () -> index
    %8 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %9 = "arith.index_cast"(%8) : (index) -> i32
    %10 = "arith.extsi"(%9) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__i32_c64}> : () -> ()
    %11 = "arith.muli"(%10, %6) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %12 = "arith.index_cast"(%11) : (i64) -> index
    %13 = "arith.addi"(%12, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %14 = "arith.index_cast"(%arg10) : (i32) -> index
    %15 = "arith.minsi"(%13, %14) : (index, index) -> index
    %16 = "arith.maxsi"(%15, %12) : (index, index) -> index
    %17 = "arith.subi"(%16, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %18 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xf32>
    "linalg.fill"(%5, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (f32, memref<64xf32>) -> ()
    %19 = "memref.subview"(%arg7, %12, %17) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %20 = "memref.subview"(%18, %17) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<64xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%19, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      "linalg.yield"(%arg13) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %21 = "bufferization.to_tensor"(%18) <{restrict, writable}> : (memref<64xf32>) -> tensor<64xf32>
    %22 = "func.call"(%21, %arg8) <{callee = @flag_gems.ops.div.true_div_func_tensor_scalar__fp32S64S_i32}> : (tensor<64xf32>, i32) -> tensor<64xf32>
    %23 = "tensor.extract_slice"(%22, %17) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<64xf32>, index) -> tensor<?xf32>
    %24 = "memref.subview"(%arg9, %12, %17) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%23, %24) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__i32_c64", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<64xf32>, i32) -> tensor<64xf32>, sym_name = "flag_gems.ops.div.true_div_func_tensor_scalar__fp32S64S_i32", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<64xf32>, %arg1: i32):
    %0 = "arith.sitofp"(%arg1) : (i32) -> f32
    %1 = "tensor.empty"() : () -> tensor<64xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    %3 = "linalg.generic"(%arg0, %2, %arg0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %4 = "arith.divf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%4) : (f32) -> ()
    }) : (tensor<64xf32>, tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>
    "func.return"(%3) : (tensor<64xf32>) -> ()
  }) : () -> ()
}) : () -> ()

