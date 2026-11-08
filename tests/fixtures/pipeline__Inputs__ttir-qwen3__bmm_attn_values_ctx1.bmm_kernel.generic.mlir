#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "bmm_kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 32 : index}> : () -> index
    %2 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %3 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
    %4 = "arith.index_cast"(%3) : (index) -> i32
    %5 = "arith.extsi"(%4) : (i32) -> i64
    %6 = "arith.extsi"(%arg5) : (i32) -> i64
    %7 = "arith.muli"(%5, %6) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %8 = "arith.index_cast"(%7) : (i64) -> index
    %9 = "arith.extsi"(%arg6) : (i32) -> i64
    %10 = "arith.muli"(%5, %9) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %11 = "arith.index_cast"(%10) : (i64) -> index
    %12 = "arith.extsi"(%arg8) : (i32) -> i64
    %13 = "arith.muli"(%5, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %14 = "arith.index_cast"(%13) : (i64) -> index
    %15 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %16 = "arith.index_cast"(%15) : (index) -> i32
    %17 = "arith.extsi"(%16) : (i32) -> i64
    %18 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %19 = "arith.index_cast"(%18) : (index) -> i32
    %20 = "arith.extsi"(%19) : (i32) -> i64
    %21 = "arith.muli"(%17, %2) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %22 = "arith.index_cast"(%21) : (i64) -> index
    %23 = "arith.muli"(%20, %2) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %24 = "arith.index_cast"(%23) : (i64) -> index
    %25 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[1, 1]>>
    %26 = "arith.index_cast"(%arg7) : (i32) -> index
    %27 = "memref.reinterpret_cast"(%arg1, %26) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %28 = "arith.index_cast"(%arg9) : (i32) -> index
    %29 = "memref.reinterpret_cast"(%arg2, %28) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %30 = "arith.addi"(%22, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %31 = "arith.index_cast"(%arg3) : (i32) -> index
    %32 = "arith.minsi"(%30, %31) : (index, index) -> index
    %33 = "arith.maxsi"(%32, %22) : (index, index) -> index
    %34 = "arith.subi"(%33, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %35 = "arith.minsi"(%34, %1) : (index, index) -> index
    %36 = "arith.addi"(%8, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %37 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
    "linalg.fill"(%0, %37) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: f32, %arg22: f32):
      "linalg.yield"(%arg21) : (f32) -> ()
    }) : (f32, memref<32x32xf32>) -> ()
    %38 = "memref.subview"(%25, %36, %35) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[1, 1]>>, index, index) -> memref<?x1xf32, strided<[1, 1], offset: ?>>
    %39 = "memref.subview"(%37, %35) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (memref<32x32xf32>, index) -> memref<?x1xf32, strided<[32, 1]>>
    "linalg.copy"(%38, %39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32):
      "linalg.yield"(%arg19) : (f32) -> ()
    }) : (memref<?x1xf32, strided<[1, 1], offset: ?>>, memref<?x1xf32, strided<[32, 1]>>) -> ()
    %40 = "bufferization.to_tensor"(%37) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
    %41 = "arith.addi"(%24, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %42 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
    "linalg.fill"(%0, %42) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: f32, %arg18: f32):
      "linalg.yield"(%arg17) : (f32) -> ()
    }) : (f32, memref<32x32xf32>) -> ()
    %43 = "memref.subview"(%27, %41) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 1, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index) -> memref<1x32xf32, strided<[?, 1], offset: ?>>
    %44 = "memref.subview"(%42) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 1, 32>, static_strides = array<i64: 1, 1>}> : (memref<32x32xf32>) -> memref<1x32xf32, strided<[32, 1]>>
    "linalg.copy"(%43, %44) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (memref<1x32xf32, strided<[?, 1], offset: ?>>, memref<1x32xf32, strided<[32, 1]>>) -> ()
    %45 = "bufferization.to_tensor"(%42) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
    %46 = "tensor.empty"() : () -> tensor<32x32xf32>
    %47 = "linalg.fill"(%0, %46) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      "linalg.yield"(%arg13) : (f32) -> ()
    }) : (f32, tensor<32x32xf32>) -> tensor<32x32xf32>
    %48 = "linalg.matmul"(%40, %45, %47) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32, %arg12: f32):
      %52 = "arith.mulf"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %53 = "arith.addf"(%arg12, %52) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%53) : (f32) -> ()
    }) : (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
    %49 = "arith.addi"(%24, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %50 = "tensor.extract_slice"(%48, %34) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (tensor<32x32xf32>, index) -> tensor<?x32xf32>
    %51 = "memref.subview"(%29, %22, %49, %34) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index, index) -> memref<?x32xf32, strided<[?, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%50, %51) <{writable}> : (tensor<?x32xf32>, memref<?x32xf32, strided<[?, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

