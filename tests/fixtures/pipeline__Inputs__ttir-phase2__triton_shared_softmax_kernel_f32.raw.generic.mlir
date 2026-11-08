#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32, i32) -> (), sym_name = "softmax_kernel"}> ({
  ^bb0(%arg10: memref<?xf32>, %arg11: memref<?xf32>, %arg12: i32, %arg13: i32, %arg14: i32):
    %6 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %7 = "arith.constant"() <{value = 0 : index}> : () -> index
    %8 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %9 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %10 = "arith.index_cast"(%9) : (index) -> i32
    %11 = "arith.muli"(%10, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %12 = "arith.index_cast"(%11) : (i32) -> index
    %13 = "arith.index_cast"(%arg14) : (i32) -> index
    %14 = "arith.minsi"(%13, %6) : (index, index) -> index
    %15 = "arith.maxsi"(%14, %7) : (index, index) -> index
    %16 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
    "linalg.fill"(%8, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: f32, %arg30: f32):
      "linalg.yield"(%arg29) : (f32) -> ()
    }) : (f32, memref<1024xf32>) -> ()
    %17 = "memref.subview"(%arg11, %12, %15) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %18 = "memref.subview"(%16, %15) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%17, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg27: f32, %arg28: f32):
      "linalg.yield"(%arg27) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %19 = "bufferization.to_tensor"(%16) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
    %20 = "func.call"(%19) <{callee = @triton.language.standard.max__fp32S1024S_c0_cFalse_cTrue_cFalse}> : (tensor<1024xf32>) -> f32
    %21 = "tensor.empty"() : () -> tensor<1024xf32>
    %22 = "linalg.fill"(%20, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: f32, %arg26: f32):
      "linalg.yield"(%arg25) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %23 = "linalg.generic"(%19, %22, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg22: f32, %arg23: f32, %arg24: f32):
      %34 = "arith.subf"(%arg22, %arg23) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%34) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %24 = "linalg.generic"(%23, %23) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: f32, %arg21: f32):
      %33 = "math.exp"(%arg20) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%33) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %25 = "func.call"(%24) <{callee = @triton.language.standard.sum__fp32S1024S_c0_cFalse_cNone}> : (tensor<1024xf32>) -> f32
    %26 = "linalg.fill"(%25, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: f32, %arg19: f32):
      "linalg.yield"(%arg18) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %27 = "linalg.generic"(%24, %26, %24) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32, %arg17: f32):
      %32 = "arith.divf"(%arg15, %arg16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%32) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %28 = "arith.muli"(%10, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %29 = "arith.index_cast"(%28) : (i32) -> index
    %30 = "tensor.extract_slice"(%27, %15) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xf32>, index) -> tensor<?xf32>
    %31 = "memref.subview"(%arg10, %29, %15) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%30, %31) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1024xf32>) -> f32, sym_name = "triton.language.standard.max__fp32S1024S_c0_cFalse_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg7: tensor<1024xf32>):
    %4 = "tt.reduce"(%arg7) <{axis = 0 : i32}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %5 = "func.call"(%arg8, %arg9) <{callee = @triton.language.standard._elementwise_max__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%5) : (f32) -> ()
    }) : (tensor<1024xf32>) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._elementwise_max__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg5: f32, %arg6: f32):
    %3 = "arith.maxnumf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1024xf32>) -> f32, sym_name = "triton.language.standard.sum__fp32S1024S_c0_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<1024xf32>):
    %1 = "tt.reduce"(%arg2) <{axis = 0 : i32}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%2) : (f32) -> ()
    }) : (tensor<1024xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

