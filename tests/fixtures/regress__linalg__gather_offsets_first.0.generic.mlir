"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, tensor<8xi32>, index) -> tensor<8x16xf32>, sym_name = "gather_rows"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: tensor<8xi32>, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (!tt.ptr<f32>) -> memref<?xf32>
    %1 = "arith.constant"() <{value = 16 : index}> : () -> index
    %2 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %3 = "builtin.unrealized_conversion_cast"(%0) : (memref<?xf32>) -> memref<?xf32>
    %4 = "arith.index_cast"(%arg1) : (tensor<8xi32>) -> tensor<8xindex>
    %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x16xf32>
    "linalg.fill"(%2, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, memref<8x16xf32>) -> ()
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "arith.constant"() <{value = 8 : index}> : () -> index
    %8 = "arith.constant"() <{value = 8 : index}> : () -> index
    %9 = "arith.minsi"(%arg2, %8) : (index, index) -> index
    %10 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%6, %9, %10) ({
    ^bb0(%arg3: index):
      %12 = "tensor.extract"(%4, %arg3) : (tensor<8xindex>, index) -> index
      %13 = "arith.constant"() <{value = 16 : index}> : () -> index
      %14 = "arith.muli"(%12, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %15 = "memref.reinterpret_cast"(%3, %14) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: 16, 1>}> : (memref<?xf32>, index) -> memref<1x16xf32, strided<[16, 1], offset: ?>>
      %16 = "memref.subview"(%15, %6, %6, %10, %10) <{operandSegmentSizes = array<i32: 1, 2, 0, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<1x16xf32, strided<[16, 1], offset: ?>>, index, index, index, index) -> memref<1x16xf32, strided<[?, ?], offset: ?>>
      %17 = "memref.subview"(%5, %arg3, %6, %10, %10) <{operandSegmentSizes = array<i32: 1, 2, 0, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<8x16xf32>, index, index, index, index) -> memref<1x16xf32, strided<[?, ?], offset: ?>>
      "memref.copy"(%16, %17) : (memref<1x16xf32, strided<[?, ?], offset: ?>>, memref<1x16xf32, strided<[?, ?], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %11 = "bufferization.to_tensor"(%5) <{restrict, writable}> : (memref<8x16xf32>) -> tensor<8x16xf32>
    "tt.return"(%11) : (tensor<8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

