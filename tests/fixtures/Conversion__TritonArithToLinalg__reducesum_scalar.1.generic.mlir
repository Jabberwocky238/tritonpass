#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<128xi32>
    %2 = "linalg.generic"(%1) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg11: i32):
      %15 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %16 = "arith.index_cast"(%15) : (index) -> i32
      "linalg.yield"(%16) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %3 = "tensor.empty"() : () -> tensor<128x!tt.ptr<bf16>>
    %4 = "linalg.fill"(%arg0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: !tt.ptr<bf16>, %arg10: !tt.ptr<bf16>):
      "linalg.yield"(%arg9) : (!tt.ptr<bf16>) -> ()
    }) : (!tt.ptr<bf16>, tensor<128x!tt.ptr<bf16>>) -> tensor<128x!tt.ptr<bf16>>
    %5 = "linalg.generic"(%4, %2, %4) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: !tt.ptr<bf16>, %arg7: i32, %arg8: !tt.ptr<bf16>):
      %14 = "tt.addptr"(%arg6, %arg7) : (!tt.ptr<bf16>, i32) -> !tt.ptr<bf16>
      "linalg.yield"(%14) : (!tt.ptr<bf16>) -> ()
    }) : (tensor<128x!tt.ptr<bf16>>, tensor<128xi32>, tensor<128x!tt.ptr<bf16>>) -> tensor<128x!tt.ptr<bf16>>
    %6 = "tt.load"(%5) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<128x!tt.ptr<bf16>>) -> tensor<128xbf16>
    %7 = "tensor.empty"() : () -> tensor<f32>
    %8 = "linalg.fill"(%0, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %9 = "linalg.reduce"(%6, %8) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg2: bf16, %arg3: f32):
      %12 = "arith.extf"(%arg2) : (bf16) -> f32
      %13 = "arith.addf"(%12, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%13) : (f32) -> ()
    }) : (tensor<128xbf16>, tensor<f32>) -> tensor<f32>
    %10 = "tensor.extract"(%9) : (tensor<f32>) -> f32
    %11 = "arith.truncf"(%10) : (f32) -> bf16
    "tt.store"(%arg1, %11) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<bf16>, bf16) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

