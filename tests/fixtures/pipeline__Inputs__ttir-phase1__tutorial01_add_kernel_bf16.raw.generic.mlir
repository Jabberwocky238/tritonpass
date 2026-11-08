#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32) -> (), sym_name = "add_kernel"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xbf16>, %arg3: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %1 = "arith.constant"() <{value = 1024 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %3 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %4 = "arith.index_cast"(%3) : (index) -> i32
    %5 = "arith.muli"(%4, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "arith.index_cast"(%5) : (i32) -> index
    %7 = "arith.addi"(%6, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %8 = "arith.index_cast"(%arg3) : (i32) -> index
    %9 = "arith.minsi"(%7, %8) : (index, index) -> index
    %10 = "arith.maxsi"(%9, %6) : (index, index) -> index
    %11 = "arith.subi"(%10, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %12 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
    "linalg.fill"(%0, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: bf16, %arg14: bf16):
      "linalg.yield"(%arg13) : (bf16) -> ()
    }) : (bf16, memref<1024xbf16>) -> ()
    %13 = "memref.subview"(%arg0, %6, %11) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %14 = "memref.subview"(%12, %11) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%13, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: bf16, %arg12: bf16):
      "linalg.yield"(%arg11) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %15 = "bufferization.to_tensor"(%12) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
    %16 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
    "linalg.fill"(%0, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: bf16, %arg10: bf16):
      "linalg.yield"(%arg9) : (bf16) -> ()
    }) : (bf16, memref<1024xbf16>) -> ()
    %17 = "memref.subview"(%arg1, %6, %11) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %18 = "memref.subview"(%16, %11) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%17, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: bf16, %arg8: bf16):
      "linalg.yield"(%arg7) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %19 = "bufferization.to_tensor"(%16) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
    %20 = "linalg.generic"(%15, %19, %15) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg4: bf16, %arg5: bf16, %arg6: bf16):
      %23 = "arith.addf"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
      "linalg.yield"(%23) : (bf16) -> ()
    }) : (tensor<1024xbf16>, tensor<1024xbf16>, tensor<1024xbf16>) -> tensor<1024xbf16>
    %21 = "tensor.extract_slice"(%20, %11) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xbf16>, index) -> tensor<?xbf16>
    %22 = "memref.subview"(%arg2, %6, %11) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%21, %22) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

