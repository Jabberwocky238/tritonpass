"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "simple_cf_into_structured_load", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 6 : index}> : () -> index
    %3 = "arith.cmpi"(%arg2, %0) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %4 = "scf.if"(%3) ({
      %9 = "arith.muli"(%arg2, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %10 = "tt.addptr"(%arg0, %9) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "scf.yield"(%10) : (!tt.ptr<f32>) -> ()
    }, {
      %8 = "tt.addptr"(%arg0, %arg2) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "scf.yield"(%8) : (!tt.ptr<f32>) -> ()
    }) : (i1) -> !tt.ptr<f32>
    %5 = "tts.make_tptr"(%4, %2) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<4x!tt.ptr<f32>>
    %6 = "tts.load"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<4x!tt.ptr<f32>>) -> tensor<4xf32>
    %7 = "tts.make_tptr"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 4>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<4x!tt.ptr<f32>>
    "tts.store"(%7, %6) <{static_mask_dims = array<i64>}> : (tensor<4x!tt.ptr<f32>>, tensor<4xf32>) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

