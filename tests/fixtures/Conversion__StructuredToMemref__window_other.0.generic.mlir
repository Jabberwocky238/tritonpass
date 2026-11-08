"builtin.module"() ({
  "tt.func"() <{function_type = (memref<?xf32>, index, index) -> tensor<128xf32>, sym_name = "other_nonzero"}> ({
  ^bb0(%arg32: memref<?xf32>, %arg33: index, %arg34: index):
    %23 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %24 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32>
    "linalg.fill"(%23, %24) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg37: f32, %arg38: f32):
      "linalg.yield"(%arg37) : (f32) -> ()
    }) : (f32, memref<128xf32>) -> ()
    %25 = "memref.subview"(%arg32, %arg33, %arg34) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %26 = "memref.subview"(%24, %arg34) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<128xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%25, %26) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg35: f32, %arg36: f32):
      "linalg.yield"(%arg35) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %27 = "bufferization.to_tensor"(%24) <{restrict, writable}> : (memref<128xf32>) -> tensor<128xf32>
    "tt.return"(%27) : (tensor<128xf32>) -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (memref<?xf32>, index, index) -> tensor<128xf32>, sym_name = "other_zero"}> ({
  ^bb0(%arg25: memref<?xf32>, %arg26: index, %arg27: index):
    %18 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %19 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32>
    "linalg.fill"(%18, %19) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: f32, %arg31: f32):
      "linalg.yield"(%arg30) : (f32) -> ()
    }) : (f32, memref<128xf32>) -> ()
    %20 = "memref.subview"(%arg25, %arg26, %arg27) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %21 = "memref.subview"(%19, %arg27) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<128xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%20, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg28: f32, %arg29: f32):
      "linalg.yield"(%arg28) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %22 = "bufferization.to_tensor"(%19) <{restrict, writable}> : (memref<128xf32>) -> tensor<128xf32>
    "tt.return"(%22) : (tensor<128xf32>) -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (memref<?xf32>, index, index) -> tensor<128xf32>, sym_name = "other_negative_zero"}> ({
  ^bb0(%arg18: memref<?xf32>, %arg19: index, %arg20: index):
    %13 = "arith.constant"() <{value = -0.000000e+00 : f32}> : () -> f32
    %14 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32>
    "linalg.fill"(%13, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: f32, %arg24: f32):
      "linalg.yield"(%arg23) : (f32) -> ()
    }) : (f32, memref<128xf32>) -> ()
    %15 = "memref.subview"(%arg18, %arg19, %arg20) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %16 = "memref.subview"(%14, %arg20) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<128xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%15, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: f32, %arg22: f32):
      "linalg.yield"(%arg21) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %17 = "bufferization.to_tensor"(%14) <{restrict, writable}> : (memref<128xf32>) -> tensor<128xf32>
    "tt.return"(%17) : (tensor<128xf32>) -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (memref<?xf32>, index, index) -> tensor<128xf32>, sym_name = "other_none"}> ({
  ^bb0(%arg11: memref<?xf32>, %arg12: index, %arg13: index):
    %8 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %9 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32>
    "linalg.fill"(%8, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: f32, %arg17: f32):
      "linalg.yield"(%arg16) : (f32) -> ()
    }) : (f32, memref<128xf32>) -> ()
    %10 = "memref.subview"(%arg11, %arg12, %arg13) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %11 = "memref.subview"(%9, %arg13) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<128xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%10, %11) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      "linalg.yield"(%arg14) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %12 = "bufferization.to_tensor"(%9) <{restrict, writable}> : (memref<128xf32>) -> tensor<128xf32>
    "tt.return"(%12) : (tensor<128xf32>) -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (memref<?xbf16>, index, index) -> tensor<128xbf16>, sym_name = "other_none_bf16"}> ({
  ^bb0(%arg4: memref<?xbf16>, %arg5: index, %arg6: index):
    %3 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %4 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xbf16>
    "linalg.fill"(%3, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: bf16, %arg10: bf16):
      "linalg.yield"(%arg9) : (bf16) -> ()
    }) : (bf16, memref<128xbf16>) -> ()
    %5 = "memref.subview"(%arg4, %arg5, %arg6) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index, index) -> memref<?xbf16, strided<[1], offset: ?>>
    %6 = "memref.subview"(%4, %arg6) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<128xbf16>, index) -> memref<?xbf16, strided<[1]>>
    "linalg.copy"(%5, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: bf16, %arg8: bf16):
      "linalg.yield"(%arg7) : (bf16) -> ()
    }) : (memref<?xbf16, strided<[1], offset: ?>>, memref<?xbf16, strided<[1]>>) -> ()
    %7 = "bufferization.to_tensor"(%4) <{restrict, writable}> : (memref<128xbf16>) -> tensor<128xbf16>
    "tt.return"(%7) : (tensor<128xbf16>) -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (memref<?xf32>, index) -> tensor<128xf32>, sym_name = "unmasked"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: index):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32>
    %1 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<128xf32, strided<[1], offset: ?>>
    "linalg.copy"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (memref<128xf32, strided<[1], offset: ?>>, memref<128xf32>) -> ()
    %2 = "bufferization.to_tensor"(%0) <{restrict, writable}> : (memref<128xf32>) -> tensor<128xf32>
    "tt.return"(%2) : (tensor<128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

