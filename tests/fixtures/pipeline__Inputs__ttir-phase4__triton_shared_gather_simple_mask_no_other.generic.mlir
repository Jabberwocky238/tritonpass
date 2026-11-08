#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, memref<?xi32>) -> (), sym_name = "gather_simple_mask_no_other"}> ({
  ^bb0(%arg0: memref<?xi32>, %arg1: memref<?xi32>):
    %0 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %8 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xi32>) -> !tt.ptr<i32>
    %9 = "tensor.empty"() : () -> tensor<64xi32>
    %10 = "linalg.fill"(%0, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32):
      "linalg.yield"(%arg20) : (i32) -> ()
    }) : (i32, tensor<64xi32>) -> tensor<64xi32>
    %11 = "linalg.fill"(%6, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<64xi32>) -> tensor<64xi32>
    %12 = "linalg.generic"(%9) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg17: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<64xi32>) -> tensor<64xi32>
    %13:3 = "scf.for"(%1, %2, %3, %12, %1, %7) ({
    ^bb0(%arg2: index, %arg3: tensor<64xi32>, %arg4: index, %arg5: i32):
      %14 = "linalg.generic"(%arg3, %11, %arg3) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg14: i32, %arg15: i32, %arg16: i32):
        %25 = "arith.divsi"(%arg14, %arg15) : (i32, i32) -> i32
        "linalg.yield"(%25) : (i32) -> ()
      }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
      %15 = "linalg.fill"(%arg5, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg12: i32, %arg13: i32):
        "linalg.yield"(%arg12) : (i32) -> ()
      }) : (i32, tensor<64xi32>) -> tensor<64xi32>
      %16 = "tensor.empty"() : () -> tensor<64xi1>
      %17 = "linalg.generic"(%14, %15, %16) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg9: i32, %arg10: i32, %arg11: i1):
        %24 = "arith.cmpi"(%arg9, %arg10) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "linalg.yield"(%24) : (i1) -> ()
      }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi1>) -> tensor<64xi1>
      %18 = "tts.gather"(%8, %14, %17) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (!tt.ptr<i32>, tensor<64xi32>, tensor<64xi1>) -> tensor<64xi32>
      %19 = "memref.subview"(%arg1, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 64>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<64xi32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%18, %19) <{writable}> : (tensor<64xi32>, memref<64xi32, strided<[1], offset: ?>>) -> ()
      %20 = "arith.addi"(%arg5, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %21 = "linalg.generic"(%arg3, %10, %arg3) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg6: i32, %arg7: i32, %arg8: i32):
        %23 = "arith.addi"(%arg6, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%23) : (i32) -> ()
      }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
      %22 = "arith.addi"(%arg4, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%21, %22, %20) : (tensor<64xi32>, index, i32) -> ()
    }) : (index, index, index, tensor<64xi32>, index, i32) -> (tensor<64xi32>, index, i32)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

