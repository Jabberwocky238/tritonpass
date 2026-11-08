#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, memref<?xi32>) -> (), sym_name = "masked_gather_scatter"}> ({
  ^bb0(%arg0: memref<?xi32>, %arg1: memref<?xi32>):
    %0 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 77 : index}> : () -> index
    %6 = "arith.constant"() <{value = 99 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 12 : i32}> : () -> i32
    %8 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xi32>) -> !tt.ptr<i32>
    %9 = "tensor.empty"() : () -> tensor<64xi32>
    %10 = "linalg.fill"(%0, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: i32, %arg18: i32):
      "linalg.yield"(%arg17) : (i32) -> ()
    }) : (i32, tensor<64xi32>) -> tensor<64xi32>
    %11 = "linalg.fill"(%7, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32):
      "linalg.yield"(%arg15) : (i32) -> ()
    }) : (i32, tensor<64xi32>) -> tensor<64xi32>
    %12 = "linalg.generic"(%9) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg14: i32):
      %28 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %29 = "arith.index_cast"(%28) : (index) -> i32
      "linalg.yield"(%29) : (i32) -> ()
    }) : (tensor<64xi32>) -> tensor<64xi32>
    %13:2 = "scf.for"(%1, %2, %3, %12, %1) ({
    ^bb0(%arg2: index, %arg3: tensor<64xi32>, %arg4: index):
      %14 = "linalg.generic"(%arg3, %11, %arg3) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg11: i32, %arg12: i32, %arg13: i32):
        %27 = "arith.divsi"(%arg11, %arg12) : (i32, i32) -> i32
        "linalg.yield"(%27) : (i32) -> ()
      }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
      %15 = "tensor.empty"() : () -> tensor<64xi1>
      %16 = "linalg.generic"(%14, %10, %15) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg8: i32, %arg9: i32, %arg10: i1):
        %26 = "arith.cmpi"(%arg8, %arg9) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "linalg.yield"(%26) : (i1) -> ()
      }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi1>) -> tensor<64xi1>
      %17 = "tts.gather"(%8, %14, %16, %6) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (!tt.ptr<i32>, tensor<64xi32>, tensor<64xi1>, i32) -> tensor<64xi32>
      %18 = "arith.addi"(%arg4, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %19 = "arith.minsi"(%18, %5) : (index, index) -> index
      %20 = "arith.maxsi"(%19, %arg4) : (index, index) -> index
      %21 = "arith.subi"(%20, %arg4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %22 = "tensor.extract_slice"(%17, %21) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<64xi32>, index) -> tensor<?xi32>
      %23 = "memref.subview"(%arg1, %arg4, %21) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%22, %23) <{writable}> : (tensor<?xi32>, memref<?xi32, strided<[1], offset: ?>>) -> ()
      %24 = "linalg.generic"(%14, %10, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg5: i32, %arg6: i32, %arg7: i32):
        %25 = "arith.addi"(%arg5, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%25) : (i32) -> ()
      }) : (tensor<64xi32>, tensor<64xi32>, tensor<64xi32>) -> tensor<64xi32>
      "scf.yield"(%24, %18) : (tensor<64xi32>, index) -> ()
    }) : (index, index, index, tensor<64xi32>, index) -> (tensor<64xi32>, index)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

