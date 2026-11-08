#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, f32) -> (), sym_name = "_layer_norm_fwd_fused"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: memref<?xf32>, %arg4: memref<?xf32>, %arg5: memref<?xf32>, %arg6: i32, %arg7: i32, %arg8: f32):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8192 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %5 = "tensor.empty"() : () -> tensor<8192xf32>
    %6 = "linalg.fill"(%3, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg87: f32, %arg88: f32):
      "linalg.yield"(%arg87) : (f32) -> ()
    }) : (f32, tensor<8192xf32>) -> tensor<8192xf32>
    %7 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %8 = "arith.index_cast"(%7) : (index) -> i32
    %9 = "arith.muli"(%8, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %10 = "arith.index_cast"(%9) : (i32) -> index
    %11 = "tensor.empty"() : () -> tensor<8192xi32>
    %12 = "linalg.generic"(%11) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg86: i32):
      %104 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %105 = "arith.index_cast"(%104) : (index) -> i32
      "linalg.yield"(%105) : (i32) -> ()
    }) : (tensor<8192xi32>) -> tensor<8192xi32>
    %13 = "arith.index_cast"(%arg7) : (i32) -> index
    %14 = "scf.for"(%1, %13, %2, %6) ({
    ^bb0(%arg77: index, %arg78: tensor<8192xf32>):
      %93 = "arith.addi"(%arg77, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %94 = "arith.minsi"(%93, %13) : (index, index) -> index
      %95 = "arith.maxsi"(%94, %arg77) : (index, index) -> index
      %96 = "arith.subi"(%95, %arg77) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %97 = "arith.addi"(%10, %arg77) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %98 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8192xf32>
      "linalg.fill"(%3, %98) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg84: f32, %arg85: f32):
        "linalg.yield"(%arg84) : (f32) -> ()
      }) : (f32, memref<8192xf32>) -> ()
      %99 = "memref.subview"(%arg0, %97, %96) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %100 = "memref.subview"(%98, %96) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<8192xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%99, %100) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg82: f32, %arg83: f32):
        "linalg.yield"(%arg82) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %101 = "bufferization.to_tensor"(%98) <{restrict, writable}> : (memref<8192xf32>) -> tensor<8192xf32>
      %102 = "linalg.generic"(%arg78, %101, %arg78) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg79: f32, %arg80: f32, %arg81: f32):
        %103 = "arith.addf"(%arg79, %arg80) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%103) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      "scf.yield"(%102) : (tensor<8192xf32>) -> ()
    }) : (index, index, index, tensor<8192xf32>) -> tensor<8192xf32>
    %15 = "tensor.empty"() : () -> tensor<f32>
    %16 = "linalg.fill"(%3, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg75: f32, %arg76: f32):
      "linalg.yield"(%arg75) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %17 = "linalg.reduce"(%14, %16) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg73: f32, %arg74: f32):
      %92 = "arith.addf"(%arg73, %arg74) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%92) : (f32) -> ()
    }) : (tensor<8192xf32>, tensor<f32>) -> tensor<f32>
    %18 = "tensor.extract"(%17) : (tensor<f32>) -> f32
    %19 = "arith.sitofp"(%arg7) : (i32) -> f32
    %20 = "arith.divf"(%18, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %21 = "linalg.fill"(%20, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg71: f32, %arg72: f32):
      "linalg.yield"(%arg71) : (f32) -> ()
    }) : (f32, tensor<8192xf32>) -> tensor<8192xf32>
    %22 = "scf.for"(%1, %13, %2, %6) ({
    ^bb0(%arg42: index, %arg43: tensor<8192xf32>):
      %63 = "arith.index_cast"(%arg42) : (index) -> i32
      %64 = "arith.addi"(%arg42, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %65 = "arith.minsi"(%64, %13) : (index, index) -> index
      %66 = "arith.maxsi"(%65, %arg42) : (index, index) -> index
      %67 = "arith.subi"(%66, %arg42) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %68 = "arith.addi"(%10, %arg42) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %69 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8192xf32>
      "linalg.fill"(%3, %69) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg69: f32, %arg70: f32):
        "linalg.yield"(%arg69) : (f32) -> ()
      }) : (f32, memref<8192xf32>) -> ()
      %70 = "memref.subview"(%arg0, %68, %67) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %71 = "memref.subview"(%69, %67) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<8192xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%70, %71) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg67: f32, %arg68: f32):
        "linalg.yield"(%arg67) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %72 = "bufferization.to_tensor"(%69) <{restrict, writable}> : (memref<8192xf32>) -> tensor<8192xf32>
      %73 = "linalg.generic"(%72, %21, %72) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg64: f32, %arg65: f32, %arg66: f32):
        %91 = "arith.subf"(%arg64, %arg65) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%91) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      %74 = "arith.subi"(%63, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %75 = "linalg.generic"(%12, %5) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg62: i32, %arg63: f32):
        %90 = "arith.sitofp"(%arg62) : (i32) -> f32
        "linalg.yield"(%90) : (f32) -> ()
      }) : (tensor<8192xi32>, tensor<8192xf32>) -> tensor<8192xf32>
      %76 = "linalg.generic"(%75, %6, %75) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg59: f32, %arg60: f32, %arg61: f32):
        %89 = "arith.addf"(%arg59, %arg60) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%89) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      %77 = "arith.subi"(%4, %74) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %78 = "arith.sitofp"(%77) : (i32) -> f32
      %79 = "linalg.fill"(%78, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg57: f32, %arg58: f32):
        "linalg.yield"(%arg57) : (f32) -> ()
      }) : (f32, tensor<8192xf32>) -> tensor<8192xf32>
      %80 = "tensor.empty"() : () -> tensor<8192xi1>
      %81 = "linalg.generic"(%76, %79, %80) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg54: f32, %arg55: f32, %arg56: i1):
        %88 = "arith.cmpf"(%arg54, %arg55) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%88) : (i1) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xi1>) -> tensor<8192xi1>
      %82 = "linalg.generic"(%81, %73, %6, %73) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg50: i1, %arg51: f32, %arg52: f32, %arg53: f32):
        %87 = "arith.select"(%arg50, %arg51, %arg52) : (i1, f32, f32) -> f32
        "linalg.yield"(%87) : (f32) -> ()
      }) : (tensor<8192xi1>, tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      %83 = "linalg.generic"(%82, %82, %82) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg47: f32, %arg48: f32, %arg49: f32):
        %86 = "arith.mulf"(%arg47, %arg48) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%86) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      %84 = "linalg.generic"(%arg43, %83, %arg43) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg44: f32, %arg45: f32, %arg46: f32):
        %85 = "arith.addf"(%arg44, %arg45) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%85) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      "scf.yield"(%84) : (tensor<8192xf32>) -> ()
    }) : (index, index, index, tensor<8192xf32>) -> tensor<8192xf32>
    %23 = "linalg.reduce"(%22, %16) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg40: f32, %arg41: f32):
      %62 = "arith.addf"(%arg40, %arg41) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%62) : (f32) -> ()
    }) : (tensor<8192xf32>, tensor<f32>) -> tensor<f32>
    %24 = "tensor.extract"(%23) : (tensor<f32>) -> f32
    %25 = "arith.divf"(%24, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %26 = "arith.addf"(%25, %arg8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %27 = "math.sqrt"(%26) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %28 = "arith.divf"(%0, %27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %29 = "tensor.empty"() : () -> tensor<1xf32>
    %30 = "linalg.fill"(%20, %29) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg38: f32, %arg39: f32):
      "linalg.yield"(%arg38) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %31 = "memref.subview"(%arg4, %7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%30, %31) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    %32 = "linalg.fill"(%28, %29) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg36: f32, %arg37: f32):
      "linalg.yield"(%arg36) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %33 = "memref.subview"(%arg5, %7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%32, %33) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    %34 = "linalg.fill"(%28, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg34: f32, %arg35: f32):
      "linalg.yield"(%arg34) : (f32) -> ()
    }) : (f32, tensor<8192xf32>) -> tensor<8192xf32>
    "scf.for"(%1, %13, %2) ({
    ^bb0(%arg9: index):
      %35 = "arith.addi"(%arg9, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %36 = "arith.minsi"(%35, %13) : (index, index) -> index
      %37 = "arith.maxsi"(%36, %arg9) : (index, index) -> index
      %38 = "arith.subi"(%37, %arg9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %39 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8192xf32>
      "linalg.fill"(%3, %39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg32: f32, %arg33: f32):
        "linalg.yield"(%arg32) : (f32) -> ()
      }) : (f32, memref<8192xf32>) -> ()
      %40 = "memref.subview"(%arg2, %arg9, %38) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %41 = "memref.subview"(%39, %38) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<8192xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%40, %41) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg30: f32, %arg31: f32):
        "linalg.yield"(%arg30) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %42 = "bufferization.to_tensor"(%39) <{restrict, writable}> : (memref<8192xf32>) -> tensor<8192xf32>
      %43 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8192xf32>
      "linalg.fill"(%3, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg28: f32, %arg29: f32):
        "linalg.yield"(%arg28) : (f32) -> ()
      }) : (f32, memref<8192xf32>) -> ()
      %44 = "memref.subview"(%arg3, %arg9, %38) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %45 = "memref.subview"(%43, %38) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<8192xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%44, %45) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg26: f32, %arg27: f32):
        "linalg.yield"(%arg26) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %46 = "bufferization.to_tensor"(%43) <{restrict, writable}> : (memref<8192xf32>) -> tensor<8192xf32>
      %47 = "arith.addi"(%10, %arg9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %48 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8192xf32>
      "linalg.fill"(%3, %48) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg24: f32, %arg25: f32):
        "linalg.yield"(%arg24) : (f32) -> ()
      }) : (f32, memref<8192xf32>) -> ()
      %49 = "memref.subview"(%arg0, %47, %38) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %50 = "memref.subview"(%48, %38) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<8192xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%49, %50) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg22: f32, %arg23: f32):
        "linalg.yield"(%arg22) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %51 = "bufferization.to_tensor"(%48) <{restrict, writable}> : (memref<8192xf32>) -> tensor<8192xf32>
      %52 = "linalg.generic"(%51, %21, %51) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg19: f32, %arg20: f32, %arg21: f32):
        %61 = "arith.subf"(%arg19, %arg20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%61) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      %53 = "linalg.generic"(%52, %34, %52) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg16: f32, %arg17: f32, %arg18: f32):
        %60 = "arith.mulf"(%arg16, %arg17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%60) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      %54 = "linalg.generic"(%53, %42, %53) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg13: f32, %arg14: f32, %arg15: f32):
        %59 = "arith.mulf"(%arg13, %arg14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%59) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      %55 = "linalg.generic"(%54, %46, %54) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg10: f32, %arg11: f32, %arg12: f32):
        %58 = "arith.addf"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%58) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      %56 = "tensor.extract_slice"(%55, %38) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<8192xf32>, index) -> tensor<?xf32>
      %57 = "memref.subview"(%arg1, %47, %38) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%56, %57) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

