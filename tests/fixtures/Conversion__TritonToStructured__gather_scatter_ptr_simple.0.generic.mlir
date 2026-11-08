"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<i32>, !tt.ptr<f32>) -> (), sym_name = "row_gather", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<i32>, %arg2: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<3> : tensor<8xi32>}> : () -> tensor<8xi32>
    %2 = "arith.constant"() <{value = dense<5> : tensor<8xi32>}> : () -> tensor<8xi32>
    %3 = "tts.make_tptr"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 8>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<i32>) -> tensor<8x!tt.ptr<i32>>
    %4 = "tts.load"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<8x!tt.ptr<i32>>) -> tensor<8xi32>
    %5 = "arith.muli"(%4, %1) <{overflowFlags = #arith.overflow<none>}> : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    %6 = "arith.remsi"(%5, %2) : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    %7 = "tts.make_gather_scatter_tptr"(%arg0, %6, %0) <{gather_scatter_dim = 0 : i32, operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, sizes = array<i64: 8, 8>, static_offsets = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, tensor<8xi32>, index) -> !tt.ptr<tensor<8x8xf32>>
    %8 = "tts.load"(%7) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (!tt.ptr<tensor<8x8xf32>>) -> tensor<8x8xf32>
    %9 = "tts.make_tptr"(%arg2, %0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 8, 8>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, index) -> tensor<8x8x!tt.ptr<f32>>
    "tts.store"(%9, %8) <{static_mask_dims = array<i64>}> : (tensor<8x8x!tt.ptr<f32>>, tensor<8x8xf32>) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

