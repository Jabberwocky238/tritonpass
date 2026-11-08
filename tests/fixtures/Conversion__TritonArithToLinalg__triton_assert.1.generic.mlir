#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "assert_tensor_1d"}> ({
    %2 = "tensor.empty"() : () -> tensor<4xi1>
    "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 0>}> ({
    ^bb0(%arg2: i1):
      "cf.assert"(%arg2) <{msg = "Assertion `message` failed"}> : (i1) -> ()
      "linalg.yield"() : () -> ()
    }) : (tensor<4xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "assert_tensor_2d"}> ({
    %1 = "tensor.empty"() : () -> tensor<4x4xi1>
    "linalg.generic"(%1) <{indexing_maps = [#map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 0>}> ({
    ^bb0(%arg1: i1):
      "cf.assert"(%arg1) <{msg = "Assertion `message` failed"}> : (i1) -> ()
      "linalg.yield"() : () -> ()
    }) : (tensor<4x4xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "assert_tensor_3d"}> ({
    %0 = "tensor.empty"() : () -> tensor<4x4x4xi1>
    "linalg.generic"(%0) <{indexing_maps = [#map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 0>}> ({
    ^bb0(%arg0: i1):
      "cf.assert"(%arg0) <{msg = "Assertion `message` failed"}> : (i1) -> ()
      "linalg.yield"() : () -> ()
    }) : (tensor<4x4x4xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

