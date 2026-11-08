"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32>
    %2 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<128xf32, strided<[1]>>
    "linalg.copy"(%2, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (memref<128xf32, strided<[1]>>, memref<128xf32>) -> ()
    %3 = "bufferization.to_tensor"(%1) <{restrict, writable}> : (memref<128xf32>) -> tensor<128xf32>
    %4 = "tensor.empty"() : () -> tensor<f32>
    %5 = "linalg.fill"(%0, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %6 = "linalg.reduce"(%3, %5) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      %11 = "arith.addf"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%11) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<f32>) -> tensor<f32>
    %7 = "tensor.extract"(%6) : (tensor<f32>) -> f32
    %8 = "tensor.empty"() : () -> tensor<1xf32>
    %9 = "linalg.fill"(%7, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %10 = "memref.subview"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<1xf32, strided<[1]>>
    "bufferization.materialize_in_destination"(%9, %10) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

