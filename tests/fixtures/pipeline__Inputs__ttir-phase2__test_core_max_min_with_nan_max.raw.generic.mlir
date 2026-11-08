"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "max_kernel"}> ({
  ^bb0(%arg5: memref<?xf32>, %arg6: memref<?xf32>):
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xf32>
    %5 = "memref.subview"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 64>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<64xf32, strided<[1]>>
    "linalg.copy"(%5, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (memref<64xf32, strided<[1]>>, memref<64xf32>) -> ()
    %6 = "bufferization.to_tensor"(%4) <{restrict, writable}> : (memref<64xf32>) -> tensor<64xf32>
    %7 = "func.call"(%6) <{callee = @triton.language.standard.max__fp32S64S_c0_cFalse_cTrue_cFalse}> : (tensor<64xf32>) -> f32
    %8 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %9 = "arith.index_cast"(%8) : (index) -> i32
    %10 = "arith.cmpi"(%9, %3) <{predicate = 0 : i64}> : (i32, i32) -> i1
    "scf.if"(%10) ({
      %11 = "tensor.empty"() : () -> tensor<1xf32>
      %12 = "linalg.fill"(%7, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg7: f32, %arg8: f32):
        "linalg.yield"(%arg7) : (f32) -> ()
      }) : (f32, tensor<1xf32>) -> tensor<1xf32>
      %13 = "memref.subview"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<1xf32, strided<[1]>>
      "bufferization.materialize_in_destination"(%12, %13) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1]>>) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<64xf32>) -> f32, sym_name = "triton.language.standard.max__fp32S64S_c0_cFalse_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<64xf32>):
    %1 = "tt.reduce"(%arg2) <{axis = 0 : i32}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._elementwise_max__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%2) : (f32) -> ()
    }) : (tensor<64xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._elementwise_max__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.maxnumf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

