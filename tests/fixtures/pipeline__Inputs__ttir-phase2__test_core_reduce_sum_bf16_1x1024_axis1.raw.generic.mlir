"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg5: memref<?xbf16>, %arg6: memref<?xbf16>):
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
    %4 = "memref.subview"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1024>, static_strides = array<i64: 1>}> : (memref<?xbf16>) -> memref<1024xbf16, strided<[1]>>
    "linalg.copy"(%4, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: bf16, %arg8: bf16):
      "linalg.yield"(%arg7) : (bf16) -> ()
    }) : (memref<1024xbf16, strided<[1]>>, memref<1024xbf16>) -> ()
    %5 = "bufferization.to_tensor"(%3) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
    %6 = "tensor.expand_shape"(%5) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 1024>}> : (tensor<1024xbf16>) -> tensor<1x1024xbf16>
    %7 = "func.call"(%6) <{callee = @triton.language.standard.sum__bf16S1_1024S_c1_cFalse_cNone}> : (tensor<1x1024xbf16>) -> tensor<1xbf16>
    %8 = "memref.reinterpret_cast"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xbf16>) -> memref<1099511627776xbf16, strided<[1]>>
    %9 = "memref.subview"(%8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<1099511627776xbf16, strided<[1]>>) -> memref<1xbf16, strided<[1]>>
    "bufferization.materialize_in_destination"(%7, %9) <{writable}> : (tensor<1xbf16>, memref<1xbf16, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x1024xbf16>) -> tensor<1xbf16>, sym_name = "triton.language.standard.sum__bf16S1_1024S_c1_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<1x1024xbf16>):
    %1 = "tt.reduce"(%arg2) <{axis = 1 : i32}> ({
    ^bb0(%arg3: bf16, %arg4: bf16):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__bf16_bf16}> : (bf16, bf16) -> bf16
      "tt.reduce.return"(%2) : (bf16) -> ()
    }) : (tensor<1x1024xbf16>) -> tensor<1xbf16>
    "func.return"(%1) : (tensor<1xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (bf16, bf16) -> bf16, sym_name = "triton.language.standard._sum_combine__bf16_bf16", sym_visibility = "private"}> ({
  ^bb0(%arg0: bf16, %arg1: bf16):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
    "func.return"(%0) : (bf16) -> ()
  }) : () -> ()
}) : () -> ()

