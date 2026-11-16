"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf8E4M3FNUZ>, memref<?xf8E4M3FNUZ>, i32) -> (), sym_name = "masked_load_fnuz"}> ({
  ^bb0(%arg0: memref<?xf8E4M3FNUZ>, %arg1: memref<?xf8E4M3FNUZ>, %arg2: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f8E4M3FNUZ}> : () -> f8E4M3FNUZ
    %1 = "arith.constant"() <{value = 16 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.index_cast"(%arg2) : (i32) -> index
    %4 = "arith.minsi"(%3, %1) : (index, index) -> index
    %5 = "arith.maxsi"(%4, %2) : (index, index) -> index
    %6 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf8E4M3FNUZ>
    "linalg.fill"(%0, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f8E4M3FNUZ, %arg6: f8E4M3FNUZ):
      "linalg.yield"(%arg5) : (f8E4M3FNUZ) -> ()
    }) : (f8E4M3FNUZ, memref<16xf8E4M3FNUZ>) -> ()
    %7 = "memref.subview"(%arg0, %5) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf8E4M3FNUZ>, index) -> memref<?xf8E4M3FNUZ, strided<[1]>>
    %8 = "memref.subview"(%6, %5) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<16xf8E4M3FNUZ>, index) -> memref<?xf8E4M3FNUZ, strided<[1]>>
    "linalg.copy"(%7, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f8E4M3FNUZ, %arg4: f8E4M3FNUZ):
      "linalg.yield"(%arg3) : (f8E4M3FNUZ) -> ()
    }) : (memref<?xf8E4M3FNUZ, strided<[1]>>, memref<?xf8E4M3FNUZ, strided<[1]>>) -> ()
    %9 = "bufferization.to_tensor"(%6) <{restrict, writable}> : (memref<16xf8E4M3FNUZ>) -> tensor<16xf8E4M3FNUZ>
    %10 = "tensor.extract_slice"(%9, %5) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<16xf8E4M3FNUZ>, index) -> tensor<?xf8E4M3FNUZ>
    %11 = "memref.subview"(%arg1, %5) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf8E4M3FNUZ>, index) -> memref<?xf8E4M3FNUZ, strided<[1]>>
    "bufferization.materialize_in_destination"(%10, %11) <{writable}> : (tensor<?xf8E4M3FNUZ>, memref<?xf8E4M3FNUZ, strided<[1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

