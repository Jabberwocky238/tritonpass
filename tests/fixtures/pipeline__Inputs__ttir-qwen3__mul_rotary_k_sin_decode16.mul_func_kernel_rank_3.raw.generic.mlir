#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32, i32) -> (), sym_name = "mul_func_kernel_rank_3"}> ({
  ^bb0(%arg7: memref<?xbf16>, %arg8: memref<?xbf16>, %arg9: memref<?xbf16>, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32):
    %10 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %11 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %12 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %13 = "arith.constant"() <{value = 6144 : index}> : () -> index
    %14 = "arith.constant"() <{value = 128 : index}> : () -> index
    %15 = "arith.constant"() <{value = 1 : index}> : () -> index
    %16 = "arith.constant"() <{value = 0 : index}> : () -> index
    %17 = "arith.constant"() <{value = 8 : index}> : () -> index
    %18 = "arith.constant"() <{value = 64 : index}> : () -> index
    %19 = "arith.constant"() <{value = 512 : index}> : () -> index
    %20 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %21 = "arith.index_cast"(%20) : (index) -> i32
    %22 = "arith.extsi"(%21) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__i32_c1}> : () -> ()
    %23 = "func.call"(%arg11) <{callee = @triton.language.standard.cdiv__i32_c8}> : (i32) -> i32
    %24 = "func.call"(%arg12) <{callee = @triton.language.standard.cdiv__i32_c64}> : (i32) -> i32
    %25 = "arith.extsi"(%24) : (i32) -> i64
    %26 = "arith.remsi"(%22, %25) : (i64, i64) -> i64
    %27 = "arith.divsi"(%22, %25) : (i64, i64) -> i64
    %28 = "arith.extsi"(%23) : (i32) -> i64
    %29 = "arith.remsi"(%27, %28) : (i64, i64) -> i64
    %30 = "arith.divsi"(%27, %28) : (i64, i64) -> i64
    %31 = "arith.index_cast"(%30) : (i64) -> index
    %32 = "arith.muli"(%29, %11) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %33 = "arith.index_cast"(%32) : (i64) -> index
    %34 = "arith.muli"(%26, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %35 = "arith.index_cast"(%34) : (i64) -> index
    %36 = "arith.muli"(%31, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %37 = "arith.index_cast"(%arg10) : (i32) -> index
    %38 = "arith.cmpi"(%31, %37) <{predicate = 2 : i64}> : (index, index) -> i1
    %39 = "arith.select"(%38, %15, %16) : (i1, index, index) -> index
    %40 = "arith.addi"(%33, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %41 = "arith.index_cast"(%arg11) : (i32) -> index
    %42 = "arith.minsi"(%40, %41) : (index, index) -> index
    %43 = "arith.maxsi"(%42, %33) : (index, index) -> index
    %44 = "arith.subi"(%43, %33) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %45 = "arith.minsi"(%39, %15) : (index, index) -> index
    %46 = "arith.minsi"(%44, %17) : (index, index) -> index
    %47 = "arith.addi"(%35, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %48 = "arith.index_cast"(%arg12) : (i32) -> index
    %49 = "arith.minsi"(%47, %48) : (index, index) -> index
    %50 = "arith.maxsi"(%49, %35) : (index, index) -> index
    %51 = "arith.subi"(%50, %35) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %52 = "arith.minsi"(%45, %15) : (index, index) -> index
    %53 = "arith.minsi"(%46, %17) : (index, index) -> index
    %54 = "arith.minsi"(%51, %18) : (index, index) -> index
    %55 = "memref.reinterpret_cast"(%arg7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>
    %56 = "arith.muli"(%53, %52) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %57 = "arith.addi"(%35, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %58 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xbf16>
    "linalg.fill"(%10, %58) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: bf16, %arg22: bf16):
      "linalg.yield"(%arg21) : (bf16) -> ()
    }) : (bf16, memref<8x64xbf16>) -> ()
    %59 = "memref.subview"(%55, %33, %57, %56, %54) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[128, 1], offset: ?>>
    %60 = "memref.subview"(%58, %56, %54) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xbf16>, index, index) -> memref<?x?xbf16, strided<[64, 1]>>
    "linalg.copy"(%59, %60) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: bf16, %arg20: bf16):
      "linalg.yield"(%arg19) : (bf16) -> ()
    }) : (memref<?x?xbf16, strided<[128, 1], offset: ?>>, memref<?x?xbf16, strided<[64, 1]>>) -> ()
    %61 = "bufferization.to_tensor"(%58) <{restrict, writable}> : (memref<8x64xbf16>) -> tensor<8x64xbf16>
    %62 = "tensor.expand_shape"(%61) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 8, 64>}> : (tensor<8x64xbf16>) -> tensor<1x8x64xbf16>
    %63 = "arith.muli"(%31, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %64 = "memref.reinterpret_cast"(%arg8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 0, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[0, 1]>>
    %65 = "arith.addi"(%35, %63) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %66 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xbf16>
    "linalg.fill"(%10, %66) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: bf16, %arg18: bf16):
      "linalg.yield"(%arg17) : (bf16) -> ()
    }) : (bf16, memref<8x64xbf16>) -> ()
    %67 = "memref.subview"(%64, %65, %56, %54) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[0, 1]>>, index, index, index) -> memref<?x?xbf16, strided<[0, 1], offset: ?>>
    %68 = "memref.subview"(%66, %56, %54) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xbf16>, index, index) -> memref<?x?xbf16, strided<[64, 1]>>
    "linalg.copy"(%67, %68) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: bf16, %arg16: bf16):
      "linalg.yield"(%arg15) : (bf16) -> ()
    }) : (memref<?x?xbf16, strided<[0, 1], offset: ?>>, memref<?x?xbf16, strided<[64, 1]>>) -> ()
    %69 = "bufferization.to_tensor"(%66) <{restrict, writable}> : (memref<8x64xbf16>) -> tensor<8x64xbf16>
    %70 = "tensor.expand_shape"(%69) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 8, 64>}> : (tensor<8x64xbf16>) -> tensor<1x8x64xbf16>
    %71 = "func.call"(%62, %70) <{callee = @_dope.ops.mul.mul_func__bf16S1_8_64S_bf16S1_8_64S}> : (tensor<1x8x64xbf16>, tensor<1x8x64xbf16>) -> tensor<1x8x64xbf16>
    %72 = "arith.muli"(%31, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %73 = "memref.reinterpret_cast"(%arg9) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 64, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>
    %74 = "tensor.collapse_shape"(%71) <{reassociation = [[0, 1], [2]]}> : (tensor<1x8x64xbf16>) -> tensor<8x64xbf16>
    %75 = "arith.addi"(%35, %72) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %76 = "tensor.extract_slice"(%74, %56, %54) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<8x64xbf16>, index, index) -> tensor<?x?xbf16>
    %77 = "memref.subview"(%73, %33, %75, %56, %54) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[64, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%76, %77) <{writable}> : (tensor<?x?xbf16>, memref<?x?xbf16, strided<[64, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__i32_c1", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c8", sym_visibility = "private"}> ({
  ^bb0(%arg6: i32):
    %6 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %8 = "arith.addi"(%arg6, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %9 = "arith.divsi"(%8, %6) : (i32, i32) -> i32
    "func.return"(%9) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c64", sym_visibility = "private"}> ({
  ^bb0(%arg5: i32):
    %2 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 63 : i32}> : () -> i32
    %4 = "arith.addi"(%arg5, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %5 = "arith.divsi"(%4, %2) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x8x64xbf16>, tensor<1x8x64xbf16>) -> tensor<1x8x64xbf16>, sym_name = "_dope.ops.mul.mul_func__bf16S1_8_64S_bf16S1_8_64S", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<1x8x64xbf16>, %arg1: tensor<1x8x64xbf16>):
    %0 = "linalg.generic"(%arg0, %arg1, %arg0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: bf16, %arg3: bf16, %arg4: bf16):
      %1 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
      "linalg.yield"(%1) : (bf16) -> ()
    }) : (tensor<1x8x64xbf16>, tensor<1x8x64xbf16>, tensor<1x8x64xbf16>) -> tensor<1x8x64xbf16>
    "func.return"(%0) : (tensor<1x8x64xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

