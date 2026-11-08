#map = affine_map<(d0, d1) -> (0, d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>) -> (), sym_name = "broadcast_kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xf32>
    %1 = "memref.subview"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 64>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<64xf32, strided<[1]>>
    "linalg.copy"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (memref<64xf32, strided<[1]>>, memref<64xf32>) -> ()
    %2 = "bufferization.to_tensor"(%0) <{restrict, writable}> : (memref<64xf32>) -> tensor<64xf32>
    %3 = "tensor.expand_shape"(%2) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 64>}> : (tensor<64xf32>) -> tensor<1x64xf32>
    %4 = "tensor.empty"() : () -> tensor<32x64xf32>
    %5 = "linalg.generic"(%3, %4) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x64xf32>, tensor<32x64xf32>) -> tensor<32x64xf32>
    %6 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 64, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[64, 1]>>
    %7 = "memref.subview"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[64, 1]>>) -> memref<32x64xf32, strided<[64, 1]>>
    "bufferization.materialize_in_destination"(%5, %7) <{writable}> : (tensor<32x64xf32>, memref<32x64xf32, strided<[64, 1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

