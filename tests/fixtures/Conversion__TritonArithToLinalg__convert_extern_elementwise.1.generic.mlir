#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "atan2_kernel_0123"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<f32>, %arg3: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg32: i32):
      %31 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %32 = "arith.index_cast"(%31) : (index) -> i32
      "linalg.yield"(%32) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: i32, %arg31: i32):
      "linalg.yield"(%arg30) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg27: i32, %arg28: i32, %arg29: i32):
      %30 = "arith.addi"(%arg27, %arg28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%30) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg3, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: i32, %arg26: i32):
      "linalg.yield"(%arg25) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg22: i32, %arg23: i32, %arg24: i1):
      %29 = "arith.cmpi"(%arg22, %arg23) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%29) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: !tt.ptr<f32>, %arg21: !tt.ptr<f32>):
      "linalg.yield"(%arg20) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg17: !tt.ptr<f32>, %arg18: i32, %arg19: !tt.ptr<f32>):
      %28 = "tt.addptr"(%arg17, %arg18) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%28) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.fill"(%arg1, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: !tt.ptr<f32>, %arg16: !tt.ptr<f32>):
      "linalg.yield"(%arg15) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.generic"(%18, %8, %18) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: i32, %arg14: !tt.ptr<f32>):
      %27 = "tt.addptr"(%arg12, %arg13) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%27) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "tt.load"(%19, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %21 = "linalg.generic"(%16, %20, %16) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32, %arg11: f32):
      %26 = "math.atan2"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%26) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %22 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %23 = "linalg.fill"(%arg2, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: !tt.ptr<f32>, %arg8: !tt.ptr<f32>):
      "linalg.yield"(%arg7) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %24 = "linalg.generic"(%23, %8, %23) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg4: !tt.ptr<f32>, %arg5: i32, %arg6: !tt.ptr<f32>):
      %25 = "tt.addptr"(%arg4, %arg5) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%25) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%24, %21) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "pow_kernel_0123"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<f32>, %arg3: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg32: i32):
      %31 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %32 = "arith.index_cast"(%31) : (index) -> i32
      "linalg.yield"(%32) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: i32, %arg31: i32):
      "linalg.yield"(%arg30) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg27: i32, %arg28: i32, %arg29: i32):
      %30 = "arith.addi"(%arg27, %arg28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%30) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg3, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: i32, %arg26: i32):
      "linalg.yield"(%arg25) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg22: i32, %arg23: i32, %arg24: i1):
      %29 = "arith.cmpi"(%arg22, %arg23) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%29) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: !tt.ptr<f32>, %arg21: !tt.ptr<f32>):
      "linalg.yield"(%arg20) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg17: !tt.ptr<f32>, %arg18: i32, %arg19: !tt.ptr<f32>):
      %28 = "tt.addptr"(%arg17, %arg18) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%28) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %18 = "linalg.fill"(%arg1, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: !tt.ptr<f32>, %arg16: !tt.ptr<f32>):
      "linalg.yield"(%arg15) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.generic"(%18, %8, %18) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg12: !tt.ptr<f32>, %arg13: i32, %arg14: !tt.ptr<f32>):
      %27 = "tt.addptr"(%arg12, %arg13) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%27) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "tt.load"(%19, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %21 = "linalg.generic"(%16, %20, %16) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32, %arg11: f32):
      %26 = "math.powf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%26) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %22 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %23 = "linalg.fill"(%arg2, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: !tt.ptr<f32>, %arg8: !tt.ptr<f32>):
      "linalg.yield"(%arg7) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %24 = "linalg.generic"(%23, %8, %23) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg4: !tt.ptr<f32>, %arg5: i32, %arg6: !tt.ptr<f32>):
      %25 = "tt.addptr"(%arg4, %arg5) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%25) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%24, %21) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "fabs_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.absf"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "sin_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.sin"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "cos_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.cos"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "tan_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.tan"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "asin_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.asin"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "acos_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.acos"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "atan_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.atan"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "sinh_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.sinh"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "cosh_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.cosh"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "tanh_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.tanh"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "asinh_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.asinh"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "acosh_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.acosh"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "atanh_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.atanh"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "log_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.log"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "log10_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.log10"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "log1p_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.log1p"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "exp_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.exp"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "exp2_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.exp2"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "erf_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.erf"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "sqrt_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.sqrt"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "rsqrt_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.rsqrt"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "ceil_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.ceil"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "floor_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.floor"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "trunc_kernel_012"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tensor.empty"() : () -> tensor<32xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg25: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32xi32>) -> tensor<32xi32>
    %6 = "tensor.empty"() : () -> tensor<32xi32>
    %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %8 = "linalg.generic"(%7, %5, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %25 = "arith.addi"(%arg20, %arg21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %9 = "tensor.empty"() : () -> tensor<32xi32>
    %10 = "linalg.fill"(%arg2, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<32xi32>) -> tensor<32xi32>
    %11 = "tensor.empty"() : () -> tensor<32xi1>
    %12 = "linalg.generic"(%8, %10, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32, %arg17: i1):
      %24 = "arith.cmpi"(%arg15, %arg16) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%24) : (i1) -> ()
    }) : (tensor<32xi32>, tensor<32xi32>, tensor<32xi1>) -> tensor<32xi1>
    %13 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %14 = "linalg.fill"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: !tt.ptr<f32>, %arg14: !tt.ptr<f32>):
      "linalg.yield"(%arg13) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %15 = "linalg.generic"(%14, %8, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: !tt.ptr<f32>, %arg11: i32, %arg12: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg10, %arg11) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xi1>) -> tensor<32xf32>
    %17 = "linalg.generic"(%16, %16) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.trunc"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %18 = "tensor.empty"() : () -> tensor<32x!tt.ptr<f32>>
    %19 = "linalg.fill"(%arg1, %18) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>):
      "linalg.yield"(%arg6) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    %20 = "linalg.generic"(%19, %8, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: !tt.ptr<f32>, %arg4: i32, %arg5: !tt.ptr<f32>):
      %21 = "tt.addptr"(%arg3, %arg4) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%21) : (!tt.ptr<f32>) -> ()
    }) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>, tensor<32x!tt.ptr<f32>>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%20, %17) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

