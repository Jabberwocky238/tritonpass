#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32, i32) -> (), sym_name = "_softmax_kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32, %arg3: i32, %arg4: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %5 = "tensor.empty"() : () -> tensor<1024xf32>
    %6 = "linalg.fill"(%0, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg67: f32, %arg68: f32):
      "linalg.yield"(%arg67) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %7 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %8 = "arith.index_cast"(%7) : (index) -> i32
    %9 = "arith.extsi"(%8) : (i32) -> i64
    %10 = "arith.extsi"(%arg2) : (i32) -> i64
    %11 = "arith.muli"(%9, %10) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %12 = "arith.index_cast"(%11) : (i64) -> index
    %13 = "arith.extsi"(%arg3) : (i32) -> i64
    %14 = "arith.muli"(%9, %13) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %15 = "arith.index_cast"(%14) : (i64) -> index
    %16 = "tensor.empty"() : () -> tensor<1024xi32>
    %17 = "linalg.generic"(%16) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg66: i32):
      %91 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %92 = "arith.index_cast"(%91) : (index) -> i32
      "linalg.yield"(%92) : (i32) -> ()
    }) : (tensor<1024xi32>) -> tensor<1024xi32>
    %18 = "arith.index_cast"(%arg4) : (i32) -> index
    %19 = "scf.for"(%1, %18, %2, %4) ({
    ^bb0(%arg51: index, %arg52: f32):
      %74 = "arith.addi"(%arg51, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %75 = "arith.minsi"(%74, %18) : (index, index) -> index
      %76 = "arith.maxsi"(%75, %arg51) : (index, index) -> index
      %77 = "arith.subi"(%76, %arg51) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %78 = "arith.addi"(%12, %arg51) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %79 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
      "linalg.fill"(%4, %79) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg64: f32, %arg65: f32):
        "linalg.yield"(%arg64) : (f32) -> ()
      }) : (f32, memref<1024xf32>) -> ()
      %80 = "memref.subview"(%arg0, %78, %77) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %81 = "memref.subview"(%79, %77) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%80, %81) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg62: f32, %arg63: f32):
        "linalg.yield"(%arg62) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %82 = "bufferization.to_tensor"(%79) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
      %83 = "linalg.fill"(%arg52, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg60: f32, %arg61: f32):
        "linalg.yield"(%arg60) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %84 = "linalg.generic"(%82, %83, %82) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg57: f32, %arg58: f32, %arg59: f32):
        %90 = "arith.maxnumf"(%arg57, %arg58) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%90) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %85 = "tensor.empty"() : () -> tensor<f32>
      %86 = "linalg.fill"(%4, %85) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg55: f32, %arg56: f32):
        "linalg.yield"(%arg55) : (f32) -> ()
      }) : (f32, tensor<f32>) -> tensor<f32>
      %87 = "linalg.reduce"(%84, %86) <{dimensions = array<i64: 0>}> ({
      ^bb0(%arg53: f32, %arg54: f32):
        %89 = "arith.maxnumf"(%arg53, %arg54) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%89) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<f32>) -> tensor<f32>
      %88 = "tensor.extract"(%87) : (tensor<f32>) -> f32
      "scf.yield"(%88) : (f32) -> ()
    }) : (index, index, index, f32) -> f32
    %20 = "linalg.fill"(%19, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg49: f32, %arg50: f32):
      "linalg.yield"(%arg49) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %21 = "scf.for"(%1, %18, %2, %0) ({
    ^bb0(%arg20: index, %arg21: f32):
      %41 = "arith.index_cast"(%arg20) : (index) -> i32
      %42 = "arith.addi"(%arg20, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %43 = "arith.minsi"(%42, %18) : (index, index) -> index
      %44 = "arith.maxsi"(%43, %arg20) : (index, index) -> index
      %45 = "arith.subi"(%44, %arg20) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %46 = "arith.addi"(%12, %arg20) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %47 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
      "linalg.fill"(%0, %47) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg47: f32, %arg48: f32):
        "linalg.yield"(%arg47) : (f32) -> ()
      }) : (f32, memref<1024xf32>) -> ()
      %48 = "memref.subview"(%arg0, %46, %45) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %49 = "memref.subview"(%47, %45) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%48, %49) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg45: f32, %arg46: f32):
        "linalg.yield"(%arg45) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %50 = "bufferization.to_tensor"(%47) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
      %51 = "linalg.generic"(%50, %20, %50) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg42: f32, %arg43: f32, %arg44: f32):
        %73 = "arith.subf"(%arg42, %arg43) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%73) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %52 = "linalg.generic"(%51, %51) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg40: f32, %arg41: f32):
        %72 = "math.exp"(%arg40) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%72) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %53 = "arith.subi"(%41, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %54 = "linalg.generic"(%17, %5) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg38: i32, %arg39: f32):
        %71 = "arith.sitofp"(%arg38) : (i32) -> f32
        "linalg.yield"(%71) : (f32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xf32>) -> tensor<1024xf32>
      %55 = "linalg.generic"(%54, %6, %54) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg35: f32, %arg36: f32, %arg37: f32):
        %70 = "arith.addf"(%arg35, %arg36) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%70) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %56 = "arith.subi"(%3, %53) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %57 = "arith.sitofp"(%56) : (i32) -> f32
      %58 = "linalg.fill"(%57, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg33: f32, %arg34: f32):
        "linalg.yield"(%arg33) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %59 = "tensor.empty"() : () -> tensor<1024xi1>
      %60 = "linalg.generic"(%55, %58, %59) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg30: f32, %arg31: f32, %arg32: i1):
        %69 = "arith.cmpf"(%arg30, %arg31) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%69) : (i1) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xi1>) -> tensor<1024xi1>
      %61 = "linalg.generic"(%60, %52, %6, %52) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg26: i1, %arg27: f32, %arg28: f32, %arg29: f32):
        %68 = "arith.select"(%arg26, %arg27, %arg28) : (i1, f32, f32) -> f32
        "linalg.yield"(%68) : (f32) -> ()
      }) : (tensor<1024xi1>, tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %62 = "tensor.empty"() : () -> tensor<f32>
      %63 = "linalg.fill"(%0, %62) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg24: f32, %arg25: f32):
        "linalg.yield"(%arg24) : (f32) -> ()
      }) : (f32, tensor<f32>) -> tensor<f32>
      %64 = "linalg.reduce"(%61, %63) <{dimensions = array<i64: 0>}> ({
      ^bb0(%arg22: f32, %arg23: f32):
        %67 = "arith.addf"(%arg22, %arg23) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%67) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<f32>) -> tensor<f32>
      %65 = "tensor.extract"(%64) : (tensor<f32>) -> f32
      %66 = "arith.addf"(%arg21, %65) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%66) : (f32) -> ()
    }) : (index, index, index, f32) -> f32
    %22 = "linalg.fill"(%21, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: f32, %arg19: f32):
      "linalg.yield"(%arg18) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    "scf.for"(%1, %18, %2) ({
    ^bb0(%arg5: index):
      %23 = "arith.addi"(%arg5, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %24 = "arith.minsi"(%23, %18) : (index, index) -> index
      %25 = "arith.maxsi"(%24, %arg5) : (index, index) -> index
      %26 = "arith.subi"(%25, %arg5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %27 = "arith.addi"(%12, %arg5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %28 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
      "linalg.fill"(%0, %28) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg16: f32, %arg17: f32):
        "linalg.yield"(%arg16) : (f32) -> ()
      }) : (f32, memref<1024xf32>) -> ()
      %29 = "memref.subview"(%arg0, %27, %26) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %30 = "memref.subview"(%28, %26) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%29, %30) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg14: f32, %arg15: f32):
        "linalg.yield"(%arg14) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %31 = "bufferization.to_tensor"(%28) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
      %32 = "linalg.generic"(%31, %20, %31) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg11: f32, %arg12: f32, %arg13: f32):
        %40 = "arith.subf"(%arg11, %arg12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%40) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %33 = "linalg.generic"(%32, %32) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg9: f32, %arg10: f32):
        %39 = "math.exp"(%arg9) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%39) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %34 = "linalg.generic"(%33, %22, %33) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
        %38 = "arith.divf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%38) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %35 = "arith.addi"(%15, %arg5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %36 = "tensor.extract_slice"(%34, %26) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xf32>, index) -> tensor<?xf32>
      %37 = "memref.subview"(%arg1, %35, %26) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%36, %37) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

