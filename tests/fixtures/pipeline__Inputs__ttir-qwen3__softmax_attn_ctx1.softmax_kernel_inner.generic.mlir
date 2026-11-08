#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32) -> (), sym_name = "softmax_kernel_inner"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xf32>
    %4 = "memref.subview"(%arg1, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "linalg.copy"(%4, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: f32, %arg24: f32):
      "linalg.yield"(%arg23) : (f32) -> ()
    }) : (memref<1xf32, strided<[1], offset: ?>>, memref<1xf32>) -> ()
    %5 = "bufferization.to_tensor"(%3) <{restrict, writable}> : (memref<1xf32>) -> tensor<1xf32>
    %6 = "tensor.empty"() : () -> tensor<f32>
    %7 = "linalg.fill"(%0, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: f32, %arg22: f32):
      "linalg.yield"(%arg21) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %8 = "linalg.reduce"(%5, %7) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg19: f32, %arg20: f32):
      %24 = "arith.maxnumf"(%arg19, %arg20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%24) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<f32>) -> tensor<f32>
    %9 = "tensor.extract"(%8) : (tensor<f32>) -> f32
    %10 = "tensor.empty"() : () -> tensor<1xf32>
    %11 = "linalg.fill"(%9, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: f32, %arg18: f32):
      "linalg.yield"(%arg17) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %12 = "linalg.generic"(%5, %11, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32, %arg16: f32):
      %23 = "arith.subf"(%arg14, %arg15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%23) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %13 = "linalg.generic"(%12, %12) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      %22 = "math.exp"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %14 = "linalg.fill"(%1, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %15 = "linalg.reduce"(%13, %14) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %21 = "arith.addf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%21) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<f32>) -> tensor<f32>
    %16 = "tensor.extract"(%15) : (tensor<f32>) -> f32
    %17 = "linalg.fill"(%16, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %18 = "linalg.generic"(%13, %17, %13) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %20 = "arith.divf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %19 = "memref.subview"(%arg0, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%18, %19) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

