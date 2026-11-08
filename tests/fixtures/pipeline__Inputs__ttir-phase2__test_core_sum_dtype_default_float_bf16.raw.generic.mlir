"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>) -> (), sym_name = "kernel_default_float"}> ({
  ^bb0(%arg5: memref<?xbf16>):
    %4 = "arith.constant"() <{value = 1.000000e+00 : bf16}> : () -> bf16
    %5 = "tensor.empty"() : () -> tensor<32x32xbf16>
    %6 = "linalg.fill"(%4, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: bf16, %arg9: bf16):
      "linalg.yield"(%arg8) : (bf16) -> ()
    }) : (bf16, tensor<32x32xbf16>) -> tensor<32x32xbf16>
    %7 = "func.call"(%6) <{callee = @triton.language.standard.sum__bf16S32_32S_cNone_cFalse_cNone}> : (tensor<32x32xbf16>) -> bf16
    %8 = "tensor.empty"() : () -> tensor<1xbf16>
    %9 = "linalg.fill"(%7, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: bf16, %arg7: bf16):
      "linalg.yield"(%arg6) : (bf16) -> ()
    }) : (bf16, tensor<1xbf16>) -> tensor<1xbf16>
    %10 = "memref.subview"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xbf16>) -> memref<1xbf16, strided<[1]>>
    "bufferization.materialize_in_destination"(%9, %10) <{writable}> : (tensor<1xbf16>, memref<1xbf16, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<32x32xbf16>) -> bf16, sym_name = "triton.language.standard.sum__bf16S32_32S_cNone_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<32x32xbf16>):
    %1 = "tensor.collapse_shape"(%arg2) <{reassociation = [[0, 1]]}> : (tensor<32x32xbf16>) -> tensor<1024xbf16>
    %2 = "tt.reduce"(%1) <{axis = 0 : i32}> ({
    ^bb0(%arg3: bf16, %arg4: bf16):
      %3 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__bf16_bf16}> : (bf16, bf16) -> bf16
      "tt.reduce.return"(%3) : (bf16) -> ()
    }) : (tensor<1024xbf16>) -> bf16
    "func.return"(%2) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (bf16, bf16) -> bf16, sym_name = "triton.language.standard._sum_combine__bf16_bf16", sym_visibility = "private"}> ({
  ^bb0(%arg0: bf16, %arg1: bf16):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
    "func.return"(%0) : (bf16) -> ()
  }) : () -> ()
}) : () -> ()

