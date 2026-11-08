#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32) -> (), sym_name = "reduce_then_scan_block_scan_kernel_row"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 4096 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %3 = "arith.constant"() <{value = 4096 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %5 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<?xf32>) -> !tt.ptr<f32>
    %6 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %7 = "arith.index_cast"(%6) : (index) -> i32
    %8 = "arith.extsi"(%7) : (i32) -> i64
    %9 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %10 = "arith.index_cast"(%9) : (index) -> i32
    %11 = "arith.extsi"(%10) : (i32) -> i64
    %12 = "arith.muli"(%arg5, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %13 = "arith.extsi"(%12) : (i32) -> i64
    %14 = "arith.muli"(%11, %13) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %15 = "arith.addi"(%14, %13) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %16 = "arith.extsi"(%arg3) : (i32) -> i64
    %17 = "arith.minsi"(%15, %16) : (i64, i64) -> i64
    %18 = "arith.cmpi"(%11, %2) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %19 = "arith.extsi"(%arg4) : (i32) -> i64
    %20 = "arith.muli"(%8, %19) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %21 = "arith.addi"(%20, %11) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %22 = "arith.addi"(%21, %4) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %23 = "tts.gather"(%5, %22, %18, %0) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (!tt.ptr<f32>, i64, i1, f32) -> f32
    %24 = "arith.muli"(%8, %16) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %25 = "arith.index_cast"(%24) : (i64) -> index
    %26 = "arith.index_cast"(%14) : (i64) -> index
    %27 = "arith.index_cast"(%17) : (i64) -> index
    %28 = "scf.for"(%26, %27, %1, %23) ({
    ^bb0(%arg6: index, %arg7: f32):
      %29 = "arith.addi"(%arg6, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %30 = "arith.index_cast"(%arg3) : (i32) -> index
      %31 = "arith.minsi"(%29, %30) : (index, index) -> index
      %32 = "arith.maxsi"(%31, %arg6) : (index, index) -> index
      %33 = "arith.subi"(%32, %arg6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %34 = "arith.addi"(%25, %arg6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %35 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
      "linalg.fill"(%0, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg21: f32, %arg22: f32):
        "linalg.yield"(%arg21) : (f32) -> ()
      }) : (f32, memref<4096xf32>) -> ()
      %36 = "memref.subview"(%arg0, %34, %33) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %37 = "memref.subview"(%35, %33) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%36, %37) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg19: f32, %arg20: f32):
        "linalg.yield"(%arg19) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %38 = "bufferization.to_tensor"(%35) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
      %39 = "tt.scan"(%38) <{axis = 0 : i32, reverse = false}> ({
      ^bb0(%arg17: f32, %arg18: f32):
        %52 = "arith.addf"(%arg17, %arg18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "tt.scan.return"(%52) : (f32) -> ()
      }) : (tensor<4096xf32>) -> tensor<4096xf32>
      %40 = "tensor.empty"() : () -> tensor<4096xf32>
      %41 = "linalg.fill"(%arg7, %40) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg15: f32, %arg16: f32):
        "linalg.yield"(%arg15) : (f32) -> ()
      }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
      %42 = "linalg.generic"(%41, %39, %41) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg12: f32, %arg13: f32, %arg14: f32):
        %51 = "arith.addf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%51) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %43 = "tensor.empty"() : () -> tensor<f32>
      %44 = "linalg.fill"(%0, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg10: f32, %arg11: f32):
        "linalg.yield"(%arg10) : (f32) -> ()
      }) : (f32, tensor<f32>) -> tensor<f32>
      %45 = "linalg.reduce"(%38, %44) <{dimensions = array<i64: 0>}> ({
      ^bb0(%arg8: f32, %arg9: f32):
        %50 = "arith.addf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%50) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<f32>) -> tensor<f32>
      %46 = "tensor.extract"(%45) : (tensor<f32>) -> f32
      %47 = "arith.addf"(%arg7, %46) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %48 = "tensor.extract_slice"(%42, %33) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<4096xf32>, index) -> tensor<?xf32>
      %49 = "memref.subview"(%arg2, %34, %33) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%48, %49) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
      "scf.yield"(%47) : (f32) -> ()
    }) : (index, index, index, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

