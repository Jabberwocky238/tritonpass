#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map4 = affine_map<(d0, d1) -> (d0, d1)>
#map5 = affine_map<(d0, d1) -> (d0, 0)>
#map6 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "bmm_kernel"}> ({
  ^bb0(%arg4: memref<?xbf16>, %arg5: memref<?xbf16>, %arg6: memref<?xbf16>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32, %arg15: i32):
    %11 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %12 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %13 = "arith.constant"() <{value = 0 : index}> : () -> index
    %14 = "arith.constant"() <{value = 1 : index}> : () -> index
    %15 = "arith.constant"() <{value = 128 : index}> : () -> index
    %16 = "arith.constant"() <{value = 64 : index}> : () -> index
    %17 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %18 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %19 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %20 = "builtin.unrealized_conversion_cast"(%arg6) : (memref<?xbf16>) -> !tt.ptr<bf16>
    %21 = "tensor.empty"() : () -> tensor<128xi32>
    %22 = "linalg.fill"(%11, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg92: i32, %arg93: i32):
      "linalg.yield"(%arg92) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %23 = "linalg.fill"(%18, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg90: i32, %arg91: i32):
      "linalg.yield"(%arg90) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %24 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %25 = "arith.index_cast"(%24) : (index) -> i32
    %26 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %27 = "arith.index_cast"(%26) : (index) -> i32
    %28 = "arith.cmpi"(%25, %arg7) <{predicate = 5 : i64}> : (i32, i32) -> i1
    "cf.cond_br"(%28)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    "func.call"() <{callee = @triton.language.standard.cdiv__c1_c128}> : () -> ()
    %29 = "func.call"(%arg8) <{callee = @triton.language.standard.cdiv__i32_c128}> : (i32) -> i32
    %30 = "arith.divsi"(%27, %29) : (i32, i32) -> i32
    %31 = "arith.remsi"(%27, %29) : (i32, i32) -> i32
    %32 = "arith.cmpi"(%30, %18) <{predicate = 5 : i64}> : (i32, i32) -> i1
    %33 = "arith.cmpi"(%31, %29) <{predicate = 5 : i64}> : (i32, i32) -> i1
    %34 = "arith.ori"(%32, %33) : (i1, i1) -> i1
    "cf.cond_br"(%34)[^bb1, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    %35 = "arith.muli"(%30, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %36 = "linalg.generic"(%21) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg89: i32):
      %139 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %140 = "arith.index_cast"(%139) : (index) -> i32
      "linalg.yield"(%140) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %37 = "linalg.fill"(%35, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg87: i32, %arg88: i32):
      "linalg.yield"(%arg87) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %38 = "linalg.generic"(%37, %36, %37) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg84: i32, %arg85: i32, %arg86: i32):
      %138 = "arith.addi"(%arg84, %arg85) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%138) : (i32) -> ()
    }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
    %39 = "arith.muli"(%31, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %40 = "linalg.fill"(%39, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg82: i32, %arg83: i32):
      "linalg.yield"(%arg82) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %41 = "linalg.generic"(%40, %36, %40) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg79: i32, %arg80: i32, %arg81: i32):
      %137 = "arith.addi"(%arg79, %arg80) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%137) : (i32) -> ()
    }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
    %42 = "tensor.empty"() : () -> tensor<128xi1>
    %43 = "linalg.generic"(%38, %23, %42) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg76: i32, %arg77: i32, %arg78: i1):
      %136 = "arith.cmpi"(%arg76, %arg77) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%136) : (i1) -> ()
    }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi1>) -> tensor<128xi1>
    %44 = "linalg.fill"(%arg8, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg74: i32, %arg75: i32):
      "linalg.yield"(%arg74) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %45 = "linalg.generic"(%41, %44, %42) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg71: i32, %arg72: i32, %arg73: i1):
      %135 = "arith.cmpi"(%arg71, %arg72) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%135) : (i1) -> ()
    }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi1>) -> tensor<128xi1>
    %46 = "linalg.generic"(%43, %38, %22, %38) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg67: i1, %arg68: i32, %arg69: i32, %arg70: i32):
      %134 = "arith.select"(%arg67, %arg68, %arg69) {tt.contiguity = dense<128> : tensor<1xi32>, tt.divisibility = dense<128> : tensor<1xi32>} : (i1, i32, i32) -> i32
      "linalg.yield"(%134) : (i32) -> ()
    }) : (tensor<128xi1>, tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
    %47 = "linalg.generic"(%45, %41, %22, %41) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg63: i1, %arg64: i32, %arg65: i32, %arg66: i32):
      %133 = "arith.select"(%arg63, %arg64, %arg65) {tt.contiguity = dense<128> : tensor<1xi32>, tt.divisibility = dense<128> : tensor<1xi32>} : (i1, i32, i32) -> i32
      "linalg.yield"(%133) : (i32) -> ()
    }) : (tensor<128xi1>, tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
    %48 = "arith.muli"(%25, %arg10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %49 = "arith.muli"(%25, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %50 = "arith.index_cast"(%49) : (i32) -> index
    %51 = "arith.muli"(%25, %arg14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %52 = "func.call"() <{callee = @triton.language.standard.zeros__Tc128_c128T_cfp32}> : () -> tensor<128x128xf32>
    %53 = "func.call"(%arg9) <{callee = @triton.language.standard.cdiv__i32_c64}> : (i32) -> i32
    %54 = "arith.index_cast"(%53) : (i32) -> index
    %55 = "scf.for"(%13, %54, %14, %52) ({
    ^bb0(%arg42: index, %arg43: tensor<128x128xf32>):
      %80 = "arith.index_cast"(%arg42) : (index) -> i32
      %81 = "arith.muli"(%80, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %82 = "arith.index_cast"(%81) : (i32) -> index
      %83 = "linalg.fill"(%arg11, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg61: i32, %arg62: i32):
        "linalg.yield"(%arg61) : (i32) -> ()
      }) : (i32, tensor<128xi32>) -> tensor<128xi32>
      %84 = "linalg.generic"(%46, %83, %46) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg58: i32, %arg59: i32, %arg60: i32):
        %132 = "arith.muli"(%arg58, %arg59) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%132) : (i32) -> ()
      }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
      %85 = "linalg.fill"(%48, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg56: i32, %arg57: i32):
        "linalg.yield"(%arg56) : (i32) -> ()
      }) : (i32, tensor<128xi32>) -> tensor<128xi32>
      %86 = "linalg.generic"(%85, %84, %85) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg53: i32, %arg54: i32, %arg55: i32):
        %131 = "arith.addi"(%arg53, %arg54) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%131) : (i32) -> ()
      }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
      %87 = "arith.index_cast"(%arg13) : (i32) -> index
      %88 = "arith.muli"(%82, %87) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %89 = "arith.addi"(%50, %88) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %90 = "arith.subi"(%arg9, %81) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %91 = "arith.index_cast"(%35) : (i32) -> index
      %92 = "arith.addi"(%91, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %93 = "arith.minsi"(%92, %14) : (index, index) -> index
      %94 = "arith.maxsi"(%93, %91) : (index, index) -> index
      %95 = "arith.subi"(%94, %91) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %96 = "arith.index_cast"(%90) : (i32) -> index
      %97 = "arith.minsi"(%96, %16) : (index, index) -> index
      %98 = "arith.maxsi"(%97, %13) : (index, index) -> index
      %99 = "arith.minsi"(%95, %15) : (index, index) -> index
      %100 = "arith.minsi"(%98, %16) : (index, index) -> index
      %101 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x64xbf16>
      "linalg.fill"(%17, %101) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg51: bf16, %arg52: bf16):
        "linalg.yield"(%arg51) : (bf16) -> ()
      }) : (bf16, memref<128x64xbf16>) -> ()
      %102 = "arith.minsi"(%99, %15) : (index, index) -> index
      "scf.for"(%13, %102, %14) ({
      ^bb0(%arg50: index):
        %125 = "tensor.extract"(%86, %arg50) : (tensor<128xi32>, index) -> i32
        %126 = "arith.index_cast"(%125) : (i32) -> index
        %127 = "arith.addi"(%126, %82) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %128 = "memref.reinterpret_cast"(%arg4, %127) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1, 64>, static_strides = array<i64: 1, 1>}> : (memref<?xbf16>, index) -> memref<1x64xbf16, strided<[1, 1], offset: ?>>
        %129 = "memref.subview"(%128, %100) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1x64xbf16, strided<[1, 1], offset: ?>>, index) -> memref<1x?xbf16, strided<[1, 1], offset: ?>>
        %130 = "memref.subview"(%101, %arg50, %100) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<128x64xbf16>, index, index) -> memref<1x?xbf16, strided<[64, 1], offset: ?>>
        "memref.copy"(%129, %130) : (memref<1x?xbf16, strided<[1, 1], offset: ?>>, memref<1x?xbf16, strided<[64, 1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      %103 = "bufferization.to_tensor"(%101) <{restrict, writable}> : (memref<128x64xbf16>) -> tensor<128x64xbf16>
      %104 = "arith.index_cast"(%39) : (i32) -> index
      %105 = "arith.addi"(%104, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %106 = "arith.index_cast"(%arg8) : (i32) -> index
      %107 = "arith.minsi"(%105, %106) : (index, index) -> index
      %108 = "arith.maxsi"(%107, %104) : (index, index) -> index
      %109 = "arith.subi"(%108, %104) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %110 = "arith.minsi"(%109, %15) : (index, index) -> index
      %111 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xbf16>
      "linalg.fill"(%17, %111) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg48: bf16, %arg49: bf16):
        "linalg.yield"(%arg48) : (bf16) -> ()
      }) : (bf16, memref<64x128xbf16>) -> ()
      %112 = "arith.minsi"(%110, %15) : (index, index) -> index
      "scf.for"(%13, %112, %14) ({
      ^bb0(%arg47: index):
        %119 = "tensor.extract"(%47, %arg47) : (tensor<128xi32>, index) -> i32
        %120 = "arith.index_cast"(%119) : (i32) -> index
        %121 = "arith.addi"(%89, %120) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %122 = "memref.reinterpret_cast"(%arg5, %121, %87) <{operandSegmentSizes = array<i32: 1, 1, 0, 1>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 64, 1>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xbf16>, index, index) -> memref<64x1xbf16, strided<[?, 1], offset: ?>>
        %123 = "memref.subview"(%122, %100) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (memref<64x1xbf16, strided<[?, 1], offset: ?>>, index) -> memref<?x1xbf16, strided<[?, 1], offset: ?>>
        %124 = "memref.subview"(%111, %arg47, %100) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (memref<64x128xbf16>, index, index) -> memref<?x1xbf16, strided<[128, 1], offset: ?>>
        "memref.copy"(%123, %124) : (memref<?x1xbf16, strided<[?, 1], offset: ?>>, memref<?x1xbf16, strided<[128, 1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      %113 = "bufferization.to_tensor"(%111) <{restrict, writable}> : (memref<64x128xbf16>) -> tensor<64x128xbf16>
      %114 = "linalg.matmul"(%103, %113, %arg43) <{indexing_maps = [#map1, #map2, #map3], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg44: bf16, %arg45: bf16, %arg46: f32):
        %115 = "arith.extf"(%arg44) : (bf16) -> f32
        %116 = "arith.extf"(%arg45) : (bf16) -> f32
        %117 = "arith.mulf"(%115, %116) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %118 = "arith.addf"(%arg46, %117) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%118) : (f32) -> ()
      }) : (tensor<128x64xbf16>, tensor<64x128xbf16>, tensor<128x128xf32>) -> tensor<128x128xf32>
      "scf.yield"(%114) : (tensor<128x128xf32>) -> ()
    }) : (index, index, index, tensor<128x128xf32>) -> tensor<128x128xf32>
    %56 = "tensor.expand_shape"(%46) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xi32>) -> tensor<128x1xi32>
    %57 = "tensor.empty"() : () -> tensor<128x1xi32>
    %58 = "linalg.fill"(%arg15, %57) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg40: i32, %arg41: i32):
      "linalg.yield"(%arg40) : (i32) -> ()
    }) : (i32, tensor<128x1xi32>) -> tensor<128x1xi32>
    %59 = "linalg.generic"(%58, %56, %58) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg37: i32, %arg38: i32, %arg39: i32):
      %79 = "arith.muli"(%arg37, %arg38) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%79) : (i32) -> ()
    }) : (tensor<128x1xi32>, tensor<128x1xi32>, tensor<128x1xi32>) -> tensor<128x1xi32>
    %60 = "linalg.fill"(%51, %57) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg35: i32, %arg36: i32):
      "linalg.yield"(%arg35) : (i32) -> ()
    }) : (i32, tensor<128x1xi32>) -> tensor<128x1xi32>
    %61 = "linalg.generic"(%60, %59, %60) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg32: i32, %arg33: i32, %arg34: i32):
      %78 = "arith.addi"(%arg32, %arg33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%78) : (i32) -> ()
    }) : (tensor<128x1xi32>, tensor<128x1xi32>, tensor<128x1xi32>) -> tensor<128x1xi32>
    %62 = "tensor.expand_shape"(%47) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xi32>) -> tensor<1x128xi32>
    %63 = "tensor.empty"() : () -> tensor<128x128xi32>
    %64 = "linalg.generic"(%61, %63) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: i32, %arg31: i32):
      "linalg.yield"(%arg30) : (i32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<128x1xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
    %65 = "linalg.generic"(%62, %63) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg28: i32, %arg29: i32):
      "linalg.yield"(%arg28) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x128xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
    %66 = "linalg.generic"(%64, %65, %64) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg25: i32, %arg26: i32, %arg27: i32):
      %77 = "arith.addi"(%arg25, %arg26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%77) : (i32) -> ()
    }) : (tensor<128x128xi32>, tensor<128x128xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
    %67 = "tensor.expand_shape"(%43) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xi1>) -> tensor<128x1xi1>
    %68 = "tensor.expand_shape"(%45) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xi1>) -> tensor<1x128xi1>
    %69 = "tensor.empty"() : () -> tensor<128x128xi1>
    %70 = "linalg.generic"(%67, %69) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i1, %arg24: i1):
      "linalg.yield"(%arg23) : (i1) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<128x1xi1>, tensor<128x128xi1>) -> tensor<128x128xi1>
    %71 = "linalg.generic"(%68, %69) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: i1, %arg22: i1):
      "linalg.yield"(%arg21) : (i1) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x128xi1>, tensor<128x128xi1>) -> tensor<128x128xi1>
    %72 = "linalg.generic"(%70, %71, %70) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg18: i1, %arg19: i1, %arg20: i1):
      %76 = "arith.andi"(%arg18, %arg19) : (i1, i1) -> i1
      "linalg.yield"(%76) : (i1) -> ()
    }) : (tensor<128x128xi1>, tensor<128x128xi1>, tensor<128x128xi1>) -> tensor<128x128xi1>
    %73 = "tensor.empty"() : () -> tensor<128x128xbf16>
    %74 = "linalg.generic"(%55, %73) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: f32, %arg17: bf16):
      %75 = "arith.truncf"(%arg16) : (f32) -> bf16
      "linalg.yield"(%75) : (bf16) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xbf16>) -> tensor<128x128xbf16>
    "tts.scatter"(%20, %66, %74, %72) : (!tt.ptr<bf16>, tensor<128x128xi32>, tensor<128x128xbf16>, tensor<128x128xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.cdiv__c1_c128", sym_visibility = "private"}> ({
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

