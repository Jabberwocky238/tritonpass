#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, i32, memref<?xf32>, i32, i32, i32) -> (), sym_name = "true_div_func_tensor_scalar_kernel_rank_1"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: i32, %arg2: memref<?xf32>, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 64 : index}> : () -> index
    %3 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %4 = "arith.index_cast"(%3) : (index) -> i32
    %5 = "arith.extsi"(%4) : (i32) -> i64
    %6 = "arith.muli"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %7 = "arith.index_cast"(%6) : (i64) -> index
    %8 = "arith.addi"(%7, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %9 = "arith.index_cast"(%arg3) : (i32) -> index
    %10 = "arith.minsi"(%8, %9) : (index, index) -> index
    %11 = "arith.maxsi"(%10, %7) : (index, index) -> index
    %12 = "arith.subi"(%11, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xf32>
    "linalg.fill"(%0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      "linalg.yield"(%arg13) : (f32) -> ()
    }) : (f32, memref<64xf32>) -> ()
    %14 = "memref.subview"(%arg0, %7, %12) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %15 = "memref.subview"(%13, %12) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<64xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%14, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      "linalg.yield"(%arg11) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %16 = "bufferization.to_tensor"(%13) <{restrict, writable}> : (memref<64xf32>) -> tensor<64xf32>
    %17 = "arith.sitofp"(%arg1) : (i32) -> f32
    %18 = "tensor.empty"() : () -> tensor<64xf32>
    %19 = "linalg.fill"(%17, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    %20 = "linalg.generic"(%16, %19, %16) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %23 = "arith.divf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%23) : (f32) -> ()
    }) : (tensor<64xf32>, tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>
    %21 = "tensor.extract_slice"(%20, %12) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<64xf32>, index) -> tensor<?xf32>
    %22 = "memref.subview"(%arg2, %7, %12) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%21, %22) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

