#map = affine_map<(d0, d1) -> (0, d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>) -> (), sym_name = "broadcast_kernel"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xbf16>):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xbf16>
    %1 = "memref.subview"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 64>, static_strides = array<i64: 1>}> : (memref<?xbf16>) -> memref<64xbf16, strided<[1]>>
    "linalg.copy"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: bf16, %arg6: bf16):
      "linalg.yield"(%arg5) : (bf16) -> ()
    }) : (memref<64xbf16, strided<[1]>>, memref<64xbf16>) -> ()
    %2 = "bufferization.to_tensor"(%0) <{restrict, writable}> : (memref<64xbf16>) -> tensor<64xbf16>
    %3 = "tensor.expand_shape"(%2) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 64>}> : (tensor<64xbf16>) -> tensor<1x64xbf16>
    %4 = "tensor.empty"() : () -> tensor<32x64xbf16>
    %5 = "linalg.generic"(%3, %4) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: bf16, %arg4: bf16):
      "linalg.yield"(%arg3) : (bf16) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x64xbf16>, tensor<32x64xbf16>) -> tensor<32x64xbf16>
    %6 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 64, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>
    %7 = "memref.subview"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>) -> memref<32x64xbf16, strided<[64, 1]>>
    "bufferization.materialize_in_destination"(%5, %7) <{writable}> : (tensor<32x64xbf16>, memref<32x64xbf16, strided<[64, 1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

