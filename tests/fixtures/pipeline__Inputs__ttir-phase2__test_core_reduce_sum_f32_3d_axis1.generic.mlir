"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776, 1099511627776>, static_strides = array<i64: 512, 16, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776x1099511627776xf32, strided<[512, 16, 1]>>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x32x16xf32>
    %3 = "memref.subview"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 2, 32, 16>, static_strides = array<i64: 1, 1, 1>}> : (memref<1099511627776x1099511627776x1099511627776xf32, strided<[512, 16, 1]>>) -> memref<2x32x16xf32, strided<[512, 16, 1]>>
    "linalg.copy"(%3, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (memref<2x32x16xf32, strided<[512, 16, 1]>>, memref<2x32x16xf32>) -> ()
    %4 = "bufferization.to_tensor"(%2) <{restrict, writable}> : (memref<2x32x16xf32>) -> tensor<2x32x16xf32>
    %5 = "tensor.empty"() : () -> tensor<2x16xf32>
    %6 = "linalg.fill"(%0, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<2x16xf32>) -> tensor<2x16xf32>
    %7 = "linalg.reduce"(%4, %6) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %10 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<2x32x16xf32>, tensor<2x16xf32>) -> tensor<2x16xf32>
    %8 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 16, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[16, 1]>>
    %9 = "memref.subview"(%8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 2, 16>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[16, 1]>>) -> memref<2x16xf32, strided<[16, 1]>>
    "bufferization.materialize_in_destination"(%7, %9) <{writable}> : (tensor<2x16xf32>, memref<2x16xf32, strided<[16, 1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

