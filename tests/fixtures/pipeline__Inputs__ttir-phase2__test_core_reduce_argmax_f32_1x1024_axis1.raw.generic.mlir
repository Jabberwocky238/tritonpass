#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xi32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg15: memref<?xf32>, %arg16: memref<?xi32>):
    %16 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
    %17 = "memref.subview"(%arg15) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1024>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<1024xf32, strided<[1]>>
    "linalg.copy"(%17, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: f32, %arg18: f32):
      "linalg.yield"(%arg17) : (f32) -> ()
    }) : (memref<1024xf32, strided<[1]>>, memref<1024xf32>) -> ()
    %18 = "bufferization.to_tensor"(%16) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
    %19 = "tensor.expand_shape"(%18) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 1024>}> : (tensor<1024xf32>) -> tensor<1x1024xf32>
    %20 = "func.call"(%19) <{callee = @triton.language.standard.argmax__fp32S1_1024S_c1_cTrue_cFalse}> : (tensor<1x1024xf32>) -> tensor<1xi32>
    %21 = "memref.reinterpret_cast"(%arg16) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %22 = "memref.subview"(%21) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<1099511627776xi32, strided<[1]>>) -> memref<1xi32, strided<[1]>>
    "bufferization.materialize_in_destination"(%20, %22) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x1024xf32>) -> tensor<1xi32>, sym_name = "triton.language.standard.argmax__fp32S1_1024S_c1_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg14: tensor<1x1024xf32>):
    %15 = "func.call"(%arg14) <{callee = @triton.language.standard.max__fp32S1_1024S_c1_cTrue_cTrue_cFalse}> : (tensor<1x1024xf32>) -> tensor<1xi32>
    "func.return"(%15) : (tensor<1xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<1x1024xf32>) -> tensor<1xi32>, sym_name = "triton.language.standard.max__fp32S1_1024S_c1_cTrue_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg8: tensor<1x1024xf32>):
    %8 = "tensor.empty"() : () -> tensor<1024xi32>
    %9 = "linalg.generic"(%8) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg13: i32):
      %13 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %14 = "arith.index_cast"(%13) : (index) -> i32
      "linalg.yield"(%14) : (i32) -> ()
    }) : (tensor<1024xi32>) -> tensor<1024xi32>
    %10 = "tensor.expand_shape"(%9) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 1024>}> : (tensor<1024xi32>) -> tensor<1x1024xi32>
    %11:2 = "tt.reduce"(%arg8, %10) <{axis = 1 : i32}> ({
    ^bb0(%arg9: f32, %arg10: i32, %arg11: f32, %arg12: i32):
      %12:2 = "func.call"(%arg9, %arg10, %arg11, %arg12) <{callee = @triton.language.standard._argmax_combine_tie_break_left__fp32_i32_fp32_i32}> : (f32, i32, f32, i32) -> (f32, i32)
      "tt.reduce.return"(%12#0, %12#1) : (f32, i32) -> ()
    }) : (tensor<1x1024xf32>, tensor<1x1024xi32>) -> (tensor<1xf32>, tensor<1xi32>)
    "func.return"(%11#1) : (tensor<1xi32>) -> ()
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

