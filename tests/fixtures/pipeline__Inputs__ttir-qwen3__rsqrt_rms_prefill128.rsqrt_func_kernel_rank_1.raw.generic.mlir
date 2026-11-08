#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32, i32) -> (), sym_name = "rsqrt_func_kernel_rank_1"}> ({
  ^bb0(%arg8: memref<?xf32>, %arg9: memref<?xf32>, %arg10: i32, %arg11: i32, %arg12: i32):
    %7 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = 128 : i64}> : () -> i64
    %9 = "arith.constant"() <{value = 128 : index}> : () -> index
    %10 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %11 = "arith.index_cast"(%10) : (index) -> i32
    %12 = "arith.extsi"(%11) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__i32_c128}> : () -> ()
    %13 = "arith.muli"(%12, %8) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %14 = "arith.index_cast"(%13) : (i64) -> index
    %15 = "arith.addi"(%14, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %16 = "arith.index_cast"(%arg10) : (i32) -> index
    %17 = "arith.minsi"(%15, %16) : (index, index) -> index
    %18 = "arith.maxsi"(%17, %14) : (index, index) -> index
    %19 = "arith.subi"(%18, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %20 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32>
    "linalg.fill"(%7, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (f32, memref<128xf32>) -> ()
    %21 = "memref.subview"(%arg8, %14, %19) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %22 = "memref.subview"(%20, %19) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<128xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%21, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      "linalg.yield"(%arg13) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %23 = "bufferization.to_tensor"(%20) <{restrict, writable}> : (memref<128xf32>) -> tensor<128xf32>
    %24 = "func.call"(%23) <{callee = @flag_gems.ops.rsqrt.rsqrt_func__fp32S128S}> : (tensor<128xf32>) -> tensor<128xf32>
    %25 = "tensor.extract_slice"(%24, %19) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<128xf32>, index) -> tensor<?xf32>
    %26 = "memref.subview"(%arg9, %14, %19) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%25, %26) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__i32_c128", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<128xf32>) -> tensor<128xf32>, sym_name = "flag_gems.ops.rsqrt.rsqrt_func__fp32S128S", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<128xf32>):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<128xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %3 = "linalg.generic"(%arg0, %arg0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      %6 = "math.sqrt"(%arg4) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %4 = "linalg.generic"(%2, %3, %2) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %5 = "arith.divf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%5) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    "func.return"(%4) : (tensor<128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

