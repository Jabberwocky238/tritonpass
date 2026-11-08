"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32) -> (), sym_name = "cat_copy_func_kernel_rank_3"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %1 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %3 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 63 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %8 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %9 = "arith.constant"() <{value = 1024 : i64}> : () -> i64
    %10 = "arith.constant"() <{value = 64 : index}> : () -> index
    %11 = "arith.constant"() <{value = 8 : index}> : () -> index
    %12 = "arith.constant"() <{value = 1 : index}> : () -> index
    %13 = "arith.constant"() <{value = 0 : index}> : () -> index
    %14 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %15 = "arith.index_cast"(%14) : (index) -> i32
    %16 = "arith.extsi"(%15) : (i32) -> i64
    %17 = "arith.addi"(%arg2, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %18 = "arith.divsi"(%17, %3) : (i32, i32) -> i32
    %19 = "arith.addi"(%arg3, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %20 = "arith.divsi"(%19, %5) : (i32, i32) -> i32
    %21 = "arith.extsi"(%20) : (i32) -> i64
    %22 = "arith.remsi"(%16, %21) : (i64, i64) -> i64
    %23 = "arith.divsi"(%16, %21) : (i64, i64) -> i64
    %24 = "arith.extsi"(%18) : (i32) -> i64
    %25 = "arith.remsi"(%23, %24) : (i64, i64) -> i64
    %26 = "arith.divsi"(%23, %24) : (i64, i64) -> i64
    %27 = "arith.muli"(%25, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %28 = "arith.index_cast"(%27) : (i64) -> index
    %29 = "arith.muli"(%22, %2) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %30 = "arith.index_cast"(%29) : (i64) -> index
    %31 = "arith.cmpi"(%26, %7) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %32 = "arith.muli"(%26, %8) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %33 = "arith.index_cast"(%32) : (i64) -> index
    %34 = "arith.addi"(%28, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %35 = "arith.index_cast"(%arg2) : (i32) -> index
    %36 = "arith.minsi"(%34, %35) : (index, index) -> index
    %37 = "arith.maxsi"(%36, %28) : (index, index) -> index
    %38 = "arith.subi"(%37, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %39 = "arith.select"(%31, %12, %13) : (i1, index, index) -> index
    %40 = "arith.select"(%31, %38, %13) : (i1, index, index) -> index
    %41 = "arith.addi"(%30, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %42 = "arith.index_cast"(%arg3) : (i32) -> index
    %43 = "arith.minsi"(%41, %42) : (index, index) -> index
    %44 = "arith.maxsi"(%43, %30) : (index, index) -> index
    %45 = "arith.subi"(%44, %30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %46 = "arith.minsi"(%39, %12) : (index, index) -> index
    %47 = "arith.minsi"(%40, %11) : (index, index) -> index
    %48 = "arith.minsi"(%45, %10) : (index, index) -> index
    %49 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 64, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>
    %50 = "arith.muli"(%47, %46) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %51 = "arith.addi"(%30, %33) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %52 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xbf16>
    "linalg.fill"(%0, %52) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: bf16, %arg9: bf16):
      "linalg.yield"(%arg8) : (bf16) -> ()
    }) : (bf16, memref<8x64xbf16>) -> ()
    %53 = "memref.subview"(%49, %28, %51, %50, %48) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[64, 1], offset: ?>>
    %54 = "memref.subview"(%52, %50, %48) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xbf16>, index, index) -> memref<?x?xbf16, strided<[64, 1]>>
    "linalg.copy"(%53, %54) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: bf16, %arg7: bf16):
      "linalg.yield"(%arg6) : (bf16) -> ()
    }) : (memref<?x?xbf16, strided<[64, 1], offset: ?>>, memref<?x?xbf16, strided<[64, 1]>>) -> ()
    %55 = "bufferization.to_tensor"(%52) <{restrict, writable}> : (memref<8x64xbf16>) -> tensor<8x64xbf16>
    %56 = "arith.muli"(%26, %9) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %57 = "arith.index_cast"(%56) : (i64) -> index
    %58 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>
    %59 = "arith.addi"(%30, %57) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %60 = "tensor.extract_slice"(%55, %50, %48) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<8x64xbf16>, index, index) -> tensor<?x?xbf16>
    %61 = "memref.subview"(%58, %28, %59, %50, %48) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[128, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%60, %61) <{writable}> : (tensor<?x?xbf16>, memref<?x?xbf16, strided<[128, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

