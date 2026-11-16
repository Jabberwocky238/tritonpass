#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi64>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "arange_func"}> ({
  ^bb0(%arg1: memref<?xi64>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32):
    %1 = "arith.constant"() <{value = 128 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 128 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "func.call"(%arg6) <{callee = @flag_gems.utils.triton_lang_extension.program_id__c0}> : (i32) -> i64
    %5 = "arith.muli"(%4, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %6 = "arith.index_cast"(%5) : (i64) -> index
    %7 = "tensor.empty"() : () -> tensor<128xi32>
    %8 = "linalg.generic"(%7) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg21: i32):
      %25 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %26 = "arith.index_cast"(%25) : (index) -> i32
      "linalg.yield"(%26) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %9 = "tensor.empty"() : () -> tensor<128xi64>
    %10 = "linalg.generic"(%8, %9) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: i32, %arg20: i64):
      %24 = "arith.extsi"(%arg19) : (i32) -> i64
      "linalg.yield"(%24) : (i64) -> ()
    }) : (tensor<128xi32>, tensor<128xi64>) -> tensor<128xi64>
    %11 = "linalg.fill"(%5, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: i64, %arg18: i64):
      "linalg.yield"(%arg17) : (i64) -> ()
    }) : (i64, tensor<128xi64>) -> tensor<128xi64>
    %12 = "linalg.generic"(%10, %11, %10) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg14: i64, %arg15: i64, %arg16: i64):
      %23 = "arith.addi"(%arg14, %arg15) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "linalg.yield"(%23) : (i64) -> ()
    }) : (tensor<128xi64>, tensor<128xi64>, tensor<128xi64>) -> tensor<128xi64>
    %13 = "arith.extsi"(%arg2) : (i32) -> i64
    %14 = "linalg.fill"(%13, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: i64, %arg13: i64):
      "linalg.yield"(%arg12) : (i64) -> ()
    }) : (i64, tensor<128xi64>) -> tensor<128xi64>
    %15 = "linalg.generic"(%12, %14, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: i64, %arg10: i64, %arg11: i64):
      %22 = "arith.addi"(%arg9, %arg10) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "linalg.yield"(%22) : (i64) -> ()
    }) : (tensor<128xi64>, tensor<128xi64>, tensor<128xi64>) -> tensor<128xi64>
    %16 = "arith.addi"(%6, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %17 = "arith.minsi"(%16, %3) : (index, index) -> index
    %18 = "arith.maxsi"(%17, %6) : (index, index) -> index
    %19 = "arith.subi"(%18, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %20 = "tensor.extract_slice"(%15, %19) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<128xi64>, index) -> tensor<?xi64>
    %21 = "memref.subview"(%arg1, %6, %19) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi64>, index, index) -> memref<?xi64, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%20, %21) <{writable}> : (tensor<?xi64>, memref<?xi64, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i64, sym_name = "flag_gems.utils.triton_lang_extension.program_id__c0", sym_visibility = "private"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.extsi"(%arg0) : (i32) -> i64
    "func.return"(%0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

