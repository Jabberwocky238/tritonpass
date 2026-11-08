#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi64>, i32) -> (), sym_name = "arange_func"}> ({
  ^bb0(%arg0: memref<?xi64>, %arg1: i32):
    %0 = "arith.constant"() <{value = 128 : i64}> : () -> i64
    %1 = "arith.constant"() <{value = 128 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %4 = "arith.index_cast"(%3) : (index) -> i32
    %5 = "arith.extsi"(%4) : (i32) -> i64
    %6 = "arith.muli"(%5, %0) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %7 = "arith.index_cast"(%6) : (i64) -> index
    %8 = "tensor.empty"() : () -> tensor<128xi32>
    %9 = "linalg.generic"(%8) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg14: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %10 = "tensor.empty"() : () -> tensor<128xi64>
    %11 = "linalg.generic"(%9, %10) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: i32, %arg13: i64):
      %25 = "arith.extsi"(%arg12) : (i32) -> i64
      "linalg.yield"(%25) : (i64) -> ()
    }) : (tensor<128xi32>, tensor<128xi64>) -> tensor<128xi64>
    %12 = "linalg.fill"(%6, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: i64, %arg11: i64):
      "linalg.yield"(%arg10) : (i64) -> ()
    }) : (i64, tensor<128xi64>) -> tensor<128xi64>
    %13 = "linalg.generic"(%11, %12, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg7: i64, %arg8: i64, %arg9: i64):
      %24 = "arith.addi"(%arg7, %arg8) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "linalg.yield"(%24) : (i64) -> ()
    }) : (tensor<128xi64>, tensor<128xi64>, tensor<128xi64>) -> tensor<128xi64>
    %14 = "arith.extsi"(%arg1) : (i32) -> i64
    %15 = "linalg.fill"(%14, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: i64, %arg6: i64):
      "linalg.yield"(%arg5) : (i64) -> ()
    }) : (i64, tensor<128xi64>) -> tensor<128xi64>
    %16 = "linalg.generic"(%13, %15, %13) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: i64, %arg3: i64, %arg4: i64):
      %23 = "arith.addi"(%arg2, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "linalg.yield"(%23) : (i64) -> ()
    }) : (tensor<128xi64>, tensor<128xi64>, tensor<128xi64>) -> tensor<128xi64>
    %17 = "arith.addi"(%7, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %18 = "arith.minsi"(%17, %2) : (index, index) -> index
    %19 = "arith.maxsi"(%18, %7) : (index, index) -> index
    %20 = "arith.subi"(%19, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %21 = "tensor.extract_slice"(%16, %20) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<128xi64>, index) -> tensor<?xi64>
    %22 = "memref.subview"(%arg0, %7, %20) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi64>, index, index) -> memref<?xi64, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%21, %22) <{writable}> : (tensor<?xi64>, memref<?xi64, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

