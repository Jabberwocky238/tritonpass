#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, memref<?xi32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg11: memref<?xi32>, %arg12: memref<?xi32>):
    %7 = "builtin.unrealized_conversion_cast"(%arg12) : (memref<?xi32>) -> !tt.ptr<i32>
    %8 = "builtin.unrealized_conversion_cast"(%arg11) : (memref<?xi32>) -> !tt.ptr<i32>
    %9 = "tensor.empty"() : () -> tensor<32768xi32>
    %10 = "linalg.generic"(%9) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg16: i32):
      %23 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %24 = "arith.index_cast"(%23) : (index) -> i32
      "linalg.yield"(%24) : (i32) -> ()
    }) : (tensor<32768xi32>) -> tensor<32768xi32>
    %11 = "tensor.expand_shape"(%10) <{reassociation = [[0, 1, 2, 3, 4]], static_output_shape = array<i64: 4, 32, 32, 4, 2>}> : (tensor<32768xi32>) -> tensor<4x32x32x4x2xi32>
    %12 = "tts.gather"(%8, %11) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<i32>, tensor<4x32x32x4x2xi32>) -> tensor<4x32x32x4x2xi32>
    %13 = "tensor.empty"() : () -> tensor<32x32x4x4x2xi32>
    %14 = "linalg.transpose"(%12, %13) <{permutation = array<i64: 2, 1, 0, 3, 4>}> ({
    ^bb0(%arg14: i32, %arg15: i32):
      "linalg.yield"(%arg14) : (i32) -> ()
    }) : (tensor<4x32x32x4x2xi32>, tensor<32x32x4x4x2xi32>) -> tensor<32x32x4x4x2xi32>
    %15 = "func.call"(%14) <{callee = @triton.language.standard.sum__i32S32_32_4_4_2S_c3_cFalse_cNone}> : (tensor<32x32x4x4x2xi32>) -> tensor<32x32x4x2xi32>
    %16 = "func.call"(%15) <{callee = @triton.language.standard.sum__i32S32_32_4_2S_c1_cFalse_cNone}> : (tensor<32x32x4x2xi32>) -> tensor<32x4x2xi32>
    %17 = "func.call"(%16) <{callee = @triton.language.standard.sum__i32S32_4_2S_c0_cFalse_cNone}> : (tensor<32x4x2xi32>) -> tensor<4x2xi32>
    %18 = "tensor.empty"() : () -> tensor<8xi32>
    %19 = "linalg.generic"(%18) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg13: i32):
      %21 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %22 = "arith.index_cast"(%21) : (index) -> i32
      "linalg.yield"(%22) : (i32) -> ()
    }) : (tensor<8xi32>) -> tensor<8xi32>
    %20 = "tensor.expand_shape"(%19) <{reassociation = [[0, 1]], static_output_shape = array<i64: 4, 2>}> : (tensor<8xi32>) -> tensor<4x2xi32>
    "tts.scatter"(%7, %20, %17) : (!tt.ptr<i32>, tensor<4x2xi32>, tensor<4x2xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<32x32x4x4x2xi32>) -> tensor<32x32x4x2xi32>, sym_name = "triton.language.standard.sum__i32S32_32_4_4_2S_c3_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg8: tensor<32x32x4x4x2xi32>):
    %5 = "tt.reduce"(%arg8) <{axis = 3 : i32}> ({
    ^bb0(%arg9: i32, %arg10: i32):
      %6 = "func.call"(%arg9, %arg10) <{callee = @triton.language.standard._sum_combine__i32_i32}> : (i32, i32) -> i32
      "tt.reduce.return"(%6) : (i32) -> ()
    }) : (tensor<32x32x4x4x2xi32>) -> tensor<32x32x4x2xi32>
    "func.return"(%5) : (tensor<32x32x4x2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "triton.language.standard._sum_combine__i32_i32", sym_visibility = "private"}> ({
  ^bb0(%arg6: i32, %arg7: i32):
    %4 = "arith.addi"(%arg6, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<32x32x4x2xi32>) -> tensor<32x4x2xi32>, sym_name = "triton.language.standard.sum__i32S32_32_4_2S_c1_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg3: tensor<32x32x4x2xi32>):
    %2 = "tt.reduce"(%arg3) <{axis = 1 : i32}> ({
    ^bb0(%arg4: i32, %arg5: i32):
      %3 = "func.call"(%arg4, %arg5) <{callee = @triton.language.standard._sum_combine__i32_i32}> : (i32, i32) -> i32
      "tt.reduce.return"(%3) : (i32) -> ()
    }) : (tensor<32x32x4x2xi32>) -> tensor<32x4x2xi32>
    "func.return"(%2) : (tensor<32x4x2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<32x4x2xi32>) -> tensor<4x2xi32>, sym_name = "triton.language.standard.sum__i32S32_4_2S_c0_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<32x4x2xi32>):
    %0 = "tt.reduce"(%arg0) <{axis = 0 : i32}> ({
    ^bb0(%arg1: i32, %arg2: i32):
      %1 = "func.call"(%arg1, %arg2) <{callee = @triton.language.standard._sum_combine__i32_i32}> : (i32, i32) -> i32
      "tt.reduce.return"(%1) : (i32) -> ()
    }) : (tensor<32x4x2xi32>) -> tensor<4x2xi32>
    "func.return"(%0) : (tensor<4x2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

