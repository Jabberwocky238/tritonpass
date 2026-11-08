#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32) -> (), sym_name = "softmax_kernel_inner"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32, %arg3: i32):
    %0 = "arith.constant"() <{value = 2048 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %5 = "arith.index_cast"(%4) : (index) -> i32
    %6 = "arith.extsi"(%5) : (i32) -> i64
    %7 = "arith.extsi"(%arg3) : (i32) -> i64
    %8 = "arith.muli"(%6, %7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %9 = "arith.index_cast"(%8) : (i64) -> index
    %10 = "arith.index_cast"(%arg3) : (i32) -> index
    %11 = "arith.minsi"(%10, %0) : (index, index) -> index
    %12 = "arith.maxsi"(%11, %1) : (index, index) -> index
    %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2048xf32>
    "linalg.fill"(%2, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg26: f32, %arg27: f32):
      "linalg.yield"(%arg26) : (f32) -> ()
    }) : (f32, memref<2048xf32>) -> ()
    %14 = "memref.subview"(%arg1, %9, %12) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %15 = "memref.subview"(%13, %12) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<2048xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%14, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: f32, %arg25: f32):
      "linalg.yield"(%arg24) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %16 = "bufferization.to_tensor"(%13) <{restrict, writable}> : (memref<2048xf32>) -> tensor<2048xf32>
    %17 = "tensor.empty"() : () -> tensor<f32>
    %18 = "linalg.fill"(%2, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg22: f32, %arg23: f32):
      "linalg.yield"(%arg22) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %19 = "linalg.reduce"(%16, %18) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg20: f32, %arg21: f32):
      %36 = "arith.maxnumf"(%arg20, %arg21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%36) : (f32) -> ()
    }) : (tensor<2048xf32>, tensor<f32>) -> tensor<f32>
    %20 = "tensor.extract"(%19) : (tensor<f32>) -> f32
    %21 = "tensor.empty"() : () -> tensor<2048xf32>
    %22 = "linalg.fill"(%20, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: f32, %arg19: f32):
      "linalg.yield"(%arg18) : (f32) -> ()
    }) : (f32, tensor<2048xf32>) -> tensor<2048xf32>
    %23 = "linalg.generic"(%16, %22, %16) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32, %arg17: f32):
      %35 = "arith.subf"(%arg15, %arg16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%35) : (f32) -> ()
    }) : (tensor<2048xf32>, tensor<2048xf32>, tensor<2048xf32>) -> tensor<2048xf32>
    %24 = "linalg.generic"(%23, %23) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      %34 = "math.exp"(%arg13) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%34) : (f32) -> ()
    }) : (tensor<2048xf32>, tensor<2048xf32>) -> tensor<2048xf32>
    %25 = "linalg.fill"(%3, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      "linalg.yield"(%arg11) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %26 = "linalg.reduce"(%24, %25) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      %33 = "arith.addf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%33) : (f32) -> ()
    }) : (tensor<2048xf32>, tensor<f32>) -> tensor<f32>
    %27 = "tensor.extract"(%26) : (tensor<f32>) -> f32
    %28 = "linalg.fill"(%27, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32):
      "linalg.yield"(%arg7) : (f32) -> ()
    }) : (f32, tensor<2048xf32>) -> tensor<2048xf32>
    %29 = "linalg.generic"(%24, %28, %24) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32, %arg6: f32):
      %32 = "arith.divf"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%32) : (f32) -> ()
    }) : (tensor<2048xf32>, tensor<2048xf32>, tensor<2048xf32>) -> tensor<2048xf32>
    %30 = "tensor.extract_slice"(%29, %12) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<2048xf32>, index) -> tensor<?xf32>
    %31 = "memref.subview"(%arg0, %9, %12) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%30, %31) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

