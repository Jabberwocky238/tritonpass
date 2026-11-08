"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32) -> (), sym_name = "rem_only"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.remsi"(%2, %arg2) : (i32, i32) -> i32
    %4 = "arith.muli"(%3, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %5 = "arith.index_cast"(%4) : (i32) -> index
    %6 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
    %7 = "memref.subview"(%arg0, %5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 16>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<16xf32, strided<[1], offset: ?>>
    "linalg.copy"(%7, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (memref<16xf32, strided<[1], offset: ?>>, memref<16xf32>) -> ()
    %8 = "bufferization.to_tensor"(%6) <{restrict, writable}> : (memref<16xf32>) -> tensor<16xf32>
    %9 = "memref.subview"(%arg1, %5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 16>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<16xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%8, %9) <{writable}> : (tensor<16xf32>, memref<16xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

