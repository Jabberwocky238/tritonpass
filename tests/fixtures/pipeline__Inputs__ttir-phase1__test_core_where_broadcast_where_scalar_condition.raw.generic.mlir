"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "where_scalar_condition"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<32x32xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<32x32xf32>) -> tensor<32x32xf32>
    %3 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 32, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[32, 1]>>
    %4 = "memref.subview"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[32, 1]>>) -> memref<32x32xf32, strided<[32, 1]>>
    "bufferization.materialize_in_destination"(%2, %4) <{writable}> : (tensor<32x32xf32>, memref<32x32xf32, strided<[32, 1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

