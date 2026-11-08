"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<i32>, !tt.ptr<f32>, i32, i32, i32) -> (), sym_name = "row_gather3", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<i32>, %arg2: !tt.ptr<f32>, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "tts.make_tptr"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<i32>) -> tensor<32x!tt.ptr<i32>>
    %1 = "tts.load"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<i32>>) -> tensor<32xi32>
    %2 = "arith.index_cast"(%arg3) : (i32) -> index
    %3 = "arith.index_cast"(%arg5) : (i32) -> index
    %4 = "arith.index_cast"(%arg4) : (i32) -> index
    %5 = "tts.make_gather_scatter_tptr"(%arg0, %1, %2, %4, %3) <{gather_scatter_dim = 1 : i32, operandSegmentSizes = array<i32: 1, 1, 3, 0, 0>, sizes = array<i64: 32, 32, 32>, static_offsets = array<i64: 0, 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, tensor<32xi32>, index, index, index) -> !tt.ptr<tensor<32x32x32xf32>>
    %6 = "tts.load"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (!tt.ptr<tensor<32x32x32xf32>>) -> tensor<32x32x32xf32>
    %7 = "tts.make_gather_scatter_tptr"(%arg2, %1, %2, %4, %3) <{gather_scatter_dim = 1 : i32, operandSegmentSizes = array<i32: 1, 1, 3, 0, 0>, sizes = array<i64: 32, 32, 32>, static_offsets = array<i64: 0, 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, tensor<32xi32>, index, index, index) -> !tt.ptr<tensor<32x32x32xf32>>
    "tts.store"(%7, %6) <{static_mask_dims = array<i64>}> : (!tt.ptr<tensor<32x32x32xf32>>, tensor<32x32x32xf32>) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

