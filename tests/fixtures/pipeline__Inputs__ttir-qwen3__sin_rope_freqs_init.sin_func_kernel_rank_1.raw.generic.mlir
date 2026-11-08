#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32, i32) -> (), sym_name = "sin_func_kernel_rank_1"}> ({
  ^bb0(%arg3: memref<?xf32>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32):
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %4 = "arith.constant"() <{value = 512 : index}> : () -> index
    %5 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %6 = "arith.index_cast"(%5) : (index) -> i32
    %7 = "arith.extsi"(%6) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__i32_c512}> : () -> ()
    %8 = "arith.muli"(%7, %3) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %9 = "arith.index_cast"(%8) : (i64) -> index
    %10 = "arith.addi"(%9, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %11 = "arith.index_cast"(%arg5) : (i32) -> index
    %12 = "arith.minsi"(%10, %11) : (index, index) -> index
    %13 = "arith.maxsi"(%12, %9) : (index, index) -> index
    %14 = "arith.subi"(%13, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %15 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
    "linalg.fill"(%2, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (f32, memref<512xf32>) -> ()
    %16 = "memref.subview"(%arg3, %9, %14) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %17 = "memref.subview"(%15, %14) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%16, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %18 = "bufferization.to_tensor"(%15) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
    %19 = "func.call"(%18) <{callee = @flag_gems.ops.sin.sin_func__fp32S512S}> : (tensor<512xf32>) -> tensor<512xf32>
    %20 = "tensor.extract_slice"(%19, %14) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<512xf32>, index) -> tensor<?xf32>
    %21 = "memref.subview"(%arg4, %9, %14) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%20, %21) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__i32_c512", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<512xf32>) -> tensor<512xf32>, sym_name = "flag_gems.ops.sin.sin_func__fp32S512S", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<512xf32>):
    %0 = "linalg.generic"(%arg0, %arg0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %1 = "math.sin"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%1) : (f32) -> ()
    }) : (tensor<512xf32>, tensor<512xf32>) -> tensor<512xf32>
    "func.return"(%0) : (tensor<512xf32>) -> ()
  }) : () -> ()
}) : () -> ()

