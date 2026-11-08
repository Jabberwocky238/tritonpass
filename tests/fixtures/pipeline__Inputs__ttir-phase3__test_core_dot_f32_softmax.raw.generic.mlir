#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, 0)>
#map4 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, i32, memref<?xf32>, i32, memref<?xf32>, i32, memref<?xf32>, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg10: memref<?xf32>, %arg11: i32, %arg12: memref<?xf32>, %arg13: i32, %arg14: memref<?xf32>, %arg15: i32, %arg16: memref<?xf32>, %arg17: i32):
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "arith.index_cast"(%arg11) : (i32) -> index
    %8 = "memref.reinterpret_cast"(%arg10, %7) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %9 = "arith.index_cast"(%arg13) : (i32) -> index
    %10 = "memref.reinterpret_cast"(%arg12, %9) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %11 = "arith.index_cast"(%arg17) : (i32) -> index
    %12 = "memref.reinterpret_cast"(%arg16, %11) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32>
    %14 = "memref.subview"(%8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>) -> memref<64x64xf32, strided<[?, 1]>>
    "linalg.copy"(%14, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg37: f32, %arg38: f32):
      "linalg.yield"(%arg37) : (f32) -> ()
    }) : (memref<64x64xf32, strided<[?, 1]>>, memref<64x64xf32>) -> ()
    %15 = "bufferization.to_tensor"(%13) <{restrict, writable}> : (memref<64x64xf32>) -> tensor<64x64xf32>
    %16 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32>
    %17 = "memref.subview"(%10) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>) -> memref<64x64xf32, strided<[?, 1]>>
    "linalg.copy"(%17, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg35: f32, %arg36: f32):
      "linalg.yield"(%arg35) : (f32) -> ()
    }) : (memref<64x64xf32, strided<[?, 1]>>, memref<64x64xf32>) -> ()
    %18 = "bufferization.to_tensor"(%16) <{restrict, writable}> : (memref<64x64xf32>) -> tensor<64x64xf32>
    %19 = "tensor.empty"() : () -> tensor<64x64xf32>
    %20 = "linalg.fill"(%6, %19) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg33: f32, %arg34: f32):
      "linalg.yield"(%arg33) : (f32) -> ()
    }) : (f32, tensor<64x64xf32>) -> tensor<64x64xf32>
    %21 = "linalg.matmul"(%15, %18, %20) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg30: f32, %arg31: f32, %arg32: f32):
      %35 = "arith.mulf"(%arg30, %arg31) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %36 = "arith.addf"(%arg32, %35) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%36) : (f32) -> ()
    }) : (tensor<64x64xf32>, tensor<64x64xf32>, tensor<64x64xf32>) -> tensor<64x64xf32>
    %22 = "func.call"(%21) <{callee = @triton.language.standard.max__fp32S64_64S_c1_cFalse_cTrue_cFalse}> : (tensor<64x64xf32>) -> tensor<64xf32>
    %23 = "tensor.expand_shape"(%22) <{reassociation = [[0, 1]], static_output_shape = array<i64: 64, 1>}> : (tensor<64xf32>) -> tensor<64x1xf32>
    %24 = "linalg.generic"(%23, %19) <{indexing_maps = [#map3, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg28: f32, %arg29: f32):
      "linalg.yield"(%arg28) : (f32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<64x1xf32>, tensor<64x64xf32>) -> tensor<64x64xf32>
    %25 = "linalg.generic"(%21, %24, %21) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg25: f32, %arg26: f32, %arg27: f32):
      %34 = "arith.subf"(%arg25, %arg26) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%34) : (f32) -> ()
    }) : (tensor<64x64xf32>, tensor<64x64xf32>, tensor<64x64xf32>) -> tensor<64x64xf32>
    %26 = "linalg.generic"(%25, %25) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: f32, %arg24: f32):
      %33 = "math.exp"(%arg23) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%33) : (f32) -> ()
    }) : (tensor<64x64xf32>, tensor<64x64xf32>) -> tensor<64x64xf32>
    %27 = "func.call"(%26) <{callee = @triton.language.standard.sum__fp32S64_64S_c1_cFalse_cNone}> : (tensor<64x64xf32>) -> tensor<64xf32>
    %28 = "tensor.expand_shape"(%27) <{reassociation = [[0, 1]], static_output_shape = array<i64: 64, 1>}> : (tensor<64xf32>) -> tensor<64x1xf32>
    %29 = "linalg.generic"(%28, %19) <{indexing_maps = [#map3, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: f32, %arg22: f32):
      "linalg.yield"(%arg21) : (f32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<64x1xf32>, tensor<64x64xf32>) -> tensor<64x64xf32>
    %30 = "linalg.generic"(%26, %29, %26) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg18: f32, %arg19: f32, %arg20: f32):
      %32 = "arith.divf"(%arg18, %arg19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%32) : (f32) -> ()
    }) : (tensor<64x64xf32>, tensor<64x64xf32>, tensor<64x64xf32>) -> tensor<64x64xf32>
    %31 = "memref.subview"(%12) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>) -> memref<64x64xf32, strided<[?, 1]>>
    "bufferization.materialize_in_destination"(%30, %31) <{writable}> : (tensor<64x64xf32>, memref<64x64xf32, strided<[?, 1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<64x64xf32>) -> tensor<64xf32>, sym_name = "triton.language.standard.max__fp32S64_64S_c1_cFalse_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg7: tensor<64x64xf32>):
    %4 = "tt.reduce"(%arg7) <{axis = 1 : i32}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %5 = "func.call"(%arg8, %arg9) <{callee = @triton.language.standard._elementwise_max__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%5) : (f32) -> ()
    }) : (tensor<64x64xf32>) -> tensor<64xf32>
    "func.return"(%4) : (tensor<64xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._elementwise_max__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg5: f32, %arg6: f32):
    %3 = "arith.maxnumf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<64x64xf32>) -> tensor<64xf32>, sym_name = "triton.language.standard.sum__fp32S64_64S_c1_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<64x64xf32>):
    %1 = "tt.reduce"(%arg2) <{axis = 1 : i32}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%2) : (f32) -> ()
    }) : (tensor<64x64xf32>) -> tensor<64xf32>
    "func.return"(%1) : (tensor<64xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

