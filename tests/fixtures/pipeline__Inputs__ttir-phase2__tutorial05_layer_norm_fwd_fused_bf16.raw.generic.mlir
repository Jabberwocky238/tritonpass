#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, memref<?xf32>, memref<?xf32>, i32, i32, f32) -> (), sym_name = "_layer_norm_fwd_fused"}> ({
  ^bb0(%arg7: memref<?xbf16>, %arg8: memref<?xbf16>, %arg9: memref<?xbf16>, %arg10: memref<?xbf16>, %arg11: memref<?xf32>, %arg12: memref<?xf32>, %arg13: i32, %arg14: i32, %arg15: f32):
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = 0 : index}> : () -> index
    %9 = "arith.constant"() <{value = 4096 : index}> : () -> index
    %10 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %11 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %12 = "tensor.empty"() : () -> tensor<4096xf32>
    %13 = "linalg.fill"(%6, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg102: f32, %arg103: f32):
      "linalg.yield"(%arg102) : (f32) -> ()
    }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
    %14 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %15 = "arith.index_cast"(%14) : (index) -> i32
    %16 = "arith.muli"(%15, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %17 = "arith.index_cast"(%16) : (i32) -> index
    %18 = "func.call"() <{callee = @triton.language.standard.zeros__Tc4096T_cfp32}> : () -> tensor<4096xf32>
    %19 = "arith.index_cast"(%arg14) : (i32) -> index
    %20 = "scf.for"(%8, %19, %9, %18) ({
    ^bb0(%arg91: index, %arg92: tensor<4096xf32>):
      %110 = "arith.addi"(%arg91, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %111 = "arith.minsi"(%110, %19) : (index, index) -> index
      %112 = "arith.maxsi"(%111, %arg91) : (index, index) -> index
      %113 = "arith.subi"(%112, %arg91) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %114 = "arith.addi"(%17, %arg91) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %115 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xbf16>
      "linalg.fill"(%10, %115) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg100: bf16, %arg101: bf16):
        "linalg.yield"(%arg100) : (bf16) -> ()
      }) : (bf16, memref<4096xbf16>) -> ()
      %116 = "memref.subview"(%arg7, %114, %113) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %117 = "memref.subview"(%115, %113) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%116, %117) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg98: bf16, %arg99: bf16):
        "linalg.yield"(%arg98) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %118 = "bufferization.to_tensor"(%115) <{restrict, writable}> : (memref<4096xbf16>) -> tensor<4096xbf16>
      %119 = "linalg.generic"(%118, %12) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg96: bf16, %arg97: f32):
        %122 = "arith.extf"(%arg96) : (bf16) -> f32
        "linalg.yield"(%122) : (f32) -> ()
      }) : (tensor<4096xbf16>, tensor<4096xf32>) -> tensor<4096xf32>
      %120 = "linalg.generic"(%arg92, %119, %arg92) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg93: f32, %arg94: f32, %arg95: f32):
        %121 = "arith.addf"(%arg93, %arg94) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%121) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      "scf.yield"(%120) : (tensor<4096xf32>) -> ()
    }) : (index, index, index, tensor<4096xf32>) -> tensor<4096xf32>
    %21 = "func.call"(%20) <{callee = @triton.language.standard.sum__fp32S4096S_c0_cFalse_cNone}> : (tensor<4096xf32>) -> f32
    %22 = "arith.sitofp"(%arg14) : (i32) -> f32
    %23 = "arith.divf"(%21, %22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %24 = "func.call"() <{callee = @triton.language.standard.zeros__Tc4096T_cfp32}> : () -> tensor<4096xf32>
    %25 = "scf.for"(%8, %19, %9, %24) ({
    ^bb0(%arg57: index, %arg58: tensor<4096xf32>):
      %74 = "arith.index_cast"(%arg57) : (index) -> i32
      %75 = "tensor.empty"() : () -> tensor<4096xi32>
      %76 = "linalg.generic"(%75) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
      ^bb0(%arg90: i32):
        %108 = "linalg.index"() <{dim = 0 : i64}> : () -> index
        %109 = "arith.index_cast"(%108) : (index) -> i32
        "linalg.yield"(%109) : (i32) -> ()
      }) : (tensor<4096xi32>) -> tensor<4096xi32>
      %77 = "arith.addi"(%arg57, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %78 = "arith.minsi"(%77, %19) : (index, index) -> index
      %79 = "arith.maxsi"(%78, %arg57) : (index, index) -> index
      %80 = "arith.subi"(%79, %arg57) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %81 = "arith.addi"(%17, %arg57) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %82 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xbf16>
      "linalg.fill"(%10, %82) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg88: bf16, %arg89: bf16):
        "linalg.yield"(%arg88) : (bf16) -> ()
      }) : (bf16, memref<4096xbf16>) -> ()
      %83 = "memref.subview"(%arg7, %81, %80) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %84 = "memref.subview"(%82, %80) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%83, %84) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg86: bf16, %arg87: bf16):
        "linalg.yield"(%arg86) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %85 = "bufferization.to_tensor"(%82) <{restrict, writable}> : (memref<4096xbf16>) -> tensor<4096xbf16>
      %86 = "linalg.generic"(%85, %12) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg84: bf16, %arg85: f32):
        %107 = "arith.extf"(%arg84) : (bf16) -> f32
        "linalg.yield"(%107) : (f32) -> ()
      }) : (tensor<4096xbf16>, tensor<4096xf32>) -> tensor<4096xf32>
      %87 = "linalg.fill"(%23, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg82: f32, %arg83: f32):
        "linalg.yield"(%arg82) : (f32) -> ()
      }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
      %88 = "linalg.generic"(%86, %87, %86) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg79: f32, %arg80: f32, %arg81: f32):
        %106 = "arith.subf"(%arg79, %arg80) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%106) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %89 = "arith.subi"(%74, %arg14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %90 = "linalg.generic"(%76, %12) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg77: i32, %arg78: f32):
        %105 = "arith.sitofp"(%arg77) : (i32) -> f32
        "linalg.yield"(%105) : (f32) -> ()
      }) : (tensor<4096xi32>, tensor<4096xf32>) -> tensor<4096xf32>
      %91 = "linalg.generic"(%90, %13, %90) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg74: f32, %arg75: f32, %arg76: f32):
        %104 = "arith.addf"(%arg74, %arg75) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%104) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %92 = "arith.subi"(%11, %89) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %93 = "arith.sitofp"(%92) : (i32) -> f32
      %94 = "linalg.fill"(%93, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg72: f32, %arg73: f32):
        "linalg.yield"(%arg72) : (f32) -> ()
      }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
      %95 = "tensor.empty"() : () -> tensor<4096xi1>
      %96 = "linalg.generic"(%91, %94, %95) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg69: f32, %arg70: f32, %arg71: i1):
        %103 = "arith.cmpf"(%arg69, %arg70) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%103) : (i1) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xi1>) -> tensor<4096xi1>
      %97 = "linalg.generic"(%96, %88, %13, %88) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg65: i1, %arg66: f32, %arg67: f32, %arg68: f32):
        %102 = "arith.select"(%arg65, %arg66, %arg67) : (i1, f32, f32) -> f32
        "linalg.yield"(%102) : (f32) -> ()
      }) : (tensor<4096xi1>, tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %98 = "linalg.generic"(%97, %97, %97) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg62: f32, %arg63: f32, %arg64: f32):
        %101 = "arith.mulf"(%arg62, %arg63) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%101) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %99 = "linalg.generic"(%arg58, %98, %arg58) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg59: f32, %arg60: f32, %arg61: f32):
        %100 = "arith.addf"(%arg59, %arg60) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%100) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      "scf.yield"(%99) : (tensor<4096xf32>) -> ()
    }) : (index, index, index, tensor<4096xf32>) -> tensor<4096xf32>
    %26 = "func.call"(%25) <{callee = @triton.language.standard.sum__fp32S4096S_c0_cFalse_cNone}> : (tensor<4096xf32>) -> f32
    %27 = "arith.divf"(%26, %22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %28 = "arith.addf"(%27, %arg15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %29 = "math.sqrt"(%28) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %30 = "arith.divf"(%7, %29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %31 = "tensor.empty"() : () -> tensor<1xf32>
    %32 = "linalg.fill"(%23, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg55: f32, %arg56: f32):
      "linalg.yield"(%arg55) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %33 = "memref.subview"(%arg11, %14) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%32, %33) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    %34 = "linalg.fill"(%30, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg53: f32, %arg54: f32):
      "linalg.yield"(%arg53) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %35 = "memref.subview"(%arg12, %14) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%34, %35) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    "scf.for"(%8, %19, %9) ({
    ^bb0(%arg16: index):
      %36 = "arith.addi"(%arg16, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %37 = "arith.minsi"(%36, %19) : (index, index) -> index
      %38 = "arith.maxsi"(%37, %arg16) : (index, index) -> index
      %39 = "arith.subi"(%38, %arg16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xbf16>
      "linalg.fill"(%10, %40) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg51: bf16, %arg52: bf16):
        "linalg.yield"(%arg51) : (bf16) -> ()
      }) : (bf16, memref<4096xbf16>) -> ()
      %41 = "memref.subview"(%arg9, %arg16, %39) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %42 = "memref.subview"(%40, %39) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%41, %42) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg49: bf16, %arg50: bf16):
        "linalg.yield"(%arg49) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %43 = "bufferization.to_tensor"(%40) <{restrict, writable}> : (memref<4096xbf16>) -> tensor<4096xbf16>
      %44 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xbf16>
      "linalg.fill"(%10, %44) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg47: bf16, %arg48: bf16):
        "linalg.yield"(%arg47) : (bf16) -> ()
      }) : (bf16, memref<4096xbf16>) -> ()
      %45 = "memref.subview"(%arg10, %arg16, %39) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %46 = "memref.subview"(%44, %39) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%45, %46) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg45: bf16, %arg46: bf16):
        "linalg.yield"(%arg45) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %47 = "bufferization.to_tensor"(%44) <{restrict, writable}> : (memref<4096xbf16>) -> tensor<4096xbf16>
      %48 = "arith.addi"(%17, %arg16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %49 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xbf16>
      "linalg.fill"(%10, %49) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg43: bf16, %arg44: bf16):
        "linalg.yield"(%arg43) : (bf16) -> ()
      }) : (bf16, memref<4096xbf16>) -> ()
      %50 = "memref.subview"(%arg7, %48, %39) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      %51 = "memref.subview"(%49, %39) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xbf16>, index) -> memref<?xbf16, strided<[1]>>
      "linalg.copy"(%50, %51) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg41: bf16, %arg42: bf16):
        "linalg.yield"(%arg41) : (bf16) -> ()
      }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
      %52 = "bufferization.to_tensor"(%49) <{restrict, writable}> : (memref<4096xbf16>) -> tensor<4096xbf16>
      %53 = "linalg.generic"(%52, %12) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg39: bf16, %arg40: f32):
        %73 = "arith.extf"(%arg39) : (bf16) -> f32
        "linalg.yield"(%73) : (f32) -> ()
      }) : (tensor<4096xbf16>, tensor<4096xf32>) -> tensor<4096xf32>
      %54 = "linalg.fill"(%23, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg37: f32, %arg38: f32):
        "linalg.yield"(%arg37) : (f32) -> ()
      }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
      %55 = "linalg.generic"(%53, %54, %53) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg34: f32, %arg35: f32, %arg36: f32):
        %72 = "arith.subf"(%arg34, %arg35) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%72) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %56 = "linalg.fill"(%30, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg32: f32, %arg33: f32):
        "linalg.yield"(%arg32) : (f32) -> ()
      }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
      %57 = "linalg.generic"(%55, %56, %55) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg29: f32, %arg30: f32, %arg31: f32):
        %71 = "arith.mulf"(%arg29, %arg30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%71) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %58 = "linalg.generic"(%43, %12) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg27: bf16, %arg28: f32):
        %70 = "arith.extf"(%arg27) : (bf16) -> f32
        "linalg.yield"(%70) : (f32) -> ()
      }) : (tensor<4096xbf16>, tensor<4096xf32>) -> tensor<4096xf32>
      %59 = "linalg.generic"(%57, %58, %57) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg24: f32, %arg25: f32, %arg26: f32):
        %69 = "arith.mulf"(%arg24, %arg25) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%69) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %60 = "linalg.generic"(%47, %12) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg22: bf16, %arg23: f32):
        %68 = "arith.extf"(%arg22) : (bf16) -> f32
        "linalg.yield"(%68) : (f32) -> ()
      }) : (tensor<4096xbf16>, tensor<4096xf32>) -> tensor<4096xf32>
      %61 = "linalg.generic"(%59, %60, %59) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg19: f32, %arg20: f32, %arg21: f32):
        %67 = "arith.addf"(%arg19, %arg20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%67) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %62 = "tensor.empty"() : () -> tensor<4096xbf16>
      %63 = "linalg.generic"(%61, %62) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg17: f32, %arg18: bf16):
        %66 = "arith.truncf"(%arg17) : (f32) -> bf16
        "linalg.yield"(%66) : (bf16) -> ()
      }) : (tensor<4096xf32>, tensor<4096xbf16>) -> tensor<4096xbf16>
      %64 = "tensor.extract_slice"(%63, %39) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<4096xbf16>, index) -> tensor<?xbf16>
      %65 = "memref.subview"(%arg8, %48, %39) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%64, %65) <{writable}> : (tensor<?xbf16>, memref<?xbf16, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<4096xf32>, sym_name = "triton.language.standard.zeros__Tc4096T_cfp32", sym_visibility = "private"}> ({
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "tensor.empty"() : () -> tensor<4096xf32>
    %5 = "linalg.fill"(%3, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
    "func.return"(%5) : (tensor<4096xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4096xf32>) -> f32, sym_name = "triton.language.standard.sum__fp32S4096S_c0_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<4096xf32>):
    %1 = "tt.reduce"(%arg2) <{axis = 0 : i32}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%2) : (f32) -> ()
    }) : (tensor<4096xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

