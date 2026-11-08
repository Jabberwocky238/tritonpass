"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, memref<?xf32>, memref<?xf32>) -> (), sym_name = "indirect_load"}> ({
  ^bb0(%arg0: memref<?xi32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 512 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xi32>
    %4 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 512>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<512xi32, strided<[1]>>
    "linalg.copy"(%4, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: i32, %arg5: i32):
      "linalg.yield"(%arg4) : (i32) -> ()
    }) : (memref<512xi32, strided<[1]>>, memref<512xi32>) -> ()
    %5 = "bufferization.to_tensor"(%3) <{restrict, writable}> : (memref<512xi32>) -> tensor<512xi32>
    %6 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xf32>
    "scf.for"(%2, %1, %0) ({
    ^bb0(%arg3: index):
      %9 = "tensor.extract"(%5, %arg3) : (tensor<512xi32>, index) -> i32
      %10 = "arith.index_cast"(%9) : (i32) -> index
      %11 = "memref.reinterpret_cast"(%arg1, %10) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
      %12 = "memref.subview"(%6, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<512xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
      "memref.copy"(%11, %12) : (memref<1xf32, strided<[1], offset: ?>>, memref<1xf32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %7 = "bufferization.to_tensor"(%6) <{restrict, writable}> : (memref<512xf32>) -> tensor<512xf32>
    %8 = "memref.subview"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 512>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<512xf32, strided<[1]>>
    "bufferization.materialize_in_destination"(%7, %8) <{writable}> : (tensor<512xf32>, memref<512xf32, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

