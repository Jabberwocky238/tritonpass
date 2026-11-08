"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>) -> (), sym_name = "gather_simple", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = dense<64> : tensor<64xi32>}> : () -> tensor<64xi32>
    %4 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = dense<10> : tensor<64xi32>}> : () -> tensor<64xi32>
    %7 = "tt.make_range"() <{end = 64 : i32, start = 0 : i32}> : () -> tensor<64xi32>
    %8:2 = "scf.for"(%0, %2, %1, %7, %7) ({
    ^bb0(%arg2: i32, %arg3: tensor<64xi32>, %arg4: tensor<64xi32>):
      %9 = "arith.divsi"(%arg3, %6) : (tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
      %10 = "arith.addi"(%arg2, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %11 = "arith.remsi"(%10, %4) : (i32, i32) -> i32
      %12 = "tt.splat"(%11) : (i32) -> tensor<64xi32>
      %13 = "arith.addi"(%9, %12) <{overflowFlags = #arith.overflow<none>}> : (tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
      %14 = "tts.gather"(%arg0, %13) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<64xi32>) -> tensor<64xf32>
      "tts.scatter"(%arg1, %arg4, %14) : (!tt.ptr<f32>, tensor<64xi32>, tensor<64xf32>) -> ()
      %15 = "arith.addi"(%13, %3) <{overflowFlags = #arith.overflow<none>}> : (tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
      %16 = "arith.addi"(%arg4, %3) <{overflowFlags = #arith.overflow<none>}> : (tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
      "scf.yield"(%15, %16) : (tensor<64xi32>, tensor<64xi32>) -> ()
    }) : (i32, i32, i32, tensor<64xi32>, tensor<64xi32>) -> (tensor<64xi32>, tensor<64xi32>)
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

