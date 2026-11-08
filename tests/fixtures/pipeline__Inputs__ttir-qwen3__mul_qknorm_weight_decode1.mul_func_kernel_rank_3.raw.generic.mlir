#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32) -> (), sym_name = "mul_func_kernel_rank_3"}> ({
  ^bb0(%arg7: memref<?xbf16>, %arg8: memref<?xbf16>, %arg9: memref<?xbf16>, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32):
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
    "func.call"() <{callee = @triton.language.standard.cdiv__c1_c1}> : () -> ()
    %21 = "func.call"(%arg10) <{callee = @triton.language.standard.cdiv__i32_c4}> : (i32) -> i32
    %22 = "func.call"(%arg11) <{callee = @triton.language.standard.cdiv__i32_c128}> : (i32) -> i32
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
    %35 = "arith.cmpi"(%29, %15) <{predicate = 2 : i64}> : (index, index) -> i1
    %36 = "arith.select"(%35, %15, %16) : (i1, index, index) -> index
    %37 = "arith.addi"(%31, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %38 = "arith.index_cast"(%arg10) : (i32) -> index
    %39 = "arith.minsi"(%37, %38) : (index, index) -> index
    %40 = "arith.maxsi"(%39, %31) : (index, index) -> index
    %41 = "arith.subi"(%40, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %42 = "arith.minsi"(%36, %15) : (index, index) -> index
    %43 = "arith.minsi"(%41, %17) : (index, index) -> index
    %44 = "arith.addi"(%33, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %45 = "arith.index_cast"(%arg11) : (i32) -> index
    %46 = "arith.minsi"(%44, %45) : (index, index) -> index
    %47 = "arith.maxsi"(%46, %33) : (index, index) -> index
    %48 = "arith.subi"(%47, %33) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %49 = "arith.minsi"(%42, %15) : (index, index) -> index
    %50 = "arith.minsi"(%43, %17) : (index, index) -> index
    %51 = "arith.minsi"(%48, %14) : (index, index) -> index
    %52 = "memref.reinterpret_cast"(%arg7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>
    %53 = "arith.muli"(%50, %49) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %54 = "arith.addi"(%33, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %55 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x128xbf16>
    "linalg.fill"(%10, %55) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: bf16, %arg21: bf16):
      "linalg.yield"(%arg20) : (bf16) -> ()
    }) : (bf16, memref<4x128xbf16>) -> ()
    %56 = "memref.subview"(%52, %31, %54, %53, %51) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[128, 1], offset: ?>>
    %57 = "memref.subview"(%55, %53, %51) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<4x128xbf16>, index, index) -> memref<?x?xbf16, strided<[128, 1]>>
    "linalg.copy"(%56, %57) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: bf16, %arg19: bf16):
      "linalg.yield"(%arg18) : (bf16) -> ()
    }) : (memref<?x?xbf16, strided<[128, 1], offset: ?>>, memref<?x?xbf16, strided<[128, 1]>>) -> ()
    %58 = "bufferization.to_tensor"(%55) <{restrict, writable}> : (memref<4x128xbf16>) -> tensor<4x128xbf16>
    %59 = "tensor.expand_shape"(%58) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 4, 128>}> : (tensor<4x128xbf16>) -> tensor<1x4x128xbf16>
    %60 = "memref.reinterpret_cast"(%arg8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 0, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[0, 1]>>
    %61 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x128xbf16>
    "linalg.fill"(%10, %61) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: bf16, %arg17: bf16):
      "linalg.yield"(%arg16) : (bf16) -> ()
    }) : (bf16, memref<4x128xbf16>) -> ()
    %62 = "memref.subview"(%60, %33, %53, %51) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[0, 1]>>, index, index, index) -> memref<?x?xbf16, strided<[0, 1], offset: ?>>
    %63 = "memref.subview"(%61, %53, %51) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<4x128xbf16>, index, index) -> memref<?x?xbf16, strided<[128, 1]>>
    "linalg.copy"(%62, %63) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: bf16, %arg15: bf16):
      "linalg.yield"(%arg14) : (bf16) -> ()
    }) : (memref<?x?xbf16, strided<[0, 1], offset: ?>>, memref<?x?xbf16, strided<[128, 1]>>) -> ()
    %64 = "bufferization.to_tensor"(%61) <{restrict, writable}> : (memref<4x128xbf16>) -> tensor<4x128xbf16>
    %65 = "tensor.expand_shape"(%64) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 4, 128>}> : (tensor<4x128xbf16>) -> tensor<1x4x128xbf16>
    %66 = "func.call"(%59, %65) <{callee = @_dope.ops.mul.mul_func__bf16S1_4_128S_bf16S1_4_128S}> : (tensor<1x4x128xbf16>, tensor<1x4x128xbf16>) -> tensor<1x4x128xbf16>
    %67 = "memref.reinterpret_cast"(%arg9) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>
    %68 = "tensor.collapse_shape"(%66) <{reassociation = [[0, 1], [2]]}> : (tensor<1x4x128xbf16>) -> tensor<4x128xbf16>
    %69 = "tensor.extract_slice"(%68, %53, %51) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<4x128xbf16>, index, index) -> tensor<?x?xbf16>
    %70 = "memref.subview"(%67, %31, %54, %53, %51) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[128, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%69, %70) <{writable}> : (tensor<?x?xbf16>, memref<?x?xbf16, strided<[128, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__c1_c1", sym_visibility = "private"}> ({
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

