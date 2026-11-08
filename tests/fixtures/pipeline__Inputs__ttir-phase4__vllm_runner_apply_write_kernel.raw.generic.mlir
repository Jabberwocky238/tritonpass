"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, i32, memref<?xi32>, memref<?xi32>, memref<?xi32>, memref<?xi32>) -> (), sym_name = "_apply_write_kernel"}> ({
  ^bb0(%arg0: memref<?xi32>, %arg1: i32, %arg2: memref<?xi32>, %arg3: memref<?xi32>, %arg4: memref<?xi32>, %arg5: memref<?xi32>):
    %0 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %5 = "arith.index_cast"(%4) : (index) -> i32
    %6 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %7 = "memref.load"(%6, %4) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %8 = "arith.extsi"(%7) : (i32) -> i64
    %9 = "memref.reinterpret_cast"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %10 = "memref.load"(%9, %4) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %11 = "arith.cmpi"(%5, %3) <{predicate = 4 : i64}> : (i32, i32) -> i1
    %12 = "scf.if"(%11) ({
      %35 = "arith.addi"(%5, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %36 = "arith.index_cast"(%35) : (i32) -> index
      %37 = "memref.reinterpret_cast"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
      %38 = "memref.load"(%37, %36) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
      "scf.yield"(%38) : (i32) -> ()
    }, {
      "scf.yield"(%3) : (i32) -> ()
    }) : (i1) -> i32
    %13 = "arith.index_cast"(%12) : (i32) -> index
    %14 = "memref.reinterpret_cast"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %15 = "memref.load"(%14, %4) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %16 = "arith.subi"(%15, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %17 = "arith.extsi"(%arg1) : (i32) -> i64
    %18 = "arith.muli"(%8, %17) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %19 = "arith.extsi"(%10) : (i32) -> i64
    %20 = "arith.addi"(%18, %19) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %21 = "arith.index_cast"(%20) : (i64) -> index
    %22 = "arith.index_cast"(%16) : (i32) -> index
    "scf.for"(%1, %22, %2) ({
    ^bb0(%arg6: index):
      %23 = "arith.addi"(%arg6, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %24 = "arith.minsi"(%23, %22) : (index, index) -> index
      %25 = "arith.maxsi"(%24, %arg6) : (index, index) -> index
      %26 = "arith.subi"(%25, %arg6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %27 = "arith.addi"(%13, %arg6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %28 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xi32>
      "linalg.fill"(%3, %28) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg9: i32, %arg10: i32):
        "linalg.yield"(%arg9) : (i32) -> ()
      }) : (i32, memref<1024xi32>) -> ()
      %29 = "memref.subview"(%arg4, %27, %26) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
      %30 = "memref.subview"(%28, %26) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xi32>, index) -> memref<?xi32, strided<[1]>>
      "linalg.copy"(%29, %30) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg7: i32, %arg8: i32):
        "linalg.yield"(%arg7) : (i32) -> ()
      }) : (memref<?xi32, strided<[1], offset: ?>>, memref<?xi32, strided<[1]>>) -> ()
      %31 = "bufferization.to_tensor"(%28) <{restrict, writable}> : (memref<1024xi32>) -> tensor<1024xi32>
      %32 = "arith.addi"(%21, %arg6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %33 = "tensor.extract_slice"(%31, %26) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xi32>, index) -> tensor<?xi32>
      %34 = "memref.subview"(%arg0, %32, %26) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%33, %34) <{writable}> : (tensor<?xi32>, memref<?xi32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

