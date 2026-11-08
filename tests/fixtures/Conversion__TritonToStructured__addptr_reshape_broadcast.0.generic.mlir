"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>):
    %0 = "arith.constant"() <{value = 6 : index}> : () -> index
    %1 = "tts.make_tptr"(%arg1, %0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 256, 128>, static_offsets = array<i64: 512, 6144>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, -9223372036854775808>}> : (!tt.ptr<bf16>, index) -> tensor<256x128x!tt.ptr<bf16>>
    %2 = "tts.load"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<256x128x!tt.ptr<bf16>>) -> tensor<256x128xbf16>
    "tts.store"(%1, %2) <{static_mask_dims = array<i64>}> : (tensor<256x128x!tt.ptr<bf16>>, tensor<256x128xbf16>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

