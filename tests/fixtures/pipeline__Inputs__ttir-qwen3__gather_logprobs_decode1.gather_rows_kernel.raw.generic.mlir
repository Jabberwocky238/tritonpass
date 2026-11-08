"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xi32>, i32, i32) -> (), sym_name = "gather_rows_kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xi32>, %arg3: i32, %arg4: i32):
    %0 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %4 = "arith.index_cast"(%3) : (index) -> i32
    %5 = "arith.muli"(%4, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "arith.index_cast"(%5) : (i32) -> index
    %7 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %8 = "memref.load"(%7, %6) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %9 = "arith.maxsi"(%8, %2) : (i32, i32) -> i32
    %10 = "arith.subi"(%arg3, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %11 = "arith.minsi"(%9, %10) : (i32, i32) -> i32
    %12 = "arith.index_cast"(%11) : (i32) -> index
    %13 = "arith.muli"(%4, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %14 = "arith.index_cast"(%13) : (i32) -> index
    %15 = "arith.addi"(%14, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %16 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xf32>
    %17 = "memref.subview"(%arg1, %15) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "linalg.copy"(%17, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (memref<1xf32, strided<[1], offset: ?>>, memref<1xf32>) -> ()
    %18 = "bufferization.to_tensor"(%16) <{restrict, writable}> : (memref<1xf32>) -> tensor<1xf32>
    %19 = "memref.subview"(%arg0, %3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%18, %19) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

