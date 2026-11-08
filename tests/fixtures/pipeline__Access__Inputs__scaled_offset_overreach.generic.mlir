"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, i32, i32) -> (), sym_name = "overreach"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: i32, %arg3: i32):
    %0 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %1 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 4096 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 64 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %5 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %6 = "arith.index_cast"(%5) : (index) -> i32
    %7 = "arith.remsi"(%6, %arg3) : (i32, i32) -> i32
    %8 = "arith.extsi"(%7) : (i32) -> i64
    %9 = "arith.muli"(%8, %0) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %10 = "arith.addi"(%9, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %11 = "arith.muli"(%10, %0) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %12 = "arith.index_cast"(%11) : (i64) -> index
    %13 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, 64>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[1, 64]>>
    %14 = "arith.index_cast"(%9) : (i64) -> index
    %15 = "arith.addi"(%14, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %16 = "arith.index_cast"(%arg2) : (i32) -> index
    %17 = "arith.minsi"(%15, %16) : (index, index) -> index
    %18 = "arith.maxsi"(%17, %14) : (index, index) -> index
    %19 = "arith.subi"(%18, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %20 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xbf16>
    "linalg.fill"(%4, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: bf16, %arg7: bf16):
      "linalg.yield"(%arg6) : (bf16) -> ()
    }) : (bf16, memref<64x64xbf16>) -> ()
    %21 = "memref.subview"(%13, %12, %19) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 64, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[1, 64]>>, index, index) -> memref<64x?xbf16, strided<[1, 64], offset: ?>>
    %22 = "memref.subview"(%20, %19) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<64x64xbf16>, index) -> memref<64x?xbf16, strided<[64, 1]>>
    "linalg.copy"(%21, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: bf16, %arg5: bf16):
      "linalg.yield"(%arg4) : (bf16) -> ()
    }) : (memref<64x?xbf16, strided<[1, 64], offset: ?>>, memref<64x?xbf16, strided<[64, 1]>>) -> ()
    %23 = "bufferization.to_tensor"(%20) <{restrict, writable}> : (memref<64x64xbf16>) -> tensor<64x64xbf16>
    %24 = "arith.muli"(%6, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %25 = "arith.index_cast"(%24) : (i32) -> index
    %26 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 64, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>
    %27 = "memref.subview"(%26, %25) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>, index) -> memref<64x64xbf16, strided<[64, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%23, %27) <{writable}> : (tensor<64x64xbf16>, memref<64x64xbf16, strided<[64, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

