#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, i32, memref<?xbf16>, i32, memref<?xbf16>, i32, memref<?xf32>, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: memref<?xbf16>, %arg1: i32, %arg2: memref<?xbf16>, %arg3: i32, %arg4: memref<?xbf16>, %arg5: i32, %arg6: memref<?xf32>, %arg7: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.index_cast"(%arg1) : (i32) -> index
    %2 = "memref.reinterpret_cast"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xbf16>, index) -> memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>
    %3 = "arith.index_cast"(%arg3) : (i32) -> index
    %4 = "memref.reinterpret_cast"(%arg2, %3) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xbf16>, index) -> memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>
    %5 = "arith.index_cast"(%arg7) : (i32) -> index
    %6 = "memref.reinterpret_cast"(%arg6, %5) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %7 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xbf16>
    %8 = "memref.subview"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>) -> memref<64x64xbf16, strided<[?, 1]>>
    "linalg.copy"(%8, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: bf16, %arg16: bf16):
      "linalg.yield"(%arg15) : (bf16) -> ()
    }) : (memref<64x64xbf16, strided<[?, 1]>>, memref<64x64xbf16>) -> ()
    %9 = "bufferization.to_tensor"(%7) <{restrict, writable}> : (memref<64x64xbf16>) -> tensor<64x64xbf16>
    %10 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x64xbf16>
    %11 = "memref.subview"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>) -> memref<64x64xbf16, strided<[?, 1]>>
    "linalg.copy"(%11, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: bf16, %arg14: bf16):
      "linalg.yield"(%arg13) : (bf16) -> ()
    }) : (memref<64x64xbf16, strided<[?, 1]>>, memref<64x64xbf16>) -> ()
    %12 = "bufferization.to_tensor"(%10) <{restrict, writable}> : (memref<64x64xbf16>) -> tensor<64x64xbf16>
    %13 = "tensor.empty"() : () -> tensor<64x64xf32>
    %14 = "linalg.fill"(%0, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      "linalg.yield"(%arg11) : (f32) -> ()
    }) : (f32, tensor<64x64xf32>) -> tensor<64x64xf32>
    %15 = "linalg.matmul"(%9, %12, %14) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg8: bf16, %arg9: bf16, %arg10: f32):
      %17 = "arith.extf"(%arg8) : (bf16) -> f32
      %18 = "arith.extf"(%arg9) : (bf16) -> f32
      %19 = "arith.mulf"(%17, %18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %20 = "arith.addf"(%arg10, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%20) : (f32) -> ()
    }) : (tensor<64x64xbf16>, tensor<64x64xbf16>, tensor<64x64xf32>) -> tensor<64x64xf32>
    %16 = "memref.subview"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 64, 64>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>) -> memref<64x64xf32, strided<[?, 1]>>
    "bufferization.materialize_in_destination"(%15, %16) <{writable}> : (tensor<64x64xf32>, memref<64x64xf32, strided<[?, 1]>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

