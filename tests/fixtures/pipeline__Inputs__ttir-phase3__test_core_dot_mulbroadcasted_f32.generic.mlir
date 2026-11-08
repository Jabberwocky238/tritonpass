#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 20480 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 6144 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 24576 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.constant"() <{value = 5 : index}> : () -> index
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    %8 = "tensor.empty"() : () -> tensor<128x32xf32>
    %9 = "linalg.fill"(%0, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: f32):
      "linalg.yield"(%arg12) : (f32) -> ()
    }) : (f32, tensor<128x32xf32>) -> tensor<128x32xf32>
    %10 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %11 = "arith.index_cast"(%10) : (index) -> i32
    %12 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %13 = "arith.index_cast"(%12) : (index) -> i32
    %14 = "arith.muli"(%13, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %15 = "arith.index_cast"(%14) : (i32) -> index
    %16 = "arith.muli"(%11, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %17 = "arith.index_cast"(%16) : (i32) -> index
    %18 = "scf.for"(%5, %6, %7, %9) ({
    ^bb0(%arg3: index, %arg4: tensor<128x32xf32>):
      %24 = "arith.index_cast"(%arg3) : (index) -> i32
      %25 = "arith.muli"(%24, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %26 = "arith.index_cast"(%25) : (i32) -> index
      %27 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 160, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[160, 1]>>
      %28 = "arith.addi"(%15, %26) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %29 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x32xf32>
      %30 = "memref.subview"(%27, %28) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 128, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[160, 1]>>, index) -> memref<128x32xf32, strided<[160, 1], offset: ?>>
      "linalg.copy"(%30, %29) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg10: f32, %arg11: f32):
        "linalg.yield"(%arg10) : (f32) -> ()
      }) : (memref<128x32xf32, strided<[160, 1], offset: ?>>, memref<128x32xf32>) -> ()
      %31 = "bufferization.to_tensor"(%29) <{restrict, writable}> : (memref<128x32xf32>) -> tensor<128x32xf32>
      %32 = "arith.muli"(%24, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %33 = "arith.index_cast"(%32) : (i32) -> index
      %34 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 192, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[192, 1]>>
      %35 = "arith.addi"(%17, %33) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %36 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      %37 = "memref.subview"(%34, %35) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[192, 1]>>, index) -> memref<32x32xf32, strided<[192, 1], offset: ?>>
      "linalg.copy"(%37, %36) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg8: f32, %arg9: f32):
        "linalg.yield"(%arg8) : (f32) -> ()
      }) : (memref<32x32xf32, strided<[192, 1], offset: ?>>, memref<32x32xf32>) -> ()
      %38 = "bufferization.to_tensor"(%36) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %39 = "linalg.matmul"(%31, %38, %arg4) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg5: f32, %arg6: f32, %arg7: f32):
        %40 = "arith.mulf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %41 = "arith.addf"(%arg7, %40) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%41) : (f32) -> ()
      }) : (tensor<128x32xf32>, tensor<32x32xf32>, tensor<128x32xf32>) -> tensor<128x32xf32>
      "scf.yield"(%39) : (tensor<128x32xf32>) -> ()
    }) : (index, index, index, tensor<128x32xf32>) -> tensor<128x32xf32>
    %19 = "arith.muli"(%13, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %20 = "arith.addi"(%19, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %21 = "arith.index_cast"(%20) : (i32) -> index
    %22 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 192, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[192, 1]>>
    %23 = "memref.subview"(%22, %21) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 128, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[192, 1]>>, index) -> memref<128x32xf32, strided<[192, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%18, %23) <{writable}> : (tensor<128x32xf32>, memref<128x32xf32, strided<[192, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

