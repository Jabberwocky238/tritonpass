"builtin.module"() ({
  "tt.func"() <{arg_attrs = [{tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {}], function_type = (!tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<i32>, i32, i32, i32) -> (), sym_name = "index_select_row_with_double_mod_kernel2", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<i32>, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = dense<1> : tensor<4x1xi32>}> : () -> tensor<4x1xi32>
    %1 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %2 = "tts.make_tptr"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<i32>) -> tensor<4x!tt.ptr<i32>>
    %3 = "tts.load"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<4x!tt.ptr<i32>>) -> tensor<4xi32>
    %4 = "tt.expand_dims"(%1) <{axis = 1 : i32}> : (tensor<4xi32>) -> tensor<4x1xi32>
    %5 = "tt.splat"(%arg5) : (i32) -> tensor<4x1xi32>
    %6 = "arith.remsi"(%4, %5) : (tensor<4x1xi32>, tensor<4x1xi32>) -> tensor<4x1xi32>
    %7 = "arith.addi"(%6, %0) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x1xi32>, tensor<4x1xi32>) -> tensor<4x1xi32>
    %8 = "tt.reshape"(%7) <{allow_reorder}> : (tensor<4x1xi32>) -> tensor<4xi32>
    %9 = "arith.addi"(%3, %8) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %10 = "arith.index_cast"(%arg3) : (i32) -> index
    %11 = "tts.make_gather_scatter_tptr"(%arg0, %9, %10) <{gather_scatter_dim = 0 : i32, operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, sizes = array<i64: 4, 16>, static_offsets = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, tensor<4xi32>, index) -> !tt.ptr<tensor<4x16xf32>>
    %12 = "tts.load"(%11) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (!tt.ptr<tensor<4x16xf32>>) -> tensor<4x16xf32>
    %13 = "arith.index_cast"(%arg4) : (i32) -> index
    %14 = "tts.make_tptr"(%arg1, %13) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 4, 16>, static_offsets = array<i64: 0, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, index) -> tensor<4x16x!tt.ptr<f32>>
    "tts.store"(%14, %12) <{static_mask_dims = array<i64>}> : (tensor<4x16x!tt.ptr<f32>>, tensor<4x16xf32>) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

