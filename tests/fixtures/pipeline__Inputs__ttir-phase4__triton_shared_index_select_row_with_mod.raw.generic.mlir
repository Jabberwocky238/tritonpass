#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xi32>, i32, i32, i32) -> (), sym_name = "index_select_row_with_mod_kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xi32>, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.empty"() : () -> tensor<4xi32>
    %4 = "linalg.generic"(%3) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg17: i32):
      %27 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %28 = "arith.index_cast"(%27) : (index) -> i32
      "linalg.yield"(%28) : (i32) -> ()
    }) : (tensor<4xi32>) -> tensor<4xi32>
    %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xi32>
    %6 = "memref.subview"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<4xi32, strided<[1]>>
    "linalg.copy"(%6, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32):
      "linalg.yield"(%arg15) : (i32) -> ()
    }) : (memref<4xi32, strided<[1]>>, memref<4xi32>) -> ()
    %7 = "bufferization.to_tensor"(%5) <{restrict, writable}> : (memref<4xi32>) -> tensor<4xi32>
    %8 = "tensor.expand_shape"(%4) <{reassociation = [[0, 1]], static_output_shape = array<i64: 4, 1>}> : (tensor<4xi32>) -> tensor<4x1xi32>
    %9 = "tensor.empty"() : () -> tensor<4x1xi32>
    %10 = "linalg.fill"(%arg5, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: i32, %arg14: i32):
      "linalg.yield"(%arg13) : (i32) -> ()
    }) : (i32, tensor<4x1xi32>) -> tensor<4x1xi32>
    %11 = "linalg.generic"(%8, %10, %8) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: i32, %arg11: i32, %arg12: i32):
      %26 = "arith.remsi"(%arg10, %arg11) : (i32, i32) -> i32
      "linalg.yield"(%26) : (i32) -> ()
    }) : (tensor<4x1xi32>, tensor<4x1xi32>, tensor<4x1xi32>) -> tensor<4x1xi32>
    %12 = "tensor.collapse_shape"(%11) <{reassociation = [[0, 1]]}> : (tensor<4x1xi32>) -> tensor<4xi32>
    %13 = "linalg.generic"(%7, %12, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg7: i32, %arg8: i32, %arg9: i32):
      %25 = "arith.addi"(%arg7, %arg8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<4xi32>, tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %14 = "arith.index_cast"(%arg3) : (i32) -> index
    %15 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x16xf32>
    "scf.for"(%2, %1, %0) ({
    ^bb0(%arg6: index):
      %20 = "tensor.extract"(%13, %arg6) : (tensor<4xi32>, index) -> i32
      %21 = "arith.index_cast"(%20) : (i32) -> index
      %22 = "arith.muli"(%21, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %23 = "memref.reinterpret_cast"(%arg0, %22, %14) <{operandSegmentSizes = array<i32: 1, 1, 0, 1>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index, index) -> memref<1x16xf32, strided<[?, 1], offset: ?>>
      %24 = "memref.subview"(%15, %arg6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: 1, 1>}> : (memref<4x16xf32>, index) -> memref<1x16xf32, strided<[16, 1], offset: ?>>
      "memref.copy"(%23, %24) : (memref<1x16xf32, strided<[?, 1], offset: ?>>, memref<1x16xf32, strided<[16, 1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %16 = "bufferization.to_tensor"(%15) <{restrict, writable}> : (memref<4x16xf32>) -> tensor<4x16xf32>
    %17 = "arith.index_cast"(%arg4) : (i32) -> index
    %18 = "memref.reinterpret_cast"(%arg1, %17) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %19 = "memref.subview"(%18) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 16>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>) -> memref<4x16xf32, strided<[?, 1]>>
    "bufferization.materialize_in_destination"(%16, %19) <{writable}> : (tensor<4x16xf32>, memref<4x16xf32, strided<[?, 1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

