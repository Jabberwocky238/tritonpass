"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xi32>, i32, i32, i32) -> (), sym_name = "index_select_rows_kernel"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xi32>, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 128 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %5 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %7 = "arith.index_cast"(%6) : (index) -> i32
    %8 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %9 = "arith.index_cast"(%8) : (index) -> i32
    %10 = "arith.muli"(%7, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %11 = "arith.index_cast"(%10) : (i32) -> index
    %12 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %13 = "memref.load"(%12, %11) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %14 = "arith.maxsi"(%13, %5) : (i32, i32) -> i32
    %15 = "arith.subi"(%arg5, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %16 = "arith.minsi"(%14, %15) : (i32, i32) -> i32
    %17 = "arith.muli"(%9, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %18 = "arith.index_cast"(%17) : (i32) -> index
    %19 = "arith.muli"(%16, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %20 = "arith.index_cast"(%19) : (i32) -> index
    %21 = "arith.addi"(%18, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %22 = "arith.index_cast"(%arg3) : (i32) -> index
    %23 = "arith.minsi"(%21, %22) : (index, index) -> index
    %24 = "arith.maxsi"(%23, %18) : (index, index) -> index
    %25 = "arith.subi"(%24, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %26 = "arith.addi"(%20, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %27 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xbf16>
    "linalg.fill"(%4, %27) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: bf16, %arg9: bf16):
      "linalg.yield"(%arg8) : (bf16) -> ()
    }) : (bf16, memref<128xbf16>) -> ()
    %28 = "memref.subview"(%arg1, %26, %25) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %29 = "memref.subview"(%27, %25) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<128xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%28, %29) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: bf16, %arg7: bf16):
      "linalg.yield"(%arg6) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %30 = "bufferization.to_tensor"(%27) <{restrict, writable}> : (memref<128xbf16>) -> tensor<128xbf16>
    %31 = "arith.muli"(%7, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %32 = "arith.index_cast"(%31) : (i32) -> index
    %33 = "arith.addi"(%32, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %34 = "tensor.extract_slice"(%30, %25) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<128xbf16>, index) -> tensor<?xbf16>
    %35 = "memref.subview"(%arg0, %33, %25) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%34, %35) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

