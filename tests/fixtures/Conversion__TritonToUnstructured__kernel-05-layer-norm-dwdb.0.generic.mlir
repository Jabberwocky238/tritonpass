"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, i32, i32) -> (), sym_name = "_layer_norm_bwd_dwdb_0123456", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<f32>, %arg3: !tt.ptr<f32>, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<256x256xf32>}> : () -> tensor<256x256xf32>
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %5 = "arith.muli"(%4, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "tt.make_range"() <{end = 256 : i32, start = 0 : i32}> : () -> tensor<256xi32>
    %7 = "tt.splat"(%5) : (i32) -> tensor<256xi32>
    %8 = "arith.addi"(%7, %6) <{overflowFlags = #arith.overflow<none>}> : (tensor<256xi32>, tensor<256xi32>) -> tensor<256xi32>
    %9 = "tt.splat"(%arg4) : (i32) -> tensor<256x1xi32>
    %10 = "tt.expand_dims"(%8) <{axis = 0 : i32}> : (tensor<256xi32>) -> tensor<1x256xi32>
    %11 = "tt.splat"(%arg5) : (i32) -> tensor<1x256xi32>
    %12 = "arith.cmpi"(%10, %11) <{predicate = 2 : i64}> : (tensor<1x256xi32>, tensor<1x256xi32>) -> tensor<1x256xi1>
    %13 = "tt.broadcast"(%12) : (tensor<1x256xi1>) -> tensor<256x256xi1>
    %14 = "tt.splat"(%arg5) : (i32) -> tensor<256x1xi32>
    %15 = "tt.broadcast"(%10) : (tensor<1x256xi32>) -> tensor<256x256xi32>
    %16:2 = "scf.for"(%1, %arg4, %2, %0, %0) ({
    ^bb0(%arg10: i32, %arg11: tensor<256x256xf32>, %arg12: tensor<256x256xf32>):
      %23 = "tt.splat"(%arg10) : (i32) -> tensor<256xi32>
      %24 = "arith.addi"(%23, %6) <{overflowFlags = #arith.overflow<none>}> : (tensor<256xi32>, tensor<256xi32>) -> tensor<256xi32>
      %25 = "tt.expand_dims"(%24) <{axis = 1 : i32}> : (tensor<256xi32>) -> tensor<256x1xi32>
      %26 = "arith.cmpi"(%25, %9) <{predicate = 2 : i64}> : (tensor<256x1xi32>, tensor<256x1xi32>) -> tensor<256x1xi1>
      %27 = "tt.broadcast"(%26) : (tensor<256x1xi1>) -> tensor<256x256xi1>
      %28 = "arith.andi"(%27, %13) : (tensor<256x256xi1>, tensor<256x256xi1>) -> tensor<256x256xi1>
      %29 = "arith.muli"(%25, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<256x1xi32>, tensor<256x1xi32>) -> tensor<256x1xi32>
      %30 = "tt.broadcast"(%29) : (tensor<256x1xi32>) -> tensor<256x256xi32>
      %31 = "arith.addi"(%30, %15) <{overflowFlags = #arith.overflow<none>}> : (tensor<256x256xi32>, tensor<256x256xi32>) -> tensor<256x256xi32>
      %32 = "tts.gather"(%arg0, %31, %28, %3) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (!tt.ptr<f32>, tensor<256x256xi32>, tensor<256x256xi1>, f32) -> tensor<256x256xf32>
      %33 = "arith.addf"(%arg11, %32) <{fastmath = #arith.fastmath<none>}> : (tensor<256x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
      %34 = "tts.gather"(%arg1, %31, %28, %3) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (!tt.ptr<f32>, tensor<256x256xi32>, tensor<256x256xi1>, f32) -> tensor<256x256xf32>
      %35 = "arith.addf"(%arg12, %34) <{fastmath = #arith.fastmath<none>}> : (tensor<256x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
      "scf.yield"(%33, %35) : (tensor<256x256xf32>, tensor<256x256xf32>) -> ()
    }) : (i32, i32, i32, tensor<256x256xf32>, tensor<256x256xf32>) -> (tensor<256x256xf32>, tensor<256x256xf32>)
    %17 = "tt.reduce"(%16#0) <{axis = 0 : i32}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "arith.addf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "tt.reduce.return"(%22) : (f32) -> ()
    }) : (tensor<256x256xf32>) -> tensor<256xf32>
    %18 = "tt.reduce"(%16#1) <{axis = 0 : i32}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      %21 = "arith.addf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "tt.reduce.return"(%21) : (f32) -> ()
    }) : (tensor<256x256xf32>) -> tensor<256xf32>
    %19 = "tt.splat"(%arg5) : (i32) -> tensor<256xi32>
    %20 = "arith.cmpi"(%8, %19) <{predicate = 2 : i64}> : (tensor<256xi32>, tensor<256xi32>) -> tensor<256xi1>
    "tts.scatter"(%arg2, %8, %17, %20) : (!tt.ptr<f32>, tensor<256xi32>, tensor<256xf32>, tensor<256xi1>) -> ()
    "tts.scatter"(%arg3, %8, %18, %20) : (!tt.ptr<f32>, tensor<256xi32>, tensor<256xf32>, tensor<256xi1>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

