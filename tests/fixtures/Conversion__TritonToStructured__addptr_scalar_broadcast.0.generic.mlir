"builtin.module"() ({
  "tt.func"() <{arg_attrs = [{tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {}, {}, {}], function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32):
    %0 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %1 = "arith.muli"(%0, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "arith.index_cast"(%1) : (i32) -> index
    %3 = "tts.make_tptr"(%arg1, %2) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 1024, 1024>, static_offsets = array<i64: -9223372036854775808, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, 1>}> : (!tt.ptr<f32>, index) -> tensor<1024x1024x!tt.ptr<f32>>
    %4 = "tts.load"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<1024x1024x!tt.ptr<f32>>) -> tensor<1024x1024xf32>
    %5 = "math.exp"(%4) <{fastmath = #arith.fastmath<none>}> : (tensor<1024x1024xf32>) -> tensor<1024x1024xf32>
    %6 = "arith.muli"(%0, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %7 = "arith.index_cast"(%6) : (i32) -> index
    %8 = "tts.make_tptr"(%arg0, %7) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 1024, 1024>, static_offsets = array<i64: -9223372036854775808, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, 1>}> : (!tt.ptr<f32>, index) -> tensor<1024x1024x!tt.ptr<f32>>
    "tts.store"(%8, %5) <{static_mask_dims = array<i64>}> : (tensor<1024x1024x!tt.ptr<f32>>, tensor<1024x1024xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

