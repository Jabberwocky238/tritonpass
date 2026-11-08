#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xf32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2048xbf16>
    %2 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 2048>, static_strides = array<i64: 1>}> : (memref<?xbf16>) -> memref<2048xbf16, strided<[1]>>
    "linalg.copy"(%2, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: bf16, %arg15: bf16):
      "linalg.yield"(%arg14) : (bf16) -> ()
    }) : (memref<2048xbf16, strided<[1]>>, memref<2048xbf16>) -> ()
    %3 = "bufferization.to_tensor"(%1) <{restrict, writable}> : (memref<2048xbf16>) -> tensor<2048xbf16>
    %4 = "tensor.expand_shape"(%3) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 2, 32, 32>}> : (tensor<2048xbf16>) -> tensor<2x32x32xbf16>
    %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2048xbf16>
    %6 = "memref.subview"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 2048>, static_strides = array<i64: 1>}> : (memref<?xbf16>) -> memref<2048xbf16, strided<[1]>>
    "linalg.copy"(%6, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: bf16, %arg13: bf16):
      "linalg.yield"(%arg12) : (bf16) -> ()
    }) : (memref<2048xbf16, strided<[1]>>, memref<2048xbf16>) -> ()
    %7 = "bufferization.to_tensor"(%5) <{restrict, writable}> : (memref<2048xbf16>) -> tensor<2048xbf16>
    %8 = "tensor.expand_shape"(%7) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 2, 32, 32>}> : (tensor<2048xbf16>) -> tensor<2x32x32xbf16>
    %9 = "tensor.empty"() : () -> tensor<2x32x32xbf16>
    %10 = "linalg.transpose"(%4, %9) <{permutation = array<i64: 0, 2, 1>}> ({
    ^bb0(%arg10: bf16, %arg11: bf16):
      "linalg.yield"(%arg10) : (bf16) -> ()
    }) : (tensor<2x32x32xbf16>, tensor<2x32x32xbf16>) -> tensor<2x32x32xbf16>
    %11 = "linalg.transpose"(%8, %9) <{permutation = array<i64: 0, 2, 1>}> ({
    ^bb0(%arg8: bf16, %arg9: bf16):
      "linalg.yield"(%arg8) : (bf16) -> ()
    }) : (tensor<2x32x32xbf16>, tensor<2x32x32xbf16>) -> tensor<2x32x32xbf16>
    %12 = "tensor.empty"() : () -> tensor<2x32x32xf32>
    %13 = "linalg.fill"(%0, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<2x32x32xf32>) -> tensor<2x32x32xf32>
    %14 = "linalg.batch_matmul"(%10, %11, %13) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: bf16, %arg4: bf16, %arg5: f32):
      %17 = "arith.extf"(%arg3) : (bf16) -> f32
      %18 = "arith.extf"(%arg4) : (bf16) -> f32
      %19 = "arith.mulf"(%17, %18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %20 = "arith.addf"(%arg5, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<2x32x32xbf16>, tensor<2x32x32xbf16>, tensor<2x32x32xf32>) -> tensor<2x32x32xf32>
    %15 = "tensor.collapse_shape"(%14) <{reassociation = [[0, 1, 2]]}> : (tensor<2x32x32xf32>) -> tensor<2048xf32>
    %16 = "memref.subview"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 2048>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<2048xf32, strided<[1]>>
    "bufferization.materialize_in_destination"(%15, %16) <{writable}> : (tensor<2048xf32>, memref<2048xf32, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

