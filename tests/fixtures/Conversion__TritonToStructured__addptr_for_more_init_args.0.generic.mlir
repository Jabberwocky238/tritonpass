"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3 : index}> : () -> index
    %4 = "arith.constant"() <{value = 12 : index}> : () -> index
    %5 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %6:5 = "scf.for"(%0, %4, %3, %1, %5, %2, %5, %3) ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index):
      %7 = "tts.make_tptr"(%arg1, %1, %arg6) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 256>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<bf16>, index, index) -> tensor<256x!tt.ptr<bf16>>
      %8 = "tts.make_tptr"(%arg0, %1, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 256>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<bf16>, index, index) -> tensor<256x!tt.ptr<bf16>>
      %9 = "tts.load"(%8) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<256x!tt.ptr<bf16>>) -> tensor<256xbf16>
      "tts.store"(%7, %9) <{static_mask_dims = array<i64>}> : (tensor<256x!tt.ptr<bf16>>, tensor<256xbf16>) -> ()
      %10 = "arith.addi"(%arg4, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %11 = "arith.addi"(%arg3, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "arith.addi"(%arg5, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.addi"(%arg7, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "arith.addi"(%11, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %15 = "arith.addi"(%14, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %16 = "arith.addi"(%arg6, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%11, %10, %12, %16, %13) : (index, index, index, index, index) -> ()
    }) : (index, index, index, index, index, index, index, index) -> (index, index, index, index, index)
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

