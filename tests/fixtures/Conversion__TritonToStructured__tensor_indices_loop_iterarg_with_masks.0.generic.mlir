"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "addptr_with_masks", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = -1.100000e+01 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7:2 = "scf.for"(%4, %3, %2, %5, %5) ({
    ^bb0(%arg3: i32, %arg4: index, %arg5: index):
      %8 = "tts.make_tptr"(%arg0, %6, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<f32>, index, index) -> tensor<4x!tt.ptr<f32>>
      %9 = "arith.addi"(%arg4, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %10 = "arith.index_cast"(%arg2) : (i32) -> index
      %11 = "arith.minsi"(%9, %10) : (index, index) -> index
      %12 = "arith.maxsi"(%11, %arg4) : (index, index) -> index
      %13 = "arith.subi"(%12, %arg4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "tts.load"(%8, %13, %0) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<4x!tt.ptr<f32>>, index, f32) -> tensor<4xf32>
      %15 = "tts.make_tptr"(%arg1, %6, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<f32>, index, index) -> tensor<4x!tt.ptr<f32>>
      "tts.store"(%15, %14) <{static_mask_dims = array<i64>}> : (tensor<4x!tt.ptr<f32>>, tensor<4xf32>) -> ()
      %16 = "arith.addi"(%arg5, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%9, %16) : (index, index) -> ()
    }) : (i32, i32, i32, index, index) -> (index, index)
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

