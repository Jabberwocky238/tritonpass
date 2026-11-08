#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {}, {}, {}, {}, {}, {}], function_type = (!tt.ptr<i32>, !tt.ptr<i32>, !tt.ptr<i32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: !tt.ptr<i32>, %arg2: !tt.ptr<i32>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "tensor.empty"() : () -> tensor<256xi32>
    %1 = "linalg.generic"(%0) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %22 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %23 = "arith.index_cast"(%22) : (index) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<256xi32>) -> tensor<256xi32>
    %2 = "tensor.empty"() : () -> tensor<256x!tt.ptr<i32>>
    %3 = "linalg.fill"(%arg0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: !tt.ptr<i32>, %arg24: !tt.ptr<i32>):
      "linalg.yield"(%arg23) : (!tt.ptr<i32>) -> ()
    }) : (!tt.ptr<i32>, tensor<256x!tt.ptr<i32>>) -> tensor<256x!tt.ptr<i32>>
    %4 = "linalg.generic"(%3, %1, %3) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: !tt.ptr<i32>, %arg21: i32, %arg22: !tt.ptr<i32>):
      %21 = "tt.addptr"(%arg20, %arg21) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      "linalg.yield"(%21) : (!tt.ptr<i32>) -> ()
    }) : (tensor<256x!tt.ptr<i32>>, tensor<256xi32>, tensor<256x!tt.ptr<i32>>) -> tensor<256x!tt.ptr<i32>>
    %5 = "tt.load"(%4) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<256x!tt.ptr<i32>>) -> tensor<256xi32>
    %6 = "tensor.expand_shape"(%5) <{reassociation = [[0, 1]], static_output_shape = array<i64: 128, 2>}> : (tensor<256xi32>) -> tensor<128x2xi32>
    %7 = "tensor.extract_slice"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 128, 1>, static_strides = array<i64: 1, 1>}> : (tensor<128x2xi32>) -> tensor<128xi32>
    %8 = "tensor.extract_slice"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 1>, static_sizes = array<i64: 128, 1>, static_strides = array<i64: 1, 1>}> : (tensor<128x2xi32>) -> tensor<128xi32>
    %9 = "tensor.empty"() : () -> tensor<128xi32>
    %10 = "linalg.generic"(%9) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg19: i32):
      %19 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %20 = "arith.index_cast"(%19) : (index) -> i32
      "linalg.yield"(%20) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %11 = "tensor.empty"() : () -> tensor<128x!tt.ptr<i32>>
    %12 = "linalg.fill"(%arg1, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: !tt.ptr<i32>, %arg18: !tt.ptr<i32>):
      "linalg.yield"(%arg17) : (!tt.ptr<i32>) -> ()
    }) : (!tt.ptr<i32>, tensor<128x!tt.ptr<i32>>) -> tensor<128x!tt.ptr<i32>>
    %13 = "linalg.generic"(%12, %10, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg14: !tt.ptr<i32>, %arg15: i32, %arg16: !tt.ptr<i32>):
      %18 = "tt.addptr"(%arg14, %arg15) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      "linalg.yield"(%18) : (!tt.ptr<i32>) -> ()
    }) : (tensor<128x!tt.ptr<i32>>, tensor<128xi32>, tensor<128x!tt.ptr<i32>>) -> tensor<128x!tt.ptr<i32>>
    "tt.store"(%13, %7) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<128x!tt.ptr<i32>>, tensor<128xi32>) -> ()
    %14 = "tensor.empty"() : () -> tensor<128x!tt.ptr<i32>>
    %15 = "linalg.fill"(%arg2, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<i32>, %arg13: !tt.ptr<i32>):
      "linalg.yield"(%arg12) : (!tt.ptr<i32>) -> ()
    }) : (!tt.ptr<i32>, tensor<128x!tt.ptr<i32>>) -> tensor<128x!tt.ptr<i32>>
    %16 = "linalg.generic"(%15, %10, %15) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<i32>, %arg10: i32, %arg11: !tt.ptr<i32>):
      %17 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      "linalg.yield"(%17) : (!tt.ptr<i32>) -> ()
    }) : (tensor<128x!tt.ptr<i32>>, tensor<128xi32>, tensor<128x!tt.ptr<i32>>) -> tensor<128x!tt.ptr<i32>>
    "tt.store"(%16, %8) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<128x!tt.ptr<i32>>, tensor<128xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

