"builtin.module"() ({
  "tt.func"() <{arg_attrs = [{tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {}, {}, {}], function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32):
    %0 = "arith.constant"() <{value = 128 : index}> : () -> index
    %1 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %2 = "arith.muli"(%1, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %3 = "arith.index_cast"(%2) : (i32) -> index
    %4 = "arith.addi"(%3, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %5 = "tts.make_tptr"(%arg1, %4) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 128, 128>, static_offsets = array<i64: -9223372036854775808, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, 1>}> : (!tt.ptr<f32>, index) -> tensor<128x128x!tt.ptr<f32>>
    %6 = "tts.load"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<128x128x!tt.ptr<f32>>) -> tensor<128x128xf32>
    %7 = "math.exp"(%6) <{fastmath = #arith.fastmath<none>}> : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %8 = "arith.muli"(%1, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %9 = "arith.index_cast"(%8) : (i32) -> index
    %10 = "arith.addi"(%9, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %11 = "tts.make_tptr"(%arg0, %10) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 128, 128>, static_offsets = array<i64: -9223372036854775808, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, 1>}> : (!tt.ptr<f32>, index) -> tensor<128x128x!tt.ptr<f32>>
    "tts.store"(%11, %7) <{static_mask_dims = array<i64>}> : (tensor<128x128x!tt.ptr<f32>>, tensor<128x128xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

