"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f16>) -> (), sym_name = "rank0_block_ptr", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f16>):
    %0 = "tt.make_tensor_ptr"(%arg0) <{order = array<i32>}> : (!tt.ptr<f16>) -> !tt.ptr<tensor<f16>>
    %1 = "tt.load"(%0) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<tensor<f16>>) -> tensor<f16>
    "tt.store"(%0, %1) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<tensor<f16>>, tensor<f16>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

