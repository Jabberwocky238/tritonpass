"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> (), sym_name = "in_loop", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %4 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %5 = "tt.addptr"(%4, %3) : (tensor<16x!tt.ptr<f32>>, tensor<16xi32>) -> tensor<16x!tt.ptr<f32>>
    "scf.for"(%0, %2, %1) ({
    ^bb0(%arg1: index):
      %6 = "tt.load"(%5) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<16x!tt.ptr<f32>>) -> tensor<16xf32>
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

