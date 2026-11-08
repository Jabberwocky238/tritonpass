"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i32>, !tt.ptr<f32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: !tt.ptr<f32>):
    %0 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 1024>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<i32>) -> tensor<1024x!tt.ptr<i32>>
    %1 = "tts.make_tptr"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 1024>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<1024x!tt.ptr<f32>>
    %2 = "tts.load"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<1024x!tt.ptr<i32>>) -> tensor<1024xi32>
    %3 = "tt.bitcast"(%2) : (tensor<1024xi32>) -> tensor<1024xf32>
    "tts.store"(%1, %3) <{static_mask_dims = array<i64>}> : (tensor<1024x!tt.ptr<f32>>, tensor<1024xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

