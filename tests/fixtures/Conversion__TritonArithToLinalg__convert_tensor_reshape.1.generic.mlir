#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (0, d1)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>) -> (), sym_name = "bcast_kernel_01"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %31 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %32 = "arith.index_cast"(%31) : (index) -> i32
      "linalg.yield"(%32) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %30 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%30) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<2048xi32>
    %10 = "linalg.generic"(%9) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg19: i32):
      %28 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %29 = "arith.index_cast"(%28) : (index) -> i32
      "linalg.yield"(%29) : (i32) -> ()
    }) : (tensor<2048xi32>) -> tensor<2048xi32>
    %11 = "tensor.empty"() : () -> tensor<2048xi32>
    %12 = "linalg.fill"(%3, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: i32, %arg18: i32):
      "linalg.yield"(%arg17) : (i32) -> ()
    }) : (i32, tensor<2048xi32>) -> tensor<2048xi32>
    %13 = "linalg.generic"(%12, %10, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg14: i32, %arg15: i32, %arg16: i32):
      %27 = "arith.addi"(%arg14, %arg15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<2048xi32>, tensor<2048xi32>, tensor<2048xi32>) -> tensor<2048xi32>
    %14 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.fill"(%arg0, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "linalg.generic"(%15, %8, %15) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %26 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%26) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %17 = "tt.load"(%16) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<32x!tt.ptr<f32>>) -> tensor<32xf32>
    %18 = "tensor.expand_shape"(%17) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 32>}> : (tensor<32xf32>) -> tensor<1x32xf32>
    %19 = "tensor.empty"() : () -> tensor<64x32xf32>
    %20 = "linalg.generic"(%18, %19) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32):
      "linalg.yield"(%arg7) : (f32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x32xf32>, tensor<64x32xf32>) -> tensor<64x32xf32>
    %21 = "tensor.collapse_shape"(%20) <{reassociation = [[0, 1]]}> : (tensor<64x32xf32>) -> tensor<2048xf32>
    %22 = "tensor.empty"() : () -> tensor<2048x!tt.ptr<f32>>
    %23 = "linalg.fill"(%arg1, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: !tt.ptr<f32>, %arg6: !tt.ptr<f32>):
      "linalg.yield"(%arg5) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<2048x!tt.ptr<f32>>) -> tensor<2048x!tt.ptr<f32>>
    %24 = "linalg.generic"(%23, %13, %23) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: !tt.ptr<f32>, %arg3: i32, %arg4: !tt.ptr<f32>):
      %25 = "tt.addptr"(%arg2, %arg3) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%25) : (!tt.ptr<f32>) -> ()
    }) : (tensor<2048x!tt.ptr<f32>>, tensor<2048xi32>, tensor<2048x!tt.ptr<f32>>) -> tensor<2048x!tt.ptr<f32>>
    "tt.store"(%24, %21) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<2048x!tt.ptr<f32>>, tensor<2048xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

