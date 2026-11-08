"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "store_into_every_second"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
    %1 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 512>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<512xf32, strided<[1]>>
    "linalg.copy"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (memref<512xf32, strided<[1]>>, memref<512xf32>) -> ()
    %2 = "bufferization.to_tensor"(%0) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
    %3 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 2>}> : (memref<?xf32>) -> memref<1099511627776xf32, strided<[2]>>
    %4 = "memref.subview"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 512>, static_strides = array<i64: 1>}> : (memref<1099511627776xf32, strided<[2]>>) -> memref<512xf32, strided<[2]>>
    "bufferization.materialize_in_destination"(%2, %4) <{writable}> : (tensor<512xf32>, memref<512xf32, strided<[2]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

