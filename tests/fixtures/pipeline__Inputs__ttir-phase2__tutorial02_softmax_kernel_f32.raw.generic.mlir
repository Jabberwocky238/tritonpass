#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32, i32, i32) -> (), sym_name = "softmax_kernel"}> ({
  ^bb0(%arg10: memref<?xf32>, %arg11: memref<?xf32>, %arg12: i32, %arg13: i32, %arg14: i32, %arg15: i32):
    %6 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %7 = "arith.constant"() <{value = 0 : index}> : () -> index
    %8 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %9 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %10 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
    %11 = "arith.index_cast"(%arg14) : (i32) -> index
    "scf.for"(%9, %11, %10) ({
    ^bb0(%arg16: index):
      %12 = "arith.index_cast"(%arg16) : (index) -> i32
      %13 = "arith.muli"(%12, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %14 = "arith.index_cast"(%13) : (i32) -> index
      %15 = "arith.index_cast"(%arg15) : (i32) -> index
      %16 = "arith.minsi"(%15, %6) : (index, index) -> index
      %17 = "arith.maxsi"(%16, %7) : (index, index) -> index
      %18 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
      "linalg.fill"(%8, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg31: f32, %arg32: f32):
        "linalg.yield"(%arg31) : (f32) -> ()
      }) : (f32, memref<1024xf32>) -> ()
      %19 = "memref.subview"(%arg11, %14, %17) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %20 = "memref.subview"(%18, %17) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%19, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg29: f32, %arg30: f32):
        "linalg.yield"(%arg29) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %21 = "bufferization.to_tensor"(%18) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
      %22 = "func.call"(%21) <{callee = @triton.language.standard.max__fp32S1024S_c0_cFalse_cTrue_cFalse}> : (tensor<1024xf32>) -> f32
      %23 = "tensor.empty"() : () -> tensor<1024xf32>
      %24 = "linalg.fill"(%22, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg27: f32, %arg28: f32):
        "linalg.yield"(%arg27) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %25 = "linalg.generic"(%21, %24, %21) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg24: f32, %arg25: f32, %arg26: f32):
        %36 = "arith.subf"(%arg24, %arg25) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%36) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %26 = "linalg.generic"(%25, %25) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg22: f32, %arg23: f32):
        %35 = "math.exp"(%arg22) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%35) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %27 = "func.call"(%26) <{callee = @triton.language.standard.sum__fp32S1024S_c0_cFalse_cNone}> : (tensor<1024xf32>) -> f32
      %28 = "linalg.fill"(%27, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg20: f32, %arg21: f32):
        "linalg.yield"(%arg20) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %29 = "linalg.generic"(%26, %28, %26) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg17: f32, %arg18: f32, %arg19: f32):
        %34 = "arith.divf"(%arg17, %arg18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%34) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %30 = "arith.muli"(%12, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %31 = "arith.index_cast"(%30) : (i32) -> index
      %32 = "tensor.extract_slice"(%29, %17) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xf32>, index) -> tensor<?xf32>
      %33 = "memref.subview"(%arg10, %31, %17) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%32, %33) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
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

