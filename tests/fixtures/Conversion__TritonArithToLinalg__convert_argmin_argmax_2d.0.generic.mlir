#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1) -> (d0, 0)>
#map3 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "test_argmax"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32):
    %0 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %2 = "tensor.empty"() : () -> tensor<4xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg49: i32):
      %46 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %47 = "arith.index_cast"(%46) : (index) -> i32
      "linalg.yield"(%47) : (i32) -> ()
    }) : (tensor<4xi32>) -> tensor<4xi32>
    %4 = "tensor.expand_shape"(%3) <{reassociation = [[0, 1]], static_output_shape = array<i64: 4, 1>}> : (tensor<4xi32>) -> tensor<4x1xi32>
    %5 = "tensor.empty"() : () -> tensor<4x1xi32>
    %6 = "linalg.fill"(%arg2, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg47: i32, %arg48: i32):
      "linalg.yield"(%arg47) : (i32) -> ()
    }) : (i32, tensor<4x1xi32>) -> tensor<4x1xi32>
    %7 = "linalg.generic"(%4, %6, %4) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg44: i32, %arg45: i32, %arg46: i32):
      %45 = "arith.muli"(%arg44, %arg45) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%45) : (i32) -> ()
    }) : (tensor<4x1xi32>, tensor<4x1xi32>, tensor<4x1xi32>) -> tensor<4x1xi32>
    %8 = "tensor.expand_shape"(%3) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xi32>) -> tensor<1x4xi32>
    %9 = "tensor.empty"() : () -> tensor<1x4xi32>
    %10 = "linalg.fill"(%arg3, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg42: i32, %arg43: i32):
      "linalg.yield"(%arg42) : (i32) -> ()
    }) : (i32, tensor<1x4xi32>) -> tensor<1x4xi32>
    %11 = "linalg.generic"(%8, %10, %8) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg39: i32, %arg40: i32, %arg41: i32):
      %44 = "arith.muli"(%arg39, %arg40) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%44) : (i32) -> ()
    }) : (tensor<1x4xi32>, tensor<1x4xi32>, tensor<1x4xi32>) -> tensor<1x4xi32>
    %12 = "tensor.empty"() : () -> tensor<4x4xi32>
    %13 = "linalg.generic"(%7, %12) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg37: i32, %arg38: i32):
      "linalg.yield"(%arg37) : (i32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<4x1xi32>, tensor<4x4xi32>) -> tensor<4x4xi32>
    %14 = "tensor.empty"() : () -> tensor<4x4xi32>
    %15 = "linalg.generic"(%11, %14) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg35: i32, %arg36: i32):
      "linalg.yield"(%arg35) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x4xi32>, tensor<4x4xi32>) -> tensor<4x4xi32>
    %16 = "linalg.generic"(%13, %15, %13) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg32: i32, %arg33: i32, %arg34: i32):
      %43 = "arith.addi"(%arg32, %arg33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%43) : (i32) -> ()
    }) : (tensor<4x4xi32>, tensor<4x4xi32>, tensor<4x4xi32>) -> tensor<4x4xi32>
    %17 = "tensor.empty"() : () -> tensor<4x4x!tt.ptr<f32>>
    %18 = "linalg.fill"(%arg0, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: !tt.ptr<f32>, %arg31: !tt.ptr<f32>):
      "linalg.yield"(%arg30) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<4x4x!tt.ptr<f32>>) -> tensor<4x4x!tt.ptr<f32>>
    %19 = "linalg.generic"(%18, %16, %18) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg27: !tt.ptr<f32>, %arg28: i32, %arg29: !tt.ptr<f32>):
      %42 = "tt.addptr"(%arg27, %arg28) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%42) : (!tt.ptr<f32>) -> ()
    }) : (tensor<4x4x!tt.ptr<f32>>, tensor<4x4xi32>, tensor<4x4x!tt.ptr<f32>>) -> tensor<4x4x!tt.ptr<f32>>
    %20 = "tt.load"(%19) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<4x4x!tt.ptr<f32>>) -> tensor<4x4xf32>
    %21 = "tensor.empty"() : () -> tensor<4x4xi32>
    %22 = "linalg.generic"(%8, %21) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: i32, %arg26: i32):
      "linalg.yield"(%arg25) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x4xi32>, tensor<4x4xi32>) -> tensor<4x4xi32>
    %23 = "tensor.empty"() : () -> tensor<4xf32>
    %24 = "linalg.fill"(%1, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: f32, %arg24: f32):
      "linalg.yield"(%arg23) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %25 = "tensor.empty"() : () -> tensor<4xi32>
    %26 = "linalg.fill"(%0, %25) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32):
      "linalg.yield"(%arg21) : (i32) -> ()
    }) : (i32, tensor<4xi32>) -> tensor<4xi32>
    %27:2 = "linalg.reduce"(%20, %22, %24, %26) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg17: f32, %arg18: i32, %arg19: f32, %arg20: i32):
      %35 = "arith.cmpf"(%arg17, %arg19) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      %36 = "arith.cmpi"(%arg18, %arg20) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %37 = "arith.andi"(%35, %36) : (i1, i1) -> i1
      %38 = "arith.cmpf"(%arg17, %arg19) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      %39 = "arith.ori"(%38, %37) : (i1, i1) -> i1
      %40 = "arith.select"(%39, %arg17, %arg19) : (i1, f32, f32) -> f32
      %41 = "arith.select"(%39, %arg18, %arg20) : (i1, i32, i32) -> i32
      "linalg.yield"(%40, %41) : (f32, i32) -> ()
    }) : (tensor<4x4xf32>, tensor<4x4xi32>, tensor<4xf32>, tensor<4xi32>) -> (tensor<4xf32>, tensor<4xi32>)
    %28 = "tensor.empty"() : () -> tensor<4x!tt.ptr<f32>>
    %29 = "linalg.fill"(%arg1, %28) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: !tt.ptr<f32>, %arg16: !tt.ptr<f32>):
      "linalg.yield"(%arg15) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<4x!tt.ptr<f32>>) -> tensor<4x!tt.ptr<f32>>
    %30 = "linalg.generic"(%29, %3, %29) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: i32, %arg14: !tt.ptr<f32>):
      %34 = "tt.addptr"(%arg12, %arg13) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%34) : (!tt.ptr<f32>) -> ()
    }) : (tensor<4x!tt.ptr<f32>>, tensor<4xi32>, tensor<4x!tt.ptr<f32>>) -> tensor<4x!tt.ptr<f32>>
    %31 = "tensor.empty"() : () -> tensor<4xf32>
    %32 = "linalg.generic"(%27#1, %31) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: i32, %arg11: f32):
      %33 = "arith.sitofp"(%arg10) : (i32) -> f32
      "linalg.yield"(%33) : (f32) -> ()
    }) : (tensor<4xi32>, tensor<4xf32>) -> tensor<4xf32>
    "tt.store"(%30, %32) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<4x!tt.ptr<f32>>, tensor<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1) -> (d0, 0)>
