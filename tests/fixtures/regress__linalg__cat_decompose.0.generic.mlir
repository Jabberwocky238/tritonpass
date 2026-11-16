"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>, tensor<4xf32>) -> tensor<8xf32>, sym_name = "cat1d"}> ({
  ^bb0(%arg2: tensor<4xf32>, %arg3: tensor<4xf32>):
    %3 = "tensor.empty"() : () -> tensor<8xf32>
    %4 = "tensor.insert_slice"(%arg2, %3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<8xf32>) -> tensor<8xf32>
    %5 = "tensor.insert_slice"(%arg3, %4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 4>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<8xf32>) -> tensor<8xf32>
    "func.return"(%5) : (tensor<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x2xi32>, tensor<4x2xi32>) -> tensor<8x2xi32>, sym_name = "cat2d"}> ({
  ^bb0(%arg0: tensor<4x2xi32>, %arg1: tensor<4x2xi32>):
    %0 = "tensor.empty"() : () -> tensor<8x2xi32>
    %1 = "tensor.insert_slice"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 2>, static_strides = array<i64: 1, 1>}> : (tensor<4x2xi32>, tensor<8x2xi32>) -> tensor<8x2xi32>
    %2 = "tensor.insert_slice"(%arg1, %1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 4, 0>, static_sizes = array<i64: 4, 2>, static_strides = array<i64: 1, 1>}> : (tensor<4x2xi32>, tensor<8x2xi32>) -> tensor<8x2xi32>
    "func.return"(%2) : (tensor<8x2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

