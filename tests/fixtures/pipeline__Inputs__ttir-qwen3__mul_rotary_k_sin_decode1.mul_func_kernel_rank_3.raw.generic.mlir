#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32) -> (), sym_name = "mul_func_kernel_rank_3"}> ({
  ^bb0(%arg7: memref<?xbf16>, %arg8: memref<?xbf16>, %arg9: memref<?xbf16>, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32):
    %10 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %11 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %12 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %13 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %14 = "arith.constant"() <{value = 128 : index}> : () -> index
    %15 = "arith.constant"() <{value = 1 : index}> : () -> index
    %16 = "arith.constant"() <{value = 0 : index}> : () -> index
    %17 = "arith.constant"() <{value = 8 : index}> : () -> index
    %18 = "arith.constant"() <{value = 64 : index}> : () -> index
    %19 = "arith.constant"() <{value = 512 : index}> : () -> index
    %20 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %21 = "arith.index_cast"(%20) : (index) -> i32
    %22 = "arith.extsi"(%21) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__c1_c1}> : () -> ()
    %23 = "func.call"(%arg10) <{callee = @triton.language.standard.cdiv__i32_c8}> : (i32) -> i32
    %24 = "func.call"(%arg11) <{callee = @triton.language.standard.cdiv__i32_c64}> : (i32) -> i32
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
    %37 = "arith.cmpi"(%31, %15) <{predicate = 2 : i64}> : (index, index) -> i1
    %38 = "arith.select"(%37, %15, %16) : (i1, index, index) -> index
    %39 = "arith.addi"(%33, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %40 = "arith.index_cast"(%arg10) : (i32) -> index
    %41 = "arith.minsi"(%39, %40) : (index, index) -> index
    %42 = "arith.maxsi"(%41, %33) : (index, index) -> index
    %43 = "arith.subi"(%42, %33) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %44 = "arith.minsi"(%38, %15) : (index, index) -> index
    %45 = "arith.minsi"(%43, %17) : (index, index) -> index
    %46 = "arith.addi"(%35, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %47 = "arith.index_cast"(%arg11) : (i32) -> index
    %48 = "arith.minsi"(%46, %47) : (index, index) -> index
    %49 = "arith.maxsi"(%48, %35) : (index, index) -> index
    %50 = "arith.subi"(%49, %35) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %51 = "arith.minsi"(%44, %15) : (index, index) -> index
    %52 = "arith.minsi"(%45, %17) : (index, index) -> index
    %53 = "arith.minsi"(%50, %18) : (index, index) -> index
    %54 = "memref.reinterpret_cast"(%arg7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>
    %55 = "arith.muli"(%52, %51) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %56 = "arith.addi"(%35, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %57 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xbf16>
    "linalg.fill"(%10, %57) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: bf16, %arg21: bf16):
      "linalg.yield"(%arg20) : (bf16) -> ()
    }) : (bf16, memref<8x64xbf16>) -> ()
    %58 = "memref.subview"(%54, %33, %56, %55, %53) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[128, 1], offset: ?>>
    %59 = "memref.subview"(%57, %55, %53) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xbf16>, index, index) -> memref<?x?xbf16, strided<[64, 1]>>
    "linalg.copy"(%58, %59) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: bf16, %arg19: bf16):
      "linalg.yield"(%arg18) : (bf16) -> ()
    }) : (memref<?x?xbf16, strided<[128, 1], offset: ?>>, memref<?x?xbf16, strided<[64, 1]>>) -> ()
    %60 = "bufferization.to_tensor"(%57) <{restrict, writable}> : (memref<8x64xbf16>) -> tensor<8x64xbf16>
    %61 = "tensor.expand_shape"(%60) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 8, 64>}> : (tensor<8x64xbf16>) -> tensor<1x8x64xbf16>
    %62 = "arith.muli"(%31, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %63 = "memref.reinterpret_cast"(%arg8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 0, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[0, 1]>>
    %64 = "arith.addi"(%35, %62) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %65 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xbf16>
    "linalg.fill"(%10, %65) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: bf16, %arg17: bf16):
      "linalg.yield"(%arg16) : (bf16) -> ()
    }) : (bf16, memref<8x64xbf16>) -> ()
    %66 = "memref.subview"(%63, %64, %55, %53) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[0, 1]>>, index, index, index) -> memref<?x?xbf16, strided<[0, 1], offset: ?>>
    %67 = "memref.subview"(%65, %55, %53) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xbf16>, index, index) -> memref<?x?xbf16, strided<[64, 1]>>
    "linalg.copy"(%66, %67) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: bf16, %arg15: bf16):
      "linalg.yield"(%arg14) : (bf16) -> ()
    }) : (memref<?x?xbf16, strided<[0, 1], offset: ?>>, memref<?x?xbf16, strided<[64, 1]>>) -> ()
    %68 = "bufferization.to_tensor"(%65) <{restrict, writable}> : (memref<8x64xbf16>) -> tensor<8x64xbf16>
    %69 = "tensor.expand_shape"(%68) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 8, 64>}> : (tensor<8x64xbf16>) -> tensor<1x8x64xbf16>
    %70 = "func.call"(%61, %69) <{callee = @_dope.ops.mul.mul_func__bf16S1_8_64S_bf16S1_8_64S}> : (tensor<1x8x64xbf16>, tensor<1x8x64xbf16>) -> tensor<1x8x64xbf16>
    %71 = "arith.muli"(%31, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %72 = "memref.reinterpret_cast"(%arg9) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 64, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>
    %73 = "tensor.collapse_shape"(%70) <{reassociation = [[0, 1], [2]]}> : (tensor<1x8x64xbf16>) -> tensor<8x64xbf16>
    %74 = "arith.addi"(%35, %71) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %75 = "tensor.extract_slice"(%73, %55, %53) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<8x64xbf16>, index, index) -> tensor<?x?xbf16>
    %76 = "memref.subview"(%72, %33, %74, %55, %53) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[64, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%75, %76) <{writable}> : (tensor<?x?xbf16>, memref<?x?xbf16, strided<[64, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__c1_c1", sym_visibility = "private"}> ({
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

