#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<i32>, !tt.ptr<f16>, tensor<1024x!tt.ptr<bf16>>, tensor<1024x!tt.ptr<f32>>, tensor<1024x!tt.ptr<f32>>, tensor<1024x!tt.ptr<f32>>, tensor<1024x!tt.ptr<f32>>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<i32>, %arg2: !tt.ptr<f16>, %arg3: tensor<1024x!tt.ptr<bf16>>, %arg4: tensor<1024x!tt.ptr<f32>>, %arg5: tensor<1024x!tt.ptr<f32>>, %arg6: tensor<1024x!tt.ptr<f32>>, %arg7: tensor<1024x!tt.ptr<f32>>):
    %0 = "tensor.empty"() : () -> tensor<1024xi32>
    %1 = "linalg.generic"(%0) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg33: i32):
      %30 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %31 = "arith.index_cast"(%30) : (index) -> i32
      "linalg.yield"(%31) : (i32) -> ()
    }) : (tensor<1024xi32>) -> tensor<1024xi32>
    %2 = "tensor.empty"() : () -> tensor<1024x!tt.ptr<f32>>
    %3 = "linalg.fill"(%arg0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg31: !tt.ptr<f32>, %arg32: !tt.ptr<f32>):
      "linalg.yield"(%arg31) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<1024x!tt.ptr<f32>>) -> tensor<1024x!tt.ptr<f32>>
    %4 = "linalg.generic"(%3, %1, %3) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg28: !tt.ptr<f32>, %arg29: i32, %arg30: !tt.ptr<f32>):
      %29 = "tt.addptr"(%arg28, %arg29) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%29) : (!tt.ptr<f32>) -> ()
    }) : (tensor<1024x!tt.ptr<f32>>, tensor<1024xi32>, tensor<1024x!tt.ptr<f32>>) -> tensor<1024x!tt.ptr<f32>>
    %5 = "tensor.empty"() : () -> tensor<1024x!tt.ptr<i32>>
    %6 = "linalg.fill"(%arg1, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg26: !tt.ptr<i32>, %arg27: !tt.ptr<i32>):
      "linalg.yield"(%arg26) : (!tt.ptr<i32>) -> ()
    }) : (!tt.ptr<i32>, tensor<1024x!tt.ptr<i32>>) -> tensor<1024x!tt.ptr<i32>>
    %7 = "linalg.generic"(%6, %1, %6) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg23: !tt.ptr<i32>, %arg24: i32, %arg25: !tt.ptr<i32>):
      %28 = "tt.addptr"(%arg23, %arg24) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      "linalg.yield"(%28) : (!tt.ptr<i32>) -> ()
    }) : (tensor<1024x!tt.ptr<i32>>, tensor<1024xi32>, tensor<1024x!tt.ptr<i32>>) -> tensor<1024x!tt.ptr<i32>>
    %8 = "tensor.empty"() : () -> tensor<1024x!tt.ptr<f16>>
    %9 = "linalg.fill"(%arg2, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: !tt.ptr<f16>, %arg22: !tt.ptr<f16>):
      "linalg.yield"(%arg21) : (!tt.ptr<f16>) -> ()
    }) : (!tt.ptr<f16>, tensor<1024x!tt.ptr<f16>>) -> tensor<1024x!tt.ptr<f16>>
    %10 = "linalg.generic"(%9, %1, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg18: !tt.ptr<f16>, %arg19: i32, %arg20: !tt.ptr<f16>):
      %27 = "tt.addptr"(%arg18, %arg19) : (!tt.ptr<f16>, i32) -> !tt.ptr<f16>
      "linalg.yield"(%27) : (!tt.ptr<f16>) -> ()
    }) : (tensor<1024x!tt.ptr<f16>>, tensor<1024xi32>, tensor<1024x!tt.ptr<f16>>) -> tensor<1024x!tt.ptr<f16>>
    %11 = "tt.load"(%4) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<1024x!tt.ptr<f32>>) -> tensor<1024xf32>
    %12 = "tt.load"(%7) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<1024x!tt.ptr<i32>>) -> tensor<1024xi32>
    %13 = "tt.load"(%10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<1024x!tt.ptr<f16>>) -> tensor<1024xf16>
    %14 = "tensor.empty"() : () -> tensor<1024xbf16>
    %15 = "linalg.generic"(%11, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: f32, %arg17: bf16):
      %26 = "arith.truncf"(%arg16) : (f32) -> bf16
      "linalg.yield"(%26) : (bf16) -> ()
    }) : (tensor<1024xf32>, tensor<1024xbf16>) -> tensor<1024xbf16>
    %16 = "linalg.generic"(%11, %11) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %25 = "math.exp"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%25) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %17 = "tensor.empty"() : () -> tensor<1024xf32>
    %18 = "linalg.generic"(%12, %17) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: i32, %arg13: f32):
      %24 = "arith.sitofp"(%arg12) : (i32) -> f32
      "linalg.yield"(%24) : (f32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xf32>) -> tensor<1024xf32>
    %19 = "tensor.empty"() : () -> tensor<1024xf32>
    %20 = "linalg.generic"(%13, %19) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f16, %arg11: f32):
      %23 = "arith.extf"(%arg10) : (f16) -> f32
      "linalg.yield"(%23) : (f32) -> ()
    }) : (tensor<1024xf16>, tensor<1024xf32>) -> tensor<1024xf32>
    %21 = "linalg.generic"(%11, %11) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %22 = "math.sqrt"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    "tt.store"(%arg3, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<1024x!tt.ptr<bf16>>, tensor<1024xbf16>) -> ()
    "tt.store"(%arg4, %16) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<1024x!tt.ptr<f32>>, tensor<1024xf32>) -> ()
    "tt.store"(%arg5, %18) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<1024x!tt.ptr<f32>>, tensor<1024xf32>) -> ()
    "tt.store"(%arg6, %20) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<1024x!tt.ptr<f32>>, tensor<1024xf32>) -> ()
    "tt.store"(%arg7, %21) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<1024x!tt.ptr<f32>>, tensor<1024xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

