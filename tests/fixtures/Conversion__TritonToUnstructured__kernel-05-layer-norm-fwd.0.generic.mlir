"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, i32, i32, f32) -> (), sym_name = "_layer_norm_fwd_fused_0123456789", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<f32>, %arg3: !tt.ptr<f32>, %arg4: !tt.ptr<f32>, %arg5: !tt.ptr<f32>, %arg6: i32, %arg7: i32, %arg8: f32):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<256xf32>}> : () -> tensor<256xf32>
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %6 = "arith.muli"(%5, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %7 = "tt.make_range"() <{end = 256 : i32, start = 0 : i32}> : () -> tensor<256xi32>
    %8 = "tt.splat"(%arg7) : (i32) -> tensor<256xi32>
    %9 = "tt.splat"(%6) : (i32) -> tensor<256xi32>
    %10 = "scf.for"(%1, %arg7, %2, %0) ({
    ^bb0(%arg16: i32, %arg17: tensor<256xf32>):
      %44 = "tt.splat"(%arg16) : (i32) -> tensor<256xi32>
      %45 = "arith.addi"(%44, %7) <{overflowFlags = #arith.overflow<none>}> : (tensor<256xi32>, tensor<256xi32>) -> tensor<256xi32>
      %46 = "arith.cmpi"(%45, %8) <{predicate = 2 : i64}> : (tensor<256xi32>, tensor<256xi32>) -> tensor<256xi1>
      %47 = "arith.addi"(%9, %45) <{overflowFlags = #arith.overflow<none>}> : (tensor<256xi32>, tensor<256xi32>) -> tensor<256xi32>
      %48 = "tts.gather"(%arg0, %47, %46, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (!tt.ptr<f32>, tensor<256xi32>, tensor<256xi1>, f32) -> tensor<256xf32>
      %49 = "arith.addf"(%arg17, %48) <{fastmath = #arith.fastmath<none>}> : (tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      "scf.yield"(%49) : (tensor<256xf32>) -> ()
    }) : (i32, i32, i32, tensor<256xf32>) -> tensor<256xf32>
    %11 = "tt.reduce"(%10) <{axis = 0 : i32}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %43 = "arith.addf"(%arg14, %arg15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "tt.reduce.return"(%43) : (f32) -> ()
    }) : (tensor<256xf32>) -> f32
    %12 = "arith.sitofp"(%arg7) : (i32) -> f32
    %13 = "arith.divf"(%11, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %14 = "tt.splat"(%13) : (f32) -> tensor<256xf32>
    %15 = "scf.for"(%1, %arg7, %2, %0) ({
    ^bb0(%arg12: i32, %arg13: tensor<256xf32>):
      %34 = "tt.splat"(%arg12) : (i32) -> tensor<256xi32>
      %35 = "arith.addi"(%34, %7) <{overflowFlags = #arith.overflow<none>}> : (tensor<256xi32>, tensor<256xi32>) -> tensor<256xi32>
      %36 = "arith.cmpi"(%35, %8) <{predicate = 2 : i64}> : (tensor<256xi32>, tensor<256xi32>) -> tensor<256xi1>
      %37 = "arith.addi"(%9, %35) <{overflowFlags = #arith.overflow<none>}> : (tensor<256xi32>, tensor<256xi32>) -> tensor<256xi32>
      %38 = "tts.gather"(%arg0, %37, %36, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (!tt.ptr<f32>, tensor<256xi32>, tensor<256xi1>, f32) -> tensor<256xf32>
      %39 = "arith.subf"(%38, %14) <{fastmath = #arith.fastmath<none>}> : (tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      %40 = "arith.select"(%36, %39, %0) : (tensor<256xi1>, tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      %41 = "arith.mulf"(%40, %40) <{fastmath = #arith.fastmath<none>}> : (tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      %42 = "arith.addf"(%arg13, %41) <{fastmath = #arith.fastmath<none>}> : (tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      "scf.yield"(%42) : (tensor<256xf32>) -> ()
    }) : (i32, i32, i32, tensor<256xf32>) -> tensor<256xf32>
    %16 = "tt.reduce"(%15) <{axis = 0 : i32}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      %33 = "arith.addf"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "tt.reduce.return"(%33) : (f32) -> ()
    }) : (tensor<256xf32>) -> f32
    %17 = "arith.divf"(%16, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %18 = "arith.addf"(%17, %arg8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %19 = "math.sqrt"(%18) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %20 = "arith.divf"(%3, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "tts.scatter"(%arg4, %5, %13) : (!tt.ptr<f32>, i32, f32) -> ()
    "tts.scatter"(%arg5, %5, %20) : (!tt.ptr<f32>, i32, f32) -> ()
    %21 = "tt.splat"(%20) : (f32) -> tensor<256xf32>
    "scf.for"(%1, %arg7, %2) ({
    ^bb0(%arg9: i32):
      %22 = "tt.splat"(%arg9) : (i32) -> tensor<256xi32>
      %23 = "arith.addi"(%22, %7) <{overflowFlags = #arith.overflow<none>}> : (tensor<256xi32>, tensor<256xi32>) -> tensor<256xi32>
      %24 = "arith.cmpi"(%23, %8) <{predicate = 2 : i64}> : (tensor<256xi32>, tensor<256xi32>) -> tensor<256xi1>
      %25 = "tts.gather"(%arg2, %23, %24) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (!tt.ptr<f32>, tensor<256xi32>, tensor<256xi1>) -> tensor<256xf32>
      %26 = "tts.gather"(%arg3, %23, %24) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (!tt.ptr<f32>, tensor<256xi32>, tensor<256xi1>) -> tensor<256xf32>
      %27 = "arith.addi"(%9, %23) <{overflowFlags = #arith.overflow<none>}> : (tensor<256xi32>, tensor<256xi32>) -> tensor<256xi32>
      %28 = "tts.gather"(%arg0, %27, %24, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (!tt.ptr<f32>, tensor<256xi32>, tensor<256xi1>, f32) -> tensor<256xf32>
      %29 = "arith.subf"(%28, %14) <{fastmath = #arith.fastmath<none>}> : (tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      %30 = "arith.mulf"(%29, %21) <{fastmath = #arith.fastmath<none>}> : (tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      %31 = "arith.mulf"(%30, %25) <{fastmath = #arith.fastmath<none>}> : (tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      %32 = "arith.addf"(%31, %26) <{fastmath = #arith.fastmath<none>}> : (tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      "tts.scatter"(%arg1, %27, %32, %24) : (!tt.ptr<f32>, tensor<256xi32>, tensor<256xf32>, tensor<256xi1>) -> ()
      "scf.yield"() : () -> ()
    }) : (i32, i32, i32) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

