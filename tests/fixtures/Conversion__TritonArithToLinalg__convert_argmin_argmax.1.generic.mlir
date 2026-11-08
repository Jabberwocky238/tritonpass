#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<i32>, i32) -> (), sym_name = "argmax_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<i32>, %arg2: i32):
    %0 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %2 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %3 = "arith.index_cast"(%2) : (index) -> i32
    %4 = "arith.muli"(%3, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %5 = "tensor.empty"() : () -> tensor<4096xi32>
    %6 = "linalg.generic"(%5) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg21: i32):
      %30 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %31 = "arith.index_cast"(%30) : (index) -> i32
      "linalg.yield"(%31) : (i32) -> ()
    }) : (tensor<4096xi32>) -> tensor<4096xi32>
    %7 = "tensor.empty"() : () -> tensor<4096xi32>
    %8 = "linalg.fill"(%4, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: i32, %arg20: i32):
      "linalg.yield"(%arg19) : (i32) -> ()
    }) : (i32, tensor<4096xi32>) -> tensor<4096xi32>
    %9 = "linalg.generic"(%8, %6, %8) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: i32, %arg17: i32, %arg18: i32):
      %29 = "arith.addi"(%arg16, %arg17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%29) : (i32) -> ()
    }) : (tensor<4096xi32>, tensor<4096xi32>, tensor<4096xi32>) -> tensor<4096xi32>
    %10 = "tensor.empty"() : () -> tensor<4096x!tt.ptr<f32>>
    %11 = "linalg.fill"(%arg0, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: !tt.ptr<f32>, %arg15: !tt.ptr<f32>):
      "linalg.yield"(%arg14) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<4096x!tt.ptr<f32>>) -> tensor<4096x!tt.ptr<f32>>
    %12 = "linalg.generic"(%11, %9, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg11: !tt.ptr<f32>, %arg12: i32, %arg13: !tt.ptr<f32>):
      %28 = "tt.addptr"(%arg11, %arg12) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%28) : (!tt.ptr<f32>) -> ()
    }) : (tensor<4096x!tt.ptr<f32>>, tensor<4096xi32>, tensor<4096x!tt.ptr<f32>>) -> tensor<4096x!tt.ptr<f32>>
    %13 = "tt.load"(%12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<4096x!tt.ptr<f32>>) -> tensor<4096xf32>
    %14 = "tensor.empty"() : () -> tensor<f32>
    %15 = "linalg.fill"(%1, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %16 = "tensor.empty"() : () -> tensor<i32>
    %17 = "linalg.fill"(%0, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: i32, %arg8: i32):
      "linalg.yield"(%arg7) : (i32) -> ()
    }) : (i32, tensor<i32>) -> tensor<i32>
    %18:2 = "linalg.reduce"(%13, %6, %15, %17) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg3: f32, %arg4: i32, %arg5: f32, %arg6: i32):
      %21 = "arith.cmpf"(%arg3, %arg5) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      %22 = "arith.cmpi"(%arg4, %arg6) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %23 = "arith.andi"(%21, %22) : (i1, i1) -> i1
      %24 = "arith.cmpf"(%arg3, %arg5) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      %25 = "arith.ori"(%24, %23) : (i1, i1) -> i1
      %26 = "arith.select"(%25, %arg3, %arg5) : (i1, f32, f32) -> f32
      %27 = "arith.select"(%25, %arg4, %arg6) : (i1, i32, i32) -> i32
      "linalg.yield"(%26, %27) : (f32, i32) -> ()
    }) : (tensor<4096xf32>, tensor<4096xi32>, tensor<f32>, tensor<i32>) -> (tensor<f32>, tensor<i32>)
    %19 = "tensor.extract"(%18#1) : (tensor<i32>) -> i32
    %20 = "tt.addptr"(%arg1, %3) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
    "tt.store"(%20, %19) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<i32>, i32) -> (), sym_name = "argmin_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<i32>, %arg2: i32):
    %0 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %2 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %3 = "arith.index_cast"(%2) : (index) -> i32
    %4 = "arith.muli"(%3, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %5 = "tensor.empty"() : () -> tensor<4096xi32>
    %6 = "linalg.generic"(%5) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg21: i32):
      %30 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %31 = "arith.index_cast"(%30) : (index) -> i32
      "linalg.yield"(%31) : (i32) -> ()
    }) : (tensor<4096xi32>) -> tensor<4096xi32>
    %7 = "tensor.empty"() : () -> tensor<4096xi32>
    %8 = "linalg.fill"(%4, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: i32, %arg20: i32):
      "linalg.yield"(%arg19) : (i32) -> ()
    }) : (i32, tensor<4096xi32>) -> tensor<4096xi32>
    %9 = "linalg.generic"(%8, %6, %8) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: i32, %arg17: i32, %arg18: i32):
      %29 = "arith.addi"(%arg16, %arg17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%29) : (i32) -> ()
    }) : (tensor<4096xi32>, tensor<4096xi32>, tensor<4096xi32>) -> tensor<4096xi32>
    %10 = "tensor.empty"() : () -> tensor<4096x!tt.ptr<f32>>
    %11 = "linalg.fill"(%arg0, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: !tt.ptr<f32>, %arg15: !tt.ptr<f32>):
      "linalg.yield"(%arg14) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<4096x!tt.ptr<f32>>) -> tensor<4096x!tt.ptr<f32>>
    %12 = "linalg.generic"(%11, %9, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg11: !tt.ptr<f32>, %arg12: i32, %arg13: !tt.ptr<f32>):
      %28 = "tt.addptr"(%arg11, %arg12) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%28) : (!tt.ptr<f32>) -> ()
    }) : (tensor<4096x!tt.ptr<f32>>, tensor<4096xi32>, tensor<4096x!tt.ptr<f32>>) -> tensor<4096x!tt.ptr<f32>>
    %13 = "tt.load"(%12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<4096x!tt.ptr<f32>>) -> tensor<4096xf32>
    %14 = "tensor.empty"() : () -> tensor<f32>
    %15 = "linalg.fill"(%1, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %16 = "tensor.empty"() : () -> tensor<i32>
    %17 = "linalg.fill"(%0, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: i32, %arg8: i32):
      "linalg.yield"(%arg7) : (i32) -> ()
    }) : (i32, tensor<i32>) -> tensor<i32>
    %18:2 = "linalg.reduce"(%13, %6, %15, %17) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg3: f32, %arg4: i32, %arg5: f32, %arg6: i32):
      %21 = "arith.cmpf"(%arg3, %arg5) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      %22 = "arith.cmpi"(%arg4, %arg6) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %23 = "arith.andi"(%21, %22) : (i1, i1) -> i1
      %24 = "arith.cmpf"(%arg3, %arg5) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
      %25 = "arith.ori"(%24, %23) : (i1, i1) -> i1
      %26 = "arith.select"(%25, %arg3, %arg5) : (i1, f32, f32) -> f32
      %27 = "arith.select"(%25, %arg4, %arg6) : (i1, i32, i32) -> i32
      "linalg.yield"(%26, %27) : (f32, i32) -> ()
    }) : (tensor<4096xf32>, tensor<4096xi32>, tensor<f32>, tensor<i32>) -> (tensor<f32>, tensor<i32>)
    %19 = "tensor.extract"(%18#1) : (tensor<i32>) -> i32
    %20 = "tt.addptr"(%arg1, %3) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
    "tt.store"(%20, %19) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

