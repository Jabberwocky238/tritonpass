"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, i32, i32, i32, i32, i32, i32) -> f32, sym_name = "_sum_combine__fp32"}> ({
  ^bb0(%arg8: memref<?xf32>, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32):
    %3 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32, i32, i32, i32, i32) -> f32, sym_name = "test"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "func.call"(%arg0, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7) <{callee = @_sum_combine__fp32}> : (memref<?xf32>, i32, i32, i32, i32, i32, i32) -> f32
    %1 = "func.call"(%arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7) <{callee = @_sum_combine__fp32}> : (memref<?xf32>, i32, i32, i32, i32, i32, i32) -> f32
    %2 = "arith.addf"(%0, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

