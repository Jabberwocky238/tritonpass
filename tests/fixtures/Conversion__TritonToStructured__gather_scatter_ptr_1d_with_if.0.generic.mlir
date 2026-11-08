"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32) -> (), sym_name = "gather_row", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32):
    %0 = "arith.constant"() <{value = dense<8> : tensor<4xi32>}> : () -> tensor<4xi32>
    %1 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = dense<4> : tensor<4xi32>}> : () -> tensor<4xi32>
    %3 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %4 = "arith.divsi"(%3, %2) : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %5 = "arith.cmpi"(%arg2, %1) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %6 = "scf.if"(%5) ({
      %10 = "arith.addi"(%4, %0) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
      "scf.yield"(%10) : (tensor<4xi32>) -> ()
    }, {
      "scf.yield"(%4) : (tensor<4xi32>) -> ()
    }) : (i1) -> tensor<4xi32>
    %7 = "tts.make_gather_scatter_tptr"(%arg0, %6) <{gather_scatter_dim = 0 : i32, operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, sizes = array<i64: 4>, static_offsets = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, tensor<4xi32>) -> !tt.ptr<tensor<4xf32>>
    %8 = "tts.make_gather_scatter_tptr"(%arg1, %6) <{gather_scatter_dim = 0 : i32, operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, sizes = array<i64: 4>, static_offsets = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, tensor<4xi32>) -> !tt.ptr<tensor<4xf32>>
    %9 = "tts.load"(%7) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (!tt.ptr<tensor<4xf32>>) -> tensor<4xf32>
    "tts.store"(%8, %9) <{static_mask_dims = array<i64>}> : (!tt.ptr<tensor<4xf32>>, tensor<4xf32>) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

