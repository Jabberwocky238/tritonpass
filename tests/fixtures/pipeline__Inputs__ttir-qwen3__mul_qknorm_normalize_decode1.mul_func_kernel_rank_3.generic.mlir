#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32, i32) -> (), sym_name = "mul_func_kernel_rank_3"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %3 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 63 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %8 = "arith.constant"() <{value = 4096 : i64}> : () -> i64
    %9 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %10 = "arith.constant"() <{value = 8 : index}> : () -> index
    %11 = "arith.constant"() <{value = 1 : index}> : () -> index
    %12 = "arith.constant"() <{value = 0 : index}> : () -> index
    %13 = "arith.constant"() <{value = 64 : index}> : () -> index
    %14 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %15 = "arith.index_cast"(%14) : (index) -> i32
    %16 = "arith.extsi"(%15) : (i32) -> i64
    %17 = "arith.addi"(%arg3, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %18 = "arith.divsi"(%17, %3) : (i32, i32) -> i32
    %19 = "arith.addi"(%arg4, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %20 = "arith.divsi"(%19, %5) : (i32, i32) -> i32
    %21 = "arith.extsi"(%20) : (i32) -> i64
    %22 = "arith.remsi"(%16, %21) : (i64, i64) -> i64
    %23 = "arith.divsi"(%16, %21) : (i64, i64) -> i64
    %24 = "arith.extsi"(%18) : (i32) -> i64
    %25 = "arith.remsi"(%23, %24) : (i64, i64) -> i64
    %26 = "arith.divsi"(%23, %24) : (i64, i64) -> i64
    %27 = "arith.muli"(%25, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %28 = "arith.index_cast"(%27) : (i64) -> index
    %29 = "arith.muli"(%22, %2) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %30 = "arith.index_cast"(%29) : (i64) -> index
    %31 = "arith.cmpi"(%26, %7) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %32 = "arith.muli"(%26, %8) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %33 = "arith.index_cast"(%32) : (i64) -> index
    %34 = "arith.addi"(%28, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %35 = "arith.index_cast"(%arg3) : (i32) -> index
    %36 = "arith.minsi"(%34, %35) : (index, index) -> index
    %37 = "arith.maxsi"(%36, %28) : (index, index) -> index
    %38 = "arith.subi"(%37, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %39 = "arith.select"(%31, %11, %12) : (i1, index, index) -> index
    %40 = "arith.select"(%31, %38, %12) : (i1, index, index) -> index
    %41 = "arith.addi"(%30, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %42 = "arith.index_cast"(%arg4) : (i32) -> index
    %43 = "arith.minsi"(%41, %42) : (index, index) -> index
    %44 = "arith.maxsi"(%43, %30) : (index, index) -> index
    %45 = "arith.subi"(%44, %30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %46 = "arith.minsi"(%39, %11) : (index, index) -> index
    %47 = "arith.minsi"(%40, %10) : (index, index) -> index
    %48 = "arith.minsi"(%45, %13) : (index, index) -> index
    %49 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[128, 1]>>
    %50 = "arith.muli"(%47, %46) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %51 = "arith.addi"(%30, %33) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %52 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xf32>
    "linalg.fill"(%0, %52) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: f32, %arg17: f32):
      "linalg.yield"(%arg16) : (f32) -> ()
    }) : (f32, memref<8x64xf32>) -> ()
    %53 = "memref.subview"(%49, %28, %51, %50, %48) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[128, 1], offset: ?>>
    %54 = "memref.subview"(%52, %50, %48) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xf32>, index, index) -> memref<?x?xf32, strided<[64, 1]>>
    "linalg.copy"(%53, %54) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      "linalg.yield"(%arg14) : (f32) -> ()
    }) : (memref<?x?xf32, strided<[128, 1], offset: ?>>, memref<?x?xf32, strided<[64, 1]>>) -> ()
    %55 = "bufferization.to_tensor"(%52) <{restrict, writable}> : (memref<8x64xf32>) -> tensor<8x64xf32>
    %56 = "tensor.expand_shape"(%55) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 8, 64>}> : (tensor<8x64xf32>) -> tensor<1x8x64xf32>
    %57 = "arith.muli"(%26, %9) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %58 = "arith.index_cast"(%57) : (i64) -> index
    %59 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, 0>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[1, 0]>>
    %60 = "arith.addi"(%28, %58) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %61 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xf32>
    "linalg.fill"(%0, %61) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, memref<8x64xf32>) -> ()
    %62 = "memref.subview"(%59, %60, %50, %48) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[1, 0]>>, index, index, index) -> memref<?x?xf32, strided<[1, 0], offset: ?>>
    %63 = "memref.subview"(%61, %50, %48) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xf32>, index, index) -> memref<?x?xf32, strided<[64, 1]>>
    "linalg.copy"(%62, %63) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (memref<?x?xf32, strided<[1, 0], offset: ?>>, memref<?x?xf32, strided<[64, 1]>>) -> ()
    %64 = "bufferization.to_tensor"(%61) <{restrict, writable}> : (memref<8x64xf32>) -> tensor<8x64xf32>
    %65 = "tensor.expand_shape"(%64) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 8, 64>}> : (tensor<8x64xf32>) -> tensor<1x8x64xf32>
    %66 = "linalg.generic"(%56, %65, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32, %arg9: f32):
      %71 = "arith.mulf"(%arg7, %arg8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%71) : (f32) -> ()
    }) : (tensor<1x8x64xf32>, tensor<1x8x64xf32>, tensor<1x8x64xf32>) -> tensor<1x8x64xf32>
    %67 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[128, 1]>>
    %68 = "tensor.collapse_shape"(%66) <{reassociation = [[0, 1], [2]]}> : (tensor<1x8x64xf32>) -> tensor<8x64xf32>
    %69 = "tensor.extract_slice"(%68, %50, %48) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<8x64xf32>, index, index) -> tensor<?x?xf32>
    %70 = "memref.subview"(%67, %28, %51, %50, %48) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[128, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%69, %70) <{writable}> : (tensor<?x?xf32>, memref<?x?xf32, strided<[128, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

