"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>) -> (), sym_name = "maxnumf"}> ({
  ^bb0(%arg0: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "tensor.empty"() : () -> tensor<4096xf32>
    %3 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
    %4 = "tensor.empty"() : () -> tensor<f32>
    %5 = "linalg.fill"(%0, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %6 = "linalg.reduce"(%3, %5) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %8 = "arith.maxnumf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%8) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<f32>) -> tensor<f32>
    %7 = "tensor.extract"(%6) : (tensor<f32>) -> f32
    "tt.store"(%arg0, %7) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>) -> (), sym_name = "minnumf"}> ({
  ^bb0(%arg0: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "tensor.empty"() : () -> tensor<4096xf32>
    %3 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
    %4 = "tensor.empty"() : () -> tensor<f32>
    %5 = "linalg.fill"(%0, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %6 = "linalg.reduce"(%3, %5) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %8 = "arith.minnumf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%8) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<f32>) -> tensor<f32>
    %7 = "tensor.extract"(%6) : (tensor<f32>) -> f32
    "tt.store"(%arg0, %7) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

