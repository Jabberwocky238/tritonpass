#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
    %2 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1024>, static_strides = array<i64: 1>}> : (memref<?xbf16>) -> memref<1024xbf16, strided<[1]>>
    "linalg.copy"(%2, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: bf16, %arg9: bf16):
      "linalg.yield"(%arg8) : (bf16) -> ()
    }) : (memref<1024xbf16, strided<[1]>>, memref<1024xbf16>) -> ()
    %3 = "bufferization.to_tensor"(%1) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
    %4 = "tensor.expand_shape"(%3) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 1024>}> : (tensor<1024xbf16>) -> tensor<1x1024xbf16>
    %5 = "tensor.empty"() : () -> tensor<1xf32>
    %6 = "linalg.fill"(%0, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %7 = "linalg.reduce"(%4, %6) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg4: bf16, %arg5: f32):
      %13 = "arith.extf"(%arg4) : (bf16) -> f32
      %14 = "arith.addf"(%13, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%14) : (f32) -> ()
    }) : (tensor<1x1024xbf16>, tensor<1xf32>) -> tensor<1xf32>
    %8 = "tensor.empty"() : () -> tensor<1xbf16>
    %9 = "linalg.generic"(%7, %8) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: bf16):
      %12 = "arith.truncf"(%arg2) : (f32) -> bf16
      "linalg.yield"(%12) : (bf16) -> ()
    }) : (tensor<1xf32>, tensor<1xbf16>) -> tensor<1xbf16>
    %10 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xbf16>) -> memref<1099511627776xbf16, strided<[1]>>
    %11 = "memref.subview"(%10) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<1099511627776xbf16, strided<[1]>>) -> memref<1xbf16, strided<[1]>>
    "bufferization.materialize_in_destination"(%9, %11) <{writable}> : (tensor<1xbf16>, memref<1xbf16, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

