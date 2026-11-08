#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32, i32) -> (), sym_name = "mul_func_kernel_rank_3"}> ({
  ^bb0(%arg7: memref<?xbf16>, %arg8: memref<?xbf16>, %arg9: memref<?xbf16>, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32):
    %10 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %11 = "arith.constant"() <{value = 4 : i64}> : () -> i64
    %12 = "arith.constant"() <{value = 128 : i64}> : () -> i64
    %13 = "arith.constant"() <{value = 4096 : index}> : () -> index
    %14 = "arith.constant"() <{value = 128 : index}> : () -> index
    %15 = "arith.constant"() <{value = 1 : index}> : () -> index
    %16 = "arith.constant"() <{value = 0 : index}> : () -> index
    %17 = "arith.constant"() <{value = 4 : index}> : () -> index
    %18 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %19 = "arith.index_cast"(%18) : (index) -> i32
    %20 = "arith.extsi"(%19) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__i32_c1}> : () -> ()
    %21 = "func.call"(%arg11) <{callee = @triton.language.standard.cdiv__i32_c4}> : (i32) -> i32
    %22 = "func.call"(%arg12) <{callee = @triton.language.standard.cdiv__i32_c128}> : (i32) -> i32
    %23 = "arith.extsi"(%22) : (i32) -> i64
    %24 = "arith.remsi"(%20, %23) : (i64, i64) -> i64
    %25 = "arith.divsi"(%20, %23) : (i64, i64) -> i64
    %26 = "arith.extsi"(%21) : (i32) -> i64
    %27 = "arith.remsi"(%25, %26) : (i64, i64) -> i64
    %28 = "arith.divsi"(%25, %26) : (i64, i64) -> i64
    %29 = "arith.index_cast"(%28) : (i64) -> index
    %30 = "arith.muli"(%27, %11) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %31 = "arith.index_cast"(%30) : (i64) -> index
    %32 = "arith.muli"(%24, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %33 = "arith.index_cast"(%32) : (i64) -> index
    %34 = "arith.muli"(%29, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %35 = "arith.index_cast"(%arg10) : (i32) -> index
    %36 = "arith.cmpi"(%29, %35) <{predicate = 2 : i64}> : (index, index) -> i1
    %37 = "arith.select"(%36, %15, %16) : (i1, index, index) -> index
    %38 = "arith.addi"(%31, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %39 = "arith.index_cast"(%arg11) : (i32) -> index
    %40 = "arith.minsi"(%38, %39) : (index, index) -> index
    %41 = "arith.maxsi"(%40, %31) : (index, index) -> index
    %42 = "arith.subi"(%41, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %43 = "arith.minsi"(%37, %15) : (index, index) -> index
    %44 = "arith.minsi"(%42, %17) : (index, index) -> index
    %45 = "arith.addi"(%33, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %46 = "arith.index_cast"(%arg12) : (i32) -> index
    %47 = "arith.minsi"(%45, %46) : (index, index) -> index
    %48 = "arith.maxsi"(%47, %33) : (index, index) -> index
    %49 = "arith.subi"(%48, %33) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %50 = "arith.minsi"(%43, %15) : (index, index) -> index
    %51 = "arith.minsi"(%44, %17) : (index, index) -> index
    %52 = "arith.minsi"(%49, %14) : (index, index) -> index
    %53 = "memref.reinterpret_cast"(%arg7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>
    %54 = "arith.muli"(%51, %50) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %55 = "arith.addi"(%33, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %56 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x128xbf16>
    "linalg.fill"(%10, %56) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: bf16, %arg22: bf16):
      "linalg.yield"(%arg21) : (bf16) -> ()
    }) : (bf16, memref<4x128xbf16>) -> ()
    %57 = "memref.subview"(%53, %31, %55, %54, %52) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[128, 1], offset: ?>>
    %58 = "memref.subview"(%56, %54, %52) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<4x128xbf16>, index, index) -> memref<?x?xbf16, strided<[128, 1]>>
    "linalg.copy"(%57, %58) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: bf16, %arg20: bf16):
      "linalg.yield"(%arg19) : (bf16) -> ()
    }) : (memref<?x?xbf16, strided<[128, 1], offset: ?>>, memref<?x?xbf16, strided<[128, 1]>>) -> ()
    %59 = "bufferization.to_tensor"(%56) <{restrict, writable}> : (memref<4x128xbf16>) -> tensor<4x128xbf16>
    %60 = "tensor.expand_shape"(%59) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 4, 128>}> : (tensor<4x128xbf16>) -> tensor<1x4x128xbf16>
    %61 = "memref.reinterpret_cast"(%arg8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 0, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[0, 1]>>
    %62 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x128xbf16>
    "linalg.fill"(%10, %62) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: bf16, %arg18: bf16):
      "linalg.yield"(%arg17) : (bf16) -> ()
    }) : (bf16, memref<4x128xbf16>) -> ()
    %63 = "memref.subview"(%61, %33, %54, %52) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[0, 1]>>, index, index, index) -> memref<?x?xbf16, strided<[0, 1], offset: ?>>
    %64 = "memref.subview"(%62, %54, %52) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<4x128xbf16>, index, index) -> memref<?x?xbf16, strided<[128, 1]>>
    "linalg.copy"(%63, %64) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: bf16, %arg16: bf16):
      "linalg.yield"(%arg15) : (bf16) -> ()
    }) : (memref<?x?xbf16, strided<[0, 1], offset: ?>>, memref<?x?xbf16, strided<[128, 1]>>) -> ()
    %65 = "bufferization.to_tensor"(%62) <{restrict, writable}> : (memref<4x128xbf16>) -> tensor<4x128xbf16>
    %66 = "tensor.expand_shape"(%65) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 4, 128>}> : (tensor<4x128xbf16>) -> tensor<1x4x128xbf16>
    %67 = "func.call"(%60, %66) <{callee = @_dope.ops.mul.mul_func__bf16S1_4_128S_bf16S1_4_128S}> : (tensor<1x4x128xbf16>, tensor<1x4x128xbf16>) -> tensor<1x4x128xbf16>
    %68 = "memref.reinterpret_cast"(%arg9) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>
    %69 = "tensor.collapse_shape"(%67) <{reassociation = [[0, 1], [2]]}> : (tensor<1x4x128xbf16>) -> tensor<4x128xbf16>
    %70 = "tensor.extract_slice"(%69, %54, %52) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<4x128xbf16>, index, index) -> tensor<?x?xbf16>
    %71 = "memref.subview"(%68, %31, %55, %54, %52) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[128, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%70, %71) <{writable}> : (tensor<?x?xbf16>, memref<?x?xbf16, strided<[128, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__i32_c1", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c4", sym_visibility = "private"}> ({
  ^bb0(%arg6: i32):
    %6 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %8 = "arith.addi"(%arg6, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %9 = "arith.divsi"(%8, %6) : (i32, i32) -> i32
    "func.return"(%9) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c128", sym_visibility = "private"}> ({
  ^bb0(%arg5: i32):
    %2 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 127 : i32}> : () -> i32
    %4 = "arith.addi"(%arg5, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %5 = "arith.divsi"(%4, %2) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x4x128xbf16>, tensor<1x4x128xbf16>) -> tensor<1x4x128xbf16>, sym_name = "_dope.ops.mul.mul_func__bf16S1_4_128S_bf16S1_4_128S", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<1x4x128xbf16>, %arg1: tensor<1x4x128xbf16>):
    %0 = "linalg.generic"(%arg0, %arg1, %arg0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: bf16, %arg3: bf16, %arg4: bf16):
      %1 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
      "linalg.yield"(%1) : (bf16) -> ()
    }) : (tensor<1x4x128xbf16>, tensor<1x4x128xbf16>, tensor<1x4x128xbf16>) -> tensor<1x4x128xbf16>
    "func.return"(%0) : (tensor<1x4x128xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

