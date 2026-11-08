"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi64>, memref<?xi32>, memref<?xi64>, i32, memref<?xi64>, memref<?xi32>, memref<?xi32>, memref<?xi32>, memref<?xi32>, i32, memref<?xi32>) -> (), sym_name = "_post_update_kernel"}> ({
  ^bb0(%arg0: memref<?xi64>, %arg1: memref<?xi32>, %arg2: memref<?xi64>, %arg3: i32, %arg4: memref<?xi64>, %arg5: memref<?xi32>, %arg6: memref<?xi32>, %arg7: memref<?xi32>, %arg8: memref<?xi32>, %arg9: i32, %arg10: memref<?xi32>):
    %0 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %4 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %7 = "arith.index_cast"(%6) : (index) -> i32
    %8 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
    %9 = "memref.load"(%8, %6) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
    %10 = "arith.cmpi"(%9, %3) <{predicate = 2 : i64}> : (i64, i64) -> i1
    "cf.cond_br"(%10)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    %11 = "arith.index_cast"(%9) : (i64) -> index
    %12 = "memref.reinterpret_cast"(%arg10) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %13 = "memref.load"(%12, %11) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %14 = "memref.reinterpret_cast"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %15 = "memref.load"(%14, %6) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %16 = "arith.index_cast"(%15) : (i32) -> index
    %17 = "arith.cmpi"(%15, %5) <{predicate = 4 : i64}> : (i32, i32) -> i1
    "scf.if"(%17) ({
      %49 = "arith.addi"(%7, %15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %50 = "arith.addi"(%49, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %51 = "arith.index_cast"(%50) : (i32) -> index
      %52 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
      %53 = "memref.load"(%52, %51) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
      %54 = "tensor.empty"() : () -> tensor<1xi64>
      %55 = "linalg.fill"(%53, %54) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg18: i64, %arg19: i64):
        "linalg.yield"(%arg18) : (i64) -> ()
      }) : (i64, tensor<1xi64>) -> tensor<1xi64>
      %56 = "memref.subview"(%arg2, %11) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi64>, index) -> memref<1xi64, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%55, %56) <{writable}> : (tensor<1xi64>, memref<1xi64, strided<[1], offset: ?>>) -> ()
      %57 = "arith.addi"(%13, %15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %58 = "tensor.empty"() : () -> tensor<1xi32>
      %59 = "linalg.fill"(%57, %58) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg16: i32, %arg17: i32):
        "linalg.yield"(%arg16) : (i32) -> ()
      }) : (i32, tensor<1xi32>) -> tensor<1xi32>
      %60 = "memref.subview"(%arg10, %11) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%59, %60) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "scf.for"(%1, %16, %2) ({
    ^bb0(%arg13: index):
      %34 = "arith.index_cast"(%arg13) : (index) -> i32
      %35 = "arith.addi"(%7, %34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %36 = "arith.index_cast"(%35) : (i32) -> index
      %37 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
      %38 = "memref.load"(%37, %36) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
      %39 = "arith.extsi"(%arg9) : (i32) -> i64
      %40 = "arith.muli"(%9, %39) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %41 = "arith.trunci"(%38) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      %42 = "arith.index_cast"(%40) : (i64) -> index
      %43 = "arith.index_cast"(%13) : (i32) -> index
      %44 = "tensor.empty"() : () -> tensor<1xi32>
      %45 = "linalg.fill"(%41, %44) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg14: i32, %arg15: i32):
        "linalg.yield"(%arg14) : (i32) -> ()
      }) : (i32, tensor<1xi32>) -> tensor<1xi32>
      %46 = "arith.addi"(%42, %43) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %47 = "arith.addi"(%46, %arg13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %48 = "memref.subview"(%arg8, %47) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%45, %48) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %18 = "memref.reinterpret_cast"(%arg7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %19 = "memref.load"(%18, %6) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %20 = "arith.addi"(%7, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %21 = "arith.index_cast"(%20) : (i32) -> index
    %22 = "memref.load"(%18, %21) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %23 = "arith.subi"(%22, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %24 = "memref.reinterpret_cast"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %25 = "memref.load"(%24, %6) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %26 = "arith.subi"(%23, %25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %27 = "arith.cmpi"(%26, %5) <{predicate = 1 : i64}> : (i32, i32) -> i1
    "scf.if"(%27) ({
      %28 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
      %29 = "memref.load"(%28, %11) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
      %30 = "arith.addi"(%29, %26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %31 = "tensor.empty"() : () -> tensor<1xi32>
      %32 = "linalg.fill"(%30, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg11: i32, %arg12: i32):
        "linalg.yield"(%arg11) : (i32) -> ()
      }) : (i32, tensor<1xi32>) -> tensor<1xi32>
      %33 = "memref.subview"(%arg1, %11) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%32, %33) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

