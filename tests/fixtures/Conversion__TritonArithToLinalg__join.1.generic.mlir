#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1) -> (d0, 0)>
#map3 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}], function_type = (!tt.ptr<i32>, !tt.ptr<i32>, !tt.ptr<i32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: !tt.ptr<i32>, %arg2: !tt.ptr<i32>):
    %0 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "tensor.empty"() : () -> tensor<128x1xi32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: i32, %arg31: i32):
      "linalg.yield"(%arg30) : (i32) -> ()
    }) : (i32, tensor<128x1xi32>) -> tensor<128x1xi32>
    %3 = "tensor.empty"() : () -> tensor<128xi32>
    %4 = "linalg.generic"(%3) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg29: i32):
      %36 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %37 = "arith.index_cast"(%36) : (index) -> i32
      "linalg.yield"(%37) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %5 = "tensor.empty"() : () -> tensor<128x!tt.ptr<i32>>
    %6 = "linalg.fill"(%arg0, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg27: !tt.ptr<i32>, %arg28: !tt.ptr<i32>):
      "linalg.yield"(%arg27) : (!tt.ptr<i32>) -> ()
    }) : (!tt.ptr<i32>, tensor<128x!tt.ptr<i32>>) -> tensor<128x!tt.ptr<i32>>
    %7 = "linalg.generic"(%6, %4, %6) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg24: !tt.ptr<i32>, %arg25: i32, %arg26: !tt.ptr<i32>):
      %35 = "tt.addptr"(%arg24, %arg25) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      "linalg.yield"(%35) : (!tt.ptr<i32>) -> ()
    }) : (tensor<128x!tt.ptr<i32>>, tensor<128xi32>, tensor<128x!tt.ptr<i32>>) -> tensor<128x!tt.ptr<i32>>
    %8 = "tt.load"(%7) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<128x!tt.ptr<i32>>) -> tensor<128xi32>
    %9 = "tensor.empty"() : () -> tensor<128x!tt.ptr<i32>>
    %10 = "linalg.fill"(%arg1, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg22: !tt.ptr<i32>, %arg23: !tt.ptr<i32>):
      "linalg.yield"(%arg22) : (!tt.ptr<i32>) -> ()
    }) : (!tt.ptr<i32>, tensor<128x!tt.ptr<i32>>) -> tensor<128x!tt.ptr<i32>>
    %11 = "linalg.generic"(%10, %4, %10) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg19: !tt.ptr<i32>, %arg20: i32, %arg21: !tt.ptr<i32>):
      %34 = "tt.addptr"(%arg19, %arg20) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      "linalg.yield"(%34) : (!tt.ptr<i32>) -> ()
    }) : (tensor<128x!tt.ptr<i32>>, tensor<128xi32>, tensor<128x!tt.ptr<i32>>) -> tensor<128x!tt.ptr<i32>>
    %12 = "tt.load"(%11) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<128x!tt.ptr<i32>>) -> tensor<128xi32>
    %13 = "tensor.empty"() : () -> tensor<128x2xi32>
    %14 = "tensor.insert_slice"(%8, %13) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 128, 1>, static_strides = array<i64: 1, 1>}> : (tensor<128xi32>, tensor<128x2xi32>) -> tensor<128x2xi32>
    %15 = "tensor.insert_slice"(%12, %14) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 1>, static_sizes = array<i64: 128, 1>, static_strides = array<i64: 1, 1>}> : (tensor<128xi32>, tensor<128x2xi32>) -> tensor<128x2xi32>
    %16 = "tensor.expand_shape"(%4) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 1>}> : (tensor<128xi32>) -> tensor<128x1xi32>
    %17 = "linalg.generic"(%16, %2, %16) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: i32, %arg17: i32, %arg18: i32):
      %33 = "arith.muli"(%arg16, %arg17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%33) : (i32) -> ()
    }) : (tensor<128x1xi32>, tensor<128x1xi32>, tensor<128x1xi32>) -> tensor<128x1xi32>
    %18 = "tensor.empty"() : () -> tensor<128x1x!tt.ptr<i32>>
    %19 = "linalg.fill"(%arg2, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: !tt.ptr<i32>, %arg15: !tt.ptr<i32>):
      "linalg.yield"(%arg14) : (!tt.ptr<i32>) -> ()
    }) : (!tt.ptr<i32>, tensor<128x1x!tt.ptr<i32>>) -> tensor<128x1x!tt.ptr<i32>>
    %20 = "linalg.generic"(%19, %17, %19) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg11: !tt.ptr<i32>, %arg12: i32, %arg13: !tt.ptr<i32>):
      %32 = "tt.addptr"(%arg11, %arg12) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      "linalg.yield"(%32) : (!tt.ptr<i32>) -> ()
    }) : (tensor<128x1x!tt.ptr<i32>>, tensor<128x1xi32>, tensor<128x1x!tt.ptr<i32>>) -> tensor<128x1x!tt.ptr<i32>>
    %21 = "tensor.empty"() : () -> tensor<2xi32>
    %22 = "linalg.generic"(%21) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg10: i32):
      %30 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %31 = "arith.index_cast"(%30) : (index) -> i32
      "linalg.yield"(%31) : (i32) -> ()
    }) : (tensor<2xi32>) -> tensor<2xi32>
    %23 = "tensor.expand_shape"(%22) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 2>}> : (tensor<2xi32>) -> tensor<1x2xi32>
    %24 = "tensor.empty"() : () -> tensor<128x2x!tt.ptr<i32>>
    %25 = "linalg.generic"(%20, %24) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: !tt.ptr<i32>, %arg9: !tt.ptr<i32>):
      "linalg.yield"(%arg8) : (!tt.ptr<i32>) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<128x1x!tt.ptr<i32>>, tensor<128x2x!tt.ptr<i32>>) -> tensor<128x2x!tt.ptr<i32>>
    %26 = "tensor.empty"() : () -> tensor<128x2xi32>
    %27 = "linalg.generic"(%23, %26) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: i32, %arg7: i32):
      "linalg.yield"(%arg6) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x2xi32>, tensor<128x2xi32>) -> tensor<128x2xi32>
    %28 = "linalg.generic"(%25, %27, %25) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<i32>, %arg4: i32, %arg5: !tt.ptr<i32>):
      %29 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      "linalg.yield"(%29) : (!tt.ptr<i32>) -> ()
    }) : (tensor<128x2x!tt.ptr<i32>>, tensor<128x2xi32>, tensor<128x2x!tt.ptr<i32>>) -> tensor<128x2x!tt.ptr<i32>>
    "tt.store"(%28, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<128x2x!tt.ptr<i32>>, tensor<128x2xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

