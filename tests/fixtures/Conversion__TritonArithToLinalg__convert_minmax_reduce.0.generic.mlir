"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<i32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "minmax_sgt"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32):
    %0 = "arith.constant"() <{value = -2147483648 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "tensor.empty"() : () -> tensor<4096xi32>
    %3 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: i32, %arg12: i32):
      "linalg.yield"(%arg11) : (i32) -> ()
    }) : (i32, tensor<4096xi32>) -> tensor<4096xi32>
    %4 = "tensor.empty"() : () -> tensor<i32>
    %5 = "linalg.fill"(%0, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: i32, %arg10: i32):
      "linalg.yield"(%arg9) : (i32) -> ()
    }) : (i32, tensor<i32>) -> tensor<i32>
    %6 = "linalg.reduce"(%3, %5) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg7: i32, %arg8: i32):
      %8 = "arith.maxsi"(%arg7, %arg8) : (i32, i32) -> i32
      "linalg.yield"(%8) : (i32) -> ()
    }) : (tensor<4096xi32>, tensor<i32>) -> tensor<i32>
    %7 = "tensor.extract"(%6) : (tensor<i32>) -> i32
    "tt.store"(%arg0, %7) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<i32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "minmax_ugt"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "tensor.empty"() : () -> tensor<4096xi32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: i32, %arg12: i32):
      "linalg.yield"(%arg11) : (i32) -> ()
    }) : (i32, tensor<4096xi32>) -> tensor<4096xi32>
    %3 = "tensor.empty"() : () -> tensor<i32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: i32, %arg10: i32):
      "linalg.yield"(%arg9) : (i32) -> ()
    }) : (i32, tensor<i32>) -> tensor<i32>
    %5 = "linalg.reduce"(%2, %4) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg7: i32, %arg8: i32):
      %7 = "arith.maxui"(%arg7, %arg8) : (i32, i32) -> i32
      "linalg.yield"(%7) : (i32) -> ()
    }) : (tensor<4096xi32>, tensor<i32>) -> tensor<i32>
    %6 = "tensor.extract"(%5) : (tensor<i32>) -> i32
    "tt.store"(%arg0, %6) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<i32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "minmax_slt"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32):
    %0 = "arith.constant"() <{value = 2147483647 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "tensor.empty"() : () -> tensor<4096xi32>
    %3 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: i32, %arg12: i32):
      "linalg.yield"(%arg11) : (i32) -> ()
    }) : (i32, tensor<4096xi32>) -> tensor<4096xi32>
    %4 = "tensor.empty"() : () -> tensor<i32>
    %5 = "linalg.fill"(%0, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: i32, %arg10: i32):
      "linalg.yield"(%arg9) : (i32) -> ()
    }) : (i32, tensor<i32>) -> tensor<i32>
    %6 = "linalg.reduce"(%3, %5) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg7: i32, %arg8: i32):
      %8 = "arith.minsi"(%arg7, %arg8) : (i32, i32) -> i32
      "linalg.yield"(%8) : (i32) -> ()
    }) : (tensor<4096xi32>, tensor<i32>) -> tensor<i32>
    %7 = "tensor.extract"(%6) : (tensor<i32>) -> i32
    "tt.store"(%arg0, %7) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<i32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "minmax_ult"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32):
    %0 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "tensor.empty"() : () -> tensor<4096xi32>
    %3 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: i32, %arg12: i32):
      "linalg.yield"(%arg11) : (i32) -> ()
    }) : (i32, tensor<4096xi32>) -> tensor<4096xi32>
    %4 = "tensor.empty"() : () -> tensor<i32>
    %5 = "linalg.fill"(%0, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: i32, %arg10: i32):
      "linalg.yield"(%arg9) : (i32) -> ()
    }) : (i32, tensor<i32>) -> tensor<i32>
    %6 = "linalg.reduce"(%3, %5) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg7: i32, %arg8: i32):
      %8 = "arith.minui"(%arg7, %arg8) : (i32, i32) -> i32
      "linalg.yield"(%8) : (i32) -> ()
    }) : (tensor<4096xi32>, tensor<i32>) -> tensor<i32>
    %7 = "tensor.extract"(%6) : (tensor<i32>) -> i32
    "tt.store"(%arg0, %7) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

