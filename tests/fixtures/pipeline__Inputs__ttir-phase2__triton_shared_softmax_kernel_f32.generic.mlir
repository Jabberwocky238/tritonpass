#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32, i32) -> (), sym_name = "softmax_kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32, %arg3: i32, %arg4: i32):
    %0 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %5 = "arith.index_cast"(%4) : (index) -> i32
    %6 = "arith.muli"(%5, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %7 = "arith.index_cast"(%6) : (i32) -> index
    %8 = "arith.index_cast"(%arg4) : (i32) -> index
    %9 = "arith.minsi"(%8, %0) : (index, index) -> index
    %10 = "arith.maxsi"(%9, %1) : (index, index) -> index
    %11 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
    "linalg.fill"(%2, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg27: f32, %arg28: f32):
      "linalg.yield"(%arg27) : (f32) -> ()
    }) : (f32, memref<1024xf32>) -> ()
    %12 = "memref.subview"(%arg1, %7, %10) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %13 = "memref.subview"(%11, %10) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%12, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: f32, %arg26: f32):
      "linalg.yield"(%arg25) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %14 = "bufferization.to_tensor"(%11) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
    %15 = "tensor.empty"() : () -> tensor<f32>
    %16 = "linalg.fill"(%2, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: f32, %arg24: f32):
      "linalg.yield"(%arg23) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %17 = "linalg.reduce"(%14, %16) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg21: f32, %arg22: f32):
      %36 = "arith.maxnumf"(%arg21, %arg22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%36) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<f32>) -> tensor<f32>
    %18 = "tensor.extract"(%17) : (tensor<f32>) -> f32
    %19 = "tensor.empty"() : () -> tensor<1024xf32>
    %20 = "linalg.fill"(%18, %19) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32):
      "linalg.yield"(%arg19) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %21 = "linalg.generic"(%14, %20, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: f32, %arg17: f32, %arg18: f32):
      %35 = "arith.subf"(%arg16, %arg17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%35) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %22 = "linalg.generic"(%21, %21) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %34 = "math.exp"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%34) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %23 = "linalg.fill"(%3, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %24 = "linalg.reduce"(%22, %23) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      %33 = "arith.addf"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%33) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<f32>) -> tensor<f32>
    %25 = "tensor.extract"(%24) : (tensor<f32>) -> f32
    %26 = "linalg.fill"(%25, %19) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %27 = "linalg.generic"(%22, %26, %22) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32, %arg7: f32):
      %32 = "arith.divf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%32) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %28 = "arith.muli"(%5, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %29 = "arith.index_cast"(%28) : (i32) -> index
    %30 = "tensor.extract_slice"(%27, %10) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xf32>, index) -> tensor<?xf32>
    %31 = "memref.subview"(%arg0, %29, %10) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%30, %31) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

