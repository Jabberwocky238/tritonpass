#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32) -> (), sym_name = "mul_func_kernel_rank_2"}> ({
  ^bb0(%arg6: memref<?xbf16>, %arg7: memref<?xbf16>, %arg8: memref<?xbf16>, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32):
    %6 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %7 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %8 = "arith.constant"() <{value = 12288 : index}> : () -> index
    %9 = "arith.constant"() <{value = 1 : index}> : () -> index
    %10 = "arith.constant"() <{value = 0 : index}> : () -> index
    %11 = "arith.constant"() <{value = 512 : index}> : () -> index
    %12 = "arith.constant"() <{value = 24576 : index}> : () -> index
    %13 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %14 = "arith.index_cast"(%13) : (index) -> i32
    %15 = "arith.extsi"(%14) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__i32_c1}> : () -> ()
    %16 = "func.call"(%arg10) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %17 = "arith.extsi"(%16) : (i32) -> i64
    %18 = "arith.remsi"(%15, %17) : (i64, i64) -> i64
    %19 = "arith.divsi"(%15, %17) : (i64, i64) -> i64
    %20 = "arith.index_cast"(%19) : (i64) -> index
    %21 = "arith.muli"(%18, %7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %22 = "arith.index_cast"(%21) : (i64) -> index
    %23 = "arith.muli"(%20, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %24 = "arith.index_cast"(%arg9) : (i32) -> index
    %25 = "arith.cmpi"(%20, %24) <{predicate = 2 : i64}> : (index, index) -> i1
    %26 = "arith.select"(%25, %9, %10) : (i1, index, index) -> index
    %27 = "arith.addi"(%22, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %28 = "arith.index_cast"(%arg10) : (i32) -> index
    %29 = "arith.minsi"(%27, %28) : (index, index) -> index
    %30 = "arith.maxsi"(%29, %22) : (index, index) -> index
    %31 = "arith.subi"(%30, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %32 = "arith.minsi"(%26, %9) : (index, index) -> index
    %33 = "arith.minsi"(%31, %11) : (index, index) -> index
    %34 = "arith.muli"(%33, %32) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %35 = "arith.addi"(%22, %23) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %36 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%6, %36) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: bf16, %arg20: bf16):
      "linalg.yield"(%arg19) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %37 = "memref.subview"(%arg6, %35, %34) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %38 = "memref.subview"(%36, %34) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%37, %38) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: bf16, %arg18: bf16):
      "linalg.yield"(%arg17) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %39 = "bufferization.to_tensor"(%36) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %40 = "tensor.expand_shape"(%39) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 512>}> : (tensor<512xbf16>) -> tensor<1x512xbf16>
    %41 = "arith.muli"(%20, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %42 = "arith.addi"(%22, %41) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %43 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%6, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: bf16, %arg16: bf16):
      "linalg.yield"(%arg15) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %44 = "memref.subview"(%arg7, %42, %34) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %45 = "memref.subview"(%43, %34) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%44, %45) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: bf16, %arg14: bf16):
      "linalg.yield"(%arg13) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %46 = "bufferization.to_tensor"(%43) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %47 = "tensor.expand_shape"(%46) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 512>}> : (tensor<512xbf16>) -> tensor<1x512xbf16>
    %48 = "func.call"(%40, %47) <{callee = @_dope.ops.mul.mul_func__bf16S1_512S_bf16S1_512S}> : (tensor<1x512xbf16>, tensor<1x512xbf16>) -> tensor<1x512xbf16>
    %49 = "tensor.collapse_shape"(%48) <{reassociation = [[0, 1]]}> : (tensor<1x512xbf16>) -> tensor<512xbf16>
    %50 = "tensor.extract_slice"(%49, %34) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<512xbf16>, index) -> tensor<?xbf16>
    %51 = "memref.subview"(%arg8, %35, %34) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%50, %51) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__i32_c1", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c512", sym_visibility = "private"}> ({
  ^bb0(%arg5: i32):
    %2 = "arith.constant"() <{value = 512 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 511 : i32}> : () -> i32
    %4 = "arith.addi"(%arg5, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %5 = "arith.divsi"(%4, %2) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x512xbf16>, tensor<1x512xbf16>) -> tensor<1x512xbf16>, sym_name = "_dope.ops.mul.mul_func__bf16S1_512S_bf16S1_512S", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<1x512xbf16>, %arg1: tensor<1x512xbf16>):
    %0 = "linalg.generic"(%arg0, %arg1, %arg0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: bf16, %arg3: bf16, %arg4: bf16):
      %1 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
      "linalg.yield"(%1) : (bf16) -> ()
    }) : (tensor<1x512xbf16>, tensor<1x512xbf16>, tensor<1x512xbf16>) -> tensor<1x512xbf16>
    "func.return"(%0) : (tensor<1x512xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

