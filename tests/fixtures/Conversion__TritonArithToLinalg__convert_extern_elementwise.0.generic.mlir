#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "atan2_kernel_0123"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<f32>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg7, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg38: i32):
      %29 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %30 = "arith.index_cast"(%29) : (index) -> i32
      "linalg.yield"(%30) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg36: i32, %arg37: i32):
      "linalg.yield"(%arg36) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg33: i32, %arg34: i32, %arg35: i32):
      %28 = "arith.addi"(%arg33, %arg34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%28) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg3, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg31: i32, %arg32: i32):
      "linalg.yield"(%arg31) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg28: i32, %arg29: i32, %arg30: i1):
      %27 = "arith.cmpi"(%arg28, %arg29) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%27) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg26: !tt.ptr<f32>, %arg27: !tt.ptr<f32>):
      "linalg.yield"(%arg26) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg23: !tt.ptr<f32>, %arg24: i32, %arg25: !tt.ptr<f32>):
      %26 = "tt.addptr"(%arg23, %arg24) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%26) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %16 = "linalg.fill"(%arg1, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: !tt.ptr<f32>, %arg22: !tt.ptr<f32>):
      "linalg.yield"(%arg21) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.generic"(%16, %6, %16) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg18: !tt.ptr<f32>, %arg19: i32, %arg20: !tt.ptr<f32>):
      %25 = "tt.addptr"(%arg18, %arg19) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%25) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "tt.load"(%17, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %19 = "linalg.generic"(%14, %18, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32, %arg17: f32):
      %24 = "math.atan2"(%arg15, %arg16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%24) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %20 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %21 = "linalg.fill"(%arg2, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %22 = "linalg.generic"(%21, %6, %21) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%22, %19) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "pow_kernel_0123"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<f32>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg7, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg38: i32):
      %29 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %30 = "arith.index_cast"(%29) : (index) -> i32
      "linalg.yield"(%30) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg36: i32, %arg37: i32):
      "linalg.yield"(%arg36) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg33: i32, %arg34: i32, %arg35: i32):
      %28 = "arith.addi"(%arg33, %arg34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%28) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg3, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg31: i32, %arg32: i32):
      "linalg.yield"(%arg31) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg28: i32, %arg29: i32, %arg30: i1):
      %27 = "arith.cmpi"(%arg28, %arg29) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%27) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg26: !tt.ptr<f32>, %arg27: !tt.ptr<f32>):
      "linalg.yield"(%arg26) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg23: !tt.ptr<f32>, %arg24: i32, %arg25: !tt.ptr<f32>):
      %26 = "tt.addptr"(%arg23, %arg24) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%26) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %16 = "linalg.fill"(%arg1, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: !tt.ptr<f32>, %arg22: !tt.ptr<f32>):
      "linalg.yield"(%arg21) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.generic"(%16, %6, %16) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg18: !tt.ptr<f32>, %arg19: i32, %arg20: !tt.ptr<f32>):
      %25 = "tt.addptr"(%arg18, %arg19) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%25) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "tt.load"(%17, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %19 = "linalg.generic"(%14, %18, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32, %arg17: f32):
      %24 = "math.powf"(%arg15, %arg16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%24) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %20 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %21 = "linalg.fill"(%arg2, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %22 = "linalg.generic"(%21, %6, %21) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%22, %19) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "fabs_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.absf"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "sin_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.sin"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "cos_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.cos"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "tan_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.tan"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "asin_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.asin"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "acos_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.acos"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "atan_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.atan"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "sinh_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.sinh"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "cosh_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.cosh"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "tanh_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.tanh"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "asinh_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.asinh"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "acosh_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.acosh"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "atanh_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.atanh"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "log_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.log"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "log10_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.log10"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "log1p_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.log1p"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "exp_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.exp"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "exp2_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.exp2"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "erf_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.erf"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "sqrt_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.sqrt"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "rsqrt_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.rsqrt"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "ceil_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.ceil"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "floor_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.floor"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "trunc_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "arith.muli"(%arg6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "tensor.empty"() : () -> tensor<32xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg31: i32):
      %24 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %25 = "arith.index_cast"(%24) : (index) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg29: i32, %arg30: i32):
      "linalg.yield"(%arg29) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %6 = "linalg.generic"(%5, %3, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: i32, %arg27: i32, %arg28: i32):
      %23 = "arith.addi"(%arg26, %arg27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %7 = "tensor.empty"() : () -> tensor<32xi32>
    %8 = "linalg.fill"(%arg2, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      "linalg.yield"(%arg24) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi1>
    %10 = "linalg.generic"(%6, %8, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32, %arg23: i1):
      %22 = "arith.cmpi"(%arg21, %arg22) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %11 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %12 = "linalg.fill"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: !tt.ptr<f32>, %arg20: !tt.ptr<f32>):
      "linalg.yield"(%arg19) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %13 = "linalg.generic"(%12, %6, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: !tt.ptr<f32>, %arg17: i32, %arg18: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg16, %arg17) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %14 = "tt.load"(%13, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %15 = "linalg.generic"(%14, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %20 = "math.trunc"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %17 = "linalg.fill"(%arg1, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>):
      "linalg.yield"(%arg12) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.generic"(%17, %6, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: !tt.ptr<f32>, %arg10: i32, %arg11: !tt.ptr<f32>):
      %19 = "tt.addptr"(%arg9, %arg10) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%19) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%18, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

