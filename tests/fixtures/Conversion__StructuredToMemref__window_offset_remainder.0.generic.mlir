"builtin.module"() ({
  "tt.func"() <{function_type = (memref<?xf32>, i32, index, index, index) -> tensor<8x32xf32>, sym_name = "remainder"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: i32, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.index_cast"(%arg1) : (i32) -> index
    %1 = "memref.reinterpret_cast"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %2 = "arith.addi"(%arg3, %arg4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x32xf32>
    %4 = "memref.subview"(%1, %arg2, %2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 8, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index) -> memref<8x32xf32, strided<[?, 1], offset: ?>>
    "linalg.copy"(%4, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (memref<8x32xf32, strided<[?, 1], offset: ?>>, memref<8x32xf32>) -> ()
    %5 = "bufferization.to_tensor"(%3) <{restrict, writable}> : (memref<8x32xf32>) -> tensor<8x32xf32>
    "tt.return"(%5) : (tensor<8x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

