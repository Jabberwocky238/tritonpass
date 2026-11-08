"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32, i32, i32) -> (), sym_name = "negative_factor"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %1 = "arith.index_cast"(%0) : (index) -> i32
    %2 = "arith.subi"(%arg4, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %3 = "arith.muli"(%2, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "arith.index_cast"(%3) : (i32) -> index
    %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32xf32>
    %6 = "memref.subview"(%arg0, %4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 32>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<32xf32, strided<[1], offset: ?>>
    "linalg.copy"(%6, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (memref<32xf32, strided<[1], offset: ?>>, memref<32xf32>) -> ()
    %7 = "bufferization.to_tensor"(%5) <{restrict, writable}> : (memref<32xf32>) -> tensor<32xf32>
    %8 = "memref.subview"(%arg1, %4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 32>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<32xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%7, %8) <{writable}> : (tensor<32xf32>, memref<32xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

