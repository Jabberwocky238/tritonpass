#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xf32>, memref<?xf32>, memref<?xf32>, memref<?xi32>, i32, f32, i64, i64, i64, memref<?xi32>) -> (), sym_name = "reduce_segments"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: memref<?xf32>, %arg4: memref<?xi32>, %arg5: i32, %arg6: f32, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: memref<?xi32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 255 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.constant"() <{value = 16 : index}> : () -> index
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    %8 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %9 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %10 = "arith.constant"() <{value = 2048 : i32}> : () -> i32
    %11 = "arith.constant"() <{value = 65536 : i64}> : () -> i64
    %12 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %13 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %14 = "tensor.empty"() : () -> tensor<128xf32>
    %15 = "linalg.fill"(%0, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg64: f32, %arg65: f32):
      "linalg.yield"(%arg64) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %16 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %17 = "arith.index_cast"(%16) : (index) -> i32
    %18 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %19 = "arith.index_cast"(%18) : (index) -> i32
    %20 = "arith.subi"(%arg5, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %21:2 = "scf.for"(%5, %6, %7, %9, %arg5) ({
    ^bb0(%arg61: index, %arg62: i32, %arg63: i32):
      %100 = "arith.cmpi"(%arg62, %arg63) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %101 = "arith.addi"(%arg62, %arg63) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %102 = "arith.divsi"(%101, %3) : (i32, i32) -> i32
      %103 = "arith.minsi"(%102, %20) : (i32, i32) -> i32
      %104 = "arith.maxsi"(%103, %9) : (i32, i32) -> i32
      %105 = "arith.index_cast"(%104) : (i32) -> index
      %106 = "memref.reinterpret_cast"(%arg10) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
      %107 = "memref.load"(%106, %105) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
      %108 = "arith.cmpi"(%107, %17) <{predicate = 3 : i64}> : (i32, i32) -> i1
      %109 = "arith.select"(%108, %arg63, %104) : (i1, i32, i32) -> i32
      %110 = "arith.addi"(%104, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %111 = "arith.select"(%108, %110, %arg62) : (i1, i32, i32) -> i32
      %112 = "arith.select"(%100, %111, %arg62) : (i1, i32, i32) -> i32
      %113 = "arith.select"(%100, %109, %arg63) : (i1, i32, i32) -> i32
      "scf.yield"(%112, %113) : (i32, i32) -> ()
    }) : (index, index, index, i32, i32) -> (i32, i32)
    %22 = "arith.subi"(%21#0, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %23 = "arith.index_cast"(%22) : (i32) -> index
    %24 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %25 = "memref.load"(%24, %23) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %26 = "arith.addi"(%25, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %27 = "arith.divsi"(%26, %1) : (i32, i32) -> i32
    %28 = "arith.muli"(%27, %13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %29 = "arith.addi"(%25, %28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %30 = "arith.subi"(%29, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %31 = "arith.divsi"(%30, %28) : (i32, i32) -> i32
    %32 = "arith.extsi"(%17) : (i32) -> i64
    %33 = "arith.muli"(%32, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %34 = "arith.muli"(%19, %13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %35 = "arith.extsi"(%34) : (i32) -> i64
    %36 = "arith.addi"(%33, %35) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %37 = "arith.index_cast"(%36) : (i64) -> index
    %38 = "arith.index_cast"(%31) : (i32) -> index
    %39 = "arith.minsi"(%38, %6) : (index, index) -> index
    %40 = "arith.maxsi"(%39, %5) : (index, index) -> index
    %41 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
    "linalg.fill"(%8, %41) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg59: f32, %arg60: f32):
      "linalg.yield"(%arg59) : (f32) -> ()
    }) : (f32, memref<16xf32>) -> ()
    %42 = "memref.subview"(%arg2, %37, %40) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %43 = "memref.subview"(%41, %40) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<16xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%42, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg57: f32, %arg58: f32):
      "linalg.yield"(%arg57) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %44 = "bufferization.to_tensor"(%41) <{restrict, writable}> : (memref<16xf32>) -> tensor<16xf32>
    %45 = "tensor.empty"() : () -> tensor<f32>
    %46 = "linalg.fill"(%8, %45) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg55: f32, %arg56: f32):
      "linalg.yield"(%arg55) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %47 = "linalg.reduce"(%44, %46) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg53: f32, %arg54: f32):
      %99 = "arith.maxnumf"(%arg53, %arg54) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%99) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<f32>) -> tensor<f32>
    %48 = "tensor.extract"(%47) : (tensor<f32>) -> f32
    %49 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
    "linalg.fill"(%0, %49) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg51: f32, %arg52: f32):
      "linalg.yield"(%arg51) : (f32) -> ()
    }) : (f32, memref<16xf32>) -> ()
    %50 = "memref.subview"(%arg3, %37, %40) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %51 = "memref.subview"(%49, %40) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<16xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%50, %51) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg49: f32, %arg50: f32):
      "linalg.yield"(%arg49) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %52 = "bufferization.to_tensor"(%49) <{restrict, writable}> : (memref<16xf32>) -> tensor<16xf32>
    %53 = "tensor.empty"() : () -> tensor<16xf32>
    %54 = "linalg.fill"(%48, %53) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg47: f32, %arg48: f32):
      "linalg.yield"(%arg47) : (f32) -> ()
    }) : (f32, tensor<16xf32>) -> tensor<16xf32>
    %55 = "linalg.generic"(%44, %54, %44) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg44: f32, %arg45: f32, %arg46: f32):
      %98 = "arith.subf"(%arg44, %arg45) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%98) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %56 = "linalg.generic"(%55, %55) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg42: f32, %arg43: f32):
      %97 = "math.exp"(%arg42) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%97) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %57 = "linalg.generic"(%52, %56, %52) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg39: f32, %arg40: f32, %arg41: f32):
      %96 = "arith.mulf"(%arg39, %arg40) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%96) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %58 = "linalg.fill"(%0, %45) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg37: f32, %arg38: f32):
      "linalg.yield"(%arg37) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %59 = "linalg.reduce"(%57, %58) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg35: f32, %arg36: f32):
      %95 = "arith.addf"(%arg35, %arg36) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%95) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<f32>) -> tensor<f32>
    %60 = "tensor.extract"(%59) : (tensor<f32>) -> f32
    %61 = "arith.muli"(%32, %11) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %62 = "arith.muli"(%19, %10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %63 = "arith.extsi"(%62) : (i32) -> i64
    %64 = "arith.addi"(%61, %63) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %65 = "arith.index_cast"(%64) : (i64) -> index
    %66 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 128, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[128, 1]>>
    %67 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x128xf32>
    "linalg.fill"(%0, %67) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg33: f32, %arg34: f32):
      "linalg.yield"(%arg33) : (f32) -> ()
    }) : (f32, memref<16x128xf32>) -> ()
    %68 = "memref.subview"(%66, %65, %40) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[128, 1]>>, index, index) -> memref<?x128xf32, strided<[128, 1], offset: ?>>
    %69 = "memref.subview"(%67, %40) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 128>, static_strides = array<i64: 1, 1>}> : (memref<16x128xf32>, index) -> memref<?x128xf32, strided<[128, 1]>>
    "linalg.copy"(%68, %69) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg31: f32, %arg32: f32):
      "linalg.yield"(%arg31) : (f32) -> ()
    }) : (memref<?x128xf32, strided<[128, 1], offset: ?>>, memref<?x128xf32, strided<[128, 1]>>) -> ()
    %70 = "bufferization.to_tensor"(%67) <{restrict, writable}> : (memref<16x128xf32>) -> tensor<16x128xf32>
    %71 = "tensor.expand_shape"(%56) <{reassociation = [[0, 1]], static_output_shape = array<i64: 16, 1>}> : (tensor<16xf32>) -> tensor<16x1xf32>
    %72 = "tensor.empty"() : () -> tensor<16x128xf32>
    %73 = "linalg.generic"(%71, %72) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: f32, %arg30: f32):
      "linalg.yield"(%arg29) : (f32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<16x1xf32>, tensor<16x128xf32>) -> tensor<16x128xf32>
    %74 = "linalg.generic"(%70, %73, %70) <{indexing_maps = [#map2, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: f32, %arg27: f32, %arg28: f32):
      %94 = "arith.mulf"(%arg26, %arg27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%94) : (f32) -> ()
    }) : (tensor<16x128xf32>, tensor<16x128xf32>, tensor<16x128xf32>) -> tensor<16x128xf32>
    %75 = "linalg.reduce"(%74, %15) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg24: f32, %arg25: f32):
      %93 = "arith.addf"(%arg24, %arg25) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%93) : (f32) -> ()
    }) : (tensor<16x128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %76 = "arith.cmpf"(%60, %0) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %77 = "linalg.fill"(%60, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg22: f32, %arg23: f32):
      "linalg.yield"(%arg22) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %78 = "linalg.generic"(%75, %77, %75) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32, %arg21: f32):
      %92 = "arith.divf"(%arg19, %arg20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%92) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %79 = "tensor.empty"() : () -> tensor<128xi1>
    %80 = "linalg.fill"(%76, %79) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: i1, %arg18: i1):
      "linalg.yield"(%arg17) : (i1) -> ()
    }) : (i1, tensor<128xi1>) -> tensor<128xi1>
    %81 = "linalg.generic"(%80, %15, %78, %15) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg13: i1, %arg14: f32, %arg15: f32, %arg16: f32):
      %91 = "arith.select"(%arg13, %arg14, %arg15) : (i1, f32, f32) -> f32
      "linalg.yield"(%91) : (f32) -> ()
    }) : (tensor<128xi1>, tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %82 = "arith.muli"(%32, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %83 = "arith.extsi"(%19) : (i32) -> i64
    %84 = "arith.muli"(%83, %arg8) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %85 = "arith.addi"(%82, %84) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %86 = "arith.index_cast"(%85) : (i64) -> index
    %87 = "tensor.empty"() : () -> tensor<128xbf16>
    %88 = "linalg.generic"(%81, %87) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: bf16):
      %90 = "arith.truncf"(%arg11) : (f32) -> bf16
      "linalg.yield"(%90) : (bf16) -> ()
    }) : (tensor<128xf32>, tensor<128xbf16>) -> tensor<128xbf16>
    %89 = "memref.subview"(%arg0, %86) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index) -> memref<128xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%88, %89) <{writable}> : (tensor<128xbf16>, memref<128xbf16, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

