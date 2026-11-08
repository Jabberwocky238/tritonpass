"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32) -> (), sym_name = "reduce_then_scan_root_scan_kernel_row"}> ({
  ^bb0(%arg5: memref<?xf32>, %arg6: memref<?xf32>, %arg7: i32):
    %3 = "arith.constant"() <{value = 8 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %6 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %7 = "arith.index_cast"(%6) : (index) -> i32
    %8 = "arith.extsi"(%7) : (i32) -> i64
    %9 = "arith.extsi"(%arg7) : (i32) -> i64
    %10 = "arith.muli"(%8, %9) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %11 = "arith.index_cast"(%10) : (i64) -> index
    %12 = "arith.index_cast"(%arg7) : (i32) -> index
    %13 = "arith.minsi"(%12, %3) : (index, index) -> index
    %14 = "arith.maxsi"(%13, %4) : (index, index) -> index
    %15 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8xf32>
    "linalg.fill"(%5, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (f32, memref<8xf32>) -> ()
    %16 = "memref.subview"(%arg5, %11, %14) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %17 = "memref.subview"(%15, %14) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<8xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%16, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %18 = "bufferization.to_tensor"(%15) <{restrict, writable}> : (memref<8xf32>) -> tensor<8xf32>
    %19 = "func.call"(%18) <{callee = @triton.language.standard.cumsum__fp32S8S_c0_cFalse_cNone}> : (tensor<8xf32>) -> tensor<8xf32>
    %20 = "tensor.extract_slice"(%19, %14) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<8xf32>, index) -> tensor<?xf32>
    %21 = "memref.subview"(%arg6, %11, %14) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%20, %21) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8xf32>) -> tensor<8xf32>, sym_name = "triton.language.standard.cumsum__fp32S8S_c0_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<8xf32>):
    %1 = "tt.scan"(%arg2) <{axis = 0 : i32, reverse = false}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.scan.return"(%2) : (f32) -> ()
    }) : (tensor<8xf32>) -> tensor<8xf32>
    "func.return"(%1) : (tensor<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

