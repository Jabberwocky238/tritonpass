#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi64>, i32) -> (), sym_name = "arange_func"}> ({
  ^bb0(%arg0: memref<?xi64>, %arg1: i32):
    %3 = "arith.constant"() <{value = 128 : i64}> : () -> i64
    %4 = "arith.constant"() <{value = 128 : index}> : () -> index
    %5 = "arith.constant"() <{value = 1 : index}> : () -> index
    %6 = "func.call"() <{callee = @flag_gems.utils.triton_lang_extension.program_id__c0}> : () -> i64
    %7 = "arith.muli"(%6, %3) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %8 = "arith.index_cast"(%7) : (i64) -> index
    %9 = "tensor.empty"() : () -> tensor<128xi32>
    %10 = "linalg.generic"(%9) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg14: i32):
      %27 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %28 = "arith.index_cast"(%27) : (index) -> i32
      "linalg.yield"(%28) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %11 = "tensor.empty"() : () -> tensor<128xi64>
    %12 = "linalg.generic"(%10, %11) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: i32, %arg13: i64):
      %26 = "arith.extsi"(%arg12) : (i32) -> i64
      "linalg.yield"(%26) : (i64) -> ()
    }) : (tensor<128xi32>, tensor<128xi64>) -> tensor<128xi64>
    %13 = "linalg.fill"(%7, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: i64, %arg11: i64):
      "linalg.yield"(%arg10) : (i64) -> ()
    }) : (i64, tensor<128xi64>) -> tensor<128xi64>
    %14 = "linalg.generic"(%12, %13, %12) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg7: i64, %arg8: i64, %arg9: i64):
      %25 = "arith.addi"(%arg7, %arg8) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "linalg.yield"(%25) : (i64) -> ()
    }) : (tensor<128xi64>, tensor<128xi64>, tensor<128xi64>) -> tensor<128xi64>
    %15 = "arith.extsi"(%arg1) : (i32) -> i64
    %16 = "linalg.fill"(%15, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: i64, %arg6: i64):
      "linalg.yield"(%arg5) : (i64) -> ()
    }) : (i64, tensor<128xi64>) -> tensor<128xi64>
    %17 = "linalg.generic"(%14, %16, %14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: i64, %arg3: i64, %arg4: i64):
      %24 = "arith.addi"(%arg2, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "linalg.yield"(%24) : (i64) -> ()
    }) : (tensor<128xi64>, tensor<128xi64>, tensor<128xi64>) -> tensor<128xi64>
    %18 = "arith.addi"(%8, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %19 = "arith.minsi"(%18, %5) : (index, index) -> index
    %20 = "arith.maxsi"(%19, %8) : (index, index) -> index
    %21 = "arith.subi"(%20, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %22 = "tensor.extract_slice"(%17, %21) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<128xi64>, index) -> tensor<?xi64>
    %23 = "memref.subview"(%arg0, %8, %21) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi64>, index, index) -> memref<?xi64, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%22, %23) <{writable}> : (tensor<?xi64>, memref<?xi64, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "flag_gems.utils.triton_lang_extension.program_id__c0", sym_visibility = "private"}> ({
    %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %1 = "arith.index_cast"(%0) : (index) -> i32
    %2 = "arith.extsi"(%1) : (i32) -> i64
    "func.return"(%2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

