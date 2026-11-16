// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (tensor<4x8xf32>, i32) -> tensor<4x8xf32>, sym_name = "short_term_right", sym_visibility = "public"}> ({
  ^bb0(%arg0: tensor<4x8xf32>, %arg1: i32):
    %0 = "arith.constant"() <{value = dense<7.000000e+00> : tensor<8xf32>}> : () -> tensor<8xf32>
    %1 = "arith.constant"() <{value = dense<6.000000e+00> : tensor<8xf32>}> : () -> tensor<8xf32>
    %2 = "arith.constant"() <{value = dense<5.000000e+00> : tensor<8xf32>}> : () -> tensor<8xf32>
    %3 = "arith.constant"() <{value = dense<4.000000e+00> : tensor<8xf32>}> : () -> tensor<8xf32>
    %4 = "arith.constant"() <{value = dense<2.000000e+00> : tensor<8xf32>}> : () -> tensor<8xf32>
    %5 = "arith.constant"() <{value = dense<-2.000000e+00> : tensor<8xf32>}> : () -> tensor<8xf32>
    %6 = "arith.constant"() <{value = dense<1.000000e+00> : tensor<8xf32>}> : () -> tensor<8xf32>
    %7 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<8xf32>}> : () -> tensor<8xf32>
    %8 = "arith.constant"() <{value = dense<3.000000e+00> : tensor<8xf32>}> : () -> tensor<8xf32>
    %9 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<4x8xf32>}> : () -> tensor<4x8xf32>
    %10 = "tt.make_range"() <{end = 8 : i32, start = 0 : i32}> : () -> tensor<8xi32>
    %11 = "arith.sitofp"(%10) : (tensor<8xi32>) -> tensor<8xf32>
    %12 = "arith.cmpf"(%11, %6) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xi1>
    %13 = "arith.select"(%12, %5, %7) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %14 = "arith.addf"(%13, %8) <{fastmath = #arith.fastmath<none>}> : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %15 = "arith.cmpf"(%11, %4) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xi1>
    %16 = "arith.select"(%15, %6, %7) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %17 = "arith.addf"(%14, %16) <{fastmath = #arith.fastmath<none>}> : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %18 = "arith.cmpf"(%11, %8) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xi1>
    %19 = "arith.select"(%18, %6, %7) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %20 = "arith.addf"(%17, %19) <{fastmath = #arith.fastmath<none>}> : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %21 = "arith.cmpf"(%11, %3) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xi1>
    %22 = "arith.select"(%21, %6, %7) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %23 = "arith.addf"(%20, %22) <{fastmath = #arith.fastmath<none>}> : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %24 = "arith.cmpf"(%11, %2) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xi1>
    %25 = "arith.select"(%24, %6, %7) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %26 = "arith.addf"(%23, %25) <{fastmath = #arith.fastmath<none>}> : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %27 = "arith.cmpf"(%11, %1) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xi1>
    %28 = "arith.select"(%27, %6, %7) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %29 = "arith.addf"(%26, %28) <{fastmath = #arith.fastmath<none>}> : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %30 = "arith.cmpf"(%11, %0) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xi1>
    %31 = "arith.select"(%30, %6, %7) : (tensor<8xi1>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %32 = "arith.addf"(%29, %31) <{fastmath = #arith.fastmath<none>}> : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %33 = "tt.expand_dims"(%32) <{axis = 0 : i32}> : (tensor<8xf32>) -> tensor<1x8xf32>
    %34 = "tt.broadcast"(%33) : (tensor<1x8xf32>) -> tensor<4x8xf32>
    %35 = "arith.sitofp"(%arg1) : (i32) -> f32
    %36 = "tt.splat"(%35) : (f32) -> tensor<4x8xf32>
    %37 = "arith.cmpf"(%34, %36) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (tensor<4x8xf32>, tensor<4x8xf32>) -> tensor<4x8xi1>
    %38 = "arith.select"(%37, %arg0, %9) : (tensor<4x8xi1>, tensor<4x8xf32>, tensor<4x8xf32>) -> tensor<4x8xf32>
    "tt.return"(%38) : (tensor<4x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

