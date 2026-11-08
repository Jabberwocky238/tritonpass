#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, f32, memref<?xf32>) -> (), sym_name = "softmax_denominator_kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: f32, %arg2: memref<?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32>
    %2 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<128xf32, strided<[1]>>
    "linalg.copy"(%2, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: f32, %arg17: f32):
      "linalg.yield"(%arg16) : (f32) -> ()
    }) : (memref<128xf32, strided<[1]>>, memref<128xf32>) -> ()
    %3 = "bufferization.to_tensor"(%1) <{restrict, writable}> : (memref<128xf32>) -> tensor<128xf32>
    %4 = "tensor.empty"() : () -> tensor<128xf32>
    %5 = "linalg.fill"(%arg1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      "linalg.yield"(%arg14) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %6 = "linalg.generic"(%3, %5, %3) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32, %arg13: f32):
      %17 = "arith.subf"(%arg11, %arg12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%17) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %7 = "linalg.generic"(%6, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      %16 = "math.exp"(%arg9) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%16) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %8 = "tensor.empty"() : () -> tensor<f32>
    %9 = "linalg.fill"(%0, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32):
      "linalg.yield"(%arg7) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %10 = "linalg.reduce"(%7, %9) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      %15 = "arith.addf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%15) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<f32>) -> tensor<f32>
    %11 = "tensor.extract"(%10) : (tensor<f32>) -> f32
    %12 = "tensor.empty"() : () -> tensor<1xf32>
    %13 = "linalg.fill"(%11, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %14 = "memref.subview"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<1xf32, strided<[1]>>
    "bufferization.materialize_in_destination"(%13, %14) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

