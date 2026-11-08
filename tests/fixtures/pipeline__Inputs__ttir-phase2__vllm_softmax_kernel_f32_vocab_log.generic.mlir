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
    ^bb0(%arg65: f32, %arg66: f32):
      "linalg.yield"(%arg65) : (f32) -> ()
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
    ^bb0(%arg64: i32):
      %90 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %91 = "arith.index_cast"(%90) : (index) -> i32
      "linalg.yield"(%91) : (i32) -> ()
    }) : (tensor<1024xi32>) -> tensor<1024xi32>
    %18 = "arith.index_cast"(%arg4) : (i32) -> index
    %19 = "scf.for"(%1, %18, %2, %4) ({
    ^bb0(%arg49: index, %arg50: f32):
      %73 = "arith.addi"(%arg49, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %74 = "arith.minsi"(%73, %18) : (index, index) -> index
      %75 = "arith.maxsi"(%74, %arg49) : (index, index) -> index
      %76 = "arith.subi"(%75, %arg49) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %77 = "arith.addi"(%12, %arg49) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %78 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
      "linalg.fill"(%4, %78) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg62: f32, %arg63: f32):
        "linalg.yield"(%arg62) : (f32) -> ()
      }) : (f32, memref<1024xf32>) -> ()
      %79 = "memref.subview"(%arg0, %77, %76) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %80 = "memref.subview"(%78, %76) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%79, %80) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg60: f32, %arg61: f32):
        "linalg.yield"(%arg60) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %81 = "bufferization.to_tensor"(%78) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
      %82 = "linalg.fill"(%arg50, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg58: f32, %arg59: f32):
        "linalg.yield"(%arg58) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %83 = "linalg.generic"(%81, %82, %81) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg55: f32, %arg56: f32, %arg57: f32):
        %89 = "arith.maxnumf"(%arg55, %arg56) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%89) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %84 = "tensor.empty"() : () -> tensor<f32>
      %85 = "linalg.fill"(%4, %84) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg53: f32, %arg54: f32):
        "linalg.yield"(%arg53) : (f32) -> ()
      }) : (f32, tensor<f32>) -> tensor<f32>
      %86 = "linalg.reduce"(%83, %85) <{dimensions = array<i64: 0>}> ({
      ^bb0(%arg51: f32, %arg52: f32):
        %88 = "arith.maxnumf"(%arg51, %arg52) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%88) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<f32>) -> tensor<f32>
      %87 = "tensor.extract"(%86) : (tensor<f32>) -> f32
      "scf.yield"(%87) : (f32) -> ()
    }) : (index, index, index, f32) -> f32
    %20 = "linalg.fill"(%19, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg47: f32, %arg48: f32):
      "linalg.yield"(%arg47) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %21 = "scf.for"(%1, %18, %2, %0) ({
    ^bb0(%arg18: index, %arg19: f32):
      %40 = "arith.index_cast"(%arg18) : (index) -> i32
      %41 = "arith.addi"(%arg18, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %42 = "arith.minsi"(%41, %18) : (index, index) -> index
      %43 = "arith.maxsi"(%42, %arg18) : (index, index) -> index
      %44 = "arith.subi"(%43, %arg18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %45 = "arith.addi"(%12, %arg18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %46 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
      "linalg.fill"(%0, %46) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg45: f32, %arg46: f32):
        "linalg.yield"(%arg45) : (f32) -> ()
      }) : (f32, memref<1024xf32>) -> ()
      %47 = "memref.subview"(%arg0, %45, %44) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %48 = "memref.subview"(%46, %44) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%47, %48) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg43: f32, %arg44: f32):
        "linalg.yield"(%arg43) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %49 = "bufferization.to_tensor"(%46) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
      %50 = "linalg.generic"(%49, %20, %49) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg40: f32, %arg41: f32, %arg42: f32):
        %72 = "arith.subf"(%arg40, %arg41) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%72) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %51 = "linalg.generic"(%50, %50) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg38: f32, %arg39: f32):
        %71 = "math.exp"(%arg38) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%71) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %52 = "arith.subi"(%40, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %53 = "linalg.generic"(%17, %5) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg36: i32, %arg37: f32):
        %70 = "arith.sitofp"(%arg36) : (i32) -> f32
        "linalg.yield"(%70) : (f32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xf32>) -> tensor<1024xf32>
      %54 = "linalg.generic"(%53, %6, %53) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg33: f32, %arg34: f32, %arg35: f32):
        %69 = "arith.addf"(%arg33, %arg34) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%69) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %55 = "arith.subi"(%3, %52) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %56 = "arith.sitofp"(%55) : (i32) -> f32
      %57 = "linalg.fill"(%56, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg31: f32, %arg32: f32):
        "linalg.yield"(%arg31) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %58 = "tensor.empty"() : () -> tensor<1024xi1>
      %59 = "linalg.generic"(%54, %57, %58) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg28: f32, %arg29: f32, %arg30: i1):
        %68 = "arith.cmpf"(%arg28, %arg29) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%68) : (i1) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xi1>) -> tensor<1024xi1>
      %60 = "linalg.generic"(%59, %51, %6, %51) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg24: i1, %arg25: f32, %arg26: f32, %arg27: f32):
        %67 = "arith.select"(%arg24, %arg25, %arg26) : (i1, f32, f32) -> f32
        "linalg.yield"(%67) : (f32) -> ()
      }) : (tensor<1024xi1>, tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %61 = "tensor.empty"() : () -> tensor<f32>
      %62 = "linalg.fill"(%0, %61) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg22: f32, %arg23: f32):
        "linalg.yield"(%arg22) : (f32) -> ()
      }) : (f32, tensor<f32>) -> tensor<f32>
      %63 = "linalg.reduce"(%60, %62) <{dimensions = array<i64: 0>}> ({
      ^bb0(%arg20: f32, %arg21: f32):
        %66 = "arith.addf"(%arg20, %arg21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%66) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<f32>) -> tensor<f32>
      %64 = "tensor.extract"(%63) : (tensor<f32>) -> f32
      %65 = "arith.addf"(%arg19, %64) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%65) : (f32) -> ()
    }) : (index, index, index, f32) -> f32
    %22 = "math.log"(%21) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %23 = "linalg.fill"(%22, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: f32, %arg17: f32):
      "linalg.yield"(%arg16) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    "scf.for"(%1, %18, %2) ({
    ^bb0(%arg5: index):
      %24 = "arith.addi"(%arg5, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %25 = "arith.minsi"(%24, %18) : (index, index) -> index
      %26 = "arith.maxsi"(%25, %arg5) : (index, index) -> index
      %27 = "arith.subi"(%26, %arg5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %28 = "arith.addi"(%12, %arg5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %29 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
      "linalg.fill"(%0, %29) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg14: f32, %arg15: f32):
        "linalg.yield"(%arg14) : (f32) -> ()
      }) : (f32, memref<1024xf32>) -> ()
      %30 = "memref.subview"(%arg0, %28, %27) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %31 = "memref.subview"(%29, %27) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%30, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg12: f32, %arg13: f32):
        "linalg.yield"(%arg12) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %32 = "bufferization.to_tensor"(%29) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
      %33 = "linalg.generic"(%32, %20, %32) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg9: f32, %arg10: f32, %arg11: f32):
        %39 = "arith.subf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%39) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %34 = "linalg.generic"(%33, %23, %33) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
        %38 = "arith.subf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%38) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %35 = "arith.addi"(%15, %arg5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %36 = "tensor.extract_slice"(%34, %27) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xf32>, index) -> tensor<?xf32>
      %37 = "memref.subview"(%arg1, %35, %27) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%36, %37) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

