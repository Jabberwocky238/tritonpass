"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32) -> (), sym_name = "softmax_kernel_012345", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32):
    %0 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 128 : index}> : () -> index
    %3 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %4 = "arith.muli"(%3, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %5 = "arith.index_cast"(%4) : (i32) -> index
    %6 = "tts.make_tptr"(%arg1, %5) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 128>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<128x!tt.ptr<f32>>
    %7 = "arith.index_cast"(%arg4) : (i32) -> index
    %8 = "arith.minsi"(%7, %2) : (index, index) -> index
    %9 = "arith.maxsi"(%8, %1) : (index, index) -> index
    %10 = "tts.load"(%6, %9, %0) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<128x!tt.ptr<f32>>, index, f32) -> tensor<128xf32>
    %11 = "tt.reduce"(%10) <{axis = 0 : i32}> ({
    ^bb0(%arg7: f32, %arg8: f32):
      %25 = "arith.cmpf"(%arg7, %arg8) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      %26 = "arith.select"(%25, %arg7, %arg8) : (i1, f32, f32) -> f32
      "tt.reduce.return"(%26) : (f32) -> ()
    }) : (tensor<128xf32>) -> f32
    %12 = "tt.splat"(%11) : (f32) -> tensor<128xf32>
    %13 = "arith.subf"(%10, %12) <{fastmath = #arith.fastmath<none>}> : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %14 = "math.exp"(%13) <{fastmath = #arith.fastmath<none>}> : (tensor<128xf32>) -> tensor<128xf32>
    %15 = "tt.reduce"(%14) <{axis = 0 : i32}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      %24 = "arith.addf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "tt.reduce.return"(%24) : (f32) -> ()
    }) : (tensor<128xf32>) -> f32
    %16 = "tt.splat"(%15) : (f32) -> tensor<128xf32>
    %17 = "arith.divf"(%14, %16) <{fastmath = #arith.fastmath<none>}> : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %18 = "arith.muli"(%3, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %19 = "arith.index_cast"(%18) : (i32) -> index
    %20 = "tts.make_tptr"(%arg0, %19) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 128>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<128x!tt.ptr<f32>>
    %21 = "arith.index_cast"(%arg4) : (i32) -> index
    %22 = "arith.minsi"(%21, %2) : (index, index) -> index
    %23 = "arith.maxsi"(%22, %1) : (index, index) -> index
    "tts.store"(%20, %17, %23) <{static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<128x!tt.ptr<f32>>, tensor<128xf32>, index) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

