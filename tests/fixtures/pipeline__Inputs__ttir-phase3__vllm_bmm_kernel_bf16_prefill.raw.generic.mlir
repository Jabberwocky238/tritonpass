#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map4 = affine_map<(d0, d1) -> (d0, d1)>
#map5 = affine_map<(d0, d1) -> (d0, 0)>
#map6 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "bmm_kernel"}> ({
  ^bb0(%arg4: memref<?xbf16>, %arg5: memref<?xbf16>, %arg6: memref<?xbf16>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32, %arg15: i32, %arg16: i32):
    %11 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %12 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %13 = "arith.constant"() <{value = 0 : index}> : () -> index
    %14 = "arith.constant"() <{value = 1 : index}> : () -> index
    %15 = "arith.constant"() <{value = 128 : index}> : () -> index
    %16 = "arith.constant"() <{value = 64 : index}> : () -> index
    %17 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %18 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %19 = "builtin.unrealized_conversion_cast"(%arg6) : (memref<?xbf16>) -> !tt.ptr<bf16>
    %20 = "tensor.empty"() : () -> tensor<128xi32>
    %21 = "linalg.fill"(%11, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg93: i32, %arg94: i32):
      "linalg.yield"(%arg93) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %22 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %23 = "arith.index_cast"(%22) : (index) -> i32
    %24 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %25 = "arith.index_cast"(%24) : (index) -> i32
    %26 = "arith.cmpi"(%23, %arg7) <{predicate = 5 : i64}> : (i32, i32) -> i1
    "cf.cond_br"(%26)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    %27 = "func.call"(%arg8) <{callee = @triton.language.standard.cdiv__i32_c128}> : (i32) -> i32
    %28 = "func.call"(%arg9) <{callee = @triton.language.standard.cdiv__i32_c128}> : (i32) -> i32
    %29 = "arith.divsi"(%25, %28) : (i32, i32) -> i32
    %30 = "arith.remsi"(%25, %28) : (i32, i32) -> i32
    %31 = "arith.cmpi"(%29, %27) <{predicate = 5 : i64}> : (i32, i32) -> i1
    %32 = "arith.cmpi"(%30, %28) <{predicate = 5 : i64}> : (i32, i32) -> i1
    %33 = "arith.ori"(%31, %32) : (i1, i1) -> i1
    "cf.cond_br"(%33)[^bb1, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    %34 = "arith.muli"(%29, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %35 = "linalg.generic"(%20) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg92: i32):
      %140 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %141 = "arith.index_cast"(%140) : (index) -> i32
      "linalg.yield"(%141) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %36 = "linalg.fill"(%34, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg90: i32, %arg91: i32):
      "linalg.yield"(%arg90) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %37 = "linalg.generic"(%36, %35, %36) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg87: i32, %arg88: i32, %arg89: i32):
      %139 = "arith.addi"(%arg87, %arg88) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%139) : (i32) -> ()
    }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
    %38 = "arith.muli"(%30, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %39 = "linalg.fill"(%38, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg85: i32, %arg86: i32):
      "linalg.yield"(%arg85) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %40 = "linalg.generic"(%39, %35, %39) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg82: i32, %arg83: i32, %arg84: i32):
      %138 = "arith.addi"(%arg82, %arg83) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%138) : (i32) -> ()
    }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
    %41 = "linalg.fill"(%arg8, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg80: i32, %arg81: i32):
      "linalg.yield"(%arg80) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %42 = "tensor.empty"() : () -> tensor<128xi1>
    %43 = "linalg.generic"(%37, %41, %42) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg77: i32, %arg78: i32, %arg79: i1):
      %137 = "arith.cmpi"(%arg77, %arg78) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%137) : (i1) -> ()
    }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi1>) -> tensor<128xi1>
    %44 = "linalg.fill"(%arg9, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg75: i32, %arg76: i32):
      "linalg.yield"(%arg75) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %45 = "linalg.generic"(%40, %44, %42) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg72: i32, %arg73: i32, %arg74: i1):
      %136 = "arith.cmpi"(%arg72, %arg73) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%136) : (i1) -> ()
    }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi1>) -> tensor<128xi1>
    %46 = "linalg.generic"(%43, %37, %21, %37) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg68: i1, %arg69: i32, %arg70: i32, %arg71: i32):
      %135 = "arith.select"(%arg68, %arg69, %arg70) {tt.contiguity = dense<128> : tensor<1xi32>, tt.divisibility = dense<128> : tensor<1xi32>} : (i1, i32, i32) -> i32
      "linalg.yield"(%135) : (i32) -> ()
    }) : (tensor<128xi1>, tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
    %47 = "linalg.generic"(%45, %40, %21, %40) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg64: i1, %arg65: i32, %arg66: i32, %arg67: i32):
      %134 = "arith.select"(%arg64, %arg65, %arg66) {tt.contiguity = dense<128> : tensor<1xi32>, tt.divisibility = dense<128> : tensor<1xi32>} : (i1, i32, i32) -> i32
      "linalg.yield"(%134) : (i32) -> ()
    }) : (tensor<128xi1>, tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
    %48 = "arith.muli"(%23, %arg11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %49 = "arith.muli"(%23, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %50 = "arith.index_cast"(%49) : (i32) -> index
    %51 = "arith.muli"(%23, %arg15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %52 = "func.call"() <{callee = @triton.language.standard.zeros__Tc128_c128T_cfp32}> : () -> tensor<128x128xf32>
    %53 = "func.call"(%arg10) <{callee = @triton.language.standard.cdiv__i32_c64}> : (i32) -> i32
    %54 = "arith.index_cast"(%53) : (i32) -> index
    %55 = "scf.for"(%13, %54, %14, %52) ({
    ^bb0(%arg43: index, %arg44: tensor<128x128xf32>):
      %80 = "arith.index_cast"(%arg43) : (index) -> i32
      %81 = "arith.muli"(%80, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %82 = "arith.index_cast"(%81) : (i32) -> index
      %83 = "linalg.fill"(%arg12, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg62: i32, %arg63: i32):
        "linalg.yield"(%arg62) : (i32) -> ()
      }) : (i32, tensor<128xi32>) -> tensor<128xi32>
      %84 = "linalg.generic"(%46, %83, %46) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg59: i32, %arg60: i32, %arg61: i32):
        %133 = "arith.muli"(%arg59, %arg60) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%133) : (i32) -> ()
      }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
      %85 = "linalg.fill"(%48, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg57: i32, %arg58: i32):
        "linalg.yield"(%arg57) : (i32) -> ()
      }) : (i32, tensor<128xi32>) -> tensor<128xi32>
      %86 = "linalg.generic"(%85, %84, %85) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg54: i32, %arg55: i32, %arg56: i32):
        %132 = "arith.addi"(%arg54, %arg55) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%132) : (i32) -> ()
      }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
      %87 = "arith.index_cast"(%arg14) : (i32) -> index
      %88 = "arith.muli"(%82, %87) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %89 = "arith.addi"(%50, %88) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %90 = "arith.subi"(%arg10, %81) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %91 = "arith.index_cast"(%34) : (i32) -> index
      %92 = "arith.addi"(%91, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %93 = "arith.index_cast"(%arg8) : (i32) -> index
      %94 = "arith.minsi"(%92, %93) : (index, index) -> index
      %95 = "arith.maxsi"(%94, %91) : (index, index) -> index
      %96 = "arith.subi"(%95, %91) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %97 = "arith.index_cast"(%90) : (i32) -> index
      %98 = "arith.minsi"(%97, %16) : (index, index) -> index
      %99 = "arith.maxsi"(%98, %13) : (index, index) -> index
      %100 = "arith.minsi"(%96, %15) : (index, index) -> index
      %101 = "arith.minsi"(%99, %16) : (index, index) -> index
      %102 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x64xbf16>
      "linalg.fill"(%17, %102) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg52: bf16, %arg53: bf16):
        "linalg.yield"(%arg52) : (bf16) -> ()
      }) : (bf16, memref<128x64xbf16>) -> ()
      %103 = "arith.minsi"(%100, %15) : (index, index) -> index
      "scf.for"(%13, %103, %14) ({
      ^bb0(%arg51: index):
        %126 = "tensor.extract"(%86, %arg51) : (tensor<128xi32>, index) -> i32
        %127 = "arith.index_cast"(%126) : (i32) -> index
        %128 = "arith.addi"(%127, %82) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %129 = "memref.reinterpret_cast"(%arg4, %128) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1, 64>, static_strides = array<i64: 1, 1>}> : (memref<?xbf16>, index) -> memref<1x64xbf16, strided<[1, 1], offset: ?>>
        %130 = "memref.subview"(%129, %101) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1x64xbf16, strided<[1, 1], offset: ?>>, index) -> memref<1x?xbf16, strided<[1, 1], offset: ?>>
        %131 = "memref.subview"(%102, %arg51, %101) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<128x64xbf16>, index, index) -> memref<1x?xbf16, strided<[64, 1], offset: ?>>
        "memref.copy"(%130, %131) : (memref<1x?xbf16, strided<[1, 1], offset: ?>>, memref<1x?xbf16, strided<[64, 1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      %104 = "bufferization.to_tensor"(%102) <{restrict, writable}> : (memref<128x64xbf16>) -> tensor<128x64xbf16>
      %105 = "arith.index_cast"(%38) : (i32) -> index
      %106 = "arith.addi"(%105, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %107 = "arith.index_cast"(%arg9) : (i32) -> index
      %108 = "arith.minsi"(%106, %107) : (index, index) -> index
      %109 = "arith.maxsi"(%108, %105) : (index, index) -> index
      %110 = "arith.subi"(%109, %105) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %111 = "arith.minsi"(%110, %15) : (index, index) -> index
      %112 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xbf16>
      "linalg.fill"(%17, %112) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg49: bf16, %arg50: bf16):
        "linalg.yield"(%arg49) : (bf16) -> ()
      }) : (bf16, memref<64x128xbf16>) -> ()
      %113 = "arith.minsi"(%111, %15) : (index, index) -> index
      "scf.for"(%13, %113, %14) ({
      ^bb0(%arg48: index):
        %120 = "tensor.extract"(%47, %arg48) : (tensor<128xi32>, index) -> i32
        %121 = "arith.index_cast"(%120) : (i32) -> index
        %122 = "arith.addi"(%89, %121) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %123 = "memref.reinterpret_cast"(%arg5, %122, %87) <{operandSegmentSizes = array<i32: 1, 1, 0, 1>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 64, 1>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xbf16>, index, index) -> memref<64x1xbf16, strided<[?, 1], offset: ?>>
        %124 = "memref.subview"(%123, %101) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (memref<64x1xbf16, strided<[?, 1], offset: ?>>, index) -> memref<?x1xbf16, strided<[?, 1], offset: ?>>
        %125 = "memref.subview"(%112, %arg48, %101) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (memref<64x128xbf16>, index, index) -> memref<?x1xbf16, strided<[128, 1], offset: ?>>
        "memref.copy"(%124, %125) : (memref<?x1xbf16, strided<[?, 1], offset: ?>>, memref<?x1xbf16, strided<[128, 1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      %114 = "bufferization.to_tensor"(%112) <{restrict, writable}> : (memref<64x128xbf16>) -> tensor<64x128xbf16>
      %115 = "linalg.matmul"(%104, %114, %arg44) <{indexing_maps = [#map1, #map2, #map3], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg45: bf16, %arg46: bf16, %arg47: f32):
        %116 = "arith.extf"(%arg45) : (bf16) -> f32
        %117 = "arith.extf"(%arg46) : (bf16) -> f32
        %118 = "arith.mulf"(%116, %117) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %119 = "arith.addf"(%arg47, %118) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%119) : (f32) -> ()
      }) : (tensor<128x64xbf16>, tensor<64x128xbf16>, tensor<128x128xf32>) -> tensor<128x128xf32>
      "scf.yield"(%115) : (tensor<128x128xf32>) -> ()
    }) : (index, index, index, tensor<128x128xf32>) -> tensor<128x128xf32>
    %56 = "tensor.expand_shape"(%46) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xi32>) -> tensor<128x1xi32>
    %57 = "tensor.empty"() : () -> tensor<128x1xi32>
    %58 = "linalg.fill"(%arg16, %57) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg41: i32, %arg42: i32):
      "linalg.yield"(%arg41) : (i32) -> ()
    }) : (i32, tensor<128x1xi32>) -> tensor<128x1xi32>
    %59 = "linalg.generic"(%58, %56, %58) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg38: i32, %arg39: i32, %arg40: i32):
      %79 = "arith.muli"(%arg38, %arg39) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%79) : (i32) -> ()
    }) : (tensor<128x1xi32>, tensor<128x1xi32>, tensor<128x1xi32>) -> tensor<128x1xi32>
    %60 = "linalg.fill"(%51, %57) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg36: i32, %arg37: i32):
      "linalg.yield"(%arg36) : (i32) -> ()
    }) : (i32, tensor<128x1xi32>) -> tensor<128x1xi32>
    %61 = "linalg.generic"(%60, %59, %60) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg33: i32, %arg34: i32, %arg35: i32):
      %78 = "arith.addi"(%arg33, %arg34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%78) : (i32) -> ()
    }) : (tensor<128x1xi32>, tensor<128x1xi32>, tensor<128x1xi32>) -> tensor<128x1xi32>
    %62 = "tensor.expand_shape"(%47) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xi32>) -> tensor<1x128xi32>
    %63 = "tensor.empty"() : () -> tensor<128x128xi32>
    %64 = "linalg.generic"(%61, %63) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg31: i32, %arg32: i32):
      "linalg.yield"(%arg31) : (i32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<128x1xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
    %65 = "linalg.generic"(%62, %63) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x128xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
    %66 = "linalg.generic"(%64, %65, %64) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %77 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%77) : (i32) -> ()
    }) : (tensor<128x128xi32>, tensor<128x128xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
    %67 = "tensor.expand_shape"(%43) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xi1>) -> tensor<128x1xi1>
    %68 = "tensor.expand_shape"(%45) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xi1>) -> tensor<1x128xi1>
    %69 = "tensor.empty"() : () -> tensor<128x128xi1>
    %70 = "linalg.generic"(%67, %69) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i1, %arg25: i1):
      "linalg.yield"(%arg24) : (i1) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<128x1xi1>, tensor<128x128xi1>) -> tensor<128x128xi1>
    %71 = "linalg.generic"(%68, %69) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg22: i1, %arg23: i1):
      "linalg.yield"(%arg22) : (i1) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x128xi1>, tensor<128x128xi1>) -> tensor<128x128xi1>
    %72 = "linalg.generic"(%70, %71, %70) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg19: i1, %arg20: i1, %arg21: i1):
      %76 = "arith.andi"(%arg19, %arg20) : (i1, i1) -> i1
      "linalg.yield"(%76) : (i1) -> ()
    }) : (tensor<128x128xi1>, tensor<128x128xi1>, tensor<128x128xi1>) -> tensor<128x128xi1>
    %73 = "tensor.empty"() : () -> tensor<128x128xbf16>
    %74 = "linalg.generic"(%55, %73) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: f32, %arg18: bf16):
      %75 = "arith.truncf"(%arg17) : (f32) -> bf16
      "linalg.yield"(%75) : (bf16) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xbf16>) -> tensor<128x128xbf16>
    "tts.scatter"(%19, %66, %74, %72) : (!tt.ptr<bf16>, tensor<128x128xi32>, tensor<128x128xbf16>, tensor<128x128xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c128", sym_visibility = "private"}> ({
  ^bb0(%arg3: i32):
    %7 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %8 = "arith.constant"() <{value = 127 : i32}> : () -> i32
    %9 = "arith.addi"(%arg3, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %10 = "arith.divsi"(%9, %7) : (i32, i32) -> i32
    "func.return"(%10) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<128x128xf32>, sym_name = "triton.language.standard.zeros__Tc128_c128T_cfp32", sym_visibility = "private"}> ({
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "tensor.empty"() : () -> tensor<128x128xf32>
    %6 = "linalg.fill"(%4, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
    "func.return"(%6) : (tensor<128x128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c64", sym_visibility = "private"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 63 : i32}> : () -> i32
    %2 = "arith.addi"(%arg0, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %3 = "arith.divsi"(%2, %0) : (i32, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

