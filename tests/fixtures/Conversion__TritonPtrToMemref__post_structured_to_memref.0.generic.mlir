"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32) -> (), sym_name = "add_kernel_01234", sym_visibility = "public"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: i32):
    %0 = "arith.constant"() <{value = 1024 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %2 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "arith.index_cast"(%3) : (i32) -> index
    %5 = "memref.reinterpret_cast"(%arg0, %4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1024>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1024xf32, strided<[1], offset: ?>>
    %6 = "arith.addi"(%4, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %7 = "arith.index_cast"(%arg3) : (i32) -> index
    %8 = "arith.minsi"(%6, %7) : (index, index) -> index
    %9 = "arith.subi"(%8, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %10 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
    %11 = "memref.subview"(%5, %9) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32, strided<[1], offset: ?>>, index) -> memref<?xf32, strided<[1], offset: ?>>
    %12 = "memref.subview"(%10, %9) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
    "memref.copy"(%11, %12) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %13 = "bufferization.to_tensor"(%10) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
    %14 = "memref.reinterpret_cast"(%arg1, %4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1024>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1024xf32, strided<[1], offset: ?>>
    %15 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
    %16 = "memref.subview"(%14, %9) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32, strided<[1], offset: ?>>, index) -> memref<?xf32, strided<[1], offset: ?>>
    %17 = "memref.subview"(%15, %9) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
    "memref.copy"(%16, %17) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %18 = "bufferization.to_tensor"(%15) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
    %19 = "arith.addf"(%13, %18) <{fastmath = #arith.fastmath<none>}> : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %20 = "memref.reinterpret_cast"(%arg2, %4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1024>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1024xf32, strided<[1], offset: ?>>
    %21 = "tensor.extract_slice"(%19, %9) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xf32>, index) -> tensor<?xf32>
    %22 = "memref.subview"(%20, %9) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32, strided<[1], offset: ?>>, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%21, %22) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

