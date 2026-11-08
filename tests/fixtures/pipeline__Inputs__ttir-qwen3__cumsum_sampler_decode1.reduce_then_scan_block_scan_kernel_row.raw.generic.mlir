#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32) -> (), sym_name = "reduce_then_scan_block_scan_kernel_row"}> ({
  ^bb0(%arg8: memref<?xf32>, %arg9: memref<?xf32>, %arg10: memref<?xf32>, %arg11: i32, %arg12: i32, %arg13: i32):
    %5 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %6 = "arith.constant"() <{value = 4096 : index}> : () -> index
    %7 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %8 = "arith.constant"() <{value = 4096 : i32}> : () -> i32
    %9 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %10 = "builtin.unrealized_conversion_cast"(%arg9) : (memref<?xf32>) -> !tt.ptr<f32>
    %11 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %12 = "arith.index_cast"(%11) : (index) -> i32
    %13 = "arith.extsi"(%12) : (i32) -> i64
    %14 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %15 = "arith.index_cast"(%14) : (index) -> i32
    %16 = "arith.extsi"(%15) : (i32) -> i64
    %17 = "arith.muli"(%arg13, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %18 = "arith.extsi"(%17) : (i32) -> i64
    %19 = "arith.muli"(%16, %18) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %20 = "arith.addi"(%19, %18) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %21 = "arith.extsi"(%arg11) : (i32) -> i64
    %22 = "arith.minsi"(%20, %21) : (i64, i64) -> i64
    %23 = "arith.cmpi"(%16, %7) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %24 = "arith.extsi"(%arg12) : (i32) -> i64
    %25 = "arith.muli"(%13, %24) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %26 = "arith.addi"(%25, %16) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %27 = "arith.addi"(%26, %9) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %28 = "tts.gather"(%10, %27, %23, %5) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (!tt.ptr<f32>, i64, i1, f32) -> f32
    %29 = "arith.index_cast"(%19) : (i64) -> index
    %30 = "arith.index_cast"(%22) : (i64) -> index
    %31 = "scf.for"(%29, %30, %6, %28) ({
    ^bb0(%arg14: index, %arg15: f32):
      %32 = "arith.muli"(%13, %21) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %33 = "arith.index_cast"(%32) : (i64) -> index
      %34 = "arith.addi"(%arg14, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %35 = "arith.index_cast"(%arg11) : (i32) -> index
      %36 = "arith.minsi"(%34, %35) : (index, index) -> index
      %37 = "arith.maxsi"(%36, %arg14) : (index, index) -> index
      %38 = "arith.subi"(%37, %arg14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %39 = "arith.addi"(%33, %arg14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
      "linalg.fill"(%5, %40) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg23: f32, %arg24: f32):
        "linalg.yield"(%arg23) : (f32) -> ()
      }) : (f32, memref<4096xf32>) -> ()
      %41 = "memref.subview"(%arg8, %39, %38) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %42 = "memref.subview"(%40, %38) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%41, %42) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg21: f32, %arg22: f32):
        "linalg.yield"(%arg21) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %43 = "bufferization.to_tensor"(%40) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
      %44 = "func.call"(%43) <{callee = @triton.language.standard.cumsum__fp32S4096S_c0_cFalse_cNone}> : (tensor<4096xf32>) -> tensor<4096xf32>
      %45 = "tensor.empty"() : () -> tensor<4096xf32>
      %46 = "linalg.fill"(%arg15, %45) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg19: f32, %arg20: f32):
        "linalg.yield"(%arg19) : (f32) -> ()
      }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
      %47 = "linalg.generic"(%46, %44, %46) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg16: f32, %arg17: f32, %arg18: f32):
        %52 = "arith.addf"(%arg16, %arg17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%52) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      %48 = "func.call"(%43) <{callee = @triton.language.standard.sum__fp32S4096S_c0_cFalse_cNone}> : (tensor<4096xf32>) -> f32
      %49 = "arith.addf"(%arg15, %48) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %50 = "tensor.extract_slice"(%47, %38) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<4096xf32>, index) -> tensor<?xf32>
      %51 = "memref.subview"(%arg10, %39, %38) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%50, %51) <{writable}> : (tensor<?xf32>, memref<?xf32, strided<[1], offset: ?>>) -> ()
      "scf.yield"(%49) : (f32) -> ()
    }) : (index, index, index, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4096xf32>) -> tensor<4096xf32>, sym_name = "triton.language.standard.cumsum__fp32S4096S_c0_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg5: tensor<4096xf32>):
    %3 = "tt.scan"(%arg5) <{axis = 0 : i32, reverse = false}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      %4 = "func.call"(%arg6, %arg7) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.scan.return"(%4) : (f32) -> ()
    }) : (tensor<4096xf32>) -> tensor<4096xf32>
    "func.return"(%3) : (tensor<4096xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg3: f32, %arg4: f32):
    %2 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4096xf32>) -> f32, sym_name = "triton.language.standard.sum__fp32S4096S_c0_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<4096xf32>):
    %0 = "tt.reduce"(%arg0) <{axis = 0 : i32}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %1 = "func.call"(%arg1, %arg2) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%1) : (f32) -> ()
    }) : (tensor<4096xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

