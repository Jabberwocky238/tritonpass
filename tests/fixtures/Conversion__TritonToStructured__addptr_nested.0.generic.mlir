"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: i32):
    %0 = "arith.constant"() <{value = 15 : index}> : () -> index
    %1 = "arith.constant"() <{value = 10 : index}> : () -> index
    %2 = "arith.constant"() <{value = 5 : index}> : () -> index
    %3 = "arith.index_cast"(%arg1) : (i32) -> index
    %4 = "tts.make_tptr"(%arg0, %2, %3) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 4, 256>, static_offsets = array<i64: -9223372036854775808, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index) -> tensor<4x256x!tt.ptr<bf16>>
    %5 = "tts.load"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<4x256x!tt.ptr<bf16>>) -> tensor<4x256xbf16>
    %6 = "arith.index_cast"(%arg1) : (i32) -> index
    %7 = "arith.addi"(%3, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %8 = "tts.make_tptr"(%arg0, %1, %7) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 4, 256>, static_offsets = array<i64: -9223372036854775808, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 2, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index) -> tensor<4x256x!tt.ptr<bf16>>
    %9 = "tts.load"(%8) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<4x256x!tt.ptr<bf16>>) -> tensor<4x256xbf16>
    %10 = "arith.addf"(%5, %9) <{fastmath = #arith.fastmath<none>}> : (tensor<4x256xbf16>, tensor<4x256xbf16>) -> tensor<4x256xbf16>
    %11 = "arith.index_cast"(%arg1) : (i32) -> index
    %12 = "arith.addi"(%7, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %13 = "tts.make_tptr"(%arg0, %0, %12) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 4, 256>, static_offsets = array<i64: -9223372036854775808, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 3, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index) -> tensor<4x256x!tt.ptr<bf16>>
    "tts.store"(%13, %10) <{static_mask_dims = array<i64>}> : (tensor<4x256x!tt.ptr<bf16>>, tensor<4x256xbf16>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

