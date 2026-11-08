"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i8>, index) -> tensor<1x32xi8>, sym_name = "load_row", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i8>, %arg1: index):
    %0 = "tts.make_tptr"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<i8>, index) -> tensor<32x!tt.ptr<i8>>
    %1 = "tts.load"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<i8>>) -> tensor<32xi8>
    %2 = "tensor.expand_shape"(%1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 32>}> : (tensor<32xi8>) -> tensor<1x32xi8>
    "tt.return"(%2) : (tensor<1x32xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> tensor<32x1xf32>, sym_name = "load_col", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>):
    %0 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 64>}> : (!tt.ptr<f32>) -> tensor<32x!tt.ptr<f32>>
    %1 = "tts.load"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<f32>>) -> tensor<32xf32>
    %2 = "tensor.expand_shape"(%1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 32, 1>}> : (tensor<32xf32>) -> tensor<32x1xf32>
    "tt.return"(%2) : (tensor<32x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, index, index) -> tensor<1x32xf32>, sym_name = "load_masked", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: index, %arg2: index):
    %0 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<32x!tt.ptr<f32>>
    %1 = "arith.muli"(%arg2, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %2 = "tts.load"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1, 0>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<32x!tt.ptr<f32>>, index) -> tensor<32xf32>
    %3 = "tensor.expand_shape"(%2) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 32>}> : (tensor<32xf32>) -> tensor<1x32xf32>
    "tt.return"(%3) : (tensor<1x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, tensor<1x32xf32>) -> (), sym_name = "store_row", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: tensor<1x32xf32>):
    %0 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<32x!tt.ptr<f32>>
    %1 = "tensor.collapse_shape"(%arg1) <{reassociation = [[0, 1]]}> : (tensor<1x32xf32>) -> tensor<32xf32>
    "tts.store"(%0, %1) <{static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> tensor<16x32xf32>, sym_name = "untouched", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>):
    %0 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 16, 32>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 32, 1>}> : (!tt.ptr<f32>) -> tensor<16x32x!tt.ptr<f32>>
    %1 = "tts.load"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<16x32x!tt.ptr<f32>>) -> tensor<16x32xf32>
    "tt.return"(%1) : (tensor<16x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> (tensor<1x32xf32>, tensor<1x32xf32>), sym_name = "load_static_mask", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>):
    %0 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<32x!tt.ptr<f32>>
    %1 = "tts.load"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64: 20>}> : (tensor<32x!tt.ptr<f32>>) -> tensor<32xf32>
    %2 = "tensor.expand_shape"(%1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 32>}> : (tensor<32xf32>) -> tensor<1x32xf32>
    %3 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<32x!tt.ptr<f32>>
    %4 = "tts.load"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64: 0>}> : (tensor<32x!tt.ptr<f32>>) -> tensor<32xf32>
    %5 = "tensor.expand_shape"(%4) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 32>}> : (tensor<32xf32>) -> tensor<1x32xf32>
    "tt.return"(%2, %5) : (tensor<1x32xf32>, tensor<1x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, index) -> tensor<4x1x8xf32>, sym_name = "load_middle", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: index):
    %0 = "arith.constant"() <{value = 16 : index}> : () -> index
    %1 = "arith.addi"(%0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %2 = "tts.make_tptr"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 4, 8>, static_offsets = array<i64: -9223372036854775808, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 8, 1>}> : (!tt.ptr<f32>, index) -> tensor<4x8x!tt.ptr<f32>>
    %3 = "tts.load"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<4x8x!tt.ptr<f32>>) -> tensor<4x8xf32>
    %4 = "tensor.expand_shape"(%3) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 4, 1, 8>}> : (tensor<4x8xf32>) -> tensor<4x1x8xf32>
    "tt.return"(%4) : (tensor<4x1x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> tensor<1x1xf32>, sym_name = "load_all_units", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>):
    %0 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 1>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 0>}> : (!tt.ptr<f32>) -> tensor<1x!tt.ptr<f32>>
    %1 = "tts.load"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<1x!tt.ptr<f32>>) -> tensor<1xf32>
    %2 = "tensor.expand_shape"(%1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 1>}> : (tensor<1xf32>) -> tensor<1x1xf32>
    "tt.return"(%2) : (tensor<1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, tensor<4x4x1xf32>, index) -> (), sym_name = "split_window_keeps_carrier", sym_visibility = "public"}> ({
  ^bb0(%arg1: !tt.ptr<f32>, %arg2: tensor<4x4x1xf32>, %arg3: index):
    %3 = "tts.make_tptr"(%arg1, %arg3) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 4, 4, 1>, static_offsets = array<i64: 0, 0, -9223372036854775808>, static_shape = array<i64: 0, 0, 0>, static_strides = array<i64: 512, 16, 0>}> : (!tt.ptr<f32>, index) -> tensor<4x4x1x!tt.ptr<f32>>
    "tts.store"(%3, %arg2) <{static_mask_dims = array<i64>}> : (tensor<4x4x1x!tt.ptr<f32>>, tensor<4x4x1xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> tensor<1x32xf32>, sym_name = "other_window_squeezed", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>):
    %0 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<32x!tt.ptr<f32>>
    %1 = "tts.load"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<f32>>) -> tensor<32xf32>
    %2 = "tensor.expand_shape"(%1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 32>}> : (tensor<32xf32>) -> tensor<1x32xf32>
    "tt.return"(%2) : (tensor<1x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, tensor<4x4x1xf32>, !tt.ptr<f32>) -> tensor<1x32xf32>, sym_name = "whole_kernel_keeps_unit_dims", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: tensor<4x4x1xf32>, %arg2: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = 7 : index}> : () -> index
    %1 = "tts.make_tptr"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 4, 4, 1>, static_offsets = array<i64: 0, 0, -9223372036854775808>, static_shape = array<i64: 0, 0, 0>, static_strides = array<i64: 512, 16, 0>}> : (!tt.ptr<f32>, index) -> tensor<4x4x1x!tt.ptr<f32>>
    "tts.store"(%1, %arg1) <{static_mask_dims = array<i64>}> : (tensor<4x4x1x!tt.ptr<f32>>, tensor<4x4x1xf32>) -> ()
    %2 = "tts.make_tptr"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 1, 32>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 0, 1>}> : (!tt.ptr<f32>) -> tensor<1x32x!tt.ptr<f32>>
    %3 = "tts.load"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<1x32x!tt.ptr<f32>>) -> tensor<1x32xf32>
    "tt.return"(%3) : (tensor<1x32xf32>) -> ()
  }) : () -> ()
}) {dope.keep_unit_dims} : () -> ()

