"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, i32, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>, %arg2: i32, %arg3: i32):
    %0 = "arith.constant"() <{value = 0xFF80 : bf16}> : () -> bf16
    %1 = "arith.constant"() <{value = 256 : index}> : () -> index
    %2 = "arith.constant"() <{value = 128 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3 : index}> : () -> index
    %4 = "arith.constant"() <{value = 259 : index}> : () -> index
    %5 = "arith.constant"() <{value = 130 : index}> : () -> index
    %6 = "arith.constant"() <{value = 2 : index}> : () -> index
    %7 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %8 = "tts.make_tptr"(%arg0, %7, %6) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 128, 256>, static_offsets = array<i64: -9223372036854775808, 3072>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index) -> tensor<128x256x!tt.ptr<bf16>>
    %9 = "tts.make_tptr"(%arg1, %7, %6) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 128, 256>, static_offsets = array<i64: -9223372036854775808, 3072>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index) -> tensor<128x256x!tt.ptr<bf16>>
    %10 = "arith.index_cast"(%arg2) : (i32) -> index
    %11 = "arith.minsi"(%10, %5) : (index, index) -> index
    %12 = "arith.maxsi"(%11, %6) : (index, index) -> index
    %13 = "arith.subi"(%12, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %14 = "arith.index_cast"(%arg3) : (i32) -> index
    %15 = "arith.minsi"(%14, %4) : (index, index) -> index
    %16 = "arith.maxsi"(%15, %3) : (index, index) -> index
    %17 = "arith.subi"(%16, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %18 = "arith.minsi"(%13, %2) : (index, index) -> index
    %19 = "arith.minsi"(%17, %1) : (index, index) -> index
    %20 = "tts.load"(%8, %18, %19, %0) <{operandSegmentSizes = array<i32: 1, 2, 1>, static_mask_dims = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<128x256x!tt.ptr<bf16>>, index, index, bf16) -> tensor<128x256xbf16>
    %21 = "arith.index_cast"(%arg2) : (i32) -> index
    %22 = "arith.minsi"(%21, %5) : (index, index) -> index
    %23 = "arith.maxsi"(%22, %6) : (index, index) -> index
    %24 = "arith.subi"(%23, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %25 = "arith.index_cast"(%arg3) : (i32) -> index
    %26 = "arith.minsi"(%25, %4) : (index, index) -> index
    %27 = "arith.maxsi"(%26, %3) : (index, index) -> index
    %28 = "arith.subi"(%27, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %29 = "arith.minsi"(%24, %2) : (index, index) -> index
    %30 = "arith.minsi"(%28, %1) : (index, index) -> index
    "tts.store"(%9, %20, %29, %30) <{static_mask_dims = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<128x256x!tt.ptr<bf16>>, tensor<128x256xbf16>, index, index) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

