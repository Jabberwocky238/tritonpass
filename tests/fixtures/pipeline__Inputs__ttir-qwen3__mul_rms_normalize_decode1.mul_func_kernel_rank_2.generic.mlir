#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32) -> (), sym_name = "mul_func_kernel_rank_2"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %3 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 63 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 8 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "arith.constant"() <{value = 64 : index}> : () -> index
    %8 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %9 = "arith.index_cast"(%8) : (index) -> i32
    %10 = "arith.extsi"(%9) : (i32) -> i64
    %11 = "arith.addi"(%arg3, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %12 = "arith.divsi"(%11, %3) : (i32, i32) -> i32
    %13 = "arith.extsi"(%12) : (i32) -> i64
    %14 = "arith.remsi"(%10, %13) : (i64, i64) -> i64
    %15 = "arith.divsi"(%10, %13) : (i64, i64) -> i64
    %16 = "arith.muli"(%15, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %17 = "arith.index_cast"(%16) : (i64) -> index
    %18 = "arith.muli"(%14, %2) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %19 = "arith.index_cast"(%18) : (i64) -> index
    %20 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 4096, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[4096, 1]>>
    %21 = "arith.addi"(%17, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %22 = "arith.minsi"(%21, %6) : (index, index) -> index
    %23 = "arith.maxsi"(%22, %17) : (index, index) -> index
    %24 = "arith.subi"(%23, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %25 = "arith.addi"(%19, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %26 = "arith.index_cast"(%arg3) : (i32) -> index
    %27 = "arith.minsi"(%25, %26) : (index, index) -> index
    %28 = "arith.maxsi"(%27, %19) : (index, index) -> index
    %29 = "arith.subi"(%28, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %30 = "arith.minsi"(%24, %5) : (index, index) -> index
    %31 = "arith.minsi"(%29, %7) : (index, index) -> index
    %32 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xf32>
    "linalg.fill"(%0, %32) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (f32, memref<8x64xf32>) -> ()
    %33 = "memref.subview"(%20, %17, %19, %30, %31) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[4096, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[4096, 1], offset: ?>>
    %34 = "memref.subview"(%32, %30, %31) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xf32>, index, index) -> memref<?x?xf32, strided<[64, 1]>>
    "linalg.copy"(%33, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      "linalg.yield"(%arg13) : (f32) -> ()
    }) : (memref<?x?xf32, strided<[4096, 1], offset: ?>>, memref<?x?xf32, strided<[64, 1]>>) -> ()
    %35 = "bufferization.to_tensor"(%32) <{restrict, writable}> : (memref<8x64xf32>) -> tensor<8x64xf32>
    %36 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, 0>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[1, 0]>>
    %37 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xf32>
    "linalg.fill"(%0, %37) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      "linalg.yield"(%arg11) : (f32) -> ()
    }) : (f32, memref<8x64xf32>) -> ()
    %38 = "memref.subview"(%36, %17, %30, %31) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[1, 0]>>, index, index, index) -> memref<?x?xf32, strided<[1, 0], offset: ?>>
    %39 = "memref.subview"(%37, %30, %31) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xf32>, index, index) -> memref<?x?xf32, strided<[64, 1]>>
    "linalg.copy"(%38, %39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (memref<?x?xf32, strided<[1, 0], offset: ?>>, memref<?x?xf32, strided<[64, 1]>>) -> ()
    %40 = "bufferization.to_tensor"(%37) <{restrict, writable}> : (memref<8x64xf32>) -> tensor<8x64xf32>
    %41 = "linalg.generic"(%35, %40, %35) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %45 = "arith.mulf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%45) : (f32) -> ()
    }) : (tensor<8x64xf32>, tensor<8x64xf32>, tensor<8x64xf32>) -> tensor<8x64xf32>
    %42 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 4096, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[4096, 1]>>
    %43 = "tensor.extract_slice"(%41, %30, %31) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<8x64xf32>, index, index) -> tensor<?x?xf32>
    %44 = "memref.subview"(%42, %17, %19, %30, %31) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[4096, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[4096, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%43, %44) <{writable}> : (tensor<?x?xf32>, memref<?x?xf32, strided<[4096, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

