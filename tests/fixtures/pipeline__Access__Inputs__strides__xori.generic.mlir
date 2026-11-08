"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32, i32, i32) -> (), sym_name = "k"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "arith.muli"(%2, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %5 = "arith.xori"(%3, %4) : (i32, i32) -> i32
    %6 = "arith.index_cast"(%5) : (i32) -> index
    %7 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %8 = "arith.index_cast"(%7) : (i32) -> index
    %9 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32xf32>
    %10 = "memref.subview"(%arg0, %6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 32>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<32xf32, strided<[1], offset: ?>>
    "linalg.copy"(%10, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (memref<32xf32, strided<[1], offset: ?>>, memref<32xf32>) -> ()
    %11 = "bufferization.to_tensor"(%9) <{restrict, writable}> : (memref<32xf32>) -> tensor<32xf32>
    %12 = "memref.subview"(%arg1, %8) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 32>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<32xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%11, %12) <{writable}> : (tensor<32xf32>, memref<32xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

