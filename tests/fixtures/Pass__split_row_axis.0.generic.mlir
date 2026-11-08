"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, i32, i32, i32, i32, i32, i64, i64) -> tensor<16x128xbf16>, sym_name = "load_rows", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i64, %arg7: i64):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<4x4x128xbf16>}> : () -> tensor<4x4x128xbf16>
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "tt.make_range"() <{end = 128 : i32, start = 0 : i32}> : () -> tensor<128xi32>
    %3 = "tt.expand_dims"(%2) <{axis = 0 : i32}> : (tensor<128xi32>) -> tensor<1x128xi32>
    %4 = "arith.extsi"(%3) : (tensor<1x128xi32>) -> tensor<1x128xi64>
    %5 = "arith.extsi"(%arg1) : (i32) -> i64
    %6 = "arith.muli"(%5, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %7 = "arith.extsi"(%arg2) : (i32) -> i64
    %8 = "arith.muli"(%7, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %9 = "arith.addi"(%6, %8) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %10 = "arith.extsi"(%arg4) : (i32) -> i64
    %11 = "arith.muli"(%10, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %12 = "arith.addi"(%9, %11) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %13 = "tt.splat"(%12) : (i64) -> tensor<4x4x1xi64>
    %14 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %15 = "arith.extsi"(%14) : (tensor<4xi32>) -> tensor<4xi64>
    %16 = "tt.expand_dims"(%15) <{axis = 1 : i32}> : (tensor<4xi64>) -> tensor<4x1xi64>
    %17 = "tt.expand_dims"(%16) <{axis = 2 : i32}> : (tensor<4x1xi64>) -> tensor<4x1x1xi64>
    %18 = "tt.broadcast"(%17) : (tensor<4x1x1xi64>) -> tensor<4x4x1xi64>
    %19 = "tt.splat"(%arg6) : (i64) -> tensor<4x4x1xi64>
    %20 = "arith.muli"(%18, %19) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x4x1xi64>, tensor<4x4x1xi64>) -> tensor<4x4x1xi64>
    %21 = "arith.addi"(%13, %20) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x4x1xi64>, tensor<4x4x1xi64>) -> tensor<4x4x1xi64>
    %22 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %23 = "arith.extsi"(%22) : (tensor<4xi32>) -> tensor<4xi64>
    %24 = "tt.expand_dims"(%23) <{axis = 0 : i32}> : (tensor<4xi64>) -> tensor<1x4xi64>
    %25 = "tt.expand_dims"(%24) <{axis = 2 : i32}> : (tensor<1x4xi64>) -> tensor<1x4x1xi64>
    %26 = "tt.broadcast"(%25) : (tensor<1x4x1xi64>) -> tensor<4x4x1xi64>
    %27 = "tt.splat"(%arg7) : (i64) -> tensor<4x4x1xi64>
    %28 = "arith.muli"(%26, %27) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x4x1xi64>, tensor<4x4x1xi64>) -> tensor<4x4x1xi64>
    %29 = "arith.addi"(%21, %28) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x4x1xi64>, tensor<4x4x1xi64>) -> tensor<4x4x1xi64>
    %30 = "tt.broadcast"(%29) : (tensor<4x4x1xi64>) -> tensor<4x4x128xi64>
    %31 = "tt.expand_dims"(%4) <{axis = 0 : i32}> : (tensor<1x128xi64>) -> tensor<1x1x128xi64>
    %32 = "tt.broadcast"(%31) : (tensor<1x1x128xi64>) -> tensor<4x4x128xi64>
    %33 = "arith.addi"(%30, %32) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x4x128xi64>, tensor<4x4x128xi64>) -> tensor<4x4x128xi64>
    %34 = "arith.subi"(%1, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %35 = "arith.addi"(%arg2, %34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %36 = "arith.subi"(%1, %35) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %37 = "arith.subi"(%1, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %38 = "arith.addi"(%arg4, %37) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %39 = "arith.subi"(%1, %38) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %40 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %41 = "tt.splat"(%36) : (i32) -> tensor<4xi32>
    %42 = "arith.cmpi"(%40, %41) <{predicate = 2 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %43 = "tt.expand_dims"(%42) <{axis = 1 : i32}> : (tensor<4xi1>) -> tensor<4x1xi1>
    %44 = "tt.expand_dims"(%43) <{axis = 2 : i32}> : (tensor<4x1xi1>) -> tensor<4x1x1xi1>
    %45 = "tt.broadcast"(%44) : (tensor<4x1x1xi1>) -> tensor<4x4x128xi1>
    %46 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %47 = "tt.splat"(%39) : (i32) -> tensor<4xi32>
    %48 = "arith.cmpi"(%46, %47) <{predicate = 2 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %49 = "tt.expand_dims"(%48) <{axis = 0 : i32}> : (tensor<4xi1>) -> tensor<1x4xi1>
    %50 = "tt.expand_dims"(%49) <{axis = 2 : i32}> : (tensor<1x4xi1>) -> tensor<1x4x1xi1>
    %51 = "tt.broadcast"(%50) : (tensor<1x4x1xi1>) -> tensor<4x4x128xi1>
    %52 = "arith.andi"(%45, %51) : (tensor<4x4x128xi1>, tensor<4x4x128xi1>) -> tensor<4x4x128xi1>
    %53 = "tt.splat"(%arg0) : (!tt.ptr<bf16>) -> tensor<4x4x128x!tt.ptr<bf16>>
    %54 = "tt.addptr"(%53, %33) : (tensor<4x4x128x!tt.ptr<bf16>>, tensor<4x4x128xi64>) -> tensor<4x4x128x!tt.ptr<bf16>>
    %55 = "tt.load"(%54, %52, %0) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<4x4x128x!tt.ptr<bf16>>, tensor<4x4x128xi1>, tensor<4x4x128xbf16>) -> tensor<4x4x128xbf16>
    %56 = "tt.reshape"(%55) : (tensor<4x4x128xbf16>) -> tensor<16x128xbf16>
    "tt.return"(%56) : (tensor<16x128xbf16>) -> ()
  }) : () -> ()
}) {dope.split_row_axis} : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, tensor<16x128xf32>, i32, i32, i32, i32, i32, i64, i64) -> (), sym_name = "store_rows", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: tensor<16x128xf32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i64, %arg8: i64):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "tt.make_range"() <{end = 128 : i32, start = 0 : i32}> : () -> tensor<128xi32>
    %2 = "tt.expand_dims"(%1) <{axis = 0 : i32}> : (tensor<128xi32>) -> tensor<1x128xi32>
    %3 = "arith.extsi"(%2) : (tensor<1x128xi32>) -> tensor<1x128xi64>
    %4 = "arith.extsi"(%arg2) : (i32) -> i64
    %5 = "arith.muli"(%4, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %6 = "arith.extsi"(%arg3) : (i32) -> i64
    %7 = "arith.muli"(%6, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %8 = "arith.addi"(%5, %7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %9 = "arith.extsi"(%arg5) : (i32) -> i64
    %10 = "arith.muli"(%9, %arg8) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %11 = "arith.addi"(%8, %10) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %12 = "tt.splat"(%11) : (i64) -> tensor<4x4x1xi64>
    %13 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %14 = "arith.extsi"(%13) : (tensor<4xi32>) -> tensor<4xi64>
    %15 = "tt.expand_dims"(%14) <{axis = 1 : i32}> : (tensor<4xi64>) -> tensor<4x1xi64>
    %16 = "tt.expand_dims"(%15) <{axis = 2 : i32}> : (tensor<4x1xi64>) -> tensor<4x1x1xi64>
    %17 = "tt.broadcast"(%16) : (tensor<4x1x1xi64>) -> tensor<4x4x1xi64>
    %18 = "tt.splat"(%arg7) : (i64) -> tensor<4x4x1xi64>
    %19 = "arith.muli"(%17, %18) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x4x1xi64>, tensor<4x4x1xi64>) -> tensor<4x4x1xi64>
    %20 = "arith.addi"(%12, %19) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x4x1xi64>, tensor<4x4x1xi64>) -> tensor<4x4x1xi64>
    %21 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %22 = "arith.extsi"(%21) : (tensor<4xi32>) -> tensor<4xi64>
    %23 = "tt.expand_dims"(%22) <{axis = 0 : i32}> : (tensor<4xi64>) -> tensor<1x4xi64>
    %24 = "tt.expand_dims"(%23) <{axis = 2 : i32}> : (tensor<1x4xi64>) -> tensor<1x4x1xi64>
    %25 = "tt.broadcast"(%24) : (tensor<1x4x1xi64>) -> tensor<4x4x1xi64>
    %26 = "tt.splat"(%arg8) : (i64) -> tensor<4x4x1xi64>
    %27 = "arith.muli"(%25, %26) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x4x1xi64>, tensor<4x4x1xi64>) -> tensor<4x4x1xi64>
    %28 = "arith.addi"(%20, %27) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x4x1xi64>, tensor<4x4x1xi64>) -> tensor<4x4x1xi64>
    %29 = "tt.broadcast"(%28) : (tensor<4x4x1xi64>) -> tensor<4x4x128xi64>
    %30 = "tt.expand_dims"(%3) <{axis = 0 : i32}> : (tensor<1x128xi64>) -> tensor<1x1x128xi64>
    %31 = "tt.broadcast"(%30) : (tensor<1x1x128xi64>) -> tensor<4x4x128xi64>
    %32 = "arith.addi"(%29, %31) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x4x128xi64>, tensor<4x4x128xi64>) -> tensor<4x4x128xi64>
    %33 = "arith.subi"(%0, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %34 = "arith.addi"(%arg3, %33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %35 = "arith.subi"(%0, %34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %36 = "arith.subi"(%0, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %37 = "arith.addi"(%arg5, %36) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %38 = "arith.subi"(%0, %37) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %39 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %40 = "tt.splat"(%35) : (i32) -> tensor<4xi32>
    %41 = "arith.cmpi"(%39, %40) <{predicate = 2 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %42 = "tt.expand_dims"(%41) <{axis = 1 : i32}> : (tensor<4xi1>) -> tensor<4x1xi1>
    %43 = "tt.expand_dims"(%42) <{axis = 2 : i32}> : (tensor<4x1xi1>) -> tensor<4x1x1xi1>
    %44 = "tt.broadcast"(%43) : (tensor<4x1x1xi1>) -> tensor<4x4x128xi1>
    %45 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %46 = "tt.splat"(%38) : (i32) -> tensor<4xi32>
    %47 = "arith.cmpi"(%45, %46) <{predicate = 2 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %48 = "tt.expand_dims"(%47) <{axis = 0 : i32}> : (tensor<4xi1>) -> tensor<1x4xi1>
    %49 = "tt.expand_dims"(%48) <{axis = 2 : i32}> : (tensor<1x4xi1>) -> tensor<1x4x1xi1>
    %50 = "tt.broadcast"(%49) : (tensor<1x4x1xi1>) -> tensor<4x4x128xi1>
    %51 = "arith.andi"(%44, %50) : (tensor<4x4x128xi1>, tensor<4x4x128xi1>) -> tensor<4x4x128xi1>
    %52 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<4x4x128x!tt.ptr<f32>>
    %53 = "tt.addptr"(%52, %32) : (tensor<4x4x128x!tt.ptr<f32>>, tensor<4x4x128xi64>) -> tensor<4x4x128x!tt.ptr<f32>>
    %54 = "tt.reshape"(%arg1) : (tensor<16x128xf32>) -> tensor<4x4x128xf32>
    "tt.store"(%53, %54, %51) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<4x4x128x!tt.ptr<f32>>, tensor<4x4x128xf32>, tensor<4x4x128xi1>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) {dope.split_row_axis} : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, tensor<16xf32>, i32, i32, i32, i32, i32) -> (), sym_name = "store_col", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: tensor<16xf32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32):
    %0 = "arith.constant"() <{value = dense<16> : tensor<4x4x1xi64>}> : () -> tensor<4x4x1xi64>
    %1 = "arith.constant"() <{value = dense<512> : tensor<4x4x1xi64>}> : () -> tensor<4x4x1xi64>
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %4 = "arith.constant"() <{value = 16 : i64}> : () -> i64
    %5 = "arith.extsi"(%arg2) : (i32) -> i64
    %6 = "arith.muli"(%5, %3) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %7 = "arith.extsi"(%arg3) : (i32) -> i64
    %8 = "arith.muli"(%7, %3) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %9 = "arith.addi"(%6, %8) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %10 = "arith.extsi"(%arg5) : (i32) -> i64
    %11 = "arith.muli"(%10, %4) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %12 = "arith.addi"(%9, %11) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %13 = "tt.splat"(%12) : (i64) -> tensor<4x4x1xi64>
    %14 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %15 = "arith.extsi"(%14) : (tensor<4xi32>) -> tensor<4xi64>
    %16 = "tt.expand_dims"(%15) <{axis = 1 : i32}> : (tensor<4xi64>) -> tensor<4x1xi64>
    %17 = "tt.expand_dims"(%16) <{axis = 2 : i32}> : (tensor<4x1xi64>) -> tensor<4x1x1xi64>
    %18 = "tt.broadcast"(%17) : (tensor<4x1x1xi64>) -> tensor<4x4x1xi64>
    %19 = "arith.muli"(%18, %1) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x4x1xi64>, tensor<4x4x1xi64>) -> tensor<4x4x1xi64>
    %20 = "arith.addi"(%13, %19) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x4x1xi64>, tensor<4x4x1xi64>) -> tensor<4x4x1xi64>
    %21 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %22 = "arith.extsi"(%21) : (tensor<4xi32>) -> tensor<4xi64>
    %23 = "tt.expand_dims"(%22) <{axis = 0 : i32}> : (tensor<4xi64>) -> tensor<1x4xi64>
    %24 = "tt.expand_dims"(%23) <{axis = 2 : i32}> : (tensor<1x4xi64>) -> tensor<1x4x1xi64>
    %25 = "tt.broadcast"(%24) : (tensor<1x4x1xi64>) -> tensor<4x4x1xi64>
    %26 = "arith.muli"(%25, %0) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x4x1xi64>, tensor<4x4x1xi64>) -> tensor<4x4x1xi64>
    %27 = "arith.addi"(%20, %26) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x4x1xi64>, tensor<4x4x1xi64>) -> tensor<4x4x1xi64>
    %28 = "arith.subi"(%2, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %29 = "arith.addi"(%arg3, %28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %30 = "arith.subi"(%2, %29) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %31 = "arith.subi"(%2, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %32 = "arith.addi"(%arg5, %31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %33 = "arith.subi"(%2, %32) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %34 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %35 = "tt.splat"(%30) : (i32) -> tensor<4xi32>
    %36 = "arith.cmpi"(%34, %35) <{predicate = 2 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %37 = "tt.expand_dims"(%36) <{axis = 1 : i32}> : (tensor<4xi1>) -> tensor<4x1xi1>
    %38 = "tt.expand_dims"(%37) <{axis = 2 : i32}> : (tensor<4x1xi1>) -> tensor<4x1x1xi1>
    %39 = "tt.broadcast"(%38) : (tensor<4x1x1xi1>) -> tensor<4x4x1xi1>
    %40 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %41 = "tt.splat"(%33) : (i32) -> tensor<4xi32>
    %42 = "arith.cmpi"(%40, %41) <{predicate = 2 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %43 = "tt.expand_dims"(%42) <{axis = 0 : i32}> : (tensor<4xi1>) -> tensor<1x4xi1>
    %44 = "tt.expand_dims"(%43) <{axis = 2 : i32}> : (tensor<1x4xi1>) -> tensor<1x4x1xi1>
    %45 = "tt.broadcast"(%44) : (tensor<1x4x1xi1>) -> tensor<4x4x1xi1>
    %46 = "arith.andi"(%39, %45) : (tensor<4x4x1xi1>, tensor<4x4x1xi1>) -> tensor<4x4x1xi1>
    %47 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<4x4x1x!tt.ptr<f32>>
    %48 = "tt.addptr"(%47, %27) : (tensor<4x4x1x!tt.ptr<f32>>, tensor<4x4x1xi64>) -> tensor<4x4x1x!tt.ptr<f32>>
    %49 = "tt.reshape"(%arg1) : (tensor<16xf32>) -> tensor<4x4x1xf32>
    "tt.store"(%48, %49, %46) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<4x4x1x!tt.ptr<f32>>, tensor<4x4x1xf32>, tensor<4x4x1xi1>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) {dope.split_row_axis} : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, i64) -> tensor<16x128xf32>, sym_name = "affine_rows", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: i64):
    %0 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %1 = "tt.make_range"() <{end = 128 : i32, start = 0 : i32}> : () -> tensor<128xi32>
    %2 = "tt.expand_dims"(%0) <{axis = 1 : i32}> : (tensor<16xi32>) -> tensor<16x1xi32>
    %3 = "arith.extsi"(%2) : (tensor<16x1xi32>) -> tensor<16x1xi64>
    %4 = "tt.splat"(%arg1) : (i64) -> tensor<16x1xi64>
    %5 = "arith.muli"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi64>, tensor<16x1xi64>) -> tensor<16x1xi64>
    %6 = "tt.expand_dims"(%1) <{axis = 0 : i32}> : (tensor<128xi32>) -> tensor<1x128xi32>
    %7 = "arith.extsi"(%6) : (tensor<1x128xi32>) -> tensor<1x128xi64>
    %8 = "tt.broadcast"(%5) : (tensor<16x1xi64>) -> tensor<16x128xi64>
    %9 = "tt.broadcast"(%7) : (tensor<1x128xi64>) -> tensor<16x128xi64>
    %10 = "arith.addi"(%8, %9) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x128xi64>, tensor<16x128xi64>) -> tensor<16x128xi64>
    %11 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<16x128x!tt.ptr<f32>>
    %12 = "tt.addptr"(%11, %10) : (tensor<16x128x!tt.ptr<f32>>, tensor<16x128xi64>) -> tensor<16x128x!tt.ptr<f32>>
    %13 = "tt.load"(%12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<16x128x!tt.ptr<f32>>) -> tensor<16x128xf32>
    "tt.return"(%13) : (tensor<16x128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, i32, i32, i32, i32, i32, i64, i64) -> tensor<16x128xbf16>, sym_name = "unrecognized_mask", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i64, %arg7: i64):
    %0 = "arith.constant"() <{value = dense<4> : tensor<16xi32>}> : () -> tensor<16xi32>
    %1 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %2 = "tt.make_range"() <{end = 128 : i32, start = 0 : i32}> : () -> tensor<128xi32>
    %3 = "arith.divsi"(%1, %0) : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %4 = "tt.splat"(%arg2) : (i32) -> tensor<16xi32>
    %5 = "arith.addi"(%4, %3) <{overflowFlags = #arith.overflow<none>}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %6 = "tt.splat"(%arg1) : (i32) -> tensor<16xi32>
    %7 = "arith.addi"(%6, %5) <{overflowFlags = #arith.overflow<none>}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %8 = "arith.remsi"(%1, %0) : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %9 = "tt.splat"(%arg4) : (i32) -> tensor<16xi32>
    %10 = "arith.addi"(%9, %8) <{overflowFlags = #arith.overflow<none>}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %11 = "tt.expand_dims"(%7) <{axis = 1 : i32}> : (tensor<16xi32>) -> tensor<16x1xi32>
    %12 = "arith.extsi"(%11) : (tensor<16x1xi32>) -> tensor<16x1xi64>
    %13 = "tt.splat"(%arg6) : (i64) -> tensor<16x1xi64>
    %14 = "arith.muli"(%12, %13) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi64>, tensor<16x1xi64>) -> tensor<16x1xi64>
    %15 = "tt.expand_dims"(%10) <{axis = 1 : i32}> : (tensor<16xi32>) -> tensor<16x1xi32>
    %16 = "arith.extsi"(%15) : (tensor<16x1xi32>) -> tensor<16x1xi64>
    %17 = "tt.splat"(%arg7) : (i64) -> tensor<16x1xi64>
    %18 = "arith.muli"(%16, %17) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi64>, tensor<16x1xi64>) -> tensor<16x1xi64>
    %19 = "arith.addi"(%14, %18) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi64>, tensor<16x1xi64>) -> tensor<16x1xi64>
    %20 = "tt.expand_dims"(%2) <{axis = 0 : i32}> : (tensor<128xi32>) -> tensor<1x128xi32>
    %21 = "arith.extsi"(%20) : (tensor<1x128xi32>) -> tensor<1x128xi64>
    %22 = "tt.broadcast"(%19) : (tensor<16x1xi64>) -> tensor<16x128xi64>
    %23 = "tt.broadcast"(%21) : (tensor<1x128xi64>) -> tensor<16x128xi64>
    %24 = "arith.addi"(%22, %23) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x128xi64>, tensor<16x128xi64>) -> tensor<16x128xi64>
    %25 = "tt.splat"(%arg3) : (i32) -> tensor<16xi32>
    %26 = "arith.cmpi"(%5, %25) <{predicate = 2 : i64}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi1>
    %27 = "tt.splat"(%arg5) : (i32) -> tensor<16xi32>
    %28 = "arith.cmpi"(%10, %27) <{predicate = 2 : i64}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi1>
    %29 = "tt.expand_dims"(%26) <{axis = 1 : i32}> : (tensor<16xi1>) -> tensor<16x1xi1>
    %30 = "tt.expand_dims"(%28) <{axis = 1 : i32}> : (tensor<16xi1>) -> tensor<16x1xi1>
    %31 = "tt.broadcast"(%29) : (tensor<16x1xi1>) -> tensor<16x128xi1>
    %32 = "tt.broadcast"(%30) : (tensor<16x1xi1>) -> tensor<16x128xi1>
    %33 = "arith.ori"(%31, %32) : (tensor<16x128xi1>, tensor<16x128xi1>) -> tensor<16x128xi1>
    %34 = "tt.splat"(%arg0) : (!tt.ptr<bf16>) -> tensor<16x128x!tt.ptr<bf16>>
    %35 = "tt.addptr"(%34, %24) : (tensor<16x128x!tt.ptr<bf16>>, tensor<16x128xi64>) -> tensor<16x128x!tt.ptr<bf16>>
    %36 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<16x128xbf16>}> : () -> tensor<16x128xbf16>
    %37 = "tt.load"(%35, %33, %36) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<16x128x!tt.ptr<bf16>>, tensor<16x128xi1>, tensor<16x128xbf16>) -> tensor<16x128xbf16>
    "tt.return"(%37) : (tensor<16x128xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

