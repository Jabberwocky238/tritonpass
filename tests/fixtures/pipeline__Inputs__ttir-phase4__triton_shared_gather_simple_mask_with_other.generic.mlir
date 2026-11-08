#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, memref<?xi32>) -> (), sym_name = "gather_simple_mask_with_other"}> ({
  ^bb0(%arg0: memref<?xi32>, %arg1: memref<?xi32>):
    %0 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %8 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %9 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xi32>) -> !tt.ptr<i32>
    %10 = "tensor.empty"() : () -> tensor<64xi32>
    %11 = "linalg.fill"(%0, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32):
      "linalg.yield"(%arg20) : (i32) -> ()
    }) : (i32, tensor<64xi32>) -> tensor<64xi32>
    %12 = "linalg.fill"(%7, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      "linalg.yield"(%arg18) : (i32) -> ()
    }) : (i32, tensor<64xi32>) -> tensor<64xi32>
    %13 = "linalg.generic"(%10) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg17: i32):
      %27 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %28 = "arith.index_cast"(%27) : (index) -> i32
      "linalg.yield"(%28) : (i32) -> ()
    }) : (tensor<64xi32>) -> tensor<64xi32>
    %14:3 = "scf.for"(%1, %2, %3, %13, %1, %8) ({
    ^bb0(%arg2: index, %arg3: tensor<64xi32>, %arg4: index, %arg5: i32):
      %15 = "linalg.generic"(%arg3, %12, %arg3) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg14: i32, %arg15: i32, %arg16: i32):
        %26 = "arith.divsi"(%arg14, %arg15) : (i32, i32) -> i32
        "linalg.yield"(%26) : (i32) -> ()
      }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
      %16 = "linalg.fill"(%arg5, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg12: i32, %arg13: i32):
        "linalg.yield"(%arg12) : (i32) -> ()
      }) : (i32, tensor<64xi32>) -> tensor<64xi32>
      %17 = "tensor.empty"() : () -> tensor<64xi1>
      %18 = "linalg.generic"(%15, %16, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg9: i32, %arg10: i32, %arg11: i1):
        %25 = "arith.cmpi"(%arg9, %arg10) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "linalg.yield"(%25) : (i1) -> ()
      }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi1>) -> tensor<64xi1>
      %19 = "tts.gather"(%9, %15, %18, %5) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (!tt.ptr<i32>, tensor<64xi32>, tensor<64xi1>, i32) -> tensor<64xi32>
      %20 = "memref.subview"(%arg1, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 64>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<64xi32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%19, %20) <{writable}> : (tensor<64xi32>, memref<64xi32, strided<[1], offset: ?>>) -> ()
      %21 = "arith.addi"(%arg5, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %22 = "linalg.generic"(%arg3, %11, %arg3) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg6: i32, %arg7: i32, %arg8: i32):
        %24 = "arith.addi"(%arg6, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%24) : (i32) -> ()
      }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
      %23 = "arith.addi"(%arg4, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%22, %23, %21) : (tensor<64xi32>, index, i32) -> ()
    }) : (index, index, index, tensor<64xi32>, index, i32) -> (tensor<64xi32>, index, i32)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

