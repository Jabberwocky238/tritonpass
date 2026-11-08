"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>, %arg2: i32):
    %0 = "arith.constant"() <{value = 11 : index}> : () -> index
    %1 = "arith.constant"() <{value = 20480 : index}> : () -> index
    %2 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %3 = "arith.index_cast"(%2) : (i32) -> index
    %4 = "arith.index_cast"(%2) : (i32) -> index
    %5 = "arith.addi"(%4, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %6 = "tts.make_tptr"(%arg0, %0, %5) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 1024>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<bf16>, index, index) -> tensor<1024x!tt.ptr<bf16>>
    %7 = "tts.make_tptr"(%arg1, %3) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 1024>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<bf16>, index) -> tensor<1024x!tt.ptr<bf16>>
    %8 = "tts.load"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<1024x!tt.ptr<bf16>>) -> tensor<1024xbf16>
    "tts.store"(%7, %8) <{static_mask_dims = array<i64>}> : (tensor<1024x!tt.ptr<bf16>>, tensor<1024xbf16>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

