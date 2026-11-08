"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, i32, i32) -> (), sym_name = "runtime_sub_rem"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: i32, %arg2: i32):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "tensor.empty"() : () -> tensor<32xf32>
    %3 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<32xf32>) -> tensor<32xf32>
    %4 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %5 = "arith.index_cast"(%4) : (index) -> i32
    %6 = "arith.subi"(%arg1, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %7 = "arith.remsi"(%5, %6) : (i32, i32) -> i32
    %8 = "arith.muli"(%7, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %9 = "arith.index_cast"(%8) : (i32) -> index
    %10 = "memref.subview"(%arg0, %9) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 32>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<32xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%3, %10) <{writable}> : (tensor<32xf32>, memref<32xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

