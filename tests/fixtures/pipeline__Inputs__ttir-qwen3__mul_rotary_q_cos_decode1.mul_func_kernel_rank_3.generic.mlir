#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32) -> (), sym_name = "mul_func_kernel_rank_3"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xbf16>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %1 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %3 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 63 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %8 = "arith.constant"() <{value = 4096 : i64}> : () -> i64
    %9 = "arith.constant"() <{value = 128 : i64}> : () -> i64
    %10 = "arith.constant"() <{value = 2048 : i64}> : () -> i64
    %11 = "arith.constant"() <{value = 8 : index}> : () -> index
    %12 = "arith.constant"() <{value = 1 : index}> : () -> index
    %13 = "arith.constant"() <{value = 0 : index}> : () -> index
    %14 = "arith.constant"() <{value = 64 : index}> : () -> index
    %15 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %16 = "arith.index_cast"(%15) : (index) -> i32
    %17 = "arith.extsi"(%16) : (i32) -> i64
    %18 = "arith.addi"(%arg3, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %19 = "arith.divsi"(%18, %3) : (i32, i32) -> i32
    %20 = "arith.addi"(%arg4, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %21 = "arith.divsi"(%20, %5) : (i32, i32) -> i32
    %22 = "arith.extsi"(%21) : (i32) -> i64
    %23 = "arith.remsi"(%17, %22) : (i64, i64) -> i64
    %24 = "arith.divsi"(%17, %22) : (i64, i64) -> i64
    %25 = "arith.extsi"(%19) : (i32) -> i64
    %26 = "arith.remsi"(%24, %25) : (i64, i64) -> i64
    %27 = "arith.divsi"(%24, %25) : (i64, i64) -> i64
    %28 = "arith.muli"(%26, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %29 = "arith.index_cast"(%28) : (i64) -> index
    %30 = "arith.muli"(%23, %2) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %31 = "arith.index_cast"(%30) : (i64) -> index
    %32 = "arith.cmpi"(%27, %7) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %33 = "arith.muli"(%27, %8) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %34 = "arith.index_cast"(%33) : (i64) -> index
    %35 = "arith.addi"(%29, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %36 = "arith.index_cast"(%arg3) : (i32) -> index
    %37 = "arith.minsi"(%35, %36) : (index, index) -> index
    %38 = "arith.maxsi"(%37, %29) : (index, index) -> index
    %39 = "arith.subi"(%38, %29) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %40 = "arith.select"(%32, %12, %13) : (i1, index, index) -> index
    %41 = "arith.select"(%32, %39, %13) : (i1, index, index) -> index
    %42 = "arith.addi"(%31, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %43 = "arith.index_cast"(%arg4) : (i32) -> index
    %44 = "arith.minsi"(%42, %43) : (index, index) -> index
    %45 = "arith.maxsi"(%44, %31) : (index, index) -> index
    %46 = "arith.subi"(%45, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %47 = "arith.minsi"(%40, %12) : (index, index) -> index
    %48 = "arith.minsi"(%41, %11) : (index, index) -> index
    %49 = "arith.minsi"(%46, %14) : (index, index) -> index
    %50 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>
    %51 = "arith.muli"(%48, %47) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %52 = "arith.addi"(%31, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %53 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xbf16>
    "linalg.fill"(%0, %53) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: bf16, %arg17: bf16):
      "linalg.yield"(%arg16) : (bf16) -> ()
    }) : (bf16, memref<8x64xbf16>) -> ()
    %54 = "memref.subview"(%50, %29, %52, %51, %49) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[128, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[128, 1], offset: ?>>
    %55 = "memref.subview"(%53, %51, %49) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xbf16>, index, index) -> memref<?x?xbf16, strided<[64, 1]>>
    "linalg.copy"(%54, %55) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: bf16, %arg15: bf16):
      "linalg.yield"(%arg14) : (bf16) -> ()
    }) : (memref<?x?xbf16, strided<[128, 1], offset: ?>>, memref<?x?xbf16, strided<[64, 1]>>) -> ()
    %56 = "bufferization.to_tensor"(%53) <{restrict, writable}> : (memref<8x64xbf16>) -> tensor<8x64xbf16>
    %57 = "tensor.expand_shape"(%56) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 8, 64>}> : (tensor<8x64xbf16>) -> tensor<1x8x64xbf16>
    %58 = "arith.muli"(%27, %9) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %59 = "arith.index_cast"(%58) : (i64) -> index
    %60 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 0, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[0, 1]>>
    %61 = "arith.addi"(%31, %59) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %62 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xbf16>
    "linalg.fill"(%0, %62) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: bf16, %arg13: bf16):
      "linalg.yield"(%arg12) : (bf16) -> ()
    }) : (bf16, memref<8x64xbf16>) -> ()
    %63 = "memref.subview"(%60, %61, %51, %49) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[0, 1]>>, index, index, index) -> memref<?x?xbf16, strided<[0, 1], offset: ?>>
    %64 = "memref.subview"(%62, %51, %49) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<8x64xbf16>, index, index) -> memref<?x?xbf16, strided<[64, 1]>>
    "linalg.copy"(%63, %64) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: bf16, %arg11: bf16):
      "linalg.yield"(%arg10) : (bf16) -> ()
    }) : (memref<?x?xbf16, strided<[0, 1], offset: ?>>, memref<?x?xbf16, strided<[64, 1]>>) -> ()
    %65 = "bufferization.to_tensor"(%62) <{restrict, writable}> : (memref<8x64xbf16>) -> tensor<8x64xbf16>
    %66 = "tensor.expand_shape"(%65) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 1, 8, 64>}> : (tensor<8x64xbf16>) -> tensor<1x8x64xbf16>
    %67 = "linalg.generic"(%57, %66, %57) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg7: bf16, %arg8: bf16, %arg9: bf16):
      %75 = "arith.mulf"(%arg7, %arg8) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
      "linalg.yield"(%75) : (bf16) -> ()
    }) : (tensor<1x8x64xbf16>, tensor<1x8x64xbf16>, tensor<1x8x64xbf16>) -> tensor<1x8x64xbf16>
    %68 = "arith.muli"(%27, %10) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %69 = "arith.index_cast"(%68) : (i64) -> index
    %70 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 64, 1>}> : (memref<?xbf16>) -> memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>
    %71 = "tensor.collapse_shape"(%67) <{reassociation = [[0, 1], [2]]}> : (tensor<1x8x64xbf16>) -> tensor<8x64xbf16>
    %72 = "arith.addi"(%31, %69) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %73 = "tensor.extract_slice"(%71, %51, %49) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<8x64xbf16>, index, index) -> tensor<?x?xbf16>
    %74 = "memref.subview"(%70, %29, %72, %51, %49) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[64, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[64, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%73, %74) <{writable}> : (tensor<?x?xbf16>, memref<?x?xbf16, strided<[64, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

