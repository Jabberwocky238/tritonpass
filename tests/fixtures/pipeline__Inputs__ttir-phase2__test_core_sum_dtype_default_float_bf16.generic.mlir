"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>) -> (), sym_name = "kernel_default_float"}> ({
  ^bb0(%arg0: memref<?xbf16>):
    %0 = "arith.constant"() <{value = 1.000000e+00 : bf16}> : () -> bf16
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "tensor.empty"() : () -> tensor<1024xbf16>
    %3 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: bf16, %arg8: bf16):
      "linalg.yield"(%arg7) : (bf16) -> ()
    }) : (bf16, tensor<1024xbf16>) -> tensor<1024xbf16>
    %4 = "tensor.empty"() : () -> tensor<f32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %6 = "linalg.reduce"(%3, %5) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg3: bf16, %arg4: f32):
      %12 = "arith.extf"(%arg3) : (bf16) -> f32
      %13 = "arith.addf"(%12, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%13) : (f32) -> ()
    }) : (tensor<1024xbf16>, tensor<f32>) -> tensor<f32>
    %7 = "tensor.extract"(%6) : (tensor<f32>) -> f32
    %8 = "arith.truncf"(%7) : (f32) -> bf16
    %9 = "tensor.empty"() : () -> tensor<1xbf16>
    %10 = "linalg.fill"(%8, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: bf16, %arg2: bf16):
      "linalg.yield"(%arg1) : (bf16) -> ()
    }) : (bf16, tensor<1xbf16>) -> tensor<1xbf16>
    %11 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xbf16>) -> memref<1xbf16, strided<[1]>>
    "bufferization.materialize_in_destination"(%10, %11) <{writable}> : (tensor<1xbf16>, memref<1xbf16, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

