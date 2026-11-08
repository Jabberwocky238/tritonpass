"builtin.module"() ({
  "tt.func"() <{arg_attrs = [{tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}], function_type = (!tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "mask_loop", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<f32>, %arg3: i32):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %7 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %8 = "tt.get_num_programs"() <{axis = 0 : i32}> : () -> i32
    %9 = "arith.muli"(%8, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %10 = "arith.index_cast"(%9) : (i32) -> index
    %11 = "arith.addi"(%arg3, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %12 = "arith.divsi"(%11, %3) : (i32, i32) -> i32
    %13 = "arith.muli"(%7, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %14 = "arith.index_cast"(%13) : (i32) -> index
    %15 = "scf.for"(%5, %12, %4, %14) ({
    ^bb0(%arg4: i32, %arg5: index):
      %16 = "tts.make_tptr"(%arg1, %1, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 2>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<f32>, index, index) -> tensor<2x!tt.ptr<f32>>
      %17 = "arith.addi"(%arg5, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %18 = "arith.index_cast"(%arg3) : (i32) -> index
      %19 = "arith.minsi"(%17, %18) : (index, index) -> index
      %20 = "arith.maxsi"(%19, %arg5) : (index, index) -> index
      %21 = "arith.subi"(%20, %arg5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %22 = "tts.load"(%16, %21) <{operandSegmentSizes = array<i32: 1, 1, 0>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<2x!tt.ptr<f32>>, index) -> tensor<2xf32>
      %23 = "tts.make_tptr"(%arg0, %1, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 2>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<f32>, index, index) -> tensor<2x!tt.ptr<f32>>
      %24 = "arith.addi"(%arg5, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %25 = "arith.index_cast"(%arg3) : (i32) -> index
      %26 = "arith.minsi"(%24, %25) : (index, index) -> index
      %27 = "arith.maxsi"(%26, %arg5) : (index, index) -> index
      %28 = "arith.subi"(%27, %arg5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "tts.store"(%23, %22, %28) <{static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<2x!tt.ptr<f32>>, tensor<2xf32>, index) -> ()
      %29 = "arith.addi"(%arg5, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%29) : (index) -> ()
    }) : (i32, i32, i32, index) -> index
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

