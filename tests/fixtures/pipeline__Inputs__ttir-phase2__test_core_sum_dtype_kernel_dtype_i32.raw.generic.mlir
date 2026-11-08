"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>) -> (), sym_name = "kernel_dtype"}> ({
  ^bb0(%arg5: memref<?xi32>):
    %4 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %5 = "tensor.empty"() : () -> tensor<32x32xi32>
    %6 = "linalg.fill"(%4, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: i32, %arg9: i32):
      "linalg.yield"(%arg8) : (i32) -> ()
    }) : (i32, tensor<32x32xi32>) -> tensor<32x32xi32>
    %7 = "func.call"(%6) <{callee = @triton.language.standard.sum__i32S32_32S_cNone_cFalse_cNone}> : (tensor<32x32xi32>) -> i32
    %8 = "tensor.empty"() : () -> tensor<1xi32>
    %9 = "linalg.fill"(%7, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: i32, %arg7: i32):
      "linalg.yield"(%arg6) : (i32) -> ()
    }) : (i32, tensor<1xi32>) -> tensor<1xi32>
    %10 = "memref.subview"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1xi32, strided<[1]>>
    "bufferization.materialize_in_destination"(%9, %10) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<32x32xi32>) -> i32, sym_name = "triton.language.standard.sum__i32S32_32S_cNone_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<32x32xi32>):
    %1 = "tensor.collapse_shape"(%arg2) <{reassociation = [[0, 1]]}> : (tensor<32x32xi32>) -> tensor<1024xi32>
    %2 = "tt.reduce"(%1) <{axis = 0 : i32}> ({
    ^bb0(%arg3: i32, %arg4: i32):
      %3 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__i32_i32}> : (i32, i32) -> i32
      "tt.reduce.return"(%3) : (i32) -> ()
    }) : (tensor<1024xi32>) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "triton.language.standard._sum_combine__i32_i32", sym_visibility = "private"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.addi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

