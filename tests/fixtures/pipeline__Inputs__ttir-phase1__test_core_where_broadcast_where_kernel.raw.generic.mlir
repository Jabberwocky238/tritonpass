#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi8>, memref<?xf32>, memref<?xf32>) -> (), sym_name = "where_kernel"}> ({
  ^bb0(%arg0: memref<?xi8>, %arg1: memref<?xf32>, %arg2: memref<?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %2 = "tensor.empty"() : () -> tensor<32x32xf32>
    %3 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: f32, %arg19: f32):
      "linalg.yield"(%arg18) : (f32) -> ()
    }) : (f32, tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = "tensor.empty"() : () -> tensor<1x32xi8>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: i8, %arg17: i8):
      "linalg.yield"(%arg16) : (i8) -> ()
    }) : (i8, tensor<1x32xi8>) -> tensor<1x32xi8>
    %6 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32xi8>
    %7 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 32>, static_strides = array<i64: 1>}> : (memref<?xi8>) -> memref<32xi8, strided<[1]>>
    "linalg.copy"(%7, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: i8, %arg15: i8):
      "linalg.yield"(%arg14) : (i8) -> ()
    }) : (memref<32xi8, strided<[1]>>, memref<32xi8>) -> ()
    %8 = "bufferization.to_tensor"(%6) <{restrict, writable}> : (memref<32xi8>) -> tensor<32xi8>
    %9 = "tensor.expand_shape"(%8) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 32>}> : (tensor<32xi8>) -> tensor<1x32xi8>
    %10 = "tensor.empty"() : () -> tensor<1x32xi1>
    %11 = "linalg.generic"(%9, %5, %10) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg11: i8, %arg12: i8, %arg13: i1):
      %22 = "arith.cmpi"(%arg11, %arg12) <{predicate = 1 : i64}> : (i8, i8) -> i1
      "linalg.yield"(%22) : (i1) -> ()
    }) : (tensor<1x32xi8>, tensor<1x32xi8>, tensor<1x32xi1>) -> tensor<1x32xi1>
    %12 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 32, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[32, 1]>>
    %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
    %14 = "memref.subview"(%12) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[32, 1]>>) -> memref<32x32xf32, strided<[32, 1]>>
    "linalg.copy"(%14, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (memref<32x32xf32, strided<[32, 1]>>, memref<32x32xf32>) -> ()
    %15 = "bufferization.to_tensor"(%13) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
    %16 = "tensor.empty"() : () -> tensor<32x32xi1>
    %17 = "linalg.generic"(%11, %16) <{indexing_maps = [#map1, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: i1, %arg8: i1):
      "linalg.yield"(%arg7) : (i1) -> ()
    }) {broadcastDims = array<i64: 0>} : (tensor<1x32xi1>, tensor<32x32xi1>) -> tensor<32x32xi1>
    %18 = "linalg.generic"(%17, %15, %3, %15) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg3: i1, %arg4: f32, %arg5: f32, %arg6: f32):
      %21 = "arith.select"(%arg3, %arg4, %arg5) : (i1, f32, f32) -> f32
      "linalg.yield"(%21) : (f32) -> ()
    }) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
    %19 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 32, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[32, 1]>>
    %20 = "memref.subview"(%19) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[32, 1]>>) -> memref<32x32xf32, strided<[32, 1]>>
    "bufferization.materialize_in_destination"(%18, %20) <{writable}> : (tensor<32x32xf32>, memref<32x32xf32, strided<[32, 1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

