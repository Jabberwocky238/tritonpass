"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi64>, memref<?xi64>, memref<?xi64>, memref<?xi64>, memref<?xi32>, i32, i32) -> (), sym_name = "_gather_block_tables_kernel"}> ({
  ^bb0(%arg0: memref<?xi64>, %arg1: memref<?xi64>, %arg2: memref<?xi64>, %arg3: memref<?xi64>, %arg4: memref<?xi32>, %arg5: i32, %arg6: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %3 = "tensor.empty"() : () -> tensor<1024xi32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: i32, %arg14: i32):
      "linalg.yield"(%arg13) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %5 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %6 = "arith.index_cast"(%5) : (index) -> i32
    %7 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %8 = "arith.index_cast"(%7) : (index) -> i32
    %9 = "memref.reinterpret_cast"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
    %10 = "memref.load"(%9, %5) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
    %11 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
    %12 = "memref.load"(%11, %5) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
    %13 = "tt.int_to_ptr"(%12) {tt.divisibility = dense<16> : tensor<1xi32>} : (i64) -> !tt.ptr<i32>
    %14 = "builtin.unrealized_conversion_cast"(%13) : (!tt.ptr<i32>) -> memref<?xi32>
    %15 = "arith.extsi"(%8) : (i32) -> i64
    %16 = "arith.muli"(%15, %10) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %17 = "arith.index_cast"(%16) : (i64) -> index
    %18 = "arith.cmpi"(%8, %arg6) <{predicate = 5 : i64}> : (i32, i32) -> i1
    "scf.if"(%18) ({
      %46 = "arith.index_cast"(%10) : (i64) -> index
      "scf.for"(%1, %46, %2) ({
      ^bb0(%arg12: index):
        %47 = "arith.addi"(%arg12, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %48 = "arith.minsi"(%47, %46) : (index, index) -> index
        %49 = "arith.maxsi"(%48, %arg12) : (index, index) -> index
        %50 = "arith.subi"(%49, %arg12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %51 = "arith.addi"(%17, %arg12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %52 = "tensor.extract_slice"(%4, %50) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xi32>, index) -> tensor<?xi32>
        %53 = "memref.subview"(%14, %51, %50) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
        "bufferization.materialize_in_destination"(%52, %53) <{writable}> : (tensor<?xi32>, memref<?xi32, strided<[1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }, {
      %19 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
      %20 = "memref.load"(%19, %7) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
      %21 = "arith.muli"(%6, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %22 = "arith.extsi"(%21) : (i32) -> i64
      %23 = "arith.addi"(%22, %20) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %24 = "arith.index_cast"(%23) : (i64) -> index
      %25 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
      %26 = "memref.load"(%25, %24) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
      %27 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
      %28 = "memref.load"(%27, %5) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
      %29 = "tt.int_to_ptr"(%28) {tt.divisibility = dense<16> : tensor<1xi32>} : (i64) -> !tt.ptr<i32>
      %30 = "builtin.unrealized_conversion_cast"(%29) : (!tt.ptr<i32>) -> memref<?xi32>
      %31 = "arith.muli"(%20, %10) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %32 = "arith.index_cast"(%31) : (i64) -> index
      %33 = "arith.index_cast"(%26) : (i32) -> index
      "scf.for"(%1, %33, %2) ({
      ^bb0(%arg7: index):
        %34 = "arith.addi"(%arg7, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %35 = "arith.minsi"(%34, %33) : (index, index) -> index
        %36 = "arith.maxsi"(%35, %arg7) : (index, index) -> index
        %37 = "arith.subi"(%36, %arg7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %38 = "arith.addi"(%32, %arg7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %39 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xi32>
        "linalg.fill"(%0, %39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg10: i32, %arg11: i32):
          "linalg.yield"(%arg10) : (i32) -> ()
        }) : (i32, memref<1024xi32>) -> ()
        %40 = "memref.subview"(%30, %38, %37) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
        %41 = "memref.subview"(%39, %37) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xi32>, index) -> memref<?xi32, strided<[1]>>
        "linalg.copy"(%40, %41) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg8: i32, %arg9: i32):
          "linalg.yield"(%arg8) : (i32) -> ()
        }) : (memref<?xi32, strided<[1], offset: ?>>, memref<?xi32, strided<[1]>>) -> ()
        %42 = "bufferization.to_tensor"(%39) <{restrict, writable}> : (memref<1024xi32>) -> tensor<1024xi32>
        %43 = "arith.addi"(%17, %arg7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %44 = "tensor.extract_slice"(%42, %37) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xi32>, index) -> tensor<?xi32>
        %45 = "memref.subview"(%14, %43, %37) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
        "bufferization.materialize_in_destination"(%44, %45) <{writable}> : (tensor<?xi32>, memref<?xi32, strided<[1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

