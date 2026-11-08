"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>) -> (), sym_name = "gather", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = dense<4> : tensor<4xi32>}> : () -> tensor<4xi32>
    %3 = "arith.constant"() <{value = dense<64> : tensor<4xi32>}> : () -> tensor<4xi32>
    %4 = "arith.constant"() <{value = dense<3> : tensor<4xi32>}> : () -> tensor<4xi32>
    %5 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %6 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %7:2 = "scf.for"(%0, %1, %5, %6, %6) ({
    ^bb0(%arg2: i32, %arg3: tensor<4xi32>, %arg4: tensor<4xi32>):
      %8 = "arith.divsi"(%arg3, %4) : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
      %9 = "tt.splat"(%arg2) : (i32) -> tensor<4xi32>
      %10 = "arith.addi"(%8, %9) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
      %11 = "arith.cmpi"(%10, %3) <{predicate = 2 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
      %12 = "tts.gather"(%arg0, %10, %11) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (!tt.ptr<f32>, tensor<4xi32>, tensor<4xi1>) -> tensor<4xf32>
      "tts.scatter"(%arg1, %10, %12) : (!tt.ptr<f32>, tensor<4xi32>, tensor<4xf32>) -> ()
      %13 = "arith.addi"(%10, %2) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
      %14 = "arith.addi"(%arg4, %2) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
      %15 = "arith.addi"(%arg2, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %16:2 = "scf.for"(%0, %1, %5, %13, %14) ({
      ^bb0(%arg5: i32, %arg6: tensor<4xi32>, %arg7: tensor<4xi32>):
        %23 = "arith.addi"(%arg5, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %24 = "arith.muli"(%15, %23) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %25 = "tt.splat"(%24) : (i32) -> tensor<4xi32>
        %26 = "arith.divsi"(%arg6, %25) : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
        %27 = "arith.addi"(%26, %9) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
        %28 = "arith.cmpi"(%27, %3) <{predicate = 2 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
        %29 = "tts.gather"(%arg0, %27, %28) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (!tt.ptr<f32>, tensor<4xi32>, tensor<4xi1>) -> tensor<4xf32>
        "tts.scatter"(%arg1, %27, %29) : (!tt.ptr<f32>, tensor<4xi32>, tensor<4xf32>) -> ()
        %30 = "arith.addi"(%27, %2) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
        %31 = "arith.addi"(%arg7, %2) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
        "scf.yield"(%30, %31) : (tensor<4xi32>, tensor<4xi32>) -> ()
      }) : (i32, i32, i32, tensor<4xi32>, tensor<4xi32>) -> (tensor<4xi32>, tensor<4xi32>)
      %17 = "arith.divsi"(%16#0, %4) : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
      %18 = "arith.addi"(%17, %9) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
      %19 = "arith.cmpi"(%18, %3) <{predicate = 2 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
      %20 = "tts.gather"(%arg0, %18, %19) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (!tt.ptr<f32>, tensor<4xi32>, tensor<4xi1>) -> tensor<4xf32>
      "tts.scatter"(%arg1, %18, %20) : (!tt.ptr<f32>, tensor<4xi32>, tensor<4xf32>) -> ()
      %21 = "arith.addi"(%18, %2) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
      %22 = "arith.addi"(%16#1, %2) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
      "scf.yield"(%21, %22) : (tensor<4xi32>, tensor<4xi32>) -> ()
    }) : (i32, i32, i32, tensor<4xi32>, tensor<4xi32>) -> (tensor<4xi32>, tensor<4xi32>)
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

