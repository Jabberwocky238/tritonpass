"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<i32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "addi"}> ({
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
      %7 = "arith.addi"(%arg7, %arg8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%7) : (i32) -> ()
    }) : (tensor<4096xi32>, tensor<i32>) -> tensor<i32>
    %6 = "tensor.extract"(%5) : (tensor<i32>) -> i32
    "tt.store"(%arg0, %6) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

