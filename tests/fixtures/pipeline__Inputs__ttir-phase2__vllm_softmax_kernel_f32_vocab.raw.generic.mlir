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
    ^bb0(%arg71: f32, %arg72: f32):
      "linalg.yield"(%arg71) : (f32) -> ()
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
    ^bb0(%arg60: index, %arg61: f32):
      %79 = "arith.addi"(%arg60, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %80 = "arith.minsi"(%79, %22) : (index, index) -> index
      %81 = "arith.maxsi"(%80, %arg60) : (index, index) -> index
      %82 = "arith.subi"(%81, %arg60) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %83 = "arith.addi"(%18, %arg60) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %84 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
      "linalg.fill"(%10, %84) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg69: f32, %arg70: f32):
        "linalg.yield"(%arg69) : (f32) -> ()
      }) : (f32, memref<1024xf32>) -> ()
      %85 = "memref.subview"(%arg10, %83, %82) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %86 = "memref.subview"(%84, %82) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%85, %86) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg67: f32, %arg68: f32):
        "linalg.yield"(%arg67) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %87 = "bufferization.to_tensor"(%84) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
      %88 = "linalg.fill"(%arg61, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg65: f32, %arg66: f32):
        "linalg.yield"(%arg65) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %89 = "linalg.generic"(%87, %88, %87) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg62: f32, %arg63: f32, %arg64: f32):
        %91 = "arith.maxnumf"(%arg62, %arg63) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%91) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %90 = "func.call"(%89) <{callee = @triton.language.standard.max__fp32S1024S_cNone_cFalse_cTrue_cFalse}> : (tensor<1024xf32>) -> f32
      "scf.yield"(%90) : (f32) -> ()
    }) : (index, index, index, f32) -> f32
    %24 = "scf.for"(%7, %22, %8, %6) ({
    ^bb0(%arg32: index, %arg33: f32):
      %45 = "arith.index_cast"(%arg32) : (index) -> i32
      %46 = "tensor.empty"() : () -> tensor<1024xi32>
      %47 = "linalg.generic"(%46) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
      ^bb0(%arg59: i32):
        %77 = "linalg.index"() <{dim = 0 : i64}> : () -> index
        %78 = "arith.index_cast"(%77) : (index) -> i32
        "linalg.yield"(%78) : (i32) -> ()
      }) : (tensor<1024xi32>) -> tensor<1024xi32>
      %48 = "arith.addi"(%arg32, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %49 = "arith.minsi"(%48, %22) : (index, index) -> index
      %50 = "arith.maxsi"(%49, %arg32) : (index, index) -> index
      %51 = "arith.subi"(%50, %arg32) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %52 = "arith.addi"(%18, %arg32) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %53 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
      "linalg.fill"(%6, %53) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg57: f32, %arg58: f32):
        "linalg.yield"(%arg57) : (f32) -> ()
      }) : (f32, memref<1024xf32>) -> ()
      %54 = "memref.subview"(%arg10, %52, %51) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %55 = "memref.subview"(%53, %51) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%54, %55) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg55: f32, %arg56: f32):
        "linalg.yield"(%arg55) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %56 = "bufferization.to_tensor"(%53) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
      %57 = "linalg.fill"(%23, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg53: f32, %arg54: f32):
        "linalg.yield"(%arg53) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %58 = "linalg.generic"(%56, %57, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg50: f32, %arg51: f32, %arg52: f32):
        %76 = "arith.subf"(%arg50, %arg51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%76) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %59 = "linalg.generic"(%58, %58) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg48: f32, %arg49: f32):
        %75 = "math.exp"(%arg48) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%75) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %60 = "arith.subi"(%45, %arg14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %61 = "linalg.generic"(%47, %11) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg46: i32, %arg47: f32):
        %74 = "arith.sitofp"(%arg46) : (i32) -> f32
        "linalg.yield"(%74) : (f32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xf32>) -> tensor<1024xf32>
      %62 = "linalg.generic"(%61, %12, %61) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg43: f32, %arg44: f32, %arg45: f32):
        %73 = "arith.addf"(%arg43, %arg44) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%73) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %63 = "arith.subi"(%9, %60) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %64 = "arith.sitofp"(%63) : (i32) -> f32
      %65 = "linalg.fill"(%64, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg41: f32, %arg42: f32):
        "linalg.yield"(%arg41) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %66 = "tensor.empty"() : () -> tensor<1024xi1>
      %67 = "linalg.generic"(%62, %65, %66) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg38: f32, %arg39: f32, %arg40: i1):
        %72 = "arith.cmpf"(%arg38, %arg39) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%72) : (i1) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xi1>) -> tensor<1024xi1>
      %68 = "linalg.generic"(%67, %59, %12, %59) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg34: i1, %arg35: f32, %arg36: f32, %arg37: f32):
        %71 = "arith.select"(%arg34, %arg35, %arg36) : (i1, f32, f32) -> f32
        "linalg.yield"(%71) : (f32) -> ()
      }) : (tensor<1024xi1>, tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %69 = "func.call"(%68) <{callee = @triton.language.standard.sum__fp32S1024S_cNone_cFalse_cNone}> : (tensor<1024xf32>) -> f32
      %70 = "arith.addf"(%arg33, %69) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%70) : (f32) -> ()
    }) : (index, index, index, f32) -> f32
    "scf.for"(%7, %22, %8) ({
    ^bb0(%arg15: index):
      %25 = "arith.addi"(%arg15, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %26 = "arith.minsi"(%25, %22) : (index, index) -> index
      %27 = "arith.maxsi"(%26, %arg15) : (index, index) -> index
      %28 = "arith.subi"(%27, %arg15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %29 = "arith.addi"(%18, %arg15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %30 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
      "linalg.fill"(%6, %30) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg30: f32, %arg31: f32):
        "linalg.yield"(%arg30) : (f32) -> ()
      }) : (f32, memref<1024xf32>) -> ()
      %31 = "memref.subview"(%arg10, %29, %28) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %32 = "memref.subview"(%30, %28) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%31, %32) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg28: f32, %arg29: f32):
        "linalg.yield"(%arg28) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %33 = "bufferization.to_tensor"(%30) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
      %34 = "linalg.fill"(%23, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg26: f32, %arg27: f32):
        "linalg.yield"(%arg26) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %35 = "linalg.generic"(%33, %34, %33) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg23: f32, %arg24: f32, %arg25: f32):
        %44 = "arith.subf"(%arg23, %arg24) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%44) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %36 = "linalg.generic"(%35, %35) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg21: f32, %arg22: f32):
        %43 = "math.exp"(%arg21) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%43) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %37 = "linalg.fill"(%24, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg19: f32, %arg20: f32):
        "linalg.yield"(%arg19) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %38 = "linalg.generic"(%36, %37, %36) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg16: f32, %arg17: f32, %arg18: f32):
        %42 = "arith.divf"(%arg16, %arg17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%42) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %39 = "arith.addi"(%21, %arg15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "tensor.extract_slice"(%38, %28) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xf32>, index) -> tensor<?xf32>
      %41 = "memref.subview"(%arg11, %39, %28) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
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

