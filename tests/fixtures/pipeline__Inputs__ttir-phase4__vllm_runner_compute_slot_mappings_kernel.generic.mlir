#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (i32, memref<?xi64>, memref<?xi32>, memref<?xi64>, memref<?xi64>, memref<?xi64>, memref<?xi32>, memref<?xi8>, memref<?xi8>, memref<?xi64>, i32, i32) -> (), sym_name = "_compute_slot_mappings_kernel"}> ({
  ^bb0(%arg0: i32, %arg1: memref<?xi64>, %arg2: memref<?xi32>, %arg3: memref<?xi64>, %arg4: memref<?xi64>, %arg5: memref<?xi64>, %arg6: memref<?xi32>, %arg7: memref<?xi8>, %arg8: memref<?xi8>, %arg9: memref<?xi64>, %arg10: i32, %arg11: i32):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %3 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %7 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %8 = "tensor.empty"() : () -> tensor<1024xi64>
    %9 = "linalg.fill"(%1, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg58: i64, %arg59: i64):
      "linalg.yield"(%arg58) : (i64) -> ()
    }) : (i64, tensor<1024xi64>) -> tensor<1024xi64>
    %10 = "linalg.fill"(%2, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg56: i64, %arg57: i64):
      "linalg.yield"(%arg56) : (i64) -> ()
    }) : (i64, tensor<1024xi64>) -> tensor<1024xi64>
    %11 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %12 = "arith.index_cast"(%11) : (index) -> i32
    %13 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %14 = "arith.index_cast"(%13) : (index) -> i32
    %15 = "arith.muli"(%12, %arg10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %16 = "arith.index_cast"(%15) : (i32) -> index
    %17 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
    %18 = "arith.index_cast"(%17) : (index) -> i32
    %19 = "arith.subi"(%18, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %20 = "arith.cmpi"(%14, %19) <{predicate = 0 : i64}> : (i32, i32) -> i1
    "scf.if"(%20) ({
      %87 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
      %88 = "memref.load"(%87, %13) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
      %89 = "arith.index_cast"(%88) : (i32) -> index
      %90 = "arith.index_cast"(%arg0) : (i32) -> index
      "scf.for"(%89, %90, %3) ({
      ^bb0(%arg55: index):
        %91 = "arith.addi"(%arg55, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %92 = "arith.minsi"(%91, %90) : (index, index) -> index
        %93 = "arith.maxsi"(%92, %arg55) : (index, index) -> index
        %94 = "arith.subi"(%93, %arg55) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %95 = "arith.addi"(%16, %arg55) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %96 = "tensor.extract_slice"(%9, %94) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xi64>, index) -> tensor<?xi64>
        %97 = "memref.subview"(%arg9, %95, %94) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi64>, index, index) -> memref<?xi64, strided<[1], offset: ?>>
        "bufferization.materialize_in_destination"(%96, %97) <{writable}> : (tensor<?xi64>, memref<?xi64, strided<[1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }, {
      %21 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
      %22 = "memref.load"(%21, %11) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
      %23 = "tt.int_to_ptr"(%22) {tt.divisibility = dense<16> : tensor<1xi32>} : (i64) -> !tt.ptr<i32>
      %24 = "builtin.unrealized_conversion_cast"(%23) : (!tt.ptr<i32>) -> memref<?xi32>
      %25 = "memref.reinterpret_cast"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
      %26 = "memref.load"(%25, %11) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
      %27 = "memref.reinterpret_cast"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
      %28 = "memref.load"(%27, %11) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
      %29 = "memref.reinterpret_cast"(%arg7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi8>) -> memref<1099511627776xi8, strided<[1]>>
      %30 = "memref.load"(%29, %11) <{nontemporal = false}> : (memref<1099511627776xi8, strided<[1]>>, index) -> i8
      %31 = "arith.cmpi"(%30, %6) <{predicate = 1 : i64}> : (i8, i8) -> i1
      %32 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
      %33 = "memref.load"(%32, %13) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
      %34 = "arith.cmpi"(%33, %2) <{predicate = 5 : i64}> : (i64, i64) -> i1
      %35 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
      %36 = "memref.load"(%35, %13) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
      %37 = "arith.addi"(%14, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %38 = "arith.index_cast"(%37) : (i32) -> index
      %39 = "memref.load"(%35, %38) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
      %40 = "arith.extsi"(%28) : (i32) -> i64
      %41 = "linalg.fill"(%40, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg53: i64, %arg54: i64):
        "linalg.yield"(%arg53) : (i64) -> ()
      }) : (i64, tensor<1024xi64>) -> tensor<1024xi64>
      %42 = "tensor.empty"() : () -> tensor<1024xi1>
      %43 = "linalg.fill"(%31, %42) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg51: i1, %arg52: i1):
        "linalg.yield"(%arg51) : (i1) -> ()
      }) : (i1, tensor<1024xi1>) -> tensor<1024xi1>
      %44 = "arith.muli"(%33, %26) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %45 = "tensor.empty"() : () -> tensor<1024xi32>
      %46 = "linalg.fill"(%28, %45) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg49: i32, %arg50: i32):
        "linalg.yield"(%arg49) : (i32) -> ()
      }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
      %47 = "arith.andi"(%31, %34) : (i1, i1) -> i1
      %48 = "linalg.fill"(%47, %42) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg47: i1, %arg48: i1):
        "linalg.yield"(%arg47) : (i1) -> ()
      }) : (i1, tensor<1024xi1>) -> tensor<1024xi1>
      %49 = "arith.index_cast"(%36) : (i32) -> index
      %50 = "arith.index_cast"(%39) : (i32) -> index
      "scf.for"(%49, %50, %3) ({
      ^bb0(%arg12: index):
        %51 = "arith.addi"(%arg12, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %52 = "arith.minsi"(%51, %50) : (index, index) -> index
        %53 = "arith.maxsi"(%52, %arg12) : (index, index) -> index
        %54 = "arith.subi"(%53, %arg12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %55 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xi64>
        "linalg.fill"(%2, %55) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg45: i64, %arg46: i64):
          "linalg.yield"(%arg45) : (i64) -> ()
        }) : (i64, memref<1024xi64>) -> ()
        %56 = "memref.subview"(%arg3, %arg12, %54) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi64>, index, index) -> memref<?xi64, strided<[1], offset: ?>>
        %57 = "memref.subview"(%55, %54) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xi64>, index) -> memref<?xi64, strided<[1]>>
        "linalg.copy"(%56, %57) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg43: i64, %arg44: i64):
          "linalg.yield"(%arg43) : (i64) -> ()
        }) : (memref<?xi64, strided<[1], offset: ?>>, memref<?xi64, strided<[1]>>) -> ()
        %58 = "bufferization.to_tensor"(%55) <{restrict, writable}> : (memref<1024xi64>) -> tensor<1024xi64>
        %59 = "linalg.generic"(%58, %41, %58) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg40: i64, %arg41: i64, %arg42: i64):
          %86 = "arith.divsi"(%arg40, %arg41) : (i64, i64) -> i64
          "linalg.yield"(%86) : (i64) -> ()
        }) : (tensor<1024xi64>, tensor<1024xi64>, tensor<1024xi64>) -> tensor<1024xi64>
        %60 = "linalg.generic"(%43, %59, %10, %59) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
        ^bb0(%arg36: i1, %arg37: i64, %arg38: i64, %arg39: i64):
          %85 = "arith.select"(%arg36, %arg37, %arg38) : (i1, i64, i64) -> i64
          "linalg.yield"(%85) : (i64) -> ()
        }) : (tensor<1024xi1>, tensor<1024xi64>, tensor<1024xi64>, tensor<1024xi64>) -> tensor<1024xi64>
        %61 = "linalg.generic"(%58, %41, %58) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg33: i64, %arg34: i64, %arg35: i64):
          %84 = "arith.remsi"(%arg33, %arg34) : (i64, i64) -> i64
          "linalg.yield"(%84) : (i64) -> ()
        }) : (tensor<1024xi64>, tensor<1024xi64>, tensor<1024xi64>) -> tensor<1024xi64>
        %62 = "linalg.fill"(%44, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg31: i64, %arg32: i64):
          "linalg.yield"(%arg31) : (i64) -> ()
        }) : (i64, tensor<1024xi64>) -> tensor<1024xi64>
        %63 = "linalg.generic"(%62, %60, %62) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg28: i64, %arg29: i64, %arg30: i64):
          %83 = "arith.addi"(%arg28, %arg29) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%83) : (i64) -> ()
        }) : (tensor<1024xi64>, tensor<1024xi64>, tensor<1024xi64>) -> tensor<1024xi64>
        %64 = "arith.select"(%34, %3, %4) : (i1, index, index) -> index
        %65 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xi32>
        "linalg.fill"(%5, %65) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg26: i32, %arg27: i32):
          "linalg.yield"(%arg26) : (i32) -> ()
        }) : (i32, memref<1024xi32>) -> ()
        %66 = "arith.minsi"(%64, %3) : (index, index) -> index
        "scf.for"(%4, %66, %0) ({
        ^bb0(%arg25: index):
          %79 = "tensor.extract"(%63, %arg25) : (tensor<1024xi64>, index) -> i64
          %80 = "arith.index_cast"(%79) : (i64) -> index
          %81 = "memref.reinterpret_cast"(%24, %80) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
          %82 = "memref.subview"(%65, %arg25) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<1024xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
          "memref.copy"(%81, %82) : (memref<1xi32, strided<[1], offset: ?>>, memref<1xi32, strided<[1], offset: ?>>) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %67 = "bufferization.to_tensor"(%65) <{restrict, writable}> : (memref<1024xi32>) -> tensor<1024xi32>
        %68 = "linalg.generic"(%67, %46, %67) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg22: i32, %arg23: i32, %arg24: i32):
          %78 = "arith.muli"(%arg22, %arg23) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%78) : (i32) -> ()
        }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
        %69 = "linalg.generic"(%68, %8) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg20: i32, %arg21: i64):
          %77 = "arith.extsi"(%arg20) : (i32) -> i64
          "linalg.yield"(%77) : (i64) -> ()
        }) : (tensor<1024xi32>, tensor<1024xi64>) -> tensor<1024xi64>
        %70 = "linalg.generic"(%69, %61, %69) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg17: i64, %arg18: i64, %arg19: i64):
          %76 = "arith.addi"(%arg17, %arg18) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          "linalg.yield"(%76) : (i64) -> ()
        }) : (tensor<1024xi64>, tensor<1024xi64>, tensor<1024xi64>) -> tensor<1024xi64>
        %71 = "linalg.generic"(%48, %70, %9, %70) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
        ^bb0(%arg13: i1, %arg14: i64, %arg15: i64, %arg16: i64):
          %75 = "arith.select"(%arg13, %arg14, %arg15) : (i1, i64, i64) -> i64
          "linalg.yield"(%75) : (i64) -> ()
        }) : (tensor<1024xi1>, tensor<1024xi64>, tensor<1024xi64>, tensor<1024xi64>) -> tensor<1024xi64>
        %72 = "arith.addi"(%16, %arg12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %73 = "tensor.extract_slice"(%71, %54) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xi64>, index) -> tensor<?xi64>
        %74 = "memref.subview"(%arg9, %72, %54) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi64>, index, index) -> memref<?xi64, strided<[1], offset: ?>>
        "bufferization.materialize_in_destination"(%73, %74) <{writable}> : (tensor<?xi64>, memref<?xi64, strided<[1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

