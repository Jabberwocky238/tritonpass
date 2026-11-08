"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, i32, memref<?xf32>, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: i32, %arg2: memref<?xf32>, %arg3: i32):
    %0 = "arith.index_cast"(%arg1) : (i32) -> index
    %1 = "memref.reinterpret_cast"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, -9223372036854775808>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[1, ?]>>
    %2 = "arith.index_cast"(%arg3) : (i32) -> index
    %3 = "memref.reinterpret_cast"(%arg2, %2) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %4 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32>
    %5 = "memref.subview"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[1, ?]>>) -> memref<64x64xf32, strided<[1, ?]>>
    "linalg.copy"(%5, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (memref<64x64xf32, strided<[1, ?]>>, memref<64x64xf32>) -> ()
    %6 = "bufferization.to_tensor"(%4) <{restrict, writable}> : (memref<64x64xf32>) -> tensor<64x64xf32>
    %7 = "memref.subview"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>) -> memref<64x64xf32, strided<[?, 1]>>
    "bufferization.materialize_in_destination"(%6, %7) <{writable}> : (tensor<64x64xf32>, memref<64x64xf32, strided<[?, 1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

