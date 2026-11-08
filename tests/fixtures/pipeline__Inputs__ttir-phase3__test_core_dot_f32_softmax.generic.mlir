#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, 0)>
#map4 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, i32, memref<?xf32>, i32, memref<?xf32>, i32, memref<?xf32>, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: i32, %arg2: memref<?xf32>, %arg3: i32, %arg4: memref<?xf32>, %arg5: i32, %arg6: memref<?xf32>, %arg7: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %2 = "arith.index_cast"(%arg1) : (i32) -> index
    %3 = "memref.reinterpret_cast"(%arg0, %2) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %4 = "arith.index_cast"(%arg3) : (i32) -> index
    %5 = "memref.reinterpret_cast"(%arg2, %4) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %6 = "arith.index_cast"(%arg7) : (i32) -> index
    %7 = "memref.reinterpret_cast"(%arg6, %6) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %8 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32>
    %9 = "memref.subview"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>) -> memref<64x64xf32, strided<[?, 1]>>
    "linalg.copy"(%9, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg35: f32, %arg36: f32):
      "linalg.yield"(%arg35) : (f32) -> ()
    }) : (memref<64x64xf32, strided<[?, 1]>>, memref<64x64xf32>) -> ()
    %10 = "bufferization.to_tensor"(%8) <{restrict, writable}> : (memref<64x64xf32>) -> tensor<64x64xf32>
    %11 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xf32>
    %12 = "memref.subview"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>) -> memref<64x64xf32, strided<[?, 1]>>
    "linalg.copy"(%12, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg33: f32, %arg34: f32):
      "linalg.yield"(%arg33) : (f32) -> ()
    }) : (memref<64x64xf32, strided<[?, 1]>>, memref<64x64xf32>) -> ()
    %13 = "bufferization.to_tensor"(%11) <{restrict, writable}> : (memref<64x64xf32>) -> tensor<64x64xf32>
    %14 = "tensor.empty"() : () -> tensor<64x64xf32>
    %15 = "linalg.fill"(%0, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg31: f32, %arg32: f32):
      "linalg.yield"(%arg31) : (f32) -> ()
    }) : (f32, tensor<64x64xf32>) -> tensor<64x64xf32>
    %16 = "linalg.matmul"(%10, %13, %15) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg28: f32, %arg29: f32, %arg30: f32):
      %35 = "arith.mulf"(%arg28, %arg29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %36 = "arith.addf"(%arg30, %35) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%36) : (f32) -> ()
    }) : (tensor<64x64xf32>, tensor<64x64xf32>, tensor<64x64xf32>) -> tensor<64x64xf32>
    %17 = "tensor.empty"() : () -> tensor<64xf32>
    %18 = "linalg.fill"(%1, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg26: f32, %arg27: f32):
      "linalg.yield"(%arg26) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    %19 = "linalg.reduce"(%16, %18) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg24: f32, %arg25: f32):
      %34 = "arith.maxnumf"(%arg24, %arg25) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%34) : (f32) -> ()
    }) : (tensor<64x64xf32>, tensor<64xf32>) -> tensor<64xf32>
    %20 = "tensor.expand_shape"(%19) <{reassociation = [[0, 1]], static_output_shape = array<i64: 64, 1>}> : (tensor<64xf32>) -> tensor<64x1xf32>
    %21 = "linalg.generic"(%20, %14) <{indexing_maps = [#map3, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg22: f32, %arg23: f32):
      "linalg.yield"(%arg22) : (f32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<64x1xf32>, tensor<64x64xf32>) -> tensor<64x64xf32>
    %22 = "linalg.generic"(%16, %21, %16) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32, %arg21: f32):
      %33 = "arith.subf"(%arg19, %arg20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%33) : (f32) -> ()
    }) : (tensor<64x64xf32>, tensor<64x64xf32>, tensor<64x64xf32>) -> tensor<64x64xf32>
    %23 = "linalg.generic"(%22, %22) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: f32, %arg18: f32):
      %32 = "math.exp"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%32) : (f32) -> ()
    }) : (tensor<64x64xf32>, tensor<64x64xf32>) -> tensor<64x64xf32>
    %24 = "linalg.fill"(%0, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    %25 = "linalg.reduce"(%23, %24) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      %31 = "arith.addf"(%arg13, %arg14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%31) : (f32) -> ()
    }) : (tensor<64x64xf32>, tensor<64xf32>) -> tensor<64xf32>
    %26 = "tensor.expand_shape"(%25) <{reassociation = [[0, 1]], static_output_shape = array<i64: 64, 1>}> : (tensor<64xf32>) -> tensor<64x1xf32>
    %27 = "linalg.generic"(%26, %14) <{indexing_maps = [#map3, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      "linalg.yield"(%arg11) : (f32) -> ()
    }) {broadcastDims = array<i64: 1>} : (tensor<64x1xf32>, tensor<64x64xf32>) -> tensor<64x64xf32>
    %28 = "linalg.generic"(%23, %27, %23) <{indexing_maps = [#map4, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32, %arg10: f32):
      %30 = "arith.divf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%30) : (f32) -> ()
    }) : (tensor<64x64xf32>, tensor<64x64xf32>, tensor<64x64xf32>) -> tensor<64x64xf32>
    %29 = "memref.subview"(%7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>) -> memref<64x64xf32, strided<[?, 1]>>
    "bufferization.materialize_in_destination"(%28, %29) <{writable}> : (tensor<64x64xf32>, memref<64x64xf32, strided<[?, 1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

