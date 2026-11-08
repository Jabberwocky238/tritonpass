#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>):
    %0 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %2 = "tensor.empty"() : () -> tensor<128xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg14: i32):
      %23 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %24 = "arith.index_cast"(%23) : (index) -> i32
      "linalg.yield"(%24) : (i32) -> ()
    }) : (tensor<128xi32>) -> tensor<128xi32>
    %4 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32>
    %5 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<128xf32, strided<[1]>>
    "linalg.copy"(%5, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (memref<128xf32, strided<[1]>>, memref<128xf32>) -> ()
    %6 = "bufferization.to_tensor"(%4) <{restrict, writable}> : (memref<128xf32>) -> tensor<128xf32>
    %7 = "tensor.empty"() : () -> tensor<f32>
    %8 = "linalg.fill"(%0, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %9 = "tensor.empty"() : () -> tensor<i32>
    %10 = "linalg.fill"(%1, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: i32, %arg9: i32):
      "linalg.yield"(%arg8) : (i32) -> ()
    }) : (i32, tensor<i32>) -> tensor<i32>
    %11:2 = "linalg.reduce"(%6, %3, %8, %10) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg4: f32, %arg5: i32, %arg6: f32, %arg7: i32):
      %16 = "arith.cmpf"(%arg4, %arg6) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      %17 = "arith.cmpi"(%arg5, %arg7) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %18 = "arith.andi"(%16, %17) : (i1, i1) -> i1
      %19 = "arith.cmpf"(%arg4, %arg6) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      %20 = "arith.ori"(%19, %18) : (i1, i1) -> i1
      %21 = "arith.select"(%20, %arg4, %arg6) : (i1, f32, f32) -> f32
      %22 = "arith.select"(%20, %arg5, %arg7) : (i1, i32, i32) -> i32
      "linalg.yield"(%21, %22) : (f32, i32) -> ()
    }) : (tensor<128xf32>, tensor<128xi32>, tensor<f32>, tensor<i32>) -> (tensor<f32>, tensor<i32>)
    %12 = "tensor.extract"(%11#0) : (tensor<f32>) -> f32
    %13 = "tensor.empty"() : () -> tensor<1xf32>
    %14 = "linalg.fill"(%12, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %15 = "memref.subview"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<1xf32, strided<[1]>>
    "bufferization.materialize_in_destination"(%14, %15) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

