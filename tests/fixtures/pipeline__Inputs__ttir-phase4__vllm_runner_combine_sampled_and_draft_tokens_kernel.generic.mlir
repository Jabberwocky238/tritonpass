"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, memref<?xi64>, memref<?xi64>, memref<?xi32>, memref<?xi32>, memref<?xi32>, memref<?xi32>, i32, memref<?xi32>, memref<?xi64>) -> (), sym_name = "_combine_sampled_and_draft_tokens_kernel"}> ({
  ^bb0(%arg0: memref<?xi32>, %arg1: memref<?xi64>, %arg2: memref<?xi64>, %arg3: memref<?xi32>, %arg4: memref<?xi32>, %arg5: memref<?xi32>, %arg6: memref<?xi32>, %arg7: i32, %arg8: memref<?xi32>, %arg9: memref<?xi64>):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %5 = "arith.index_cast"(%4) : (index) -> i32
    %6 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
    %7 = "memref.load"(%6, %4) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
    %8 = "memref.reinterpret_cast"(%arg8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %9 = "memref.load"(%8, %4) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %10 = "arith.index_cast"(%9) : (i32) -> index
    %11 = "arith.addi"(%5, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %12 = "arith.index_cast"(%11) : (i32) -> index
    %13 = "memref.load"(%8, %12) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %14 = "arith.subi"(%13, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %15 = "arith.subi"(%14, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %16 = "memref.reinterpret_cast"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %17 = "memref.load"(%16, %12) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %18 = "arith.index_cast"(%17) : (i32) -> index
    %19 = "arith.subi"(%17, %14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %20 = "arith.cmpi"(%14, %3) <{predicate = 4 : i64}> : (i32, i32) -> i1
    %21 = "arith.extsi"(%19) : (i32) -> i64
    %22 = "tensor.empty"() : () -> tensor<1xi64>
    %23 = "linalg.fill"(%21, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: i64, %arg15: i64):
      "linalg.yield"(%arg14) : (i64) -> ()
    }) : (i64, tensor<1xi64>) -> tensor<1xi64>
    %24 = "arith.select"(%20, %1, %2) : (i1, index, index) -> index
    %25 = "tensor.extract_slice"(%23, %24) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1xi64>, index) -> tensor<?xi64>
    %26 = "memref.subview"(%arg9, %10, %24) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi64>, index, index) -> memref<?xi64, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%25, %26) <{writable}> : (tensor<?xi64>, memref<?xi64, strided<[1], offset: ?>>) -> ()
    %27 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %28 = "memref.load"(%27, %4) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %29 = "arith.index_cast"(%7) : (i64) -> index
    %30 = "memref.reinterpret_cast"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %31 = "memref.load"(%30, %29) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %32 = "arith.cmpi"(%28, %31) <{predicate = 3 : i64}> : (i32, i32) -> i1
    "scf.if"(%32) ({
      "scf.yield"() : () -> ()
    }, {
      %33 = "arith.subi"(%28, %14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %34 = "arith.cmpi"(%33, %31) <{predicate = 5 : i64}> : (i32, i32) -> i1
      "scf.if"(%34) ({
        %46 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
        %47 = "memref.load"(%46, %29) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
        %48 = "arith.trunci"(%47) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
        %49 = "arith.index_cast"(%19) : (i32) -> index
        %50 = "tensor.empty"() : () -> tensor<1xi32>
        %51 = "linalg.fill"(%48, %50) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg12: i32, %arg13: i32):
          "linalg.yield"(%arg12) : (i32) -> ()
        }) : (i32, tensor<1xi32>) -> tensor<1xi32>
        %52 = "memref.subview"(%arg0, %49) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
        "bufferization.materialize_in_destination"(%51, %52) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      %35 = "arith.cmpi"(%15, %3) <{predicate = 4 : i64}> : (i32, i32) -> i1
      "scf.if"(%35) ({
        %36 = "arith.extsi"(%arg7) : (i32) -> i64
        %37 = "arith.muli"(%7, %36) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
        %38 = "arith.index_cast"(%37) : (i64) -> index
        %39 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xi32>
        %40 = "memref.subview"(%arg6, %38) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
        "linalg.copy"(%40, %39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg10: i32, %arg11: i32):
          "linalg.yield"(%arg10) : (i32) -> ()
        }) : (memref<1xi32, strided<[1], offset: ?>>, memref<1xi32>) -> ()
        %41 = "bufferization.to_tensor"(%39) <{restrict, writable}> : (memref<1xi32>) -> tensor<1xi32>
        %42 = "arith.subi"(%0, %14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %43 = "arith.index_cast"(%42) : (i32) -> index
        %44 = "arith.addi"(%18, %43) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %45 = "memref.subview"(%arg0, %44) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
        "bufferization.materialize_in_destination"(%41, %45) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

