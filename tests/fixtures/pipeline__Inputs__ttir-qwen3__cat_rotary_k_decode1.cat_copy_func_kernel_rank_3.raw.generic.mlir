"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32) -> (), sym_name = "cat_copy_func_kernel_rank_3"}> ({
  ^bb0(%arg3: memref<?xbf16>, %arg4: memref<?xbf16>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
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
    "func.call"() <{callee = @triton.language.standard.cdiv__c1_c1}> : () -> ()
    %20 = "func.call"(%arg5) <{callee = @triton.language.standard.cdiv__i32_c8}> : (i32) -> i32
    %21 = "func.call"(%arg6) <{callee = @triton.language.standard.cdiv__i32_c64}> : (i32) -> i32
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
    %34 = "arith.cmpi"(%28, %13) <{predicate = 2 : i64}> : (index, index) -> i1
    %35 = "arith.select"(%34, %13, %14) : (i1, index, index) -> index
    %36 = "arith.addi"(%30, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %37 = "arith.index_cast"(%arg5) : (i32) -> index
    %38 = "arith.minsi"(%36, %37) : (index, index) -> index
    %39 = "arith.maxsi"(%38, %30) : (index, index) -> index
    %40 = "arith.subi"(%39, %30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %41 = "arith.minsi"(%35, %13) : (index, index) -> index
    %42 = "arith.minsi"(%40, %15) : (index, index) -> index
    %43 = "arith.addi"(%32, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %44 = "arith.index_cast"(%arg6) : (i32) -> index
    %45 = "arith.minsi"(%43, %44) : (index, index) -> index
    %46 = "arith.maxsi"(%45, %32) : (index, index) -> index
    %47 = "arith.subi"(%46, %32) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %48 = "arith.minsi"(%41, %13) : (index, index) -> index
    %49 = "arith.minsi"(%42, %15) : (index, index) -> index
    %50 = "arith.minsi"(%47, %12) : (index, index) -> index
    %51 = "memref.reinterpret_cast"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 64, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>
    %52 = "arith.muli"(%49, %48) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %53 = "arith.addi"(%32, %33) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %54 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xbf16>
    "linalg.fill"(%8, %54) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: bf16, %arg12: bf16):
      "linalg.yield"(%arg11) : (bf16) -> ()
    }) : (bf16, memref<8x64xbf16>) -> ()
    %55 = "memref.subview"(%51, %30, %53, %52, %50) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[64, 1], offset: ?>>
    %56 = "memref.subview"(%54, %52, %50) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xbf16>, index, index) -> memref<?x?xbf16, strided<[64, 1]>>
    "linalg.copy"(%55, %56) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: bf16, %arg10: bf16):
      "linalg.yield"(%arg9) : (bf16) -> ()
    }) : (memref<?x?xbf16, strided<[64, 1], offset: ?>>, memref<?x?xbf16, strided<[64, 1]>>) -> ()
    %57 = "bufferization.to_tensor"(%54) <{restrict, writable}> : (memref<8x64xbf16>) -> tensor<8x64xbf16>
    %58 = "tensor.expand_shape"(%57) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 8, 64>}> : (tensor<8x64xbf16>) -> tensor<1x8x64xbf16>
    %59 = "func.call"(%58) <{callee = @_dope.ops.cat.cat_copy_func__bf16S1_8_64S}> : (tensor<1x8x64xbf16>) -> tensor<1x8x64xbf16>
    %60 = "arith.muli"(%28, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %61 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>
    %62 = "tensor.collapse_shape"(%59) <{reassociation = [[0, 1], [2]]}> : (tensor<1x8x64xbf16>) -> tensor<8x64xbf16>
    %63 = "arith.addi"(%32, %60) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %64 = "tensor.extract_slice"(%62, %52, %50) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<8x64xbf16>, index, index) -> tensor<?x?xbf16>
    %65 = "memref.subview"(%61, %30, %63, %52, %50) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[128, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%64, %65) <{writable}> : (tensor<?x?xbf16>, memref<?x?xbf16, strided<[128, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__c1_c1", sym_visibility = "private"}> ({
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

