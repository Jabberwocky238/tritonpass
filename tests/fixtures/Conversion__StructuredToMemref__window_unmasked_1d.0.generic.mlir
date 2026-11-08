"builtin.module"() ({
  "tt.func"() <{function_type = (memref<?xf32>, memref<?xf32>, index) -> (), sym_name = "unmasked_1d"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: index):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<256xf32>
    %1 = "memref.subview"(%arg0, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 256>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<256xf32, strided<[1], offset: ?>>
    "linalg.copy"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (memref<256xf32, strided<[1], offset: ?>>, memref<256xf32>) -> ()
    %2 = "bufferization.to_tensor"(%0) <{restrict, writable}> : (memref<256xf32>) -> tensor<256xf32>
    %3 = "memref.subview"(%arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 256>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<256xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%2, %3) <{writable}> : (tensor<256xf32>, memref<256xf32, strided<[1], offset: ?>>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

