"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i32>, !tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "sign_extend", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<f32>, %arg3: i32):
    %0 = "arith.constant"() <{value = 1.100000e+01 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "tt.load"(%arg0) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
    %3 = "arith.index_cast"(%2) : (i32) -> index
    %4 = "tts.make_tptr"(%arg1, %3) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<4x!tt.ptr<f32>>
    %5 = "arith.addi"(%3, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %6 = "arith.index_cast"(%arg3) : (i32) -> index
    %7 = "arith.minsi"(%5, %6) : (index, index) -> index
    %8 = "arith.maxsi"(%7, %3) : (index, index) -> index
    %9 = "arith.subi"(%8, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %10 = "tts.load"(%4, %9, %0) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<4x!tt.ptr<f32>>, index, f32) -> tensor<4xf32>
    %11 = "tts.make_tptr"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<4x!tt.ptr<f32>>
    "tts.store"(%11, %10) <{static_mask_dims = array<i64>}> : (tensor<4x!tt.ptr<f32>>, tensor<4xf32>) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

