#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32) -> (), sym_name = "sub_func_noalpha_kernel_rank_1"}> ({
  ^bb0(%arg5: memref<?xbf16>, %arg6: memref<?xbf16>, %arg7: memref<?xbf16>, %arg8: i32, %arg9: i32, %arg10: i32):
    %2 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %3 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %4 = "arith.constant"() <{value = 512 : index}> : () -> index
    %5 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %6 = "arith.index_cast"(%5) : (index) -> i32
    %7 = "arith.extsi"(%6) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__i32_c512}> : () -> ()
    %8 = "arith.muli"(%7, %3) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %9 = "arith.index_cast"(%8) : (i64) -> index
    %10 = "arith.addi"(%9, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %11 = "arith.index_cast"(%arg8) : (i32) -> index
    %12 = "arith.minsi"(%10, %11) : (index, index) -> index
    %13 = "arith.maxsi"(%12, %9) : (index, index) -> index
    %14 = "arith.subi"(%13, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %15 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%2, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: bf16, %arg18: bf16):
      "linalg.yield"(%arg17) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %16 = "memref.subview"(%arg5, %9, %14) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %17 = "memref.subview"(%15, %14) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%16, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: bf16, %arg16: bf16):
      "linalg.yield"(%arg15) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %18 = "bufferization.to_tensor"(%15) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %19 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%2, %19) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: bf16, %arg14: bf16):
      "linalg.yield"(%arg13) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %20 = "memref.subview"(%arg6, %9, %14) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %21 = "memref.subview"(%19, %14) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%20, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: bf16, %arg12: bf16):
      "linalg.yield"(%arg11) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %22 = "bufferization.to_tensor"(%19) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %23 = "func.call"(%18, %22) <{callee = @_dope.ops.sub.sub_func_noalpha__bf16S512S_bf16S512S}> : (tensor<512xbf16>, tensor<512xbf16>) -> tensor<512xbf16>
    %24 = "tensor.extract_slice"(%23, %14) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<512xbf16>, index) -> tensor<?xbf16>
    %25 = "memref.subview"(%arg7, %9, %14) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%24, %25) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__i32_c512", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<512xbf16>, tensor<512xbf16>) -> tensor<512xbf16>, sym_name = "_dope.ops.sub.sub_func_noalpha__bf16S512S_bf16S512S", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<512xbf16>, %arg1: tensor<512xbf16>):
    %0 = "linalg.generic"(%arg0, %arg1, %arg0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: bf16, %arg3: bf16, %arg4: bf16):
      %1 = "arith.subf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
      "linalg.yield"(%1) : (bf16) -> ()
    }) : (tensor<512xbf16>, tensor<512xbf16>, tensor<512xbf16>) -> tensor<512xbf16>
    "func.return"(%0) : (tensor<512xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

