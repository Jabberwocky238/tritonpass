#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>, sym_name = "slt_is_min"}> ({
  ^bb0(%arg36: tensor<8xi32>, %arg37: tensor<8xi32>):
    %20 = "linalg.generic"(%arg36, %arg37, %arg36) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg38: i32, %arg39: i32, %arg40: i32):
      %21 = "arith.minsi"(%arg38, %arg39) : (i32, i32) -> i32
      "linalg.yield"(%21) : (i32) -> ()
    }) : (tensor<8xi32>, tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    "func.return"(%20) : (tensor<8xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>, sym_name = "ule_stays"}> ({
  ^bb0(%arg27: tensor<8xi32>, %arg28: tensor<8xi32>):
    %15 = "tensor.empty"() : () -> tensor<8xi1>
    %16 = "linalg.generic"(%arg27, %arg28, %15) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg33: i32, %arg34: i32, %arg35: i1):
      %19 = "arith.cmpi"(%arg33, %arg34) <{predicate = 7 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%19) : (i1) -> ()
    }) : (tensor<8xi32>, tensor<8xi32>, tensor<8xi1>) -> tensor<8xi1>
    %17 = "linalg.generic"(%16, %arg27, %arg28, %arg27) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg29: i1, %arg30: i32, %arg31: i32, %arg32: i32):
      %18 = "arith.select"(%arg29, %arg30, %arg31) : (i1, i32, i32) -> i32
      "linalg.yield"(%18) : (i32) -> ()
    }) : (tensor<8xi1>, tensor<8xi32>, tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    "func.return"(%17) : (tensor<8xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8xi64>, tensor<8xi64>) -> tensor<8xi64>, sym_name = "sge_stays"}> ({
  ^bb0(%arg18: tensor<8xi64>, %arg19: tensor<8xi64>):
    %10 = "tensor.empty"() : () -> tensor<8xi1>
    %11 = "linalg.generic"(%arg18, %arg19, %10) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg24: i64, %arg25: i64, %arg26: i1):
      %14 = "arith.cmpi"(%arg24, %arg25) <{predicate = 5 : i64}> : (i64, i64) -> i1
      "linalg.yield"(%14) : (i1) -> ()
    }) : (tensor<8xi64>, tensor<8xi64>, tensor<8xi1>) -> tensor<8xi1>
    %12 = "linalg.generic"(%11, %arg18, %arg19, %arg18) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg20: i1, %arg21: i64, %arg22: i64, %arg23: i64):
      %13 = "arith.select"(%arg20, %arg21, %arg22) : (i1, i64, i64) -> i64
      "linalg.yield"(%13) : (i64) -> ()
    }) : (tensor<8xi1>, tensor<8xi64>, tensor<8xi64>, tensor<8xi64>) -> tensor<8xi64>
    "func.return"(%12) : (tensor<8xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>, sym_name = "une_stays"}> ({
  ^bb0(%arg9: tensor<8xf32>, %arg10: tensor<8xf32>):
    %5 = "tensor.empty"() : () -> tensor<8xi1>
    %6 = "linalg.generic"(%arg9, %arg10, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32, %arg17: i1):
      %9 = "arith.cmpf"(%arg15, %arg16) <{fastmath = #arith.fastmath<none>, predicate = 13 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%9) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %7 = "linalg.generic"(%6, %arg9, %arg10, %arg9) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg11: i1, %arg12: f32, %arg13: f32, %arg14: f32):
      %8 = "arith.select"(%arg11, %arg12, %arg13) : (i1, f32, f32) -> f32
      "linalg.yield"(%8) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    "func.return"(%7) : (tensor<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>, sym_name = "ugt_stays"}> ({
  ^bb0(%arg0: tensor<8xf32>, %arg1: tensor<8xf32>):
    %0 = "tensor.empty"() : () -> tensor<8xi1>
    %1 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: i1):
      %4 = "arith.cmpf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>, predicate = 9 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%4) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %2 = "linalg.generic"(%1, %arg0, %arg1, %arg0) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg2: i1, %arg3: f32, %arg4: f32, %arg5: f32):
      %3 = "arith.select"(%arg2, %arg3, %arg4) : (i1, f32, f32) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    "func.return"(%2) : (tensor<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

