#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32) -> (), sym_name = "add_func_noalpha_kernel_rank_2"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 16 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %4 = "arith.index_cast"(%3) : (index) -> i32
    %5 = "arith.extsi"(%4) : (i32) -> i64
    %6 = "arith.muli"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %7 = "arith.index_cast"(%6) : (i64) -> index
    %8 = "arith.addi"(%7, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %9 = "arith.index_cast"(%arg3) : (i32) -> index
    %10 = "arith.minsi"(%8, %9) : (index, index) -> index
    %11 = "arith.maxsi"(%10, %7) : (index, index) -> index
    %12 = "arith.subi"(%11, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
    "linalg.fill"(%0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (f32, memref<16xf32>) -> ()
    %14 = "memref.subview"(%arg0, %7, %12) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %15 = "memref.subview"(%13, %12) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<16xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%14, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      "linalg.yield"(%arg13) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %16 = "bufferization.to_tensor"(%13) <{restrict, writable}> : (memref<16xf32>) -> tensor<16xf32>
    %17 = "tensor.expand_shape"(%16) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xf32>) -> tensor<16x1xf32>
    %18 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 0>}> : (memref<?xf32>) -> memref<1099511627776xf32, strided<[0]>>
    %19 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
    "linalg.fill"(%0, %19) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      "linalg.yield"(%arg11) : (f32) -> ()
    }) : (f32, memref<16xf32>) -> ()
    %20 = "memref.subview"(%18, %12) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1099511627776xf32, strided<[0]>>, index) -> memref<?xf32, strided<[0]>>
    %21 = "memref.subview"(%19, %12) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<16xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%20, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (memref<?xf32, strided<[0]>>, memref<?xf32, strided<[1]>>) -> ()
    %22 = "bufferization.to_tensor"(%19) <{restrict, writable}> : (memref<16xf32>) -> tensor<16xf32>
    %23 = "tensor.expand_shape"(%22) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xf32>) -> tensor<16x1xf32>
    %24 = "linalg.generic"(%17, %23, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %28 = "arith.addf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%28) : (f32) -> ()
    }) : (tensor<16x1xf32>, tensor<16x1xf32>, tensor<16x1xf32>) -> tensor<16x1xf32>
    %25 = "tensor.collapse_shape"(%24) <{reassociation = [[0, 1]]}> : (tensor<16x1xf32>) -> tensor<16xf32>
    %26 = "tensor.extract_slice"(%25, %12) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<16xf32>, index) -> tensor<?xf32>
    %27 = "memref.subview"(%arg2, %7, %12) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%26, %27) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

