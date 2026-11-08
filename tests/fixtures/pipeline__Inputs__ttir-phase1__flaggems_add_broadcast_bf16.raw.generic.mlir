#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, i32, memref<?xbf16>, i32, i32, i32, i32) -> (), sym_name = "add_func_kernel_rank_2"}> ({
  ^bb0(%arg16: memref<?xbf16>, %arg17: memref<?xbf16>, %arg18: i32, %arg19: memref<?xbf16>, %arg20: i32, %arg21: i32, %arg22: i32, %arg23: i32):
    %15 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %16 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %17 = "arith.constant"() <{value = 4096 : index}> : () -> index
    %18 = "arith.constant"() <{value = 1 : index}> : () -> index
    %19 = "arith.constant"() <{value = 0 : index}> : () -> index
    %20 = "arith.constant"() <{value = 512 : index}> : () -> index
    %21 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %22 = "arith.index_cast"(%21) : (index) -> i32
    %23 = "arith.extsi"(%22) : (i32) -> i64
    "func.call"() <{callee = @triton.language.standard.cdiv__i32_c1}> : () -> ()
    %24 = "func.call"(%arg21) <{callee = @triton.language.standard.cdiv__i32_c512}> : (i32) -> i32
    %25 = "arith.extsi"(%24) : (i32) -> i64
    %26 = "arith.remsi"(%23, %25) : (i64, i64) -> i64
    %27 = "arith.divsi"(%23, %25) : (i64, i64) -> i64
    %28 = "arith.index_cast"(%27) : (i64) -> index
    %29 = "arith.muli"(%26, %16) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %30 = "arith.index_cast"(%29) : (i64) -> index
    %31 = "arith.muli"(%28, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %32 = "arith.index_cast"(%arg20) : (i32) -> index
    %33 = "arith.cmpi"(%28, %32) <{predicate = 2 : i64}> : (index, index) -> i1
    %34 = "arith.select"(%33, %18, %19) : (i1, index, index) -> index
    %35 = "arith.addi"(%30, %20) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %36 = "arith.index_cast"(%arg21) : (i32) -> index
    %37 = "arith.minsi"(%35, %36) : (index, index) -> index
    %38 = "arith.maxsi"(%37, %30) : (index, index) -> index
    %39 = "arith.subi"(%38, %30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %40 = "arith.minsi"(%34, %18) : (index, index) -> index
    %41 = "arith.minsi"(%39, %20) : (index, index) -> index
    %42 = "arith.muli"(%41, %40) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %43 = "arith.addi"(%30, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %44 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%15, %44) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg32: bf16, %arg33: bf16):
      "linalg.yield"(%arg32) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %45 = "memref.subview"(%arg16, %43, %42) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %46 = "memref.subview"(%44, %42) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%45, %46) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: bf16, %arg31: bf16):
      "linalg.yield"(%arg30) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %47 = "bufferization.to_tensor"(%44) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %48 = "tensor.expand_shape"(%47) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 512>}> : (tensor<512xbf16>) -> tensor<1x512xbf16>
    %49 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%15, %49) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg28: bf16, %arg29: bf16):
      "linalg.yield"(%arg28) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %50 = "memref.subview"(%arg17, %30, %42) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %51 = "memref.subview"(%49, %42) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%50, %51) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg26: bf16, %arg27: bf16):
      "linalg.yield"(%arg26) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %52 = "bufferization.to_tensor"(%49) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %53 = "tensor.expand_shape"(%52) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 512>}> : (tensor<512xbf16>) -> tensor<1x512xbf16>
    %54 = "func.call"(%48, %53, %arg18) <{callee = @flag_gems.ops.add.add_func__bf16S1_512S_bf16S1_512S_i32}> : (tensor<1x512xbf16>, tensor<1x512xbf16>, i32) -> tensor<1x512xf32>
    %55 = "tensor.empty"() : () -> tensor<1x512xbf16>
    %56 = "linalg.generic"(%54, %55) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: f32, %arg25: bf16):
      %60 = "arith.truncf"(%arg24) : (f32) -> bf16
      "linalg.yield"(%60) : (bf16) -> ()
    }) : (tensor<1x512xf32>, tensor<1x512xbf16>) -> tensor<1x512xbf16>
    %57 = "tensor.collapse_shape"(%56) <{reassociation = [[0, 1]]}> : (tensor<1x512xbf16>) -> tensor<512xbf16>
    %58 = "tensor.extract_slice"(%57, %42) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<512xbf16>, index) -> tensor<?xbf16>
    %59 = "memref.subview"(%arg19, %43, %42) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%58, %59) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__i32_c1", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c512", sym_visibility = "private"}> ({
  ^bb0(%arg15: i32):
    %11 = "arith.constant"() <{value = 512 : i32}> : () -> i32
    %12 = "arith.constant"() <{value = 511 : i32}> : () -> i32
    %13 = "arith.addi"(%arg15, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %14 = "arith.divsi"(%13, %11) : (i32, i32) -> i32
    "func.return"(%14) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x512xbf16>, tensor<1x512xbf16>, i32) -> tensor<1x512xf32>, sym_name = "flag_gems.ops.add.add_func__bf16S1_512S_bf16S1_512S_i32", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<1x512xbf16>, %arg1: tensor<1x512xbf16>, %arg2: i32):
    %0 = "tensor.empty"() : () -> tensor<1x512xf32>
    %1 = "linalg.generic"(%arg1, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: bf16, %arg14: f32):
      %10 = "arith.extf"(%arg13) : (bf16) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<1x512xbf16>, tensor<1x512xf32>) -> tensor<1x512xf32>
    %2 = "arith.sitofp"(%arg2) : (i32) -> f32
    %3 = "linalg.fill"(%2, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      "linalg.yield"(%arg11) : (f32) -> ()
    }) : (f32, tensor<1x512xf32>) -> tensor<1x512xf32>
    %4 = "linalg.generic"(%1, %3, %1) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32, %arg10: f32):
      %9 = "arith.mulf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%9) : (f32) -> ()
    }) : (tensor<1x512xf32>, tensor<1x512xf32>, tensor<1x512xf32>) -> tensor<1x512xf32>
    %5 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: bf16, %arg7: f32):
      %8 = "arith.extf"(%arg6) : (bf16) -> f32
      "linalg.yield"(%8) : (f32) -> ()
    }) : (tensor<1x512xbf16>, tensor<1x512xf32>) -> tensor<1x512xf32>
    %6 = "linalg.generic"(%5, %4, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %7 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) : (tensor<1x512xf32>, tensor<1x512xf32>, tensor<1x512xf32>) -> tensor<1x512xf32>
    "func.return"(%6) : (tensor<1x512xf32>) -> ()
  }) : () -> ()
}) : () -> ()

