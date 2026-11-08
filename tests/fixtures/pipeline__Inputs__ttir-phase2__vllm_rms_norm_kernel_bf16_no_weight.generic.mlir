#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> (0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, f32) -> (), sym_name = "_rms_norm_kernel"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xbf16>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: f32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %4 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %6 = "tensor.empty"() : () -> tensor<1xf32>
    %7 = "linalg.fill"(%0, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg75: f32, %arg76: f32):
      "linalg.yield"(%arg75) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %8 = "linalg.fill"(%5, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg73: f32, %arg74: f32):
      "linalg.yield"(%arg73) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %9 = "tensor.empty"() : () -> tensor<1024xf32>
    %10 = "linalg.fill"(%0, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg71: f32, %arg72: f32):
      "linalg.yield"(%arg71) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %11 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %12 = "arith.index_cast"(%11) : (index) -> i32
    %13 = "arith.extsi"(%12) : (i32) -> i64
    %14 = "arith.extsi"(%arg3) : (i32) -> i64
    %15 = "arith.muli"(%13, %14) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %16 = "arith.index_cast"(%15) : (i64) -> index
    %17 = "arith.extsi"(%arg4) : (i32) -> i64
    %18 = "arith.muli"(%13, %17) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %19 = "arith.index_cast"(%18) : (i64) -> index
    %20 = "tensor.empty"() : () -> tensor<1024xi32>
    %21 = "linalg.generic"(%20) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg70: i32):
      %90 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %91 = "arith.index_cast"(%90) : (index) -> i32
      "linalg.yield"(%91) : (i32) -> ()
    }) : (tensor<1024xi32>) -> tensor<1024xi32>
    %22 = "arith.index_cast"(%arg5) : (i32) -> index
    %23 = "scf.for"(%1, %22, %2, %7) ({
    ^bb0(%arg36: index, %arg37: tensor<1xf32>):
      %55 = "arith.index_cast"(%arg36) : (index) -> i32
      %56 = "arith.addi"(%arg36, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %57 = "arith.minsi"(%56, %22) : (index, index) -> index
      %58 = "arith.maxsi"(%57, %arg36) : (index, index) -> index
      %59 = "arith.subi"(%58, %arg36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %60 = "arith.addi"(%16, %arg36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %61 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
      "linalg.fill"(%3, %61) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg68: bf16, %arg69: bf16):
        "linalg.yield"(%arg68) : (bf16) -> ()
      }) : (bf16, memref<1024xbf16>) -> ()
      %62 = "memref.subview"(%arg0, %60, %59) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %63 = "memref.subview"(%61, %59) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%62, %63) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg66: bf16, %arg67: bf16):
        "linalg.yield"(%arg66) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %64 = "bufferization.to_tensor"(%61) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
      %65 = "linalg.generic"(%64, %9) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg64: bf16, %arg65: f32):
        %89 = "arith.extf"(%arg64) : (bf16) -> f32
        "linalg.yield"(%89) : (f32) -> ()
      }) : (tensor<1024xbf16>, tensor<1024xf32>) -> tensor<1024xf32>
      %66 = "linalg.generic"(%65, %65, %65) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg61: f32, %arg62: f32, %arg63: f32):
        %88 = "arith.mulf"(%arg61, %arg62) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%88) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %67 = "arith.subi"(%55, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %68 = "linalg.generic"(%21, %9) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg59: i32, %arg60: f32):
        %87 = "arith.sitofp"(%arg59) : (i32) -> f32
        "linalg.yield"(%87) : (f32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xf32>) -> tensor<1024xf32>
      %69 = "linalg.generic"(%68, %10, %68) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg56: f32, %arg57: f32, %arg58: f32):
        %86 = "arith.addf"(%arg56, %arg57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%86) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %70 = "arith.subi"(%4, %67) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %71 = "arith.sitofp"(%70) : (i32) -> f32
      %72 = "linalg.fill"(%71, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg54: f32, %arg55: f32):
        "linalg.yield"(%arg54) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %73 = "tensor.empty"() : () -> tensor<1024xi1>
      %74 = "linalg.generic"(%69, %72, %73) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg51: f32, %arg52: f32, %arg53: i1):
        %85 = "arith.cmpf"(%arg51, %arg52) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%85) : (i1) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xi1>) -> tensor<1024xi1>
      %75 = "linalg.generic"(%74, %66, %10, %66) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg47: i1, %arg48: f32, %arg49: f32, %arg50: f32):
        %84 = "arith.select"(%arg47, %arg48, %arg49) : (i1, f32, f32) -> f32
        "linalg.yield"(%84) : (f32) -> ()
      }) : (tensor<1024xi1>, tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %76 = "tensor.empty"() : () -> tensor<f32>
      %77 = "linalg.fill"(%0, %76) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg45: f32, %arg46: f32):
        "linalg.yield"(%arg45) : (f32) -> ()
      }) : (f32, tensor<f32>) -> tensor<f32>
      %78 = "linalg.reduce"(%75, %77) <{dimensions = array<i64: 0>}> ({
      ^bb0(%arg43: f32, %arg44: f32):
        %83 = "arith.addf"(%arg43, %arg44) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%83) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<f32>) -> tensor<f32>
      %79 = "tensor.extract"(%78) : (tensor<f32>) -> f32
      %80 = "linalg.fill"(%79, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg41: f32, %arg42: f32):
        "linalg.yield"(%arg41) : (f32) -> ()
      }) : (f32, tensor<1xf32>) -> tensor<1xf32>
      %81 = "linalg.generic"(%arg37, %80, %arg37) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg38: f32, %arg39: f32, %arg40: f32):
        %82 = "arith.addf"(%arg38, %arg39) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%82) : (f32) -> ()
      }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
      "scf.yield"(%81) : (tensor<1xf32>) -> ()
    }) : (index, index, index, tensor<1xf32>) -> tensor<1xf32>
    %24 = "arith.sitofp"(%arg5) : (i32) -> f32
    %25 = "linalg.fill"(%24, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg34: f32, %arg35: f32):
      "linalg.yield"(%arg34) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %26 = "linalg.generic"(%23, %25, %23) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg31: f32, %arg32: f32, %arg33: f32):
      %54 = "arith.divf"(%arg31, %arg32) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%54) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %27 = "linalg.fill"(%arg6, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: f32, %arg30: f32):
      "linalg.yield"(%arg29) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %28 = "linalg.generic"(%26, %27, %26) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: f32, %arg27: f32, %arg28: f32):
      %53 = "arith.addf"(%arg26, %arg27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%53) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %29 = "linalg.generic"(%28, %28) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: f32, %arg25: f32):
      %52 = "math.sqrt"(%arg24) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%52) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %30 = "linalg.generic"(%8, %29, %8) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: f32, %arg22: f32, %arg23: f32):
      %51 = "arith.divf"(%arg21, %arg22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%51) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %31 = "linalg.generic"(%30, %9) <{indexing_maps = [#map1, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32):
      "linalg.yield"(%arg19) : (f32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    "scf.for"(%1, %22, %2) ({
    ^bb0(%arg7: index):
      %32 = "arith.addi"(%arg7, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %33 = "arith.minsi"(%32, %22) : (index, index) -> index
      %34 = "arith.maxsi"(%33, %arg7) : (index, index) -> index
      %35 = "arith.subi"(%34, %arg7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %36 = "arith.addi"(%16, %arg7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %37 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
      "linalg.fill"(%3, %37) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg17: bf16, %arg18: bf16):
        "linalg.yield"(%arg17) : (bf16) -> ()
      }) : (bf16, memref<1024xbf16>) -> ()
      %38 = "memref.subview"(%arg0, %36, %35) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %39 = "memref.subview"(%37, %35) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%38, %39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg15: bf16, %arg16: bf16):
        "linalg.yield"(%arg15) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %40 = "bufferization.to_tensor"(%37) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
      %41 = "linalg.generic"(%40, %9) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg13: bf16, %arg14: f32):
        %50 = "arith.extf"(%arg13) : (bf16) -> f32
        "linalg.yield"(%50) : (f32) -> ()
      }) : (tensor<1024xbf16>, tensor<1024xf32>) -> tensor<1024xf32>
      %42 = "linalg.generic"(%41, %31, %41) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg10: f32, %arg11: f32, %arg12: f32):
        %49 = "arith.mulf"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%49) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %43 = "tensor.empty"() : () -> tensor<1024xbf16>
      %44 = "linalg.generic"(%42, %43) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg8: f32, %arg9: bf16):
        %48 = "arith.truncf"(%arg8) : (f32) -> bf16
        "linalg.yield"(%48) : (bf16) -> ()
      }) : (tensor<1024xf32>, tensor<1024xbf16>) -> tensor<1024xbf16>
      %45 = "arith.addi"(%19, %arg7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %46 = "tensor.extract_slice"(%44, %35) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xbf16>, index) -> tensor<?xbf16>
      %47 = "memref.subview"(%arg2, %45, %35) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%46, %47) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

