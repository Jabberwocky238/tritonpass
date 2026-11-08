"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xi32>, i32, i32, i32) -> (), sym_name = "index_select_rows_kernel"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xi32>, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 512 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 512 : index}> : () -> index
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
    %14 = "arith.cmpi"(%13, %5) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %15 = "arith.addi"(%13, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %16 = "arith.select"(%14, %15, %13) : (i1, i32, i32) -> i32
    %17 = "arith.maxsi"(%16, %5) : (i32, i32) -> i32
    %18 = "arith.subi"(%arg5, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %19 = "arith.minsi"(%17, %18) : (i32, i32) -> i32
    %20 = "arith.muli"(%9, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %21 = "arith.index_cast"(%20) : (i32) -> index
    %22 = "arith.muli"(%19, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %23 = "arith.index_cast"(%22) : (i32) -> index
    %24 = "arith.addi"(%21, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %25 = "arith.index_cast"(%arg3) : (i32) -> index
    %26 = "arith.minsi"(%24, %25) : (index, index) -> index
    %27 = "arith.maxsi"(%26, %21) : (index, index) -> index
    %28 = "arith.subi"(%27, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %29 = "arith.addi"(%23, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %30 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%4, %30) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: bf16, %arg9: bf16):
      "linalg.yield"(%arg8) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %31 = "memref.subview"(%arg1, %29, %28) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %32 = "memref.subview"(%30, %28) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%31, %32) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: bf16, %arg7: bf16):
      "linalg.yield"(%arg6) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %33 = "bufferization.to_tensor"(%30) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %34 = "arith.muli"(%7, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %35 = "arith.index_cast"(%34) : (i32) -> index
    %36 = "arith.addi"(%35, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %37 = "tensor.extract_slice"(%33, %28) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<512xbf16>, index) -> tensor<?xbf16>
    %38 = "memref.subview"(%arg0, %36, %28) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%37, %38) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

