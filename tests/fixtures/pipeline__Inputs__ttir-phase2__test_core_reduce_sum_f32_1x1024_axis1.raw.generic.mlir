"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg5: memref<?xf32>, %arg6: memref<?xf32>):
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
    %4 = "memref.subview"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1024>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<1024xf32, strided<[1]>>
    "linalg.copy"(%4, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32):
      "linalg.yield"(%arg7) : (f32) -> ()
    }) : (memref<1024xf32, strided<[1]>>, memref<1024xf32>) -> ()
    %5 = "bufferization.to_tensor"(%3) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
    %6 = "tensor.expand_shape"(%5) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 1024>}> : (tensor<1024xf32>) -> tensor<1x1024xf32>
    %7 = "func.call"(%6) <{callee = @triton.language.standard.sum__fp32S1_1024S_c1_cFalse_cNone}> : (tensor<1x1024xf32>) -> tensor<1xf32>
    %8 = "memref.reinterpret_cast"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<1099511627776xf32, strided<[1]>>
    %9 = "memref.subview"(%8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<1099511627776xf32, strided<[1]>>) -> memref<1xf32, strided<[1]>>
    "bufferization.materialize_in_destination"(%7, %9) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x1024xf32>) -> tensor<1xf32>, sym_name = "triton.language.standard.sum__fp32S1_1024S_c1_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<1x1024xf32>):
    %1 = "tt.reduce"(%arg2) <{axis = 1 : i32}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%2) : (f32) -> ()
    }) : (tensor<1x1024xf32>) -> tensor<1xf32>
    "func.return"(%1) : (tensor<1xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

