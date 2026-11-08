#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map4 = affine_map<(d0, d1) -> (d0, d1)>
#map5 = affine_map<(d0, d1) -> (d0, 0)>
#map6 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "bmm_kernel"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xbf16>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 63 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 128 : index}> : () -> index
    %6 = "arith.constant"() <{value = 64 : index}> : () -> index
    %7 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %8 = "arith.constant"() <{value = 127 : i32}> : () -> i32
    %9 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %10 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %11 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %12 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<?xbf16>) -> !tt.ptr<bf16>
    %13 = "tensor.empty"() : () -> tensor<128x128xf32>
    %14 = "linalg.fill"(%0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg90: f32, %arg91: f32):
      "linalg.yield"(%arg90) : (f32) -> ()
    }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
    %15 = "tensor.empty"() : () -> tensor<128xi32>
    %16 = "linalg.fill"(%10, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg88: i32, %arg89: i32):
      "linalg.yield"(%arg88) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %17 = "linalg.fill"(%2, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg86: i32, %arg87: i32):
      "linalg.yield"(%arg86) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %18 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %19 = "arith.index_cast"(%18) : (index) -> i32
    %20 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %21 = "arith.index_cast"(%20) : (index) -> i32
    %22 = "arith.cmpi"(%19, %arg3) <{predicate = 5 : i64}> : (i32, i32) -> i1
    "scf.if"(%22) ({
      "scf.yield"() : () -> ()
    }, {
      %23 = "arith.addi"(%arg4, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %24 = "arith.divsi"(%23, %11) : (i32, i32) -> i32
      %25 = "arith.divsi"(%21, %24) : (i32, i32) -> i32
      %26 = "arith.remsi"(%21, %24) : (i32, i32) -> i32
      %27 = "arith.cmpi"(%25, %2) <{predicate = 5 : i64}> : (i32, i32) -> i1
      %28 = "arith.cmpi"(%26, %24) <{predicate = 5 : i64}> : (i32, i32) -> i1
      %29 = "arith.ori"(%27, %28) : (i1, i1) -> i1
      "scf.if"(%29) ({
        "scf.yield"() : () -> ()
      }, {
        %30 = "arith.muli"(%25, %11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %31 = "linalg.generic"(%15) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
        ^bb0(%arg85: i32):
          %134 = "linalg.index"() <{dim = 0 : i64}> : () -> index
          %135 = "arith.index_cast"(%134) : (index) -> i32
          "linalg.yield"(%135) : (i32) -> ()
        }) : (tensor<128xi32>) -> tensor<128xi32>
        %32 = "linalg.fill"(%30, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg83: i32, %arg84: i32):
          "linalg.yield"(%arg83) : (i32) -> ()
        }) : (i32, tensor<128xi32>) -> tensor<128xi32>
        %33 = "linalg.generic"(%32, %31, %32) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg80: i32, %arg81: i32, %arg82: i32):
          %133 = "arith.addi"(%arg80, %arg81) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%133) : (i32) -> ()
        }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
        %34 = "arith.muli"(%26, %11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %35 = "linalg.fill"(%34, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg78: i32, %arg79: i32):
          "linalg.yield"(%arg78) : (i32) -> ()
        }) : (i32, tensor<128xi32>) -> tensor<128xi32>
        %36 = "linalg.generic"(%35, %31, %35) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg75: i32, %arg76: i32, %arg77: i32):
          %132 = "arith.addi"(%arg75, %arg76) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%132) : (i32) -> ()
        }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
        %37 = "tensor.empty"() : () -> tensor<128xi1>
        %38 = "linalg.generic"(%33, %17, %37) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg72: i32, %arg73: i32, %arg74: i1):
          %131 = "arith.cmpi"(%arg72, %arg73) <{predicate = 2 : i64}> : (i32, i32) -> i1
          "linalg.yield"(%131) : (i1) -> ()
        }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi1>) -> tensor<128xi1>
        %39 = "linalg.fill"(%arg4, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg70: i32, %arg71: i32):
          "linalg.yield"(%arg70) : (i32) -> ()
        }) : (i32, tensor<128xi32>) -> tensor<128xi32>
        %40 = "linalg.generic"(%36, %39, %37) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg67: i32, %arg68: i32, %arg69: i1):
          %130 = "arith.cmpi"(%arg67, %arg68) <{predicate = 2 : i64}> : (i32, i32) -> i1
          "linalg.yield"(%130) : (i1) -> ()
        }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi1>) -> tensor<128xi1>
        %41 = "linalg.generic"(%38, %33, %16, %33) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
        ^bb0(%arg63: i1, %arg64: i32, %arg65: i32, %arg66: i32):
          %129 = "arith.select"(%arg63, %arg64, %arg65) {tt.contiguity = dense<128> : tensor<1xi32>, tt.divisibility = dense<128> : tensor<1xi32>} : (i1, i32, i32) -> i32
          "linalg.yield"(%129) : (i32) -> ()
        }) : (tensor<128xi1>, tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
        %42 = "linalg.generic"(%40, %36, %16, %36) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
        ^bb0(%arg59: i1, %arg60: i32, %arg61: i32, %arg62: i32):
          %128 = "arith.select"(%arg59, %arg60, %arg61) {tt.contiguity = dense<128> : tensor<1xi32>, tt.divisibility = dense<128> : tensor<1xi32>} : (i1, i32, i32) -> i32
          "linalg.yield"(%128) : (i32) -> ()
        }) : (tensor<128xi1>, tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
        %43 = "arith.muli"(%19, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %44 = "arith.muli"(%19, %arg8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %45 = "arith.index_cast"(%44) : (i32) -> index
        %46 = "arith.muli"(%19, %arg10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %47 = "arith.addi"(%arg5, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %48 = "arith.divsi"(%47, %9) : (i32, i32) -> i32
        %49 = "tensor.expand_shape"(%41) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xi32>) -> tensor<128x1xi32>
        %50 = "tensor.expand_shape"(%42) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xi32>) -> tensor<1x128xi32>
        %51 = "tensor.expand_shape"(%38) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xi1>) -> tensor<128x1xi1>
        %52 = "tensor.expand_shape"(%40) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xi1>) -> tensor<1x128xi1>
        %53 = "arith.index_cast"(%48) : (i32) -> index
        %54 = "scf.for"(%3, %53, %4, %14) ({
        ^bb0(%arg38: index, %arg39: tensor<128x128xf32>):
          %75 = "arith.index_cast"(%arg38) : (index) -> i32
          %76 = "arith.muli"(%75, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          %77 = "arith.index_cast"(%76) : (i32) -> index
          %78 = "linalg.fill"(%arg7, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
          ^bb0(%arg57: i32, %arg58: i32):
            "linalg.yield"(%arg57) : (i32) -> ()
          }) : (i32, tensor<128xi32>) -> tensor<128xi32>
          %79 = "linalg.generic"(%41, %78, %41) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
          ^bb0(%arg54: i32, %arg55: i32, %arg56: i32):
            %127 = "arith.muli"(%arg54, %arg55) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
            "linalg.yield"(%127) : (i32) -> ()
          }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
          %80 = "linalg.fill"(%43, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
          ^bb0(%arg52: i32, %arg53: i32):
            "linalg.yield"(%arg52) : (i32) -> ()
          }) : (i32, tensor<128xi32>) -> tensor<128xi32>
          %81 = "linalg.generic"(%80, %79, %80) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
          ^bb0(%arg49: i32, %arg50: i32, %arg51: i32):
            %126 = "arith.addi"(%arg49, %arg50) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
            "linalg.yield"(%126) : (i32) -> ()
          }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
          %82 = "arith.index_cast"(%arg9) : (i32) -> index
          %83 = "arith.muli"(%77, %82) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %84 = "arith.addi"(%45, %83) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %85 = "arith.subi"(%arg5, %76) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          %86 = "arith.index_cast"(%30) : (i32) -> index
          %87 = "arith.addi"(%86, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %88 = "arith.minsi"(%87, %4) : (index, index) -> index
          %89 = "arith.maxsi"(%88, %86) : (index, index) -> index
          %90 = "arith.subi"(%89, %86) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %91 = "arith.index_cast"(%85) : (i32) -> index
          %92 = "arith.minsi"(%91, %6) : (index, index) -> index
          %93 = "arith.maxsi"(%92, %3) : (index, index) -> index
          %94 = "arith.minsi"(%90, %5) : (index, index) -> index
          %95 = "arith.minsi"(%93, %6) : (index, index) -> index
          %96 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x64xbf16>
          "linalg.fill"(%7, %96) <{operandSegmentSizes = array<i32: 1, 1>}> ({
          ^bb0(%arg47: bf16, %arg48: bf16):
            "linalg.yield"(%arg47) : (bf16) -> ()
          }) : (bf16, memref<128x64xbf16>) -> ()
          %97 = "arith.minsi"(%94, %5) : (index, index) -> index
          "scf.for"(%3, %97, %4) ({
          ^bb0(%arg46: index):
            %120 = "tensor.extract"(%81, %arg46) : (tensor<128xi32>, index) -> i32
            %121 = "arith.index_cast"(%120) : (i32) -> index
            %122 = "arith.addi"(%121, %77) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %123 = "memref.reinterpret_cast"(%arg0, %122) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1, 64>, static_strides = array<i64: 1, 1>}> : (memref<?xbf16>, index) -> memref<1x64xbf16, strided<[1, 1], offset: ?>>
            %124 = "memref.subview"(%123, %95) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1x64xbf16, strided<[1, 1], offset: ?>>, index) -> memref<1x?xbf16, strided<[1, 1], offset: ?>>
            %125 = "memref.subview"(%96, %arg46, %95) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<128x64xbf16>, index, index) -> memref<1x?xbf16, strided<[64, 1], offset: ?>>
            "memref.copy"(%124, %125) : (memref<1x?xbf16, strided<[1, 1], offset: ?>>, memref<1x?xbf16, strided<[64, 1], offset: ?>>) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          %98 = "bufferization.to_tensor"(%96) <{restrict, writable}> : (memref<128x64xbf16>) -> tensor<128x64xbf16>
          %99 = "arith.index_cast"(%34) : (i32) -> index
          %100 = "arith.addi"(%99, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %101 = "arith.index_cast"(%arg4) : (i32) -> index
          %102 = "arith.minsi"(%100, %101) : (index, index) -> index
          %103 = "arith.maxsi"(%102, %99) : (index, index) -> index
          %104 = "arith.subi"(%103, %99) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %105 = "arith.minsi"(%104, %5) : (index, index) -> index
          %106 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xbf16>
          "linalg.fill"(%7, %106) <{operandSegmentSizes = array<i32: 1, 1>}> ({
          ^bb0(%arg44: bf16, %arg45: bf16):
            "linalg.yield"(%arg44) : (bf16) -> ()
          }) : (bf16, memref<64x128xbf16>) -> ()
          %107 = "arith.minsi"(%105, %5) : (index, index) -> index
          "scf.for"(%3, %107, %4) ({
          ^bb0(%arg43: index):
            %114 = "tensor.extract"(%42, %arg43) : (tensor<128xi32>, index) -> i32
            %115 = "arith.index_cast"(%114) : (i32) -> index
            %116 = "arith.addi"(%84, %115) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %117 = "memref.reinterpret_cast"(%arg1, %116, %82) <{operandSegmentSizes = array<i32: 1, 1, 0, 1>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 64, 1>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xbf16>, index, index) -> memref<64x1xbf16, strided<[?, 1], offset: ?>>
            %118 = "memref.subview"(%117, %95) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (memref<64x1xbf16, strided<[?, 1], offset: ?>>, index) -> memref<?x1xbf16, strided<[?, 1], offset: ?>>
            %119 = "memref.subview"(%106, %arg43, %95) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (memref<64x128xbf16>, index, index) -> memref<?x1xbf16, strided<[128, 1], offset: ?>>
            "memref.copy"(%118, %119) : (memref<?x1xbf16, strided<[?, 1], offset: ?>>, memref<?x1xbf16, strided<[128, 1], offset: ?>>) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          %108 = "bufferization.to_tensor"(%106) <{restrict, writable}> : (memref<64x128xbf16>) -> tensor<64x128xbf16>
          %109 = "linalg.matmul"(%98, %108, %arg39) <{indexing_maps = [#map1, #map2, #map3], operandSegmentSizes = array<i32: 2, 1>}> ({
          ^bb0(%arg40: bf16, %arg41: bf16, %arg42: f32):
            %110 = "arith.extf"(%arg40) : (bf16) -> f32
            %111 = "arith.extf"(%arg41) : (bf16) -> f32
            %112 = "arith.mulf"(%110, %111) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            %113 = "arith.addf"(%arg42, %112) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            "linalg.yield"(%113) : (f32) -> ()
          }) : (tensor<128x64xbf16>, tensor<64x128xbf16>, tensor<128x128xf32>) -> tensor<128x128xf32>
          "scf.yield"(%109) : (tensor<128x128xf32>) -> ()
        }) : (index, index, index, tensor<128x128xf32>) -> tensor<128x128xf32>
        %55 = "tensor.empty"() : () -> tensor<128x1xi32>
        %56 = "linalg.fill"(%arg11, %55) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg36: i32, %arg37: i32):
          "linalg.yield"(%arg36) : (i32) -> ()
        }) : (i32, tensor<128x1xi32>) -> tensor<128x1xi32>
        %57 = "linalg.generic"(%56, %49, %56) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg33: i32, %arg34: i32, %arg35: i32):
          %74 = "arith.muli"(%arg33, %arg34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%74) : (i32) -> ()
        }) : (tensor<128x1xi32>, tensor<128x1xi32>, tensor<128x1xi32>) -> tensor<128x1xi32>
        %58 = "linalg.fill"(%46, %55) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg31: i32, %arg32: i32):
          "linalg.yield"(%arg31) : (i32) -> ()
        }) : (i32, tensor<128x1xi32>) -> tensor<128x1xi32>
        %59 = "linalg.generic"(%58, %57, %58) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg28: i32, %arg29: i32, %arg30: i32):
          %73 = "arith.addi"(%arg28, %arg29) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%73) : (i32) -> ()
        }) : (tensor<128x1xi32>, tensor<128x1xi32>, tensor<128x1xi32>) -> tensor<128x1xi32>
        %60 = "tensor.empty"() : () -> tensor<128x128xi32>
        %61 = "linalg.generic"(%59, %60) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg26: i32, %arg27: i32):
          "linalg.yield"(%arg26) : (i32) -> ()
        }) {broadcastDims = array<i64: 1>} : (tensor<128x1xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
        %62 = "linalg.generic"(%50, %60) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg24: i32, %arg25: i32):
          "linalg.yield"(%arg24) : (i32) -> ()
        }) {broadcastDims = array<i64: 0>} : (tensor<1x128xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
        %63 = "linalg.generic"(%61, %62, %61) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg21: i32, %arg22: i32, %arg23: i32):
          %72 = "arith.addi"(%arg21, %arg22) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%72) : (i32) -> ()
        }) : (tensor<128x128xi32>, tensor<128x128xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
        %64 = "tensor.empty"() : () -> tensor<128x128xi1>
        %65 = "linalg.generic"(%51, %64) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg19: i1, %arg20: i1):
          "linalg.yield"(%arg19) : (i1) -> ()
        }) {broadcastDims = array<i64: 1>} : (tensor<128x1xi1>, tensor<128x128xi1>) -> tensor<128x128xi1>
        %66 = "linalg.generic"(%52, %64) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg17: i1, %arg18: i1):
          "linalg.yield"(%arg17) : (i1) -> ()
        }) {broadcastDims = array<i64: 0>} : (tensor<1x128xi1>, tensor<128x128xi1>) -> tensor<128x128xi1>
        %67 = "linalg.generic"(%65, %66, %65) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg14: i1, %arg15: i1, %arg16: i1):
          %71 = "arith.andi"(%arg14, %arg15) : (i1, i1) -> i1
          "linalg.yield"(%71) : (i1) -> ()
        }) : (tensor<128x128xi1>, tensor<128x128xi1>, tensor<128x128xi1>) -> tensor<128x128xi1>
        %68 = "tensor.empty"() : () -> tensor<128x128xbf16>
        %69 = "linalg.generic"(%54, %68) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg12: f32, %arg13: bf16):
          %70 = "arith.truncf"(%arg12) : (f32) -> bf16
          "linalg.yield"(%70) : (bf16) -> ()
        }) : (tensor<128x128xf32>, tensor<128x128xbf16>) -> tensor<128x128xbf16>
        "tts.scatter"(%12, %63, %69, %67) : (!tt.ptr<bf16>, tensor<128x128xi32>, tensor<128x128xbf16>, tensor<128x128xi1>) -> ()
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

