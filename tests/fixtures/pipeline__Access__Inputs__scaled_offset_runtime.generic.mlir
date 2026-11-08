"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, i32, i32) -> (), sym_name = "two_dim_runtime"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: i32, %arg3: i32):
    %0 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 4096 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 64 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %4 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %5 = "arith.index_cast"(%4) : (index) -> i32
    %6 = "arith.muli"(%5, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %7 = "arith.muli"(%6, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %8 = "arith.index_cast"(%7) : (i32) -> index
    %9 = "arith.index_cast"(%arg3) : (i32) -> index
    %10 = "memref.reinterpret_cast"(%arg0, %9) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, -9223372036854775808>}> : (memref<?xbf16>, index) -> memref<1099511627776x1099511627776xbf16, strided<[1, ?]>>
    %11 = "arith.index_cast"(%6) : (i32) -> index
    %12 = "arith.addi"(%11, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %13 = "arith.index_cast"(%arg2) : (i32) -> index
    %14 = "arith.minsi"(%12, %13) : (index, index) -> index
    %15 = "arith.maxsi"(%14, %11) : (index, index) -> index
    %16 = "arith.subi"(%15, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %17 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xbf16>
    "linalg.fill"(%3, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: bf16, %arg7: bf16):
      "linalg.yield"(%arg6) : (bf16) -> ()
    }) : (bf16, memref<64x64xbf16>) -> ()
    %18 = "memref.subview"(%10, %8, %16) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 64, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[1, ?]>>, index, index) -> memref<64x?xbf16, strided<[1, ?], offset: ?>>
    %19 = "memref.subview"(%17, %16) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<64x64xbf16>, index) -> memref<64x?xbf16, strided<[64, 1]>>
    "linalg.copy"(%18, %19) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: bf16, %arg5: bf16):
      "linalg.yield"(%arg4) : (bf16) -> ()
    }) : (memref<64x?xbf16, strided<[1, ?], offset: ?>>, memref<64x?xbf16, strided<[64, 1]>>) -> ()
    %20 = "bufferization.to_tensor"(%17) <{restrict, writable}> : (memref<64x64xbf16>) -> tensor<64x64xbf16>
    %21 = "arith.muli"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %22 = "arith.index_cast"(%21) : (i32) -> index
    %23 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 64, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>
    %24 = "memref.subview"(%23, %22) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>, index) -> memref<64x64xbf16, strided<[64, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%20, %24) <{writable}> : (tensor<64x64xbf16>, memref<64x64xbf16, strided<[64, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

