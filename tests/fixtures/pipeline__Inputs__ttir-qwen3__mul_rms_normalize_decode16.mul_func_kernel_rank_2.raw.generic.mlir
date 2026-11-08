#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32, i32) -> (), sym_name = "mul_func_kernel_rank_2"}> ({
  ^bb0(%arg6: memref<?xf32>, %arg7: memref<?xf32>, %arg8: memref<?xf32>, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32):
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %8 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %9 = "arith.constant"() <{value = 8 : index}> : () -> index
    %10 = "arith.constant"() <{value = 64 : index}> : () -> index
    %11 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %12 = "arith.index_cast"(%11) : (index) -> i32
    %13 = "arith.extsi"(%12) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__i32_c8}> : () -> ()
    %14 = "func.call"(%arg10) <{callee = @triton.language.standard.cdiv__i32_c64}> : (i32) -> i32
    %15 = "arith.extsi"(%14) : (i32) -> i64
    %16 = "arith.remsi"(%13, %15) : (i64, i64) -> i64
    %17 = "arith.divsi"(%13, %15) : (i64, i64) -> i64
    %18 = "arith.muli"(%17, %7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %19 = "arith.index_cast"(%18) : (i64) -> index
    %20 = "arith.muli"(%16, %8) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %21 = "arith.index_cast"(%20) : (i64) -> index
    %22 = "memref.reinterpret_cast"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 4096, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[4096, 1]>>
    %23 = "arith.addi"(%19, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %24 = "arith.index_cast"(%arg9) : (i32) -> index
    %25 = "arith.minsi"(%23, %24) : (index, index) -> index
    %26 = "arith.maxsi"(%25, %19) : (index, index) -> index
    %27 = "arith.subi"(%26, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %28 = "arith.addi"(%21, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %29 = "arith.index_cast"(%arg10) : (i32) -> index
    %30 = "arith.minsi"(%28, %29) : (index, index) -> index
    %31 = "arith.maxsi"(%30, %21) : (index, index) -> index
    %32 = "arith.subi"(%31, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %33 = "arith.minsi"(%27, %9) : (index, index) -> index
    %34 = "arith.minsi"(%32, %10) : (index, index) -> index
    %35 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xf32>
    "linalg.fill"(%6, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32):
      "linalg.yield"(%arg19) : (f32) -> ()
    }) : (f32, memref<8x64xf32>) -> ()
    %36 = "memref.subview"(%22, %19, %21, %33, %34) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[4096, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[4096, 1], offset: ?>>
    %37 = "memref.subview"(%35, %33, %34) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xf32>, index, index) -> memref<?x?xf32, strided<[64, 1]>>
    "linalg.copy"(%36, %37) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: f32, %arg18: f32):
      "linalg.yield"(%arg17) : (f32) -> ()
    }) : (memref<?x?xf32, strided<[4096, 1], offset: ?>>, memref<?x?xf32, strided<[64, 1]>>) -> ()
    %38 = "bufferization.to_tensor"(%35) <{restrict, writable}> : (memref<8x64xf32>) -> tensor<8x64xf32>
    %39 = "memref.reinterpret_cast"(%arg7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, 0>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[1, 0]>>
    %40 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xf32>
    "linalg.fill"(%6, %40) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (f32, memref<8x64xf32>) -> ()
    %41 = "memref.subview"(%39, %19, %33, %34) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[1, 0]>>, index, index, index) -> memref<?x?xf32, strided<[1, 0], offset: ?>>
    %42 = "memref.subview"(%40, %33, %34) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xf32>, index, index) -> memref<?x?xf32, strided<[64, 1]>>
    "linalg.copy"(%41, %42) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      "linalg.yield"(%arg13) : (f32) -> ()
    }) : (memref<?x?xf32, strided<[1, 0], offset: ?>>, memref<?x?xf32, strided<[64, 1]>>) -> ()
    %43 = "bufferization.to_tensor"(%40) <{restrict, writable}> : (memref<8x64xf32>) -> tensor<8x64xf32>
    %44 = "func.call"(%38, %43) <{callee = @_dope.ops.mul.mul_func__fp32S8_64S_fp32S8_64S}> : (tensor<8x64xf32>, tensor<8x64xf32>) -> tensor<8x64xf32>
    %45 = "memref.reinterpret_cast"(%arg8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 4096, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[4096, 1]>>
    %46 = "tensor.extract_slice"(%44, %33, %34) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<8x64xf32>, index, index) -> tensor<?x?xf32>
    %47 = "memref.subview"(%45, %19, %21, %33, %34) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[4096, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[4096, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%46, %47) <{writable}> : (tensor<?x?xf32>, memref<?x?xf32, strided<[4096, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__i32_c8", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c64", sym_visibility = "private"}> ({
  ^bb0(%arg5: i32):
    %2 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 63 : i32}> : () -> i32
    %4 = "arith.addi"(%arg5, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %5 = "arith.divsi"(%4, %2) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8x64xf32>, tensor<8x64xf32>) -> tensor<8x64xf32>, sym_name = "_dope.ops.mul.mul_func__fp32S8_64S_fp32S8_64S", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<8x64xf32>, %arg1: tensor<8x64xf32>):
    %0 = "linalg.generic"(%arg0, %arg1, %arg0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %1 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%1) : (f32) -> ()
    }) : (tensor<8x64xf32>, tensor<8x64xf32>, tensor<8x64xf32>) -> tensor<8x64xf32>
    "func.return"(%0) : (tensor<8x64xf32>) -> ()
  }) : () -> ()
}) : () -> ()

