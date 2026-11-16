"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, i32) -> (), sym_name = "descriptors", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: i32):
    %0 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "tt.make_tensor_descriptor"(%arg0, %arg1, %0) <{padding = 2 : i32}> : (!tt.ptr<f32>, i32, i64) -> !tt.tensordesc<tensor<16xf32>>
    %3 = "tt.make_tensor_descriptor"(%arg0, %arg1, %0) <{padding = 1 : i32}> : (!tt.ptr<f32>, i32, i64) -> !tt.tensordesc<tensor<16xf32>>
    %4 = "tt.descriptor_load"(%2, %1) <{cache = 1 : i32, evict = 1 : i32}> : (!tt.tensordesc<tensor<16xf32>>, i32) -> tensor<16xf32>
    "tt.descriptor_store"(%3, %4, %1) : (!tt.tensordesc<tensor<16xf32>>, tensor<16xf32>, i32) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

