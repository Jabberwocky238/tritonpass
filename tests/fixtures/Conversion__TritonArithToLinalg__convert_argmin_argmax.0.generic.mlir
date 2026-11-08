#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<i32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "argmax_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<i32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %2 = "arith.muli"(%arg6, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %3 = "tensor.empty"() : () -> tensor<4096xi32>
    %4 = "linalg.generic"(%3) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg27: i32):
      %28 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %29 = "arith.index_cast"(%28) : (index) -> i32
      "linalg.yield"(%29) : (i32) -> ()
    }) : (tensor<4096xi32>) -> tensor<4096xi32>
    %5 = "tensor.empty"() : () -> tensor<4096xi32>
    %6 = "linalg.fill"(%2, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: i32, %arg26: i32):
      "linalg.yield"(%arg25) : (i32) -> ()
    }) : (i32, tensor<4096xi32>) -> tensor<4096xi32>
    %7 = "linalg.generic"(%6, %4, %6) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg22: i32, %arg23: i32, %arg24: i32):
      %27 = "arith.addi"(%arg22, %arg23) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<4096xi32>, tensor<4096xi32>, tensor<4096xi32>) -> tensor<4096xi32>
    %8 = "tensor.empty"() : () -> tensor<4096x!tt.ptr<f32>>
    %9 = "linalg.fill"(%arg0, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: !tt.ptr<f32>, %arg21: !tt.ptr<f32>):
      "linalg.yield"(%arg20) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<4096x!tt.ptr<f32>>) -> tensor<4096x!tt.ptr<f32>>
    %10 = "linalg.generic"(%9, %7, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg17: !tt.ptr<f32>, %arg18: i32, %arg19: !tt.ptr<f32>):
      %26 = "tt.addptr"(%arg17, %arg18) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%26) : (!tt.ptr<f32>) -> ()
    }) : (tensor<4096x!tt.ptr<f32>>, tensor<4096xi32>, tensor<4096x!tt.ptr<f32>>) -> tensor<4096x!tt.ptr<f32>>
    %11 = "tt.load"(%10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<4096x!tt.ptr<f32>>) -> tensor<4096xf32>
    %12 = "tensor.empty"() : () -> tensor<f32>
    %13 = "linalg.fill"(%1, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %14 = "tensor.empty"() : () -> tensor<i32>
    %15 = "linalg.fill"(%0, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: i32, %arg14: i32):
      "linalg.yield"(%arg13) : (i32) -> ()
    }) : (i32, tensor<i32>) -> tensor<i32>
    %16:2 = "linalg.reduce"(%11, %4, %13, %15) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg9: f32, %arg10: i32, %arg11: f32, %arg12: i32):
      %19 = "arith.cmpf"(%arg9, %arg11) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      %20 = "arith.cmpi"(%arg10, %arg12) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %21 = "arith.andi"(%19, %20) : (i1, i1) -> i1
      %22 = "arith.cmpf"(%arg9, %arg11) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      %23 = "arith.ori"(%22, %21) : (i1, i1) -> i1
      %24 = "arith.select"(%23, %arg9, %arg11) : (i1, f32, f32) -> f32
      %25 = "arith.select"(%23, %arg10, %arg12) : (i1, i32, i32) -> i32
      "linalg.yield"(%24, %25) : (f32, i32) -> ()
    }) : (tensor<4096xf32>, tensor<4096xi32>, tensor<f32>, tensor<i32>) -> (tensor<f32>, tensor<i32>)
    %17 = "tensor.extract"(%16#1) : (tensor<i32>) -> i32
    %18 = "tt.addptr"(%arg1, %arg6) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
    "tt.store"(%18, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<i32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "argmin_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<i32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %2 = "arith.muli"(%arg6, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %3 = "tensor.empty"() : () -> tensor<4096xi32>
    %4 = "linalg.generic"(%3) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg27: i32):
      %28 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %29 = "arith.index_cast"(%28) : (index) -> i32
      "linalg.yield"(%29) : (i32) -> ()
    }) : (tensor<4096xi32>) -> tensor<4096xi32>
    %5 = "tensor.empty"() : () -> tensor<4096xi32>
    %6 = "linalg.fill"(%2, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: i32, %arg26: i32):
      "linalg.yield"(%arg25) : (i32) -> ()
    }) : (i32, tensor<4096xi32>) -> tensor<4096xi32>
    %7 = "linalg.generic"(%6, %4, %6) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg22: i32, %arg23: i32, %arg24: i32):
      %27 = "arith.addi"(%arg22, %arg23) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<4096xi32>, tensor<4096xi32>, tensor<4096xi32>) -> tensor<4096xi32>
    %8 = "tensor.empty"() : () -> tensor<4096x!tt.ptr<f32>>
    %9 = "linalg.fill"(%arg0, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: !tt.ptr<f32>, %arg21: !tt.ptr<f32>):
      "linalg.yield"(%arg20) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<4096x!tt.ptr<f32>>) -> tensor<4096x!tt.ptr<f32>>
    %10 = "linalg.generic"(%9, %7, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg17: !tt.ptr<f32>, %arg18: i32, %arg19: !tt.ptr<f32>):
      %26 = "tt.addptr"(%arg17, %arg18) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%26) : (!tt.ptr<f32>) -> ()
    }) : (tensor<4096x!tt.ptr<f32>>, tensor<4096xi32>, tensor<4096x!tt.ptr<f32>>) -> tensor<4096x!tt.ptr<f32>>
    %11 = "tt.load"(%10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<4096x!tt.ptr<f32>>) -> tensor<4096xf32>
    %12 = "tensor.empty"() : () -> tensor<f32>
    %13 = "linalg.fill"(%1, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %14 = "tensor.empty"() : () -> tensor<i32>
    %15 = "linalg.fill"(%0, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: i32, %arg14: i32):
      "linalg.yield"(%arg13) : (i32) -> ()
    }) : (i32, tensor<i32>) -> tensor<i32>
    %16:2 = "linalg.reduce"(%11, %4, %13, %15) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg9: f32, %arg10: i32, %arg11: f32, %arg12: i32):
      %19 = "arith.cmpf"(%arg9, %arg11) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      %20 = "arith.cmpi"(%arg10, %arg12) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %21 = "arith.andi"(%19, %20) : (i1, i1) -> i1
      %22 = "arith.cmpf"(%arg9, %arg11) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
      %23 = "arith.ori"(%22, %21) : (i1, i1) -> i1
      %24 = "arith.select"(%23, %arg9, %arg11) : (i1, f32, f32) -> f32
      %25 = "arith.select"(%23, %arg10, %arg12) : (i1, i32, i32) -> i32
      "linalg.yield"(%24, %25) : (f32, i32) -> ()
    }) : (tensor<4096xf32>, tensor<4096xi32>, tensor<f32>, tensor<i32>) -> (tensor<f32>, tensor<i32>)
    %17 = "tensor.extract"(%16#1) : (tensor<i32>) -> i32
    %18 = "tt.addptr"(%arg1, %arg6) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
    "tt.store"(%18, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

