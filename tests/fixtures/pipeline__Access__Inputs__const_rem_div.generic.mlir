"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "const_rem_div"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>):
    %0 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %3 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %4 = "arith.index_cast"(%3) : (index) -> i32
    %5 = "arith.remsi"(%4, %0) : (i32, i32) -> i32
    %6 = "arith.divsi"(%4, %0) : (i32, i32) -> i32
    %7 = "arith.muli"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %8 = "arith.muli"(%6, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %9 = "arith.addi"(%7, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %10 = "arith.index_cast"(%9) : (i32) -> index
    %11 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8xf32>
    %12 = "memref.subview"(%arg0, %10) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 8>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<8xf32, strided<[1], offset: ?>>
    "linalg.copy"(%12, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (memref<8xf32, strided<[1], offset: ?>>, memref<8xf32>) -> ()
    %13 = "bufferization.to_tensor"(%11) <{restrict, writable}> : (memref<8xf32>) -> tensor<8xf32>
    %14 = "memref.subview"(%arg1, %10) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 8>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<8xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%13, %14) <{writable}> : (tensor<8xf32>, memref<8xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

