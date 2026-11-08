#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32) -> (), sym_name = "add_func_noalpha_kernel_rank_2"}> ({
  ^bb0(%arg5: memref<?xf32>, %arg6: memref<?xf32>, %arg7: memref<?xf32>, %arg8: i32):
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %4 = "arith.constant"() <{value = 8 : index}> : () -> index
    %5 = "arith.constant"() <{value = 1 : index}> : () -> index
    %6 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %7 = "arith.index_cast"(%6) : (index) -> i32
    %8 = "arith.extsi"(%7) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__c1_c8}> : () -> ()
    "func.call"() <{callee = @triton.language.standard.cdiv__c1_c1}> : () -> ()
    %9 = "arith.muli"(%8, %3) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %10 = "arith.index_cast"(%9) : (i64) -> index
    %11 = "arith.addi"(%10, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %12 = "arith.minsi"(%11, %5) : (index, index) -> index
    %13 = "arith.maxsi"(%12, %10) : (index, index) -> index
    %14 = "arith.subi"(%13, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %15 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8xf32>
    "linalg.fill"(%2, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (f32, memref<8xf32>) -> ()
    %16 = "memref.subview"(%arg5, %10, %14) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %17 = "memref.subview"(%15, %14) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<8xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%16, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      "linalg.yield"(%arg13) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %18 = "bufferization.to_tensor"(%15) <{restrict, writable}> : (memref<8xf32>) -> tensor<8xf32>
    %19 = "tensor.expand_shape"(%18) <{reassociation = [[0, 1]], static_output_shape = array<i64: 8, 1>}> : (tensor<8xf32>) -> tensor<8x1xf32>
    %20 = "memref.reinterpret_cast"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 0>}> : (memref<?xf32>) -> memref<1099511627776xf32, strided<[0]>>
    %21 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8xf32>
    "linalg.fill"(%2, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      "linalg.yield"(%arg11) : (f32) -> ()
    }) : (f32, memref<8xf32>) -> ()
    %22 = "memref.subview"(%20, %14) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1099511627776xf32, strided<[0]>>, index) -> memref<?xf32, strided<[0]>>
    %23 = "memref.subview"(%21, %14) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<8xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%22, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (memref<?xf32, strided<[0]>>, memref<?xf32, strided<[1]>>) -> ()
    %24 = "bufferization.to_tensor"(%21) <{restrict, writable}> : (memref<8xf32>) -> tensor<8xf32>
    %25 = "tensor.expand_shape"(%24) <{reassociation = [[0, 1]], static_output_shape = array<i64: 8, 1>}> : (tensor<8xf32>) -> tensor<8x1xf32>
    %26 = "func.call"(%19, %25) <{callee = @_dope.ops.add.add_func_noalpha__fp32S8_1S_fp32S8_1S}> : (tensor<8x1xf32>, tensor<8x1xf32>) -> tensor<8x1xf32>
    %27 = "tensor.collapse_shape"(%26) <{reassociation = [[0, 1]]}> : (tensor<8x1xf32>) -> tensor<8xf32>
    %28 = "tensor.extract_slice"(%27, %14) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<8xf32>, index) -> tensor<?xf32>
    %29 = "memref.subview"(%arg7, %10, %14) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%28, %29) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__c1_c8", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__c1_c1", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8x1xf32>, tensor<8x1xf32>) -> tensor<8x1xf32>, sym_name = "_dope.ops.add.add_func_noalpha__fp32S8_1S_fp32S8_1S", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<8x1xf32>, %arg1: tensor<8x1xf32>):
    %0 = "linalg.generic"(%arg0, %arg1, %arg0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %1 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%1) : (f32) -> ()
    }) : (tensor<8x1xf32>, tensor<8x1xf32>, tensor<8x1xf32>) -> tensor<8x1xf32>
    "func.return"(%0) : (tensor<8x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

