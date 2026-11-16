// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128xf32>, i32, i32, i32, i32, i32, i32) -> tensor<128xf8E5M2>, sym_name = "trunc_rtne"}> ({
  ^bb0(%arg9: tensor<128xf32>, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32, %arg15: i32):
    %3 = "tensor.empty"() : () -> tensor<128xf8E5M2>
    %4 = "linalg.generic"(%arg9, %3) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: f32, %arg17: f8E5M2):
      %5 = "arith.truncf"(%arg16) : (f32) -> f8E5M2
      "linalg.yield"(%5) : (f8E5M2) -> ()
    }) : (tensor<128xf32>, tensor<128xf8E5M2>) -> tensor<128xf8E5M2>
    "func.return"(%4) : (tensor<128xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<128xf8E4M3FN>, i32, i32, i32, i32, i32, i32) -> tensor<128xf32>, sym_name = "ext"}> ({
  ^bb0(%arg0: tensor<128xf8E4M3FN>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32):
    %0 = "tensor.empty"() : () -> tensor<128xf32>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: f8E4M3FN, %arg8: f32):
      %2 = "arith.extf"(%arg7) : (f8E4M3FN) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (tensor<128xf8E4M3FN>, tensor<128xf32>) -> tensor<128xf32>
    "func.return"(%1) : (tensor<128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

