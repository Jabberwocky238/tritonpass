"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32, i32) -> (), sym_name = "mean_kernel"}> ({
  ^bb0(%arg5: memref<?xf32>, %arg6: memref<?xf32>, %arg7: i32, %arg8: i32, %arg9: i32):
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %6 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %7 = "arith.index_cast"(%6) : (index) -> i32
    %8 = "arith.cmpi"(%7, %arg8) <{predicate = 5 : i64}> : (i32, i32) -> i1
    "cf.cond_br"(%8)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    %9 = "arith.index_cast"(%arg9) : (i32) -> index
    %10 = "scf.for"(%4, %9, %5, %3) ({
    ^bb0(%arg12: index, %arg13: f32):
      %16 = "arith.muli"(%7, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %17 = "arith.index_cast"(%16) : (i32) -> index
      %18 = "arith.addi"(%arg12, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %19 = "arith.minsi"(%18, %9) : (index, index) -> index
      %20 = "arith.maxsi"(%19, %arg12) : (index, index) -> index
      %21 = "arith.subi"(%20, %arg12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %22 = "arith.addi"(%17, %arg12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %23 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
      "linalg.fill"(%3, %23) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg16: f32, %arg17: f32):
        "linalg.yield"(%arg16) : (f32) -> ()
      }) : (f32, memref<1024xf32>) -> ()
      %24 = "memref.subview"(%arg5, %22, %21) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %25 = "memref.subview"(%23, %21) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%24, %25) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg14: f32, %arg15: f32):
        "linalg.yield"(%arg14) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %26 = "bufferization.to_tensor"(%23) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
      %27 = "func.call"(%26) <{callee = @triton.language.standard.sum__fp32S1024S_cNone_cFalse_cNone}> : (tensor<1024xf32>) -> f32
      %28 = "arith.addf"(%arg13, %27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%28) : (f32) -> ()
    }) : (index, index, index, f32) -> f32
    %11 = "arith.sitofp"(%arg9) : (i32) -> f32
    %12 = "arith.divf"(%10, %11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %13 = "tensor.empty"() : () -> tensor<1xf32>
    %14 = "linalg.fill"(%12, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %15 = "memref.subview"(%arg6, %6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%14, %15) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1024xf32>) -> f32, sym_name = "triton.language.standard.sum__fp32S1024S_cNone_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<1024xf32>):
    %1 = "tt.reduce"(%arg2) <{axis = 0 : i32}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%2) : (f32) -> ()
    }) : (tensor<1024xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

