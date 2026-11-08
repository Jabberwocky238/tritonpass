"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i64, i64, i64, i64, i64, i64, i64) -> (), sym_name = "row_gather2", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i64, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64):
    %0 = "arith.constant"() <{value = dense<8> : tensor<1x16xi32>}> : () -> tensor<1x16xi32>
    %1 = "arith.constant"() <{value = dense<8> : tensor<16x1xi32>}> : () -> tensor<16x1xi32>
    %2 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %3 = "tt.get_program_id"() <{axis = 2 : i32}> : () -> i32
    %4 = "arith.muli"(%arg5, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %5 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %6 = "tt.expand_dims"(%5) <{axis = 1 : i32}> : (tensor<16xi32>) -> tensor<16x1xi32>
    %7 = "arith.remsi"(%6, %1) : (tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
    %8 = "arith.muli"(%arg3, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %9 = "tt.splat"(%8) : (i32) -> tensor<16x1xi32>
    %10 = "arith.addi"(%7, %9) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
    %11 = "arith.divsi"(%6, %1) : (tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
    %12 = "tt.splat"(%arg4) : (i32) -> tensor<16x1xi32>
    %13 = "arith.addi"(%11, %12) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
    %14 = "arith.extsi"(%arg2) : (i32) -> i64
    %15 = "arith.muli"(%14, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %16 = "tt.addptr"(%arg0, %15) : (!tt.ptr<f32>, i64) -> !tt.ptr<f32>
    %17 = "arith.extsi"(%13) : (tensor<16x1xi32>) -> tensor<16x1xi64>
    %18 = "tt.splat"(%arg6) : (i64) -> tensor<16x1xi64>
    %19 = "arith.muli"(%17, %18) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi64>, tensor<16x1xi64>) -> tensor<16x1xi64>
    %20 = "tt.splat"(%16) : (!tt.ptr<f32>) -> tensor<16x1x!tt.ptr<f32>>
    %21 = "arith.extsi"(%10) : (tensor<16x1xi32>) -> tensor<16x1xi64>
    %22 = "tt.splat"(%arg8) : (i64) -> tensor<16x1xi64>
    %23 = "arith.muli"(%21, %22) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi64>, tensor<16x1xi64>) -> tensor<16x1xi64>
    %24 = "arith.addi"(%19, %23) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi64>, tensor<16x1xi64>) -> tensor<16x1xi64>
    %25 = "tt.addptr"(%20, %24) : (tensor<16x1x!tt.ptr<f32>>, tensor<16x1xi64>) -> tensor<16x1x!tt.ptr<f32>>
    %26 = "tt.expand_dims"(%5) <{axis = 0 : i32}> : (tensor<16xi32>) -> tensor<1x16xi32>
    %27 = "tt.broadcast"(%25) : (tensor<16x1x!tt.ptr<f32>>) -> tensor<16x16x!tt.ptr<f32>>
    %28 = "tt.broadcast"(%26) : (tensor<1x16xi32>) -> tensor<16x16xi32>
    %29 = "tt.addptr"(%27, %28) : (tensor<16x16x!tt.ptr<f32>>, tensor<16x16xi32>) -> tensor<16x16x!tt.ptr<f32>>
    %30 = "arith.cmpi"(%26, %0) <{predicate = 2 : i64}> : (tensor<1x16xi32>, tensor<1x16xi32>) -> tensor<1x16xi1>
    %31 = "tt.splat"(%4) : (i32) -> tensor<16x1xi32>
    %32 = "arith.cmpi"(%6, %31) <{predicate = 2 : i64}> : (tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi1>
    %33 = "tt.broadcast"(%30) : (tensor<1x16xi1>) -> tensor<16x16xi1>
    %34 = "tt.broadcast"(%32) : (tensor<16x1xi1>) -> tensor<16x16xi1>
    %35 = "arith.andi"(%33, %34) : (tensor<16x16xi1>, tensor<16x16xi1>) -> tensor<16x16xi1>
    %36 = "tt.load"(%29, %35) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<16x16x!tt.ptr<f32>>, tensor<16x16xi1>) -> tensor<16x16xf32>
    %37 = "arith.muli"(%14, %arg10) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %38 = "arith.extsi"(%3) : (i32) -> i64
    %39 = "arith.muli"(%38, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %40 = "arith.addi"(%37, %39) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %41 = "tt.addptr"(%arg1, %40) : (!tt.ptr<f32>, i64) -> !tt.ptr<f32>
    %42 = "tt.splat"(%arg9) : (i64) -> tensor<16x1xi64>
    %43 = "arith.muli"(%17, %42) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi64>, tensor<16x1xi64>) -> tensor<16x1xi64>
    %44 = "tt.splat"(%41) : (!tt.ptr<f32>) -> tensor<16x1x!tt.ptr<f32>>
    %45 = "tt.splat"(%arg11) : (i64) -> tensor<16x1xi64>
    %46 = "arith.muli"(%21, %45) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi64>, tensor<16x1xi64>) -> tensor<16x1xi64>
    %47 = "arith.addi"(%43, %46) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi64>, tensor<16x1xi64>) -> tensor<16x1xi64>
    %48 = "tt.addptr"(%44, %47) : (tensor<16x1x!tt.ptr<f32>>, tensor<16x1xi64>) -> tensor<16x1x!tt.ptr<f32>>
    %49 = "tt.broadcast"(%48) : (tensor<16x1x!tt.ptr<f32>>) -> tensor<16x16x!tt.ptr<f32>>
    %50 = "tt.addptr"(%49, %28) : (tensor<16x16x!tt.ptr<f32>>, tensor<16x16xi32>) -> tensor<16x16x!tt.ptr<f32>>
    "tt.store"(%50, %36, %35) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<16x16x!tt.ptr<f32>>, tensor<16x16xf32>, tensor<16x16xi1>) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

