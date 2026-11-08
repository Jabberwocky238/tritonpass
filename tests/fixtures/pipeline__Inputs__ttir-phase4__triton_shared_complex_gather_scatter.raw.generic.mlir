#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, memref<?xi32>) -> (), sym_name = "complex_gather_scatter"}> ({
  ^bb0(%arg0: memref<?xi32>, %arg1: memref<?xi32>):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 32 : index}> : () -> index
    %5 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %7 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xi32>) -> !tt.ptr<i32>
    %8 = "tensor.empty"() : () -> tensor<32xi32>
    %9 = "linalg.fill"(%0, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg52: i32, %arg53: i32):
      "linalg.yield"(%arg52) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %10 = "linalg.fill"(%5, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg50: i32, %arg51: i32):
      "linalg.yield"(%arg50) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "linalg.generic"(%8) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg49: i32):
      %61 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %62 = "arith.index_cast"(%61) : (index) -> i32
      "linalg.yield"(%62) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %12 = "scf.for"(%1, %2, %3, %11) ({
    ^bb0(%arg2: index, %arg3: tensor<32xi32>):
      %13 = "arith.index_cast"(%arg2) : (index) -> i32
      %14 = "linalg.generic"(%arg3, %10, %arg3) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg46: i32, %arg47: i32, %arg48: i32):
        %60 = "arith.divsi"(%arg46, %arg47) : (i32, i32) -> i32
        "linalg.yield"(%60) : (i32) -> ()
      }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
      %15 = "linalg.fill"(%13, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg44: i32, %arg45: i32):
        "linalg.yield"(%arg44) : (i32) -> ()
      }) : (i32, tensor<32xi32>) -> tensor<32xi32>
      %16 = "linalg.generic"(%14, %15, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg41: i32, %arg42: i32, %arg43: i32):
        %59 = "arith.addi"(%arg41, %arg42) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%59) : (i32) -> ()
      }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
      %17 = "tensor.empty"() : () -> tensor<32xi1>
      %18 = "linalg.generic"(%16, %9, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg38: i32, %arg39: i32, %arg40: i1):
        %58 = "arith.cmpi"(%arg38, %arg39) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "linalg.yield"(%58) : (i1) -> ()
      }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
      %19 = "tts.gather"(%7, %16, %18) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (!tt.ptr<i32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi32>
      "scf.for"(%1, %4, %3) ({
      ^bb0(%arg37: index):
        %54 = "tensor.extract"(%16, %arg37) : (tensor<32xi32>, index) -> i32
        %55 = "arith.index_cast"(%54) : (i32) -> index
        %56 = "tensor.extract_slice"(%19, %arg37) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<32xi32>, index) -> tensor<1xi32>
        %57 = "memref.reinterpret_cast"(%arg1, %55) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
        "bufferization.materialize_in_destination"(%56, %57) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      %20 = "linalg.generic"(%16, %9, %16) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg34: i32, %arg35: i32, %arg36: i32):
        %53 = "arith.addi"(%arg34, %arg35) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%53) : (i32) -> ()
      }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
      %21 = "scf.for"(%1, %2, %3, %20) ({
      ^bb0(%arg17: index, %arg18: tensor<32xi32>):
        %35 = "arith.index_cast"(%arg17) : (index) -> i32
        %36 = "arith.addi"(%13, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %37 = "arith.addi"(%35, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %38 = "arith.muli"(%36, %37) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %39 = "linalg.fill"(%38, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg32: i32, %arg33: i32):
          "linalg.yield"(%arg32) : (i32) -> ()
        }) : (i32, tensor<32xi32>) -> tensor<32xi32>
        %40 = "linalg.generic"(%arg18, %39, %arg18) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg29: i32, %arg30: i32, %arg31: i32):
          %52 = "arith.divsi"(%arg29, %arg30) : (i32, i32) -> i32
          "linalg.yield"(%52) : (i32) -> ()
        }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
        %41 = "linalg.generic"(%40, %15, %40) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
          %51 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%51) : (i32) -> ()
        }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
        %42 = "linalg.generic"(%41, %9, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg23: i32, %arg24: i32, %arg25: i1):
          %50 = "arith.cmpi"(%arg23, %arg24) <{predicate = 2 : i64}> : (i32, i32) -> i1
          "linalg.yield"(%50) : (i1) -> ()
        }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
        %43 = "tts.gather"(%7, %41, %42) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (!tt.ptr<i32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi32>
        "scf.for"(%1, %4, %3) ({
        ^bb0(%arg22: index):
          %46 = "tensor.extract"(%41, %arg22) : (tensor<32xi32>, index) -> i32
          %47 = "arith.index_cast"(%46) : (i32) -> index
          %48 = "tensor.extract_slice"(%43, %arg22) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<32xi32>, index) -> tensor<1xi32>
          %49 = "memref.reinterpret_cast"(%arg1, %47) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
          "bufferization.materialize_in_destination"(%48, %49) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1], offset: ?>>) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %44 = "linalg.generic"(%41, %9, %41) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg19: i32, %arg20: i32, %arg21: i32):
          %45 = "arith.addi"(%arg19, %arg20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%45) : (i32) -> ()
        }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
        "scf.yield"(%44) : (tensor<32xi32>) -> ()
      }) : (index, index, index, tensor<32xi32>) -> tensor<32xi32>
      %22 = "linalg.generic"(%21, %10, %21) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg14: i32, %arg15: i32, %arg16: i32):
        %34 = "arith.divsi"(%arg14, %arg15) : (i32, i32) -> i32
        "linalg.yield"(%34) : (i32) -> ()
      }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
      %23 = "linalg.generic"(%22, %15, %22) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg11: i32, %arg12: i32, %arg13: i32):
        %33 = "arith.addi"(%arg11, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%33) : (i32) -> ()
      }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
      %24 = "linalg.generic"(%23, %9, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg8: i32, %arg9: i32, %arg10: i1):
        %32 = "arith.cmpi"(%arg8, %arg9) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "linalg.yield"(%32) : (i1) -> ()
      }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
      %25 = "tts.gather"(%7, %23, %24) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (!tt.ptr<i32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi32>
      "scf.for"(%1, %4, %3) ({
      ^bb0(%arg7: index):
        %28 = "tensor.extract"(%23, %arg7) : (tensor<32xi32>, index) -> i32
        %29 = "arith.index_cast"(%28) : (i32) -> index
        %30 = "tensor.extract_slice"(%25, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<32xi32>, index) -> tensor<1xi32>
        %31 = "memref.reinterpret_cast"(%arg1, %29) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
        "bufferization.materialize_in_destination"(%30, %31) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      %26 = "linalg.generic"(%23, %9, %23) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg4: i32, %arg5: i32, %arg6: i32):
        %27 = "arith.addi"(%arg4, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%27) : (i32) -> ()
      }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
      "scf.yield"(%26) : (tensor<32xi32>) -> ()
    }) : (index, index, index, tensor<32xi32>) -> tensor<32xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

