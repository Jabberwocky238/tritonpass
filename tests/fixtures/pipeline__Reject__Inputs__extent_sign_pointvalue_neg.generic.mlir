"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, i32) -> (), sym_name = "pointvalue_neg"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: i32):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "tensor.empty"() : () -> tensor<32xf32>
    %5 = "linalg.fill"(%0, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<32xf32>) -> tensor<32xf32>
    %6 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %7 = "arith.index_cast"(%6) : (index) -> i32
    %8 = "arith.subi"(%arg1, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %9 = "arith.divsi"(%8, %2) : (i32, i32) -> i32
    %10 = "arith.remsi"(%7, %9) : (i32, i32) -> i32
    %11 = "arith.muli"(%10, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %12 = "arith.index_cast"(%11) : (i32) -> index
    %13 = "memref.subview"(%arg0, %12) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 32>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<32xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%5, %13) <{writable}> : (tensor<32xf32>, memref<32xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

