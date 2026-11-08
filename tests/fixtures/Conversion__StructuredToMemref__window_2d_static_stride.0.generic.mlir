"builtin.module"() ({
  "tt.func"() <{function_type = (memref<?xbf16>, index, index, index, index) -> tensor<16x64xbf16>, sym_name = "tile_2d"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %1 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x64xbf16>
    "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: bf16, %arg8: bf16):
      "linalg.yield"(%arg7) : (bf16) -> ()
    }) : (bf16, memref<16x64xbf16>) -> ()
    %3 = "memref.subview"(%1, %arg1, %arg2, %arg3, %arg4) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[128, 1], offset: ?>>
    %4 = "memref.subview"(%2, %arg3, %arg4) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<16x64xbf16>, index, index) -> memref<?x?xbf16, strided<[64, 1]>>
    "linalg.copy"(%3, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: bf16, %arg6: bf16):
      "linalg.yield"(%arg5) : (bf16) -> ()
    }) : (memref<?x?xbf16, strided<[128, 1], offset: ?>>, memref<?x?xbf16, strided<[64, 1]>>) -> ()
    %5 = "bufferization.to_tensor"(%2) <{restrict, writable}> : (memref<16x64xbf16>) -> tensor<16x64xbf16>
    "tt.return"(%5) : (tensor<16x64xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

