#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, i32, memref<?xf32>, i32, memref<?xf32>, i32, memref<?xf32>, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: i32, %arg2: memref<?xf32>, %arg3: i32, %arg4: memref<?xf32>, %arg5: i32, %arg6: memref<?xf32>, %arg7: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.index_cast"(%arg1) : (i32) -> index
    %2 = "memref.reinterpret_cast"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %3 = "arith.index_cast"(%arg3) : (i32) -> index
    %4 = "memref.reinterpret_cast"(%arg2, %3) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %5 = "arith.index_cast"(%arg5) : (i32) -> index
    %6 = "memref.reinterpret_cast"(%arg4, %5) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %7 = "arith.index_cast"(%arg7) : (i32) -> index
    %8 = "memref.reinterpret_cast"(%arg6, %7) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %9 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32>
    %10 = "memref.subview"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>) -> memref<64x64xf32, strided<[?, 1]>>
    "linalg.copy"(%10, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: f32, %arg21: f32):
      "linalg.yield"(%arg20) : (f32) -> ()
    }) : (memref<64x64xf32, strided<[?, 1]>>, memref<64x64xf32>) -> ()
    %11 = "bufferization.to_tensor"(%9) <{restrict, writable}> : (memref<64x64xf32>) -> tensor<64x64xf32>
    %12 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32>
    %13 = "memref.subview"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>) -> memref<64x64xf32, strided<[?, 1]>>
    "linalg.copy"(%13, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: f32, %arg19: f32):
      "linalg.yield"(%arg18) : (f32) -> ()
    }) : (memref<64x64xf32, strided<[?, 1]>>, memref<64x64xf32>) -> ()
    %14 = "bufferization.to_tensor"(%12) <{restrict, writable}> : (memref<64x64xf32>) -> tensor<64x64xf32>
    %15 = "tensor.empty"() : () -> tensor<64x64xf32>
    %16 = "linalg.fill"(%0, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: f32, %arg17: f32):
      "linalg.yield"(%arg16) : (f32) -> ()
    }) : (f32, tensor<64x64xf32>) -> tensor<64x64xf32>
    %17 = "linalg.matmul"(%11, %14, %16) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32, %arg15: f32):
      %25 = "arith.mulf"(%arg13, %arg14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %26 = "arith.addf"(%arg15, %25) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%26) : (f32) -> ()
    }) : (tensor<64x64xf32>, tensor<64x64xf32>, tensor<64x64xf32>) -> tensor<64x64xf32>
    %18 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32>
    %19 = "memref.subview"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>) -> memref<64x64xf32, strided<[?, 1]>>
    "linalg.copy"(%19, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      "linalg.yield"(%arg11) : (f32) -> ()
    }) : (memref<64x64xf32, strided<[?, 1]>>, memref<64x64xf32>) -> ()
    %20 = "bufferization.to_tensor"(%18) <{restrict, writable}> : (memref<64x64xf32>) -> tensor<64x64xf32>
    %21 = "linalg.matmul"(%17, %20, %16) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32, %arg10: f32):
      %23 = "arith.mulf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %24 = "arith.addf"(%arg10, %23) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%24) : (f32) -> ()
    }) : (tensor<64x64xf32>, tensor<64x64xf32>, tensor<64x64xf32>) -> tensor<64x64xf32>
    %22 = "memref.subview"(%8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>) -> memref<64x64xf32, strided<[?, 1]>>
    "bufferization.materialize_in_destination"(%21, %22) <{writable}> : (tensor<64x64xf32>, memref<64x64xf32, strided<[?, 1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

