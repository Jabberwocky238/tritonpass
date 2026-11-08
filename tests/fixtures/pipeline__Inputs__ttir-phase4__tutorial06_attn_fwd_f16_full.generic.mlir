#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0) -> (d0)>
#map4 = affine_map<(d0, d1) -> (d0, d1)>
#map5 = affine_map<(d0, d1) -> (d0, 0)>
"builtin.module"() ({
  "func.func"() <{function_type = (f32, memref<?xf32>, i32, memref<?xf16>, memref<?xf16>, memref<?xf16>, memref<?xf16>, i32) -> (), sym_name = "_attn_fwd"}> ({
  ^bb0(%arg0: f32, %arg1: memref<?xf32>, %arg2: i32, %arg3: memref<?xf16>, %arg4: memref<?xf16>, %arg5: memref<?xf16>, %arg6: memref<?xf16>, %arg7: i32):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 64 : index}> : () -> index
    %3 = "arith.constant"() <{value = 128 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %5 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %6 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = 1.44269502 : f32}> : () -> f32
    %9 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %10 = "tensor.empty"() : () -> tensor<128xf32>
    %11 = "linalg.fill"(%0, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg96: f32, %arg97: f32):
      "linalg.yield"(%arg96) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %12 = "linalg.fill"(%5, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg94: f32, %arg95: f32):
      "linalg.yield"(%arg94) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %13 = "tensor.empty"() : () -> tensor<128x128xf32>
    %14 = "linalg.fill"(%7, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg92: f32, %arg93: f32):
      "linalg.yield"(%arg92) : (f32) -> ()
    }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
    %15 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %16 = "arith.index_cast"(%15) : (index) -> i32
    %17 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %18 = "arith.index_cast"(%17) : (index) -> i32
    %19 = "arith.divsi"(%18, %arg2) : (i32, i32) -> i32
    %20 = "arith.remsi"(%18, %arg2) : (i32, i32) -> i32
    %21 = "arith.muli"(%arg2, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %22 = "arith.muli"(%19, %21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %23 = "arith.muli"(%20, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %24 = "arith.addi"(%22, %23) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %25 = "arith.muli"(%16, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %26 = "arith.index_cast"(%25) : (i32) -> index
    %27 = "arith.addi"(%24, %25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %28 = "arith.mulf"(%arg0, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %29 = "arith.index_cast"(%27) : (i32) -> index
    %30 = "memref.reinterpret_cast"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf16>) -> memref<1099511627776x1099511627776xf16, strided<[128, 1]>>
    %31 = "arith.addi"(%29, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %32 = "arith.index_cast"(%21) : (i32) -> index
    %33 = "arith.minsi"(%31, %32) : (index, index) -> index
    %34 = "arith.maxsi"(%33, %29) : (index, index) -> index
    %35 = "arith.subi"(%34, %29) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %36 = "arith.minsi"(%35, %3) : (index, index) -> index
    %37 = "arith.minsi"(%36, %3) : (index, index) -> index
    %38 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x128xf16>
    "linalg.fill"(%4, %38) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg90: f16, %arg91: f16):
      "linalg.yield"(%arg90) : (f16) -> ()
    }) : (f16, memref<128x128xf16>) -> ()
    %39 = "memref.subview"(%30, %29, %37) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf16, strided<[128, 1]>>, index, index) -> memref<?x128xf16, strided<[128, 1], offset: ?>>
    %40 = "memref.subview"(%38, %37) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<128x128xf16>, index) -> memref<?x128xf16, strided<[128, 1]>>
    "linalg.copy"(%39, %40) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg88: f16, %arg89: f16):
      "linalg.yield"(%arg88) : (f16) -> ()
    }) : (memref<?x128xf16, strided<[128, 1], offset: ?>>, memref<?x128xf16, strided<[128, 1]>>) -> ()
    %41 = "bufferization.to_tensor"(%38) <{restrict, writable}> : (memref<128x128xf16>) -> tensor<128x128xf16>
    %42 = "linalg.fill"(%28, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg86: f32, %arg87: f32):
      "linalg.yield"(%arg86) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %43 = "tensor.empty"() : () -> tensor<128x64xf32>
    %44 = "linalg.fill"(%28, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg84: f32, %arg85: f32):
      "linalg.yield"(%arg84) : (f32) -> ()
    }) : (f32, tensor<128x64xf32>) -> tensor<128x64xf32>
    %45 = "arith.index_cast"(%arg7) : (i32) -> index
    %46:5 = "scf.for"(%1, %45, %2, %14, %11, %12, %24, %24) ({
    ^bb0(%arg20: index, %arg21: tensor<128x128xf32>, %arg22: tensor<128xf32>, %arg23: tensor<128xf32>, %arg24: i32, %arg25: i32):
      %65 = "arith.index_cast"(%arg24) : (i32) -> index
      %66 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf16>) -> memref<1099511627776x1099511627776xf16, strided<[128, 1]>>
      %67 = "arith.addi"(%65, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %68 = "arith.minsi"(%67, %32) : (index, index) -> index
      %69 = "arith.maxsi"(%68, %65) : (index, index) -> index
      %70 = "arith.subi"(%69, %65) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %71 = "arith.minsi"(%70, %2) : (index, index) -> index
      %72 = "arith.minsi"(%71, %2) : (index, index) -> index
      %73 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xf16>
      "linalg.fill"(%4, %73) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg82: f16, %arg83: f16):
        "linalg.yield"(%arg82) : (f16) -> ()
      }) : (f16, memref<64x128xf16>) -> ()
      %74 = "memref.subview"(%66, %65, %72) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf16, strided<[128, 1]>>, index, index) -> memref<?x128xf16, strided<[128, 1], offset: ?>>
      %75 = "memref.subview"(%73, %72) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<64x128xf16>, index) -> memref<?x128xf16, strided<[128, 1]>>
      "linalg.copy"(%74, %75) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg80: f16, %arg81: f16):
        "linalg.yield"(%arg80) : (f16) -> ()
      }) : (memref<?x128xf16, strided<[128, 1], offset: ?>>, memref<?x128xf16, strided<[128, 1]>>) -> ()
      %76 = "bufferization.to_tensor"(%73) <{restrict, writable}> : (memref<64x128xf16>) -> tensor<64x128xf16>
      %77 = "tensor.empty"() : () -> tensor<128x64xf16>
      %78 = "linalg.transpose"(%76, %77) <{permutation = array<i64: 1, 0>}> ({
      ^bb0(%arg78: f16, %arg79: f16):
        "linalg.yield"(%arg78) : (f16) -> ()
      }) : (tensor<64x128xf16>, tensor<128x64xf16>) -> tensor<128x64xf16>
      %79 = "linalg.fill"(%7, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg76: f32, %arg77: f32):
        "linalg.yield"(%arg76) : (f32) -> ()
      }) : (f32, tensor<128x64xf32>) -> tensor<128x64xf32>
      %80 = "linalg.matmul"(%41, %78, %79) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg73: f16, %arg74: f16, %arg75: f32):
        %131 = "arith.extf"(%arg73) : (f16) -> f32
        %132 = "arith.extf"(%arg74) : (f16) -> f32
        %133 = "arith.mulf"(%131, %132) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %134 = "arith.addf"(%arg75, %133) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%134) : (f32) -> ()
      }) : (tensor<128x128xf16>, tensor<128x64xf16>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %81 = "linalg.reduce"(%80, %12) <{dimensions = array<i64: 1>}> ({
      ^bb0(%arg71: f32, %arg72: f32):
        %130 = "arith.maxnumf"(%arg71, %arg72) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%130) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128xf32>) -> tensor<128xf32>
      %82 = "linalg.generic"(%81, %42, %81) <{indexing_maps = [#map3, #map3, #map3], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg68: f32, %arg69: f32, %arg70: f32):
        %129 = "arith.mulf"(%arg68, %arg69) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%129) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %83 = "linalg.generic"(%arg23, %82, %arg23) <{indexing_maps = [#map3, #map3, #map3], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg65: f32, %arg66: f32, %arg67: f32):
        %128 = "arith.maxnumf"(%arg65, %arg66) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%128) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %84 = "linalg.generic"(%80, %44, %80) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg62: f32, %arg63: f32, %arg64: f32):
        %127 = "arith.mulf"(%arg62, %arg63) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%127) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %85 = "tensor.expand_shape"(%83) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %86 = "linalg.generic"(%85, %43) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg60: f32, %arg61: f32):
        "linalg.yield"(%arg60) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %87 = "linalg.generic"(%84, %86, %84) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg57: f32, %arg58: f32, %arg59: f32):
        %126 = "arith.subf"(%arg57, %arg58) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%126) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %88 = "linalg.generic"(%87, %87) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg55: f32, %arg56: f32):
        %125 = "math.exp2"(%arg55) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%125) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf32>) -> tensor<128x64xf32>
      %89 = "linalg.generic"(%arg23, %83, %arg23) <{indexing_maps = [#map3, #map3, #map3], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg52: f32, %arg53: f32, %arg54: f32):
        %124 = "arith.subf"(%arg52, %arg53) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%124) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %90 = "linalg.generic"(%89, %89) <{indexing_maps = [#map3, #map3], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg50: f32, %arg51: f32):
        %123 = "math.exp2"(%arg50) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%123) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %91 = "linalg.fill"(%7, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg48: f32, %arg49: f32):
        "linalg.yield"(%arg48) : (f32) -> ()
      }) : (f32, tensor<128xf32>) -> tensor<128xf32>
      %92 = "linalg.reduce"(%88, %91) <{dimensions = array<i64: 1>}> ({
      ^bb0(%arg46: f32, %arg47: f32):
        %122 = "arith.addf"(%arg46, %arg47) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%122) : (f32) -> ()
      }) : (tensor<128x64xf32>, tensor<128xf32>) -> tensor<128xf32>
      %93 = "tensor.expand_shape"(%90) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %94 = "linalg.generic"(%93, %13) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg44: f32, %arg45: f32):
        "linalg.yield"(%arg44) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %95 = "linalg.generic"(%arg21, %94, %arg21) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg41: f32, %arg42: f32, %arg43: f32):
        %121 = "arith.mulf"(%arg41, %arg42) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%121) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %96 = "arith.index_cast"(%arg25) : (i32) -> index
      %97 = "memref.reinterpret_cast"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf16>) -> memref<1099511627776x1099511627776xf16, strided<[128, 1]>>
      %98 = "arith.addi"(%96, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %99 = "arith.minsi"(%98, %32) : (index, index) -> index
      %100 = "arith.maxsi"(%99, %96) : (index, index) -> index
      %101 = "arith.subi"(%100, %96) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %102 = "arith.minsi"(%101, %2) : (index, index) -> index
      %103 = "arith.minsi"(%102, %2) : (index, index) -> index
      %104 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xf16>
      "linalg.fill"(%4, %104) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg39: f16, %arg40: f16):
        "linalg.yield"(%arg39) : (f16) -> ()
      }) : (f16, memref<64x128xf16>) -> ()
      %105 = "memref.subview"(%97, %96, %103) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf16, strided<[128, 1]>>, index, index) -> memref<?x128xf16, strided<[128, 1], offset: ?>>
      %106 = "memref.subview"(%104, %103) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<64x128xf16>, index) -> memref<?x128xf16, strided<[128, 1]>>
      "linalg.copy"(%105, %106) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg37: f16, %arg38: f16):
        "linalg.yield"(%arg37) : (f16) -> ()
      }) : (memref<?x128xf16, strided<[128, 1], offset: ?>>, memref<?x128xf16, strided<[128, 1]>>) -> ()
      %107 = "bufferization.to_tensor"(%104) <{restrict, writable}> : (memref<64x128xf16>) -> tensor<64x128xf16>
      %108 = "linalg.generic"(%88, %77) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg35: f32, %arg36: f16):
        %120 = "arith.truncf"(%arg35) : (f32) -> f16
        "linalg.yield"(%120) : (f16) -> ()
      }) : (tensor<128x64xf32>, tensor<128x64xf16>) -> tensor<128x64xf16>
      %109 = "linalg.matmul"(%108, %107, %95) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg32: f16, %arg33: f16, %arg34: f32):
        %116 = "arith.extf"(%arg32) : (f16) -> f32
        %117 = "arith.extf"(%arg33) : (f16) -> f32
        %118 = "arith.mulf"(%116, %117) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %119 = "arith.addf"(%arg34, %118) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%119) : (f32) -> ()
      }) : (tensor<128x64xf16>, tensor<64x128xf16>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %110 = "linalg.generic"(%arg22, %90, %arg22) <{indexing_maps = [#map3, #map3, #map3], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg29: f32, %arg30: f32, %arg31: f32):
        %115 = "arith.mulf"(%arg29, %arg30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%115) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %111 = "linalg.generic"(%110, %92, %110) <{indexing_maps = [#map3, #map3, #map3], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg26: f32, %arg27: f32, %arg28: f32):
        %114 = "arith.addf"(%arg26, %arg27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%114) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %112 = "arith.addi"(%arg24, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %113 = "arith.addi"(%arg25, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%109, %111, %83, %112, %113) : (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32) -> ()
    }) : (index, index, index, tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32) -> (tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>, i32, i32)
    %47 = "linalg.generic"(%46#1, %46#1) <{indexing_maps = [#map3, #map3], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: f32, %arg19: f32):
      %64 = "math.log2"(%arg18) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%64) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %48 = "linalg.generic"(%46#2, %47, %46#2) <{indexing_maps = [#map3, #map3, #map3], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32, %arg17: f32):
      %63 = "arith.addf"(%arg15, %arg16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%63) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %49 = "tensor.expand_shape"(%46#1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
    %50 = "linalg.generic"(%49, %13) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      "linalg.yield"(%arg13) : (f32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    %51 = "linalg.generic"(%46#0, %50, %46#0) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32, %arg12: f32):
      %62 = "arith.divf"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%62) : (f32) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    %52 = "arith.muli"(%18, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %53 = "arith.index_cast"(%52) : (i32) -> index
    %54 = "arith.addi"(%53, %26) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %55 = "memref.subview"(%arg1, %54) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<128xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%48, %55) <{writable}> : (tensor<128xf32>, memref<128xf32, strided<[1], offset: ?>>) -> ()
    %56 = "tensor.empty"() : () -> tensor<128x128xf16>
    %57 = "linalg.generic"(%51, %56) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f16):
      %61 = "arith.truncf"(%arg8) : (f32) -> f16
      "linalg.yield"(%61) : (f16) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xf16>) -> tensor<128x128xf16>
    %58 = "memref.reinterpret_cast"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf16>) -> memref<1099511627776x1099511627776xf16, strided<[128, 1]>>
    %59 = "tensor.extract_slice"(%57, %37) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (tensor<128x128xf16>, index) -> tensor<?x128xf16>
    %60 = "memref.subview"(%58, %29, %37) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf16, strided<[128, 1]>>, index, index) -> memref<?x128xf16, strided<[128, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%59, %60) <{writable}> : (tensor<?x128xf16>, memref<?x128xf16, strided<[128, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

