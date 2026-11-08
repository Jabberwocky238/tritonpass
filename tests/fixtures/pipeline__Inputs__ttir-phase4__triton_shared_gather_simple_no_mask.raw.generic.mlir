#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, memref<?xi32>) -> (), sym_name = "gather_simple_no_mask"}> ({
  ^bb0(%arg0: memref<?xi32>, %arg1: memref<?xi32>):
    %0 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %7 = "tensor.empty"() : () -> tensor<64xi32>
    %8 = "linalg.fill"(%0, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32):
      "linalg.yield"(%arg20) : (i32) -> ()
    }) : (i32, tensor<64xi32>) -> tensor<64xi32>
    %9 = "linalg.fill"(%6, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<64xi32>) -> tensor<64xi32>
    %10 = "linalg.generic"(%7) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg17: i32):
      %30 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %31 = "arith.index_cast"(%30) : (index) -> i32
      "linalg.yield"(%31) : (i32) -> ()
    }) : (tensor<64xi32>) -> tensor<64xi32>
    %11:2 = "scf.for"(%1, %2, %3, %10, %1) ({
    ^bb0(%arg2: index, %arg3: tensor<64xi32>, %arg4: index):
      %12 = "arith.index_cast"(%arg2) : (index) -> i32
      %13 = "linalg.generic"(%arg3, %9, %arg3) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg14: i32, %arg15: i32, %arg16: i32):
        %29 = "arith.divsi"(%arg14, %arg15) : (i32, i32) -> i32
        "linalg.yield"(%29) : (i32) -> ()
      }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
      %14 = "arith.addi"(%12, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %15 = "arith.remsi"(%14, %0) : (i32, i32) -> i32
      %16 = "linalg.fill"(%15, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg12: i32, %arg13: i32):
        "linalg.yield"(%arg12) : (i32) -> ()
      }) : (i32, tensor<64xi32>) -> tensor<64xi32>
      %17 = "linalg.generic"(%13, %16, %13) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg9: i32, %arg10: i32, %arg11: i32):
        %28 = "arith.addi"(%arg9, %arg10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%28) : (i32) -> ()
      }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
      %18 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xi32>
      "scf.for"(%1, %4, %3) ({
      ^bb0(%arg8: index):
        %24 = "tensor.extract"(%17, %arg8) : (tensor<64xi32>, index) -> i32
        %25 = "arith.index_cast"(%24) : (i32) -> index
        %26 = "memref.reinterpret_cast"(%arg0, %25) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
        %27 = "memref.subview"(%18, %arg8) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<64xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
        "memref.copy"(%26, %27) : (memref<1xi32, strided<[1], offset: ?>>, memref<1xi32, strided<[1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      %19 = "bufferization.to_tensor"(%18) <{restrict, writable}> : (memref<64xi32>) -> tensor<64xi32>
      %20 = "memref.subview"(%arg1, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 64>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<64xi32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%19, %20) <{writable}> : (tensor<64xi32>, memref<64xi32, strided<[1], offset: ?>>) -> ()
      %21 = "linalg.generic"(%17, %8, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg5: i32, %arg6: i32, %arg7: i32):
        %23 = "arith.addi"(%arg5, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%23) : (i32) -> ()
      }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
      %22 = "arith.addi"(%arg4, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%21, %22) : (tensor<64xi32>, index) -> ()
    }) : (index, index, index, tensor<64xi32>, index) -> (tensor<64xi32>, index)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

