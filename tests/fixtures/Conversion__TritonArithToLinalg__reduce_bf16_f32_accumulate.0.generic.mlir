#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (bf16, tensor<4x!tt.ptr<bf16>>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "sum_rows_bf16"}> ({
  ^bb0(%arg0: bf16, %arg1: tensor<4x!tt.ptr<bf16>>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<4x128xbf16>
    %2 = "linalg.fill"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: bf16, %arg15: bf16):
      "linalg.yield"(%arg14) : (bf16) -> ()
    }) : (bf16, tensor<4x128xbf16>) -> tensor<4x128xbf16>
    %3 = "tensor.empty"() : () -> tensor<4xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %5 = "linalg.reduce"(%2, %4) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg10: bf16, %arg11: f32):
      %9 = "arith.extf"(%arg10) : (bf16) -> f32
      %10 = "arith.addf"(%9, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<4x128xbf16>, tensor<4xf32>) -> tensor<4xf32>
    %6 = "tensor.empty"() : () -> tensor<4xbf16>
    %7 = "linalg.generic"(%5, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: bf16):
      %8 = "arith.truncf"(%arg8) : (f32) -> bf16
      "linalg.yield"(%8) : (bf16) -> ()
    }) : (tensor<4xf32>, tensor<4xbf16>) -> tensor<4xbf16>
    "tt.store"(%arg1, %7) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<4x!tt.ptr<bf16>>, tensor<4xbf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (bf16, tensor<4x!tt.ptr<bf16>>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "max_rows_bf16"}> ({
  ^bb0(%arg0: bf16, %arg1: tensor<4x!tt.ptr<bf16>>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<4x128xbf16>
    %2 = "linalg.fill"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: bf16, %arg15: bf16):
      "linalg.yield"(%arg14) : (bf16) -> ()
    }) : (bf16, tensor<4x128xbf16>) -> tensor<4x128xbf16>
    %3 = "tensor.empty"() : () -> tensor<4xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %5 = "linalg.reduce"(%2, %4) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg10: bf16, %arg11: f32):
      %9 = "arith.extf"(%arg10) : (bf16) -> f32
      %10 = "arith.maximumf"(%9, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<4x128xbf16>, tensor<4xf32>) -> tensor<4xf32>
    %6 = "tensor.empty"() : () -> tensor<4xbf16>
    %7 = "linalg.generic"(%5, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: bf16):
      %8 = "arith.truncf"(%arg8) : (f32) -> bf16
      "linalg.yield"(%8) : (bf16) -> ()
    }) : (tensor<4xf32>, tensor<4xbf16>) -> tensor<4xbf16>
    "tt.store"(%arg1, %7) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<4x!tt.ptr<bf16>>, tensor<4xbf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (bf16, !tt.ptr<bf16>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "max_all_bf16"}> ({
  ^bb0(%arg0: bf16, %arg1: !tt.ptr<bf16>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<128xbf16>
    %2 = "linalg.fill"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: bf16, %arg13: bf16):
      "linalg.yield"(%arg12) : (bf16) -> ()
    }) : (bf16, tensor<128xbf16>) -> tensor<128xbf16>
    %3 = "tensor.empty"() : () -> tensor<f32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %5 = "linalg.reduce"(%2, %4) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg8: bf16, %arg9: f32):
      %8 = "arith.extf"(%arg8) : (bf16) -> f32
      %9 = "arith.maximumf"(%8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%9) : (f32) -> ()
    }) : (tensor<128xbf16>, tensor<f32>) -> tensor<f32>
    %6 = "tensor.extract"(%5) : (tensor<f32>) -> f32
    %7 = "arith.truncf"(%6) : (f32) -> bf16
    "tt.store"(%arg1, %7) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<bf16>, bf16) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, tensor<4x!tt.ptr<f32>>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "sum_rows_f32"}> ({
  ^bb0(%arg0: f32, %arg1: tensor<4x!tt.ptr<f32>>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<4x128xf32>
    %2 = "linalg.fill"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, tensor<4x128xf32>) -> tensor<4x128xf32>
    %3 = "tensor.empty"() : () -> tensor<4xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %5 = "linalg.reduce"(%2, %4) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %6 = "arith.addf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<4x128xf32>, tensor<4xf32>) -> tensor<4xf32>
    "tt.store"(%arg1, %5) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<4x!tt.ptr<f32>>, tensor<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

