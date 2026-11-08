"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: i32):
    %0 = "arith.constant"() <{value = 256 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<4x256xbf16>}> : () -> tensor<4x256xbf16>
    %3 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 3 : index}> : () -> index
    %5 = "arith.constant"() <{value = 12 : index}> : () -> index
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 1, 256>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 0, 1>}> : (!tt.ptr<bf16>) -> tensor<1x256x!tt.ptr<bf16>>
    %8 = "tts.load"(%7) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<1x256x!tt.ptr<bf16>>) -> tensor<1x256xbf16>
    %9 = "arith.index_cast"(%arg1) : (i32) -> index
    %10 = "tts.make_tptr"(%arg0, %9) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 1, 256>, static_offsets = array<i64: -9223372036854775808, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 0, 1>}> : (!tt.ptr<bf16>, index) -> tensor<1x256x!tt.ptr<bf16>>
    "tts.store"(%10, %8) <{static_mask_dims = array<i64>}> : (tensor<1x256x!tt.ptr<bf16>>, tensor<1x256xbf16>) -> ()
    %11:2 = "scf.for"(%6, %5, %4, %2, %6) ({
    ^bb0(%arg2: index, %arg3: tensor<4x256xbf16>, %arg4: index):
      %13 = "arith.index_cast"(%arg2) : (index) -> i32
      %14 = "arith.muli"(%13, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %15 = "arith.index_cast"(%14) : (i32) -> index
      %16 = "tts.make_tptr"(%arg0, %15, %1, %arg4, %6) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 4, 256>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index, index, index) -> tensor<4x256x!tt.ptr<bf16>>
      %17 = "tts.load"(%16) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<4x256x!tt.ptr<bf16>>) -> tensor<4x256xbf16>
      %18 = "arith.addf"(%arg3, %17) <{fastmath = #arith.fastmath<none>}> : (tensor<4x256xbf16>, tensor<4x256xbf16>) -> tensor<4x256xbf16>
      %19 = "arith.addi"(%arg4, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%18, %19) : (tensor<4x256xbf16>, index) -> ()
    }) : (index, index, index, tensor<4x256xbf16>, index) -> (tensor<4x256xbf16>, index)
    %12 = "tts.make_tptr"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 4, 256>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<bf16>, index) -> tensor<4x256x!tt.ptr<bf16>>
    "tts.store"(%12, %11#0) <{static_mask_dims = array<i64>}> : (tensor<4x256x!tt.ptr<bf16>>, tensor<4x256xbf16>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

