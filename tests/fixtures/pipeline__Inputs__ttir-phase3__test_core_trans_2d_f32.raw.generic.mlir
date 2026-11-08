"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>):
    %0 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 16, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[16, 1]>>
    %1 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 16, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[16, 1]>>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x16xf32>
    %3 = "memref.subview"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 16>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[16, 1]>>) -> memref<16x16xf32, strided<[16, 1]>>
    "linalg.copy"(%3, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (memref<16x16xf32, strided<[16, 1]>>, memref<16x16xf32>) -> ()
    %4 = "bufferization.to_tensor"(%2) <{restrict, writable}> : (memref<16x16xf32>) -> tensor<16x16xf32>
    %5 = "tensor.empty"() : () -> tensor<16x16xf32>
    %6 = "linalg.transpose"(%4, %5) <{permutation = array<i64: 1, 0>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
    %7 = "memref.subview"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 16>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[16, 1]>>) -> memref<16x16xf32, strided<[16, 1]>>
    "bufferization.materialize_in_destination"(%6, %7) <{writable}> : (tensor<16x16xf32>, memref<16x16xf32, strided<[16, 1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

