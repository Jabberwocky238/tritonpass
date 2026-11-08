"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32) -> (), sym_name = "nested2_complex_body", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = dense<3> : tensor<2x2xi32>}> : () -> tensor<2x2xi32>
    %3 = "arith.constant"() <{value = dense<1> : tensor<2x2xi32>}> : () -> tensor<2x2xi32>
    %4 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %5 = "tt.make_range"() <{end = 2 : i32, start = 0 : i32}> : () -> tensor<2xi32>
    %6 = "tt.expand_dims"(%5) <{axis = 1 : i32}> : (tensor<2xi32>) -> tensor<2x1xi32>
    %7 = "tt.splat"(%arg2) : (i32) -> tensor<2x1xi32>
    %8 = "arith.muli"(%6, %7) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x1xi32>, tensor<2x1xi32>) -> tensor<2x1xi32>
    %9 = "tt.expand_dims"(%5) <{axis = 0 : i32}> : (tensor<2xi32>) -> tensor<1x2xi32>
    %10 = "tt.splat"(%arg3) : (i32) -> tensor<1x2xi32>
    %11 = "arith.muli"(%9, %10) <{overflowFlags = #arith.overflow<none>}> : (tensor<1x2xi32>, tensor<1x2xi32>) -> tensor<1x2xi32>
    %12 = "tt.broadcast"(%8) : (tensor<2x1xi32>) -> tensor<2x2xi32>
    %13 = "tt.broadcast"(%11) : (tensor<1x2xi32>) -> tensor<2x2xi32>
    %14 = "arith.addi"(%12, %13) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
    %15 = "arith.muli"(%arg2, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %16 = "tt.splat"(%15) : (i32) -> tensor<2x2xi32>
    %17:2 = "scf.for"(%0, %4, %1, %14, %14) ({
    ^bb0(%arg4: i32, %arg5: tensor<2x2xi32>, %arg6: tensor<2x2xi32>):
      %18 = "arith.addi"(%arg5, %3) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
      %19 = "arith.addi"(%arg6, %3) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
      %20:2 = "scf.for"(%0, %4, %1, %18, %19) ({
      ^bb0(%arg7: i32, %arg8: tensor<2x2xi32>, %arg9: tensor<2x2xi32>):
        %25 = "tts.gather"(%arg0, %arg8) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
        "tts.scatter"(%arg1, %arg9, %25) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
        %26 = "arith.addi"(%arg8, %2) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
        %27 = "arith.addi"(%arg9, %2) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
        "scf.yield"(%26, %27) : (tensor<2x2xi32>, tensor<2x2xi32>) -> ()
      }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xi32>) -> (tensor<2x2xi32>, tensor<2x2xi32>)
      %21 = "arith.addi"(%arg5, %16) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
      %22 = "arith.addi"(%21, %3) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
      %23 = "arith.addi"(%arg6, %16) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
      %24 = "arith.addi"(%23, %3) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
      "scf.yield"(%22, %24) : (tensor<2x2xi32>, tensor<2x2xi32>) -> ()
    }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xi32>) -> (tensor<2x2xi32>, tensor<2x2xi32>)
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

