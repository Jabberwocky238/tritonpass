"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>) -> (), sym_name = "tensor_indices_nested", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7:2 = "scf.for"(%2, %4, %1, %5, %5) ({
    ^bb0(%arg2: i32, %arg3: index, %arg4: index):
      %8 = "arith.muli"(%arg2, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %9 = "arith.index_cast"(%8) : (i32) -> index
      %10 = "arith.addi"(%arg3, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %11 = "tts.make_tptr"(%arg0, %6, %10) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<f32>, index, index) -> tensor<4x!tt.ptr<f32>>
      %12 = "tts.load"(%11) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<4x!tt.ptr<f32>>) -> tensor<4xf32>
      %13 = "tts.make_tptr"(%arg1, %6, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<f32>, index, index) -> tensor<4x!tt.ptr<f32>>
      "tts.store"(%13, %12) <{static_mask_dims = array<i64>}> : (tensor<4x!tt.ptr<f32>>, tensor<4xf32>) -> ()
      %14 = "arith.addi"(%10, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %15 = "arith.addi"(%arg4, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %16:2 = "scf.for"(%2, %3, %1, %14, %15) ({
      ^bb0(%arg5: i32, %arg6: index, %arg7: index):
        %17 = "arith.muli"(%arg5, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %18 = "arith.index_cast"(%17) : (i32) -> index
        %19 = "arith.addi"(%arg6, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %20 = "tts.make_tptr"(%arg0, %6, %19) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<f32>, index, index) -> tensor<4x!tt.ptr<f32>>
        %21 = "tts.load"(%20) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<4x!tt.ptr<f32>>) -> tensor<4xf32>
        %22 = "tts.make_tptr"(%arg1, %6, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<f32>, index, index) -> tensor<4x!tt.ptr<f32>>
        "tts.store"(%22, %21) <{static_mask_dims = array<i64>}> : (tensor<4x!tt.ptr<f32>>, tensor<4xf32>) -> ()
        %23 = "arith.addi"(%19, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %24 = "arith.addi"(%arg7, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        "scf.yield"(%23, %24) : (index, index) -> ()
      }) : (i32, i32, i32, index, index) -> (index, index)
      "scf.yield"(%16#0, %16#1) : (index, index) -> ()
    }) : (i32, i32, i32, index, index) -> (index, index)
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

