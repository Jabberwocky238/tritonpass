"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32) -> (), sym_name = "reduce_then_scan_root_scan_kernel_row"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32):
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %4 = "arith.index_cast"(%3) : (index) -> i32
    %5 = "arith.extsi"(%4) : (i32) -> i64
    %6 = "arith.extsi"(%arg2) : (i32) -> i64
    %7 = "arith.muli"(%5, %6) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %8 = "arith.index_cast"(%7) : (i64) -> index
    %9 = "arith.index_cast"(%arg2) : (i32) -> index
    %10 = "arith.minsi"(%9, %0) : (index, index) -> index
    %11 = "arith.maxsi"(%10, %1) : (index, index) -> index
    %12 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8xf32>
    "linalg.fill"(%2, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32):
      "linalg.yield"(%arg7) : (f32) -> ()
    }) : (f32, memref<8xf32>) -> ()
    %13 = "memref.subview"(%arg0, %8, %11) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %14 = "memref.subview"(%12, %11) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<8xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%13, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %15 = "bufferization.to_tensor"(%12) <{restrict, writable}> : (memref<8xf32>) -> tensor<8xf32>
    %16 = "tt.scan"(%15) <{axis = 0 : i32, reverse = false}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %19 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "tt.scan.return"(%19) : (f32) -> ()
    }) : (tensor<8xf32>) -> tensor<8xf32>
    %17 = "tensor.extract_slice"(%16, %11) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<8xf32>, index) -> tensor<?xf32>
    %18 = "memref.subview"(%arg1, %8, %11) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%17, %18) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

