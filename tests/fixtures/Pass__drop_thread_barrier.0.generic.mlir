"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>) -> (), sym_name = "one", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>):
    %0 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %1 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %2 = "tt.addptr"(%1, %0) : (tensor<16x!tt.ptr<f32>>, tensor<16xi32>) -> tensor<16x!tt.ptr<f32>>
    %3 = "tt.load"(%2) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<16x!tt.ptr<f32>>) -> tensor<16xf32>
    %4 = "tt.splat"(%arg1) : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %5 = "tt.addptr"(%4, %0) : (tensor<16x!tt.ptr<f32>>, tensor<16xi32>) -> tensor<16x!tt.ptr<f32>>
    "tt.store"(%5, %3) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<16x!tt.ptr<f32>>, tensor<16xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

