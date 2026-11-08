"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32) -> (), sym_name = "reduce_kernel_2d"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32, %arg3: i32):
    %0 = "arith.constant"() <{value = 16 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %3 = "arith.index_cast"(%2) : (index) -> i32
    %4 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
    %5 = "arith.index_cast"(%4) : (index) -> i32
    %6 = "arith.muli"(%arg3, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %7 = "arith.muli"(%arg2, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %8 = "arith.index_cast"(%7) : (i32) -> index
    %9 = "arith.addi"(%8, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %10 = "arith.index_cast"(%6) : (i32) -> index
    %11 = "arith.minsi"(%9, %10) : (index, index) -> index
    %12 = "arith.maxsi"(%11, %8) : (index, index) -> index
    %13 = "arith.subi"(%12, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %14 = "arith.minsi"(%13, %0) : (index, index) -> index
    %15 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
    "linalg.fill"(%1, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, memref<16xf32>) -> ()
    %16 = "memref.subview"(%arg0, %8, %14) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %17 = "memref.subview"(%15, %14) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<16xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%16, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %18 = "bufferization.to_tensor"(%15) <{restrict, writable}> : (memref<16xf32>) -> tensor<16xf32>
    %19 = "tensor.empty"() : () -> tensor<f32>
    %20 = "linalg.fill"(%1, %19) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %21 = "linalg.reduce"(%18, %20) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      %26 = "arith.addf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%26) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<f32>) -> tensor<f32>
    %22 = "tensor.extract"(%21) : (tensor<f32>) -> f32
    %23 = "tensor.empty"() : () -> tensor<1xf32>
    %24 = "linalg.fill"(%22, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %25 = "memref.subview"(%arg1, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%24, %25) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

