#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32) -> (), sym_name = "add_func_noalpha_kernel_rank_3"}> ({
  ^bb0(%arg6: memref<?xf32>, %arg7: memref<?xf32>, %arg8: memref<?xf32>, %arg9: i32, %arg10: i32, %arg11: i32):
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %8 = "arith.constant"() <{value = 32 : index}> : () -> index
    %9 = "arith.constant"() <{value = 1 : index}> : () -> index
    %10 = "arith.constant"() <{value = 0 : index}> : () -> index
    %11 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %12 = "arith.index_cast"(%11) : (index) -> i32
    %13 = "arith.extsi"(%12) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__c1_c1}> : () -> ()
    %14 = "func.call"(%arg9) <{callee = @triton.language.standard.cdiv__i32_c32}> : (i32) -> i32
    "func.call"() <{callee = @triton.language.standard.cdiv__c1_c1}> : () -> ()
    %15 = "arith.extsi"(%14) : (i32) -> i64
    %16 = "arith.remsi"(%13, %15) : (i64, i64) -> i64
    %17 = "arith.divsi"(%13, %15) : (i64, i64) -> i64
    %18 = "arith.index_cast"(%17) : (i64) -> index
    %19 = "arith.muli"(%16, %7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %20 = "arith.index_cast"(%19) : (i64) -> index
    %21 = "arith.muli"(%18, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %22 = "arith.cmpi"(%18, %9) <{predicate = 2 : i64}> : (index, index) -> i1
    %23 = "arith.select"(%22, %9, %10) : (i1, index, index) -> index
    %24 = "arith.addi"(%20, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %25 = "arith.index_cast"(%arg9) : (i32) -> index
    %26 = "arith.minsi"(%24, %25) : (index, index) -> index
    %27 = "arith.maxsi"(%26, %20) : (index, index) -> index
    %28 = "arith.subi"(%27, %20) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %29 = "arith.minsi"(%23, %9) : (index, index) -> index
    %30 = "arith.minsi"(%28, %8) : (index, index) -> index
    %31 = "arith.muli"(%30, %29) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %32 = "arith.addi"(%20, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %33 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32xf32>
    "linalg.fill"(%6, %33) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: f32, %arg19: f32):
      "linalg.yield"(%arg18) : (f32) -> ()
    }) : (f32, memref<32xf32>) -> ()
    %34 = "memref.subview"(%arg6, %32, %31) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %35 = "memref.subview"(%33, %31) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<32xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%34, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: f32, %arg17: f32):
      "linalg.yield"(%arg16) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %36 = "bufferization.to_tensor"(%33) <{restrict, writable}> : (memref<32xf32>) -> tensor<32xf32>
    %37 = "tensor.expand_shape"(%36) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 1, 32, 1>}> : (tensor<32xf32>) -> tensor<1x32x1xf32>
    %38 = "memref.reinterpret_cast"(%arg7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 0>}> : (memref<?xf32>) -> memref<1099511627776xf32, strided<[0]>>
    %39 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32xf32>
    "linalg.fill"(%6, %39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      "linalg.yield"(%arg14) : (f32) -> ()
    }) : (f32, memref<32xf32>) -> ()
    %40 = "memref.subview"(%38, %31) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1099511627776xf32, strided<[0]>>, index) -> memref<?xf32, strided<[0]>>
    %41 = "memref.subview"(%39, %31) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<32xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%40, %41) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (memref<?xf32, strided<[0]>>, memref<?xf32, strided<[1]>>) -> ()
    %42 = "bufferization.to_tensor"(%39) <{restrict, writable}> : (memref<32xf32>) -> tensor<32xf32>
    %43 = "tensor.expand_shape"(%42) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 1, 32, 1>}> : (tensor<32xf32>) -> tensor<1x32x1xf32>
    %44 = "func.call"(%37, %43) <{callee = @_dope.ops.add.add_func_noalpha__fp32S1_32_1S_fp32S1_32_1S}> : (tensor<1x32x1xf32>, tensor<1x32x1xf32>) -> tensor<1x32x1xf32>
    %45 = "tensor.collapse_shape"(%44) <{reassociation = [[0, 1, 2]]}> : (tensor<1x32x1xf32>) -> tensor<32xf32>
    %46 = "tensor.extract_slice"(%45, %31) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<32xf32>, index) -> tensor<?xf32>
    %47 = "memref.subview"(%arg8, %32, %31) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%46, %47) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__c1_c1", sym_visibility = "private"}> ({
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
  "func.func"() <{function_type = (tensor<1x32x1xf32>, tensor<1x32x1xf32>) -> tensor<1x32x1xf32>, sym_name = "_dope.ops.add.add_func_noalpha__fp32S1_32_1S_fp32S1_32_1S", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<1x32x1xf32>, %arg1: tensor<1x32x1xf32>):
    %0 = "linalg.generic"(%arg0, %arg1, %arg0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %1 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%1) : (f32) -> ()
    }) : (tensor<1x32x1xf32>, tensor<1x32x1xf32>, tensor<1x32x1xf32>) -> tensor<1x32x1xf32>
    "func.return"(%0) : (tensor<1x32x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

