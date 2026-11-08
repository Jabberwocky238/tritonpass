#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32, i32) -> (), sym_name = "mul_func_kernel_rank_3"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xbf16>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %1 = "arith.constant"() <{value = 4 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 128 : i64}> : () -> i64
    %3 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 127 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 4096 : i64}> : () -> i64
    %8 = "arith.constant"() <{value = 128 : index}> : () -> index
    %9 = "arith.constant"() <{value = 4 : index}> : () -> index
    %10 = "arith.constant"() <{value = 1 : index}> : () -> index
    %11 = "arith.constant"() <{value = 0 : index}> : () -> index
    %12 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %13 = "arith.index_cast"(%12) : (index) -> i32
    %14 = "arith.extsi"(%13) : (i32) -> i64
    %15 = "arith.addi"(%arg4, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %16 = "arith.divsi"(%15, %3) : (i32, i32) -> i32
    %17 = "arith.addi"(%arg5, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %18 = "arith.divsi"(%17, %5) : (i32, i32) -> i32
    %19 = "arith.extsi"(%18) : (i32) -> i64
    %20 = "arith.remsi"(%14, %19) : (i64, i64) -> i64
    %21 = "arith.divsi"(%14, %19) : (i64, i64) -> i64
    %22 = "arith.extsi"(%16) : (i32) -> i64
    %23 = "arith.remsi"(%21, %22) : (i64, i64) -> i64
    %24 = "arith.divsi"(%21, %22) : (i64, i64) -> i64
    %25 = "arith.muli"(%23, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %26 = "arith.index_cast"(%25) : (i64) -> index
    %27 = "arith.muli"(%20, %2) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %28 = "arith.index_cast"(%27) : (i64) -> index
    %29 = "arith.extsi"(%arg3) : (i32) -> i64
    %30 = "arith.cmpi"(%24, %29) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %31 = "arith.muli"(%24, %7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %32 = "arith.index_cast"(%31) : (i64) -> index
    %33 = "arith.addi"(%26, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %34 = "arith.index_cast"(%arg4) : (i32) -> index
    %35 = "arith.minsi"(%33, %34) : (index, index) -> index
    %36 = "arith.maxsi"(%35, %26) : (index, index) -> index
    %37 = "arith.subi"(%36, %26) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %38 = "arith.select"(%30, %10, %11) : (i1, index, index) -> index
    %39 = "arith.select"(%30, %37, %11) : (i1, index, index) -> index
    %40 = "arith.addi"(%28, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %41 = "arith.index_cast"(%arg5) : (i32) -> index
    %42 = "arith.minsi"(%40, %41) : (index, index) -> index
    %43 = "arith.maxsi"(%42, %28) : (index, index) -> index
    %44 = "arith.subi"(%43, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %45 = "arith.minsi"(%38, %10) : (index, index) -> index
    %46 = "arith.minsi"(%39, %9) : (index, index) -> index
    %47 = "arith.minsi"(%44, %8) : (index, index) -> index
    %48 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>
    %49 = "arith.muli"(%46, %45) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %50 = "arith.addi"(%28, %32) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %51 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x128xbf16>
    "linalg.fill"(%0, %51) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: bf16, %arg18: bf16):
      "linalg.yield"(%arg17) : (bf16) -> ()
    }) : (bf16, memref<4x128xbf16>) -> ()
    %52 = "memref.subview"(%48, %26, %50, %49, %47) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[128, 1], offset: ?>>
    %53 = "memref.subview"(%51, %49, %47) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<4x128xbf16>, index, index) -> memref<?x?xbf16, strided<[128, 1]>>
    "linalg.copy"(%52, %53) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: bf16, %arg16: bf16):
      "linalg.yield"(%arg15) : (bf16) -> ()
    }) : (memref<?x?xbf16, strided<[128, 1], offset: ?>>, memref<?x?xbf16, strided<[128, 1]>>) -> ()
    %54 = "bufferization.to_tensor"(%51) <{restrict, writable}> : (memref<4x128xbf16>) -> tensor<4x128xbf16>
    %55 = "tensor.expand_shape"(%54) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 4, 128>}> : (tensor<4x128xbf16>) -> tensor<1x4x128xbf16>
    %56 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 0, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[0, 1]>>
    %57 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x128xbf16>
    "linalg.fill"(%0, %57) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: bf16, %arg14: bf16):
      "linalg.yield"(%arg13) : (bf16) -> ()
    }) : (bf16, memref<4x128xbf16>) -> ()
    %58 = "memref.subview"(%56, %28, %49, %47) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[0, 1]>>, index, index, index) -> memref<?x?xbf16, strided<[0, 1], offset: ?>>
    %59 = "memref.subview"(%57, %49, %47) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<4x128xbf16>, index, index) -> memref<?x?xbf16, strided<[128, 1]>>
    "linalg.copy"(%58, %59) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: bf16, %arg12: bf16):
      "linalg.yield"(%arg11) : (bf16) -> ()
    }) : (memref<?x?xbf16, strided<[0, 1], offset: ?>>, memref<?x?xbf16, strided<[128, 1]>>) -> ()
    %60 = "bufferization.to_tensor"(%57) <{restrict, writable}> : (memref<4x128xbf16>) -> tensor<4x128xbf16>
    %61 = "tensor.expand_shape"(%60) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 4, 128>}> : (tensor<4x128xbf16>) -> tensor<1x4x128xbf16>
    %62 = "linalg.generic"(%55, %61, %55) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg8: bf16, %arg9: bf16, %arg10: bf16):
      %67 = "arith.mulf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
      "linalg.yield"(%67) : (bf16) -> ()
    }) : (tensor<1x4x128xbf16>, tensor<1x4x128xbf16>, tensor<1x4x128xbf16>) -> tensor<1x4x128xbf16>
    %63 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>
    %64 = "tensor.collapse_shape"(%62) <{reassociation = [[0, 1], [2]]}> : (tensor<1x4x128xbf16>) -> tensor<4x128xbf16>
    %65 = "tensor.extract_slice"(%64, %49, %47) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<4x128xbf16>, index, index) -> tensor<?x?xbf16>
    %66 = "memref.subview"(%63, %26, %50, %49, %47) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[128, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%65, %66) <{writable}> : (tensor<?x?xbf16>, memref<?x?xbf16, strided<[128, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

