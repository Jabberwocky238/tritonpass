"builtin.module"() ({
  "tt.func"() <{function_type = (memref<?xf32>) -> tensor<1x16xf32>, sym_name = "size1_negative"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 16, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[16, 1]>>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x16xf32>
    %2 = "memref.subview"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[16, 1]>>) -> memref<1x16xf32, strided<[16, 1]>>
    "linalg.copy"(%2, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (memref<1x16xf32, strided<[16, 1]>>, memref<1x16xf32>) -> ()
    %3 = "bufferization.to_tensor"(%1) <{restrict, writable}> : (memref<1x16xf32>) -> tensor<1x16xf32>
    "tt.return"(%3) : (tensor<1x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (memref<?xf32>, index, index) -> tensor<1x16xf32>, sym_name = "size1_bad"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: index, %arg2: index):
    %0 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 16, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[16, 1]>>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x16xf32>
    %2 = "memref.subview"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[16, 1]>>) -> memref<1x16xf32, strided<[16, 1]>>
    "linalg.copy"(%2, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (memref<1x16xf32, strided<[16, 1]>>, memref<1x16xf32>) -> ()
    %3 = "bufferization.to_tensor"(%1) <{restrict, writable}> : (memref<1x16xf32>) -> tensor<1x16xf32>
    "tt.return"(%3) : (tensor<1x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (memref<?xf32>, index, index, index) -> tensor<1x16xf32>, sym_name = "size1_bad_with_offset"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.muli"(%arg1, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %1 = "arith.muli"(%arg3, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %2 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 16, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[16, 1]>>
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x16xf32>
    %4 = "memref.subview"(%2, %1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[16, 1]>>, index) -> memref<1x16xf32, strided<[16, 1], offset: ?>>
    "linalg.copy"(%4, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (memref<1x16xf32, strided<[16, 1], offset: ?>>, memref<1x16xf32>) -> ()
    %5 = "bufferization.to_tensor"(%3) <{restrict, writable}> : (memref<1x16xf32>) -> tensor<1x16xf32>
    "tt.return"(%5) : (tensor<1x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

