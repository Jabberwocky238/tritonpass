"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>) -> (), sym_name = "kernel_dtype"}> ({
  ^bb0(%arg0: memref<?xi32>):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "tensor.empty"() : () -> tensor<1024xi32>
    %3 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: i32, %arg8: i32):
      "linalg.yield"(%arg7) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %4 = "tensor.empty"() : () -> tensor<i32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: i32, %arg6: i32):
      "linalg.yield"(%arg5) : (i32) -> ()
    }) : (i32, tensor<i32>) -> tensor<i32>
    %6 = "linalg.reduce"(%3, %5) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg3: i32, %arg4: i32):
      %11 = "arith.addi"(%arg3, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%11) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<i32>) -> tensor<i32>
    %7 = "tensor.extract"(%6) : (tensor<i32>) -> i32
    %8 = "tensor.empty"() : () -> tensor<1xi32>
    %9 = "linalg.fill"(%7, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i32, %arg2: i32):
      "linalg.yield"(%arg1) : (i32) -> ()
    }) : (i32, tensor<1xi32>) -> tensor<1xi32>
    %10 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1xi32, strided<[1]>>
    "bufferization.materialize_in_destination"(%9, %10) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

