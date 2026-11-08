"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32) -> (), sym_name = "add_kernel_01234", sym_visibility = "public"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: i32):
    %0 = "arith.constant"() <{value = 1024 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<?xf32>) -> !tt.ptr<f32>
    %3 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<?xf32>) -> !tt.ptr<f32>
    %4 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !tt.ptr<f32>
    %5 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %6 = "arith.muli"(%5, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %7 = "arith.index_cast"(%6) : (i32) -> index
    %8 = "tts.make_tptr"(%4, %7) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 1024>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<1024x!tt.ptr<f32>>
    %9 = "arith.addi"(%7, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %10 = "arith.index_cast"(%arg3) : (i32) -> index
    %11 = "arith.minsi"(%9, %10) : (index, index) -> index
    %12 = "arith.subi"(%11, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %13 = "tts.load"(%8, %12) <{operandSegmentSizes = array<i32: 1, 1, 0>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<1024x!tt.ptr<f32>>, index) -> tensor<1024xf32>
    %14 = "tts.make_tptr"(%3, %7) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 1024>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<1024x!tt.ptr<f32>>
    %15 = "tts.load"(%14, %12) <{operandSegmentSizes = array<i32: 1, 1, 0>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<1024x!tt.ptr<f32>>, index) -> tensor<1024xf32>
    %16 = "arith.addf"(%13, %15) <{fastmath = #arith.fastmath<none>}> : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %17 = "tts.make_tptr"(%2, %7) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 1024>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<1024x!tt.ptr<f32>>
    "tts.store"(%17, %16, %12) <{static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<1024x!tt.ptr<f32>>, tensor<1024xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

