#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32, i32) -> (), sym_name = "mul_func_kernel_rank_3"}> ({
  ^bb0(%arg7: memref<?xf32>, %arg8: memref<?xf32>, %arg9: memref<?xf32>, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32):
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
    "func.call"() <{callee = @triton.language.standard.cdiv__c1_c1}> : () -> ()
    %22 = "func.call"(%arg10) <{callee = @triton.language.standard.cdiv__i32_c8}> : (i32) -> i32
    %23 = "func.call"(%arg11) <{callee = @triton.language.standard.cdiv__i32_c64}> : (i32) -> i32
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
    %36 = "arith.cmpi"(%30, %14) <{predicate = 2 : i64}> : (index, index) -> i1
    %37 = "arith.select"(%36, %14, %15) : (i1, index, index) -> index
    %38 = "arith.addi"(%32, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %39 = "arith.index_cast"(%arg10) : (i32) -> index
    %40 = "arith.minsi"(%38, %39) : (index, index) -> index
    %41 = "arith.maxsi"(%40, %32) : (index, index) -> index
    %42 = "arith.subi"(%41, %32) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %43 = "arith.minsi"(%37, %14) : (index, index) -> index
    %44 = "arith.minsi"(%42, %16) : (index, index) -> index
    %45 = "arith.addi"(%34, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %46 = "arith.index_cast"(%arg11) : (i32) -> index
    %47 = "arith.minsi"(%45, %46) : (index, index) -> index
    %48 = "arith.maxsi"(%47, %34) : (index, index) -> index
    %49 = "arith.subi"(%48, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %50 = "arith.minsi"(%43, %14) : (index, index) -> index
    %51 = "arith.minsi"(%44, %16) : (index, index) -> index
    %52 = "arith.minsi"(%49, %17) : (index, index) -> index
    %53 = "memref.reinterpret_cast"(%arg7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[128, 1]>>
    %54 = "arith.muli"(%51, %50) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %55 = "arith.addi"(%34, %35) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %56 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xf32>
    "linalg.fill"(%10, %56) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: f32, %arg21: f32):
      "linalg.yield"(%arg20) : (f32) -> ()
    }) : (f32, memref<8x64xf32>) -> ()
    %57 = "memref.subview"(%53, %32, %55, %54, %52) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[128, 1], offset: ?>>
    %58 = "memref.subview"(%56, %54, %52) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xf32>, index, index) -> memref<?x?xf32, strided<[64, 1]>>
    "linalg.copy"(%57, %58) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: f32, %arg19: f32):
      "linalg.yield"(%arg18) : (f32) -> ()
    }) : (memref<?x?xf32, strided<[128, 1], offset: ?>>, memref<?x?xf32, strided<[64, 1]>>) -> ()
    %59 = "bufferization.to_tensor"(%56) <{restrict, writable}> : (memref<8x64xf32>) -> tensor<8x64xf32>
    %60 = "tensor.expand_shape"(%59) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 8, 64>}> : (tensor<8x64xf32>) -> tensor<1x8x64xf32>
    %61 = "arith.muli"(%30, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %62 = "memref.reinterpret_cast"(%arg8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, 0>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[1, 0]>>
    %63 = "arith.addi"(%32, %61) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %64 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xf32>
    "linalg.fill"(%10, %64) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: f32, %arg17: f32):
      "linalg.yield"(%arg16) : (f32) -> ()
    }) : (f32, memref<8x64xf32>) -> ()
    %65 = "memref.subview"(%62, %63, %54, %52) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[1, 0]>>, index, index, index) -> memref<?x?xf32, strided<[1, 0], offset: ?>>
    %66 = "memref.subview"(%64, %54, %52) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xf32>, index, index) -> memref<?x?xf32, strided<[64, 1]>>
    "linalg.copy"(%65, %66) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      "linalg.yield"(%arg14) : (f32) -> ()
    }) : (memref<?x?xf32, strided<[1, 0], offset: ?>>, memref<?x?xf32, strided<[64, 1]>>) -> ()
    %67 = "bufferization.to_tensor"(%64) <{restrict, writable}> : (memref<8x64xf32>) -> tensor<8x64xf32>
    %68 = "tensor.expand_shape"(%67) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 8, 64>}> : (tensor<8x64xf32>) -> tensor<1x8x64xf32>
    %69 = "func.call"(%60, %68) <{callee = @_dope.ops.mul.mul_func__fp32S1_8_64S_fp32S1_8_64S}> : (tensor<1x8x64xf32>, tensor<1x8x64xf32>) -> tensor<1x8x64xf32>
    %70 = "memref.reinterpret_cast"(%arg9) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[128, 1]>>
    %71 = "tensor.collapse_shape"(%69) <{reassociation = [[0, 1], [2]]}> : (tensor<1x8x64xf32>) -> tensor<8x64xf32>
    %72 = "tensor.extract_slice"(%71, %54, %52) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<8x64xf32>, index, index) -> tensor<?x?xf32>
    %73 = "memref.subview"(%70, %32, %55, %54, %52) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[128, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%72, %73) <{writable}> : (tensor<?x?xf32>, memref<?x?xf32, strided<[128, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__c1_c1", sym_visibility = "private"}> ({
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

