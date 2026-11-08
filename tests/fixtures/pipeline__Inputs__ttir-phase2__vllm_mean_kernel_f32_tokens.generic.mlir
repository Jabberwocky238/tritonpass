"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32, i32) -> (), sym_name = "mean_kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32, %arg3: i32, %arg4: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %3 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %4 = "arith.index_cast"(%3) : (index) -> i32
    %5 = "arith.cmpi"(%4, %arg3) <{predicate = 5 : i64}> : (i32, i32) -> i1
    "scf.if"(%5) ({
      "scf.yield"() : () -> ()
    }, {
      %6 = "arith.muli"(%4, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %7 = "arith.index_cast"(%6) : (i32) -> index
      %8 = "arith.index_cast"(%arg4) : (i32) -> index
      %9 = "scf.for"(%1, %8, %2, %0) ({
      ^bb0(%arg7: index, %arg8: f32):
        %15 = "arith.addi"(%arg7, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %16 = "arith.minsi"(%15, %8) : (index, index) -> index
        %17 = "arith.maxsi"(%16, %arg7) : (index, index) -> index
        %18 = "arith.subi"(%17, %arg7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %19 = "arith.addi"(%7, %arg7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %20 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
        "linalg.fill"(%0, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg15: f32, %arg16: f32):
          "linalg.yield"(%arg15) : (f32) -> ()
        }) : (f32, memref<1024xf32>) -> ()
        %21 = "memref.subview"(%arg0, %19, %18) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
        %22 = "memref.subview"(%20, %18) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
        "linalg.copy"(%21, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg13: f32, %arg14: f32):
          "linalg.yield"(%arg13) : (f32) -> ()
        }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
        %23 = "bufferization.to_tensor"(%20) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
        %24 = "tensor.empty"() : () -> tensor<f32>
        %25 = "linalg.fill"(%0, %24) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg11: f32, %arg12: f32):
          "linalg.yield"(%arg11) : (f32) -> ()
        }) : (f32, tensor<f32>) -> tensor<f32>
        %26 = "linalg.reduce"(%23, %25) <{dimensions = array<i64: 0>}> ({
        ^bb0(%arg9: f32, %arg10: f32):
          %29 = "arith.addf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%29) : (f32) -> ()
        }) : (tensor<1024xf32>, tensor<f32>) -> tensor<f32>
        %27 = "tensor.extract"(%26) : (tensor<f32>) -> f32
        %28 = "arith.addf"(%arg8, %27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "scf.yield"(%28) : (f32) -> ()
      }) : (index, index, index, f32) -> f32
      %10 = "arith.sitofp"(%arg4) : (i32) -> f32
      %11 = "arith.divf"(%9, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %12 = "tensor.empty"() : () -> tensor<1xf32>
      %13 = "linalg.fill"(%11, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg5: f32, %arg6: f32):
        "linalg.yield"(%arg5) : (f32) -> ()
      }) : (f32, tensor<1xf32>) -> tensor<1xf32>
      %14 = "memref.subview"(%arg1, %3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%13, %14) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

