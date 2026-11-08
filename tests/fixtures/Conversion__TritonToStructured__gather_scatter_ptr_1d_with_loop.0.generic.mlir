"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32) -> (), sym_name = "gather_row", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = dense<10> : tensor<4xi32>}> : () -> tensor<4xi32>
    %4 = "arith.constant"() <{value = dense<4> : tensor<4xi32>}> : () -> tensor<4xi32>
    %5 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %6 = "arith.divsi"(%5, %4) : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %7 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<4x!tt.ptr<f32>>
    %8 = "tt.addptr"(%7, %6) : (tensor<4x!tt.ptr<f32>>, tensor<4xi32>) -> tensor<4x!tt.ptr<f32>>
    %9 = "tt.splat"(%arg1) : (!tt.ptr<f32>) -> tensor<4x!tt.ptr<f32>>
    %10 = "tt.addptr"(%9, %6) : (tensor<4x!tt.ptr<f32>>, tensor<4xi32>) -> tensor<4x!tt.ptr<f32>>
    %11:2 = "scf.for"(%2, %1, %0, %8, %10) ({
    ^bb0(%arg4: i32, %arg5: tensor<4x!tt.ptr<f32>>, %arg6: tensor<4x!tt.ptr<f32>>):
      %12 = "tt.load"(%arg5) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<4x!tt.ptr<f32>>) -> tensor<4xf32>
      "tt.store"(%arg6, %12) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<4x!tt.ptr<f32>>, tensor<4xf32>) -> ()
      %13 = "tt.addptr"(%arg5, %3) : (tensor<4x!tt.ptr<f32>>, tensor<4xi32>) -> tensor<4x!tt.ptr<f32>>
      %14 = "tt.addptr"(%arg6, %3) : (tensor<4x!tt.ptr<f32>>, tensor<4xi32>) -> tensor<4x!tt.ptr<f32>>
      "scf.yield"(%13, %14) : (tensor<4x!tt.ptr<f32>>, tensor<4x!tt.ptr<f32>>) -> ()
    }) : (i32, i32, i32, tensor<4x!tt.ptr<f32>>, tensor<4x!tt.ptr<f32>>) -> (tensor<4x!tt.ptr<f32>>, tensor<4x!tt.ptr<f32>>)
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

