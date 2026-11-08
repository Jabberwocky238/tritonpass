#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32) -> (), sym_name = "silu_forward_kernel_rank_2"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 24576 : i64}> : () -> i64
    %3 = "arith.constant"() <{value = 12288 : i64}> : () -> i64
    %4 = "arith.constant"() <{value = 512 : index}> : () -> index
    %5 = "arith.constant"() <{value = 1 : index}> : () -> index
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = 511 : i32}> : () -> i32
    %9 = "arith.constant"() <{value = 512 : i32}> : () -> i32
    %10 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %11 = "tensor.empty"() : () -> tensor<1x512xf32>
    %12 = "linalg.fill"(%1, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg27: f32, %arg28: f32):
      "linalg.yield"(%arg27) : (f32) -> ()
    }) : (f32, tensor<1x512xf32>) -> tensor<1x512xf32>
    %13 = "linalg.fill"(%7, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: f32, %arg26: f32):
      "linalg.yield"(%arg25) : (f32) -> ()
    }) : (f32, tensor<1x512xf32>) -> tensor<1x512xf32>
    %14 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %15 = "arith.index_cast"(%14) : (index) -> i32
    %16 = "arith.extsi"(%15) : (i32) -> i64
    %17 = "arith.addi"(%arg3, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %18 = "arith.divsi"(%17, %9) : (i32, i32) -> i32
    %19 = "arith.extsi"(%18) : (i32) -> i64
    %20 = "arith.remsi"(%16, %19) : (i64, i64) -> i64
    %21 = "arith.divsi"(%16, %19) : (i64, i64) -> i64
    %22 = "arith.muli"(%20, %10) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %23 = "arith.index_cast"(%22) : (i64) -> index
    %24 = "arith.extsi"(%arg2) : (i32) -> i64
    %25 = "arith.cmpi"(%21, %24) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %26 = "arith.muli"(%21, %2) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %27 = "arith.index_cast"(%26) : (i64) -> index
    %28 = "arith.addi"(%23, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %29 = "arith.index_cast"(%arg3) : (i32) -> index
    %30 = "arith.minsi"(%28, %29) : (index, index) -> index
    %31 = "arith.maxsi"(%30, %23) : (index, index) -> index
    %32 = "arith.subi"(%31, %23) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %33 = "arith.select"(%25, %5, %6) : (i1, index, index) -> index
    %34 = "arith.select"(%25, %32, %6) : (i1, index, index) -> index
    %35 = "arith.muli"(%34, %33) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %36 = "arith.addi"(%23, %27) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %37 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%0, %37) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: bf16, %arg24: bf16):
      "linalg.yield"(%arg23) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %38 = "memref.subview"(%arg0, %36, %35) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %39 = "memref.subview"(%37, %35) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%38, %39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: bf16, %arg22: bf16):
      "linalg.yield"(%arg21) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %40 = "bufferization.to_tensor"(%37) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %41 = "tensor.expand_shape"(%40) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 512>}> : (tensor<512xbf16>) -> tensor<1x512xbf16>
    %42 = "linalg.generic"(%41, %11) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: bf16, %arg20: f32):
      %60 = "arith.extf"(%arg19) : (bf16) -> f32
      "linalg.yield"(%60) : (f32) -> ()
    }) : (tensor<1x512xbf16>, tensor<1x512xf32>) -> tensor<1x512xf32>
    %43 = "linalg.generic"(%12, %42, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: f32, %arg17: f32, %arg18: f32):
      %59 = "arith.subf"(%arg16, %arg17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%59) : (f32) -> ()
    }) : (tensor<1x512xf32>, tensor<1x512xf32>, tensor<1x512xf32>) -> tensor<1x512xf32>
    %44 = "linalg.generic"(%43, %43) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %58 = "math.exp"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%58) : (f32) -> ()
    }) : (tensor<1x512xf32>, tensor<1x512xf32>) -> tensor<1x512xf32>
    %45 = "linalg.generic"(%44, %13, %44) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32, %arg13: f32):
      %57 = "arith.addf"(%arg11, %arg12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%57) : (f32) -> ()
    }) : (tensor<1x512xf32>, tensor<1x512xf32>, tensor<1x512xf32>) -> tensor<1x512xf32>
    %46 = "linalg.generic"(%42, %45, %42) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32, %arg10: f32):
      %56 = "arith.divf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%56) : (f32) -> ()
    }) : (tensor<1x512xf32>, tensor<1x512xf32>, tensor<1x512xf32>) -> tensor<1x512xf32>
    %47 = "arith.muli"(%21, %3) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %48 = "arith.index_cast"(%47) : (i64) -> index
    %49 = "tensor.empty"() : () -> tensor<1x512xbf16>
    %50 = "linalg.generic"(%46, %49) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: bf16):
      %55 = "arith.truncf"(%arg6) : (f32) -> bf16
      "linalg.yield"(%55) : (bf16) -> ()
    }) : (tensor<1x512xf32>, tensor<1x512xbf16>) -> tensor<1x512xbf16>
    %51 = "tensor.collapse_shape"(%50) <{reassociation = [[0, 1]]}> : (tensor<1x512xbf16>) -> tensor<512xbf16>
    %52 = "arith.addi"(%23, %48) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %53 = "tensor.extract_slice"(%51, %35) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<512xbf16>, index) -> tensor<?xbf16>
    %54 = "memref.subview"(%arg1, %52, %35) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%53, %54) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

