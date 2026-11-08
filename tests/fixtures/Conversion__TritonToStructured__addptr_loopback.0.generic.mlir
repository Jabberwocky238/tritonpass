"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>, %arg2: i32):
    %0 = "arith.constant"() <{value = 6 : index}> : () -> index
    %1 = "arith.index_cast"(%arg2) : (i32) -> index
    %2 = "tts.make_tptr"(%arg0, %0, %1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 4, 256>, static_offsets = array<i64: -9223372036854775808, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index) -> tensor<4x256x!tt.ptr<bf16>>
    %3 = "arith.index_cast"(%arg2) : (i32) -> index
    %4 = "tts.make_tptr"(%arg1, %0, %3) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 4, 256>, static_offsets = array<i64: -9223372036854775808, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index) -> tensor<4x256x!tt.ptr<bf16>>
    %5 = "tts.load"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<4x256x!tt.ptr<bf16>>) -> tensor<4x256xbf16>
    "tts.store"(%4, %5) <{static_mask_dims = array<i64>}> : (tensor<4x256x!tt.ptr<bf16>>, tensor<4x256xbf16>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

