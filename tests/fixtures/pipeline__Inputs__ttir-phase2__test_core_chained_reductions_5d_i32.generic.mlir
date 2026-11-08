#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, memref<?xi32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: memref<?xi32>, %arg1: memref<?xi32>):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<?xi32>) -> !tt.ptr<i32>
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xi32>) -> !tt.ptr<i32>
    %3 = "tensor.empty"() : () -> tensor<32768xi32>
    %4 = "linalg.generic"(%3) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg17: i32):
      %26 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %27 = "arith.index_cast"(%26) : (index) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<32768xi32>) -> tensor<32768xi32>
    %5 = "tensor.expand_shape"(%4) <{reassociation = [[0, 1, 2, 3, 4]], static_output_shape = array<i64: 4, 32, 32, 4, 2>}> : (tensor<32768xi32>) -> tensor<4x32x32x4x2xi32>
    %6 = "tts.gather"(%2, %5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<i32>, tensor<4x32x32x4x2xi32>) -> tensor<4x32x32x4x2xi32>
    %7 = "tensor.empty"() : () -> tensor<32x32x4x4x2xi32>
    %8 = "linalg.transpose"(%6, %7) <{permutation = array<i64: 2, 1, 0, 3, 4>}> ({
    ^bb0(%arg15: i32, %arg16: i32):
      "linalg.yield"(%arg15) : (i32) -> ()
    }) : (tensor<4x32x32x4x2xi32>, tensor<32x32x4x4x2xi32>) -> tensor<32x32x4x4x2xi32>
    %9 = "tensor.empty"() : () -> tensor<32x32x4x2xi32>
    %10 = "linalg.fill"(%0, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: i32, %arg14: i32):
      "linalg.yield"(%arg13) : (i32) -> ()
    }) : (i32, tensor<32x32x4x2xi32>) -> tensor<32x32x4x2xi32>
    %11 = "linalg.reduce"(%8, %10) <{dimensions = array<i64: 3>}> ({
    ^bb0(%arg11: i32, %arg12: i32):
      %25 = "arith.addi"(%arg11, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<32x32x4x4x2xi32>, tensor<32x32x4x2xi32>) -> tensor<32x32x4x2xi32>
    %12 = "tensor.empty"() : () -> tensor<32x4x2xi32>
    %13 = "linalg.fill"(%0, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: i32, %arg10: i32):
      "linalg.yield"(%arg9) : (i32) -> ()
    }) : (i32, tensor<32x4x2xi32>) -> tensor<32x4x2xi32>
    %14 = "linalg.reduce"(%11, %13) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg7: i32, %arg8: i32):
      %24 = "arith.addi"(%arg7, %arg8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%24) : (i32) -> ()
    }) : (tensor<32x32x4x2xi32>, tensor<32x4x2xi32>) -> tensor<32x4x2xi32>
    %15 = "tensor.empty"() : () -> tensor<4x2xi32>
    %16 = "linalg.fill"(%0, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: i32, %arg6: i32):
      "linalg.yield"(%arg5) : (i32) -> ()
    }) : (i32, tensor<4x2xi32>) -> tensor<4x2xi32>
    %17 = "linalg.reduce"(%14, %16) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg3: i32, %arg4: i32):
      %23 = "arith.addi"(%arg3, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%23) : (i32) -> ()
    }) : (tensor<32x4x2xi32>, tensor<4x2xi32>) -> tensor<4x2xi32>
    %18 = "tensor.empty"() : () -> tensor<8xi32>
    %19 = "linalg.generic"(%18) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg2: i32):
      %21 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %22 = "arith.index_cast"(%21) : (index) -> i32
      "linalg.yield"(%22) : (i32) -> ()
    }) : (tensor<8xi32>) -> tensor<8xi32>
    %20 = "tensor.expand_shape"(%19) <{reassociation = [[0, 1]], static_output_shape = array<i64: 4, 2>}> : (tensor<8xi32>) -> tensor<4x2xi32>
    "tts.scatter"(%1, %20, %17) : (!tt.ptr<i32>, tensor<4x2xi32>, tensor<4x2xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

