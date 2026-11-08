#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (0, d1)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "bcast_kernel_01"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg5, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %29 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %30 = "arith.index_cast"(%29) : (index) -> i32
      "linalg.yield"(%30) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %28 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%28) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<2048xi32>
    %8 = "linalg.generic"(%7) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<2048xi32>) -> tensor<2048xi32>
    %9 = "tensor.empty"() : () -> tensor<2048xi32>
    %10 = "linalg.fill"(%1, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<2048xi32>) -> tensor<2048xi32>
    %11 = "linalg.generic"(%10, %8, %10) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<2048xi32>, tensor<2048xi32>, tensor<2048xi32>) -> tensor<2048xi32>
    %12 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.fill"(%arg0, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: !tt.ptr<f32>, %arg19: !tt.ptr<f32>):
      "linalg.yield"(%arg18) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.generic"(%13, %6, %13) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: !tt.ptr<f32>, %arg16: i32, %arg17: !tt.ptr<f32>):
      %24 = "tt.addptr"(%arg15, %arg16) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%24) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "tt.load"(%14) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<32x!tt.ptr<f32>>) -> tensor<32xf32>
    %16 = "tensor.expand_shape"(%15) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 32>}> : (tensor<32xf32>) -> tensor<1x32xf32>
    %17 = "tensor.empty"() : () -> tensor<64x32xf32>
    %18 = "linalg.generic"(%16, %17) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      "linalg.yield"(%arg13) : (f32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x32xf32>, tensor<64x32xf32>) -> tensor<64x32xf32>
    %19 = "tensor.collapse_shape"(%18) <{reassociation = [[0, 1]]}> : (tensor<64x32xf32>) -> tensor<2048xf32>
    %20 = "tensor.empty"() : () -> tensor<2048x!tt.ptr<f32>>
    %21 = "linalg.fill"(%arg1, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: !tt.ptr<f32>, %arg12: !tt.ptr<f32>):
      "linalg.yield"(%arg11) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<2048x!tt.ptr<f32>>) -> tensor<2048x!tt.ptr<f32>>
    %22 = "linalg.generic"(%21, %11, %21) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg8: !tt.ptr<f32>, %arg9: i32, %arg10: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg8, %arg9) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<2048x!tt.ptr<f32>>, tensor<2048xi32>, tensor<2048x!tt.ptr<f32>>) -> tensor<2048x!tt.ptr<f32>>
    "tt.store"(%22, %19) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<2048x!tt.ptr<f32>>, tensor<2048xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

