#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32) -> (), sym_name = "softmax_kernel_inner"}> ({
  ^bb0(%arg12: memref<?xf32>, %arg13: memref<?xf32>, %arg14: i32, %arg15: i32):
    %17 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %18 = "arith.constant"() <{value = 0 : index}> : () -> index
    %19 = "arith.constant"() <{value = 4096 : index}> : () -> index
    %20 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %21 = "tensor.empty"() : () -> tensor<4096xf32>
    %22 = "linalg.fill"(%17, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg117: f32, %arg118: f32):
      "linalg.yield"(%arg117) : (f32) -> ()
    }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
    %23 = "linalg.fill"(%20, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg115: f32, %arg116: f32):
      "linalg.yield"(%arg115) : (f32) -> ()
    }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
    %24 = "func.call"() <{callee = @flag_gems.utils.triton_lang_extension.program_id__c0}> : () -> i64
    %25 = "arith.extsi"(%arg15) : (i32) -> i64
    %26 = "arith.muli"(%24, %25) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %27 = "arith.index_cast"(%26) : (i64) -> index
    %28 = "func.call"(%arg15) <{callee = @flag_gems.ops.softmax.prev_multiple_of__i32_c4096}> : (i32) -> i32
    %29 = "arith.index_cast"(%28) : (i32) -> index
    %30:2 = "scf.for"(%18, %29, %19, %23, %22) ({
    ^bb0(%arg84: index, %arg85: tensor<4096xf32>, %arg86: tensor<4096xf32>):
      %104 = "arith.addi"(%27, %arg84) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %105 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
      %106 = "memref.subview"(%arg13, %104) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4096>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<4096xf32, strided<[1], offset: ?>>
      "linalg.copy"(%106, %105) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg113: f32, %arg114: f32):
        "linalg.yield"(%arg113) : (f32) -> ()
      }) : (memref<4096xf32, strided<[1], offset: ?>>, memref<4096xf32>) -> ()
      %107 = "bufferization.to_tensor"(%105) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
      %108 = "linalg.generic"(%arg85, %107, %arg85) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg110: f32, %arg111: f32, %arg112: f32):
        %126 = "arith.maxnumf"(%arg110, %arg111) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%126) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %109 = "tensor.empty"() : () -> tensor<4096xi1>
      %110 = "linalg.generic"(%108, %23, %109) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg107: f32, %arg108: f32, %arg109: i1):
        %125 = "arith.cmpf"(%arg107, %arg108) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%125) : (i1) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xi1>) -> tensor<4096xi1>
      %111 = "linalg.generic"(%arg85, %108, %arg85) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg104: f32, %arg105: f32, %arg106: f32):
        %124 = "arith.subf"(%arg104, %arg105) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%124) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %112 = "linalg.generic"(%111, %111) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg102: f32, %arg103: f32):
        %123 = "math.exp"(%arg102) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%123) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %113 = "linalg.generic"(%arg86, %112, %arg86) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg99: f32, %arg100: f32, %arg101: f32):
        %122 = "arith.mulf"(%arg99, %arg100) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%122) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %114 = "linalg.generic"(%107, %108, %107) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg96: f32, %arg97: f32, %arg98: f32):
        %121 = "arith.subf"(%arg96, %arg97) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%121) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %115 = "linalg.generic"(%114, %114) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg94: f32, %arg95: f32):
        %120 = "math.exp"(%arg94) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%120) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %116 = "linalg.generic"(%113, %115, %113) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg91: f32, %arg92: f32, %arg93: f32):
        %119 = "arith.addf"(%arg91, %arg92) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%119) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %117 = "linalg.generic"(%110, %arg86, %116, %arg86) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg87: i1, %arg88: f32, %arg89: f32, %arg90: f32):
        %118 = "arith.select"(%arg87, %arg88, %arg89) : (i1, f32, f32) -> f32
        "linalg.yield"(%118) : (f32) -> ()
      }) : (tensor<4096xi1>, tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      "scf.yield"(%108, %117) : (tensor<4096xf32>, tensor<4096xf32>) -> ()
    }) : (index, index, index, tensor<4096xf32>, tensor<4096xf32>) -> (tensor<4096xf32>, tensor<4096xf32>)
    %31 = "arith.index_cast"(%arg15) : (i32) -> index
    %32:2 = "scf.for"(%29, %31, %19, %30#0, %30#1) ({
    ^bb0(%arg51: index, %arg52: tensor<4096xf32>, %arg53: tensor<4096xf32>):
      %76 = "arith.addi"(%arg51, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %77 = "arith.minsi"(%76, %31) : (index, index) -> index
      %78 = "arith.maxsi"(%77, %arg51) : (index, index) -> index
      %79 = "arith.subi"(%78, %arg51) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %80 = "arith.addi"(%27, %arg51) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %81 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
      "linalg.fill"(%20, %81) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg82: f32, %arg83: f32):
        "linalg.yield"(%arg82) : (f32) -> ()
      }) : (f32, memref<4096xf32>) -> ()
      %82 = "memref.subview"(%arg13, %80, %79) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %83 = "memref.subview"(%81, %79) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%82, %83) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg80: f32, %arg81: f32):
        "linalg.yield"(%arg80) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %84 = "bufferization.to_tensor"(%81) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
      %85 = "linalg.generic"(%arg52, %84, %arg52) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg77: f32, %arg78: f32, %arg79: f32):
        %103 = "arith.maxnumf"(%arg77, %arg78) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%103) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %86 = "tensor.empty"() : () -> tensor<4096xi1>
      %87 = "linalg.generic"(%85, %23, %86) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg74: f32, %arg75: f32, %arg76: i1):
        %102 = "arith.cmpf"(%arg74, %arg75) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%102) : (i1) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xi1>) -> tensor<4096xi1>
      %88 = "linalg.generic"(%arg52, %85, %arg52) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg71: f32, %arg72: f32, %arg73: f32):
        %101 = "arith.subf"(%arg71, %arg72) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%101) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %89 = "linalg.generic"(%88, %88) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg69: f32, %arg70: f32):
        %100 = "math.exp"(%arg69) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%100) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %90 = "linalg.generic"(%arg53, %89, %arg53) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg66: f32, %arg67: f32, %arg68: f32):
        %99 = "arith.mulf"(%arg66, %arg67) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%99) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %91 = "linalg.generic"(%84, %85, %84) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg63: f32, %arg64: f32, %arg65: f32):
        %98 = "arith.subf"(%arg63, %arg64) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%98) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %92 = "linalg.generic"(%91, %91) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg61: f32, %arg62: f32):
        %97 = "math.exp"(%arg61) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%97) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %93 = "linalg.generic"(%90, %92, %90) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg58: f32, %arg59: f32, %arg60: f32):
        %96 = "arith.addf"(%arg58, %arg59) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%96) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %94 = "linalg.generic"(%87, %arg53, %93, %arg53) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg54: i1, %arg55: f32, %arg56: f32, %arg57: f32):
        %95 = "arith.select"(%arg54, %arg55, %arg56) : (i1, f32, f32) -> f32
        "linalg.yield"(%95) : (f32) -> ()
      }) : (tensor<4096xi1>, tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      "scf.yield"(%85, %94) : (tensor<4096xf32>, tensor<4096xf32>) -> ()
    }) : (index, index, index, tensor<4096xf32>, tensor<4096xf32>) -> (tensor<4096xf32>, tensor<4096xf32>)
    %33 = "func.call"(%32#0) <{callee = @triton.language.standard.max__fp32S4096S_c0_cFalse_cTrue_cFalse}> : (tensor<4096xf32>) -> f32
    %34 = "linalg.fill"(%33, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg49: f32, %arg50: f32):
      "linalg.yield"(%arg49) : (f32) -> ()
    }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
    %35 = "linalg.generic"(%32#0, %34, %32#0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg46: f32, %arg47: f32, %arg48: f32):
      %75 = "arith.subf"(%arg46, %arg47) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%75) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
    %36 = "linalg.generic"(%35, %35) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg44: f32, %arg45: f32):
      %74 = "math.exp"(%arg44) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%74) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
    %37 = "linalg.generic"(%32#1, %36, %32#1) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg41: f32, %arg42: f32, %arg43: f32):
      %73 = "arith.mulf"(%arg41, %arg42) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%73) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
    %38 = "func.call"(%37) <{callee = @triton.language.standard.sum__fp32S4096S_c0_cFalse_cNone}> : (tensor<4096xf32>) -> f32
    %39 = "func.call"(%arg15) <{callee = @flag_gems.ops.softmax.prev_multiple_of__i32_c4096}> : (i32) -> i32
    %40 = "arith.index_cast"(%39) : (i32) -> index
    %41 = "arith.addi"(%40, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %42 = "arith.minsi"(%41, %31) : (index, index) -> index
    %43 = "arith.maxsi"(%42, %40) : (index, index) -> index
    %44 = "arith.subi"(%43, %40) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %45 = "arith.addi"(%27, %40) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %46 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
    "linalg.fill"(%20, %46) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg39: f32, %arg40: f32):
      "linalg.yield"(%arg39) : (f32) -> ()
    }) : (f32, memref<4096xf32>) -> ()
    %47 = "memref.subview"(%arg13, %45, %44) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %48 = "memref.subview"(%46, %44) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%47, %48) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg37: f32, %arg38: f32):
      "linalg.yield"(%arg37) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %49 = "bufferization.to_tensor"(%46) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
    %50 = "linalg.generic"(%49, %34, %49) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg34: f32, %arg35: f32, %arg36: f32):
      %72 = "arith.subf"(%arg34, %arg35) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%72) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
    %51 = "linalg.generic"(%50, %50) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg32: f32, %arg33: f32):
      %71 = "math.exp"(%arg32) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%71) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
    %52 = "linalg.fill"(%38, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: f32, %arg31: f32):
      "linalg.yield"(%arg30) : (f32) -> ()
    }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
    %53 = "linalg.generic"(%51, %52, %51) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg27: f32, %arg28: f32, %arg29: f32):
      %70 = "arith.divf"(%arg27, %arg28) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%70) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
    %54 = "tensor.extract_slice"(%53, %44) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<4096xf32>, index) -> tensor<?xf32>
    %55 = "memref.subview"(%arg12, %45, %44) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%54, %55) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "scf.for"(%19, %31, %19) ({
    ^bb0(%arg16: index):
      %56 = "arith.index_cast"(%arg16) : (index) -> i32
      %57 = "arith.subi"(%39, %56) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %58 = "arith.index_cast"(%57) : (i32) -> index
      %59 = "arith.addi"(%27, %58) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %60 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
      %61 = "memref.subview"(%arg13, %59) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4096>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<4096xf32, strided<[1], offset: ?>>
      "linalg.copy"(%61, %60) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg25: f32, %arg26: f32):
        "linalg.yield"(%arg25) : (f32) -> ()
      }) : (memref<4096xf32, strided<[1], offset: ?>>, memref<4096xf32>) -> ()
      %62 = "bufferization.to_tensor"(%60) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
      %63 = "linalg.generic"(%62, %34, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg22: f32, %arg23: f32, %arg24: f32):
        %69 = "arith.subf"(%arg22, %arg23) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%69) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %64 = "linalg.generic"(%63, %63) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg20: f32, %arg21: f32):
        %68 = "math.exp"(%arg20) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%68) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %65 = "linalg.generic"(%64, %52, %64) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg17: f32, %arg18: f32, %arg19: f32):
        %67 = "arith.divf"(%arg17, %arg18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%67) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %66 = "memref.subview"(%arg12, %59) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4096>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<4096xf32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%65, %66) <{writable}> : (tensor<4096xf32>, memref<4096xf32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "flag_gems.utils.triton_lang_extension.program_id__c0", sym_visibility = "private"}> ({
    %14 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %15 = "arith.index_cast"(%14) : (index) -> i32
    %16 = "arith.extsi"(%15) : (i32) -> i64
    "func.return"(%16) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "flag_gems.ops.softmax.prev_multiple_of__i32_c4096", sym_visibility = "private"}> ({
  ^bb0(%arg11: i32):
    %10 = "arith.constant"() <{value = 4096 : i32}> : () -> i32
    %11 = "func.call"(%arg11) <{callee = @triton.language.standard.cdiv__i32_c4096}> : (i32) -> i32
    %12 = "arith.muli"(%11, %10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %13 = "arith.subi"(%12, %10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%13) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c4096", sym_visibility = "private"}> ({
  ^bb0(%arg10: i32):
    %6 = "arith.constant"() <{value = 4096 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 4095 : i32}> : () -> i32
    %8 = "arith.addi"(%arg10, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %9 = "arith.divsi"(%8, %6) : (i32, i32) -> i32
    "func.return"(%9) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4096xf32>) -> f32, sym_name = "triton.language.standard.max__fp32S4096S_c0_cFalse_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg7: tensor<4096xf32>):
    %4 = "tt.reduce"(%arg7) <{axis = 0 : i32}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %5 = "func.call"(%arg8, %arg9) <{callee = @triton.language.standard._elementwise_max__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%5) : (f32) -> ()
    }) : (tensor<4096xf32>) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._elementwise_max__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg5: f32, %arg6: f32):
    %3 = "arith.maxnumf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%3) : (f32) -> ()
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

