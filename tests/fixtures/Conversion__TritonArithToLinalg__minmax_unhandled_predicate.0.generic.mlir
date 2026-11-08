#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8xi32>, tensor<8xi32>, i32, i32, i32, i32, i32, i32) -> tensor<8xi32>, sym_name = "slt_is_min"}> ({
  ^bb0(%arg60: tensor<8xi32>, %arg61: tensor<8xi32>, %arg62: i32, %arg63: i32, %arg64: i32, %arg65: i32, %arg66: i32, %arg67: i32):
    %20 = "linalg.generic"(%arg60, %arg61, %arg60) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg68: i32, %arg69: i32, %arg70: i32):
      %21 = "arith.minsi"(%arg68, %arg69) : (i32, i32) -> i32
      "linalg.yield"(%21) : (i32) -> ()
    }) : (tensor<8xi32>, tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    "func.return"(%20) : (tensor<8xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8xi32>, tensor<8xi32>, i32, i32, i32, i32, i32, i32) -> tensor<8xi32>, sym_name = "ule_stays"}> ({
  ^bb0(%arg45: tensor<8xi32>, %arg46: tensor<8xi32>, %arg47: i32, %arg48: i32, %arg49: i32, %arg50: i32, %arg51: i32, %arg52: i32):
    %15 = "tensor.empty"() : () -> tensor<8xi1>
    %16 = "linalg.generic"(%arg45, %arg46, %15) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg57: i32, %arg58: i32, %arg59: i1):
      %19 = "arith.cmpi"(%arg57, %arg58) <{predicate = 7 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%19) : (i1) -> ()
    }) : (tensor<8xi32>, tensor<8xi32>, tensor<8xi1>) -> tensor<8xi1>
    %17 = "linalg.generic"(%16, %arg45, %arg46, %arg45) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg53: i1, %arg54: i32, %arg55: i32, %arg56: i32):
      %18 = "arith.select"(%arg53, %arg54, %arg55) : (i1, i32, i32) -> i32
      "linalg.yield"(%18) : (i32) -> ()
    }) : (tensor<8xi1>, tensor<8xi32>, tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    "func.return"(%17) : (tensor<8xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8xi64>, tensor<8xi64>, i32, i32, i32, i32, i32, i32) -> tensor<8xi64>, sym_name = "sge_stays"}> ({
  ^bb0(%arg30: tensor<8xi64>, %arg31: tensor<8xi64>, %arg32: i32, %arg33: i32, %arg34: i32, %arg35: i32, %arg36: i32, %arg37: i32):
    %10 = "tensor.empty"() : () -> tensor<8xi1>
    %11 = "linalg.generic"(%arg30, %arg31, %10) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg42: i64, %arg43: i64, %arg44: i1):
      %14 = "arith.cmpi"(%arg42, %arg43) <{predicate = 5 : i64}> : (i64, i64) -> i1
      "linalg.yield"(%14) : (i1) -> ()
    }) : (tensor<8xi64>, tensor<8xi64>, tensor<8xi1>) -> tensor<8xi1>
    %12 = "linalg.generic"(%11, %arg30, %arg31, %arg30) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg38: i1, %arg39: i64, %arg40: i64, %arg41: i64):
      %13 = "arith.select"(%arg38, %arg39, %arg40) : (i1, i64, i64) -> i64
      "linalg.yield"(%13) : (i64) -> ()
    }) : (tensor<8xi1>, tensor<8xi64>, tensor<8xi64>, tensor<8xi64>) -> tensor<8xi64>
    "func.return"(%12) : (tensor<8xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8xf32>, tensor<8xf32>, i32, i32, i32, i32, i32, i32) -> tensor<8xf32>, sym_name = "une_stays"}> ({
  ^bb0(%arg15: tensor<8xf32>, %arg16: tensor<8xf32>, %arg17: i32, %arg18: i32, %arg19: i32, %arg20: i32, %arg21: i32, %arg22: i32):
    %5 = "tensor.empty"() : () -> tensor<8xi1>
    %6 = "linalg.generic"(%arg15, %arg16, %5) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg27: f32, %arg28: f32, %arg29: i1):
      %9 = "arith.cmpf"(%arg27, %arg28) <{fastmath = #arith.fastmath<none>, predicate = 13 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%9) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %7 = "linalg.generic"(%6, %arg15, %arg16, %arg15) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg23: i1, %arg24: f32, %arg25: f32, %arg26: f32):
      %8 = "arith.select"(%arg23, %arg24, %arg25) : (i1, f32, f32) -> f32
      "linalg.yield"(%8) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    "func.return"(%7) : (tensor<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8xf32>, tensor<8xf32>, i32, i32, i32, i32, i32, i32) -> tensor<8xf32>, sym_name = "ugt_stays"}> ({
  ^bb0(%arg0: tensor<8xf32>, %arg1: tensor<8xf32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "tensor.empty"() : () -> tensor<8xi1>
    %1 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32, %arg14: i1):
      %4 = "arith.cmpf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>, predicate = 9 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%4) : (i1) -> ()
    }) : (tensor<8xf32>, tensor<8xf32>, tensor<8xi1>) -> tensor<8xi1>
    %2 = "linalg.generic"(%1, %arg0, %arg1, %arg0) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg8: i1, %arg9: f32, %arg10: f32, %arg11: f32):
      %3 = "arith.select"(%arg8, %arg9, %arg10) : (i1, f32, f32) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    "func.return"(%2) : (tensor<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

