#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> (0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, f32) -> (), sym_name = "_rms_norm_kernel"}> ({
  ^bb0(%arg7: memref<?xbf16>, %arg8: memref<?xbf16>, %arg9: memref<?xbf16>, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: f32):
    %6 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 0 : index}> : () -> index
    %8 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %9 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %10 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %11 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %12 = "tensor.empty"() : () -> tensor<1xf32>
    %13 = "linalg.fill"(%6, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg76: f32, %arg77: f32):
      "linalg.yield"(%arg76) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %14 = "tensor.empty"() : () -> tensor<1024xf32>
    %15 = "linalg.fill"(%11, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg74: f32, %arg75: f32):
      "linalg.yield"(%arg74) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %16 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %17 = "arith.index_cast"(%16) : (index) -> i32
    %18 = "arith.extsi"(%17) : (i32) -> i64
    %19 = "arith.extsi"(%arg10) : (i32) -> i64
    %20 = "arith.muli"(%18, %19) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %21 = "arith.index_cast"(%20) : (i64) -> index
    %22 = "arith.extsi"(%arg11) : (i32) -> i64
    %23 = "arith.muli"(%18, %22) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %24 = "arith.index_cast"(%23) : (i64) -> index
    %25 = "func.call"() <{callee = @triton.language.standard.zeros__Tc1T_cfp32}> : () -> tensor<1xf32>
    %26 = "arith.index_cast"(%arg12) : (i32) -> index
    %27 = "scf.for"(%7, %26, %8, %25) ({
    ^bb0(%arg43: index, %arg44: tensor<1xf32>):
      %59 = "arith.index_cast"(%arg43) : (index) -> i32
      %60 = "tensor.empty"() : () -> tensor<1024xi32>
      %61 = "linalg.generic"(%60) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
      ^bb0(%arg73: i32):
        %92 = "linalg.index"() <{dim = 0 : i64}> : () -> index
        %93 = "arith.index_cast"(%92) : (index) -> i32
        "linalg.yield"(%93) : (i32) -> ()
      }) : (tensor<1024xi32>) -> tensor<1024xi32>
      %62 = "arith.addi"(%arg43, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %63 = "arith.minsi"(%62, %26) : (index, index) -> index
      %64 = "arith.maxsi"(%63, %arg43) : (index, index) -> index
      %65 = "arith.subi"(%64, %arg43) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %66 = "arith.addi"(%21, %arg43) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %67 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
      "linalg.fill"(%9, %67) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg71: bf16, %arg72: bf16):
        "linalg.yield"(%arg71) : (bf16) -> ()
      }) : (bf16, memref<1024xbf16>) -> ()
      %68 = "memref.subview"(%arg7, %66, %65) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %69 = "memref.subview"(%67, %65) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%68, %69) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg69: bf16, %arg70: bf16):
        "linalg.yield"(%arg69) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %70 = "bufferization.to_tensor"(%67) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
      %71 = "linalg.generic"(%70, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg67: bf16, %arg68: f32):
        %91 = "arith.extf"(%arg67) : (bf16) -> f32
        "linalg.yield"(%91) : (f32) -> ()
      }) : (tensor<1024xbf16>, tensor<1024xf32>) -> tensor<1024xf32>
      %72 = "linalg.generic"(%71, %71, %71) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg64: f32, %arg65: f32, %arg66: f32):
        %90 = "arith.mulf"(%arg64, %arg65) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%90) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %73 = "arith.subi"(%59, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %74 = "linalg.generic"(%61, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg62: i32, %arg63: f32):
        %89 = "arith.sitofp"(%arg62) : (i32) -> f32
        "linalg.yield"(%89) : (f32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xf32>) -> tensor<1024xf32>
      %75 = "linalg.generic"(%74, %15, %74) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg59: f32, %arg60: f32, %arg61: f32):
        %88 = "arith.addf"(%arg59, %arg60) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%88) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %76 = "arith.subi"(%10, %73) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %77 = "arith.sitofp"(%76) : (i32) -> f32
      %78 = "linalg.fill"(%77, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg57: f32, %arg58: f32):
        "linalg.yield"(%arg57) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %79 = "tensor.empty"() : () -> tensor<1024xi1>
      %80 = "linalg.generic"(%75, %78, %79) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg54: f32, %arg55: f32, %arg56: i1):
        %87 = "arith.cmpf"(%arg54, %arg55) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%87) : (i1) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xi1>) -> tensor<1024xi1>
      %81 = "linalg.generic"(%80, %72, %15, %72) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg50: i1, %arg51: f32, %arg52: f32, %arg53: f32):
        %86 = "arith.select"(%arg50, %arg51, %arg52) : (i1, f32, f32) -> f32
        "linalg.yield"(%86) : (f32) -> ()
      }) : (tensor<1024xi1>, tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %82 = "func.call"(%81) <{callee = @triton.language.standard.sum__fp32S1024S_cNone_cFalse_cNone}> : (tensor<1024xf32>) -> f32
      %83 = "linalg.fill"(%82, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg48: f32, %arg49: f32):
        "linalg.yield"(%arg48) : (f32) -> ()
      }) : (f32, tensor<1xf32>) -> tensor<1xf32>
      %84 = "linalg.generic"(%arg44, %83, %arg44) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg45: f32, %arg46: f32, %arg47: f32):
        %85 = "arith.addf"(%arg45, %arg46) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%85) : (f32) -> ()
      }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
      "scf.yield"(%84) : (tensor<1xf32>) -> ()
    }) : (index, index, index, tensor<1xf32>) -> tensor<1xf32>
    %28 = "arith.sitofp"(%arg12) : (i32) -> f32
    %29 = "linalg.fill"(%28, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg41: f32, %arg42: f32):
      "linalg.yield"(%arg41) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %30 = "linalg.generic"(%27, %29, %27) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg38: f32, %arg39: f32, %arg40: f32):
      %58 = "arith.divf"(%arg38, %arg39) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%58) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %31 = "linalg.fill"(%arg13, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg36: f32, %arg37: f32):
      "linalg.yield"(%arg36) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %32 = "linalg.generic"(%30, %31, %30) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg33: f32, %arg34: f32, %arg35: f32):
      %57 = "arith.addf"(%arg33, %arg34) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%57) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %33 = "linalg.generic"(%32, %32) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg31: f32, %arg32: f32):
      %56 = "math.sqrt"(%arg31) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%56) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %34 = "linalg.generic"(%13, %33, %13) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg28: f32, %arg29: f32, %arg30: f32):
      %55 = "arith.divf"(%arg28, %arg29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%55) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    "scf.for"(%7, %26, %8) ({
    ^bb0(%arg14: index):
      %35 = "arith.addi"(%arg14, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %36 = "arith.minsi"(%35, %26) : (index, index) -> index
      %37 = "arith.maxsi"(%36, %arg14) : (index, index) -> index
      %38 = "arith.subi"(%37, %arg14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %39 = "arith.addi"(%21, %arg14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
      "linalg.fill"(%9, %40) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg26: bf16, %arg27: bf16):
        "linalg.yield"(%arg26) : (bf16) -> ()
      }) : (bf16, memref<1024xbf16>) -> ()
      %41 = "memref.subview"(%arg7, %39, %38) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %42 = "memref.subview"(%40, %38) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%41, %42) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg24: bf16, %arg25: bf16):
        "linalg.yield"(%arg24) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %43 = "bufferization.to_tensor"(%40) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
      %44 = "linalg.generic"(%43, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg22: bf16, %arg23: f32):
        %54 = "arith.extf"(%arg22) : (bf16) -> f32
        "linalg.yield"(%54) : (f32) -> ()
      }) : (tensor<1024xbf16>, tensor<1024xf32>) -> tensor<1024xf32>
      %45 = "linalg.generic"(%34, %14) <{indexing_maps = [#map1, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg20: f32, %arg21: f32):
        "linalg.yield"(%arg20) : (f32) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %46 = "linalg.generic"(%44, %45, %44) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg17: f32, %arg18: f32, %arg19: f32):
        %53 = "arith.mulf"(%arg17, %arg18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%53) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %47 = "tensor.empty"() : () -> tensor<1024xbf16>
      %48 = "linalg.generic"(%46, %47) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg15: f32, %arg16: bf16):
        %52 = "arith.truncf"(%arg15) : (f32) -> bf16
        "linalg.yield"(%52) : (bf16) -> ()
      }) : (tensor<1024xf32>, tensor<1024xbf16>) -> tensor<1024xbf16>
      %49 = "arith.addi"(%24, %arg14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %50 = "tensor.extract_slice"(%48, %38) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xbf16>, index) -> tensor<?xbf16>
      %51 = "memref.subview"(%arg9, %49, %38) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%50, %51) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<1xf32>, sym_name = "triton.language.standard.zeros__Tc1T_cfp32", sym_visibility = "private"}> ({
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "tensor.empty"() : () -> tensor<1xf32>
    %5 = "linalg.fill"(%3, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    "func.return"(%5) : (tensor<1xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1024xf32>) -> f32, sym_name = "triton.language.standard.sum__fp32S1024S_cNone_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<1024xf32>):
    %1 = "tt.reduce"(%arg2) <{axis = 0 : i32}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%2) : (f32) -> ()
    }) : (tensor<1024xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

