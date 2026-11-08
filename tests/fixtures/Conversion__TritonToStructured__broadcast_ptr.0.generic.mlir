"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> tensor<4x4xf32>, sym_name = "row_broadcast_ptr", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>):
    %0 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 4, 4>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 0, 1>}> : (!tt.ptr<f32>) -> tensor<4x4x!tt.ptr<f32>>
    %1 = "tts.load"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<4x4x!tt.ptr<f32>>) -> tensor<4x4xf32>
    "tt.return"(%1) : (tensor<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

