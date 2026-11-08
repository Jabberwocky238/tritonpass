#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32) -> (), sym_name = "reduce_then_scan_block_sum_kernel_row"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32, %arg3: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 4096 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4096 : i32}> : () -> i32
    %3 = "tensor.empty"() : () -> tensor<4096xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32):
      "linalg.yield"(%arg19) : (f32) -> ()
    }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
    %5 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %6 = "arith.index_cast"(%5) : (index) -> i32
    %7 = "arith.extsi"(%6) : (i32) -> i64
    %8 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %9 = "arith.index_cast"(%8) : (index) -> i32
    %10 = "arith.extsi"(%9) : (i32) -> i64
    %11 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
    %12 = "arith.index_cast"(%11) : (index) -> i32
    %13 = "arith.muli"(%arg3, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %14 = "arith.extsi"(%13) : (i32) -> i64
    %15 = "arith.muli"(%7, %14) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %16 = "arith.addi"(%15, %14) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %17 = "arith.extsi"(%arg2) : (i32) -> i64
    %18 = "arith.minsi"(%16, %17) : (i64, i64) -> i64
    %19 = "arith.muli"(%10, %17) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %20 = "arith.index_cast"(%19) : (i64) -> index
    %21 = "arith.index_cast"(%15) : (i64) -> index
    %22 = "arith.index_cast"(%18) : (i64) -> index
    %23 = "scf.for"(%21, %22, %1, %4) ({
    ^bb0(%arg10: index, %arg11: tensor<4096xf32>):
      %36 = "arith.addi"(%arg10, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %37 = "arith.index_cast"(%arg2) : (i32) -> index
      %38 = "arith.minsi"(%36, %37) : (index, index) -> index
      %39 = "arith.maxsi"(%38, %arg10) : (index, index) -> index
      %40 = "arith.subi"(%39, %arg10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %41 = "arith.addi"(%20, %arg10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %42 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
      "linalg.fill"(%0, %42) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg17: f32, %arg18: f32):
        "linalg.yield"(%arg17) : (f32) -> ()
      }) : (f32, memref<4096xf32>) -> ()
      %43 = "memref.subview"(%arg0, %41, %40) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %44 = "memref.subview"(%42, %40) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%43, %44) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg15: f32, %arg16: f32):
        "linalg.yield"(%arg15) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %45 = "bufferization.to_tensor"(%42) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
      %46 = "linalg.generic"(%arg11, %45, %arg11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg12: f32, %arg13: f32, %arg14: f32):
        %47 = "arith.addf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%47) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      "scf.yield"(%46) : (tensor<4096xf32>) -> ()
    }) : (index, index, index, tensor<4096xf32>) -> tensor<4096xf32>
    %24 = "tensor.empty"() : () -> tensor<f32>
    %25 = "linalg.fill"(%0, %24) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %26 = "linalg.reduce"(%23, %25) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      %35 = "arith.addf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%35) : (f32) -> ()
    }) : (tensor<4096xf32>, tensor<f32>) -> tensor<f32>
    %27 = "tensor.extract"(%26) : (tensor<f32>) -> f32
    %28 = "arith.extsi"(%12) : (i32) -> i64
    %29 = "arith.muli"(%10, %28) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %30 = "arith.addi"(%29, %7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %31 = "arith.index_cast"(%30) : (i64) -> index
    %32 = "tensor.empty"() : () -> tensor<1xf32>
    %33 = "linalg.fill"(%27, %32) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %34 = "memref.subview"(%arg1, %31) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%33, %34) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

