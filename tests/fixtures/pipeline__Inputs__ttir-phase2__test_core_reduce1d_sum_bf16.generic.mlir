"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xbf16>
    %2 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xbf16>) -> memref<128xbf16, strided<[1]>>
    "linalg.copy"(%2, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: bf16, %arg9: bf16):
      "linalg.yield"(%arg8) : (bf16) -> ()
    }) : (memref<128xbf16, strided<[1]>>, memref<128xbf16>) -> ()
    %3 = "bufferization.to_tensor"(%1) <{restrict, writable}> : (memref<128xbf16>) -> tensor<128xbf16>
    %4 = "tensor.empty"() : () -> tensor<f32>
    %5 = "linalg.fill"(%0, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %6 = "linalg.reduce"(%3, %5) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg4: bf16, %arg5: f32):
      %12 = "arith.extf"(%arg4) : (bf16) -> f32
      %13 = "arith.addf"(%12, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%13) : (f32) -> ()
    }) : (tensor<128xbf16>, tensor<f32>) -> tensor<f32>
    %7 = "tensor.extract"(%6) : (tensor<f32>) -> f32
    %8 = "arith.truncf"(%7) : (f32) -> bf16
    %9 = "tensor.empty"() : () -> tensor<1xbf16>
    %10 = "linalg.fill"(%8, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: bf16, %arg3: bf16):
      "linalg.yield"(%arg2) : (bf16) -> ()
    }) : (bf16, tensor<1xbf16>) -> tensor<1xbf16>
    %11 = "memref.subview"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xbf16>) -> memref<1xbf16, strided<[1]>>
    "bufferization.materialize_in_destination"(%10, %11) <{writable}> : (tensor<1xbf16>, memref<1xbf16, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

