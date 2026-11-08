"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, i32) -> (), sym_name = "rem_dividend_neg"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: i32):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "tensor.empty"() : () -> tensor<32xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<32xf32>) -> tensor<32xf32>
    %5 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %6 = "arith.index_cast"(%5) : (index) -> i32
    %7 = "arith.subi"(%6, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %8 = "arith.remsi"(%7, %arg1) : (i32, i32) -> i32
    %9 = "arith.muli"(%8, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %10 = "arith.index_cast"(%9) : (i32) -> index
    %11 = "memref.subview"(%arg0, %10) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 32>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<32xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%4, %11) <{writable}> : (tensor<32xf32>, memref<32xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

