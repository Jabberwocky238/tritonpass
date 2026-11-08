"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xi64>, memref<?xf32>) -> (), sym_name = "gather_test_kernel_1d"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xi64>, %arg2: memref<?xf32>):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32xf32>
    %1 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 32>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<32xf32, strided<[1]>>
    "linalg.copy"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (memref<32xf32, strided<[1]>>, memref<32xf32>) -> ()
    %2 = "bufferization.to_tensor"(%0) <{restrict, writable}> : (memref<32xf32>) -> tensor<32xf32>
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xi64>
    %4 = "memref.subview"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 64>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<64xi64, strided<[1]>>
    "linalg.copy"(%4, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: i64, %arg4: i64):
      "linalg.yield"(%arg3) : (i64) -> ()
    }) : (memref<64xi64, strided<[1]>>, memref<64xi64>) -> ()
    %5 = "bufferization.to_tensor"(%3) <{restrict, writable}> : (memref<64xi64>) -> tensor<64xi64>
    %6 = "tt.gather"(%2, %5) <{axis = 0 : i32}> : (tensor<32xf32>, tensor<64xi64>) -> tensor<64xf32>
    %7 = "memref.subview"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 64>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<64xf32, strided<[1]>>
    "bufferization.materialize_in_destination"(%6, %7) <{writable}> : (tensor<64xf32>, memref<64xf32, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

