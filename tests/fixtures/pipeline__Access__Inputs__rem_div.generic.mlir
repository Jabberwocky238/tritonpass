"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32) -> (), sym_name = "rem_div"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %2 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %3 = "arith.index_cast"(%2) : (index) -> i32
    %4 = "arith.remsi"(%3, %arg2) : (i32, i32) -> i32
    %5 = "arith.divsi"(%3, %arg2) : (i32, i32) -> i32
    %6 = "arith.muli"(%4, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %7 = "arith.muli"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %8 = "arith.addi"(%6, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %9 = "arith.index_cast"(%8) : (i32) -> index
    %10 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
    %11 = "memref.subview"(%arg0, %9) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 16>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<16xf32, strided<[1], offset: ?>>
    "linalg.copy"(%11, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (memref<16xf32, strided<[1], offset: ?>>, memref<16xf32>) -> ()
    %12 = "bufferization.to_tensor"(%10) <{restrict, writable}> : (memref<16xf32>) -> tensor<16xf32>
    %13 = "memref.subview"(%arg1, %9) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 16>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<16xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%12, %13) <{writable}> : (tensor<16xf32>, memref<16xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

