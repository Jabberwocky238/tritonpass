#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32, i32) -> (), sym_name = "_softmax_kernel"}> ({
  ^bb0(%arg10: memref<?xf32>, %arg11: memref<?xf32>, %arg12: i32, %arg13: i32, %arg14: i32):
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 0 : index}> : () -> index
    %8 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %9 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %10 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %11 = "tensor.empty"() : () -> tensor<1024xf32>
    %12 = "linalg.fill"(%6, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg69: f32, %arg70: f32):
      "linalg.yield"(%arg69) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %13 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %14 = "arith.index_cast"(%13) : (index) -> i32
    %15 = "arith.extsi"(%14) : (i32) -> i64
    %16 = "arith.extsi"(%arg12) : (i32) -> i64
    %17 = "arith.muli"(%15, %16) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %18 = "arith.index_cast"(%17) : (i64) -> index
    %19 = "arith.extsi"(%arg13) : (i32) -> i64
    %20 = "arith.muli"(%15, %19) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %21 = "arith.index_cast"(%20) : (i64) -> index
    %22 = "arith.index_cast"(%arg14) : (i32) -> index
    %23 = "scf.for"(%7, %22, %8, %10) ({
    ^bb0(%arg58: index, %arg59: f32):
      %78 = "arith.addi"(%arg58, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %79 = "arith.minsi"(%78, %22) : (index, index) -> index
      %80 = "arith.maxsi"(%79, %arg58) : (index, index) -> index
      %81 = "arith.subi"(%80, %arg58) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %82 = "arith.addi"(%18, %arg58) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %83 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
      "linalg.fill"(%10, %83) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg67: f32, %arg68: f32):
        "linalg.yield"(%arg67) : (f32) -> ()
      }) : (f32, memref<1024xf32>) -> ()
      %84 = "memref.subview"(%arg10, %82, %81) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %85 = "memref.subview"(%83, %81) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%84, %85) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg65: f32, %arg66: f32):
        "linalg.yield"(%arg65) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %86 = "bufferization.to_tensor"(%83) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
      %87 = "linalg.fill"(%arg59, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg63: f32, %arg64: f32):
        "linalg.yield"(%arg63) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %88 = "linalg.generic"(%86, %87, %86) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg60: f32, %arg61: f32, %arg62: f32):
        %90 = "arith.maxnumf"(%arg60, %arg61) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%90) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %89 = "func.call"(%88) <{callee = @triton.language.standard.max__fp32S1024S_cNone_cFalse_cTrue_cFalse}> : (tensor<1024xf32>) -> f32
      "scf.yield"(%89) : (f32) -> ()
    }) : (index, index, index, f32) -> f32
    %24 = "scf.for"(%7, %22, %8, %6) ({
    ^bb0(%arg30: index, %arg31: f32):
      %44 = "arith.index_cast"(%arg30) : (index) -> i32
      %45 = "tensor.empty"() : () -> tensor<1024xi32>
      %46 = "linalg.generic"(%45) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
      ^bb0(%arg57: i32):
        %76 = "linalg.index"() <{dim = 0 : i64}> : () -> index
        %77 = "arith.index_cast"(%76) : (index) -> i32
        "linalg.yield"(%77) : (i32) -> ()
      }) : (tensor<1024xi32>) -> tensor<1024xi32>
      %47 = "arith.addi"(%arg30, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %48 = "arith.minsi"(%47, %22) : (index, index) -> index
      %49 = "arith.maxsi"(%48, %arg30) : (index, index) -> index
      %50 = "arith.subi"(%49, %arg30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %51 = "arith.addi"(%18, %arg30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %52 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
      "linalg.fill"(%6, %52) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg55: f32, %arg56: f32):
        "linalg.yield"(%arg55) : (f32) -> ()
      }) : (f32, memref<1024xf32>) -> ()
      %53 = "memref.subview"(%arg10, %51, %50) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %54 = "memref.subview"(%52, %50) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%53, %54) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg53: f32, %arg54: f32):
        "linalg.yield"(%arg53) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %55 = "bufferization.to_tensor"(%52) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
      %56 = "linalg.fill"(%23, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg51: f32, %arg52: f32):
        "linalg.yield"(%arg51) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %57 = "linalg.generic"(%55, %56, %55) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg48: f32, %arg49: f32, %arg50: f32):
        %75 = "arith.subf"(%arg48, %arg49) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%75) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %58 = "linalg.generic"(%57, %57) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg46: f32, %arg47: f32):
        %74 = "math.exp"(%arg46) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%74) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %59 = "arith.subi"(%44, %arg14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %60 = "linalg.generic"(%46, %11) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg44: i32, %arg45: f32):
        %73 = "arith.sitofp"(%arg44) : (i32) -> f32
        "linalg.yield"(%73) : (f32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xf32>) -> tensor<1024xf32>
      %61 = "linalg.generic"(%60, %12, %60) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg41: f32, %arg42: f32, %arg43: f32):
        %72 = "arith.addf"(%arg41, %arg42) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%72) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %62 = "arith.subi"(%9, %59) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %63 = "arith.sitofp"(%62) : (i32) -> f32
      %64 = "linalg.fill"(%63, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg39: f32, %arg40: f32):
        "linalg.yield"(%arg39) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %65 = "tensor.empty"() : () -> tensor<1024xi1>
      %66 = "linalg.generic"(%61, %64, %65) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg36: f32, %arg37: f32, %arg38: i1):
        %71 = "arith.cmpf"(%arg36, %arg37) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%71) : (i1) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xi1>) -> tensor<1024xi1>
      %67 = "linalg.generic"(%66, %58, %12, %58) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg32: i1, %arg33: f32, %arg34: f32, %arg35: f32):
        %70 = "arith.select"(%arg32, %arg33, %arg34) : (i1, f32, f32) -> f32
        "linalg.yield"(%70) : (f32) -> ()
      }) : (tensor<1024xi1>, tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %68 = "func.call"(%67) <{callee = @triton.language.standard.sum__fp32S1024S_cNone_cFalse_cNone}> : (tensor<1024xf32>) -> f32
      %69 = "arith.addf"(%arg31, %68) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%69) : (f32) -> ()
    }) : (index, index, index, f32) -> f32
    %25 = "math.log"(%24) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "scf.for"(%7, %22, %8) ({
    ^bb0(%arg15: index):
      %26 = "arith.addi"(%arg15, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %27 = "arith.minsi"(%26, %22) : (index, index) -> index
      %28 = "arith.maxsi"(%27, %arg15) : (index, index) -> index
      %29 = "arith.subi"(%28, %arg15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %30 = "arith.addi"(%18, %arg15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %31 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
      "linalg.fill"(%6, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg28: f32, %arg29: f32):
        "linalg.yield"(%arg28) : (f32) -> ()
      }) : (f32, memref<1024xf32>) -> ()
      %32 = "memref.subview"(%arg10, %30, %29) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %33 = "memref.subview"(%31, %29) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%32, %33) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg26: f32, %arg27: f32):
        "linalg.yield"(%arg26) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %34 = "bufferization.to_tensor"(%31) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
      %35 = "linalg.fill"(%23, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg24: f32, %arg25: f32):
        "linalg.yield"(%arg24) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %36 = "linalg.generic"(%34, %35, %34) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg21: f32, %arg22: f32, %arg23: f32):
        %43 = "arith.subf"(%arg21, %arg22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%43) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %37 = "linalg.fill"(%25, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg19: f32, %arg20: f32):
        "linalg.yield"(%arg19) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %38 = "linalg.generic"(%36, %37, %36) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg16: f32, %arg17: f32, %arg18: f32):
        %42 = "arith.subf"(%arg16, %arg17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%42) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %39 = "arith.addi"(%21, %arg15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "tensor.extract_slice"(%38, %29) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xf32>, index) -> tensor<?xf32>
      %41 = "memref.subview"(%arg11, %39, %29) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%40, %41) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1024xf32>) -> f32, sym_name = "triton.language.standard.max__fp32S1024S_cNone_cFalse_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg7: tensor<1024xf32>):
    %4 = "tt.reduce"(%arg7) <{axis = 0 : i32}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %5 = "func.call"(%arg8, %arg9) <{callee = @triton.language.standard._elementwise_max__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%5) : (f32) -> ()
    }) : (tensor<1024xf32>) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._elementwise_max__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg5: f32, %arg6: f32):
    %3 = "arith.maxnumf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%3) : (f32) -> ()
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

