"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f16>, i64, i64, i32) -> (), sym_name = "advance_fold", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f16>, %arg1: i64, %arg2: i64, %arg3: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %2 = "tt.make_tensor_ptr"(%arg0, %arg1, %arg2, %arg2, %1, %0, %0) <{order = array<i32: 1, 0>}> : (!tt.ptr<f16>, i64, i64, i64, i64, i32, i32) -> !tt.ptr<tensor<16x16xf16>>
    %3 = "tt.load"(%2) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<tensor<16x16xf16>>) -> tensor<16x16xf16>
    %4 = "tt.advance"(%2, %0, %arg3) : (!tt.ptr<tensor<16x16xf16>>, i32, i32) -> !tt.ptr<tensor<16x16xf16>>
    "tt.store"(%4, %3) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<tensor<16x16xf16>>, tensor<16x16xf16>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

