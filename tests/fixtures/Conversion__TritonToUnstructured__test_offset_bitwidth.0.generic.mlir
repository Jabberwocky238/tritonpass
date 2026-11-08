"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>) -> (), sym_name = "gather_simple", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = dense<64> : tensor<64xi32>}> : () -> tensor<64xi32>
    %4 = "arith.constant"() <{value = dense<10> : tensor<64xi32>}> : () -> tensor<64xi32>
    %5 = "tt.make_range"() <{end = 64 : i32, start = 0 : i32}> : () -> tensor<64xi32>
    %6 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %7 = "arith.divsi"(%5, %4) : (tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
    %8 = "arith.extsi"(%6) : (i32) -> i64
    %9 = "arith.extsi"(%7) : (tensor<64xi32>) -> tensor<64xi64>
    %10 = "tt.splat"(%8) : (i64) -> tensor<64xi64>
    %11 = "arith.addi"(%9, %10) <{overflowFlags = #arith.overflow<none>}> : (tensor<64xi64>, tensor<64xi64>) -> tensor<64xi64>
    %12 = "tt.splat"(%6) : (i32) -> tensor<64xi32>
    %13 = "arith.addi"(%7, %12) <{overflowFlags = #arith.overflow<none>}> : (tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
    %14 = "arith.extsi"(%13) : (tensor<64xi32>) -> tensor<64xi64>
    %15 = "arith.addi"(%11, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<64xi64>, tensor<64xi64>) -> tensor<64xi64>
    %16:2 = "scf.for"(%2, %1, %0, %15, %5) ({
    ^bb0(%arg2: i32, %arg3: tensor<64xi64>, %arg4: tensor<64xi32>):
      %17 = "tts.gather"(%arg0, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<64xi64>) -> tensor<64xf32>
      %18 = "arith.extsi"(%arg4) : (tensor<64xi32>) -> tensor<64xi64>
      "tts.scatter"(%arg1, %18, %17) : (!tt.ptr<f32>, tensor<64xi64>, tensor<64xf32>) -> ()
      %19 = "arith.extsi"(%12) : (tensor<64xi32>) -> tensor<64xi64>
      %20 = "arith.addi"(%arg3, %19) <{overflowFlags = #arith.overflow<none>}> : (tensor<64xi64>, tensor<64xi64>) -> tensor<64xi64>
      %21 = "arith.addi"(%arg4, %3) <{overflowFlags = #arith.overflow<none>}> : (tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
      "scf.yield"(%20, %21) : (tensor<64xi64>, tensor<64xi32>) -> ()
    }) : (i32, i32, i32, tensor<64xi64>, tensor<64xi32>) -> (tensor<64xi64>, tensor<64xi32>)
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

