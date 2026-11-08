#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32, i32) -> (), sym_name = "add_func_noalpha_kernel_rank_3"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 16 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %3 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 31 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 32 : index}> : () -> index
    %6 = "arith.constant"() <{value = 16 : index}> : () -> index
    %7 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %8 = "arith.index_cast"(%7) : (index) -> i32
    %9 = "arith.extsi"(%8) : (i32) -> i64
    %10 = "arith.addi"(%arg4, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %11 = "arith.divsi"(%10, %3) : (i32, i32) -> i32
    %12 = "arith.extsi"(%11) : (i32) -> i64
    %13 = "arith.remsi"(%9, %12) : (i64, i64) -> i64
    %14 = "arith.divsi"(%9, %12) : (i64, i64) -> i64
    %15 = "arith.muli"(%14, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %16 = "arith.index_cast"(%15) : (i64) -> index
    %17 = "arith.muli"(%13, %2) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %18 = "arith.index_cast"(%17) : (i64) -> index
    %19 = "arith.addi"(%16, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %20 = "arith.index_cast"(%arg3) : (i32) -> index
    %21 = "arith.minsi"(%19, %20) : (index, index) -> index
    %22 = "arith.maxsi"(%21, %16) : (index, index) -> index
    %23 = "arith.subi"(%22, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %24 = "arith.addi"(%18, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %25 = "arith.index_cast"(%arg4) : (i32) -> index
    %26 = "arith.minsi"(%24, %25) : (index, index) -> index
    %27 = "arith.maxsi"(%26, %18) : (index, index) -> index
    %28 = "arith.subi"(%27, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %29 = "arith.minsi"(%23, %6) : (index, index) -> index
    %30 = "arith.minsi"(%28, %5) : (index, index) -> index
    %31 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 32, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[32, 1]>>
    %32 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x32xf32>
    "linalg.fill"(%0, %32) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: f32, %arg17: f32):
      "linalg.yield"(%arg16) : (f32) -> ()
    }) : (f32, memref<16x32xf32>) -> ()
    %33 = "memref.subview"(%31, %16, %18, %29, %30) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[32, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[32, 1], offset: ?>>
    %34 = "memref.subview"(%32, %29, %30) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<16x32xf32>, index, index) -> memref<?x?xf32, strided<[32, 1]>>
    "linalg.copy"(%33, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      "linalg.yield"(%arg14) : (f32) -> ()
    }) : (memref<?x?xf32, strided<[32, 1], offset: ?>>, memref<?x?xf32, strided<[32, 1]>>) -> ()
    %35 = "bufferization.to_tensor"(%32) <{restrict, writable}> : (memref<16x32xf32>) -> tensor<16x32xf32>
    %36 = "tensor.expand_shape"(%35) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 16, 32, 1>}> : (tensor<16x32xf32>) -> tensor<16x32x1xf32>
    %37 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 0, 0>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[0, 0]>>
    %38 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x32xf32>
    "linalg.fill"(%0, %38) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, memref<16x32xf32>) -> ()
    %39 = "memref.subview"(%37, %29, %30) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[0, 0]>>, index, index) -> memref<?x?xf32, strided<[0, 0]>>
    %40 = "memref.subview"(%38, %29, %30) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<16x32xf32>, index, index) -> memref<?x?xf32, strided<[32, 1]>>
    "linalg.copy"(%39, %40) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (memref<?x?xf32, strided<[0, 0]>>, memref<?x?xf32, strided<[32, 1]>>) -> ()
    %41 = "bufferization.to_tensor"(%38) <{restrict, writable}> : (memref<16x32xf32>) -> tensor<16x32xf32>
    %42 = "tensor.expand_shape"(%41) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 16, 32, 1>}> : (tensor<16x32xf32>) -> tensor<16x32x1xf32>
    %43 = "linalg.generic"(%36, %42, %36) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32, %arg9: f32):
      %48 = "arith.addf"(%arg7, %arg8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%48) : (f32) -> ()
    }) : (tensor<16x32x1xf32>, tensor<16x32x1xf32>, tensor<16x32x1xf32>) -> tensor<16x32x1xf32>
    %44 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 32, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[32, 1]>>
    %45 = "tensor.collapse_shape"(%43) <{reassociation = [[0], [1, 2]]}> : (tensor<16x32x1xf32>) -> tensor<16x32xf32>
    %46 = "tensor.extract_slice"(%45, %29, %30) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<16x32xf32>, index, index) -> tensor<?x?xf32>
    %47 = "memref.subview"(%44, %16, %18, %29, %30) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[32, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[32, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%46, %47) <{writable}> : (tensor<?x?xf32>, memref<?x?xf32, strided<[32, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

