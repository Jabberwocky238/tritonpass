#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xi32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg15: memref<?xf32>, %arg16: memref<?xi32>):
    %15 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32>
    %16 = "memref.subview"(%arg15) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<128xf32, strided<[1]>>
    "linalg.copy"(%16, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32):
      "linalg.yield"(%arg19) : (f32) -> ()
    }) : (memref<128xf32, strided<[1]>>, memref<128xf32>) -> ()
    %17 = "bufferization.to_tensor"(%15) <{restrict, writable}> : (memref<128xf32>) -> tensor<128xf32>
    %18 = "func.call"(%17) <{callee = @triton.language.standard.argmax__fp32S128S_c0_cTrue_cFalse}> : (tensor<128xf32>) -> i32
    %19 = "tensor.empty"() : () -> tensor<1xi32>
    %20 = "linalg.fill"(%18, %19) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: i32, %arg18: i32):
      "linalg.yield"(%arg17) : (i32) -> ()
    }) : (i32, tensor<1xi32>) -> tensor<1xi32>
    %21 = "memref.subview"(%arg16) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1xi32, strided<[1]>>
    "bufferization.materialize_in_destination"(%20, %21) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<128xf32>) -> i32, sym_name = "triton.language.standard.argmax__fp32S128S_c0_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg14: tensor<128xf32>):
    %14 = "func.call"(%arg14) <{callee = @triton.language.standard.max__fp32S128S_c0_cTrue_cTrue_cFalse}> : (tensor<128xf32>) -> i32
    "func.return"(%14) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<128xf32>) -> i32, sym_name = "triton.language.standard.max__fp32S128S_c0_cTrue_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg8: tensor<128xf32>):
    %8 = "tensor.empty"() : () -> tensor<128xi32>
    %9 = "linalg.generic"(%8) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg13: i32):
      %12 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %13 = "arith.index_cast"(%12) : (index) -> i32
      "linalg.yield"(%13) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %10:2 = "tt.reduce"(%arg8, %9) <{axis = 0 : i32}> ({
    ^bb0(%arg9: f32, %arg10: i32, %arg11: f32, %arg12: i32):
      %11:2 = "func.call"(%arg9, %arg10, %arg11, %arg12) <{callee = @triton.language.standard._argmax_combine_tie_break_left__fp32_i32_fp32_i32}> : (f32, i32, f32, i32) -> (f32, i32)
      "tt.reduce.return"(%11#0, %11#1) : (f32, i32) -> ()
    }) : (tensor<128xf32>, tensor<128xi32>) -> (f32, i32)
    "func.return"(%10#1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32, f32, i32) -> (f32, i32), sym_name = "triton.language.standard._argmax_combine_tie_break_left__fp32_i32_fp32_i32", sym_visibility = "private"}> ({
  ^bb0(%arg4: f32, %arg5: i32, %arg6: f32, %arg7: i32):
    %7:2 = "func.call"(%arg4, %arg5, %arg6, %arg7) <{callee = @triton.language.standard._argmax_combine__fp32_i32_fp32_i32_cTrue}> : (f32, i32, f32, i32) -> (f32, i32)
    "func.return"(%7#0, %7#1) : (f32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32, f32, i32) -> (f32, i32), sym_name = "triton.language.standard._argmax_combine__fp32_i32_fp32_i32_cTrue", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: i32, %arg2: f32, %arg3: i32):
    %0 = "arith.cmpf"(%arg0, %arg2) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %1 = "arith.cmpi"(%arg1, %arg3) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %2 = "arith.andi"(%0, %1) : (i1, i1) -> i1
    %3 = "arith.cmpf"(%arg0, %arg2) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
    %4 = "arith.ori"(%3, %2) : (i1, i1) -> i1
    %5 = "arith.select"(%4, %arg0, %arg2) : (i1, f32, f32) -> f32
    %6 = "arith.select"(%4, %arg1, %arg3) : (i1, i32, i32) -> i32
    "func.return"(%5, %6) : (f32, i32) -> ()
  }) : () -> ()
}) : () -> ()

