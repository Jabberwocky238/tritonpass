"builtin.module"() ({
  "func.func"() <{function_type = (f32, tensor<8x16x!tt.ptr<f32>>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "sum_axis0"}> ({
  ^bb0(%arg0: f32, %arg1: tensor<8x16x!tt.ptr<f32>>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<4x8x16xf32>
    %2 = "linalg.fill"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, tensor<4x8x16xf32>) -> tensor<4x8x16xf32>
    %3 = "tensor.empty"() : () -> tensor<8x16xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (f32, tensor<8x16xf32>) -> tensor<8x16xf32>
    %5 = "linalg.reduce"(%2, %4) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %6 = "arith.addf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<4x8x16xf32>, tensor<8x16xf32>) -> tensor<8x16xf32>
    "tt.store"(%arg1, %5) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<8x16x!tt.ptr<f32>>, tensor<8x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, tensor<4x16x!tt.ptr<f32>>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "sum_axis1"}> ({
  ^bb0(%arg0: f32, %arg1: tensor<4x16x!tt.ptr<f32>>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<4x8x16xf32>
    %2 = "linalg.fill"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, tensor<4x8x16xf32>) -> tensor<4x8x16xf32>
    %3 = "tensor.empty"() : () -> tensor<4x16xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (f32, tensor<4x16xf32>) -> tensor<4x16xf32>
    %5 = "linalg.reduce"(%2, %4) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %6 = "arith.addf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<4x8x16xf32>, tensor<4x16xf32>) -> tensor<4x16xf32>
    "tt.store"(%arg1, %5) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<4x16x!tt.ptr<f32>>, tensor<4x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, tensor<4x8x!tt.ptr<f32>>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "sum_axis2"}> ({
  ^bb0(%arg0: f32, %arg1: tensor<4x8x!tt.ptr<f32>>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<4x8x16xf32>
    %2 = "linalg.fill"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, tensor<4x8x16xf32>) -> tensor<4x8x16xf32>
    %3 = "tensor.empty"() : () -> tensor<4x8xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (f32, tensor<4x8xf32>) -> tensor<4x8xf32>
    %5 = "linalg.reduce"(%2, %4) <{dimensions = array<i64: 2>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %6 = "arith.addf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<4x8x16xf32>, tensor<4x8xf32>) -> tensor<4x8xf32>
    "tt.store"(%arg1, %5) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<4x8x!tt.ptr<f32>>, tensor<4x8xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, tensor<4x!tt.ptr<f32>>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "sum_rows"}> ({
  ^bb0(%arg0: f32, %arg1: tensor<4x!tt.ptr<f32>>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<4x128xf32>
    %2 = "linalg.fill"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, tensor<4x128xf32>) -> tensor<4x128xf32>
    %3 = "tensor.empty"() : () -> tensor<4xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %5 = "linalg.reduce"(%2, %4) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %6 = "arith.addf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<4x128xf32>, tensor<4xf32>) -> tensor<4xf32>
    "tt.store"(%arg1, %5) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<4x!tt.ptr<f32>>, tensor<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

