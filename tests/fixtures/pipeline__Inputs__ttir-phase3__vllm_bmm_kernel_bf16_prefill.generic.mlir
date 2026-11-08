#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map4 = affine_map<(d0, d1) -> (d0, d1)>
#map5 = affine_map<(d0, d1) -> (d0, 0)>
#map6 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "bmm_kernel"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xbf16>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 63 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 128 : index}> : () -> index
    %5 = "arith.constant"() <{value = 64 : index}> : () -> index
    %6 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %7 = "arith.constant"() <{value = 127 : i32}> : () -> i32
    %8 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %9 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %10 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %11 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<?xbf16>) -> !tt.ptr<bf16>
    %12 = "tensor.empty"() : () -> tensor<128x128xf32>
    %13 = "linalg.fill"(%0, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg91: f32, %arg92: f32):
      "linalg.yield"(%arg91) : (f32) -> ()
    }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
    %14 = "tensor.empty"() : () -> tensor<128xi32>
    %15 = "linalg.fill"(%9, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg89: i32, %arg90: i32):
      "linalg.yield"(%arg89) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %16 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %17 = "arith.index_cast"(%16) : (index) -> i32
    %18 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %19 = "arith.index_cast"(%18) : (index) -> i32
    %20 = "arith.cmpi"(%17, %arg3) <{predicate = 5 : i64}> : (i32, i32) -> i1
    "scf.if"(%20) ({
      "scf.yield"() : () -> ()
    }, {
      %21 = "arith.addi"(%arg4, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %22 = "arith.divsi"(%21, %10) : (i32, i32) -> i32
      %23 = "arith.addi"(%arg5, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %24 = "arith.divsi"(%23, %10) : (i32, i32) -> i32
      %25 = "arith.divsi"(%19, %24) : (i32, i32) -> i32
      %26 = "arith.remsi"(%19, %24) : (i32, i32) -> i32
      %27 = "arith.cmpi"(%25, %22) <{predicate = 5 : i64}> : (i32, i32) -> i1
      %28 = "arith.cmpi"(%26, %24) <{predicate = 5 : i64}> : (i32, i32) -> i1
      %29 = "arith.ori"(%27, %28) : (i1, i1) -> i1
      "scf.if"(%29) ({
        "scf.yield"() : () -> ()
      }, {
        %30 = "arith.muli"(%25, %10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %31 = "linalg.generic"(%14) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
        ^bb0(%arg88: i32):
          %136 = "linalg.index"() <{dim = 0 : i64}> : () -> index
          %137 = "arith.index_cast"(%136) : (index) -> i32
          "linalg.yield"(%137) : (i32) -> ()
        }) : (tensor<128xi32>) -> tensor<128xi32>
        %32 = "linalg.fill"(%30, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg86: i32, %arg87: i32):
          "linalg.yield"(%arg86) : (i32) -> ()
        }) : (i32, tensor<128xi32>) -> tensor<128xi32>
        %33 = "linalg.generic"(%32, %31, %32) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg83: i32, %arg84: i32, %arg85: i32):
          %135 = "arith.addi"(%arg83, %arg84) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%135) : (i32) -> ()
        }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
        %34 = "arith.muli"(%26, %10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %35 = "linalg.fill"(%34, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg81: i32, %arg82: i32):
          "linalg.yield"(%arg81) : (i32) -> ()
        }) : (i32, tensor<128xi32>) -> tensor<128xi32>
        %36 = "linalg.generic"(%35, %31, %35) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg78: i32, %arg79: i32, %arg80: i32):
          %134 = "arith.addi"(%arg78, %arg79) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%134) : (i32) -> ()
        }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
        %37 = "linalg.fill"(%arg4, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg76: i32, %arg77: i32):
          "linalg.yield"(%arg76) : (i32) -> ()
        }) : (i32, tensor<128xi32>) -> tensor<128xi32>
        %38 = "tensor.empty"() : () -> tensor<128xi1>
        %39 = "linalg.generic"(%33, %37, %38) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg73: i32, %arg74: i32, %arg75: i1):
          %133 = "arith.cmpi"(%arg73, %arg74) <{predicate = 2 : i64}> : (i32, i32) -> i1
          "linalg.yield"(%133) : (i1) -> ()
        }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi1>) -> tensor<128xi1>
        %40 = "linalg.fill"(%arg5, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg71: i32, %arg72: i32):
          "linalg.yield"(%arg71) : (i32) -> ()
        }) : (i32, tensor<128xi32>) -> tensor<128xi32>
        %41 = "linalg.generic"(%36, %40, %38) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg68: i32, %arg69: i32, %arg70: i1):
          %132 = "arith.cmpi"(%arg68, %arg69) <{predicate = 2 : i64}> : (i32, i32) -> i1
          "linalg.yield"(%132) : (i1) -> ()
        }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi1>) -> tensor<128xi1>
        %42 = "linalg.generic"(%39, %33, %15, %33) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
        ^bb0(%arg64: i1, %arg65: i32, %arg66: i32, %arg67: i32):
          %131 = "arith.select"(%arg64, %arg65, %arg66) {tt.contiguity = dense<128> : tensor<1xi32>, tt.divisibility = dense<128> : tensor<1xi32>} : (i1, i32, i32) -> i32
          "linalg.yield"(%131) : (i32) -> ()
        }) : (tensor<128xi1>, tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
        %43 = "linalg.generic"(%41, %36, %15, %36) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
        ^bb0(%arg60: i1, %arg61: i32, %arg62: i32, %arg63: i32):
          %130 = "arith.select"(%arg60, %arg61, %arg62) {tt.contiguity = dense<128> : tensor<1xi32>, tt.divisibility = dense<128> : tensor<1xi32>} : (i1, i32, i32) -> i32
          "linalg.yield"(%130) : (i32) -> ()
        }) : (tensor<128xi1>, tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
        %44 = "arith.muli"(%17, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %45 = "arith.muli"(%17, %arg9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %46 = "arith.index_cast"(%45) : (i32) -> index
        %47 = "arith.muli"(%17, %arg11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %48 = "arith.addi"(%arg6, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %49 = "arith.divsi"(%48, %8) : (i32, i32) -> i32
        %50 = "tensor.expand_shape"(%42) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xi32>) -> tensor<128x1xi32>
        %51 = "tensor.expand_shape"(%43) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xi32>) -> tensor<1x128xi32>
        %52 = "tensor.expand_shape"(%39) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xi1>) -> tensor<128x1xi1>
        %53 = "tensor.expand_shape"(%41) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xi1>) -> tensor<1x128xi1>
        %54 = "arith.index_cast"(%49) : (i32) -> index
        %55 = "scf.for"(%2, %54, %3, %13) ({
        ^bb0(%arg39: index, %arg40: tensor<128x128xf32>):
          %76 = "arith.index_cast"(%arg39) : (index) -> i32
          %77 = "arith.muli"(%76, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          %78 = "arith.index_cast"(%77) : (i32) -> index
          %79 = "linalg.fill"(%arg8, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
          ^bb0(%arg58: i32, %arg59: i32):
            "linalg.yield"(%arg58) : (i32) -> ()
          }) : (i32, tensor<128xi32>) -> tensor<128xi32>
          %80 = "linalg.generic"(%42, %79, %42) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
          ^bb0(%arg55: i32, %arg56: i32, %arg57: i32):
            %129 = "arith.muli"(%arg55, %arg56) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
            "linalg.yield"(%129) : (i32) -> ()
          }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
          %81 = "linalg.fill"(%44, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
          ^bb0(%arg53: i32, %arg54: i32):
            "linalg.yield"(%arg53) : (i32) -> ()
          }) : (i32, tensor<128xi32>) -> tensor<128xi32>
          %82 = "linalg.generic"(%81, %80, %81) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
          ^bb0(%arg50: i32, %arg51: i32, %arg52: i32):
            %128 = "arith.addi"(%arg50, %arg51) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
            "linalg.yield"(%128) : (i32) -> ()
          }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
          %83 = "arith.index_cast"(%arg10) : (i32) -> index
          %84 = "arith.muli"(%78, %83) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %85 = "arith.addi"(%46, %84) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %86 = "arith.subi"(%arg6, %77) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          %87 = "arith.index_cast"(%30) : (i32) -> index
          %88 = "arith.addi"(%87, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %89 = "arith.index_cast"(%arg4) : (i32) -> index
          %90 = "arith.minsi"(%88, %89) : (index, index) -> index
          %91 = "arith.maxsi"(%90, %87) : (index, index) -> index
          %92 = "arith.subi"(%91, %87) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %93 = "arith.index_cast"(%86) : (i32) -> index
          %94 = "arith.minsi"(%93, %5) : (index, index) -> index
          %95 = "arith.maxsi"(%94, %2) : (index, index) -> index
          %96 = "arith.minsi"(%92, %4) : (index, index) -> index
          %97 = "arith.minsi"(%95, %5) : (index, index) -> index
          %98 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x64xbf16>
          "linalg.fill"(%6, %98) <{operandSegmentSizes = array<i32: 1, 1>}> ({
          ^bb0(%arg48: bf16, %arg49: bf16):
            "linalg.yield"(%arg48) : (bf16) -> ()
          }) : (bf16, memref<128x64xbf16>) -> ()
          %99 = "arith.minsi"(%96, %4) : (index, index) -> index
          "scf.for"(%2, %99, %3) ({
          ^bb0(%arg47: index):
            %122 = "tensor.extract"(%82, %arg47) : (tensor<128xi32>, index) -> i32
            %123 = "arith.index_cast"(%122) : (i32) -> index
            %124 = "arith.addi"(%123, %78) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %125 = "memref.reinterpret_cast"(%arg0, %124) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1, 64>, static_strides = array<i64: 1, 1>}> : (memref<?xbf16>, index) -> memref<1x64xbf16, strided<[1, 1], offset: ?>>
            %126 = "memref.subview"(%125, %97) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1x64xbf16, strided<[1, 1], offset: ?>>, index) -> memref<1x?xbf16, strided<[1, 1], offset: ?>>
            %127 = "memref.subview"(%98, %arg47, %97) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<128x64xbf16>, index, index) -> memref<1x?xbf16, strided<[64, 1], offset: ?>>
            "memref.copy"(%126, %127) : (memref<1x?xbf16, strided<[1, 1], offset: ?>>, memref<1x?xbf16, strided<[64, 1], offset: ?>>) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          %100 = "bufferization.to_tensor"(%98) <{restrict, writable}> : (memref<128x64xbf16>) -> tensor<128x64xbf16>
          %101 = "arith.index_cast"(%34) : (i32) -> index
          %102 = "arith.addi"(%101, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %103 = "arith.index_cast"(%arg5) : (i32) -> index
          %104 = "arith.minsi"(%102, %103) : (index, index) -> index
          %105 = "arith.maxsi"(%104, %101) : (index, index) -> index
          %106 = "arith.subi"(%105, %101) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %107 = "arith.minsi"(%106, %4) : (index, index) -> index
          %108 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xbf16>
          "linalg.fill"(%6, %108) <{operandSegmentSizes = array<i32: 1, 1>}> ({
          ^bb0(%arg45: bf16, %arg46: bf16):
            "linalg.yield"(%arg45) : (bf16) -> ()
          }) : (bf16, memref<64x128xbf16>) -> ()
          %109 = "arith.minsi"(%107, %4) : (index, index) -> index
          "scf.for"(%2, %109, %3) ({
          ^bb0(%arg44: index):
            %116 = "tensor.extract"(%43, %arg44) : (tensor<128xi32>, index) -> i32
            %117 = "arith.index_cast"(%116) : (i32) -> index
            %118 = "arith.addi"(%85, %117) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %119 = "memref.reinterpret_cast"(%arg1, %118, %83) <{operandSegmentSizes = array<i32: 1, 1, 0, 1>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 64, 1>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xbf16>, index, index) -> memref<64x1xbf16, strided<[?, 1], offset: ?>>
            %120 = "memref.subview"(%119, %97) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (memref<64x1xbf16, strided<[?, 1], offset: ?>>, index) -> memref<?x1xbf16, strided<[?, 1], offset: ?>>
            %121 = "memref.subview"(%108, %arg44, %97) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (memref<64x128xbf16>, index, index) -> memref<?x1xbf16, strided<[128, 1], offset: ?>>
            "memref.copy"(%120, %121) : (memref<?x1xbf16, strided<[?, 1], offset: ?>>, memref<?x1xbf16, strided<[128, 1], offset: ?>>) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          %110 = "bufferization.to_tensor"(%108) <{restrict, writable}> : (memref<64x128xbf16>) -> tensor<64x128xbf16>
          %111 = "linalg.matmul"(%100, %110, %arg40) <{indexing_maps = [#map1, #map2, #map3], operandSegmentSizes = array<i32: 2, 1>}> ({
          ^bb0(%arg41: bf16, %arg42: bf16, %arg43: f32):
            %112 = "arith.extf"(%arg41) : (bf16) -> f32
            %113 = "arith.extf"(%arg42) : (bf16) -> f32
            %114 = "arith.mulf"(%112, %113) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            %115 = "arith.addf"(%arg43, %114) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            "linalg.yield"(%115) : (f32) -> ()
          }) : (tensor<128x64xbf16>, tensor<64x128xbf16>, tensor<128x128xf32>) -> tensor<128x128xf32>
          "scf.yield"(%111) : (tensor<128x128xf32>) -> ()
        }) : (index, index, index, tensor<128x128xf32>) -> tensor<128x128xf32>
        %56 = "tensor.empty"() : () -> tensor<128x1xi32>
        %57 = "linalg.fill"(%arg12, %56) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg37: i32, %arg38: i32):
          "linalg.yield"(%arg37) : (i32) -> ()
        }) : (i32, tensor<128x1xi32>) -> tensor<128x1xi32>
        %58 = "linalg.generic"(%57, %50, %57) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg34: i32, %arg35: i32, %arg36: i32):
          %75 = "arith.muli"(%arg34, %arg35) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%75) : (i32) -> ()
        }) : (tensor<128x1xi32>, tensor<128x1xi32>, tensor<128x1xi32>) -> tensor<128x1xi32>
        %59 = "linalg.fill"(%47, %56) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg32: i32, %arg33: i32):
          "linalg.yield"(%arg32) : (i32) -> ()
        }) : (i32, tensor<128x1xi32>) -> tensor<128x1xi32>
        %60 = "linalg.generic"(%59, %58, %59) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg29: i32, %arg30: i32, %arg31: i32):
          %74 = "arith.addi"(%arg29, %arg30) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%74) : (i32) -> ()
        }) : (tensor<128x1xi32>, tensor<128x1xi32>, tensor<128x1xi32>) -> tensor<128x1xi32>
        %61 = "tensor.empty"() : () -> tensor<128x128xi32>
        %62 = "linalg.generic"(%60, %61) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg27: i32, %arg28: i32):
          "linalg.yield"(%arg27) : (i32) -> ()
        }) {broadcastDims = array<i64: 1>} : (tensor<128x1xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
        %63 = "linalg.generic"(%51, %61) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg25: i32, %arg26: i32):
          "linalg.yield"(%arg25) : (i32) -> ()
        }) {broadcastDims = array<i64: 0>} : (tensor<1x128xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
        %64 = "linalg.generic"(%62, %63, %62) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg22: i32, %arg23: i32, %arg24: i32):
          %73 = "arith.addi"(%arg22, %arg23) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%73) : (i32) -> ()
        }) : (tensor<128x128xi32>, tensor<128x128xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
        %65 = "tensor.empty"() : () -> tensor<128x128xi1>
        %66 = "linalg.generic"(%52, %65) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg20: i1, %arg21: i1):
          "linalg.yield"(%arg20) : (i1) -> ()
        }) {broadcastDims = array<i64: 1>} : (tensor<128x1xi1>, tensor<128x128xi1>) -> tensor<128x128xi1>
        %67 = "linalg.generic"(%53, %65) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg18: i1, %arg19: i1):
          "linalg.yield"(%arg18) : (i1) -> ()
        }) {broadcastDims = array<i64: 0>} : (tensor<1x128xi1>, tensor<128x128xi1>) -> tensor<128x128xi1>
        %68 = "linalg.generic"(%66, %67, %66) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg15: i1, %arg16: i1, %arg17: i1):
          %72 = "arith.andi"(%arg15, %arg16) : (i1, i1) -> i1
          "linalg.yield"(%72) : (i1) -> ()
        }) : (tensor<128x128xi1>, tensor<128x128xi1>, tensor<128x128xi1>) -> tensor<128x128xi1>
        %69 = "tensor.empty"() : () -> tensor<128x128xbf16>
        %70 = "linalg.generic"(%55, %69) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg13: f32, %arg14: bf16):
          %71 = "arith.truncf"(%arg13) : (f32) -> bf16
          "linalg.yield"(%71) : (bf16) -> ()
        }) : (tensor<128x128xf32>, tensor<128x128xbf16>) -> tensor<128x128xbf16>
        "tts.scatter"(%11, %64, %70, %68) : (!tt.ptr<bf16>, tensor<128x128xi32>, tensor<128x128xbf16>, tensor<128x128xi1>) -> ()
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

