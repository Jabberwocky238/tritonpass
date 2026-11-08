#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<i32>, !tt.ptr<i32>) -> (), sym_name = "rand"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: !tt.ptr<i32>):
    %0 = "tensor.empty"() : () -> tensor<8xi32>
    %1 = "linalg.generic"(%0) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg12: i32):
      %12 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %13 = "arith.index_cast"(%12) : (index) -> i32
      "linalg.yield"(%13) : (i32) -> ()
    }) : (tensor<8xi32>) -> tensor<8xi32>
    %2 = "tensor.empty"() : () -> tensor<8x!tt.ptr<i32>>
    %3 = "linalg.fill"(%arg0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: !tt.ptr<i32>, %arg11: !tt.ptr<i32>):
      "linalg.yield"(%arg10) : (!tt.ptr<i32>) -> ()
    }) : (!tt.ptr<i32>, tensor<8x!tt.ptr<i32>>) -> tensor<8x!tt.ptr<i32>>
    %4 = "linalg.generic"(%3, %1, %3) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg7: !tt.ptr<i32>, %arg8: i32, %arg9: !tt.ptr<i32>):
      %11 = "tt.addptr"(%arg7, %arg8) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      "linalg.yield"(%11) : (!tt.ptr<i32>) -> ()
    }) : (tensor<8x!tt.ptr<i32>>, tensor<8xi32>, tensor<8x!tt.ptr<i32>>) -> tensor<8x!tt.ptr<i32>>
    %5 = "tt.load"(%4) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<8x!tt.ptr<i32>>) -> tensor<8xi32>
    %6 = "tt.extern_elementwise"(%5, %1) <{libname = "", libpath = "", pure = true, symbol = "some_symbol"}> : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    %7 = "tensor.empty"() : () -> tensor<8x!tt.ptr<i32>>
    %8 = "linalg.fill"(%arg1, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: !tt.ptr<i32>, %arg6: !tt.ptr<i32>):
      "linalg.yield"(%arg5) : (!tt.ptr<i32>) -> ()
    }) : (!tt.ptr<i32>, tensor<8x!tt.ptr<i32>>) -> tensor<8x!tt.ptr<i32>>
    %9 = "linalg.generic"(%8, %1, %8) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: !tt.ptr<i32>, %arg3: i32, %arg4: !tt.ptr<i32>):
      %10 = "tt.addptr"(%arg2, %arg3) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      "linalg.yield"(%10) : (!tt.ptr<i32>) -> ()
    }) : (tensor<8x!tt.ptr<i32>>, tensor<8xi32>, tensor<8x!tt.ptr<i32>>) -> tensor<8x!tt.ptr<i32>>
    "tt.store"(%9, %6) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<8x!tt.ptr<i32>>, tensor<8xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

