"builtin.module"() ({
  "tt.func"() <{function_type = (tensor<4xf32>, i32) -> tensor<4xf32>, sym_name = "divide_overflow", sym_visibility = "public"}> ({
  ^bb0(%arg0: tensor<4xf32>, %arg1: i32):
    %0 = "arith.constant"() <{value = dense<-4.61168602E+18> : tensor<4xf32>}> : () -> tensor<4xf32>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<4xf32>}> : () -> tensor<4xf32>
    %2 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %3 = "arith.sitofp"(%2) : (tensor<4xi32>) -> tensor<4xf32>
    %4 = "arith.mulf"(%3, %0) <{fastmath = #arith.fastmath<none>}> : (tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %5 = "arith.addf"(%4, %1) <{fastmath = #arith.fastmath<none>}> : (tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %6 = "arith.sitofp"(%arg1) : (i32) -> f32
    %7 = "tt.splat"(%6) : (f32) -> tensor<4xf32>
    %8 = "arith.cmpf"(%5, %7) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (tensor<4xf32>, tensor<4xf32>) -> tensor<4xi1>
    %9 = "arith.select"(%8, %arg0, %1) : (tensor<4xi1>, tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    "tt.return"(%9) : (tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (tensor<4xf32>, i32) -> tensor<4xf32>, sym_name = "multiply_overflow", sym_visibility = "public"}> ({
  ^bb0(%arg0: tensor<4xf32>, %arg1: i32):
    %0 = "arith.constant"() <{value = dense<4.61168602E+18> : tensor<4xf32>}> : () -> tensor<4xf32>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<4xf32>}> : () -> tensor<4xf32>
    %2 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %3 = "arith.sitofp"(%2) : (tensor<4xi32>) -> tensor<4xf32>
    %4 = "arith.mulf"(%3, %0) <{fastmath = #arith.fastmath<none>}> : (tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %5 = "arith.addf"(%4, %1) <{fastmath = #arith.fastmath<none>}> : (tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %6 = "arith.sitofp"(%arg1) : (i32) -> f32
    %7 = "tt.splat"(%6) : (f32) -> tensor<4xf32>
    %8 = "arith.cmpf"(%5, %7) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (tensor<4xf32>, tensor<4xf32>) -> tensor<4xi1>
    %9 = "arith.select"(%8, %arg0, %1) : (tensor<4xi1>, tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    "tt.return"(%9) : (tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

