"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, !tt.ptr<bf16>, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "matmul_kernel_with_block_pointers_01234567891011", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>, %arg2: !tt.ptr<bf16>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32):
    %0 = "arith.constant"() <{value = 64 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<128x64xbf16>}> : () -> tensor<128x64xbf16>
    %3 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %6 = "arith.index_cast"(%arg6) : (i32) -> index
    %7 = "arith.index_cast"(%arg12) : (i32) -> index
    %8 = "arith.muli"(%7, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %9 = "arith.index_cast"(%arg3) : (i32) -> index
    %10 = "arith.index_cast"(%arg7) : (i32) -> index
    %11 = "arith.index_cast"(%arg5) : (i32) -> index
    %12 = "arith.muli"(%10, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %13:3 = "scf.for"(%4, %arg5, %3, %2, %12, %8) ({
    ^bb0(%arg14: i32, %arg15: tensor<128x64xbf16>, %arg16: index, %arg17: index):
      %24 = "tts.make_tptr"(%arg0, %6, %10, %arg17, %1, %9, %11) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, order = array<i32: 1, 0>, sizes = array<i64: 128, 64>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index, index, index, index, index) -> !tt.ptr<tensor<128x64xbf16>>
      %25 = "tts.make_tptr"(%arg0, %6, %10, %8, %arg16, %9, %11) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, order = array<i32: 1, 0>, sizes = array<i64: 128, 64>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index, index, index, index, index) -> !tt.ptr<tensor<128x64xbf16>>
      %26 = "tts.load"(%25) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (!tt.ptr<tensor<128x64xbf16>>) -> tensor<128x64xbf16>
      %27 = "tts.load"(%24) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (!tt.ptr<tensor<128x64xbf16>>) -> tensor<128x64xbf16>
      %28 = "arith.addf"(%26, %27) <{fastmath = #arith.fastmath<none>}> : (tensor<128x64xbf16>, tensor<128x64xbf16>) -> tensor<128x64xbf16>
      %29 = "arith.addf"(%arg15, %28) <{fastmath = #arith.fastmath<none>}> : (tensor<128x64xbf16>, tensor<128x64xbf16>) -> tensor<128x64xbf16>
      %30 = "arith.muli"(%10, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %31 = "arith.addi"(%30, %arg16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %32 = "arith.muli"(%6, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %33 = "arith.addi"(%32, %arg17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%29, %31, %33) : (tensor<128x64xbf16>, index, index) -> ()
    }) : (i32, i32, i32, tensor<128x64xbf16>, index, index) -> (tensor<128x64xbf16>, index, index)
    %14 = "arith.muli"(%arg13, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %15 = "arith.index_cast"(%arg10) : (i32) -> index
    %16 = "arith.index_cast"(%arg12) : (i32) -> index
    %17 = "arith.muli"(%16, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %18 = "arith.index_cast"(%arg3) : (i32) -> index
    %19 = "arith.index_cast"(%arg11) : (i32) -> index
    %20 = "arith.index_cast"(%14) : (i32) -> index
    %21 = "arith.muli"(%20, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %22 = "arith.index_cast"(%arg4) : (i32) -> index
    %23 = "tts.make_tptr"(%arg2, %15, %19, %17, %21, %18, %22) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, order = array<i32: 1, 0>, sizes = array<i64: 128, 64>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index, index, index, index, index) -> !tt.ptr<tensor<128x64xbf16>>
    "tts.store"(%23, %13#0) <{static_mask_dims = array<i64>}> : (!tt.ptr<tensor<128x64xbf16>>, tensor<128x64xbf16>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

