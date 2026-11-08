#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<i32>, !tt.ptr<i32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "tensor_ptr"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: !tt.ptr<i32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "tensor.empty"() : () -> tensor<16xi32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg45: i32, %arg46: i32):
      "linalg.yield"(%arg45) : (i32) -> ()
    }) : (i32, tensor<16xi32>) -> tensor<16xi32>
    %3 = "tensor.empty"() : () -> tensor<16xi32>
    %4 = "linalg.generic"(%3) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg44: i32):
      %44 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %45 = "arith.index_cast"(%44) : (index) -> i32
      "linalg.yield"(%45) : (i32) -> ()
    }) : (tensor<16xi32>) -> tensor<16xi32>
    %5 = "tensor.empty"() : () -> tensor<16x!tt.ptr<i32>>
    %6 = "linalg.fill"(%arg0, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg42: !tt.ptr<i32>, %arg43: !tt.ptr<i32>):
      "linalg.yield"(%arg42) : (!tt.ptr<i32>) -> ()
    }) : (!tt.ptr<i32>, tensor<16x!tt.ptr<i32>>) -> tensor<16x!tt.ptr<i32>>
    %7 = "linalg.generic"(%6, %4, %6) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg39: !tt.ptr<i32>, %arg40: i32, %arg41: !tt.ptr<i32>):
      %43 = "tt.addptr"(%arg39, %arg40) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      "linalg.yield"(%43) : (!tt.ptr<i32>) -> ()
    }) : (tensor<16x!tt.ptr<i32>>, tensor<16xi32>, tensor<16x!tt.ptr<i32>>) -> tensor<16x!tt.ptr<i32>>
    %8 = "tensor.empty"() : () -> tensor<16xi32>
    %9 = "linalg.generic"(%7, %8) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg37: !tt.ptr<i32>, %arg38: i32):
      %42 = "tt.load"(%arg37) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
      "linalg.yield"(%42) : (i32) -> ()
    }) : (tensor<16x!tt.ptr<i32>>, tensor<16xi32>) -> tensor<16xi32>
    %10 = "tensor.empty"() : () -> tensor<16xi64>
    %11 = "linalg.generic"(%9, %10) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg35: i32, %arg36: i64):
      %41 = "arith.extsi"(%arg35) : (i32) -> i64
      "linalg.yield"(%41) : (i64) -> ()
    }) : (tensor<16xi32>, tensor<16xi64>) -> tensor<16xi64>
    %12 = "tensor.empty"() : () -> tensor<16x!tt.ptr<i32>>
    %13 = "linalg.generic"(%11, %12) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg33: i64, %arg34: !tt.ptr<i32>):
      %40 = "tt.int_to_ptr"(%arg33) : (i64) -> !tt.ptr<i32>
      "linalg.yield"(%40) : (!tt.ptr<i32>) -> ()
    }) : (tensor<16xi64>, tensor<16x!tt.ptr<i32>>) -> tensor<16x!tt.ptr<i32>>
    %14 = "tensor.empty"() : () -> tensor<16xi32>
    %15 = "linalg.generic"(%13, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg31: !tt.ptr<i32>, %arg32: i32):
      %39 = "tt.load"(%arg31) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
      "linalg.yield"(%39) : (i32) -> ()
    }) : (tensor<16x!tt.ptr<i32>>, tensor<16xi32>) -> tensor<16xi32>
    %16 = "tensor.empty"() : () -> tensor<16x!tt.ptr<i32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: !tt.ptr<i32>, %arg30: !tt.ptr<i32>):
      "linalg.yield"(%arg29) : (!tt.ptr<i32>) -> ()
    }) : (!tt.ptr<i32>, tensor<16x!tt.ptr<i32>>) -> tensor<16x!tt.ptr<i32>>
    %18 = "linalg.generic"(%17, %4, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: !tt.ptr<i32>, %arg27: i32, %arg28: !tt.ptr<i32>):
      %38 = "tt.addptr"(%arg26, %arg27) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      "linalg.yield"(%38) : (!tt.ptr<i32>) -> ()
    }) : (tensor<16x!tt.ptr<i32>>, tensor<16xi32>, tensor<16x!tt.ptr<i32>>) -> tensor<16x!tt.ptr<i32>>
    %19 = "tensor.empty"() : () -> tensor<16xi64>
    %20 = "linalg.generic"(%18, %19) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: !tt.ptr<i32>, %arg25: i64):
      %37 = "tt.ptr_to_int"(%arg24) : (!tt.ptr<i32>) -> i64
      "linalg.yield"(%37) : (i64) -> ()
    }) : (tensor<16x!tt.ptr<i32>>, tensor<16xi64>) -> tensor<16xi64>
    %21 = "tensor.empty"() : () -> tensor<16xi64>
    %22 = "linalg.generic"(%15, %21) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg22: i32, %arg23: i64):
      %36 = "arith.extsi"(%arg22) : (i32) -> i64
      "linalg.yield"(%36) : (i64) -> ()
    }) : (tensor<16xi32>, tensor<16xi64>) -> tensor<16xi64>
    %23 = "linalg.generic"(%20, %22, %20) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg19: i64, %arg20: i64, %arg21: i64):
      %35 = "arith.addi"(%arg19, %arg20) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "linalg.yield"(%35) : (i64) -> ()
    }) : (tensor<16xi64>, tensor<16xi64>, tensor<16xi64>) -> tensor<16xi64>
    %24 = "tensor.empty"() : () -> tensor<16x!tt.ptr<i64>>
    %25 = "linalg.generic"(%18, %24) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: !tt.ptr<i32>, %arg18: !tt.ptr<i64>):
      %34 = "tt.bitcast"(%arg17) : (!tt.ptr<i32>) -> !tt.ptr<i64>
      "linalg.yield"(%34) : (!tt.ptr<i64>) -> ()
    }) : (tensor<16x!tt.ptr<i32>>, tensor<16x!tt.ptr<i64>>) -> tensor<16x!tt.ptr<i64>>
    %26 = "linalg.generic"(%25, %2, %25) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg14: !tt.ptr<i64>, %arg15: i32, %arg16: !tt.ptr<i64>):
      %33 = "tt.addptr"(%arg14, %arg15) : (!tt.ptr<i64>, i32) -> !tt.ptr<i64>
      "linalg.yield"(%33) : (!tt.ptr<i64>) -> ()
    }) : (tensor<16x!tt.ptr<i64>>, tensor<16xi32>, tensor<16x!tt.ptr<i64>>) -> tensor<16x!tt.ptr<i64>>
    %27 = "tensor.empty"() : () -> tensor<16x!tt.ptr<i32>>
    %28 = "linalg.generic"(%26, %27) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<i64>, %arg13: !tt.ptr<i32>):
      %32 = "tt.bitcast"(%arg12) : (!tt.ptr<i64>) -> !tt.ptr<i32>
      "linalg.yield"(%32) : (!tt.ptr<i32>) -> ()
    }) : (tensor<16x!tt.ptr<i64>>, tensor<16x!tt.ptr<i32>>) -> tensor<16x!tt.ptr<i32>>
    %29 = "tensor.empty"() : () -> tensor<16xi32>
    %30 = "linalg.generic"(%23, %29) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: i64, %arg11: i32):
      %31 = "arith.trunci"(%arg10) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      "linalg.yield"(%31) : (i32) -> ()
    }) : (tensor<16xi64>, tensor<16xi32>) -> tensor<16xi32>
    "linalg.generic"(%28, %30) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 0>}> ({
    ^bb0(%arg8: !tt.ptr<i32>, %arg9: i32):
      "tt.store"(%arg8, %arg9) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
      "linalg.yield"() : () -> ()
    }) : (tensor<16x!tt.ptr<i32>>, tensor<16xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

