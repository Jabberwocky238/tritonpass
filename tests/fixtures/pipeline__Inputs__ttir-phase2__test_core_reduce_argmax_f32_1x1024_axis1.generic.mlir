#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xi32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xi32>):
    %0 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %2 = "tensor.empty"() : () -> tensor<1024xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg12: i32):
      %23 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %24 = "arith.index_cast"(%23) : (index) -> i32
      "linalg.yield"(%24) : (i32) -> ()
    }) : (tensor<1024xi32>) -> tensor<1024xi32>
    %4 = "tensor.expand_shape"(%3) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 1024>}> : (tensor<1024xi32>) -> tensor<1x1024xi32>
    %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
    %6 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1024>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<1024xf32, strided<[1]>>
    "linalg.copy"(%6, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (memref<1024xf32, strided<[1]>>, memref<1024xf32>) -> ()
    %7 = "bufferization.to_tensor"(%5) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
    %8 = "tensor.expand_shape"(%7) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 1024>}> : (tensor<1024xf32>) -> tensor<1x1024xf32>
    %9 = "tensor.empty"() : () -> tensor<1xf32>
    %10 = "linalg.fill"(%0, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %11 = "tensor.empty"() : () -> tensor<1xi32>
    %12 = "linalg.fill"(%1, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: i32, %arg7: i32):
      "linalg.yield"(%arg6) : (i32) -> ()
    }) : (i32, tensor<1xi32>) -> tensor<1xi32>
    %13:2 = "linalg.reduce"(%8, %4, %10, %12) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg2: f32, %arg3: i32, %arg4: f32, %arg5: i32):
      %16 = "arith.cmpf"(%arg2, %arg4) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      %17 = "arith.cmpi"(%arg3, %arg5) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %18 = "arith.andi"(%16, %17) : (i1, i1) -> i1
      %19 = "arith.cmpf"(%arg2, %arg4) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      %20 = "arith.ori"(%19, %18) : (i1, i1) -> i1
      %21 = "arith.select"(%20, %arg2, %arg4) : (i1, f32, f32) -> f32
      %22 = "arith.select"(%20, %arg3, %arg5) : (i1, i32, i32) -> i32
      "linalg.yield"(%21, %22) : (f32, i32) -> ()
    }) : (tensor<1x1024xf32>, tensor<1x1024xi32>, tensor<1xf32>, tensor<1xi32>) -> (tensor<1xf32>, tensor<1xi32>)
    %14 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %15 = "memref.subview"(%14) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<1099511627776xi32, strided<[1]>>) -> memref<1xi32, strided<[1]>>
    "bufferization.materialize_in_destination"(%13#1, %15) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

