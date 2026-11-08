#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32) -> (), sym_name = "mul_func_kernel_rank_2"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xbf16>, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %1 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 512 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 511 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %5 = "arith.constant"() <{value = 4096 : i64}> : () -> i64
    %6 = "arith.constant"() <{value = 512 : index}> : () -> index
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    %8 = "arith.constant"() <{value = 0 : index}> : () -> index
    %9 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %10 = "arith.index_cast"(%9) : (index) -> i32
    %11 = "arith.extsi"(%10) : (i32) -> i64
    %12 = "arith.addi"(%arg3, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %13 = "arith.divsi"(%12, %2) : (i32, i32) -> i32
    %14 = "arith.extsi"(%13) : (i32) -> i64
    %15 = "arith.remsi"(%11, %14) : (i64, i64) -> i64
    %16 = "arith.divsi"(%11, %14) : (i64, i64) -> i64
    %17 = "arith.muli"(%15, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %18 = "arith.index_cast"(%17) : (i64) -> index
    %19 = "arith.cmpi"(%16, %4) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %20 = "arith.muli"(%16, %5) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %21 = "arith.index_cast"(%20) : (i64) -> index
    %22 = "arith.addi"(%18, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %23 = "arith.index_cast"(%arg3) : (i32) -> index
    %24 = "arith.minsi"(%22, %23) : (index, index) -> index
    %25 = "arith.maxsi"(%24, %18) : (index, index) -> index
    %26 = "arith.subi"(%25, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %27 = "arith.select"(%19, %7, %8) : (i1, index, index) -> index
    %28 = "arith.select"(%19, %26, %8) : (i1, index, index) -> index
    %29 = "arith.muli"(%28, %27) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %30 = "arith.addi"(%18, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %31 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%0, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: bf16, %arg16: bf16):
      "linalg.yield"(%arg15) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %32 = "memref.subview"(%arg0, %30, %29) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %33 = "memref.subview"(%31, %29) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%32, %33) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: bf16, %arg14: bf16):
      "linalg.yield"(%arg13) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %34 = "bufferization.to_tensor"(%31) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %35 = "tensor.expand_shape"(%34) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 512>}> : (tensor<512xbf16>) -> tensor<1x512xbf16>
    %36 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%0, %36) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: bf16, %arg12: bf16):
      "linalg.yield"(%arg11) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %37 = "memref.subview"(%arg1, %18, %29) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %38 = "memref.subview"(%36, %29) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%37, %38) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: bf16, %arg10: bf16):
      "linalg.yield"(%arg9) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %39 = "bufferization.to_tensor"(%36) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %40 = "tensor.expand_shape"(%39) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 512>}> : (tensor<512xbf16>) -> tensor<1x512xbf16>
    %41 = "linalg.generic"(%35, %40, %35) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: bf16, %arg7: bf16, %arg8: bf16):
      %45 = "arith.mulf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
      "linalg.yield"(%45) : (bf16) -> ()
    }) : (tensor<1x512xbf16>, tensor<1x512xbf16>, tensor<1x512xbf16>) -> tensor<1x512xbf16>
    %42 = "tensor.collapse_shape"(%41) <{reassociation = [[0, 1]]}> : (tensor<1x512xbf16>) -> tensor<512xbf16>
    %43 = "tensor.extract_slice"(%42, %29) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<512xbf16>, index) -> tensor<?xbf16>
    %44 = "memref.subview"(%arg2, %30, %29) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%43, %44) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

