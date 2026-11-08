"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, !tt.ptr<i32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>, %arg2: !tt.ptr<i32>):
    %0 = "arith.constant"() <{value = 6 : index}> : () -> index
    %1 = "tt.make_range"() <{end = 768 : i32, start = 512 : i32}> : () -> tensor<256xi32>
    %2 = "tt.expand_dims"(%1) <{axis = 1 : i32}> : (tensor<256xi32>) -> tensor<256x1xi32>
    %3 = "tt.broadcast"(%2) : (tensor<256x1xi32>) -> tensor<256x128xi32>
    %4 = "tts.make_tptr"(%arg1, %0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 256, 128>, static_offsets = array<i64: 512, 6144>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, -9223372036854775808>}> : (!tt.ptr<bf16>, index) -> tensor<256x128x!tt.ptr<bf16>>
    %5 = "tts.load"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<256x128x!tt.ptr<bf16>>) -> tensor<256x128xbf16>
    "tts.store"(%4, %5) <{static_mask_dims = array<i64>}> : (tensor<256x128x!tt.ptr<bf16>>, tensor<256x128xbf16>) -> ()
    %6 = "tts.make_tptr"(%arg2, %0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 256, 128>, static_offsets = array<i64: 512, 6144>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, -9223372036854775808>}> : (!tt.ptr<i32>, index) -> tensor<256x128x!tt.ptr<i32>>
    "tts.store"(%6, %3) <{static_mask_dims = array<i64>}> : (tensor<256x128x!tt.ptr<i32>>, tensor<256x128xi32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