#map3 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "test_argmin"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32):
    %0 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %2 = "tensor.empty"() : () -> tensor<4xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg49: i32):
      %46 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %47 = "arith.index_cast"(%46) : (index) -> i32
      "linalg.yield"(%47) : (i32) -> ()
    }) : (tensor<4xi32>) -> tensor<4xi32>
    %4 = "tensor.expand_shape"(%3) <{reassociation = [[0, 1]], static_output_shape = array<i64: 4, 1>}> : (tensor<4xi32>) -> tensor<4x1xi32>
    %5 = "tensor.empty"() : () -> tensor<4x1xi32>
    %6 = "linalg.fill"(%arg2, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg47: i32, %arg48: i32):
      "linalg.yield"(%arg47) : (i32) -> ()
    }) : (i32, tensor<4x1xi32>) -> tensor<4x1xi32>
    %7 = "linalg.generic"(%4, %6, %4) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg44: i32, %arg45: i32, %arg46: i32):
      %45 = "arith.muli"(%arg44, %arg45) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%45) : (i32) -> ()
    }) : (tensor<4x1xi32>, tensor<4x1xi32>, tensor<4x1xi32>) -> tensor<4x1xi32>
    %8 = "tensor.expand_shape"(%3) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xi32>) -> tensor<1x4xi32>
    %9 = "tensor.empty"() : () -> tensor<1x4xi32>
    %10 = "linalg.fill"(%arg3, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg42: i32, %arg43: i32):
      "linalg.yield"(%arg42) : (i32) -> ()
    }) : (i32, tensor<1x4xi32>) -> tensor<1x4xi32>
    %11 = "linalg.generic"(%8, %10, %8) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg39: i32, %arg40: i32, %arg41: i32):
      %44 = "arith.muli"(%arg39, %arg40) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%44) : (i32) -> ()
    }) : (tensor<1x4xi32>, tensor<1x4xi32>, tensor<1x4xi32>) -> tensor<1x4xi32>
    %12 = "tensor.empty"() : () -> tensor<4x4xi32>
    %13 = "linalg.generic"(%7, %12) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg37: i32, %arg38: i32):
      "linalg.yield"(%arg37) : (i32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<4x1xi32>, tensor<4x4xi32>) -> tensor<4x4xi32>
    %14 = "tensor.empty"() : () -> tensor<4x4xi32>
    %15 = "linalg.generic"(%11, %14) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg35: i32, %arg36: i32):
      "linalg.yield"(%arg35) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x4xi32>, tensor<4x4xi32>) -> tensor<4x4xi32>
    %16 = "linalg.generic"(%13, %15, %13) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg32: i32, %arg33: i32, %arg34: i32):
      %43 = "arith.addi"(%arg32, %arg33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%43) : (i32) -> ()
    }) : (tensor<4x4xi32>, tensor<4x4xi32>, tensor<4x4xi32>) -> tensor<4x4xi32>
    %17 = "tensor.empty"() : () -> tensor<4x4x!tt.ptr<f32>>
    %18 = "linalg.fill"(%arg0, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: !tt.ptr<f32>, %arg31: !tt.ptr<f32>):
      "linalg.yield"(%arg30) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<4x4x!tt.ptr<f32>>) -> tensor<4x4x!tt.ptr<f32>>
    %19 = "linalg.generic"(%18, %16, %18) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg27: !tt.ptr<f32>, %arg28: i32, %arg29: !tt.ptr<f32>):
      %42 = "tt.addptr"(%arg27, %arg28) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%42) : (!tt.ptr<f32>) -> ()
    }) : (tensor<4x4x!tt.ptr<f32>>, tensor<4x4xi32>, tensor<4x4x!tt.ptr<f32>>) -> tensor<4x4x!tt.ptr<f32>>
    %20 = "tt.load"(%19) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<4x4x!tt.ptr<f32>>) -> tensor<4x4xf32>
    %21 = "tensor.empty"() : () -> tensor<4x4xi32>
    %22 = "linalg.generic"(%8, %21) <{indexing_maps = [#map3, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: i32, %arg26: i32):
      "linalg.yield"(%arg25) : (i32) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x4xi32>, tensor<4x4xi32>) -> tensor<4x4xi32>
    %23 = "tensor.empty"() : () -> tensor<4xf32>
    %24 = "linalg.fill"(%1, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: f32, %arg24: f32):
      "linalg.yield"(%arg23) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %25 = "tensor.empty"() : () -> tensor<4xi32>
    %26 = "linalg.fill"(%0, %25) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32):
      "linalg.yield"(%arg21) : (i32) -> ()
    }) : (i32, tensor<4xi32>) -> tensor<4xi32>
    %27:2 = "linalg.reduce"(%20, %22, %24, %26) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg17: f32, %arg18: i32, %arg19: f32, %arg20: i32):
      %35 = "arith.cmpf"(%arg17, %arg19) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      %36 = "arith.cmpi"(%arg18, %arg20) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %37 = "arith.andi"(%35, %36) : (i1, i1) -> i1
      %38 = "arith.cmpf"(%arg17, %arg19) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
      %39 = "arith.ori"(%38, %37) : (i1, i1) -> i1
      %40 = "arith.select"(%39, %arg17, %arg19) : (i1, f32, f32) -> f32
      %41 = "arith.select"(%39, %arg18, %arg20) : (i1, i32, i32) -> i32
      "linalg.yield"(%40, %41) : (f32, i32) -> ()
    }) : (tensor<4x4xf32>, tensor<4x4xi32>, tensor<4xf32>, tensor<4xi32>) -> (tensor<4xf32>, tensor<4xi32>)
    %28 = "tensor.empty"() : () -> tensor<4x!tt.ptr<f32>>
    %29 = "linalg.fill"(%arg1, %28) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: !tt.ptr<f32>, %arg16: !tt.ptr<f32>):
      "linalg.yield"(%arg15) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<4x!tt.ptr<f32>>) -> tensor<4x!tt.ptr<f32>>
    %30 = "linalg.generic"(%29, %3, %29) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: i32, %arg14: !tt.ptr<f32>):
      %34 = "tt.addptr"(%arg12, %arg13) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%34) : (!tt.ptr<f32>) -> ()
    }) : (tensor<4x!tt.ptr<f32>>, tensor<4xi32>, tensor<4x!tt.ptr<f32>>) -> tensor<4x!tt.ptr<f32>>
    %31 = "tensor.empty"() : () -> tensor<4xf32>
    %32 = "linalg.generic"(%27#1, %31) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: i32, %arg11: f32):
      %33 = "arith.sitofp"(%arg10) : (i32) -> f32
      "linalg.yield"(%33) : (f32) -> ()
    }) : (tensor<4xi32>, tensor<4xf32>) -> tensor<4xf32>
    "tt.store"(%30, %32) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<4x!tt.ptr<f32>>, tensor<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

