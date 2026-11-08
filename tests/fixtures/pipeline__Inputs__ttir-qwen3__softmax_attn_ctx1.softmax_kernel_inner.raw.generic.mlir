#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32) -> (), sym_name = "softmax_kernel_inner"}> ({
  ^bb0(%arg10: memref<?xf32>, %arg11: memref<?xf32>, %arg12: i32):
    %9 = "func.call"() <{callee = @flag_gems.utils.triton_lang_extension.program_id__c0}> : () -> i64
    %10 = "arith.index_cast"(%9) : (i64) -> index
    %11 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xf32>
    %12 = "memref.subview"(%arg11, %10) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "linalg.copy"(%12, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: f32, %arg26: f32):
      "linalg.yield"(%arg25) : (f32) -> ()
    }) : (memref<1xf32, strided<[1], offset: ?>>, memref<1xf32>) -> ()
    %13 = "bufferization.to_tensor"(%11) <{restrict, writable}> : (memref<1xf32>) -> tensor<1xf32>
    %14 = "func.call"(%13) <{callee = @triton.language.standard.max__fp32S1S_c0_cFalse_cTrue_cFalse}> : (tensor<1xf32>) -> f32
    %15 = "tensor.empty"() : () -> tensor<1xf32>
    %16 = "linalg.fill"(%14, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: f32, %arg24: f32):
      "linalg.yield"(%arg23) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %17 = "linalg.generic"(%13, %16, %13) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: f32, %arg21: f32, %arg22: f32):
      %25 = "arith.subf"(%arg20, %arg21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%25) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %18 = "linalg.generic"(%17, %17) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: f32, %arg19: f32):
      %24 = "math.exp"(%arg18) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%24) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %19 = "func.call"(%18) <{callee = @triton.language.standard.sum__fp32S1S_c0_cFalse_cNone}> : (tensor<1xf32>) -> f32
    %20 = "linalg.fill"(%19, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: f32, %arg17: f32):
      "linalg.yield"(%arg16) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %21 = "linalg.generic"(%18, %20, %18) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32, %arg15: f32):
      %23 = "arith.divf"(%arg13, %arg14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%23) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %22 = "memref.subview"(%arg10, %10) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%21, %22) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "flag_gems.utils.triton_lang_extension.program_id__c0", sym_visibility = "private"}> ({
    %6 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %7 = "arith.index_cast"(%6) : (index) -> i32
    %8 = "arith.extsi"(%7) : (i32) -> i64
    "func.return"(%8) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1xf32>) -> f32, sym_name = "triton.language.standard.max__fp32S1S_c0_cFalse_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg7: tensor<1xf32>):
    %4 = "tt.reduce"(%arg7) <{axis = 0 : i32}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %5 = "func.call"(%arg8, %arg9) <{callee = @triton.language.standard._elementwise_max__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%5) : (f32) -> ()
    }) : (tensor<1xf32>) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._elementwise_max__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg5: f32, %arg6: f32):
    %3 = "arith.maxnumf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1xf32>) -> f32, sym_name = "triton.language.standard.sum__fp32S1S_c0_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<1xf32>):
    %1 = "tt.reduce"(%arg2) <{axis = 0 : i32}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%2) : (f32) -> ()
    }) : (tensor<1xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

