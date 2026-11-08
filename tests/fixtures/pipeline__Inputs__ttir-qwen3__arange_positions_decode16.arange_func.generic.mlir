#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi64>, i32, i32, i32) -> (), sym_name = "arange_func"}> ({
  ^bb0(%arg0: memref<?xi64>, %arg1: i32, %arg2: i32, %arg3: i32):
    %0 = "arith.constant"() <{value = 128 : i64}> : () -> i64
    %1 = "arith.constant"() <{value = 128 : index}> : () -> index
    %2 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %3 = "arith.index_cast"(%2) : (index) -> i32
    %4 = "arith.extsi"(%3) : (i32) -> i64
    %5 = "arith.muli"(%4, %0) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %6 = "arith.index_cast"(%5) : (i64) -> index
    %7 = "tensor.empty"() : () -> tensor<128xi32>
    %8 = "linalg.generic"(%7) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg16: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %9 = "tensor.empty"() : () -> tensor<128xi64>
    %10 = "linalg.generic"(%8, %9) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: i32, %arg15: i64):
      %25 = "arith.extsi"(%arg14) : (i32) -> i64
      "linalg.yield"(%25) : (i64) -> ()
    }) : (tensor<128xi32>, tensor<128xi64>) -> tensor<128xi64>
    %11 = "linalg.fill"(%5, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: i64, %arg13: i64):
      "linalg.yield"(%arg12) : (i64) -> ()
    }) : (i64, tensor<128xi64>) -> tensor<128xi64>
    %12 = "linalg.generic"(%10, %11, %10) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: i64, %arg10: i64, %arg11: i64):
      %24 = "arith.addi"(%arg9, %arg10) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "linalg.yield"(%24) : (i64) -> ()
    }) : (tensor<128xi64>, tensor<128xi64>, tensor<128xi64>) -> tensor<128xi64>
    %13 = "arith.extsi"(%arg1) : (i32) -> i64
    %14 = "linalg.fill"(%13, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: i64, %arg8: i64):
      "linalg.yield"(%arg7) : (i64) -> ()
    }) : (i64, tensor<128xi64>) -> tensor<128xi64>
    %15 = "linalg.generic"(%12, %14, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg4: i64, %arg5: i64, %arg6: i64):
      %23 = "arith.addi"(%arg4, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "linalg.yield"(%23) : (i64) -> ()
    }) : (tensor<128xi64>, tensor<128xi64>, tensor<128xi64>) -> tensor<128xi64>
    %16 = "arith.addi"(%6, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %17 = "arith.index_cast"(%arg3) : (i32) -> index
    %18 = "arith.minsi"(%16, %17) : (index, index) -> index
    %19 = "arith.maxsi"(%18, %6) : (index, index) -> index
    %20 = "arith.subi"(%19, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %21 = "tensor.extract_slice"(%15, %20) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<128xi64>, index) -> tensor<?xi64>
    %22 = "memref.subview"(%arg0, %6, %20) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi64>, index, index) -> memref<?xi64, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%21, %22) <{writable}> : (tensor<?xi64>, memref<?xi64, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

