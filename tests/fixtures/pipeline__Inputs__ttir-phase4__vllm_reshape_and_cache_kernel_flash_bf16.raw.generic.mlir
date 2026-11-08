#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, memref<?xi64>, memref<?xf32>, memref<?xf32>, i64, i64, i64, i64, i64, i64, i64) -> (), sym_name = "reshape_and_cache_kernel_flash"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xi64>, %arg5: memref<?xf32>, %arg6: memref<?xf32>, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64, %arg13: i64):
    %0 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %1 = "arith.constant"() <{value = 1024 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %3 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %4 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 16 : i64}> : () -> i64
    %6 = "builtin.unrealized_conversion_cast"(%arg3) : (memref<?xbf16>) -> !tt.ptr<bf16>
    %7 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<?xbf16>) -> !tt.ptr<bf16>
    %8 = "tensor.empty"() : () -> tensor<1024xi32>
    %9 = "linalg.fill"(%1, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg56: i32, %arg57: i32):
      "linalg.yield"(%arg56) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %10 = "linalg.fill"(%4, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg54: i32, %arg55: i32):
      "linalg.yield"(%arg54) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %11 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %12 = "arith.index_cast"(%11) : (index) -> i32
    %13 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
    %14 = "memref.load"(%13, %11) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
    %15 = "arith.cmpi"(%14, %2) <{predicate = 2 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%15)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    %16 = "arith.divsi"(%14, %5) : (i64, i64) -> i64
    %17 = "arith.remsi"(%14, %5) : (i64, i64) -> i64
    %18 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %19 = "arith.index_cast"(%18) : (index) -> i32
    %20 = "linalg.generic"(%8) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg53: i32):
      %68 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %69 = "arith.index_cast"(%68) : (index) -> i32
      "linalg.yield"(%69) : (i32) -> ()
    }) : (tensor<1024xi32>) -> tensor<1024xi32>
    %21 = "arith.muli"(%19, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %22 = "arith.index_cast"(%21) : (i32) -> index
    %23 = "linalg.fill"(%21, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg51: i32, %arg52: i32):
      "linalg.yield"(%arg51) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %24 = "linalg.generic"(%23, %20, %23) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg48: i32, %arg49: i32, %arg50: i32):
      %67 = "arith.addi"(%arg48, %arg49) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%67) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %25 = "arith.extsi"(%12) : (i32) -> i64
    %26 = "arith.muli"(%25, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %27 = "arith.index_cast"(%26) : (i64) -> index
    %28 = "arith.muli"(%25, %arg8) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %29 = "arith.index_cast"(%28) : (i64) -> index
    %30 = "linalg.generic"(%24, %10, %24) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg45: i32, %arg46: i32, %arg47: i32):
      %66 = "arith.divsi"(%arg45, %arg46) : (i32, i32) -> i32
      "linalg.yield"(%66) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %31 = "linalg.generic"(%24, %10, %24) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg42: i32, %arg43: i32, %arg44: i32):
      %65 = "arith.remsi"(%arg42, %arg43) : (i32, i32) -> i32
      "linalg.yield"(%65) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %32 = "arith.muli"(%16, %arg9) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %33 = "arith.muli"(%17, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %34 = "arith.addi"(%32, %33) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %35 = "tensor.empty"() : () -> tensor<1024xi64>
    %36 = "linalg.generic"(%30, %35) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg40: i32, %arg41: i64):
      %64 = "arith.extsi"(%arg40) : (i32) -> i64
      "linalg.yield"(%64) : (i64) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi64>) -> tensor<1024xi64>
    %37 = "linalg.fill"(%arg10, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg38: i64, %arg39: i64):
      "linalg.yield"(%arg38) : (i64) -> ()
    }) : (i64, tensor<1024xi64>) -> tensor<1024xi64>
    %38 = "linalg.generic"(%36, %37, %36) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg35: i64, %arg36: i64, %arg37: i64):
      %63 = "arith.muli"(%arg35, %arg36) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "linalg.yield"(%63) : (i64) -> ()
    }) : (tensor<1024xi64>, tensor<1024xi64>, tensor<1024xi64>) -> tensor<1024xi64>
    %39 = "linalg.fill"(%34, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg33: i64, %arg34: i64):
      "linalg.yield"(%arg33) : (i64) -> ()
    }) : (i64, tensor<1024xi64>) -> tensor<1024xi64>
    %40 = "linalg.generic"(%39, %38, %39) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg30: i64, %arg31: i64, %arg32: i64):
      %62 = "arith.addi"(%arg30, %arg31) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "linalg.yield"(%62) : (i64) -> ()
    }) : (tensor<1024xi64>, tensor<1024xi64>, tensor<1024xi64>) -> tensor<1024xi64>
    %41 = "linalg.generic"(%31, %35) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg28: i32, %arg29: i64):
      %61 = "arith.extsi"(%arg28) : (i32) -> i64
      "linalg.yield"(%61) : (i64) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi64>) -> tensor<1024xi64>
    %42 = "linalg.generic"(%40, %41, %40) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg25: i64, %arg26: i64, %arg27: i64):
      %60 = "arith.addi"(%arg25, %arg26) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "linalg.yield"(%60) : (i64) -> ()
    }) : (tensor<1024xi64>, tensor<1024xi64>, tensor<1024xi64>) -> tensor<1024xi64>
    %43 = "arith.addi"(%22, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %44 = "arith.minsi"(%43, %3) : (index, index) -> index
    %45 = "arith.maxsi"(%44, %22) : (index, index) -> index
    %46 = "arith.subi"(%45, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %47 = "arith.addi"(%27, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %48 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
    "linalg.fill"(%0, %48) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: bf16, %arg24: bf16):
      "linalg.yield"(%arg23) : (bf16) -> ()
    }) : (bf16, memref<1024xbf16>) -> ()
    %49 = "memref.subview"(%arg0, %47, %46) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %50 = "memref.subview"(%48, %46) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%49, %50) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: bf16, %arg22: bf16):
      "linalg.yield"(%arg21) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %51 = "bufferization.to_tensor"(%48) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
    %52 = "arith.addi"(%29, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %53 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
    "linalg.fill"(%0, %53) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: bf16, %arg20: bf16):
      "linalg.yield"(%arg19) : (bf16) -> ()
    }) : (bf16, memref<1024xbf16>) -> ()
    %54 = "memref.subview"(%arg1, %52, %46) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %55 = "memref.subview"(%53, %46) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%54, %55) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: bf16, %arg18: bf16):
      "linalg.yield"(%arg17) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %56 = "bufferization.to_tensor"(%53) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
    %57 = "tensor.empty"() : () -> tensor<1024xi1>
    %58 = "linalg.generic"(%24, %9, %57) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg14: i32, %arg15: i32, %arg16: i1):
      %59 = "arith.cmpi"(%arg14, %arg15) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%59) : (i1) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi1>) -> tensor<1024xi1>
    "tts.scatter"(%7, %42, %51, %58) : (!tt.ptr<bf16>, tensor<1024xi64>, tensor<1024xbf16>, tensor<1024xi1>) -> ()
    "tts.scatter"(%6, %42, %56, %58) : (!tt.ptr<bf16>, tensor<1024xi64>, tensor<1024xbf16>, tensor<1024xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

