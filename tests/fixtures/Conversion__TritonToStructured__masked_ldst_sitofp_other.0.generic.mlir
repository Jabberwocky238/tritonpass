"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>, %arg2: i32):
    %0 = "arith.constant"() <{value = 7.000000e+00 : bf16}> : () -> bf16
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 128 : index}> : () -> index
    %3 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 128>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<bf16>) -> tensor<128x!tt.ptr<bf16>>
    %4 = "tts.make_tptr"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 128>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<bf16>) -> tensor<128x!tt.ptr<bf16>>
    %5 = "arith.index_cast"(%arg2) : (i32) -> index
    %6 = "arith.minsi"(%5, %2) : (index, index) -> index
    %7 = "arith.maxsi"(%6, %1) : (index, index) -> index
    %8 = "tts.load"(%3, %7, %0) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<128x!tt.ptr<bf16>>, index, bf16) -> tensor<128xbf16>
    %9 = "arith.index_cast"(%arg2) : (i32) -> index
    %10 = "arith.minsi"(%9, %2) : (index, index) -> index
    %11 = "arith.maxsi"(%10, %1) : (index, index) -> index
    "tts.store"(%4, %8, %11) <{static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<128x!tt.ptr<bf16>>, tensor<128xbf16>, index) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

