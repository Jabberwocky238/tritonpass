#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> (0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, f32) -> (), sym_name = "_rms_norm_kernel"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xbf16>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: f32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %4 = "arith.constant"() <{value = 1.000000e+00 : bf16}> : () -> bf16
    %5 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %7 = "tensor.empty"() : () -> tensor<1xf32>
    %8 = "linalg.fill"(%0, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg84: f32, %arg85: f32):
      "linalg.yield"(%arg84) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %9 = "linalg.fill"(%6, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg82: f32, %arg83: f32):
      "linalg.yield"(%arg82) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %10 = "tensor.empty"() : () -> tensor<1024xf32>
    %11 = "linalg.fill"(%0, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg80: f32, %arg81: f32):
      "linalg.yield"(%arg80) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %12 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %13 = "arith.index_cast"(%12) : (index) -> i32
    %14 = "arith.extsi"(%13) : (i32) -> i64
    %15 = "arith.extsi"(%arg3) : (i32) -> i64
    %16 = "arith.muli"(%14, %15) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %17 = "arith.index_cast"(%16) : (i64) -> index
    %18 = "arith.extsi"(%arg4) : (i32) -> i64
    %19 = "arith.muli"(%14, %18) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %20 = "arith.index_cast"(%19) : (i64) -> index
    %21 = "tensor.empty"() : () -> tensor<1024xi32>
    %22 = "linalg.generic"(%21) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg79: i32):
      %99 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %100 = "arith.index_cast"(%99) : (index) -> i32
      "linalg.yield"(%100) : (i32) -> ()
    }) : (tensor<1024xi32>) -> tensor<1024xi32>
    %23 = "arith.index_cast"(%arg5) : (i32) -> index
    %24 = "scf.for"(%1, %23, %2, %8) ({
    ^bb0(%arg45: index, %arg46: tensor<1xf32>):
      %64 = "arith.index_cast"(%arg45) : (index) -> i32
      %65 = "arith.addi"(%arg45, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %66 = "arith.minsi"(%65, %23) : (index, index) -> index
      %67 = "arith.maxsi"(%66, %arg45) : (index, index) -> index
      %68 = "arith.subi"(%67, %arg45) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %69 = "arith.addi"(%17, %arg45) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %70 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
      "linalg.fill"(%3, %70) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg77: bf16, %arg78: bf16):
        "linalg.yield"(%arg77) : (bf16) -> ()
      }) : (bf16, memref<1024xbf16>) -> ()
      %71 = "memref.subview"(%arg0, %69, %68) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %72 = "memref.subview"(%70, %68) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%71, %72) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg75: bf16, %arg76: bf16):
        "linalg.yield"(%arg75) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %73 = "bufferization.to_tensor"(%70) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
      %74 = "linalg.generic"(%73, %10) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg73: bf16, %arg74: f32):
        %98 = "arith.extf"(%arg73) : (bf16) -> f32
        "linalg.yield"(%98) : (f32) -> ()
      }) : (tensor<1024xbf16>, tensor<1024xf32>) -> tensor<1024xf32>
      %75 = "linalg.generic"(%74, %74, %74) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg70: f32, %arg71: f32, %arg72: f32):
        %97 = "arith.mulf"(%arg70, %arg71) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%97) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %76 = "arith.subi"(%64, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %77 = "linalg.generic"(%22, %10) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg68: i32, %arg69: f32):
        %96 = "arith.sitofp"(%arg68) : (i32) -> f32
        "linalg.yield"(%96) : (f32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xf32>) -> tensor<1024xf32>
      %78 = "linalg.generic"(%77, %11, %77) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg65: f32, %arg66: f32, %arg67: f32):
        %95 = "arith.addf"(%arg65, %arg66) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%95) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %79 = "arith.subi"(%5, %76) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %80 = "arith.sitofp"(%79) : (i32) -> f32
      %81 = "linalg.fill"(%80, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg63: f32, %arg64: f32):
        "linalg.yield"(%arg63) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %82 = "tensor.empty"() : () -> tensor<1024xi1>
      %83 = "linalg.generic"(%78, %81, %82) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg60: f32, %arg61: f32, %arg62: i1):
        %94 = "arith.cmpf"(%arg60, %arg61) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%94) : (i1) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xi1>) -> tensor<1024xi1>
      %84 = "linalg.generic"(%83, %75, %11, %75) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg56: i1, %arg57: f32, %arg58: f32, %arg59: f32):
        %93 = "arith.select"(%arg56, %arg57, %arg58) : (i1, f32, f32) -> f32
        "linalg.yield"(%93) : (f32) -> ()
      }) : (tensor<1024xi1>, tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %85 = "tensor.empty"() : () -> tensor<f32>
      %86 = "linalg.fill"(%0, %85) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg54: f32, %arg55: f32):
        "linalg.yield"(%arg54) : (f32) -> ()
      }) : (f32, tensor<f32>) -> tensor<f32>
      %87 = "linalg.reduce"(%84, %86) <{dimensions = array<i64: 0>}> ({
      ^bb0(%arg52: f32, %arg53: f32):
        %92 = "arith.addf"(%arg52, %arg53) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%92) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<f32>) -> tensor<f32>
      %88 = "tensor.extract"(%87) : (tensor<f32>) -> f32
      %89 = "linalg.fill"(%88, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg50: f32, %arg51: f32):
        "linalg.yield"(%arg50) : (f32) -> ()
      }) : (f32, tensor<1xf32>) -> tensor<1xf32>
      %90 = "linalg.generic"(%arg46, %89, %arg46) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg47: f32, %arg48: f32, %arg49: f32):
        %91 = "arith.addf"(%arg47, %arg48) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%91) : (f32) -> ()
      }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
      "scf.yield"(%90) : (tensor<1xf32>) -> ()
    }) : (index, index, index, tensor<1xf32>) -> tensor<1xf32>
    %25 = "arith.sitofp"(%arg5) : (i32) -> f32
    %26 = "linalg.fill"(%25, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg43: f32, %arg44: f32):
      "linalg.yield"(%arg43) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %27 = "linalg.generic"(%24, %26, %24) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg40: f32, %arg41: f32, %arg42: f32):
      %63 = "arith.divf"(%arg40, %arg41) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%63) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %28 = "linalg.fill"(%arg6, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg38: f32, %arg39: f32):
      "linalg.yield"(%arg38) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %29 = "linalg.generic"(%27, %28, %27) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg35: f32, %arg36: f32, %arg37: f32):
      %62 = "arith.addf"(%arg35, %arg36) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%62) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %30 = "linalg.generic"(%29, %29) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg33: f32, %arg34: f32):
      %61 = "math.sqrt"(%arg33) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%61) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %31 = "linalg.generic"(%9, %30, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg30: f32, %arg31: f32, %arg32: f32):
      %60 = "arith.divf"(%arg30, %arg31) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%60) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %32 = "linalg.generic"(%31, %10) <{indexing_maps = [#map1, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg28: f32, %arg29: f32):
      "linalg.yield"(%arg28) : (f32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    "scf.for"(%1, %23, %2) ({
    ^bb0(%arg7: index):
      %33 = "arith.addi"(%arg7, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %34 = "arith.minsi"(%33, %23) : (index, index) -> index
      %35 = "arith.maxsi"(%34, %arg7) : (index, index) -> index
      %36 = "arith.subi"(%35, %arg7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %37 = "arith.addi"(%17, %arg7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %38 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
      "linalg.fill"(%3, %38) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg26: bf16, %arg27: bf16):
        "linalg.yield"(%arg26) : (bf16) -> ()
      }) : (bf16, memref<1024xbf16>) -> ()
      %39 = "memref.subview"(%arg0, %37, %36) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %40 = "memref.subview"(%38, %36) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%39, %40) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg24: bf16, %arg25: bf16):
        "linalg.yield"(%arg24) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %41 = "bufferization.to_tensor"(%38) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
      %42 = "linalg.generic"(%41, %10) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg22: bf16, %arg23: f32):
        %59 = "arith.extf"(%arg22) : (bf16) -> f32
        "linalg.yield"(%59) : (f32) -> ()
      }) : (tensor<1024xbf16>, tensor<1024xf32>) -> tensor<1024xf32>
      %43 = "linalg.generic"(%42, %32, %42) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg19: f32, %arg20: f32, %arg21: f32):
        %58 = "arith.mulf"(%arg19, %arg20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%58) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %44 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
      "linalg.fill"(%4, %44) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg17: bf16, %arg18: bf16):
        "linalg.yield"(%arg17) : (bf16) -> ()
      }) : (bf16, memref<1024xbf16>) -> ()
      %45 = "memref.subview"(%arg1, %arg7, %36) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %46 = "memref.subview"(%44, %36) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%45, %46) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg15: bf16, %arg16: bf16):
        "linalg.yield"(%arg15) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %47 = "bufferization.to_tensor"(%44) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
      %48 = "linalg.generic"(%47, %10) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg13: bf16, %arg14: f32):
        %57 = "arith.extf"(%arg13) : (bf16) -> f32
        "linalg.yield"(%57) : (f32) -> ()
      }) : (tensor<1024xbf16>, tensor<1024xf32>) -> tensor<1024xf32>
      %49 = "linalg.generic"(%43, %48, %43) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg10: f32, %arg11: f32, %arg12: f32):
        %56 = "arith.mulf"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%56) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %50 = "tensor.empty"() : () -> tensor<1024xbf16>
      %51 = "linalg.generic"(%49, %50) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg8: f32, %arg9: bf16):
        %55 = "arith.truncf"(%arg8) : (f32) -> bf16
        "linalg.yield"(%55) : (bf16) -> ()
      }) : (tensor<1024xf32>, tensor<1024xbf16>) -> tensor<1024xbf16>
      %52 = "arith.addi"(%20, %arg7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %53 = "tensor.extract_slice"(%51, %36) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xbf16>, index) -> tensor<?xbf16>
      %54 = "memref.subview"(%arg2, %52, %36) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%53, %54) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

