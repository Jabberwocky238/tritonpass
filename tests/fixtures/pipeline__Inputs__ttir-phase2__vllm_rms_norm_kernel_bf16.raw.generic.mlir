#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> (0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, f32) -> (), sym_name = "_rms_norm_kernel"}> ({
  ^bb0(%arg7: memref<?xbf16>, %arg8: memref<?xbf16>, %arg9: memref<?xbf16>, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: f32):
    %6 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 0 : index}> : () -> index
    %8 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %9 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %10 = "arith.constant"() <{value = 1.000000e+00 : bf16}> : () -> bf16
    %11 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %12 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %13 = "tensor.empty"() : () -> tensor<1xf32>
    %14 = "linalg.fill"(%6, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg85: f32, %arg86: f32):
      "linalg.yield"(%arg85) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %15 = "tensor.empty"() : () -> tensor<1024xf32>
    %16 = "linalg.fill"(%12, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg83: f32, %arg84: f32):
      "linalg.yield"(%arg83) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %17 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %18 = "arith.index_cast"(%17) : (index) -> i32
    %19 = "arith.extsi"(%18) : (i32) -> i64
    %20 = "arith.extsi"(%arg10) : (i32) -> i64
    %21 = "arith.muli"(%19, %20) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %22 = "arith.index_cast"(%21) : (i64) -> index
    %23 = "arith.extsi"(%arg11) : (i32) -> i64
    %24 = "arith.muli"(%19, %23) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %25 = "arith.index_cast"(%24) : (i64) -> index
    %26 = "func.call"() <{callee = @triton.language.standard.zeros__Tc1T_cfp32}> : () -> tensor<1xf32>
    %27 = "arith.index_cast"(%arg12) : (i32) -> index
    %28 = "scf.for"(%7, %27, %8, %26) ({
    ^bb0(%arg52: index, %arg53: tensor<1xf32>):
      %68 = "arith.index_cast"(%arg52) : (index) -> i32
      %69 = "tensor.empty"() : () -> tensor<1024xi32>
      %70 = "linalg.generic"(%69) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
      ^bb0(%arg82: i32):
        %101 = "linalg.index"() <{dim = 0 : i64}> : () -> index
        %102 = "arith.index_cast"(%101) : (index) -> i32
        "linalg.yield"(%102) : (i32) -> ()
      }) : (tensor<1024xi32>) -> tensor<1024xi32>
      %71 = "arith.addi"(%arg52, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %72 = "arith.minsi"(%71, %27) : (index, index) -> index
      %73 = "arith.maxsi"(%72, %arg52) : (index, index) -> index
      %74 = "arith.subi"(%73, %arg52) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %75 = "arith.addi"(%22, %arg52) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %76 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
      "linalg.fill"(%9, %76) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg80: bf16, %arg81: bf16):
        "linalg.yield"(%arg80) : (bf16) -> ()
      }) : (bf16, memref<1024xbf16>) -> ()
      %77 = "memref.subview"(%arg7, %75, %74) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %78 = "memref.subview"(%76, %74) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%77, %78) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg78: bf16, %arg79: bf16):
        "linalg.yield"(%arg78) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %79 = "bufferization.to_tensor"(%76) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
      %80 = "linalg.generic"(%79, %15) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg76: bf16, %arg77: f32):
        %100 = "arith.extf"(%arg76) : (bf16) -> f32
        "linalg.yield"(%100) : (f32) -> ()
      }) : (tensor<1024xbf16>, tensor<1024xf32>) -> tensor<1024xf32>
      %81 = "linalg.generic"(%80, %80, %80) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg73: f32, %arg74: f32, %arg75: f32):
        %99 = "arith.mulf"(%arg73, %arg74) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%99) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %82 = "arith.subi"(%68, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %83 = "linalg.generic"(%70, %15) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg71: i32, %arg72: f32):
        %98 = "arith.sitofp"(%arg71) : (i32) -> f32
        "linalg.yield"(%98) : (f32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xf32>) -> tensor<1024xf32>
      %84 = "linalg.generic"(%83, %16, %83) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg68: f32, %arg69: f32, %arg70: f32):
        %97 = "arith.addf"(%arg68, %arg69) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%97) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %85 = "arith.subi"(%11, %82) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %86 = "arith.sitofp"(%85) : (i32) -> f32
      %87 = "linalg.fill"(%86, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg66: f32, %arg67: f32):
        "linalg.yield"(%arg66) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %88 = "tensor.empty"() : () -> tensor<1024xi1>
      %89 = "linalg.generic"(%84, %87, %88) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg63: f32, %arg64: f32, %arg65: i1):
        %96 = "arith.cmpf"(%arg63, %arg64) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%96) : (i1) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xi1>) -> tensor<1024xi1>
      %90 = "linalg.generic"(%89, %81, %16, %81) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg59: i1, %arg60: f32, %arg61: f32, %arg62: f32):
        %95 = "arith.select"(%arg59, %arg60, %arg61) : (i1, f32, f32) -> f32
        "linalg.yield"(%95) : (f32) -> ()
      }) : (tensor<1024xi1>, tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %91 = "func.call"(%90) <{callee = @triton.language.standard.sum__fp32S1024S_cNone_cFalse_cNone}> : (tensor<1024xf32>) -> f32
      %92 = "linalg.fill"(%91, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg57: f32, %arg58: f32):
        "linalg.yield"(%arg57) : (f32) -> ()
      }) : (f32, tensor<1xf32>) -> tensor<1xf32>
      %93 = "linalg.generic"(%arg53, %92, %arg53) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg54: f32, %arg55: f32, %arg56: f32):
        %94 = "arith.addf"(%arg54, %arg55) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%94) : (f32) -> ()
      }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
      "scf.yield"(%93) : (tensor<1xf32>) -> ()
    }) : (index, index, index, tensor<1xf32>) -> tensor<1xf32>
    %29 = "arith.sitofp"(%arg12) : (i32) -> f32
    %30 = "linalg.fill"(%29, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg50: f32, %arg51: f32):
      "linalg.yield"(%arg50) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %31 = "linalg.generic"(%28, %30, %28) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg47: f32, %arg48: f32, %arg49: f32):
      %67 = "arith.divf"(%arg47, %arg48) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%67) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %32 = "linalg.fill"(%arg13, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg45: f32, %arg46: f32):
      "linalg.yield"(%arg45) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %33 = "linalg.generic"(%31, %32, %31) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg42: f32, %arg43: f32, %arg44: f32):
      %66 = "arith.addf"(%arg42, %arg43) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%66) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %34 = "linalg.generic"(%33, %33) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg40: f32, %arg41: f32):
      %65 = "math.sqrt"(%arg40) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%65) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %35 = "linalg.generic"(%14, %34, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg37: f32, %arg38: f32, %arg39: f32):
      %64 = "arith.divf"(%arg37, %arg38) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%64) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    "scf.for"(%7, %27, %8) ({
    ^bb0(%arg14: index):
      %36 = "arith.addi"(%arg14, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %37 = "arith.minsi"(%36, %27) : (index, index) -> index
      %38 = "arith.maxsi"(%37, %arg14) : (index, index) -> index
      %39 = "arith.subi"(%38, %arg14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "arith.addi"(%22, %arg14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %41 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
      "linalg.fill"(%9, %41) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg35: bf16, %arg36: bf16):
        "linalg.yield"(%arg35) : (bf16) -> ()
      }) : (bf16, memref<1024xbf16>) -> ()
      %42 = "memref.subview"(%arg7, %40, %39) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %43 = "memref.subview"(%41, %39) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%42, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg33: bf16, %arg34: bf16):
        "linalg.yield"(%arg33) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %44 = "bufferization.to_tensor"(%41) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
      %45 = "linalg.generic"(%44, %15) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg31: bf16, %arg32: f32):
        %63 = "arith.extf"(%arg31) : (bf16) -> f32
        "linalg.yield"(%63) : (f32) -> ()
      }) : (tensor<1024xbf16>, tensor<1024xf32>) -> tensor<1024xf32>
      %46 = "linalg.generic"(%35, %15) <{indexing_maps = [#map1, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg29: f32, %arg30: f32):
        "linalg.yield"(%arg29) : (f32) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %47 = "linalg.generic"(%45, %46, %45) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg26: f32, %arg27: f32, %arg28: f32):
        %62 = "arith.mulf"(%arg26, %arg27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%62) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %48 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xbf16>
      "linalg.fill"(%10, %48) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg24: bf16, %arg25: bf16):
        "linalg.yield"(%arg24) : (bf16) -> ()
      }) : (bf16, memref<1024xbf16>) -> ()
      %49 = "memref.subview"(%arg8, %arg14, %39) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %50 = "memref.subview"(%48, %39) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%49, %50) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg22: bf16, %arg23: bf16):
        "linalg.yield"(%arg22) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %51 = "bufferization.to_tensor"(%48) <{restrict, writable}> : (memref<1024xbf16>) -> tensor<1024xbf16>
      %52 = "linalg.generic"(%51, %15) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg20: bf16, %arg21: f32):
        %61 = "arith.extf"(%arg20) : (bf16) -> f32
        "linalg.yield"(%61) : (f32) -> ()
      }) : (tensor<1024xbf16>, tensor<1024xf32>) -> tensor<1024xf32>
      %53 = "linalg.generic"(%47, %52, %47) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg17: f32, %arg18: f32, %arg19: f32):
        %60 = "arith.mulf"(%arg17, %arg18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%60) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %54 = "tensor.empty"() : () -> tensor<1024xbf16>
      %55 = "linalg.generic"(%53, %54) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg15: f32, %arg16: bf16):
        %59 = "arith.truncf"(%arg15) : (f32) -> bf16
        "linalg.yield"(%59) : (bf16) -> ()
      }) : (tensor<1024xf32>, tensor<1024xbf16>) -> tensor<1024xbf16>
      %56 = "arith.addi"(%25, %arg14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %57 = "tensor.extract_slice"(%55, %39) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xbf16>, index) -> tensor<?xbf16>
      %58 = "memref.subview"(%arg9, %56, %39) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%57, %58) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
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

