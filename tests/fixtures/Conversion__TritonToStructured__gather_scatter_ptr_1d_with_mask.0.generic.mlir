"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<i32>, !tt.ptr<f32>, i32) -> (), sym_name = "row_gather1d_with_mask", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<i32>, %arg2: !tt.ptr<f32>, %arg3: i32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 32 : index}> : () -> index
    %2 = "tts.make_tptr"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<i32>) -> tensor<32x!tt.ptr<i32>>
    %3 = "tts.load"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<i32>>) -> tensor<32xi32>
    %4 = "tts.make_gather_scatter_tptr"(%arg0, %3) <{gather_scatter_dim = 0 : i32, operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, tensor<32xi32>) -> !tt.ptr<tensor<32xf32>>
    %5 = "arith.index_cast"(%arg3) : (i32) -> index
    %6 = "arith.minsi"(%5, %1) : (index, index) -> index
    %7 = "arith.maxsi"(%6, %0) : (index, index) -> index
    %8 = "tts.load"(%4, %7) <{operandSegmentSizes = array<i32: 1, 1, 0>, static_mask_dims = array<i64: -9223372036854775808>}> : (!tt.ptr<tensor<32xf32>>, index) -> tensor<32xf32>
    %9 = "tts.make_tptr"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<32x!tt.ptr<f32>>
    "tts.store"(%9, %8) <{static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

