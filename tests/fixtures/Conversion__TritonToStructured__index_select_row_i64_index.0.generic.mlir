"builtin.module"() ({
  "tt.func"() <{arg_attrs = [{tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}], function_type = (!tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<i64>, i32) -> (), sym_name = "index_select_row_kernel", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<i64>, %arg3: i32):
    %0 = "tts.make_tptr"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<i64>) -> tensor<4x!tt.ptr<i64>>
    %1 = "tts.load"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<4x!tt.ptr<i64>>) -> tensor<4xi64>
    %2 = "arith.index_cast"(%arg3) : (i32) -> index
    %3 = "tts.make_gather_scatter_tptr"(%arg0, %1, %2) <{gather_scatter_dim = 0 : i32, operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, sizes = array<i64: 4, 16>, static_offsets = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, tensor<4xi64>, index) -> !tt.ptr<tensor<4x16xf32>>
    %4 = "tts.load"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (!tt.ptr<tensor<4x16xf32>>) -> tensor<4x16xf32>
    %5 = "arith.index_cast"(%arg3) : (i32) -> index
    %6 = "tts.make_tptr"(%arg1, %5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 4, 16>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, index) -> tensor<4x16x!tt.ptr<f32>>
    "tts.store"(%6, %4) <{static_mask_dims = array<i64>}> : (tensor<4x16x!tt.ptr<f32>>, tensor<4x16xf32>) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

