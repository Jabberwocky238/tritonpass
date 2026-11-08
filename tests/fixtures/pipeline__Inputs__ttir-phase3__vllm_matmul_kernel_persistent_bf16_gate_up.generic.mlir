#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map4 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "matmul_kernel_persistent"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xbf16>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 132 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %6 = "arith.constant"() <{value = 128 : index}> : () -> index
    %7 = "arith.constant"() <{value = 63 : i32}> : () -> i32
    %8 = "arith.constant"() <{value = 127 : i32}> : () -> i32
    %9 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %10 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %11 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %12 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %13 = "arith.constant"() <{value = 132 : i32}> : () -> i32
    %14 = "tensor.empty"() : () -> tensor<128x128xf32>
    %15 = "linalg.fill"(%0, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg55: f32, %arg56: f32):
      "linalg.yield"(%arg55) : (f32) -> ()
    }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
    %16 = "tensor.empty"() : () -> tensor<128xi32>
    %17 = "linalg.fill"(%10, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg53: i32, %arg54: i32):
      "linalg.yield"(%arg53) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %18 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %19 = "arith.index_cast"(%18) : (index) -> i32
    %20 = "arith.addi"(%arg3, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %21 = "arith.divsi"(%20, %11) : (i32, i32) -> i32
    %22 = "arith.addi"(%arg4, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %23 = "arith.divsi"(%22, %11) : (i32, i32) -> i32
    %24 = "arith.addi"(%arg5, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %25 = "arith.divsi"(%24, %9) : (i32, i32) -> i32
    %26 = "arith.muli"(%21, %23) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %27 = "arith.subi"(%19, %13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %28 = "arith.muli"(%23, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %29 = "linalg.generic"(%16) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg52: i32):
      %126 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %127 = "arith.index_cast"(%126) : (index) -> i32
      "linalg.yield"(%127) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %30 = "linalg.fill"(%arg3, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg50: i32, %arg51: i32):
      "linalg.yield"(%arg50) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %31 = "linalg.fill"(%arg4, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg48: i32, %arg49: i32):
      "linalg.yield"(%arg48) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %32 = "arith.index_cast"(%26) : (i32) -> index
    %33 = "scf.for"(%18, %32, %1, %27) ({
    ^bb0(%arg9: index, %arg10: i32):
      %34 = "arith.index_cast"(%arg9) : (index) -> i32
      %35 = "arith.divsi"(%34, %28) : (i32, i32) -> i32
      %36 = "arith.muli"(%35, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %37 = "arith.subi"(%21, %36) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %38 = "arith.minsi"(%37, %12) : (i32, i32) -> i32
      %39 = "arith.remsi"(%34, %38) : (i32, i32) -> i32
      %40 = "arith.addi"(%36, %39) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %41 = "arith.remsi"(%34, %28) : (i32, i32) -> i32
      %42 = "arith.divsi"(%41, %38) : (i32, i32) -> i32
      %43 = "arith.muli"(%40, %11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %44 = "arith.muli"(%42, %11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %45 = "linalg.fill"(%43, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg46: i32, %arg47: i32):
        "linalg.yield"(%arg46) : (i32) -> ()
      }) : (i32, tensor<128xi32>) -> tensor<128xi32>
      %46 = "linalg.generic"(%45, %29, %45) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg43: i32, %arg44: i32, %arg45: i32):
        %125 = "arith.addi"(%arg43, %arg44) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%125) : (i32) -> ()
      }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
      %47 = "linalg.fill"(%44, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg41: i32, %arg42: i32):
        "linalg.yield"(%arg41) : (i32) -> ()
      }) : (i32, tensor<128xi32>) -> tensor<128xi32>
      %48 = "linalg.generic"(%47, %29, %47) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg38: i32, %arg39: i32, %arg40: i32):
        %124 = "arith.addi"(%arg38, %arg39) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%124) : (i32) -> ()
      }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
      %49 = "tensor.empty"() : () -> tensor<128xi1>
      %50 = "linalg.generic"(%46, %30, %49) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg35: i32, %arg36: i32, %arg37: i1):
        %123 = "arith.cmpi"(%arg35, %arg36) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "linalg.yield"(%123) : (i1) -> ()
      }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi1>) -> tensor<128xi1>
      %51 = "linalg.generic"(%50, %46, %17, %46) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg31: i1, %arg32: i32, %arg33: i32, %arg34: i32):
        %122 = "arith.select"(%arg31, %arg32, %arg33) {tt.contiguity = dense<128> : tensor<1xi32>, tt.divisibility = dense<128> : tensor<1xi32>} : (i1, i32, i32) -> i32
        "linalg.yield"(%122) : (i32) -> ()
      }) : (tensor<128xi1>, tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
      %52 = "linalg.generic"(%48, %31, %49) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg28: i32, %arg29: i32, %arg30: i1):
        %121 = "arith.cmpi"(%arg28, %arg29) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "linalg.yield"(%121) : (i1) -> ()
      }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi1>) -> tensor<128xi1>
      %53 = "linalg.generic"(%52, %48, %17, %48) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg24: i1, %arg25: i32, %arg26: i32, %arg27: i32):
        %120 = "arith.select"(%arg24, %arg25, %arg26) {tt.contiguity = dense<128> : tensor<1xi32>, tt.divisibility = dense<128> : tensor<1xi32>} : (i1, i32, i32) -> i32
        "linalg.yield"(%120) : (i32) -> ()
      }) : (tensor<128xi1>, tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
      %54 = "arith.index_cast"(%25) : (i32) -> index
      %55 = "scf.for"(%2, %54, %3, %15) ({
      ^bb0(%arg13: index, %arg14: tensor<128x128xf32>):
        %88 = "arith.index_cast"(%arg13) : (index) -> i32
        %89 = "arith.muli"(%88, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %90 = "arith.index_cast"(%89) : (i32) -> index
        %91 = "arith.index_cast"(%arg6) : (i32) -> index
        %92 = "arith.index_cast"(%arg7) : (i32) -> index
        %93 = "arith.subi"(%arg5, %89) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %94 = "arith.index_cast"(%93) : (i32) -> index
        %95 = "arith.minsi"(%94, %4) : (index, index) -> index
        %96 = "arith.maxsi"(%95, %2) : (index, index) -> index
        %97 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x64xbf16>
        "linalg.fill"(%5, %97) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg22: bf16, %arg23: bf16):
          "linalg.yield"(%arg22) : (bf16) -> ()
        }) : (bf16, memref<128x64xbf16>) -> ()
        "scf.for"(%2, %6, %3) ({
        ^bb0(%arg21: index):
          %113 = "tensor.extract"(%51, %arg21) : (tensor<128xi32>, index) -> i32
          %114 = "arith.index_cast"(%113) : (i32) -> index
          %115 = "arith.muli"(%114, %91) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %116 = "arith.addi"(%115, %90) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %117 = "memref.reinterpret_cast"(%arg0, %116, %91) <{operandSegmentSizes = array<i32: 1, 1, 0, 1>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1, 64>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xbf16>, index, index) -> memref<1x64xbf16, strided<[?, 1], offset: ?>>
          %118 = "memref.subview"(%117, %96) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1x64xbf16, strided<[?, 1], offset: ?>>, index) -> memref<1x?xbf16, strided<[?, 1], offset: ?>>
          %119 = "memref.subview"(%97, %arg21, %96) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<128x64xbf16>, index, index) -> memref<1x?xbf16, strided<[64, 1], offset: ?>>
          "memref.copy"(%118, %119) : (memref<1x?xbf16, strided<[?, 1], offset: ?>>, memref<1x?xbf16, strided<[64, 1], offset: ?>>) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %98 = "bufferization.to_tensor"(%97) <{restrict, writable}> : (memref<128x64xbf16>) -> tensor<128x64xbf16>
        %99 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xbf16>
        "linalg.fill"(%5, %99) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg19: bf16, %arg20: bf16):
          "linalg.yield"(%arg19) : (bf16) -> ()
        }) : (bf16, memref<64x128xbf16>) -> ()
        "scf.for"(%2, %6, %3) ({
        ^bb0(%arg18: index):
          %106 = "tensor.extract"(%53, %arg18) : (tensor<128xi32>, index) -> i32
          %107 = "arith.index_cast"(%106) : (i32) -> index
          %108 = "arith.muli"(%107, %92) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %109 = "arith.addi"(%90, %108) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %110 = "memref.reinterpret_cast"(%arg1, %109, %92) <{operandSegmentSizes = array<i32: 1, 1, 0, 1>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 64, 1>, static_strides = array<i64: 1, -9223372036854775808>}> : (memref<?xbf16>, index, index) -> memref<64x1xbf16, strided<[1, ?], offset: ?>>
          %111 = "memref.subview"(%110, %96) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (memref<64x1xbf16, strided<[1, ?], offset: ?>>, index) -> memref<?x1xbf16, strided<[1, ?], offset: ?>>
          %112 = "memref.subview"(%99, %arg18, %96) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (memref<64x128xbf16>, index, index) -> memref<?x1xbf16, strided<[128, 1], offset: ?>>
          "memref.copy"(%111, %112) : (memref<?x1xbf16, strided<[1, ?], offset: ?>>, memref<?x1xbf16, strided<[128, 1], offset: ?>>) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %100 = "bufferization.to_tensor"(%99) <{restrict, writable}> : (memref<64x128xbf16>) -> tensor<64x128xbf16>
        %101 = "linalg.matmul"(%98, %100, %arg14) <{indexing_maps = [#map1, #map2, #map3], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg15: bf16, %arg16: bf16, %arg17: f32):
          %102 = "arith.extf"(%arg15) : (bf16) -> f32
          %103 = "arith.extf"(%arg16) : (bf16) -> f32
          %104 = "arith.mulf"(%102, %103) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          %105 = "arith.addf"(%arg17, %104) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%105) : (f32) -> ()
        }) : (tensor<128x64xbf16>, tensor<64x128xbf16>, tensor<128x128xf32>) -> tensor<128x128xf32>
        "scf.yield"(%101) : (tensor<128x128xf32>) -> ()
      }) : (index, index, index, tensor<128x128xf32>) -> tensor<128x128xf32>
      %56 = "arith.addi"(%arg10, %13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %57 = "arith.divsi"(%56, %28) : (i32, i32) -> i32
      %58 = "arith.muli"(%57, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %59 = "arith.subi"(%21, %58) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %60 = "arith.minsi"(%59, %12) : (i32, i32) -> i32
      %61 = "arith.remsi"(%56, %60) : (i32, i32) -> i32
      %62 = "arith.addi"(%58, %61) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %63 = "arith.remsi"(%56, %28) : (i32, i32) -> i32
      %64 = "arith.divsi"(%63, %60) : (i32, i32) -> i32
      %65 = "arith.muli"(%62, %11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %66 = "arith.index_cast"(%65) : (i32) -> index
      %67 = "arith.muli"(%64, %11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %68 = "arith.index_cast"(%67) : (i32) -> index
      %69 = "arith.index_cast"(%arg8) : (i32) -> index
      %70 = "memref.reinterpret_cast"(%arg2, %69) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xbf16>, index) -> memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>
      %71 = "tensor.empty"() : () -> tensor<128x128xbf16>
      %72 = "linalg.generic"(%55, %71) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg11: f32, %arg12: bf16):
        %87 = "arith.truncf"(%arg11) : (f32) -> bf16
        "linalg.yield"(%87) : (bf16) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xbf16>) -> tensor<128x128xbf16>
      %73 = "arith.addi"(%66, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %74 = "arith.index_cast"(%arg3) : (i32) -> index
      %75 = "arith.minsi"(%73, %74) : (index, index) -> index
      %76 = "arith.maxsi"(%75, %66) : (index, index) -> index
      %77 = "arith.subi"(%76, %66) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %78 = "arith.addi"(%68, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %79 = "arith.index_cast"(%arg4) : (i32) -> index
      %80 = "arith.minsi"(%78, %79) : (index, index) -> index
      %81 = "arith.maxsi"(%80, %68) : (index, index) -> index
      %82 = "arith.subi"(%81, %68) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %83 = "arith.minsi"(%77, %6) : (index, index) -> index
      %84 = "arith.minsi"(%82, %6) : (index, index) -> index
      %85 = "tensor.extract_slice"(%72, %83, %84) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<128x128xbf16>, index, index) -> tensor<?x?xbf16>
      %86 = "memref.subview"(%70, %66, %68, %83, %84) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[?, 1], offset: ?>>
      "bufferization.materialize_in_destination"(%85, %86) <{writable}> : (tensor<?x?xbf16>, memref<?x?xbf16, strided<[?, 1], offset: ?>>) -> ()
      "scf.yield"(%56) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

