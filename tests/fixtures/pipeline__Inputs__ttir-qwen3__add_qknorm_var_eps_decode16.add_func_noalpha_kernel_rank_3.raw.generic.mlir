#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32, i32) -> (), sym_name = "add_func_noalpha_kernel_rank_3"}> ({
  ^bb0(%arg6: memref<?xf32>, %arg7: memref<?xf32>, %arg8: memref<?xf32>, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32):
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 16 : i64}> : () -> i64
    %8 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %9 = "arith.constant"() <{value = 32 : index}> : () -> index
    %10 = "arith.constant"() <{value = 16 : index}> : () -> index
    %11 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %12 = "arith.index_cast"(%11) : (index) -> i32
    %13 = "arith.extsi"(%12) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__i32_c16}> : () -> ()
    %14 = "func.call"(%arg10) <{callee = @triton.language.standard.cdiv__i32_c32}> : (i32) -> i32
    "func.call"() <{callee = @triton.language.standard.cdiv__c1_c1}> : () -> ()
    %15 = "arith.extsi"(%14) : (i32) -> i64
    %16 = "arith.remsi"(%13, %15) : (i64, i64) -> i64
    %17 = "arith.divsi"(%13, %15) : (i64, i64) -> i64
    %18 = "arith.muli"(%17, %7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %19 = "arith.index_cast"(%18) : (i64) -> index
    %20 = "arith.muli"(%16, %8) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %21 = "arith.index_cast"(%20) : (i64) -> index
    %22 = "arith.addi"(%19, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %23 = "arith.index_cast"(%arg9) : (i32) -> index
    %24 = "arith.minsi"(%22, %23) : (index, index) -> index
    %25 = "arith.maxsi"(%24, %19) : (index, index) -> index
    %26 = "arith.subi"(%25, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %27 = "arith.addi"(%21, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %28 = "arith.index_cast"(%arg10) : (i32) -> index
    %29 = "arith.minsi"(%27, %28) : (index, index) -> index
    %30 = "arith.maxsi"(%29, %21) : (index, index) -> index
    %31 = "arith.subi"(%30, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %32 = "arith.minsi"(%26, %10) : (index, index) -> index
    %33 = "arith.minsi"(%31, %9) : (index, index) -> index
    %34 = "memref.reinterpret_cast"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 32, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[32, 1]>>
    %35 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x32xf32>
    "linalg.fill"(%6, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32):
      "linalg.yield"(%arg19) : (f32) -> ()
    }) : (f32, memref<16x32xf32>) -> ()
    %36 = "memref.subview"(%34, %19, %21, %32, %33) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[32, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[32, 1], offset: ?>>
    %37 = "memref.subview"(%35, %32, %33) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<16x32xf32>, index, index) -> memref<?x?xf32, strided<[32, 1]>>
    "linalg.copy"(%36, %37) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: f32, %arg18: f32):
      "linalg.yield"(%arg17) : (f32) -> ()
    }) : (memref<?x?xf32, strided<[32, 1], offset: ?>>, memref<?x?xf32, strided<[32, 1]>>) -> ()
    %38 = "bufferization.to_tensor"(%35) <{restrict, writable}> : (memref<16x32xf32>) -> tensor<16x32xf32>
    %39 = "tensor.expand_shape"(%38) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 16, 32, 1>}> : (tensor<16x32xf32>) -> tensor<16x32x1xf32>
    %40 = "memref.reinterpret_cast"(%arg7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 0, 0>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[0, 0]>>
    %41 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x32xf32>
    "linalg.fill"(%6, %41) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (f32, memref<16x32xf32>) -> ()
    %42 = "memref.subview"(%40, %32, %33) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[0, 0]>>, index, index) -> memref<?x?xf32, strided<[0, 0]>>
    %43 = "memref.subview"(%41, %32, %33) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<16x32xf32>, index, index) -> memref<?x?xf32, strided<[32, 1]>>
    "linalg.copy"(%42, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      "linalg.yield"(%arg13) : (f32) -> ()
    }) : (memref<?x?xf32, strided<[0, 0]>>, memref<?x?xf32, strided<[32, 1]>>) -> ()
    %44 = "bufferization.to_tensor"(%41) <{restrict, writable}> : (memref<16x32xf32>) -> tensor<16x32xf32>
    %45 = "tensor.expand_shape"(%44) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 16, 32, 1>}> : (tensor<16x32xf32>) -> tensor<16x32x1xf32>
    %46 = "func.call"(%39, %45) <{callee = @_dope.ops.add.add_func_noalpha__fp32S16_32_1S_fp32S16_32_1S}> : (tensor<16x32x1xf32>, tensor<16x32x1xf32>) -> tensor<16x32x1xf32>
    %47 = "memref.reinterpret_cast"(%arg8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 32, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[32, 1]>>
    %48 = "tensor.collapse_shape"(%46) <{reassociation = [[0], [1, 2]]}> : (tensor<16x32x1xf32>) -> tensor<16x32xf32>
    %49 = "tensor.extract_slice"(%48, %32, %33) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<16x32xf32>, index, index) -> tensor<?x?xf32>
    %50 = "memref.subview"(%47, %19, %21, %32, %33) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[32, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[32, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%49, %50) <{writable}> : (tensor<?x?xf32>, memref<?x?xf32, strided<[32, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__i32_c16", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c32", sym_visibility = "private"}> ({
  ^bb0(%arg5: i32):
    %2 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 31 : i32}> : () -> i32
    %4 = "arith.addi"(%arg5, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %5 = "arith.divsi"(%4, %2) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__c1_c1", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<16x32x1xf32>, tensor<16x32x1xf32>) -> tensor<16x32x1xf32>, sym_name = "_dope.ops.add.add_func_noalpha__fp32S16_32_1S_fp32S16_32_1S", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<16x32x1xf32>, %arg1: tensor<16x32x1xf32>):
    %0 = "linalg.generic"(%arg0, %arg1, %arg0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %1 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%1) : (f32) -> ()
    }) : (tensor<16x32x1xf32>, tensor<16x32x1xf32>, tensor<16x32x1xf32>) -> tensor<16x32x1xf32>
    "func.return"(%0) : (tensor<16x32x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

