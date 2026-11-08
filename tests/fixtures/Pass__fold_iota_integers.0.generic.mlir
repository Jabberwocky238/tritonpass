"builtin.module"() ({
  "tt.func"() <{function_type = (tensor<16x16xf32>, i32, i32) -> tensor<16x16xf32>, sym_name = "causal", sym_visibility = "public"}> ({
  ^bb0(%arg0: tensor<16x16xf32>, %arg1: i32, %arg2: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = dense<1.200000e+01> : tensor<16xf32>}> : () -> tensor<16xf32>
    %2 = "arith.constant"() <{value = dense<8.000000e+00> : tensor<16xf32>}> : () -> tensor<16xf32>
    %3 = "arith.constant"() <{value = dense<-1.000000e+00> : tensor<16xf32>}> : () -> tensor<16xf32>
    %4 = "arith.constant"() <{value = dense<4.000000e+00> : tensor<16xf32>}> : () -> tensor<16xf32>
    %5 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<16xf32>}> : () -> tensor<16xf32>
    %6 = "arith.constant"() <{value = dense<0xFF800000> : tensor<16x16xf32>}> : () -> tensor<16x16xf32>
    %7 = "arith.subi"(%arg2, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %8 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %9 = "arith.sitofp"(%8) : (tensor<16xi32>) -> tensor<16xf32>
    %10 = "arith.addf"(%9, %5) <{fastmath = #arith.fastmath<none>}> : (tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %11 = "tt.expand_dims"(%10) <{axis = 0 : i32}> : (tensor<16xf32>) -> tensor<1x16xf32>
    %12 = "tt.broadcast"(%11) : (tensor<1x16xf32>) -> tensor<16x16xf32>
    %13 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %14 = "arith.sitofp"(%13) : (tensor<16xi32>) -> tensor<16xf32>
    %15 = "arith.cmpf"(%14, %4) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (tensor<16xf32>, tensor<16xf32>) -> tensor<16xi1>
    %16 = "arith.select"(%15, %3, %5) : (tensor<16xi1>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %17 = "arith.addf"(%16, %5) <{fastmath = #arith.fastmath<none>}> : (tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %18 = "arith.cmpf"(%14, %2) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (tensor<16xf32>, tensor<16xf32>) -> tensor<16xi1>
    %19 = "arith.select"(%18, %3, %5) : (tensor<16xi1>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %20 = "arith.addf"(%17, %19) <{fastmath = #arith.fastmath<none>}> : (tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %21 = "arith.cmpf"(%14, %1) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (tensor<16xf32>, tensor<16xf32>) -> tensor<16xi1>
    %22 = "arith.select"(%21, %3, %5) : (tensor<16xi1>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %23 = "arith.addf"(%20, %22) <{fastmath = #arith.fastmath<none>}> : (tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %24 = "tt.expand_dims"(%23) <{axis = 1 : i32}> : (tensor<16xf32>) -> tensor<16x1xf32>
    %25 = "tt.broadcast"(%24) : (tensor<16x1xf32>) -> tensor<16x16xf32>
    %26 = "arith.addf"(%12, %25) <{fastmath = #arith.fastmath<none>}> : (tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
    %27 = "arith.subi"(%0, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %28 = "arith.sitofp"(%27) : (i32) -> f32
    %29 = "tt.splat"(%28) : (f32) -> tensor<16x16xf32>
    %30 = "arith.cmpf"(%26, %29) <{fastmath = #arith.fastmath<none>, predicate = 5 : i64}> : (tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xi1>
    %31 = "arith.select"(%30, %arg0, %6) : (tensor<16x16xi1>, tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
    "tt.return"(%31) : (tensor<16x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (tensor<16x!tt.ptr<f32>>, i32) -> tensor<16xf32>, sym_name = "memory_mask_untouched", sym_visibility = "public"}> ({
  ^bb0(%arg0: tensor<16x!tt.ptr<f32>>, %arg1: i32):
    %0 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %1 = "tt.splat"(%arg1) : (i32) -> tensor<16xi32>
    %2 = "arith.cmpi"(%0, %1) <{predicate = 2 : i64}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi1>
    %3 = "tt.load"(%arg0, %2) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<16x!tt.ptr<f32>>, tensor<16xi1>) -> tensor<16xf32>
    "tt.return"(%3) : (tensor<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (tensor<16x!tt.ptr<f32>>, i32) -> tensor<16xf32>, sym_name = "shared_mask", sym_visibility = "public"}> ({
  ^bb0(%arg0: tensor<16x!tt.ptr<f32>>, %arg1: i32):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<16xf32>}> : () -> tensor<16xf32>
    %1 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %2 = "tt.splat"(%arg1) : (i32) -> tensor<16xi32>
    %3 = "arith.cmpi"(%1, %2) <{predicate = 2 : i64}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi1>
    %4 = "tt.load"(%arg0, %3) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<16x!tt.ptr<f32>>, tensor<16xi1>) -> tensor<16xf32>
    %5 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %6 = "arith.sitofp"(%5) : (tensor<16xi32>) -> tensor<16xf32>
    %7 = "arith.addf"(%6, %0) <{fastmath = #arith.fastmath<none>}> : (tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    %8 = "arith.sitofp"(%arg1) : (i32) -> f32
    %9 = "tt.splat"(%8) : (f32) -> tensor<16xf32>
    %10 = "arith.cmpf"(%7, %9) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (tensor<16xf32>, tensor<16xf32>) -> tensor<16xi1>
    %11 = "arith.select"(%10, %4, %0) : (tensor<16xi1>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    "tt.return"(%11) : (tensor<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (tensor<16xf32>, i32) -> tensor<16xf32>, sym_name = "product_of_ranges", sym_visibility = "public"}> ({
  ^bb0(%arg0: tensor<16xf32>, %arg1: i32):
    %0 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %1 = "arith.muli"(%0, %0) <{overflowFlags = #arith.overflow<none>}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %2 = "tt.splat"(%arg1) : (i32) -> tensor<16xi32>
    %3 = "arith.cmpi"(%1, %2) <{predicate = 2 : i64}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi1>
    %4 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<16xf32>}> : () -> tensor<16xf32>
    %5 = "arith.cmpi"(%1, %2) <{predicate = 2 : i64}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi1>
    %6 = "arith.select"(%3, %arg0, %4) : (tensor<16xi1>, tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    "tt.return"(%6) : (tensor<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (tensor<64xf32>, i32) -> tensor<64xf32>, sym_name = "too_many_steps", sym_visibility = "public"}> ({
  ^bb0(%arg0: tensor<64xf32>, %arg1: i32):
    %0 = "tt.make_range"() <{end = 64 : i32, start = 0 : i32}> : () -> tensor<64xi32>
    %1 = "arith.constant"() <{value = dense<2> : tensor<64xi32>}> : () -> tensor<64xi32>
    %2 = "arith.remsi"(%0, %1) : (tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
    %3 = "tt.splat"(%arg1) : (i32) -> tensor<64xi32>
    %4 = "arith.cmpi"(%2, %3) <{predicate = 2 : i64}> : (tensor<64xi32>, tensor<64xi32>) -> tensor<64xi1>
    %5 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<64xf32>}> : () -> tensor<64xf32>
    %6 = "arith.cmpi"(%2, %3) <{predicate = 2 : i64}> : (tensor<64xi32>, tensor<64xi32>) -> tensor<64xi1>
    %7 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %8 = "arith.subi"(%7, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %9 = "tt.make_range"() <{end = 64 : i32, start = 0 : i32}> : () -> tensor<64xi32>
    %10 = "arith.sitofp"(%9) : (tensor<64xi32>) -> tensor<64xf32>
    %11 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<64xf32>}> : () -> tensor<64xf32>
    %12 = "arith.select"(%4, %arg0, %5) : (tensor<64xi1>, tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>
    "tt.return"(%12) : (tensor<64xf32>) -> ()
  }) : () -> ()
}) : () -> ()

