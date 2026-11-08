#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map4 = affine_map<(d0, d1) -> (d0, d1)>
#map5 = affine_map<(d0, d1) -> (0, d1)>
#map6 = affine_map<(d0, d1) -> (d0, 0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, f32, memref<?xi32>, memref<?xi32>, memref<?xbf16>, i32, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "_fwd_kernel"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xbf16>, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: f32, %arg5: memref<?xi32>, %arg6: memref<?xi32>, %arg7: memref<?xbf16>, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32, %arg15: i32):
    %0 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 128 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %4 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = -1.000000e+08 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %9 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %10 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %11 = "tensor.empty"() : () -> tensor<128xf32>
    %12 = "linalg.fill"(%0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg129: f32, %arg130: f32):
      "linalg.yield"(%arg129) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %13 = "linalg.fill"(%5, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg127: f32, %arg128: f32):
      "linalg.yield"(%arg127) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %14 = "linalg.fill"(%6, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg125: f32, %arg126: f32):
      "linalg.yield"(%arg125) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %15 = "tensor.empty"() : () -> tensor<128x128xf32>
    %16 = "linalg.fill"(%7, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg123: f32, %arg124: f32):
      "linalg.yield"(%arg123) : (f32) -> ()
    }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
    %17 = "linalg.fill"(%6, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg121: f32, %arg122: f32):
      "linalg.yield"(%arg121) : (f32) -> ()
    }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
    %18 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %19 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %20 = "arith.index_cast"(%19) : (index) -> i32
    %21 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
    %22 = "arith.index_cast"(%21) : (index) -> i32
    %23 = "arith.divsi"(%20, %10) : (i32, i32) -> i32
    %24 = "memref.reinterpret_cast"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %25 = "memref.load"(%24, %18) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %26 = "memref.reinterpret_cast"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %27 = "memref.load"(%26, %18) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %28 = "arith.index_cast"(%27) : (i32) -> index
    %29 = "arith.muli"(%22, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %30 = "arith.index_cast"(%29) : (i32) -> index
    %31 = "tensor.empty"() : () -> tensor<128xi32>
    %32 = "linalg.generic"(%31) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg120: i32):
      %169 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %170 = "arith.index_cast"(%169) : (index) -> i32
      "linalg.yield"(%170) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %33 = "arith.muli"(%20, %arg9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %34 = "arith.index_cast"(%33) : (i32) -> index
    %35 = "arith.muli"(%23, %arg11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %36 = "arith.index_cast"(%35) : (i32) -> index
    %37 = "arith.muli"(%23, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %38 = "arith.index_cast"(%37) : (i32) -> index
    %39 = "arith.addi"(%28, %30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %40 = "arith.index_cast"(%arg8) : (i32) -> index
    %41 = "memref.reinterpret_cast"(%arg0, %40) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xbf16>, index) -> memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>
    %42 = "arith.addi"(%30, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %43 = "arith.index_cast"(%25) : (i32) -> index
    %44 = "arith.minsi"(%42, %43) : (index, index) -> index
    %45 = "arith.maxsi"(%44, %30) : (index, index) -> index
    %46 = "arith.subi"(%45, %30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %47 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x128xbf16>
    "linalg.fill"(%3, %47) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg118: bf16, %arg119: bf16):
      "linalg.yield"(%arg118) : (bf16) -> ()
    }) : (bf16, memref<128x128xbf16>) -> ()
    %48 = "memref.subview"(%41, %39, %34, %46) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>, index, index, index) -> memref<?x128xbf16, strided<[?, 1], offset: ?>>
    %49 = "memref.subview"(%47, %46) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<128x128xbf16>, index) -> memref<?x128xbf16, strided<[128, 1]>>
    "linalg.copy"(%48, %49) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg116: bf16, %arg117: bf16):
      "linalg.yield"(%arg116) : (bf16) -> ()
    }) : (memref<?x128xbf16, strided<[?, 1], offset: ?>>, memref<?x128xbf16, strided<[128, 1]>>) -> ()
    %50 = "bufferization.to_tensor"(%47) <{restrict, writable}> : (memref<128x128xbf16>) -> tensor<128x128xbf16>
    %51 = "arith.index_cast"(%arg10) : (i32) -> index
    %52 = "arith.index_cast"(%arg12) : (i32) -> index
    %53 = "arith.cmpi"(%29, %25) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %54 = "arith.extui"(%53) : (i1) -> i32
    %55 = "arith.addi"(%22, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %56 = "arith.muli"(%55, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %57 = "arith.minsi"(%25, %56) : (i32, i32) -> i32
    %58 = "arith.muli"(%54, %57) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %59 = "linalg.fill"(%arg4, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg114: f32, %arg115: f32):
      "linalg.yield"(%arg114) : (f32) -> ()
    }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
    %60 = "arith.index_cast"(%58) : (i32) -> index
    %61:3 = "scf.for"(%1, %60, %2, %13, %14, %17) ({
    ^bb0(%arg23: index, %arg24: tensor<128xf32>, %arg25: tensor<128xf32>, %arg26: tensor<128x128xf32>):
      %75 = "arith.index_cast"(%arg23) : (index) -> i32
      %76 = "arith.addi"(%27, %75) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %77 = "arith.muli"(%76, %arg10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %78 = "arith.index_cast"(%77) : (i32) -> index
      %79 = "memref.reinterpret_cast"(%arg1, %51) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, -9223372036854775808>}> : (memref<?xbf16>, index) -> memref<1099511627776x1099511627776xbf16, strided<[1, ?]>>
      %80 = "arith.addi"(%arg23, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %81 = "arith.minsi"(%80, %43) : (index, index) -> index
      %82 = "arith.maxsi"(%81, %arg23) : (index, index) -> index
      %83 = "arith.subi"(%82, %arg23) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %84 = "arith.addi"(%36, %78) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %85 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x128xbf16>
      "linalg.fill"(%3, %85) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg112: bf16, %arg113: bf16):
        "linalg.yield"(%arg112) : (bf16) -> ()
      }) : (bf16, memref<128x128xbf16>) -> ()
      %86 = "memref.subview"(%79, %84, %83) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 128, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[1, ?]>>, index, index) -> memref<128x?xbf16, strided<[1, ?], offset: ?>>
      %87 = "memref.subview"(%85, %83) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 128, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<128x128xbf16>, index) -> memref<128x?xbf16, strided<[128, 1]>>
      "linalg.copy"(%86, %87) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg110: bf16, %arg111: bf16):
        "linalg.yield"(%arg110) : (bf16) -> ()
      }) : (memref<128x?xbf16, strided<[1, ?], offset: ?>>, memref<128x?xbf16, strided<[128, 1]>>) -> ()
      %88 = "bufferization.to_tensor"(%85) <{restrict, writable}> : (memref<128x128xbf16>) -> tensor<128x128xbf16>
      %89 = "linalg.matmul"(%50, %88, %17) <{indexing_maps = [#map1, #map2, #map3], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg107: bf16, %arg108: bf16, %arg109: f32):
        %165 = "arith.extf"(%arg107) : (bf16) -> f32
        %166 = "arith.extf"(%arg108) : (bf16) -> f32
        %167 = "arith.mulf"(%165, %166) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %168 = "arith.addf"(%arg109, %167) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%168) : (f32) -> ()
      }) : (tensor<128x128xbf16>, tensor<128x128xbf16>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %90 = "linalg.generic"(%89, %59, %89) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg104: f32, %arg105: f32, %arg106: f32):
        %164 = "arith.mulf"(%arg104, %arg105) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%164) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %91 = "arith.subi"(%75, %25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %92 = "linalg.generic"(%32, %11) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg102: i32, %arg103: f32):
        %163 = "arith.sitofp"(%arg102) : (i32) -> f32
        "linalg.yield"(%163) : (f32) -> ()
      }) : (tensor<128xi32>, tensor<128xf32>) -> tensor<128xf32>
      %93 = "linalg.generic"(%92, %14, %92) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg99: f32, %arg100: f32, %arg101: f32):
        %162 = "arith.addf"(%arg99, %arg100) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%162) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %94 = "tensor.expand_shape"(%93) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xf32>) -> tensor<1x128xf32>
      %95 = "linalg.generic"(%94, %15) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg97: f32, %arg98: f32):
        "linalg.yield"(%arg97) : (f32) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %96 = "arith.subi"(%4, %91) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %97 = "arith.sitofp"(%96) : (i32) -> f32
      %98 = "linalg.fill"(%97, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg95: f32, %arg96: f32):
        "linalg.yield"(%arg95) : (f32) -> ()
      }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
      %99 = "tensor.empty"() : () -> tensor<128x128xi1>
      %100 = "linalg.generic"(%95, %98, %99) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg92: f32, %arg93: f32, %arg94: i1):
        %161 = "arith.cmpf"(%arg92, %arg93) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%161) : (i1) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xi1>) -> tensor<128x128xi1>
      %101 = "arith.subi"(%29, %75) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %102 = "tensor.expand_shape"(%93) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %103 = "linalg.generic"(%102, %15) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg90: f32, %arg91: f32):
        "linalg.yield"(%arg90) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %104 = "linalg.generic"(%92, %12, %92) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg87: f32, %arg88: f32, %arg89: f32):
        %160 = "arith.mulf"(%arg87, %arg88) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%160) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %105 = "linalg.generic"(%104, %14, %104) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg84: f32, %arg85: f32, %arg86: f32):
        %159 = "arith.addf"(%arg84, %arg85) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%159) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %106 = "tensor.expand_shape"(%105) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 128>}> : (tensor<128xf32>) -> tensor<1x128xf32>
      %107 = "linalg.generic"(%106, %15) <{indexing_maps = [#map5, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg82: f32, %arg83: f32):
        "linalg.yield"(%arg82) : (f32) -> ()
      }) {broadcastDims = array<i64: 0>} : (tensor<1x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %108 = "linalg.generic"(%103, %107, %103) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg79: f32, %arg80: f32, %arg81: f32):
        %158 = "arith.addf"(%arg79, %arg80) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%158) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %109 = "arith.subi"(%4, %101) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %110 = "arith.sitofp"(%109) : (i32) -> f32
      %111 = "linalg.fill"(%110, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg77: f32, %arg78: f32):
        "linalg.yield"(%arg77) : (f32) -> ()
      }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
      %112 = "linalg.generic"(%108, %111, %99) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg74: f32, %arg75: f32, %arg76: i1):
        %157 = "arith.cmpf"(%arg74, %arg75) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%157) : (i1) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xi1>) -> tensor<128x128xi1>
      %113 = "linalg.generic"(%112, %90, %16, %90) <{indexing_maps = [#map4, #map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg70: i1, %arg71: f32, %arg72: f32, %arg73: f32):
        %156 = "arith.select"(%arg70, %arg71, %arg72) : (i1, f32, f32) -> f32
        "linalg.yield"(%156) : (f32) -> ()
      }) : (tensor<128x128xi1>, tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %114 = "linalg.generic"(%100, %113, %16, %113) <{indexing_maps = [#map4, #map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg66: i1, %arg67: f32, %arg68: f32, %arg69: f32):
        %155 = "arith.select"(%arg66, %arg67, %arg68) : (i1, f32, f32) -> f32
        "linalg.yield"(%155) : (f32) -> ()
      }) : (tensor<128x128xi1>, tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %115 = "linalg.reduce"(%114, %13) <{dimensions = array<i64: 1>}> ({
      ^bb0(%arg64: f32, %arg65: f32):
        %154 = "arith.maxnumf"(%arg64, %arg65) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%154) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %116 = "linalg.generic"(%arg24, %115, %arg24) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg61: f32, %arg62: f32, %arg63: f32):
        %153 = "arith.maxnumf"(%arg61, %arg62) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%153) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %117 = "tensor.expand_shape"(%116) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %118 = "linalg.generic"(%117, %15) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg59: f32, %arg60: f32):
        "linalg.yield"(%arg59) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %119 = "linalg.generic"(%114, %118, %114) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg56: f32, %arg57: f32, %arg58: f32):
        %152 = "arith.subf"(%arg56, %arg57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%152) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %120 = "linalg.generic"(%119, %119) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg54: f32, %arg55: f32):
        %151 = "math.exp2"(%arg54) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%151) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %121 = "linalg.reduce"(%120, %14) <{dimensions = array<i64: 1>}> ({
      ^bb0(%arg52: f32, %arg53: f32):
        %150 = "arith.addf"(%arg52, %arg53) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%150) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %122 = "linalg.generic"(%arg24, %116, %arg24) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg49: f32, %arg50: f32, %arg51: f32):
        %149 = "arith.subf"(%arg49, %arg50) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%149) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %123 = "linalg.generic"(%122, %122) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg47: f32, %arg48: f32):
        %148 = "math.exp2"(%arg47) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%148) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %124 = "linalg.generic"(%arg25, %123, %arg25) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg44: f32, %arg45: f32, %arg46: f32):
        %147 = "arith.mulf"(%arg44, %arg45) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%147) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %125 = "linalg.generic"(%124, %121, %124) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg41: f32, %arg42: f32, %arg43: f32):
        %146 = "arith.addf"(%arg41, %arg42) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%146) : (f32) -> ()
      }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
      %126 = "tensor.expand_shape"(%123) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
      %127 = "linalg.generic"(%126, %15) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg39: f32, %arg40: f32):
        "linalg.yield"(%arg39) : (f32) -> ()
      }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %128 = "linalg.generic"(%arg26, %127, %arg26) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg36: f32, %arg37: f32, %arg38: f32):
        %145 = "arith.mulf"(%arg36, %arg37) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%145) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %129 = "arith.muli"(%76, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %130 = "arith.index_cast"(%129) : (i32) -> index
      %131 = "memref.reinterpret_cast"(%arg2, %52) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xbf16>, index) -> memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>
      %132 = "arith.addi"(%38, %130) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %133 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x128xbf16>
      "linalg.fill"(%3, %133) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg34: bf16, %arg35: bf16):
        "linalg.yield"(%arg34) : (bf16) -> ()
      }) : (bf16, memref<128x128xbf16>) -> ()
      %134 = "memref.subview"(%131, %132, %83) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>, index, index) -> memref<?x128xbf16, strided<[?, 1], offset: ?>>
      %135 = "memref.subview"(%133, %83) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<128x128xbf16>, index) -> memref<?x128xbf16, strided<[128, 1]>>
      "linalg.copy"(%134, %135) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg32: bf16, %arg33: bf16):
        "linalg.yield"(%arg32) : (bf16) -> ()
      }) : (memref<?x128xbf16, strided<[?, 1], offset: ?>>, memref<?x128xbf16, strided<[128, 1]>>) -> ()
      %136 = "bufferization.to_tensor"(%133) <{restrict, writable}> : (memref<128x128xbf16>) -> tensor<128x128xbf16>
      %137 = "tensor.empty"() : () -> tensor<128x128xbf16>
      %138 = "linalg.generic"(%120, %137) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg30: f32, %arg31: bf16):
        %144 = "arith.truncf"(%arg30) : (f32) -> bf16
        "linalg.yield"(%144) : (bf16) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xbf16>) -> tensor<128x128xbf16>
      %139 = "linalg.matmul"(%138, %136, %128) <{indexing_maps = [#map1, #map2, #map3], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg27: bf16, %arg28: bf16, %arg29: f32):
        %140 = "arith.extf"(%arg27) : (bf16) -> f32
        %141 = "arith.extf"(%arg28) : (bf16) -> f32
        %142 = "arith.mulf"(%140, %141) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %143 = "arith.addf"(%arg29, %142) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%143) : (f32) -> ()
      }) : (tensor<128x128xbf16>, tensor<128x128xbf16>, tensor<128x128xf32>) -> tensor<128x128xf32>
      "scf.yield"(%116, %125, %139) : (tensor<128xf32>, tensor<128xf32>, tensor<128x128xf32>) -> ()
    }) : (index, index, index, tensor<128xf32>, tensor<128xf32>, tensor<128x128xf32>) -> (tensor<128xf32>, tensor<128xf32>, tensor<128x128xf32>)
    %62 = "tensor.expand_shape"(%61#1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xf32>) -> tensor<128x1xf32>
    %63 = "linalg.generic"(%62, %15) <{indexing_maps = [#map6, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: f32, %arg22: f32):
      "linalg.yield"(%arg21) : (f32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<128x1xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    %64 = "linalg.generic"(%61#2, %63, %61#2) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg18: f32, %arg19: f32, %arg20: f32):
      %74 = "arith.divf"(%arg18, %arg19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%74) : (f32) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    %65 = "arith.muli"(%20, %arg15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %66 = "arith.index_cast"(%65) : (i32) -> index
    %67 = "arith.index_cast"(%arg14) : (i32) -> index
    %68 = "memref.reinterpret_cast"(%arg7, %67) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xbf16>, index) -> memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>
    %69 = "tensor.empty"() : () -> tensor<128x128xbf16>
    %70 = "linalg.generic"(%64, %69) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: f32, %arg17: bf16):
      %73 = "arith.truncf"(%arg16) : (f32) -> bf16
      "linalg.yield"(%73) : (bf16) -> ()
    }) : (tensor<128x128xf32>, tensor<128x128xbf16>) -> tensor<128x128xbf16>
    %71 = "tensor.extract_slice"(%70, %46) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (tensor<128x128xbf16>, index) -> tensor<?x128xbf16>
    %72 = "memref.subview"(%68, %39, %66, %46) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>, index, index, index) -> memref<?x128xbf16, strided<[?, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%71, %72) <{writable}> : (tensor<?x128xbf16>, memref<?x128xbf16, strided<[?, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

