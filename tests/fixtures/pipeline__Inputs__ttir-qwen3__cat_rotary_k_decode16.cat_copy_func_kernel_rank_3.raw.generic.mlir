"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32, i32) -> (), sym_name = "cat_copy_func_kernel_rank_3"}> ({
  ^bb0(%arg3: memref<?xbf16>, %arg4: memref<?xbf16>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32):
    %8 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %9 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %10 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %11 = "arith.constant"() <{value = 512 : index}> : () -> index
    %12 = "arith.constant"() <{value = 64 : index}> : () -> index
    %13 = "arith.constant"() <{value = 1 : index}> : () -> index
    %14 = "arith.constant"() <{value = 0 : index}> : () -> index
    %15 = "arith.constant"() <{value = 8 : index}> : () -> index
    %16 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %17 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %18 = "arith.index_cast"(%17) : (index) -> i32
    %19 = "arith.extsi"(%18) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__i32_c1}> : () -> ()
    %20 = "func.call"(%arg6) <{callee = @triton.language.standard.cdiv__i32_c8}> : (i32) -> i32
    %21 = "func.call"(%arg7) <{callee = @triton.language.standard.cdiv__i32_c64}> : (i32) -> i32
    %22 = "arith.extsi"(%21) : (i32) -> i64
    %23 = "arith.remsi"(%19, %22) : (i64, i64) -> i64
    %24 = "arith.divsi"(%19, %22) : (i64, i64) -> i64
    %25 = "arith.extsi"(%20) : (i32) -> i64
    %26 = "arith.remsi"(%24, %25) : (i64, i64) -> i64
    %27 = "arith.divsi"(%24, %25) : (i64, i64) -> i64
    %28 = "arith.index_cast"(%27) : (i64) -> index
    %29 = "arith.muli"(%26, %9) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %30 = "arith.index_cast"(%29) : (i64) -> index
    %31 = "arith.muli"(%23, %10) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %32 = "arith.index_cast"(%31) : (i64) -> index
    %33 = "arith.muli"(%28, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %34 = "arith.index_cast"(%arg5) : (i32) -> index
    %35 = "arith.cmpi"(%28, %34) <{predicate = 2 : i64}> : (index, index) -> i1
    %36 = "arith.select"(%35, %13, %14) : (i1, index, index) -> index
    %37 = "arith.addi"(%30, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %38 = "arith.index_cast"(%arg6) : (i32) -> index
    %39 = "arith.minsi"(%37, %38) : (index, index) -> index
    %40 = "arith.maxsi"(%39, %30) : (index, index) -> index
    %41 = "arith.subi"(%40, %30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %42 = "arith.minsi"(%36, %13) : (index, index) -> index
    %43 = "arith.minsi"(%41, %15) : (index, index) -> index
    %44 = "arith.addi"(%32, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %45 = "arith.index_cast"(%arg7) : (i32) -> index
    %46 = "arith.minsi"(%44, %45) : (index, index) -> index
    %47 = "arith.maxsi"(%46, %32) : (index, index) -> index
    %48 = "arith.subi"(%47, %32) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %49 = "arith.minsi"(%42, %13) : (index, index) -> index
    %50 = "arith.minsi"(%43, %15) : (index, index) -> index
    %51 = "arith.minsi"(%48, %12) : (index, index) -> index
    %52 = "memref.reinterpret_cast"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 64, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>
    %53 = "arith.muli"(%50, %49) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %54 = "arith.addi"(%32, %33) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %55 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xbf16>
    "linalg.fill"(%8, %55) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: bf16, %arg13: bf16):
      "linalg.yield"(%arg12) : (bf16) -> ()
    }) : (bf16, memref<8x64xbf16>) -> ()
    %56 = "memref.subview"(%52, %30, %54, %53, %51) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[64, 1], offset: ?>>
    %57 = "memref.subview"(%55, %53, %51) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xbf16>, index, index) -> memref<?x?xbf16, strided<[64, 1]>>
    "linalg.copy"(%56, %57) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: bf16, %arg11: bf16):
      "linalg.yield"(%arg10) : (bf16) -> ()
    }) : (memref<?x?xbf16, strided<[64, 1], offset: ?>>, memref<?x?xbf16, strided<[64, 1]>>) -> ()
    %58 = "bufferization.to_tensor"(%55) <{restrict, writable}> : (memref<8x64xbf16>) -> tensor<8x64xbf16>
    %59 = "tensor.expand_shape"(%58) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 8, 64>}> : (tensor<8x64xbf16>) -> tensor<1x8x64xbf16>
    %60 = "func.call"(%59) <{callee = @_dope.ops.cat.cat_copy_func__bf16S1_8_64S}> : (tensor<1x8x64xbf16>) -> tensor<1x8x64xbf16>
    %61 = "arith.muli"(%28, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %62 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>
    %63 = "tensor.collapse_shape"(%60) <{reassociation = [[0, 1], [2]]}> : (tensor<1x8x64xbf16>) -> tensor<8x64xbf16>
    %64 = "arith.addi"(%32, %61) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %65 = "tensor.extract_slice"(%63, %53, %51) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<8x64xbf16>, index, index) -> tensor<?x?xbf16>
    %66 = "memref.subview"(%62, %30, %64, %53, %51) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[128, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%65, %66) <{writable}> : (tensor<?x?xbf16>, memref<?x?xbf16, strided<[128, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__i32_c1", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c8", sym_visibility = "private"}> ({
  ^bb0(%arg2: i32):
    %4 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %6 = "arith.addi"(%arg2, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %7 = "arith.divsi"(%6, %4) : (i32, i32) -> i32
    "func.return"(%7) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c64", sym_visibility = "private"}> ({
  ^bb0(%arg1: i32):
    %0 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 63 : i32}> : () -> i32
    %2 = "arith.addi"(%arg1, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %3 = "arith.divsi"(%2, %0) : (i32, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x8x64xbf16>) -> tensor<1x8x64xbf16>, sym_name = "_dope.ops.cat.cat_copy_func__bf16S1_8_64S", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<1x8x64xbf16>):
    "func.return"(%arg0) : (tensor<1x8x64xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

