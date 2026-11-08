"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, i32, i32) -> (), sym_name = "packed_masked"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: i32, %arg3: i32):
    %0 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %1 = "arith.constant"() <{value = 4096 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 4096 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 64 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %5 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %6 = "arith.index_cast"(%5) : (index) -> i32
    %7 = "arith.remsi"(%6, %arg3) : (i32, i32) -> i32
    %8 = "arith.extsi"(%7) : (i32) -> i64
    %9 = "arith.muli"(%8, %0) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %10 = "arith.muli"(%8, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %11 = "arith.index_cast"(%10) : (i64) -> index
    %12 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, 64>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[1, 64]>>
    %13 = "arith.index_cast"(%9) : (i64) -> index
    %14 = "arith.addi"(%13, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %15 = "arith.index_cast"(%arg2) : (i32) -> index
    %16 = "arith.minsi"(%14, %15) : (index, index) -> index
    %17 = "arith.maxsi"(%16, %13) : (index, index) -> index
    %18 = "arith.subi"(%17, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %19 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xbf16>
    "linalg.fill"(%4, %19) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: bf16, %arg7: bf16):
      "linalg.yield"(%arg6) : (bf16) -> ()
    }) : (bf16, memref<64x64xbf16>) -> ()
    %20 = "memref.subview"(%12, %11, %18) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 64, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[1, 64]>>, index, index) -> memref<64x?xbf16, strided<[1, 64], offset: ?>>
    %21 = "memref.subview"(%19, %18) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<64x64xbf16>, index) -> memref<64x?xbf16, strided<[64, 1]>>
    "linalg.copy"(%20, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: bf16, %arg5: bf16):
      "linalg.yield"(%arg4) : (bf16) -> ()
    }) : (memref<64x?xbf16, strided<[1, 64], offset: ?>>, memref<64x?xbf16, strided<[64, 1]>>) -> ()
    %22 = "bufferization.to_tensor"(%19) <{restrict, writable}> : (memref<64x64xbf16>) -> tensor<64x64xbf16>
    %23 = "arith.muli"(%6, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %24 = "arith.index_cast"(%23) : (i32) -> index
    %25 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 64, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>
    %26 = "memref.subview"(%25, %24) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>, index) -> memref<64x64xbf16, strided<[64, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%22, %26) <{writable}> : (tensor<64x64xbf16>, memref<64x64xbf16, strided<[64, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

