#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32, i32, i32) -> (), sym_name = "softmax_kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %5 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
    %6 = "arith.index_cast"(%arg4) : (i32) -> index
    "scf.for"(%4, %6, %5) ({
    ^bb0(%arg6: index):
      %7 = "arith.index_cast"(%arg6) : (index) -> i32
      %8 = "arith.muli"(%7, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %9 = "arith.index_cast"(%8) : (i32) -> index
      %10 = "arith.index_cast"(%arg5) : (i32) -> index
      %11 = "arith.minsi"(%10, %0) : (index, index) -> index
      %12 = "arith.maxsi"(%11, %1) : (index, index) -> index
      %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
      "linalg.fill"(%2, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg29: f32, %arg30: f32):
        "linalg.yield"(%arg29) : (f32) -> ()
      }) : (f32, memref<1024xf32>) -> ()
      %14 = "memref.subview"(%arg1, %9, %12) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %15 = "memref.subview"(%13, %12) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%14, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg27: f32, %arg28: f32):
        "linalg.yield"(%arg27) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %16 = "bufferization.to_tensor"(%13) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
      %17 = "tensor.empty"() : () -> tensor<f32>
      %18 = "linalg.fill"(%2, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg25: f32, %arg26: f32):
        "linalg.yield"(%arg25) : (f32) -> ()
      }) : (f32, tensor<f32>) -> tensor<f32>
      %19 = "linalg.reduce"(%16, %18) <{dimensions = array<i64: 0>}> ({
      ^bb0(%arg23: f32, %arg24: f32):
        %38 = "arith.maxnumf"(%arg23, %arg24) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%38) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<f32>) -> tensor<f32>
      %20 = "tensor.extract"(%19) : (tensor<f32>) -> f32
      %21 = "tensor.empty"() : () -> tensor<1024xf32>
      %22 = "linalg.fill"(%20, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg21: f32, %arg22: f32):
        "linalg.yield"(%arg21) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %23 = "linalg.generic"(%16, %22, %16) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg18: f32, %arg19: f32, %arg20: f32):
        %37 = "arith.subf"(%arg18, %arg19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%37) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %24 = "linalg.generic"(%23, %23) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg16: f32, %arg17: f32):
        %36 = "math.exp"(%arg16) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%36) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %25 = "linalg.fill"(%3, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg14: f32, %arg15: f32):
        "linalg.yield"(%arg14) : (f32) -> ()
      }) : (f32, tensor<f32>) -> tensor<f32>
      %26 = "linalg.reduce"(%24, %25) <{dimensions = array<i64: 0>}> ({
      ^bb0(%arg12: f32, %arg13: f32):
        %35 = "arith.addf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%35) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<f32>) -> tensor<f32>
      %27 = "tensor.extract"(%26) : (tensor<f32>) -> f32
      %28 = "linalg.fill"(%27, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg10: f32, %arg11: f32):
        "linalg.yield"(%arg10) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %29 = "linalg.generic"(%24, %28, %24) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg7: f32, %arg8: f32, %arg9: f32):
        %34 = "arith.divf"(%arg7, %arg8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%34) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %30 = "arith.muli"(%7, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %31 = "arith.index_cast"(%30) : (i32) -> index
      %32 = "tensor.extract_slice"(%29, %12) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xf32>, index) -> tensor<?xf32>
      %33 = "memref.subview"(%arg0, %31, %12) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%32, %33) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

