"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, !tt.ptr<bf16>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>, %arg2: !tt.ptr<bf16>):
    %0 = "arith.constant"() <{value = 256 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<128x256xbf16>}> : () -> tensor<128x256xbf16>
    %2 = "arith.constant"() <{value = 128 : index}> : () -> index
    %3 = "tts.make_tptr"(%arg0, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 128, 64>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<bf16>, index) -> tensor<128x64x!tt.ptr<bf16>>
    %4 = "tts.load"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<128x64x!tt.ptr<bf16>>) -> tensor<128x64xbf16>
    %5 = "tts.make_tptr"(%arg1, %0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 64, 256>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<bf16>, index) -> tensor<64x256x!tt.ptr<bf16>>
    %6 = "tts.load"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<64x256x!tt.ptr<bf16>>) -> tensor<64x256xbf16>
    %7 = "tts.make_tptr"(%arg2, %0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 128, 256>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<bf16>, index) -> tensor<128x256x!tt.ptr<bf16>>
    %8 = "tt.dot"(%4, %6, %1) <{inputPrecision = 2 : i32, maxNumImpreciseAcc = 0 : i32}> : (tensor<128x64xbf16>, tensor<64x256xbf16>, tensor<128x256xbf16>) -> tensor<128x256xbf16>
    "tts.store"(%7, %8) <{static_mask_dims = array<i64>}> : (tensor<128x256x!tt.ptr<bf16>>, tensor<128x256xbf16>) -> ()
    "tts.store"(%7, %1) <{static_mask_dims = array<i64>}> : (tensor<128x256x!tt.ptr<bf16>>, tensor<128x256xbf16>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

