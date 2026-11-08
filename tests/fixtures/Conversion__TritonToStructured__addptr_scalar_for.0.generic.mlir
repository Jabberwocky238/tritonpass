"builtin.module"() ({
  "tt.func"() <{arg_attrs = [{tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {}, {}, {}], function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<1024xf32>}> : () -> tensor<1024xf32>
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "arith.constant"() <{value = 12 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %5 = "arith.muli"(%4, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "arith.index_cast"(%5) : (i32) -> index
    %7:2 = "scf.for"(%3, %2, %1, %6, %0) ({
    ^bb0(%arg5: index, %arg6: index, %arg7: tensor<1024xf32>):
      %11 = "tts.make_tptr"(%arg1, %arg6) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 1024>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<1024x!tt.ptr<f32>>
      %12 = "tts.load"(%11) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<1024x!tt.ptr<f32>>) -> tensor<1024xf32>
      %13 = "math.exp"(%12) <{fastmath = #arith.fastmath<none>}> : (tensor<1024xf32>) -> tensor<1024xf32>
      %14 = "arith.addf"(%arg7, %13) <{fastmath = #arith.fastmath<none>}> : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %15 = "arith.addi"(%arg6, %arg5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%15, %14) : (index, tensor<1024xf32>) -> ()
    }) : (index, index, index, index, tensor<1024xf32>) -> (index, tensor<1024xf32>)
    %8 = "arith.muli"(%4, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %9 = "arith.index_cast"(%8) : (i32) -> index
    %10 = "tts.make_tptr"(%arg0, %9) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 1024>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<1024x!tt.ptr<f32>>
    "tts.store"(%10, %7#1) <{static_mask_dims = array<i64>}> : (tensor<1024x!tt.ptr<f32>>, tensor<1024xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

