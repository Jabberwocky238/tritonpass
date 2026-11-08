"builtin.module"() ({
  "tt.func"() <{arg_attrs = [{tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {}, {}, {}], function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32):
    %0 = "arith.constant"() <{value = 128 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<128x128xf32>}> : () -> tensor<128x128xf32>
    %2 = "arith.constant"() <{value = 3 : index}> : () -> index
    %3 = "arith.constant"() <{value = 12 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %6 = "arith.muli"(%5, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %7 = "arith.index_cast"(%6) : (i32) -> index
    %8:2 = "scf.for"(%4, %3, %2, %1, %7) ({
    ^bb0(%arg5: index, %arg6: tensor<128x128xf32>, %arg7: index):
      %13 = "arith.addi"(%arg7, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "tts.make_tptr"(%arg1, %13) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 128, 128>, static_offsets = array<i64: -9223372036854775808, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, 1>}> : (!tt.ptr<f32>, index) -> tensor<128x128x!tt.ptr<f32>>
      %15 = "tts.load"(%14) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<128x128x!tt.ptr<f32>>) -> tensor<128x128xf32>
      %16 = "math.exp"(%15) <{fastmath = #arith.fastmath<none>}> : (tensor<128x128xf32>) -> tensor<128x128xf32>
      %17 = "arith.addf"(%arg6, %16) <{fastmath = #arith.fastmath<none>}> : (tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %18 = "arith.addi"(%arg7, %arg5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%17, %18) : (tensor<128x128xf32>, index) -> ()
    }) : (index, index, index, tensor<128x128xf32>, index) -> (tensor<128x128xf32>, index)
    %9 = "arith.muli"(%5, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %10 = "arith.index_cast"(%9) : (i32) -> index
    %11 = "arith.addi"(%10, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %12 = "tts.make_tptr"(%arg0, %11) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 128, 128>, static_offsets = array<i64: -9223372036854775808, 0>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, 1>}> : (!tt.ptr<f32>, index) -> tensor<128x128x!tt.ptr<f32>>
    "tts.store"(%12, %8#0) <{static_mask_dims = array<i64>}> : (tensor<128x128x!tt.ptr<f32>>, tensor<128x128xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

