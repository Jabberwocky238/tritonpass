"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, memref<?xi32>, memref<?xi32>, memref<?xi32>, memref<?xi64>, memref<?xi32>) -> (), sym_name = "_get_num_sampled_and_rejected_kernel"}> ({
  ^bb0(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: memref<?xi32>, %arg3: memref<?xi32>, %arg4: memref<?xi64>, %arg5: memref<?xi32>):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %3 = "arith.index_cast"(%2) : (index) -> i32
    %4 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
    %5 = "memref.load"(%4, %2) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
    %6 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %7 = "memref.load"(%6, %2) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %8 = "arith.index_cast"(%5) : (i64) -> index
    %9 = "memref.reinterpret_cast"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %10 = "memref.load"(%9, %8) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %11 = "arith.cmpi"(%7, %10) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %12 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %13 = "memref.load"(%12, %2) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %14 = "arith.select"(%11, %1, %13) : (i1, i32, i32) -> i32
    %15 = "tensor.empty"() : () -> tensor<1xi32>
    %16 = "linalg.fill"(%14, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: i32, %arg9: i32):
      "linalg.yield"(%arg8) : (i32) -> ()
    }) : (i32, tensor<1xi32>) -> tensor<1xi32>
    %17 = "memref.subview"(%arg0, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%16, %17) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1], offset: ?>>) -> ()
    %18 = "memref.reinterpret_cast"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %19 = "memref.load"(%18, %2) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %20 = "arith.addi"(%3, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %21 = "arith.index_cast"(%20) : (i32) -> index
    %22 = "memref.load"(%18, %21) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %23 = "arith.subi"(%22, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %24 = "arith.subi"(%23, %14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %25 = "arith.select"(%11, %1, %24) : (i1, i32, i32) -> i32
    %26 = "linalg.fill"(%25, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: i32, %arg7: i32):
      "linalg.yield"(%arg6) : (i32) -> ()
    }) : (i32, tensor<1xi32>) -> tensor<1xi32>
    %27 = "memref.subview"(%arg1, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%26, %27) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

