"builtin.module"() ({
  "func.func"() <{function_type = (f32, memref<?xf32>, i32) -> (), sym_name = "splat"}> ({
  ^bb0(%arg0: f32, %arg1: memref<?xf32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "tensor.empty"() : () -> tensor<2x512xf32>
    %4 = "linalg.fill"(%arg0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<2x512xf32>) -> tensor<2x512xf32>
    %5 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "arith.index_cast"(%5) : (i32) -> index
    %7 = "arith.index_cast"(%arg2) : (i32) -> index
    %8 = "memref.reinterpret_cast"(%arg1, %7) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %9 = "memref.subview"(%8, %6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 2, 512>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index) -> memref<2x512xf32, strided<[?, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%4, %9) <{writable}> : (tensor<2x512xf32>, memref<2x512xf32, strided<[?, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

