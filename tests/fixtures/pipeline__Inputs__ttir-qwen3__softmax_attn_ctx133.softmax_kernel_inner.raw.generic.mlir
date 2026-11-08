#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32) -> (), sym_name = "softmax_kernel_inner"}> ({
  ^bb0(%arg10: memref<?xf32>, %arg11: memref<?xf32>, %arg12: i32, %arg13: i32):
    %9 = "arith.constant"() <{value = 256 : index}> : () -> index
    %10 = "arith.constant"() <{value = 0 : index}> : () -> index
    %11 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %12 = "func.call"() <{callee = @flag_gems.utils.triton_lang_extension.program_id__c0}> : () -> i64
    %13 = "arith.extsi"(%arg13) : (i32) -> i64
    %14 = "arith.muli"(%12, %13) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %15 = "arith.index_cast"(%14) : (i64) -> index
    %16 = "arith.index_cast"(%arg13) : (i32) -> index
    %17 = "arith.minsi"(%16, %9) : (index, index) -> index
    %18 = "arith.maxsi"(%17, %10) : (index, index) -> index
    %19 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<256xf32>
    "linalg.fill"(%11, %19) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg28: f32, %arg29: f32):
      "linalg.yield"(%arg28) : (f32) -> ()
    }) : (f32, memref<256xf32>) -> ()
    %20 = "memref.subview"(%arg11, %15, %18) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %21 = "memref.subview"(%19, %18) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<256xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%20, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg26: f32, %arg27: f32):
      "linalg.yield"(%arg26) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %22 = "bufferization.to_tensor"(%19) <{restrict, writable}> : (memref<256xf32>) -> tensor<256xf32>
    %23 = "func.call"(%22) <{callee = @triton.language.standard.max__fp32S256S_c0_cFalse_cTrue_cFalse}> : (tensor<256xf32>) -> f32
    %24 = "tensor.empty"() : () -> tensor<256xf32>
    %25 = "linalg.fill"(%23, %24) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: f32, %arg25: f32):
      "linalg.yield"(%arg24) : (f32) -> ()
    }) : (f32, tensor<256xf32>) -> tensor<256xf32>
    %26 = "linalg.generic"(%22, %25, %22) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: f32, %arg22: f32, %arg23: f32):
      %35 = "arith.subf"(%arg21, %arg22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%35) : (f32) -> ()
    }) : (tensor<256xf32>, tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
    %27 = "linalg.generic"(%26, %26) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32):
      %34 = "math.exp"(%arg19) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%34) : (f32) -> ()
    }) : (tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
    %28 = "func.call"(%27) <{callee = @triton.language.standard.sum__fp32S256S_c0_cFalse_cNone}> : (tensor<256xf32>) -> f32
    %29 = "linalg.fill"(%28, %24) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: f32, %arg18: f32):
      "linalg.yield"(%arg17) : (f32) -> ()
    }) : (f32, tensor<256xf32>) -> tensor<256xf32>
    %30 = "linalg.generic"(%27, %29, %27) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32, %arg16: f32):
      %33 = "arith.divf"(%arg14, %arg15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%33) : (f32) -> ()
    }) : (tensor<256xf32>, tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
    %31 = "tensor.extract_slice"(%30, %18) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<256xf32>, index) -> tensor<?xf32>
    %32 = "memref.subview"(%arg10, %15, %18) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%31, %32) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "flag_gems.utils.triton_lang_extension.program_id__c0", sym_visibility = "private"}> ({
    %6 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %7 = "arith.index_cast"(%6) : (index) -> i32
    %8 = "arith.extsi"(%7) : (i32) -> i64
    "func.return"(%8) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<256xf32>) -> f32, sym_name = "triton.language.standard.max__fp32S256S_c0_cFalse_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg7: tensor<256xf32>):
    %4 = "tt.reduce"(%arg7) <{axis = 0 : i32}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %5 = "func.call"(%arg8, %arg9) <{callee = @triton.language.standard._elementwise_max__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%5) : (f32) -> ()
    }) : (tensor<256xf32>) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._elementwise_max__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg5: f32, %arg6: f32):
    %3 = "arith.maxnumf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<256xf32>) -> f32, sym_name = "triton.language.standard.sum__fp32S256S_c0_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<256xf32>):
    %1 = "tt.reduce"(%arg2) <{axis = 0 : i32}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%2) : (f32) -> ()
    }) : (tensor<256xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

