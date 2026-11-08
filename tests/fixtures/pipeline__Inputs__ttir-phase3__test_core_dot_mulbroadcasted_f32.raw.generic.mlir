#map = affine_map<(d0, d1, d2) -> (d0, d1, 0)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map2 = affine_map<(d0, d1, d2) -> (0, d1, d2)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg5: memref<?xf32>, %arg6: memref<?xf32>, %arg7: memref<?xf32>):
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.constant"() <{value = 5 : index}> : () -> index
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    %8 = "arith.constant"() <{value = 20480 : i32}> : () -> i32
    %9 = "arith.constant"() <{value = 6144 : i32}> : () -> i32
    %10 = "arith.constant"() <{value = 24576 : i32}> : () -> i32
    %11 = "tensor.empty"() : () -> tensor<128x32xf32>
    %12 = "linalg.fill"(%3, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: f32, %arg25: f32):
      "linalg.yield"(%arg24) : (f32) -> ()
    }) : (f32, tensor<128x32xf32>) -> tensor<128x32xf32>
    %13 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %14 = "arith.index_cast"(%13) : (index) -> i32
    %15 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %16 = "arith.index_cast"(%15) : (index) -> i32
    %17 = "scf.for"(%5, %6, %7, %12) ({
    ^bb0(%arg8: index, %arg9: tensor<128x32xf32>):
      %24 = "arith.index_cast"(%arg8) : (index) -> i32
      %25 = "arith.muli"(%16, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %26 = "arith.index_cast"(%25) : (i32) -> index
      %27 = "arith.muli"(%24, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %28 = "arith.index_cast"(%27) : (i32) -> index
      %29 = "memref.reinterpret_cast"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 160, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[160, 1]>>
      %30 = "arith.addi"(%26, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %31 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x32xf32>
      %32 = "memref.subview"(%29, %30) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 128, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[160, 1]>>, index) -> memref<128x32xf32, strided<[160, 1], offset: ?>>
      "linalg.copy"(%32, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg22: f32, %arg23: f32):
        "linalg.yield"(%arg22) : (f32) -> ()
      }) : (memref<128x32xf32, strided<[160, 1], offset: ?>>, memref<128x32xf32>) -> ()
      %33 = "bufferization.to_tensor"(%31) <{restrict, writable}> : (memref<128x32xf32>) -> tensor<128x32xf32>
      %34 = "arith.muli"(%14, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %35 = "arith.index_cast"(%34) : (i32) -> index
      %36 = "arith.muli"(%24, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %37 = "arith.index_cast"(%36) : (i32) -> index
      %38 = "memref.reinterpret_cast"(%arg7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 192, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[192, 1]>>
      %39 = "arith.addi"(%35, %37) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      %41 = "memref.subview"(%38, %39) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[192, 1]>>, index) -> memref<32x32xf32, strided<[192, 1], offset: ?>>
      "linalg.copy"(%41, %40) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg20: f32, %arg21: f32):
        "linalg.yield"(%arg20) : (f32) -> ()
      }) : (memref<32x32xf32, strided<[192, 1], offset: ?>>, memref<32x32xf32>) -> ()
      %42 = "bufferization.to_tensor"(%40) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %43 = "tensor.expand_shape"(%33) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 128, 32, 1>}> : (tensor<128x32xf32>) -> tensor<128x32x1xf32>
      %44 = "tensor.expand_shape"(%42) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 32, 32>}> : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
      %45 = "tensor.empty"() : () -> tensor<128x32x32xf32>
      %46 = "linalg.generic"(%43, %45) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg18: f32, %arg19: f32):
        "linalg.yield"(%arg18) : (f32) -> ()
      }) {broadcastDims = array<i64: 2>} : (tensor<128x32x1xf32>, tensor<128x32x32xf32>) -> tensor<128x32x32xf32>
      %47 = "linalg.generic"(%44, %45) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg16: f32, %arg17: f32):
        "linalg.yield"(%arg16) : (f32) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1x32x32xf32>, tensor<128x32x32xf32>) -> tensor<128x32x32xf32>
      %48 = "linalg.generic"(%46, %47, %46) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg13: f32, %arg14: f32, %arg15: f32):
        %52 = "arith.mulf"(%arg13, %arg14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%52) : (f32) -> ()
      }) : (tensor<128x32x32xf32>, tensor<128x32x32xf32>, tensor<128x32x32xf32>) -> tensor<128x32x32xf32>
      %49 = "func.call"(%48) <{callee = @triton.language.standard.sum__fp32S128_32_32S_c1_cFalse_cNone}> : (tensor<128x32x32xf32>) -> tensor<128x32xf32>
      %50 = "linalg.generic"(%49, %arg9, %49) <{indexing_maps = [#map3, #map3, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg10: f32, %arg11: f32, %arg12: f32):
        %51 = "arith.addf"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%51) : (f32) -> ()
      }) : (tensor<128x32xf32>, tensor<128x32xf32>, tensor<128x32xf32>) -> tensor<128x32xf32>
      "scf.yield"(%50) : (tensor<128x32xf32>) -> ()
    }) : (index, index, index, tensor<128x32xf32>) -> tensor<128x32xf32>
    %18 = "arith.muli"(%16, %10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %19 = "arith.muli"(%14, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %20 = "arith.addi"(%18, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %21 = "arith.index_cast"(%20) : (i32) -> index
    %22 = "memref.reinterpret_cast"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 192, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[192, 1]>>
    %23 = "memref.subview"(%22, %21) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 128, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[192, 1]>>, index) -> memref<128x32xf32, strided<[192, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%17, %23) <{writable}> : (tensor<128x32xf32>, memref<128x32xf32, strided<[192, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<128x32x32xf32>) -> tensor<128x32xf32>, sym_name = "triton.language.standard.sum__fp32S128_32_32S_c1_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<128x32x32xf32>):
    %1 = "tt.reduce"(%arg2) <{axis = 1 : i32}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%2) : (f32) -> ()
    }) : (tensor<128x32x32xf32>) -> tensor<128x32xf32>
    "func.return"(%1) : (tensor<128x32xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

