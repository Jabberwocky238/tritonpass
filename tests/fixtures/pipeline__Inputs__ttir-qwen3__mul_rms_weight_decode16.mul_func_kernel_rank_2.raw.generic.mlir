#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32) -> (), sym_name = "mul_func_kernel_rank_2"}> ({
  ^bb0(%arg6: memref<?xbf16>, %arg7: memref<?xbf16>, %arg8: memref<?xbf16>, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32):
    %6 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %7 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %8 = "arith.constant"() <{value = 4096 : index}> : () -> index
    %9 = "arith.constant"() <{value = 1 : index}> : () -> index
    %10 = "arith.constant"() <{value = 0 : index}> : () -> index
    %11 = "arith.constant"() <{value = 512 : index}> : () -> index
    %12 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %13 = "arith.index_cast"(%12) : (index) -> i32
    %14 = "arith.extsi"(%13) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__i32_c1}> : () -> ()
    %15 = "func.call"(%arg10) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %16 = "arith.extsi"(%15) : (i32) -> i64
    %17 = "arith.remsi"(%14, %16) : (i64, i64) -> i64
    %18 = "arith.divsi"(%14, %16) : (i64, i64) -> i64
    %19 = "arith.index_cast"(%18) : (i64) -> index
    %20 = "arith.muli"(%17, %7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %21 = "arith.index_cast"(%20) : (i64) -> index
    %22 = "arith.muli"(%19, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %23 = "arith.index_cast"(%arg9) : (i32) -> index
    %24 = "arith.cmpi"(%19, %23) <{predicate = 2 : i64}> : (index, index) -> i1
    %25 = "arith.select"(%24, %9, %10) : (i1, index, index) -> index
    %26 = "arith.addi"(%21, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %27 = "arith.index_cast"(%arg10) : (i32) -> index
    %28 = "arith.minsi"(%26, %27) : (index, index) -> index
    %29 = "arith.maxsi"(%28, %21) : (index, index) -> index
    %30 = "arith.subi"(%29, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %31 = "arith.minsi"(%25, %9) : (index, index) -> index
    %32 = "arith.minsi"(%30, %11) : (index, index) -> index
    %33 = "arith.muli"(%32, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %34 = "arith.addi"(%21, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %35 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%6, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: bf16, %arg20: bf16):
      "linalg.yield"(%arg19) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %36 = "memref.subview"(%arg6, %34, %33) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %37 = "memref.subview"(%35, %33) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%36, %37) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: bf16, %arg18: bf16):
      "linalg.yield"(%arg17) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %38 = "bufferization.to_tensor"(%35) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %39 = "tensor.expand_shape"(%38) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 512>}> : (tensor<512xbf16>) -> tensor<1x512xbf16>
    %40 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%6, %40) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: bf16, %arg16: bf16):
      "linalg.yield"(%arg15) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %41 = "memref.subview"(%arg7, %21, %33) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %42 = "memref.subview"(%40, %33) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%41, %42) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: bf16, %arg14: bf16):
      "linalg.yield"(%arg13) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %43 = "bufferization.to_tensor"(%40) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %44 = "tensor.expand_shape"(%43) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 512>}> : (tensor<512xbf16>) -> tensor<1x512xbf16>
    %45 = "func.call"(%39, %44) <{callee = @_dope.ops.mul.mul_func__bf16S1_512S_bf16S1_512S}> : (tensor<1x512xbf16>, tensor<1x512xbf16>) -> tensor<1x512xbf16>
    %46 = "tensor.collapse_shape"(%45) <{reassociation = [[0, 1]]}> : (tensor<1x512xbf16>) -> tensor<512xbf16>
    %47 = "tensor.extract_slice"(%46, %33) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<512xbf16>, index) -> tensor<?xbf16>
    %48 = "memref.subview"(%arg8, %34, %33) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%47, %48) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
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

