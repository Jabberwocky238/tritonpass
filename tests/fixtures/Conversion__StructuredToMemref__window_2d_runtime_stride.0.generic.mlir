"builtin.module"() ({
  "tt.func"() <{function_type = (memref<?xbf16>, i32, index, index) -> tensor<16x64xbf16>, sym_name = "tile_runtime_stride"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: i32, %arg2: index, %arg3: index):
    %0 = "arith.index_cast"(%arg1) : (i32) -> index
    %1 = "memref.reinterpret_cast"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xbf16>, index) -> memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x64xbf16>
    %3 = "memref.subview"(%1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 16, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>, index, index) -> memref<16x64xbf16, strided<[?, 1], offset: ?>>
    "linalg.copy"(%3, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: bf16, %arg5: bf16):
      "linalg.yield"(%arg4) : (bf16) -> ()
    }) : (memref<16x64xbf16, strided<[?, 1], offset: ?>>, memref<16x64xbf16>) -> ()
    %4 = "bufferization.to_tensor"(%2) <{restrict, writable}> : (memref<16x64xbf16>) -> tensor<16x64xbf16>
    "tt.return"(%4) : (tensor<16x64xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

