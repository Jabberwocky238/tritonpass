"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg5: memref<?xbf16>, %arg6: memref<?xbf16>):
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xbf16>
    %4 = "memref.subview"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xbf16>) -> memref<128xbf16, strided<[1]>>
    "linalg.copy"(%4, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: bf16, %arg10: bf16):
      "linalg.yield"(%arg9) : (bf16) -> ()
    }) : (memref<128xbf16, strided<[1]>>, memref<128xbf16>) -> ()
    %5 = "bufferization.to_tensor"(%3) <{restrict, writable}> : (memref<128xbf16>) -> tensor<128xbf16>
    %6 = "func.call"(%5) <{callee = @triton.language.standard.sum__bf16S128S_c0_cFalse_cNone}> : (tensor<128xbf16>) -> bf16
    %7 = "tensor.empty"() : () -> tensor<1xbf16>
    %8 = "linalg.fill"(%6, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: bf16, %arg8: bf16):
      "linalg.yield"(%arg7) : (bf16) -> ()
    }) : (bf16, tensor<1xbf16>) -> tensor<1xbf16>
    %9 = "memref.subview"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xbf16>) -> memref<1xbf16, strided<[1]>>
    "bufferization.materialize_in_destination"(%8, %9) <{writable}> : (tensor<1xbf16>, memref<1xbf16, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<128xbf16>) -> bf16, sym_name = "triton.language.standard.sum__bf16S128S_c0_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<128xbf16>):
    %1 = "tt.reduce"(%arg2) <{axis = 0 : i32}> ({
    ^bb0(%arg3: bf16, %arg4: bf16):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__bf16_bf16}> : (bf16, bf16) -> bf16
      "tt.reduce.return"(%2) : (bf16) -> ()
    }) : (tensor<128xbf16>) -> bf16
    "func.return"(%1) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (bf16, bf16) -> bf16, sym_name = "triton.language.standard._sum_combine__bf16_bf16", sym_visibility = "private"}> ({
  ^bb0(%arg0: bf16, %arg1: bf16):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
    "func.return"(%0) : (bf16) -> ()
  }) : () -> ()
}) : () -> ()

