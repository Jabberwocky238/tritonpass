"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i8>) -> tensor<2x2xi8>, sym_name = "nested_bool_and_mask_fallback", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i8>):
    %0 = "arith.constant"() <{value = -128 : i8}> : () -> i8
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 3 : index}> : () -> index
    %3 = "tts.make_tptr"(%arg0, %2, %1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<i8>, index, index) -> tensor<2x2x!tt.ptr<i8>>
    %4 = "tts.load"(%3, %0) <{operandSegmentSizes = array<i32: 1, 0, 1>, static_mask_dims = array<i64: 2, 2>}> : (tensor<2x2x!tt.ptr<i8>>, i8) -> tensor<2x2xi8>
    "tt.return"(%4) : (tensor<2x2xi8>) -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

