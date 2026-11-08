#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32, i32) -> (), sym_name = "rsqrt_func_kernel_rank_1"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32, %arg3: i32, %arg4: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 32 : index}> : () -> index
    %3 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %4 = "tensor.empty"() : () -> tensor<32xf32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      "linalg.yield"(%arg14) : (f32) -> ()
    }) : (f32, tensor<32xf32>) -> tensor<32xf32>
    %6 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %7 = "arith.index_cast"(%6) : (index) -> i32
    %8 = "arith.extsi"(%7) : (i32) -> i64
    %9 = "arith.muli"(%8, %3) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %10 = "arith.index_cast"(%9) : (i64) -> index
    %11 = "arith.addi"(%10, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %12 = "arith.index_cast"(%arg2) : (i32) -> index
    %13 = "arith.minsi"(%11, %12) : (index, index) -> index
    %14 = "arith.maxsi"(%13, %10) : (index, index) -> index
    %15 = "arith.subi"(%14, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %16 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32xf32>
    "linalg.fill"(%0, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, memref<32xf32>) -> ()
    %17 = "memref.subview"(%arg0, %10, %15) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %18 = "memref.subview"(%16, %15) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<32xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%17, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %19 = "bufferization.to_tensor"(%16) <{restrict, writable}> : (memref<32xf32>) -> tensor<32xf32>
    %20 = "linalg.generic"(%19, %19) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %25 = "math.sqrt"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%25) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %21 = "linalg.generic"(%5, %20, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32, %arg7: f32):
      %24 = "arith.divf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%24) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %22 = "tensor.extract_slice"(%21, %15) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<32xf32>, index) -> tensor<?xf32>
    %23 = "memref.subview"(%arg1, %10, %15) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%22, %23) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

