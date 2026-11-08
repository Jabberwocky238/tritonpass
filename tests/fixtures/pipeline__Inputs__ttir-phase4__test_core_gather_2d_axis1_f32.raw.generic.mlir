"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xi64>, memref<?xf32>) -> (), sym_name = "gather_test_kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xi64>, %arg2: memref<?xf32>):
    %0 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 64, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[64, 1]>>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x64xf32>
    %2 = "memref.subview"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 128, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[64, 1]>>) -> memref<128x64xf32, strided<[64, 1]>>
    "linalg.copy"(%2, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (memref<128x64xf32, strided<[64, 1]>>, memref<128x64xf32>) -> ()
    %3 = "bufferization.to_tensor"(%1) <{restrict, writable}> : (memref<128x64xf32>) -> tensor<128x64xf32>
    %4 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xi64>) -> memref<1099511627776x1099511627776xi64, strided<[128, 1]>>
    %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x128xi64>
    %6 = "memref.subview"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 128, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xi64, strided<[128, 1]>>) -> memref<128x128xi64, strided<[128, 1]>>
    "linalg.copy"(%6, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: i64, %arg4: i64):
      "linalg.yield"(%arg3) : (i64) -> ()
    }) : (memref<128x128xi64, strided<[128, 1]>>, memref<128x128xi64>) -> ()
    %7 = "bufferization.to_tensor"(%5) <{restrict, writable}> : (memref<128x128xi64>) -> tensor<128x128xi64>
    %8 = "tt.gather"(%3, %7) <{axis = 1 : i32}> : (tensor<128x64xf32>, tensor<128x128xi64>) -> tensor<128x128xf32>
    %9 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[128, 1]>>
    %10 = "memref.subview"(%9) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 128, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[128, 1]>>) -> memref<128x128xf32, strided<[128, 1]>>
    "bufferization.materialize_in_destination"(%8, %10) <{writable}> : (tensor<128x128xf32>, memref<128x128xf32, strided<[128, 1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

