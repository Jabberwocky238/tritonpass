#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, memref<?xf32>, memref<?xf32>, i32, i32, f32) -> (), sym_name = "_layer_norm_fwd_fused"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: memref<?xf32>, %arg6: i32, %arg7: i32, %arg8: f32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 4096 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %5 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "tensor.empty"() : () -> tensor<4096xf32>
    %7 = "linalg.fill"(%0, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg99: f32, %arg100: f32):
      "linalg.yield"(%arg99) : (f32) -> ()
    }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
    %8 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %9 = "arith.index_cast"(%8) : (index) -> i32
    %10 = "arith.muli"(%9, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %11 = "arith.index_cast"(%10) : (i32) -> index
    %12 = "tensor.empty"() : () -> tensor<4096xi32>
    %13 = "linalg.generic"(%12) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg98: i32):
      %118 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %119 = "arith.index_cast"(%118) : (index) -> i32
      "linalg.yield"(%119) : (i32) -> ()
    }) : (tensor<4096xi32>) -> tensor<4096xi32>
    %14 = "arith.index_cast"(%arg7) : (i32) -> index
    %15 = "scf.for"(%2, %14, %3, %7) ({
    ^bb0(%arg87: index, %arg88: tensor<4096xf32>):
      %105 = "arith.addi"(%arg87, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %106 = "arith.minsi"(%105, %14) : (index, index) -> index
      %107 = "arith.maxsi"(%106, %arg87) : (index, index) -> index
      %108 = "arith.subi"(%107, %arg87) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %109 = "arith.addi"(%11, %arg87) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %110 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xbf16>
      "linalg.fill"(%4, %110) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg96: bf16, %arg97: bf16):
        "linalg.yield"(%arg96) : (bf16) -> ()
      }) : (bf16, memref<4096xbf16>) -> ()
      %111 = "memref.subview"(%arg0, %109, %108) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %112 = "memref.subview"(%110, %108) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%111, %112) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg94: bf16, %arg95: bf16):
        "linalg.yield"(%arg94) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %113 = "bufferization.to_tensor"(%110) <{restrict, writable}> : (memref<4096xbf16>) -> tensor<4096xbf16>
      %114 = "linalg.generic"(%113, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg92: bf16, %arg93: f32):
        %117 = "arith.extf"(%arg92) : (bf16) -> f32
        "linalg.yield"(%117) : (f32) -> ()
      }) : (tensor<4096xbf16>, tensor<4096xf32>) -> tensor<4096xf32>
      %115 = "linalg.generic"(%arg88, %114, %arg88) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg89: f32, %arg90: f32, %arg91: f32):
        %116 = "arith.addf"(%arg89, %arg90) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%116) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      "scf.yield"(%115) : (tensor<4096xf32>) -> ()
    }) : (index, index, index, tensor<4096xf32>) -> tensor<4096xf32>
    %16 = "tensor.empty"() : () -> tensor<f32>
    %17 = "linalg.fill"(%0, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg85: f32, %arg86: f32):
      "linalg.yield"(%arg85) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %18 = "linalg.reduce"(%15, %17) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg83: f32, %arg84: f32):
      %104 = "arith.addf"(%arg83, %arg84) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%104) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<f32>) -> tensor<f32>
    %19 = "tensor.extract"(%18) : (tensor<f32>) -> f32
    %20 = "arith.sitofp"(%arg7) : (i32) -> f32
    %21 = "arith.divf"(%19, %20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %22 = "linalg.fill"(%21, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg81: f32, %arg82: f32):
      "linalg.yield"(%arg81) : (f32) -> ()
    }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
    %23 = "scf.for"(%2, %14, %3, %7) ({
    ^bb0(%arg50: index, %arg51: tensor<4096xf32>):
      %73 = "arith.index_cast"(%arg50) : (index) -> i32
      %74 = "arith.addi"(%arg50, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %75 = "arith.minsi"(%74, %14) : (index, index) -> index
      %76 = "arith.maxsi"(%75, %arg50) : (index, index) -> index
      %77 = "arith.subi"(%76, %arg50) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %78 = "arith.addi"(%11, %arg50) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %79 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xbf16>
      "linalg.fill"(%4, %79) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg79: bf16, %arg80: bf16):
        "linalg.yield"(%arg79) : (bf16) -> ()
      }) : (bf16, memref<4096xbf16>) -> ()
      %80 = "memref.subview"(%arg0, %78, %77) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %81 = "memref.subview"(%79, %77) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%80, %81) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg77: bf16, %arg78: bf16):
        "linalg.yield"(%arg77) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %82 = "bufferization.to_tensor"(%79) <{restrict, writable}> : (memref<4096xbf16>) -> tensor<4096xbf16>
      %83 = "linalg.generic"(%82, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg75: bf16, %arg76: f32):
        %103 = "arith.extf"(%arg75) : (bf16) -> f32
        "linalg.yield"(%103) : (f32) -> ()
      }) : (tensor<4096xbf16>, tensor<4096xf32>) -> tensor<4096xf32>
      %84 = "linalg.generic"(%83, %22, %83) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg72: f32, %arg73: f32, %arg74: f32):
        %102 = "arith.subf"(%arg72, %arg73) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%102) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %85 = "arith.subi"(%73, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %86 = "linalg.generic"(%13, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg70: i32, %arg71: f32):
        %101 = "arith.sitofp"(%arg70) : (i32) -> f32
        "linalg.yield"(%101) : (f32) -> ()
      }) : (tensor<4096xi32>, tensor<4096xf32>) -> tensor<4096xf32>
      %87 = "linalg.generic"(%86, %7, %86) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg67: f32, %arg68: f32, %arg69: f32):
        %100 = "arith.addf"(%arg67, %arg68) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%100) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %88 = "arith.subi"(%5, %85) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %89 = "arith.sitofp"(%88) : (i32) -> f32
      %90 = "linalg.fill"(%89, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg65: f32, %arg66: f32):
        "linalg.yield"(%arg65) : (f32) -> ()
      }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
      %91 = "tensor.empty"() : () -> tensor<4096xi1>
      %92 = "linalg.generic"(%87, %90, %91) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg62: f32, %arg63: f32, %arg64: i1):
        %99 = "arith.cmpf"(%arg62, %arg63) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%99) : (i1) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xi1>) -> tensor<4096xi1>
      %93 = "linalg.generic"(%92, %84, %7, %84) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg58: i1, %arg59: f32, %arg60: f32, %arg61: f32):
        %98 = "arith.select"(%arg58, %arg59, %arg60) : (i1, f32, f32) -> f32
        "linalg.yield"(%98) : (f32) -> ()
      }) : (tensor<4096xi1>, tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %94 = "linalg.generic"(%93, %93, %93) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg55: f32, %arg56: f32, %arg57: f32):
        %97 = "arith.mulf"(%arg55, %arg56) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%97) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %95 = "linalg.generic"(%arg51, %94, %arg51) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg52: f32, %arg53: f32, %arg54: f32):
        %96 = "arith.addf"(%arg52, %arg53) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%96) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      "scf.yield"(%95) : (tensor<4096xf32>) -> ()
    }) : (index, index, index, tensor<4096xf32>) -> tensor<4096xf32>
    %24 = "linalg.reduce"(%23, %17) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg48: f32, %arg49: f32):
      %72 = "arith.addf"(%arg48, %arg49) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%72) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<f32>) -> tensor<f32>
    %25 = "tensor.extract"(%24) : (tensor<f32>) -> f32
    %26 = "arith.divf"(%25, %20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %27 = "arith.addf"(%26, %arg8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %28 = "math.sqrt"(%27) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %29 = "arith.divf"(%1, %28) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %30 = "tensor.empty"() : () -> tensor<1xf32>
    %31 = "linalg.fill"(%21, %30) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg46: f32, %arg47: f32):
      "linalg.yield"(%arg46) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %32 = "memref.subview"(%arg4, %8) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%31, %32) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    %33 = "linalg.fill"(%29, %30) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg44: f32, %arg45: f32):
      "linalg.yield"(%arg44) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %34 = "memref.subview"(%arg5, %8) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%33, %34) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    %35 = "linalg.fill"(%29, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg42: f32, %arg43: f32):
      "linalg.yield"(%arg42) : (f32) -> ()
    }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
    "scf.for"(%2, %14, %3) ({
    ^bb0(%arg9: index):
      %36 = "arith.addi"(%arg9, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %37 = "arith.minsi"(%36, %14) : (index, index) -> index
      %38 = "arith.maxsi"(%37, %arg9) : (index, index) -> index
      %39 = "arith.subi"(%38, %arg9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xbf16>
      "linalg.fill"(%4, %40) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg40: bf16, %arg41: bf16):
        "linalg.yield"(%arg40) : (bf16) -> ()
      }) : (bf16, memref<4096xbf16>) -> ()
      %41 = "memref.subview"(%arg2, %arg9, %39) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %42 = "memref.subview"(%40, %39) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%41, %42) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg38: bf16, %arg39: bf16):
        "linalg.yield"(%arg38) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %43 = "bufferization.to_tensor"(%40) <{restrict, writable}> : (memref<4096xbf16>) -> tensor<4096xbf16>
      %44 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xbf16>
      "linalg.fill"(%4, %44) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg36: bf16, %arg37: bf16):
        "linalg.yield"(%arg36) : (bf16) -> ()
      }) : (bf16, memref<4096xbf16>) -> ()
      %45 = "memref.subview"(%arg3, %arg9, %39) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %46 = "memref.subview"(%44, %39) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%45, %46) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg34: bf16, %arg35: bf16):
        "linalg.yield"(%arg34) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %47 = "bufferization.to_tensor"(%44) <{restrict, writable}> : (memref<4096xbf16>) -> tensor<4096xbf16>
      %48 = "arith.addi"(%11, %arg9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %49 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xbf16>
      "linalg.fill"(%4, %49) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg32: bf16, %arg33: bf16):
        "linalg.yield"(%arg32) : (bf16) -> ()
      }) : (bf16, memref<4096xbf16>) -> ()
      %50 = "memref.subview"(%arg0, %48, %39) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %51 = "memref.subview"(%49, %39) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%50, %51) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg30: bf16, %arg31: bf16):
        "linalg.yield"(%arg30) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %52 = "bufferization.to_tensor"(%49) <{restrict, writable}> : (memref<4096xbf16>) -> tensor<4096xbf16>
      %53 = "linalg.generic"(%52, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg28: bf16, %arg29: f32):
        %71 = "arith.extf"(%arg28) : (bf16) -> f32
        "linalg.yield"(%71) : (f32) -> ()
      }) : (tensor<4096xbf16>, tensor<4096xf32>) -> tensor<4096xf32>
      %54 = "linalg.generic"(%53, %22, %53) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg25: f32, %arg26: f32, %arg27: f32):
        %70 = "arith.subf"(%arg25, %arg26) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%70) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %55 = "linalg.generic"(%54, %35, %54) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg22: f32, %arg23: f32, %arg24: f32):
        %69 = "arith.mulf"(%arg22, %arg23) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%69) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %56 = "linalg.generic"(%43, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg20: bf16, %arg21: f32):
        %68 = "arith.extf"(%arg20) : (bf16) -> f32
        "linalg.yield"(%68) : (f32) -> ()
      }) : (tensor<4096xbf16>, tensor<4096xf32>) -> tensor<4096xf32>
      %57 = "linalg.generic"(%55, %56, %55) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg17: f32, %arg18: f32, %arg19: f32):
        %67 = "arith.mulf"(%arg17, %arg18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%67) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %58 = "linalg.generic"(%47, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg15: bf16, %arg16: f32):
        %66 = "arith.extf"(%arg15) : (bf16) -> f32
        "linalg.yield"(%66) : (f32) -> ()
      }) : (tensor<4096xbf16>, tensor<4096xf32>) -> tensor<4096xf32>
      %59 = "linalg.generic"(%57, %58, %57) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg12: f32, %arg13: f32, %arg14: f32):
        %65 = "arith.addf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%65) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %60 = "tensor.empty"() : () -> tensor<4096xbf16>
      %61 = "linalg.generic"(%59, %60) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg10: f32, %arg11: bf16):
        %64 = "arith.truncf"(%arg10) : (f32) -> bf16
        "linalg.yield"(%64) : (bf16) -> ()
      }) : (tensor<4096xf32>, tensor<4096xbf16>) -> tensor<4096xbf16>
      %62 = "tensor.extract_slice"(%61, %39) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<4096xbf16>, index) -> tensor<?xbf16>
      %63 = "memref.subview"(%arg1, %48, %39) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%62, %63) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

