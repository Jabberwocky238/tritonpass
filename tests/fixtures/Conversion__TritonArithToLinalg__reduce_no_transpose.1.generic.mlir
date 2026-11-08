"builtin.module"() ({
  "func.func"() <{function_type = (f32, tensor<8x16x!tt.ptr<f32>>) -> (), sym_name = "sum_axis0"}> ({
  ^bb0(%arg0: f32, %arg1: tensor<8x16x!tt.ptr<f32>>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<4x8x16xf32>
    %2 = "linalg.fill"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<4x8x16xf32>) -> tensor<4x8x16xf32>
    %3 = "tensor.empty"() : () -> tensor<8x16xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<8x16xf32>) -> tensor<8x16xf32>
    %5 = "linalg.reduce"(%2, %4) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %6 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<4x8x16xf32>, tensor<8x16xf32>) -> tensor<8x16xf32>
    "tt.store"(%arg1, %5) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<8x16x!tt.ptr<f32>>, tensor<8x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, tensor<4x16x!tt.ptr<f32>>) -> (), sym_name = "sum_axis1"}> ({
  ^bb0(%arg0: f32, %arg1: tensor<4x16x!tt.ptr<f32>>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<4x8x16xf32>
    %2 = "linalg.fill"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<4x8x16xf32>) -> tensor<4x8x16xf32>
    %3 = "tensor.empty"() : () -> tensor<4x16xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<4x16xf32>) -> tensor<4x16xf32>
    %5 = "linalg.reduce"(%2, %4) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %6 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<4x8x16xf32>, tensor<4x16xf32>) -> tensor<4x16xf32>
    "tt.store"(%arg1, %5) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<4x16x!tt.ptr<f32>>, tensor<4x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, tensor<4x8x!tt.ptr<f32>>) -> (), sym_name = "sum_axis2"}> ({
  ^bb0(%arg0: f32, %arg1: tensor<4x8x!tt.ptr<f32>>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<4x8x16xf32>
    %2 = "linalg.fill"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<4x8x16xf32>) -> tensor<4x8x16xf32>
    %3 = "tensor.empty"() : () -> tensor<4x8xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<4x8xf32>) -> tensor<4x8xf32>
    %5 = "linalg.reduce"(%2, %4) <{dimensions = array<i64: 2>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %6 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<4x8x16xf32>, tensor<4x8xf32>) -> tensor<4x8xf32>
    "tt.store"(%arg1, %5) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<4x8x!tt.ptr<f32>>, tensor<4x8xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, tensor<4x!tt.ptr<f32>>) -> (), sym_name = "sum_rows"}> ({
  ^bb0(%arg0: f32, %arg1: tensor<4x!tt.ptr<f32>>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<4x128xf32>
    %2 = "linalg.fill"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<4x128xf32>) -> tensor<4x128xf32>
    %3 = "tensor.empty"() : () -> tensor<4xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %5 = "linalg.reduce"(%2, %4) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %6 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<4x128xf32>, tensor<4xf32>) -> tensor<4xf32>
    "tt.store"(%arg1, %5) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<4x!tt.ptr<f32>>, tensor<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

