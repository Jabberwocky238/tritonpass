"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, i32, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>, %arg2: i32, %arg3: i32):
    %0 = "arith.constant"() <{value = 6 : index}> : () -> index
    %1 = "arith.constant"() <{value = 10 : index}> : () -> index
    %2 = "arith.index_cast"(%arg2) : (i32) -> index
    %3 = "arith.index_cast"(%arg3) : (i32) -> index
    %4 = "arith.addi"(%2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %5 = "arith.addi"(%4, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %6 = "tts.make_tptr"(%arg0, %0, %5) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 4, 256>, static_offsets = array<i64: -9223372036854775808, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index) -> tensor<4x256x!tt.ptr<bf16>>
    %7 = "arith.index_cast"(%arg2) : (i32) -> index
    %8 = "arith.index_cast"(%arg3) : (i32) -> index
    %9 = "arith.addi"(%7, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %10 = "arith.addi"(%9, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %11 = "tts.make_tptr"(%arg1, %0, %10) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 4, 256>, static_offsets = array<i64: -9223372036854775808, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index) -> tensor<4x256x!tt.ptr<bf16>>
    %12 = "tts.load"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<4x256x!tt.ptr<bf16>>) -> tensor<4x256xbf16>
    "tts.store"(%11, %12) <{static_mask_dims = array<i64>}> : (tensor<4x256x!tt.ptr<bf16>>, tensor<4x256xbf16>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

