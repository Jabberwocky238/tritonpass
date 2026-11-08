"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i64>, !tt.ptr<f32>) -> (), sym_name = "test"}> ({
  ^bb0(%arg0: !tt.ptr<i64>, %arg1: !tt.ptr<f32>):
    %0 = "tt.load"(%arg0) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i64>) -> i64
    %1 = "tt.int_to_ptr"(%0) : (i64) -> !tt.ptr<f16>
    %2 = "tt.make_range"() <{end = 32 : i32, start = 0 : i32}> : () -> tensor<32xi32>
    %3 = "tts.make_tptr"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 0>}> : (!tt.ptr<f16>) -> tensor<32x!tt.ptr<f16>>
    %4 = "tt.splat"(%1) : (!tt.ptr<f16>) -> tensor<32x!tt.ptr<f16>>
    %5 = "tts.make_tptr"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f16>) -> tensor<32x!tt.ptr<f16>>
    %6 = "tt.addptr"(%4, %2) : (tensor<32x!tt.ptr<f16>>, tensor<32xi32>) -> tensor<32x!tt.ptr<f16>>
    %7 = "tts.load"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<f16>>) -> tensor<32xf16>
    %8 = "tt.bitcast"(%arg1) : (!tt.ptr<f32>) -> !tt.ptr<f16>
    %9 = "tts.make_tptr"(%8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 0>}> : (!tt.ptr<f16>) -> tensor<32x!tt.ptr<f16>>
    %10 = "tt.splat"(%8) : (!tt.ptr<f16>) -> tensor<32x!tt.ptr<f16>>
    %11 = "tts.make_tptr"(%8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f16>) -> tensor<32x!tt.ptr<f16>>
    %12 = "tt.addptr"(%10, %2) : (tensor<32x!tt.ptr<f16>>, tensor<32xi32>) -> tensor<32x!tt.ptr<f16>>
    "tts.store"(%11, %7) <{static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<f16>>, tensor<32xf16>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

