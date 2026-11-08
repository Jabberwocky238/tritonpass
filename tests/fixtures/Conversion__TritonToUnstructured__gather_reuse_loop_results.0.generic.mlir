"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32) -> (), sym_name = "nested_use_same_level_loop_result", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3 = "tt.make_range"() <{end = 2 : i32, start = 0 : i32}> : () -> tensor<2xi32>
    %4 = "tt.expand_dims"(%3) <{axis = 1 : i32}> : (tensor<2xi32>) -> tensor<2x1xi32>
    %5 = "tt.splat"(%arg2) : (i32) -> tensor<2x1xi32>
    %6 = "arith.muli"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x1xi32>, tensor<2x1xi32>) -> tensor<2x1xi32>
    %7 = "tt.expand_dims"(%3) <{axis = 0 : i32}> : (tensor<2xi32>) -> tensor<1x2xi32>
    %8 = "tt.splat"(%arg3) : (i32) -> tensor<1x2xi32>
    %9 = "arith.muli"(%7, %8) <{overflowFlags = #arith.overflow<none>}> : (tensor<1x2xi32>, tensor<1x2xi32>) -> tensor<1x2xi32>
    %10 = "tt.broadcast"(%6) : (tensor<2x1xi32>) -> tensor<2x2xi32>
    %11 = "tt.broadcast"(%9) : (tensor<1x2xi32>) -> tensor<2x2xi32>
    %12 = "arith.addi"(%10, %11) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
    %13 = "arith.muli"(%arg3, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %14 = "tt.splat"(%13) : (i32) -> tensor<2x2xi32>
    %15:2 = "scf.for"(%0, %2, %1, %12, %12) ({
    ^bb0(%arg4: i32, %arg5: tensor<2x2xi32>, %arg6: tensor<2x2xi32>):
      %16 = "scf.for"(%0, %2, %1, %arg5) ({
      ^bb0(%arg10: i32, %arg11: tensor<2x2xi32>):
        %26 = "arith.addi"(%arg11, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
        "scf.yield"(%26) : (tensor<2x2xi32>) -> ()
      }) : (i32, i32, i32, tensor<2x2xi32>) -> tensor<2x2xi32>
      %17:2 = "scf.for"(%0, %2, %1, %16, %arg6) ({
      ^bb0(%arg7: i32, %arg8: tensor<2x2xi32>, %arg9: tensor<2x2xi32>):
        %19 = "tts.gather"(%arg0, %arg8) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
        %20 = "arith.addi"(%arg8, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
        %21 = "tts.gather"(%arg0, %20) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
        "tts.scatter"(%arg1, %arg9, %19) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
        %22 = "arith.addi"(%arg9, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
        %23 = "arith.addi"(%22, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
        "tts.scatter"(%arg1, %23, %21) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
        %24 = "arith.addi"(%23, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
        %25 = "arith.addi"(%20, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
        "scf.yield"(%25, %24) : (tensor<2x2xi32>, tensor<2x2xi32>) -> ()
      }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xi32>) -> (tensor<2x2xi32>, tensor<2x2xi32>)
      %18 = "arith.addi"(%17#0, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
      "scf.yield"(%18, %17#1) : (tensor<2x2xi32>, tensor<2x2xi32>) -> ()
    }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xi32>) -> (tensor<2x2xi32>, tensor<2x2xi32>)
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

