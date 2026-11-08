#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xi32>, i32, i32, i32, i32) -> (), sym_name = "index_select_row_with_double_mod_kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xi32>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.empty"() : () -> tensor<4xi32>
    %4 = "linalg.generic"(%3) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg23: i32):
      %31 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %32 = "arith.index_cast"(%31) : (index) -> i32
      "linalg.yield"(%32) : (i32) -> ()
    }) : (tensor<4xi32>) -> tensor<4xi32>
    %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xi32>
    %6 = "memref.subview"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<4xi32, strided<[1]>>
    "linalg.copy"(%6, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32):
      "linalg.yield"(%arg21) : (i32) -> ()
    }) : (memref<4xi32, strided<[1]>>, memref<4xi32>) -> ()
    %7 = "bufferization.to_tensor"(%5) <{restrict, writable}> : (memref<4xi32>) -> tensor<4xi32>
    %8 = "tensor.expand_shape"(%7) <{reassociation = [[0, 1]], static_output_shape = array<i64: 4, 1>}> : (tensor<4xi32>) -> tensor<4x1xi32>
    %9 = "tensor.expand_shape"(%4) <{reassociation = [[0, 1]], static_output_shape = array<i64: 4, 1>}> : (tensor<4xi32>) -> tensor<4x1xi32>
    %10 = "tensor.empty"() : () -> tensor<4x1xi32>
    %11 = "linalg.fill"(%arg5, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: i32, %arg20: i32):
      "linalg.yield"(%arg19) : (i32) -> ()
    }) : (i32, tensor<4x1xi32>) -> tensor<4x1xi32>
    %12 = "linalg.generic"(%9, %11, %9) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg16: i32, %arg17: i32, %arg18: i32):
      %30 = "arith.remsi"(%arg16, %arg17) : (i32, i32) -> i32
      "linalg.yield"(%30) : (i32) -> ()
    }) : (tensor<4x1xi32>, tensor<4x1xi32>, tensor<4x1xi32>) -> tensor<4x1xi32>
    %13 = "linalg.generic"(%8, %12, %8) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg13: i32, %arg14: i32, %arg15: i32):
      %29 = "arith.addi"(%arg13, %arg14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%29) : (i32) -> ()
    }) : (tensor<4x1xi32>, tensor<4x1xi32>, tensor<4x1xi32>) -> tensor<4x1xi32>
    %14 = "linalg.fill"(%arg6, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: i32, %arg12: i32):
      "linalg.yield"(%arg11) : (i32) -> ()
    }) : (i32, tensor<4x1xi32>) -> tensor<4x1xi32>
    %15 = "linalg.generic"(%13, %14, %13) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg8: i32, %arg9: i32, %arg10: i32):
      %28 = "arith.remsi"(%arg8, %arg9) : (i32, i32) -> i32
      "linalg.yield"(%28) : (i32) -> ()
    }) : (tensor<4x1xi32>, tensor<4x1xi32>, tensor<4x1xi32>) -> tensor<4x1xi32>
    %16 = "arith.index_cast"(%arg3) : (i32) -> index
    %17 = "tensor.collapse_shape"(%15) <{reassociation = [[0, 1]]}> : (tensor<4x1xi32>) -> tensor<4xi32>
    %18 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x16xf32>
    "scf.for"(%2, %1, %0) ({
    ^bb0(%arg7: index):
      %23 = "tensor.extract"(%17, %arg7) : (tensor<4xi32>, index) -> i32
      %24 = "arith.index_cast"(%23) : (i32) -> index
      %25 = "arith.muli"(%24, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %26 = "memref.reinterpret_cast"(%arg0, %25, %16) <{operandSegmentSizes = array<i32: 1, 1, 0, 1>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index, index) -> memref<1x16xf32, strided<[?, 1], offset: ?>>
      %27 = "memref.subview"(%18, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: 1, 1>}> : (memref<4x16xf32>, index) -> memref<1x16xf32, strided<[16, 1], offset: ?>>
      "memref.copy"(%26, %27) : (memref<1x16xf32, strided<[?, 1], offset: ?>>, memref<1x16xf32, strided<[16, 1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %19 = "bufferization.to_tensor"(%18) <{restrict, writable}> : (memref<4x16xf32>) -> tensor<4x16xf32>
    %20 = "arith.index_cast"(%arg4) : (i32) -> index
    %21 = "memref.reinterpret_cast"(%arg1, %20) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %22 = "memref.subview"(%21) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 16>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>) -> memref<4x16xf32, strided<[?, 1]>>
    "bufferization.materialize_in_destination"(%19, %22) <{writable}> : (tensor<4x16xf32>, memref<4x16xf32, strided<[?, 1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

