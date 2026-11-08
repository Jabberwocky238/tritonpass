#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32) -> (), sym_name = "mul_func_kernel_rank_2"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xbf16>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %1 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 512 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 511 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 12288 : i64}> : () -> i64
    %5 = "arith.constant"() <{value = 24576 : i64}> : () -> i64
    %6 = "arith.constant"() <{value = 512 : index}> : () -> index
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    %8 = "arith.constant"() <{value = 0 : index}> : () -> index
    %9 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %10 = "arith.index_cast"(%9) : (index) -> i32
    %11 = "arith.extsi"(%10) : (i32) -> i64
    %12 = "arith.addi"(%arg4, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %13 = "arith.divsi"(%12, %2) : (i32, i32) -> i32
    %14 = "arith.extsi"(%13) : (i32) -> i64
    %15 = "arith.remsi"(%11, %14) : (i64, i64) -> i64
    %16 = "arith.divsi"(%11, %14) : (i64, i64) -> i64
    %17 = "arith.muli"(%15, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %18 = "arith.index_cast"(%17) : (i64) -> index
    %19 = "arith.extsi"(%arg3) : (i32) -> i64
    %20 = "arith.cmpi"(%16, %19) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %21 = "arith.muli"(%16, %4) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %22 = "arith.index_cast"(%21) : (i64) -> index
    %23 = "arith.addi"(%18, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %24 = "arith.index_cast"(%arg4) : (i32) -> index
    %25 = "arith.minsi"(%23, %24) : (index, index) -> index
    %26 = "arith.maxsi"(%25, %18) : (index, index) -> index
    %27 = "arith.subi"(%26, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %28 = "arith.select"(%20, %7, %8) : (i1, index, index) -> index
    %29 = "arith.select"(%20, %27, %8) : (i1, index, index) -> index
    %30 = "arith.muli"(%29, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %31 = "arith.addi"(%18, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %32 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%0, %32) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: bf16, %arg17: bf16):
      "linalg.yield"(%arg16) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %33 = "memref.subview"(%arg0, %31, %30) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %34 = "memref.subview"(%32, %30) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%33, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: bf16, %arg15: bf16):
      "linalg.yield"(%arg14) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %35 = "bufferization.to_tensor"(%32) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %36 = "tensor.expand_shape"(%35) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 512>}> : (tensor<512xbf16>) -> tensor<1x512xbf16>
    %37 = "arith.muli"(%16, %5) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %38 = "arith.index_cast"(%37) : (i64) -> index
    %39 = "arith.addi"(%18, %38) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %40 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "linalg.fill"(%0, %40) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: bf16, %arg13: bf16):
      "linalg.yield"(%arg12) : (bf16) -> ()
    }) : (bf16, memref<512xbf16>) -> ()
    %41 = "memref.subview"(%arg1, %39, %30) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %42 = "memref.subview"(%40, %30) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%41, %42) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: bf16, %arg11: bf16):
      "linalg.yield"(%arg10) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %43 = "bufferization.to_tensor"(%40) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %44 = "tensor.expand_shape"(%43) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 512>}> : (tensor<512xbf16>) -> tensor<1x512xbf16>
    %45 = "linalg.generic"(%36, %44, %36) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg7: bf16, %arg8: bf16, %arg9: bf16):
      %49 = "arith.mulf"(%arg7, %arg8) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
      "linalg.yield"(%49) : (bf16) -> ()
    }) : (tensor<1x512xbf16>, tensor<1x512xbf16>, tensor<1x512xbf16>) -> tensor<1x512xbf16>
    %46 = "tensor.collapse_shape"(%45) <{reassociation = [[0, 1]]}> : (tensor<1x512xbf16>) -> tensor<512xbf16>
    %47 = "tensor.extract_slice"(%46, %30) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<512xbf16>, index) -> tensor<?xbf16>
    %48 = "memref.subview"(%arg2, %31, %30) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%47, %48) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

