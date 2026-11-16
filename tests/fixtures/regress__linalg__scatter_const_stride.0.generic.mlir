"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, tensor<8xi32>, tensor<8x16xf32>) -> (), sym_name = "scatter_rows"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: tensor<8xi32>, %arg2: tensor<8x16xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (!tt.ptr<f32>) -> memref<?xf32>
    %1 = "arith.constant"() <{value = 16 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%0) : (memref<?xf32>) -> memref<?xf32>
    %3 = "arith.index_cast"(%arg1) : (tensor<8xi32>) -> tensor<8xindex>
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 8 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%4, %5, %6) ({
    ^bb0(%arg3: index):
      %7 = "tensor.extract"(%3, %arg3) : (tensor<8xindex>, index) -> index
      %8 = "tensor.extract_slice"(%arg2, %arg3, %4, %6, %6) <{operandSegmentSizes = array<i32: 1, 2, 0, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<8x16xf32>, index, index, index, index) -> tensor<1x16xf32>
      %9 = "arith.constant"() <{value = 16 : index}> : () -> index
      %10 = "arith.muli"(%7, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %11 = "memref.reinterpret_cast"(%2, %10) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: 16, 1>}> : (memref<?xf32>, index) -> memref<1x16xf32, strided<[16, 1], offset: ?>>
      "bufferization.materialize_in_destination"(%8, %11) <{writable}> : (tensor<1x16xf32>, memref<1x16xf32, strided<[16, 1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

