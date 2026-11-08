"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, !tt.ptr<bf16>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>, %arg2: !tt.ptr<bf16>):
    %0 = "arith.constant"() <{value = 256 : index}> : () -> index
    %1 = "arith.constant"() <{value = 128 : index}> : () -> index
    %2 = "tts.make_tptr"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 128, 64>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<bf16>, index) -> tensor<128x64x!tt.ptr<bf16>>
    %3 = "tts.load"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<128x64x!tt.ptr<bf16>>) -> tensor<128x64xbf16>
    %4 = "tts.make_tptr"(%arg1, %0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 256, 64>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, -9223372036854775808>}> : (!tt.ptr<bf16>, index) -> tensor<256x64x!tt.ptr<bf16>>
    %5 = "tts.load"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<256x64x!tt.ptr<bf16>>) -> tensor<256x64xbf16>
    %6 = "tt.trans"(%5) <{order = array<i32: 1, 0>}> : (tensor<256x64xbf16>) -> tensor<64x256xbf16>
    %7 = "tts.make_tptr"(%arg2, %0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 128, 256>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<bf16>, index) -> tensor<128x256x!tt.ptr<bf16>>
    %8 = "tts.load"(%7) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<128x256x!tt.ptr<bf16>>) -> tensor<128x256xbf16>
    %9 = "tt.dot"(%3, %6, %8) <{inputPrecision = 2 : i32, maxNumImpreciseAcc = 0 : i32}> : (tensor<128x64xbf16>, tensor<64x256xbf16>, tensor<128x256xbf16>) -> tensor<128x256xbf16>
    "tts.store"(%7, %9) <{static_mask_dims = array<i64>}> : (tensor<128x256x!tt.ptr<bf16>>, tensor<128x256xbf16>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

