#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, memref<?xbf16>, memref<?xf32>) -> (), sym_name = "indirect_load"}> ({
  ^bb0(%arg0: memref<?xi32>, %arg1: memref<?xbf16>, %arg2: memref<?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 512 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xi32>
    %4 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 512>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<512xi32, strided<[1]>>
    "linalg.copy"(%4, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: i32, %arg7: i32):
      "linalg.yield"(%arg6) : (i32) -> ()
    }) : (memref<512xi32, strided<[1]>>, memref<512xi32>) -> ()
    %5 = "bufferization.to_tensor"(%3) <{restrict, writable}> : (memref<512xi32>) -> tensor<512xi32>
    %6 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xbf16>
    "scf.for"(%2, %1, %0) ({
    ^bb0(%arg5: index):
      %12 = "tensor.extract"(%5, %arg5) : (tensor<512xi32>, index) -> i32
      %13 = "arith.index_cast"(%12) : (i32) -> index
      %14 = "memref.reinterpret_cast"(%arg1, %13) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index) -> memref<1xbf16, strided<[1], offset: ?>>
      %15 = "memref.subview"(%6, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<512xbf16>, index) -> memref<1xbf16, strided<[1], offset: ?>>
      "memref.copy"(%14, %15) : (memref<1xbf16, strided<[1], offset: ?>>, memref<1xbf16, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %7 = "bufferization.to_tensor"(%6) <{restrict, writable}> : (memref<512xbf16>) -> tensor<512xbf16>
    %8 = "tensor.empty"() : () -> tensor<512xf32>
    %9 = "linalg.generic"(%7, %8) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: bf16, %arg4: f32):
      %11 = "arith.extf"(%arg3) : (bf16) -> f32
      "linalg.yield"(%11) : (f32) -> ()
    }) : (tensor<512xbf16>, tensor<512xf32>) -> tensor<512xf32>
    %10 = "memref.subview"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 512>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<512xf32, strided<[1]>>
    "bufferization.materialize_in_destination"(%9, %10) <{writable}> : (tensor<512xf32>, memref<512xf32, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

