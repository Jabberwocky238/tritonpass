"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, memref<?xi32>, i32, i32, memref<?xi64>, memref<?xi32>, memref<?xi32>, i32, memref<?xi32>, memref<?xi32>) -> (), sym_name = "_prepare_prefill_inputs_kernel"}> ({
  ^bb0(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: i32, %arg3: i32, %arg4: memref<?xi64>, %arg5: memref<?xi32>, %arg6: memref<?xi32>, %arg7: i32, %arg8: memref<?xi32>, %arg9: memref<?xi32>):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %5 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %6 = "arith.index_cast"(%5) : (index) -> i32
    %7 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
    %8 = "memref.load"(%7, %5) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
    %9 = "arith.index_cast"(%8) : (i64) -> index
    %10 = "memref.reinterpret_cast"(%arg8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %11 = "memref.load"(%10, %9) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %12 = "memref.reinterpret_cast"(%arg9) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %13 = "memref.load"(%12, %9) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %14 = "arith.index_cast"(%13) : (i32) -> index
    %15 = "arith.cmpi"(%13, %11) <{predicate = 5 : i64}> : (i32, i32) -> i1
    "scf.if"(%15) ({
      "scf.yield"() : () -> ()
    }, {
      %16 = "memref.reinterpret_cast"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
      %17 = "memref.load"(%16, %5) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
      %18 = "arith.index_cast"(%17) : (i32) -> index
      %19 = "arith.addi"(%6, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %20 = "arith.index_cast"(%19) : (i32) -> index
      %21 = "memref.load"(%16, %20) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
      %22 = "arith.subi"(%21, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %23 = "arith.extsi"(%arg7) : (i32) -> i64
      %24 = "arith.muli"(%8, %23) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %25 = "arith.index_cast"(%24) : (i64) -> index
      %26 = "arith.index_cast"(%22) : (i32) -> index
      "scf.for"(%1, %26, %2) ({
      ^bb0(%arg14: index):
        %41 = "arith.addi"(%arg14, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %42 = "arith.minsi"(%41, %26) : (index, index) -> index
        %43 = "arith.maxsi"(%42, %arg14) : (index, index) -> index
        %44 = "arith.subi"(%43, %arg14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %45 = "arith.addi"(%25, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %46 = "arith.addi"(%45, %arg14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %47 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xi32>
        "linalg.fill"(%4, %47) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg17: i32, %arg18: i32):
          "linalg.yield"(%arg17) : (i32) -> ()
        }) : (i32, memref<1024xi32>) -> ()
        %48 = "memref.subview"(%arg6, %46, %44) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
        %49 = "memref.subview"(%47, %44) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xi32>, index) -> memref<?xi32, strided<[1]>>
        "linalg.copy"(%48, %49) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg15: i32, %arg16: i32):
          "linalg.yield"(%arg15) : (i32) -> ()
        }) : (memref<?xi32, strided<[1], offset: ?>>, memref<?xi32, strided<[1]>>) -> ()
        %50 = "bufferization.to_tensor"(%47) <{restrict, writable}> : (memref<1024xi32>) -> tensor<1024xi32>
        %51 = "arith.addi"(%18, %arg14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %52 = "tensor.extract_slice"(%50, %44) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xi32>, index) -> tensor<?xi32>
        %53 = "memref.subview"(%arg0, %51, %44) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
        "bufferization.materialize_in_destination"(%52, %53) <{writable}> : (tensor<?xi32>, memref<?xi32, strided<[1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      %27 = "arith.addi"(%13, %22) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %28 = "arith.index_cast"(%27) : (i32) -> index
      %29 = "arith.cmpi"(%arg3, %4) <{predicate = 4 : i64}> : (i32, i32) -> i1
      %30 = "arith.cmpi"(%27, %11) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %31 = "arith.andi"(%29, %30) : (i1, i1) -> i1
      %32 = "arith.select"(%31, %3, %1) : (i1, index, index) -> index
      %33 = "arith.addi"(%25, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %34 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xi32>
      "linalg.fill"(%4, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg12: i32, %arg13: i32):
        "linalg.yield"(%arg12) : (i32) -> ()
      }) : (i32, memref<1xi32>) -> ()
      %35 = "memref.subview"(%arg6, %33, %32) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
      %36 = "memref.subview"(%34, %32) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1xi32>, index) -> memref<?xi32, strided<[1]>>
      "linalg.copy"(%35, %36) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg10: i32, %arg11: i32):
        "linalg.yield"(%arg10) : (i32) -> ()
      }) : (memref<?xi32, strided<[1], offset: ?>>, memref<?xi32, strided<[1]>>) -> ()
      %37 = "bufferization.to_tensor"(%34) <{restrict, writable}> : (memref<1xi32>) -> tensor<1xi32>
      %38 = "arith.select"(%29, %3, %1) : (i1, index, index) -> index
      %39 = "tensor.extract_slice"(%37, %38) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1xi32>, index) -> tensor<?xi32>
      %40 = "memref.subview"(%arg1, %9, %38) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%39, %40) <{writable}> : (tensor<?xi32>, memref<?xi32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

