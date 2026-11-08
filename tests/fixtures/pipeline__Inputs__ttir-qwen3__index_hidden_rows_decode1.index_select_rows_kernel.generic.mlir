"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xi32>, i32, i32) -> (), sym_name = "index_select_rows_kernel"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xi32>, %arg3: i32, %arg4: i32):
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
    %15 = "arith.addi"(%13, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %16 = "arith.select"(%14, %15, %13) : (i1, i32, i32) -> i32
    %17 = "arith.maxsi"(%16, %5) : (i32, i32) -> i32
    %18 = "arith.minsi"(%17, %5) : (i32, i32) -> i32
    %19 = "arith.muli"(%9, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %20 = "arith.index_cast"(%19) : (i32) -> index
    %21 = "arith.muli"(%18, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %22 = "arith.index_cast"(%21) : (i32) -> index
    %23 = "arith.addi"(%20, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %24 = "arith.index_cast"(%arg3) : (i32) -> index
    %25 = "arith.minsi"(%23, %24) : (index, index) -> index
    %26 = "arith.maxsi"(%25, %20) : (index, index) -> index
    %27 = "arith.subi"(%26, %20) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %28 = "arith.addi"(%22, %20) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %29 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%4, %29) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: bf16, %arg8: bf16):
      "linalg.yield"(%arg7) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %30 = "memref.subview"(%arg1, %28, %27) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %31 = "memref.subview"(%29, %27) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%30, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: bf16, %arg6: bf16):
      "linalg.yield"(%arg5) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %32 = "bufferization.to_tensor"(%29) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %33 = "arith.muli"(%7, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %34 = "arith.index_cast"(%33) : (i32) -> index
    %35 = "arith.addi"(%34, %20) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %36 = "tensor.extract_slice"(%32, %27) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<512xbf16>, index) -> tensor<?xbf16>
    %37 = "memref.subview"(%arg0, %35, %27) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%36, %37) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

