#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, f32) -> (), sym_name = "_layer_norm_fwd_fused"}> ({
  ^bb0(%arg7: memref<?xf32>, %arg8: memref<?xf32>, %arg9: memref<?xf32>, %arg10: memref<?xf32>, %arg11: memref<?xf32>, %arg12: memref<?xf32>, %arg13: i32, %arg14: i32, %arg15: f32):
    %6 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 0 : index}> : () -> index
    %8 = "arith.constant"() <{value = 8192 : index}> : () -> index
    %9 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %10 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %11 = "tensor.empty"() : () -> tensor<8192xf32>
    %12 = "linalg.fill"(%9, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg90: f32, %arg91: f32):
      "linalg.yield"(%arg90) : (f32) -> ()
    }) : (f32, tensor<8192xf32>) -> tensor<8192xf32>
    %13 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %14 = "arith.index_cast"(%13) : (index) -> i32
    %15 = "arith.muli"(%14, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %16 = "arith.index_cast"(%15) : (i32) -> index
    %17 = "func.call"() <{callee = @triton.language.standard.zeros__Tc8192T_cfp32}> : () -> tensor<8192xf32>
    %18 = "arith.index_cast"(%arg14) : (i32) -> index
    %19 = "scf.for"(%7, %18, %8, %17) ({
    ^bb0(%arg81: index, %arg82: tensor<8192xf32>):
      %98 = "arith.addi"(%arg81, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %99 = "arith.minsi"(%98, %18) : (index, index) -> index
      %100 = "arith.maxsi"(%99, %arg81) : (index, index) -> index
      %101 = "arith.subi"(%100, %arg81) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %102 = "arith.addi"(%16, %arg81) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %103 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8192xf32>
      "linalg.fill"(%9, %103) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg88: f32, %arg89: f32):
        "linalg.yield"(%arg88) : (f32) -> ()
      }) : (f32, memref<8192xf32>) -> ()
      %104 = "memref.subview"(%arg7, %102, %101) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %105 = "memref.subview"(%103, %101) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<8192xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%104, %105) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg86: f32, %arg87: f32):
        "linalg.yield"(%arg86) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %106 = "bufferization.to_tensor"(%103) <{restrict, writable}> : (memref<8192xf32>) -> tensor<8192xf32>
      %107 = "linalg.generic"(%arg82, %106, %arg82) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg83: f32, %arg84: f32, %arg85: f32):
        %108 = "arith.addf"(%arg83, %arg84) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%108) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      "scf.yield"(%107) : (tensor<8192xf32>) -> ()
    }) : (index, index, index, tensor<8192xf32>) -> tensor<8192xf32>
    %20 = "func.call"(%19) <{callee = @triton.language.standard.sum__fp32S8192S_c0_cFalse_cNone}> : (tensor<8192xf32>) -> f32
    %21 = "arith.sitofp"(%arg14) : (i32) -> f32
    %22 = "arith.divf"(%20, %21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %23 = "func.call"() <{callee = @triton.language.standard.zeros__Tc8192T_cfp32}> : () -> tensor<8192xf32>
    %24 = "scf.for"(%7, %18, %8, %23) ({
    ^bb0(%arg49: index, %arg50: tensor<8192xf32>):
      %64 = "arith.index_cast"(%arg49) : (index) -> i32
      %65 = "tensor.empty"() : () -> tensor<8192xi32>
      %66 = "linalg.generic"(%65) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
      ^bb0(%arg80: i32):
        %96 = "linalg.index"() <{dim = 0 : i64}> : () -> index
        %97 = "arith.index_cast"(%96) : (index) -> i32
        "linalg.yield"(%97) : (i32) -> ()
      }) : (tensor<8192xi32>) -> tensor<8192xi32>
      %67 = "arith.addi"(%arg49, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %68 = "arith.minsi"(%67, %18) : (index, index) -> index
      %69 = "arith.maxsi"(%68, %arg49) : (index, index) -> index
      %70 = "arith.subi"(%69, %arg49) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %71 = "arith.addi"(%16, %arg49) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %72 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8192xf32>
      "linalg.fill"(%9, %72) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg78: f32, %arg79: f32):
        "linalg.yield"(%arg78) : (f32) -> ()
      }) : (f32, memref<8192xf32>) -> ()
      %73 = "memref.subview"(%arg7, %71, %70) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %74 = "memref.subview"(%72, %70) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<8192xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%73, %74) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg76: f32, %arg77: f32):
        "linalg.yield"(%arg76) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %75 = "bufferization.to_tensor"(%72) <{restrict, writable}> : (memref<8192xf32>) -> tensor<8192xf32>
      %76 = "linalg.fill"(%22, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg74: f32, %arg75: f32):
        "linalg.yield"(%arg74) : (f32) -> ()
      }) : (f32, tensor<8192xf32>) -> tensor<8192xf32>
      %77 = "linalg.generic"(%75, %76, %75) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg71: f32, %arg72: f32, %arg73: f32):
        %95 = "arith.subf"(%arg71, %arg72) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%95) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      %78 = "arith.subi"(%64, %arg14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %79 = "linalg.generic"(%66, %11) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg69: i32, %arg70: f32):
        %94 = "arith.sitofp"(%arg69) : (i32) -> f32
        "linalg.yield"(%94) : (f32) -> ()
      }) : (tensor<8192xi32>, tensor<8192xf32>) -> tensor<8192xf32>
      %80 = "linalg.generic"(%79, %12, %79) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg66: f32, %arg67: f32, %arg68: f32):
        %93 = "arith.addf"(%arg66, %arg67) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%93) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      %81 = "arith.subi"(%10, %78) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %82 = "arith.sitofp"(%81) : (i32) -> f32
      %83 = "linalg.fill"(%82, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg64: f32, %arg65: f32):
        "linalg.yield"(%arg64) : (f32) -> ()
      }) : (f32, tensor<8192xf32>) -> tensor<8192xf32>
      %84 = "tensor.empty"() : () -> tensor<8192xi1>
      %85 = "linalg.generic"(%80, %83, %84) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg61: f32, %arg62: f32, %arg63: i1):
        %92 = "arith.cmpf"(%arg61, %arg62) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%92) : (i1) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xi1>) -> tensor<8192xi1>
      %86 = "linalg.generic"(%85, %77, %12, %77) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg57: i1, %arg58: f32, %arg59: f32, %arg60: f32):
        %91 = "arith.select"(%arg57, %arg58, %arg59) : (i1, f32, f32) -> f32
        "linalg.yield"(%91) : (f32) -> ()
      }) : (tensor<8192xi1>, tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      %87 = "linalg.generic"(%86, %86, %86) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg54: f32, %arg55: f32, %arg56: f32):
        %90 = "arith.mulf"(%arg54, %arg55) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%90) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      %88 = "linalg.generic"(%arg50, %87, %arg50) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg51: f32, %arg52: f32, %arg53: f32):
        %89 = "arith.addf"(%arg51, %arg52) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%89) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      "scf.yield"(%88) : (tensor<8192xf32>) -> ()
    }) : (index, index, index, tensor<8192xf32>) -> tensor<8192xf32>
    %25 = "func.call"(%24) <{callee = @triton.language.standard.sum__fp32S8192S_c0_cFalse_cNone}> : (tensor<8192xf32>) -> f32
    %26 = "arith.divf"(%25, %21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %27 = "arith.addf"(%26, %arg15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %28 = "math.sqrt"(%27) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %29 = "arith.divf"(%6, %28) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %30 = "tensor.empty"() : () -> tensor<1xf32>
    %31 = "linalg.fill"(%22, %30) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg47: f32, %arg48: f32):
      "linalg.yield"(%arg47) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %32 = "memref.subview"(%arg11, %13) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%31, %32) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    %33 = "linalg.fill"(%29, %30) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg45: f32, %arg46: f32):
      "linalg.yield"(%arg45) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %34 = "memref.subview"(%arg12, %13) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%33, %34) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    "scf.for"(%7, %18, %8) ({
    ^bb0(%arg16: index):
      %35 = "arith.addi"(%arg16, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %36 = "arith.minsi"(%35, %18) : (index, index) -> index
      %37 = "arith.maxsi"(%36, %arg16) : (index, index) -> index
      %38 = "arith.subi"(%37, %arg16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %39 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8192xf32>
      "linalg.fill"(%9, %39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg43: f32, %arg44: f32):
        "linalg.yield"(%arg43) : (f32) -> ()
      }) : (f32, memref<8192xf32>) -> ()
      %40 = "memref.subview"(%arg9, %arg16, %38) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %41 = "memref.subview"(%39, %38) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<8192xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%40, %41) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg41: f32, %arg42: f32):
        "linalg.yield"(%arg41) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %42 = "bufferization.to_tensor"(%39) <{restrict, writable}> : (memref<8192xf32>) -> tensor<8192xf32>
      %43 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8192xf32>
      "linalg.fill"(%9, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg39: f32, %arg40: f32):
        "linalg.yield"(%arg39) : (f32) -> ()
      }) : (f32, memref<8192xf32>) -> ()
      %44 = "memref.subview"(%arg10, %arg16, %38) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %45 = "memref.subview"(%43, %38) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<8192xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%44, %45) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg37: f32, %arg38: f32):
        "linalg.yield"(%arg37) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %46 = "bufferization.to_tensor"(%43) <{restrict, writable}> : (memref<8192xf32>) -> tensor<8192xf32>
      %47 = "arith.addi"(%16, %arg16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %48 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8192xf32>
      "linalg.fill"(%9, %48) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg35: f32, %arg36: f32):
        "linalg.yield"(%arg35) : (f32) -> ()
      }) : (f32, memref<8192xf32>) -> ()
      %49 = "memref.subview"(%arg7, %47, %38) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %50 = "memref.subview"(%48, %38) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<8192xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%49, %50) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg33: f32, %arg34: f32):
        "linalg.yield"(%arg33) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %51 = "bufferization.to_tensor"(%48) <{restrict, writable}> : (memref<8192xf32>) -> tensor<8192xf32>
      %52 = "linalg.fill"(%22, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg31: f32, %arg32: f32):
        "linalg.yield"(%arg31) : (f32) -> ()
      }) : (f32, tensor<8192xf32>) -> tensor<8192xf32>
      %53 = "linalg.generic"(%51, %52, %51) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg28: f32, %arg29: f32, %arg30: f32):
        %63 = "arith.subf"(%arg28, %arg29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%63) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      %54 = "linalg.fill"(%29, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg26: f32, %arg27: f32):
        "linalg.yield"(%arg26) : (f32) -> ()
      }) : (f32, tensor<8192xf32>) -> tensor<8192xf32>
      %55 = "linalg.generic"(%53, %54, %53) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg23: f32, %arg24: f32, %arg25: f32):
        %62 = "arith.mulf"(%arg23, %arg24) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%62) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      %56 = "linalg.generic"(%55, %42, %55) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg20: f32, %arg21: f32, %arg22: f32):
        %61 = "arith.mulf"(%arg20, %arg21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%61) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      %57 = "linalg.generic"(%56, %46, %56) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg17: f32, %arg18: f32, %arg19: f32):
        %60 = "arith.addf"(%arg17, %arg18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%60) : (f32) -> ()
      }) : (tensor<8192xf32>, tensor<8192xf32>, tensor<8192xf32>) -> tensor<8192xf32>
      %58 = "tensor.extract_slice"(%57, %38) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<8192xf32>, index) -> tensor<?xf32>
      %59 = "memref.subview"(%arg8, %47, %38) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%58, %59) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<8192xf32>, sym_name = "triton.language.standard.zeros__Tc8192T_cfp32", sym_visibility = "private"}> ({
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "tensor.empty"() : () -> tensor<8192xf32>
    %5 = "linalg.fill"(%3, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<8192xf32>) -> tensor<8192xf32>
    "func.return"(%5) : (tensor<8192xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8192xf32>) -> f32, sym_name = "triton.language.standard.sum__fp32S8192S_c0_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<8192xf32>):
    %1 = "tt.reduce"(%arg2) <{axis = 0 : i32}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%2) : (f32) -> ()
    }) : (tensor<8192xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

