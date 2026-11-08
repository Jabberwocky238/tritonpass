"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, !tt.ptr<bf16>, i32, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>, %arg2: !tt.ptr<bf16>, %arg3: i32, %arg4: i32):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5 : index}> : () -> index
    %2 = "arith.constant"() <{value = 3 : index}> : () -> index
    %3 = "arith.constant"() <{value = 12 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.index_cast"(%arg3) : (i32) -> index
    %6 = "tts.make_tptr"(%arg0, %1, %5) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 4, 256>, static_offsets = array<i64: -9223372036854775808, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index) -> tensor<4x256x!tt.ptr<bf16>>
    %7 = "tts.load"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<4x256x!tt.ptr<bf16>>) -> tensor<4x256xbf16>
    %8 = "arith.index_cast"(%arg3) : (i32) -> index
    %9:2 = "scf.for"(%4, %3, %2, %7, %8) ({
    ^bb0(%arg5: index, %arg6: tensor<4x256xbf16>, %arg7: index):
      %12 = "tts.make_tptr"(%arg1, %0, %1, %arg7, %4) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 4, 256>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index, index, index) -> tensor<4x256x!tt.ptr<bf16>>
      %13 = "tts.load"(%12) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<4x256x!tt.ptr<bf16>>) -> tensor<4x256xbf16>
      %14 = "arith.addf"(%arg6, %13) <{fastmath = #arith.fastmath<none>}> : (tensor<4x256xbf16>, tensor<4x256xbf16>) -> tensor<4x256xbf16>
      %15 = "arith.addi"(%arg7, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%14, %15) : (tensor<4x256xbf16>, index) -> ()
    }) : (index, index, index, tensor<4x256xbf16>, index) -> (tensor<4x256xbf16>, index)
    %10 = "arith.index_cast"(%arg3) : (i32) -> index
    %11 = "tts.make_tptr"(%arg2, %1, %10) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 4, 256>, static_offsets = array<i64: -9223372036854775808, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index) -> tensor<4x256x!tt.ptr<bf16>>
    "tts.store"(%11, %9#0) <{static_mask_dims = array<i64>}> : (tensor<4x256x!tt.ptr<bf16>>, tensor<4x256xbf16>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

