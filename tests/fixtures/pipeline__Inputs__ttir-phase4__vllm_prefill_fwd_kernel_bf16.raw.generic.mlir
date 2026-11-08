#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map4 = affine_map<(d0, d1) -> (d0, d1)>
#map5 = affine_map<(d0, d1) -> (0, d1)>
#map6 = affine_map<(d0, d1) -> (d0, 0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, f32, memref<?xi32>, memref<?xi32>, memref<?xbf16>, i32, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "_fwd_kernel"}> ({
  ^bb0(%arg14: memref<?xbf16>, %arg15: memref<?xbf16>, %arg16: memref<?xbf16>, %arg17: memref<?xbf16>, %arg18: f32, %arg19: memref<?xi32>, %arg20: memref<?xi32>, %arg21: memref<?xbf16>, %arg22: i32, %arg23: i32, %arg24: i32, %arg25: i32, %arg26: i32, %arg27: i32, %arg28: i32, %arg29: i32):
    %12 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %13 = "arith.constant"() <{value = 0 : index}> : () -> index
    %14 = "arith.constant"() <{value = 128 : index}> : () -> index
    %15 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %16 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %17 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %18 = "arith.constant"() <{value = -1.000000e+08 : f32}> : () -> f32
    %19 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %20 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %21 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %22 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %23 = "tensor.empty"() : () -> tensor<128xf32>
    %24 = "linalg.fill"(%12, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg142: f32, %arg143: f32):
      "linalg.yield"(%arg142) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %25 = "linalg.fill"(%17, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg140: f32, %arg141: f32):
      "linalg.yield"(%arg140) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %26 = "tensor.empty"() : () -> tensor<128x128xf32>
    %27 = "linalg.fill"(%18, %26) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg138: f32, %arg139: f32):
      "linalg.yield"(%arg138) : (f32) -> ()
    }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
    %28 = "linalg.fill"(%20, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg136: f32, %arg137: f32):
      "linalg.yield"(%arg136) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %29 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %30 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %31 = "arith.index_cast"(%30) : (index) -> i32
    %32 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
    %33 = "arith.index_cast"(%32) : (index) -> i32
    %34 = "arith.divsi"(%31, %22) : (i32, i32) -> i32
    %35 = "memref.reinterpret_cast"(%arg20) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %36 = "memref.load"(%35, %29) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %37 = "memref.reinterpret_cast"(%arg19) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %38 = "memref.load"(%37, %29) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %39 = "arith.index_cast"(%38) : (i32) -> index
    %40 = "arith.muli"(%33, %21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %41 = "tensor.empty"() : () -> tensor<128xi32>
    %42 = "linalg.generic"(%41) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg135: i32):
      %184 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %185 = "arith.index_cast"(%184) : (index) -> i32
      "linalg.yield"(%185) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %43 = "arith.index_cast"(%40) : (i32) -> index
    %44 = "arith.muli"(%31, %arg23) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %45 = "arith.index_cast"(%44) : (i32) -> index
    %46 = "arith.muli"(%34, %arg25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %47 = "arith.index_cast"(%46) : (i32) -> index
    %48 = "arith.muli"(%34, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %49 = "arith.index_cast"(%48) : (i32) -> index
    %50 = "arith.addi"(%39, %43) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %51 = "arith.index_cast"(%arg22) : (i32) -> index
    %52 = "memref.reinterpret_cast"(%arg14, %51) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xbf16>, index) -> memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>
    %53 = "arith.addi"(%43, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %54 = "arith.index_cast"(%36) : (i32) -> index
    %55 = "arith.minsi"(%53, %54) : (index, index) -> index
    %56 = "arith.maxsi"(%55, %43) : (index, index) -> index
    %57 = "arith.subi"(%56, %43) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %58 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x128xbf16>
    "linalg.fill"(%15, %58) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg133: bf16, %arg134: bf16):
      "linalg.yield"(%arg133) : (bf16) -> ()
    }) : (bf16, memref<128x128xbf16>) -> ()
    %59 = "memref.subview"(%52, %50, %45, %57) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>, index, index, index) -> memref<?x128xbf16, strided<[?, 1], offset: ?>>
    %60 = "memref.subview"(%58, %57) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<128x128xbf16>, index) -> memref<?x128xbf16, strided<[128, 1]>>
    "linalg.copy"(%59, %60) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg131: bf16, %arg132: bf16):
      "linalg.yield"(%arg131) : (bf16) -> ()
    }) : (memref<?x128xbf16, strided<[?, 1], offset: ?>>, memref<?x128xbf16, strided<[128, 1]>>) -> ()
    %61 = "bufferization.to_tensor"(%58) <{restrict, writable}> : (memref<128x128xbf16>) -> tensor<128x128xbf16>
    %62 = "arith.index_cast"(%arg24) : (i32) -> index
    %63 = "arith.index_cast"(%arg26) : (i32) -> index
    %64 = "func.call"() <{callee = @triton.language.standard.zeros__Tc128T_cfp32}> : () -> tensor<128xf32>
    %65 = "linalg.generic"(%64, %28, %64) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg128: f32, %arg129: f32, %arg130: f32):
      %183 = "arith.subf"(%arg128, %arg129) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%183) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %66 = "func.call"() <{callee = @triton.language.standard.zeros__Tc128T_cfp32}> : () -> tensor<128xf32>
    %67 = "func.call"() <{callee = @triton.language.standard.zeros__Tc128_c128T_cfp32}> : () -> tensor<128x128xf32>
    %68 = "arith.cmpi"(%40, %36) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %69 = "arith.extui"(%68) : (i1) -> i32
    %70 = "arith.addi"(%33, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %71 = "arith.muli"(%70, %21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %72 = "arith.minsi"(%36, %71) : (i32, i32) -> i32
    %73 = "arith.muli"(%69, %72) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %74 = "arith.index_cast"(%73) : (i32) -> index
    %75:3 = "scf.for"(%13, %74, %14, %65, %66, %67) ({
    ^bb0(%arg37: index, %arg38: tensor<128xf32>, %arg39: tensor<128xf32>, %arg40: tensor<128x128xf32>):
      %89 = "arith.index_cast"(%arg37) : (index) -> i32
      %90 = "arith.addi"(%38, %89) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %91 = "arith.muli"(%90, %arg24) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %92 = "arith.index_cast"(%91) : (i32) -> index
      %93 = "memref.reinterpret_cast"(%arg15, %62) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, -9223372036854775808>}> : (memref<?xbf16>, index) -> memref<1099511627776x1099511627776xbf16, strided<[1, ?]>>
      %94 = "arith.addi"(%arg37, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %95 = "arith.minsi"(%94, %54) : (index, index) -> index
      %96 = "arith.maxsi"(%95, %arg37) : (index, index) -> index
      %97 = "arith.subi"(%96, %arg37) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %98 = "arith.addi"(%47, %92) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %99 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x128xbf16>
      "linalg.fill"(%15, %99) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg126: bf16, %arg127: bf16):
        "linalg.yield"(%arg126) : (bf16) -> ()
      }) : (bf16, memref<128x128xbf16>) -> ()
      %100 = "memref.subview"(%93, %98, %97) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 128, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[1, ?]>>, index, index) -> memref<128x?xbf16, strided<[1, ?], offset: ?>>
      %101 = "memref.subview"(%99, %97) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 128, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<128x128xbf16>, index) -> memref<128x?xbf16, strided<[128, 1]>>
      "linalg.copy"(%100, %101) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg124: bf16, %arg125: bf16):
        "linalg.yield"(%arg124) : (bf16) -> ()
      }) : (memref<128x?xbf16, strided<[1, ?], offset: ?>>, memref<128x?xbf16, strided<[128, 1]>>) -> ()
      %102 = "bufferization.to_tensor"(%99) <{restrict, writable}> : (memref<128x128xbf16>) -> tensor<128x128xbf16>
      %103 = "linalg.fill"(%17, %26) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg122: f32, %arg123: f32):
        "linalg.yield"(%arg122) : (f32) -> ()
      }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
      %104 = "linalg.matmul"(%61, %102, %103) <{indexing_maps = [#map1, #map2, #map3], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg119: bf16, %arg120: bf16, %arg121: f32):
        %179 = "arith.extf"(%arg119) : (bf16) -> f32
        %180 = "arith.extf"(%arg120) : (bf16) -> f32
        %181 = "arith.mulf"(%179, %180) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %182 = "arith.addf"(%arg121, %181) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%182) : (f32) -> ()
      }) : (tensor<128x128xbf16>, tensor<128x128xbf16>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %105 = "linalg.fill"(%arg18, %26) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg117: f32, %arg118: f32):
        "linalg.yield"(%arg117) : (f32) -> ()
      }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
      %106 = "linalg.generic"(%104, %105, %104) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg114: f32, %arg115: f32, %arg116: f32):
        %178 = "arith.mulf"(%arg114, %arg115) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%178) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %107 = "arith.subi"(%89, %36) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %108 = "linalg.generic"(%42, %23) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg112: i32, %arg113: f32):
        %177 = "arith.sitofp"(%arg112) : (i32) -> f32
        "linalg.yield"(%177) : (f32) -> ()
      }) : (tensor<128xi32>, tensor<128xf32>) -> tensor<128xf32>
      %109 = "linalg.generic"(%108, %25, %108) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg109: f32, %arg110: f32, %arg111: f32):
        %176 = "arith.addf"(%arg109, %arg110) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%176) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %110 = "tensor.expand_shape"(%109) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xf32>) -> tensor<1x128xf32>
      %111 = "linalg.generic"(%110, %26) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg107: f32, %arg108: f32):
        "linalg.yield"(%arg107) : (f32) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %112 = "arith.subi"(%16, %107) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %113 = "arith.sitofp"(%112) : (i32) -> f32
      %114 = "linalg.fill"(%113, %26) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg105: f32, %arg106: f32):
        "linalg.yield"(%arg105) : (f32) -> ()
      }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
      %115 = "tensor.empty"() : () -> tensor<128x128xi1>
      %116 = "linalg.generic"(%111, %114, %115) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg102: f32, %arg103: f32, %arg104: i1):
        %175 = "arith.cmpf"(%arg102, %arg103) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%175) : (i1) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xi1>) -> tensor<128x128xi1>
      %117 = "arith.subi"(%40, %89) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %118 = "tensor.expand_shape"(%109) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %119 = "linalg.generic"(%118, %26) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg100: f32, %arg101: f32):
        "linalg.yield"(%arg100) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %120 = "linalg.generic"(%108, %24, %108) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg97: f32, %arg98: f32, %arg99: f32):
        %174 = "arith.mulf"(%arg97, %arg98) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%174) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %121 = "linalg.generic"(%120, %25, %120) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg94: f32, %arg95: f32, %arg96: f32):
        %173 = "arith.addf"(%arg94, %arg95) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%173) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %122 = "tensor.expand_shape"(%121) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xf32>) -> tensor<1x128xf32>
      %123 = "linalg.generic"(%122, %26) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg92: f32, %arg93: f32):
        "linalg.yield"(%arg92) : (f32) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %124 = "linalg.generic"(%119, %123, %119) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg89: f32, %arg90: f32, %arg91: f32):
        %172 = "arith.addf"(%arg89, %arg90) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%172) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %125 = "arith.subi"(%16, %117) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %126 = "arith.sitofp"(%125) : (i32) -> f32
      %127 = "linalg.fill"(%126, %26) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg87: f32, %arg88: f32):
        "linalg.yield"(%arg87) : (f32) -> ()
      }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
      %128 = "linalg.generic"(%124, %127, %115) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg84: f32, %arg85: f32, %arg86: i1):
        %171 = "arith.cmpf"(%arg84, %arg85) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%171) : (i1) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xi1>) -> tensor<128x128xi1>
      %129 = "linalg.generic"(%128, %106, %27, %106) <{indexing_maps = [#map4, #map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg80: i1, %arg81: f32, %arg82: f32, %arg83: f32):
        %170 = "arith.select"(%arg80, %arg81, %arg82) : (i1, f32, f32) -> f32
        "linalg.yield"(%170) : (f32) -> ()
      }) : (tensor<128x128xi1>, tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %130 = "linalg.generic"(%116, %129, %27, %129) <{indexing_maps = [#map4, #map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg76: i1, %arg77: f32, %arg78: f32, %arg79: f32):
        %169 = "arith.select"(%arg76, %arg77, %arg78) : (i1, f32, f32) -> f32
        "linalg.yield"(%169) : (f32) -> ()
      }) : (tensor<128x128xi1>, tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %131 = "func.call"(%130) <{callee = @triton.language.standard.max__fp32S128_128S_c1_cFalse_cTrue_cFalse}> : (tensor<128x128xf32>) -> tensor<128xf32>
      %132 = "linalg.generic"(%arg38, %131, %arg38) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg73: f32, %arg74: f32, %arg75: f32):
        %168 = "arith.maxnumf"(%arg73, %arg74) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%168) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %133 = "tensor.expand_shape"(%132) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %134 = "linalg.generic"(%133, %26) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg71: f32, %arg72: f32):
        "linalg.yield"(%arg71) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %135 = "linalg.generic"(%130, %134, %130) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg68: f32, %arg69: f32, %arg70: f32):
        %167 = "arith.subf"(%arg68, %arg69) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%167) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %136 = "linalg.generic"(%135, %135) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg66: f32, %arg67: f32):
        %166 = "math.exp2"(%arg66) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%166) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %137 = "func.call"(%136) <{callee = @triton.language.standard.sum__fp32S128_128S_c1_cFalse_cNone}> : (tensor<128x128xf32>) -> tensor<128xf32>
      %138 = "linalg.generic"(%arg38, %132, %arg38) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg63: f32, %arg64: f32, %arg65: f32):
        %165 = "arith.subf"(%arg63, %arg64) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%165) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %139 = "linalg.generic"(%138, %138) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg61: f32, %arg62: f32):
        %164 = "math.exp2"(%arg61) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%164) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %140 = "linalg.generic"(%arg39, %139, %arg39) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg58: f32, %arg59: f32, %arg60: f32):
        %163 = "arith.mulf"(%arg58, %arg59) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%163) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %141 = "linalg.generic"(%140, %137, %140) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg55: f32, %arg56: f32, %arg57: f32):
        %162 = "arith.addf"(%arg55, %arg56) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%162) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %142 = "tensor.expand_shape"(%139) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %143 = "linalg.generic"(%142, %26) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg53: f32, %arg54: f32):
        "linalg.yield"(%arg53) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %144 = "linalg.generic"(%arg40, %143, %arg40) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg50: f32, %arg51: f32, %arg52: f32):
        %161 = "arith.mulf"(%arg50, %arg51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%161) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %145 = "arith.muli"(%90, %arg26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %146 = "arith.index_cast"(%145) : (i32) -> index
      %147 = "memref.reinterpret_cast"(%arg16, %63) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xbf16>, index) -> memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>
      %148 = "arith.addi"(%49, %146) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %149 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x128xbf16>
      "linalg.fill"(%15, %149) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg48: bf16, %arg49: bf16):
        "linalg.yield"(%arg48) : (bf16) -> ()
      }) : (bf16, memref<128x128xbf16>) -> ()
      %150 = "memref.subview"(%147, %148, %97) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>, index, index) -> memref<?x128xbf16, strided<[?, 1], offset: ?>>
      %151 = "memref.subview"(%149, %97) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<128x128xbf16>, index) -> memref<?x128xbf16, strided<[128, 1]>>
      "linalg.copy"(%150, %151) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg46: bf16, %arg47: bf16):
        "linalg.yield"(%arg46) : (bf16) -> ()
      }) : (memref<?x128xbf16, strided<[?, 1], offset: ?>>, memref<?x128xbf16, strided<[128, 1]>>) -> ()
      %152 = "bufferization.to_tensor"(%149) <{restrict, writable}> : (memref<128x128xbf16>) -> tensor<128x128xbf16>
      %153 = "tensor.empty"() : () -> tensor<128x128xbf16>
      %154 = "linalg.generic"(%136, %153) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg44: f32, %arg45: bf16):
        %160 = "arith.truncf"(%arg44) : (f32) -> bf16
        "linalg.yield"(%160) : (bf16) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xbf16>) -> tensor<128x128xbf16>
      %155 = "linalg.matmul"(%154, %152, %144) <{indexing_maps = [#map1, #map2, #map3], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg41: bf16, %arg42: bf16, %arg43: f32):
        %156 = "arith.extf"(%arg41) : (bf16) -> f32
        %157 = "arith.extf"(%arg42) : (bf16) -> f32
        %158 = "arith.mulf"(%156, %157) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %159 = "arith.addf"(%arg43, %158) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%159) : (f32) -> ()
      }) : (tensor<128x128xbf16>, tensor<128x128xbf16>, tensor<128x128xf32>) -> tensor<128x128xf32>
      "scf.yield"(%132, %141, %155) : (tensor<128xf32>, tensor<128xf32>, tensor<128x128xf32>) -> ()
    }) : (index, index, index, tensor<128xf32>, tensor<128xf32>, tensor<128x128xf32>) -> (tensor<128xf32>, tensor<128xf32>, tensor<128x128xf32>)
    %76 = "tensor.expand_shape"(%75#1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
    %77 = "linalg.generic"(%76, %26) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg35: f32, %arg36: f32):
      "linalg.yield"(%arg35) : (f32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    %78 = "linalg.generic"(%75#2, %77, %75#2) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg32: f32, %arg33: f32, %arg34: f32):
      %88 = "arith.divf"(%arg32, %arg33) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%88) : (f32) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    %79 = "arith.muli"(%31, %arg29) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %80 = "arith.index_cast"(%79) : (i32) -> index
    %81 = "arith.index_cast"(%arg28) : (i32) -> index
    %82 = "memref.reinterpret_cast"(%arg21, %81) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xbf16>, index) -> memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>
    %83 = "tensor.empty"() : () -> tensor<128x128xbf16>
    %84 = "linalg.generic"(%78, %83) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: f32, %arg31: bf16):
      %87 = "arith.truncf"(%arg30) : (f32) -> bf16
      "linalg.yield"(%87) : (bf16) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xbf16>) -> tensor<128x128xbf16>
    %85 = "tensor.extract_slice"(%84, %57) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (tensor<128x128xbf16>, index) -> tensor<?x128xbf16>
    %86 = "memref.subview"(%82, %50, %80, %57) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>, index, index, index) -> memref<?x128xbf16, strided<[?, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%85, %86) <{writable}> : (tensor<?x128xbf16>, memref<?x128xbf16, strided<[?, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<128xf32>, sym_name = "triton.language.standard.zeros__Tc128T_cfp32", sym_visibility = "private"}> ({
    %9 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %10 = "tensor.empty"() : () -> tensor<128xf32>
    %11 = "linalg.fill"(%9, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    "func.return"(%11) : (tensor<128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<128x128xf32>, sym_name = "triton.language.standard.zeros__Tc128_c128T_cfp32", sym_visibility = "private"}> ({
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "tensor.empty"() : () -> tensor<128x128xf32>
    %8 = "linalg.fill"(%6, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
    "func.return"(%8) : (tensor<128x128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<128x128xf32>) -> tensor<128xf32>, sym_name = "triton.language.standard.max__fp32S128_128S_c1_cFalse_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg7: tensor<128x128xf32>):
    %4 = "tt.reduce"(%arg7) <{axis = 1 : i32}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %5 = "func.call"(%arg8, %arg9) <{callee = @triton.language.standard._elementwise_max__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%5) : (f32) -> ()
    }) : (tensor<128x128xf32>) -> tensor<128xf32>
    "func.return"(%4) : (tensor<128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._elementwise_max__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg5: f32, %arg6: f32):
    %3 = "arith.maxnumf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<128x128xf32>) -> tensor<128xf32>, sym_name = "triton.language.standard.sum__fp32S128_128S_c1_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<128x128xf32>):
    %1 = "tt.reduce"(%arg2) <{axis = 1 : i32}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%2) : (f32) -> ()
    }) : (tensor<128x128xf32>) -> tensor<128xf32>
    "func.return"(%1) : (tensor<128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

