// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, index, tensor<64xf32>) -> tensor<16x64xf32>, sym_name = "bcast_readonly"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: index, %arg3: tensor<64xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (!tt.ptr<f32>) -> memref<?xf32>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (!tt.ptr<f32>) -> memref<?xf32>
    %2 = "memref.reinterpret_cast"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 0, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[0, 1]>>
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x64xf32>
    %4 = "memref.subview"(%2, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 16, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[0, 1]>>, index) -> memref<16x64xf32, strided<[0, 1], offset: ?>>
    "linalg.copy"(%4, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (memref<16x64xf32, strided<[0, 1], offset: ?>>, memref<16x64xf32>) -> ()
    %5 = "bufferization.to_tensor"(%3) <{restrict, writable}> : (memref<16x64xf32>) -> tensor<16x64xf32>
    %6 = "memref.cast"(%0) : (memref<?xf32>) -> memref<?xf32>
    %7 = "memref.subview"(%6, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 64>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<64xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%arg3, %7) <{writable}> : (tensor<64xf32>, memref<64xf32, strided<[1], offset: ?>>) -> ()
    "tt.return"(%5) : (tensor<16x64xf32>) -> ()
  }) : () -> ()
}) : () -> ()

