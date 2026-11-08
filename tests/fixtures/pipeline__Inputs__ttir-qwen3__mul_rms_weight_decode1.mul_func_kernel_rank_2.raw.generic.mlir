#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32) -> (), sym_name = "mul_func_kernel_rank_2"}> ({
  ^bb0(%arg6: memref<?xbf16>, %arg7: memref<?xbf16>, %arg8: memref<?xbf16>, %arg9: i32, %arg10: i32, %arg11: i32):
    %6 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %7 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %8 = "arith.constant"() <{value = 4096 : index}> : () -> index
    %9 = "arith.constant"() <{value = 1 : index}> : () -> index
    %10 = "arith.constant"() <{value = 0 : index}> : () -> index
    %11 = "arith.constant"() <{value = 512 : index}> : () -> index
    %12 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %13 = "arith.index_cast"(%12) : (index) -> i32
    %14 = "arith.extsi"(%13) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__c1_c1}> : () -> ()
    %15 = "func.call"(%arg9) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %16 = "arith.extsi"(%15) : (i32) -> i64
    %17 = "arith.remsi"(%14, %16) : (i64, i64) -> i64
    %18 = "arith.divsi"(%14, %16) : (i64, i64) -> i64
    %19 = "arith.index_cast"(%18) : (i64) -> index
    %20 = "arith.muli"(%17, %7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %21 = "arith.index_cast"(%20) : (i64) -> index
    %22 = "arith.muli"(%19, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %23 = "arith.cmpi"(%19, %9) <{predicate = 2 : i64}> : (index, index) -> i1
    %24 = "arith.select"(%23, %9, %10) : (i1, index, index) -> index
    %25 = "arith.addi"(%21, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %26 = "arith.index_cast"(%arg9) : (i32) -> index
    %27 = "arith.minsi"(%25, %26) : (index, index) -> index
    %28 = "arith.maxsi"(%27, %21) : (index, index) -> index
    %29 = "arith.subi"(%28, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %30 = "arith.minsi"(%24, %9) : (index, index) -> index
    %31 = "arith.minsi"(%29, %11) : (index, index) -> index
    %32 = "arith.muli"(%31, %30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %33 = "arith.addi"(%21, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %34 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%6, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: bf16, %arg19: bf16):
      "linalg.yield"(%arg18) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %35 = "memref.subview"(%arg6, %33, %32) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %36 = "memref.subview"(%34, %32) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%35, %36) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: bf16, %arg17: bf16):
      "linalg.yield"(%arg16) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %37 = "bufferization.to_tensor"(%34) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %38 = "tensor.expand_shape"(%37) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 512>}> : (tensor<512xbf16>) -> tensor<1x512xbf16>
    %39 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%6, %39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: bf16, %arg15: bf16):
      "linalg.yield"(%arg14) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %40 = "memref.subview"(%arg7, %21, %32) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %41 = "memref.subview"(%39, %32) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%40, %41) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: bf16, %arg13: bf16):
      "linalg.yield"(%arg12) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %42 = "bufferization.to_tensor"(%39) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %43 = "tensor.expand_shape"(%42) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 512>}> : (tensor<512xbf16>) -> tensor<1x512xbf16>
    %44 = "func.call"(%38, %43) <{callee = @_dope.ops.mul.mul_func__bf16S1_512S_bf16S1_512S}> : (tensor<1x512xbf16>, tensor<1x512xbf16>) -> tensor<1x512xbf16>
    %45 = "tensor.collapse_shape"(%44) <{reassociation = [[0, 1]]}> : (tensor<1x512xbf16>) -> tensor<512xbf16>
    %46 = "tensor.extract_slice"(%45, %32) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<512xbf16>, index) -> tensor<?xbf16>
    %47 = "memref.subview"(%arg8, %33, %32) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%46, %47) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__c1_c1", sym_visibility = "private"}> ({
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

