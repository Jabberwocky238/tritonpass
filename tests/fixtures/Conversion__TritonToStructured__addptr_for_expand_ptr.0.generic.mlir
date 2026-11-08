"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 12 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %5 = "scf.for"(%1, %2, %3, %4) ({
    ^bb0(%arg1: index, %arg2: index):
      %6 = "tts.make_tptr"(%arg0, %0, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 256, 256>, static_offsets = array<i64: -9223372036854775808, 256>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<bf16>, index, index) -> tensor<256x256x!tt.ptr<bf16>>
      %7 = "tts.load"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<256x256x!tt.ptr<bf16>>) -> tensor<256x256xbf16>
      "tts.store"(%6, %7) <{static_mask_dims = array<i64>}> : (tensor<256x256x!tt.ptr<bf16>>, tensor<256x256xbf16>) -> ()
      %8 = "arith.addi"(%arg2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%8) : (index) -> ()
    }) : (index, index, index, index) -> index
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

