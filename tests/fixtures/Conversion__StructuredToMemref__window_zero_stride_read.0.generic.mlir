"builtin.module"() ({
  "tt.func"() <{function_type = (memref<?xf32>, index) -> tensor<16x64xf32>, sym_name = "broadcast_read"}> ({
  ^bb0(%arg4: memref<?xf32>, %arg5: index):
    %4 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 0, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[0, 1]>>
    %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x64xf32>
    %6 = "memref.subview"(%4, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 16, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[0, 1]>>, index) -> memref<16x64xf32, strided<[0, 1], offset: ?>>
    "linalg.copy"(%6, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (memref<16x64xf32, strided<[0, 1], offset: ?>>, memref<16x64xf32>) -> ()
    %7 = "bufferization.to_tensor"(%5) <{restrict, writable}> : (memref<16x64xf32>) -> tensor<16x64xf32>
    "tt.return"(%7) : (tensor<16x64xf32>) -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (memref<?xf32>, index) -> tensor<1x64xf32>, sym_name = "size_one_dim"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: index):
    %0 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 64, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[64, 1]>>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x64xf32>
    %2 = "memref.subview"(%0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 1, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[64, 1]>>, index) -> memref<1x64xf32, strided<[64, 1], offset: ?>>
    "linalg.copy"(%2, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (memref<1x64xf32, strided<[64, 1], offset: ?>>, memref<1x64xf32>) -> ()
    %3 = "bufferization.to_tensor"(%1) <{restrict, writable}> : (memref<1x64xf32>) -> tensor<1x64xf32>
    "tt.return"(%3) : (tensor<1x64xf32>) -> ()
  }) : () -> ()
}) : () -> ()

