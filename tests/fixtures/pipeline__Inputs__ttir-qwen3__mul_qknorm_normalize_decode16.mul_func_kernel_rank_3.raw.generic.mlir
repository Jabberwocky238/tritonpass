#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32, i32, i32) -> (), sym_name = "mul_func_kernel_rank_3"}> ({
  ^bb0(%arg7: memref<?xf32>, %arg8: memref<?xf32>, %arg9: memref<?xf32>, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32):
    %10 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %11 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %12 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %13 = "arith.constant"() <{value = 4096 : index}> : () -> index
    %14 = "arith.constant"() <{value = 1 : index}> : () -> index
    %15 = "arith.constant"() <{value = 0 : index}> : () -> index
    %16 = "arith.constant"() <{value = 8 : index}> : () -> index
    %17 = "arith.constant"() <{value = 64 : index}> : () -> index
    %18 = "arith.constant"() <{value = 32 : index}> : () -> index
    %19 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %20 = "arith.index_cast"(%19) : (index) -> i32
    %21 = "arith.extsi"(%20) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__i32_c1}> : () -> ()
    %22 = "func.call"(%arg11) <{callee = @triton.language.standard.cdiv__i32_c8}> : (i32) -> i32
    %23 = "func.call"(%arg12) <{callee = @triton.language.standard.cdiv__i32_c64}> : (i32) -> i32
    %24 = "arith.extsi"(%23) : (i32) -> i64
    %25 = "arith.remsi"(%21, %24) : (i64, i64) -> i64
    %26 = "arith.divsi"(%21, %24) : (i64, i64) -> i64
    %27 = "arith.extsi"(%22) : (i32) -> i64
    %28 = "arith.remsi"(%26, %27) : (i64, i64) -> i64
    %29 = "arith.divsi"(%26, %27) : (i64, i64) -> i64
    %30 = "arith.index_cast"(%29) : (i64) -> index
    %31 = "arith.muli"(%28, %11) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %32 = "arith.index_cast"(%31) : (i64) -> index
    %33 = "arith.muli"(%25, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %34 = "arith.index_cast"(%33) : (i64) -> index
    %35 = "arith.muli"(%30, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %36 = "arith.index_cast"(%arg10) : (i32) -> index
    %37 = "arith.cmpi"(%30, %36) <{predicate = 2 : i64}> : (index, index) -> i1
    %38 = "arith.select"(%37, %14, %15) : (i1, index, index) -> index
    %39 = "arith.addi"(%32, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %40 = "arith.index_cast"(%arg11) : (i32) -> index
    %41 = "arith.minsi"(%39, %40) : (index, index) -> index
    %42 = "arith.maxsi"(%41, %32) : (index, index) -> index
    %43 = "arith.subi"(%42, %32) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %44 = "arith.minsi"(%38, %14) : (index, index) -> index
    %45 = "arith.minsi"(%43, %16) : (index, index) -> index
    %46 = "arith.addi"(%34, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %47 = "arith.index_cast"(%arg12) : (i32) -> index
    %48 = "arith.minsi"(%46, %47) : (index, index) -> index
    %49 = "arith.maxsi"(%48, %34) : (index, index) -> index
    %50 = "arith.subi"(%49, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %51 = "arith.minsi"(%44, %14) : (index, index) -> index
    %52 = "arith.minsi"(%45, %16) : (index, index) -> index
    %53 = "arith.minsi"(%50, %17) : (index, index) -> index
    %54 = "memref.reinterpret_cast"(%arg7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[128, 1]>>
    %55 = "arith.muli"(%52, %51) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %56 = "arith.addi"(%34, %35) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %57 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xf32>
    "linalg.fill"(%10, %57) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: f32, %arg22: f32):
      "linalg.yield"(%arg21) : (f32) -> ()
    }) : (f32, memref<8x64xf32>) -> ()
    %58 = "memref.subview"(%54, %32, %56, %55, %53) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[128, 1], offset: ?>>
    %59 = "memref.subview"(%57, %55, %53) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xf32>, index, index) -> memref<?x?xf32, strided<[64, 1]>>
    "linalg.copy"(%58, %59) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32):
      "linalg.yield"(%arg19) : (f32) -> ()
    }) : (memref<?x?xf32, strided<[128, 1], offset: ?>>, memref<?x?xf32, strided<[64, 1]>>) -> ()
    %60 = "bufferization.to_tensor"(%57) <{restrict, writable}> : (memref<8x64xf32>) -> tensor<8x64xf32>
    %61 = "tensor.expand_shape"(%60) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 8, 64>}> : (tensor<8x64xf32>) -> tensor<1x8x64xf32>
    %62 = "arith.muli"(%30, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %63 = "memref.reinterpret_cast"(%arg8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, 0>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[1, 0]>>
    %64 = "arith.addi"(%32, %62) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %65 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xf32>
    "linalg.fill"(%10, %65) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: f32, %arg18: f32):
      "linalg.yield"(%arg17) : (f32) -> ()
    }) : (f32, memref<8x64xf32>) -> ()
    %66 = "memref.subview"(%63, %64, %55, %53) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[1, 0]>>, index, index, index) -> memref<?x?xf32, strided<[1, 0], offset: ?>>
    %67 = "memref.subview"(%65, %55, %53) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xf32>, index, index) -> memref<?x?xf32, strided<[64, 1]>>
    "linalg.copy"(%66, %67) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (memref<?x?xf32, strided<[1, 0], offset: ?>>, memref<?x?xf32, strided<[64, 1]>>) -> ()
    %68 = "bufferization.to_tensor"(%65) <{restrict, writable}> : (memref<8x64xf32>) -> tensor<8x64xf32>
    %69 = "tensor.expand_shape"(%68) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 8, 64>}> : (tensor<8x64xf32>) -> tensor<1x8x64xf32>
    %70 = "func.call"(%61, %69) <{callee = @_dope.ops.mul.mul_func__fp32S1_8_64S_fp32S1_8_64S}> : (tensor<1x8x64xf32>, tensor<1x8x64xf32>) -> tensor<1x8x64xf32>
    %71 = "memref.reinterpret_cast"(%arg9) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[128, 1]>>
    %72 = "tensor.collapse_shape"(%70) <{reassociation = [[0, 1], [2]]}> : (tensor<1x8x64xf32>) -> tensor<8x64xf32>
    %73 = "tensor.extract_slice"(%72, %55, %53) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<8x64xf32>, index, index) -> tensor<?x?xf32>
    %74 = "memref.subview"(%71, %32, %56, %55, %53) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[128, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%73, %74) <{writable}> : (tensor<?x?xf32>, memref<?x?xf32, strided<[128, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__i32_c1", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c8", sym_visibility = "private"}> ({
  ^bb0(%arg6: i32):
    %6 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %8 = "arith.addi"(%arg6, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %9 = "arith.divsi"(%8, %6) : (i32, i32) -> i32
    "func.return"(%9) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c64", sym_visibility = "private"}> ({
  ^bb0(%arg5: i32):
    %2 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 63 : i32}> : () -> i32
    %4 = "arith.addi"(%arg5, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %5 = "arith.divsi"(%4, %2) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x8x64xf32>, tensor<1x8x64xf32>) -> tensor<1x8x64xf32>, sym_name = "_dope.ops.mul.mul_func__fp32S1_8_64S_fp32S1_8_64S", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<1x8x64xf32>, %arg1: tensor<1x8x64xf32>):
    %0 = "linalg.generic"(%arg0, %arg1, %arg0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %1 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%1) : (f32) -> ()
    }) : (tensor<1x8x64xf32>, tensor<1x8x64xf32>, tensor<1x8x64xf32>) -> tensor<1x8x64xf32>
    "func.return"(%0) : (tensor<1x8x64xf32>) -> ()
  }) : () -> ()
}) : () -> ()

