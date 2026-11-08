"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "mean_kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>):
    %0 = "arith.constant"() <{value = 1.280000e+02 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32>
    %3 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<128xf32, strided<[1]>>
    "linalg.copy"(%3, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (memref<128xf32, strided<[1]>>, memref<128xf32>) -> ()
    %4 = "bufferization.to_tensor"(%2) <{restrict, writable}> : (memref<128xf32>) -> tensor<128xf32>
    %5 = "tensor.empty"() : () -> tensor<f32>
    %6 = "linalg.fill"(%1, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %7 = "linalg.reduce"(%4, %6) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      %13 = "arith.addf"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%13) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<f32>) -> tensor<f32>
    %8 = "tensor.extract"(%7) : (tensor<f32>) -> f32
    %9 = "arith.divf"(%8, %0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %10 = "tensor.empty"() : () -> tensor<1xf32>
    %11 = "linalg.fill"(%9, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %12 = "memref.subview"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<1xf32, strided<[1]>>
    "bufferization.materialize_in_destination"(%11, %12) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

