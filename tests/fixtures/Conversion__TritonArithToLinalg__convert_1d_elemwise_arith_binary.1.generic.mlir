#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, tensor<1024x!tt.ptr<f32>>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: tensor<1024x!tt.ptr<f32>>):
    %0 = "tensor.empty"() : () -> tensor<1024xi32>
    %1 = "linalg.generic"(%0) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg32: i32):
      %25 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %26 = "arith.index_cast"(%25) : (index) -> i32
      "linalg.yield"(%26) : (i32) -> ()
    }) : (tensor<1024xi32>) -> tensor<1024xi32>
    %2 = "tensor.empty"() : () -> tensor<1024x!tt.ptr<f32>>
    %3 = "linalg.fill"(%arg0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: !tt.ptr<f32>, %arg31: !tt.ptr<f32>):
      "linalg.yield"(%arg30) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<1024x!tt.ptr<f32>>) -> tensor<1024x!tt.ptr<f32>>
    %4 = "linalg.generic"(%3, %1, %3) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg27: !tt.ptr<f32>, %arg28: i32, %arg29: !tt.ptr<f32>):
      %24 = "tt.addptr"(%arg27, %arg28) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%24) : (!tt.ptr<f32>) -> ()
    }) : (tensor<1024x!tt.ptr<f32>>, tensor<1024xi32>, tensor<1024x!tt.ptr<f32>>) -> tensor<1024x!tt.ptr<f32>>
    %5 = "tensor.empty"() : () -> tensor<1024x!tt.ptr<f32>>
    %6 = "linalg.fill"(%arg1, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: !tt.ptr<f32>, %arg26: !tt.ptr<f32>):
      "linalg.yield"(%arg25) : (!tt.ptr<f32>) -> ()
    }) : (!tt.ptr<f32>, tensor<1024x!tt.ptr<f32>>) -> tensor<1024x!tt.ptr<f32>>
    %7 = "linalg.generic"(%6, %1, %6) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg22: !tt.ptr<f32>, %arg23: i32, %arg24: !tt.ptr<f32>):
      %23 = "tt.addptr"(%arg22, %arg23) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      "linalg.yield"(%23) : (!tt.ptr<f32>) -> ()
    }) : (tensor<1024x!tt.ptr<f32>>, tensor<1024xi32>, tensor<1024x!tt.ptr<f32>>) -> tensor<1024x!tt.ptr<f32>>
    %8 = "tt.load"(%4) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<1024x!tt.ptr<f32>>) -> tensor<1024xf32>
    %9 = "tt.load"(%7) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<1024x!tt.ptr<f32>>) -> tensor<1024xf32>
    %10 = "linalg.generic"(%8, %9, %8) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32, %arg21: f32):
      %22 = "arith.addf"(%arg19, %arg20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %11 = "linalg.generic"(%10, %9, %10) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: f32, %arg17: f32, %arg18: f32):
      %21 = "arith.subf"(%arg16, %arg17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%21) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %12 = "linalg.generic"(%11, %9, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32, %arg15: f32):
      %20 = "arith.mulf"(%arg13, %arg14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %13 = "linalg.generic"(%12, %9, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32, %arg12: f32):
      %19 = "arith.divf"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%19) : (f32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %14 = "tensor.empty"() : () -> tensor<1024xi1>
    %15 = "linalg.generic"(%13, %9, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32, %arg9: i1):
      %18 = "arith.cmpf"(%arg7, %arg8) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%18) : (i1) -> ()
    }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xi1>) -> tensor<1024xi1>
    %16 = "linalg.generic"(%15, %8, %9, %8) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg3: i1, %arg4: f32, %arg5: f32, %arg6: f32):
      %17 = "arith.select"(%arg3, %arg4, %arg5) : (i1, f32, f32) -> f32
      "linalg.yield"(%17) : (f32) -> ()
    }) : (tensor<1024xi1>, tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    "tt.store"(%arg2, %16) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<1024x!tt.ptr<f32>>, tensor<1024xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

