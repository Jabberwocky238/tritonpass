"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> (), sym_name = "test_1", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = dense<4> : tensor<4xi32>}> : () -> tensor<4xi32>
    %4 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %5:3 = "tts.get_structured_state"(%4) <{resultSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<4xi32>) -> (tensor<4xi32>, index, index)
    %6 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<4x!tt.ptr<f32>>
    %7:6 = "scf.for"(%2, %1, %0, %5#0, %5#1, %5#2, %5#0, %5#1, %5#2) ({
    ^bb0(%arg1: i32, %arg2: tensor<4xi32>, %arg3: index, %arg4: index, %arg5: tensor<4xi32>, %arg6: index, %arg7: index):
      %8 = "tt.addptr"(%6, %arg2) : (tensor<4x!tt.ptr<f32>>, tensor<4xi32>) -> tensor<4x!tt.ptr<f32>>
      %9 = "arith.sitofp"(%arg5) : (tensor<4xi32>) -> tensor<4xf32>
      "tt.store"(%8, %9) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<4x!tt.ptr<f32>>, tensor<4xf32>) -> ()
      %10 = "arith.addi"(%arg2, %3) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
      %11:3 = "tts.get_structured_state"(%10) <{resultSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<4xi32>) -> (tensor<4xi32>, index, index)
      %12 = "arith.addi"(%arg5, %3) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
      %13:3 = "tts.get_structured_state"(%12) <{resultSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<4xi32>) -> (tensor<4xi32>, index, index)
      "scf.yield"(%11#0, %11#1, %11#2, %13#0, %13#1, %13#2) : (tensor<4xi32>, index, index, tensor<4xi32>, index, index) -> ()
    }) : (i32, i32, i32, tensor<4xi32>, index, index, tensor<4xi32>, index, index) -> (tensor<4xi32>, index, index, tensor<4xi32>, index, index)
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

