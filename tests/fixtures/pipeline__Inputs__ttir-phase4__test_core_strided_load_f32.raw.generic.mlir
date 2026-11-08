"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "take_every_second_element"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>):
    %0 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 2>}> : (memref<?xf32>) -> memref<1099511627776xf32, strided<[2]>>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<256xf32>
    %2 = "memref.subview"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 256>, static_strides = array<i64: 1>}> : (memref<1099511627776xf32, strided<[2]>>) -> memref<256xf32, strided<[2]>>
    "linalg.copy"(%2, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (memref<256xf32, strided<[2]>>, memref<256xf32>) -> ()
    %3 = "bufferization.to_tensor"(%1) <{restrict, writable}> : (memref<256xf32>) -> tensor<256xf32>
    %4 = "memref.subview"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 256>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<256xf32, strided<[1]>>
    "bufferization.materialize_in_destination"(%3, %4) <{writable}> : (tensor<256xf32>, memref<256xf32, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

