"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> f32, sym_name = "_sum_combine__fp32"}> ({
  ^bb0(%arg2: memref<?xf32>):
    %3 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> f32, sym_name = "test"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>):
    %0 = "func.call"(%arg0) <{callee = @_sum_combine__fp32}> : (memref<?xf32>) -> f32
    %1 = "func.call"(%arg1) <{callee = @_sum_combine__fp32}> : (memref<?xf32>) -> f32
    %2 = "arith.addf"(%0, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

