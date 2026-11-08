#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<32x64x128x!tt.ptr<f16>>, tensor<32x128x256x!tt.ptr<f16>>, tensor<32x64x256x!tt.ptr<f32>>, tensor<32x64x256x!tt.ptr<f32>>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: tensor<32x64x128x!tt.ptr<f16>>, %arg1: tensor<32x128x256x!tt.ptr<f16>>, %arg2: tensor<32x64x256x!tt.ptr<f32>>, %arg3: tensor<32x64x256x!tt.ptr<f32>>):
    %0 = "tt.load"(%arg0) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<32x64x128x!tt.ptr<f16>>) -> tensor<32x64x128xf16>
    %1 = "tt.load"(%arg1) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<32x128x256x!tt.ptr<f16>>) -> tensor<32x128x256xf16>
    %2 = "tt.load"(%arg2) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<32x64x256x!tt.ptr<f32>>) -> tensor<32x64x256xf32>
    %3 = "linalg.batch_matmul"(%0, %1, %2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg4: f16, %arg5: f16, %arg6: f32):
      %4 = "arith.extf"(%arg4) : (f16) -> f32
      %5 = "arith.extf"(%arg5) : (f16) -> f32
      %6 = "arith.mulf"(%4, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %7 = "arith.addf"(%arg6, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) : (tensor<32x64x128xf16>, tensor<32x128x256xf16>, tensor<32x64x256xf32>) -> tensor<32x64x256xf32>
    "tt.store"(%arg3, %3) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x64x256x!tt.ptr<f32>>, tensor<32x64x256xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

