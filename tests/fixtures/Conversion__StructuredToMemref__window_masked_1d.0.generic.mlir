"builtin.module"() ({
  "tt.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, index, index) -> (), sym_name = "masked_1d"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
    "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: bf16, %arg7: bf16):
      "linalg.yield"(%arg6) : (bf16) -> ()
    }) : (bf16, memref<1024xbf16>) -> ()
    %2 = "memref.subview"(%arg0, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %3 = "memref.subview"(%1, %arg3) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: bf16, %arg5: bf16):
      "linalg.yield"(%arg4) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %4 = "bufferization.to_tensor"(%1) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
    %5 = "tensor.extract_slice"(%4, %arg3) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xbf16>, index) -> tensor<?xbf16>
    %6 = "memref.subview"(%arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%5, %6) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

