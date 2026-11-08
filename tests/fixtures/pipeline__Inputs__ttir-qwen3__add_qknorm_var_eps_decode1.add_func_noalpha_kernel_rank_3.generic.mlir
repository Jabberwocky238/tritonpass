#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32) -> (), sym_name = "add_func_noalpha_kernel_rank_3"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 31 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %5 = "arith.constant"() <{value = 32 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "arith.constant"() <{value = 0 : index}> : () -> index
    %8 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %9 = "arith.index_cast"(%8) : (index) -> i32
    %10 = "arith.extsi"(%9) : (i32) -> i64
    %11 = "arith.addi"(%arg3, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %12 = "arith.divsi"(%11, %2) : (i32, i32) -> i32
    %13 = "arith.extsi"(%12) : (i32) -> i64
    %14 = "arith.remsi"(%10, %13) : (i64, i64) -> i64
    %15 = "arith.divsi"(%10, %13) : (i64, i64) -> i64
    %16 = "arith.muli"(%14, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %17 = "arith.index_cast"(%16) : (i64) -> index
    %18 = "arith.cmpi"(%15, %4) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %19 = "arith.muli"(%15, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %20 = "arith.index_cast"(%19) : (i64) -> index
    %21 = "arith.addi"(%17, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %22 = "arith.index_cast"(%arg3) : (i32) -> index
    %23 = "arith.minsi"(%21, %22) : (index, index) -> index
    %24 = "arith.maxsi"(%23, %17) : (index, index) -> index
    %25 = "arith.subi"(%24, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %26 = "arith.select"(%18, %6, %7) : (i1, index, index) -> index
    %27 = "arith.select"(%18, %25, %7) : (i1, index, index) -> index
    %28 = "arith.muli"(%26, %26) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %29 = "arith.muli"(%27, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %30 = "arith.addi"(%17, %20) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %31 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32xf32>
    "linalg.fill"(%0, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (f32, memref<32xf32>) -> ()
    %32 = "memref.subview"(%arg0, %30, %29) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %33 = "memref.subview"(%31, %29) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<32xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%32, %33) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      "linalg.yield"(%arg13) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %34 = "bufferization.to_tensor"(%31) <{restrict, writable}> : (memref<32xf32>) -> tensor<32xf32>
    %35 = "tensor.expand_shape"(%34) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 1, 32, 1>}> : (tensor<32xf32>) -> tensor<1x32x1xf32>
    %36 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 0>}> : (memref<?xf32>) -> memref<1099511627776xf32, strided<[0]>>
    %37 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32xf32>
    "linalg.fill"(%0, %37) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      "linalg.yield"(%arg11) : (f32) -> ()
    }) : (f32, memref<32xf32>) -> ()
    %38 = "memref.subview"(%36, %29) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1099511627776xf32, strided<[0]>>, index) -> memref<?xf32, strided<[0]>>
    %39 = "memref.subview"(%37, %29) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<32xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%38, %39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (memref<?xf32, strided<[0]>>, memref<?xf32, strided<[1]>>) -> ()
    %40 = "bufferization.to_tensor"(%37) <{restrict, writable}> : (memref<32xf32>) -> tensor<32xf32>
    %41 = "tensor.expand_shape"(%40) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 1, 32, 1>}> : (tensor<32xf32>) -> tensor<1x32x1xf32>
    %42 = "linalg.generic"(%35, %41, %35) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %46 = "arith.addf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%46) : (f32) -> ()
    }) : (tensor<1x32x1xf32>, tensor<1x32x1xf32>, tensor<1x32x1xf32>) -> tensor<1x32x1xf32>
    %43 = "tensor.collapse_shape"(%42) <{reassociation = [[0, 1, 2]]}> : (tensor<1x32x1xf32>) -> tensor<32xf32>
    %44 = "tensor.extract_slice"(%43, %29) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<32xf32>, index) -> tensor<?xf32>
    %45 = "memref.subview"(%arg2, %30, %29) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%44, %45) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

