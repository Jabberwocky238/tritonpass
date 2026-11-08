#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32) -> (), sym_name = "softmax_kernel_inner"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 4096 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 4095 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 4096 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %6 = "tensor.empty"() : () -> tensor<4096xf32>
    %7 = "linalg.fill"(%0, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg112: f32, %arg113: f32):
      "linalg.yield"(%arg112) : (f32) -> ()
    }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
    %8 = "linalg.fill"(%5, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg110: f32, %arg111: f32):
      "linalg.yield"(%arg110) : (f32) -> ()
    }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
    %9 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %10 = "arith.index_cast"(%9) : (index) -> i32
    %11 = "arith.extsi"(%10) : (i32) -> i64
    %12 = "arith.extsi"(%arg2) : (i32) -> i64
    %13 = "arith.muli"(%11, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %14 = "arith.index_cast"(%13) : (i64) -> index
    %15 = "arith.addi"(%arg2, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %16 = "arith.divsi"(%15, %1) : (i32, i32) -> i32
    %17 = "arith.muli"(%16, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %18 = "arith.subi"(%17, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %19 = "arith.index_cast"(%18) : (i32) -> index
    %20:2 = "scf.for"(%3, %19, %4, %8, %7) ({
    ^bb0(%arg79: index, %arg80: tensor<4096xf32>, %arg81: tensor<4096xf32>):
      %99 = "arith.addi"(%14, %arg79) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %100 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
      %101 = "memref.subview"(%arg1, %99) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4096>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<4096xf32, strided<[1], offset: ?>>
      "linalg.copy"(%101, %100) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg108: f32, %arg109: f32):
        "linalg.yield"(%arg108) : (f32) -> ()
      }) : (memref<4096xf32, strided<[1], offset: ?>>, memref<4096xf32>) -> ()
      %102 = "bufferization.to_tensor"(%100) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
      %103 = "linalg.generic"(%arg80, %102, %arg80) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg105: f32, %arg106: f32, %arg107: f32):
        %121 = "arith.maxnumf"(%arg105, %arg106) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%121) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %104 = "tensor.empty"() : () -> tensor<4096xi1>
      %105 = "linalg.generic"(%103, %8, %104) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg102: f32, %arg103: f32, %arg104: i1):
        %120 = "arith.cmpf"(%arg102, %arg103) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%120) : (i1) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xi1>) -> tensor<4096xi1>
      %106 = "linalg.generic"(%arg80, %103, %arg80) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg99: f32, %arg100: f32, %arg101: f32):
        %119 = "arith.subf"(%arg99, %arg100) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%119) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %107 = "linalg.generic"(%106, %106) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg97: f32, %arg98: f32):
        %118 = "math.exp"(%arg97) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%118) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %108 = "linalg.generic"(%arg81, %107, %arg81) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg94: f32, %arg95: f32, %arg96: f32):
        %117 = "arith.mulf"(%arg94, %arg95) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%117) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %109 = "linalg.generic"(%102, %103, %102) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg91: f32, %arg92: f32, %arg93: f32):
        %116 = "arith.subf"(%arg91, %arg92) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%116) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %110 = "linalg.generic"(%109, %109) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg89: f32, %arg90: f32):
        %115 = "math.exp"(%arg89) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%115) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %111 = "linalg.generic"(%108, %110, %108) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg86: f32, %arg87: f32, %arg88: f32):
        %114 = "arith.addf"(%arg86, %arg87) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%114) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %112 = "linalg.generic"(%105, %arg81, %111, %arg81) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg82: i1, %arg83: f32, %arg84: f32, %arg85: f32):
        %113 = "arith.select"(%arg82, %arg83, %arg84) : (i1, f32, f32) -> f32
        "linalg.yield"(%113) : (f32) -> ()
      }) : (tensor<4096xi1>, tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      "scf.yield"(%103, %112) : (tensor<4096xf32>, tensor<4096xf32>) -> ()
    }) : (index, index, index, tensor<4096xf32>, tensor<4096xf32>) -> (tensor<4096xf32>, tensor<4096xf32>)
    %21 = "arith.index_cast"(%arg2) : (i32) -> index
    %22:2 = "scf.for"(%19, %21, %4, %20#0, %20#1) ({
    ^bb0(%arg46: index, %arg47: tensor<4096xf32>, %arg48: tensor<4096xf32>):
      %71 = "arith.addi"(%arg46, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %72 = "arith.minsi"(%71, %21) : (index, index) -> index
      %73 = "arith.maxsi"(%72, %arg46) : (index, index) -> index
      %74 = "arith.subi"(%73, %arg46) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %75 = "arith.addi"(%14, %arg46) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %76 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
      "linalg.fill"(%5, %76) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg77: f32, %arg78: f32):
        "linalg.yield"(%arg77) : (f32) -> ()
      }) : (f32, memref<4096xf32>) -> ()
      %77 = "memref.subview"(%arg1, %75, %74) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %78 = "memref.subview"(%76, %74) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%77, %78) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg75: f32, %arg76: f32):
        "linalg.yield"(%arg75) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %79 = "bufferization.to_tensor"(%76) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
      %80 = "linalg.generic"(%arg47, %79, %arg47) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg72: f32, %arg73: f32, %arg74: f32):
        %98 = "arith.maxnumf"(%arg72, %arg73) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%98) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %81 = "tensor.empty"() : () -> tensor<4096xi1>
      %82 = "linalg.generic"(%80, %8, %81) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg69: f32, %arg70: f32, %arg71: i1):
        %97 = "arith.cmpf"(%arg69, %arg70) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%97) : (i1) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xi1>) -> tensor<4096xi1>
      %83 = "linalg.generic"(%arg47, %80, %arg47) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg66: f32, %arg67: f32, %arg68: f32):
        %96 = "arith.subf"(%arg66, %arg67) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%96) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %84 = "linalg.generic"(%83, %83) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg64: f32, %arg65: f32):
        %95 = "math.exp"(%arg64) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%95) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %85 = "linalg.generic"(%arg48, %84, %arg48) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg61: f32, %arg62: f32, %arg63: f32):
        %94 = "arith.mulf"(%arg61, %arg62) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%94) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %86 = "linalg.generic"(%79, %80, %79) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg58: f32, %arg59: f32, %arg60: f32):
        %93 = "arith.subf"(%arg58, %arg59) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%93) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %87 = "linalg.generic"(%86, %86) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg56: f32, %arg57: f32):
        %92 = "math.exp"(%arg56) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%92) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %88 = "linalg.generic"(%85, %87, %85) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg53: f32, %arg54: f32, %arg55: f32):
        %91 = "arith.addf"(%arg53, %arg54) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%91) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %89 = "linalg.generic"(%82, %arg48, %88, %arg48) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg49: i1, %arg50: f32, %arg51: f32, %arg52: f32):
        %90 = "arith.select"(%arg49, %arg50, %arg51) : (i1, f32, f32) -> f32
        "linalg.yield"(%90) : (f32) -> ()
      }) : (tensor<4096xi1>, tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      "scf.yield"(%80, %89) : (tensor<4096xf32>, tensor<4096xf32>) -> ()
    }) : (index, index, index, tensor<4096xf32>, tensor<4096xf32>) -> (tensor<4096xf32>, tensor<4096xf32>)
    %23 = "tensor.empty"() : () -> tensor<f32>
    %24 = "linalg.fill"(%5, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg44: f32, %arg45: f32):
      "linalg.yield"(%arg44) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %25 = "linalg.reduce"(%22#0, %24) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg42: f32, %arg43: f32):
      %70 = "arith.maxnumf"(%arg42, %arg43) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%70) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<f32>) -> tensor<f32>
    %26 = "tensor.extract"(%25) : (tensor<f32>) -> f32
    %27 = "linalg.fill"(%26, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg40: f32, %arg41: f32):
      "linalg.yield"(%arg40) : (f32) -> ()
    }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
    %28 = "linalg.generic"(%22#0, %27, %22#0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg37: f32, %arg38: f32, %arg39: f32):
      %69 = "arith.subf"(%arg37, %arg38) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%69) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
    %29 = "linalg.generic"(%28, %28) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg35: f32, %arg36: f32):
      %68 = "math.exp"(%arg35) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%68) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
    %30 = "linalg.generic"(%22#1, %29, %22#1) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg32: f32, %arg33: f32, %arg34: f32):
      %67 = "arith.mulf"(%arg32, %arg33) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%67) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
    %31 = "linalg.fill"(%0, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: f32, %arg31: f32):
      "linalg.yield"(%arg30) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %32 = "linalg.reduce"(%30, %31) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg28: f32, %arg29: f32):
      %66 = "arith.addf"(%arg28, %arg29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%66) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<f32>) -> tensor<f32>
    %33 = "tensor.extract"(%32) : (tensor<f32>) -> f32
    %34 = "arith.addi"(%19, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %35 = "arith.minsi"(%34, %21) : (index, index) -> index
    %36 = "arith.maxsi"(%35, %19) : (index, index) -> index
    %37 = "arith.subi"(%36, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %38 = "arith.addi"(%14, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %39 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
    "linalg.fill"(%5, %39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg26: f32, %arg27: f32):
      "linalg.yield"(%arg26) : (f32) -> ()
    }) : (f32, memref<4096xf32>) -> ()
    %40 = "memref.subview"(%arg1, %38, %37) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %41 = "memref.subview"(%39, %37) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%40, %41) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: f32, %arg25: f32):
      "linalg.yield"(%arg24) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %42 = "bufferization.to_tensor"(%39) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
    %43 = "linalg.generic"(%42, %27, %42) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: f32, %arg22: f32, %arg23: f32):
      %65 = "arith.subf"(%arg21, %arg22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%65) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
    %44 = "linalg.generic"(%43, %43) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32):
      %64 = "math.exp"(%arg19) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%64) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
    %45 = "linalg.fill"(%33, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: f32, %arg18: f32):
      "linalg.yield"(%arg17) : (f32) -> ()
    }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
    %46 = "linalg.generic"(%44, %45, %44) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32, %arg16: f32):
      %63 = "arith.divf"(%arg14, %arg15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%63) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
    %47 = "tensor.extract_slice"(%46, %37) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<4096xf32>, index) -> tensor<?xf32>
    %48 = "memref.subview"(%arg0, %38, %37) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%47, %48) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "scf.for"(%4, %21, %4) ({
    ^bb0(%arg3: index):
      %49 = "arith.index_cast"(%arg3) : (index) -> i32
      %50 = "arith.subi"(%18, %49) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %51 = "arith.index_cast"(%50) : (i32) -> index
      %52 = "arith.addi"(%14, %51) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %53 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
      %54 = "memref.subview"(%arg1, %52) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4096>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<4096xf32, strided<[1], offset: ?>>
      "linalg.copy"(%54, %53) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg12: f32, %arg13: f32):
        "linalg.yield"(%arg12) : (f32) -> ()
      }) : (memref<4096xf32, strided<[1], offset: ?>>, memref<4096xf32>) -> ()
      %55 = "bufferization.to_tensor"(%53) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
      %56 = "linalg.generic"(%55, %27, %55) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg9: f32, %arg10: f32, %arg11: f32):
        %62 = "arith.subf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%62) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %57 = "linalg.generic"(%56, %56) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg7: f32, %arg8: f32):
        %61 = "math.exp"(%arg7) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%61) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %58 = "linalg.generic"(%57, %45, %57) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg4: f32, %arg5: f32, %arg6: f32):
        %60 = "arith.divf"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%60) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %59 = "memref.subview"(%arg0, %52) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4096>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<4096xf32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%58, %59) <{writable}> : (tensor<4096xf32>, memref<4096xf32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

