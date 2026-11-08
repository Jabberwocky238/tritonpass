"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32) -> (), sym_name = "modulo", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32):
    %0 = "arith.constant"() <{value = 16 : index}> : () -> index
    %1 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %2 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %3 = "arith.muli"(%2, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "arith.index_cast"(%3) : (i32) -> index
    %5 = "arith.index_cast"(%3) : (i32) -> index
    %6 = "arith.index_cast"(%arg3) : (i32) -> index
    %7 = "tts.make_tptr"(%arg0, %5, %6) <{operandSegmentSizes = array<i32: 1, 0, 1, 1>, order = array<i32>, sizes = array<i64: 16>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index, index) -> tensor<16x!tt.ptr<f32>>
    %8 = "arith.index_cast"(%3) : (i32) -> index
    %9 = "arith.addi"(%8, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %10 = "arith.index_cast"(%arg2) : (i32) -> index
    %11 = "arith.minsi"(%9, %10) : (index, index) -> index
    %12 = "arith.maxsi"(%11, %8) : (index, index) -> index
    %13 = "arith.subi"(%12, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %14 = "tts.load"(%7, %13) <{operandSegmentSizes = array<i32: 1, 1, 0>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<16x!tt.ptr<f32>>, index) -> tensor<16xf32>
    %15 = "tts.make_tptr"(%arg1, %4) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 16>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<16x!tt.ptr<f32>>
    %16 = "arith.index_cast"(%3) : (i32) -> index
    %17 = "arith.addi"(%16, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %18 = "arith.index_cast"(%arg2) : (i32) -> index
    %19 = "arith.minsi"(%17, %18) : (index, index) -> index
    %20 = "arith.maxsi"(%19, %16) : (index, index) -> index
    %21 = "arith.subi"(%20, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "tts.store"(%15, %14, %21) <{static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<16x!tt.ptr<f32>>, tensor<16xf32>, index) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

