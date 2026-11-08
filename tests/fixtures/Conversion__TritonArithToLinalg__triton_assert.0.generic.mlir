#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i32, i32, i32, i32) -> (), sym_name = "assert_tensor_1d"}> ({
  ^bb0(%arg14: i32, %arg15: i32, %arg16: i32, %arg17: i32, %arg18: i32, %arg19: i32):
    %2 = "tensor.empty"() : () -> tensor<4xi1>
    "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 0>}> ({
    ^bb0(%arg20: i1):
      "cf.assert"(%arg20) <{msg = "Assertion `message` failed"}> : (i1) -> ()
      "linalg.yield"() : () -> ()
    }) : (tensor<4xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, i32, i32, i32, i32) -> (), sym_name = "assert_tensor_2d"}> ({
  ^bb0(%arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32):
    %1 = "tensor.empty"() : () -> tensor<4x4xi1>
    "linalg.generic"(%1) <{indexing_maps = [#map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 0>}> ({
    ^bb0(%arg13: i1):
      "cf.assert"(%arg13) <{msg = "Assertion `message` failed"}> : (i1) -> ()
      "linalg.yield"() : () -> ()
    }) : (tensor<4x4xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, i32, i32, i32, i32) -> (), sym_name = "assert_tensor_3d"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "tensor.empty"() : () -> tensor<4x4x4xi1>
    "linalg.generic"(%0) <{indexing_maps = [#map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 0>}> ({
    ^bb0(%arg6: i1):
      "cf.assert"(%arg6) <{msg = "Assertion `message` failed"}> : (i1) -> ()
      "linalg.yield"() : () -> ()
    }) : (tensor<4x4x4xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

