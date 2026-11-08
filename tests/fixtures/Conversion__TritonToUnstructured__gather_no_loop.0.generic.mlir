"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>) -> (), sym_name = "gather_simple_no_loop", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = dense<5> : tensor<64xi32>}> : () -> tensor<64xi32>
    %1 = "arith.constant"() <{value = dense<10> : tensor<64xi32>}> : () -> tensor<64xi32>
    %2 = "tt.make_range"() <{end = 64 : i32, start = 0 : i32}> : () -> tensor<64xi32>
    %3 = "arith.divsi"(%2, %1) : (tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
    %4 = "arith.addi"(%3, %0) <{overflowFlags = #arith.overflow<none>}> : (tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
    %5 = "tts.gather"(%arg0, %4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<64xi32>) -> tensor<64xf32>
    "tts.scatter"(%arg1, %2, %5) : (!tt.ptr<f32>, tensor<64xi32>, tensor<64xf32>) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

