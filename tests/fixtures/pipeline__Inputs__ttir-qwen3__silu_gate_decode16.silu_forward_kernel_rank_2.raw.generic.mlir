#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32) -> (), sym_name = "silu_forward_kernel_rank_2"}> ({
  ^bb0(%arg19: memref<?xbf16>, %arg20: memref<?xbf16>, %arg21: i32, %arg22: i32, %arg23: i32, %arg24: i32):
    %19 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %20 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %21 = "arith.constant"() <{value = 24576 : index}> : () -> index
    %22 = "arith.constant"() <{value = 1 : index}> : () -> index
    %23 = "arith.constant"() <{value = 0 : index}> : () -> index
    %24 = "arith.constant"() <{value = 512 : index}> : () -> index
    %25 = "arith.constant"() <{value = 12288 : index}> : () -> index
    %26 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %27 = "arith.index_cast"(%26) : (index) -> i32
    %28 = "arith.extsi"(%27) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__i32_c1}> : () -> ()
    %29 = "func.call"(%arg22) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %30 = "arith.extsi"(%29) : (i32) -> i64
    %31 = "arith.remsi"(%28, %30) : (i64, i64) -> i64
    %32 = "arith.divsi"(%28, %30) : (i64, i64) -> i64
    %33 = "arith.index_cast"(%32) : (i64) -> index
    %34 = "arith.muli"(%31, %20) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %35 = "arith.index_cast"(%34) : (i64) -> index
    %36 = "arith.muli"(%33, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %37 = "arith.index_cast"(%arg21) : (i32) -> index
    %38 = "arith.cmpi"(%33, %37) <{predicate = 2 : i64}> : (index, index) -> i1
    %39 = "arith.select"(%38, %22, %23) : (i1, index, index) -> index
    %40 = "arith.addi"(%35, %24) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %41 = "arith.index_cast"(%arg22) : (i32) -> index
    %42 = "arith.minsi"(%40, %41) : (index, index) -> index
    %43 = "arith.maxsi"(%42, %35) : (index, index) -> index
    %44 = "arith.subi"(%43, %35) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %45 = "arith.minsi"(%39, %22) : (index, index) -> index
    %46 = "arith.minsi"(%44, %24) : (index, index) -> index
    %47 = "arith.muli"(%46, %45) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %48 = "arith.addi"(%35, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %49 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%19, %49) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: bf16, %arg30: bf16):
      "linalg.yield"(%arg29) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %50 = "memref.subview"(%arg19, %48, %47) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %51 = "memref.subview"(%49, %47) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%50, %51) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg27: bf16, %arg28: bf16):
      "linalg.yield"(%arg27) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %52 = "bufferization.to_tensor"(%49) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %53 = "tensor.expand_shape"(%52) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 512>}> : (tensor<512xbf16>) -> tensor<1x512xbf16>
    %54 = "func.call"(%53) <{callee = @flag_gems.ops.silu.silu_forward__bf16S1_512S}> : (tensor<1x512xbf16>) -> tensor<1x512xf32>
    %55 = "arith.muli"(%33, %25) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %56 = "tensor.empty"() : () -> tensor<1x512xbf16>
    %57 = "linalg.generic"(%54, %56) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: f32, %arg26: bf16):
      %62 = "arith.truncf"(%arg25) : (f32) -> bf16
      "linalg.yield"(%62) : (bf16) -> ()
    }) : (tensor<1x512xf32>, tensor<1x512xbf16>) -> tensor<1x512xbf16>
    %58 = "tensor.collapse_shape"(%57) <{reassociation = [[0, 1]]}> : (tensor<1x512xbf16>) -> tensor<512xbf16>
    %59 = "arith.addi"(%35, %55) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %60 = "tensor.extract_slice"(%58, %47) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<512xbf16>, index) -> tensor<?xbf16>
    %61 = "memref.subview"(%arg20, %59, %47) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%60, %61) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__i32_c1", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c512", sym_visibility = "private"}> ({
  ^bb0(%arg18: i32):
    %15 = "arith.constant"() <{value = 512 : i32}> : () -> i32
    %16 = "arith.constant"() <{value = 511 : i32}> : () -> i32
    %17 = "arith.addi"(%arg18, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %18 = "arith.divsi"(%17, %15) : (i32, i32) -> i32
    "func.return"(%18) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x512xbf16>) -> tensor<1x512xf32>, sym_name = "flag_gems.ops.silu.silu_forward__bf16S1_512S", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<1x512xbf16>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "tensor.empty"() : () -> tensor<1x512xf32>
    %3 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: f32, %arg17: f32):
      "linalg.yield"(%arg16) : (f32) -> ()
    }) : (f32, tensor<1x512xf32>) -> tensor<1x512xf32>
    %4 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      "linalg.yield"(%arg14) : (f32) -> ()
    }) : (f32, tensor<1x512xf32>) -> tensor<1x512xf32>
    %5 = "linalg.generic"(%arg0, %2) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: bf16, %arg13: f32):
      %14 = "arith.extf"(%arg12) : (bf16) -> f32
      "linalg.yield"(%14) : (f32) -> ()
    }) : (tensor<1x512xbf16>, tensor<1x512xf32>) -> tensor<1x512xf32>
    %6 = "linalg.generic"(%4, %5, %4) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32, %arg11: f32):
      %13 = "arith.subf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%13) : (f32) -> ()
    }) : (tensor<1x512xf32>, tensor<1x512xf32>, tensor<1x512xf32>) -> tensor<1x512xf32>
    %7 = "linalg.generic"(%6, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32):
      %12 = "math.exp"(%arg7) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%12) : (f32) -> ()
    }) : (tensor<1x512xf32>, tensor<1x512xf32>) -> tensor<1x512xf32>
    %8 = "linalg.generic"(%7, %3, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32, %arg6: f32):
      %11 = "arith.addf"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%11) : (f32) -> ()
    }) : (tensor<1x512xf32>, tensor<1x512xf32>, tensor<1x512xf32>) -> tensor<1x512xf32>
    %9 = "linalg.generic"(%5, %8, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %10 = "arith.divf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<1x512xf32>, tensor<1x512xf32>, tensor<1x512xf32>) -> tensor<1x512xf32>
    "func.return"(%9) : (tensor<1x512xf32>) -> ()
  }) : () -> ()
}) : () -> ()

