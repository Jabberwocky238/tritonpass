"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>) -> (), sym_name = "add_ptr_into_make_block_ptr", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 512 : index}> : () -> index
    %3 = "arith.constant"() <{value = 64 : index}> : () -> index
    %4 = "arith.constant"() <{value = 32768 : i64}> : () -> i64
    %5 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %6 = "arith.extsi"(%5) : (i32) -> i64
    %7 = "arith.muli"(%6, %4) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %8 = "arith.index_cast"(%7) : (i64) -> index
    %9 = "tts.make_tptr"(%arg0, %3, %1, %8, %0, %2, %3) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, order = array<i32: 1, 0>, sizes = array<i64: 512, 64>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index, index, index, index, index) -> !tt.ptr<tensor<512x64xbf16>>
    %10 = "tts.make_tptr"(%arg1, %3, %1, %8, %0, %2, %3) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, order = array<i32: 1, 0>, sizes = array<i64: 512, 64>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index, index, index, index, index) -> !tt.ptr<tensor<512x64xbf16>>
    %11 = "tts.load"(%9) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (!tt.ptr<tensor<512x64xbf16>>) -> tensor<512x64xbf16>
    "tts.store"(%10, %11) <{static_mask_dims = array<i64>}> : (!tt.ptr<tensor<512x64xbf16>>, tensor<512x64xbf16>) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

