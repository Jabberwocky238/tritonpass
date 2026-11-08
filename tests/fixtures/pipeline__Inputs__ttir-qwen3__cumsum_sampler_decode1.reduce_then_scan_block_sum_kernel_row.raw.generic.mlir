#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32) -> (), sym_name = "reduce_then_scan_block_sum_kernel_row"}> ({
  ^bb0(%arg7: memref<?xf32>, %arg8: memref<?xf32>, %arg9: i32, %arg10: i32):
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 4096 : i32}> : () -> i32
    %8 = "arith.constant"() <{value = 4096 : index}> : () -> index
    %9 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %10 = "arith.index_cast"(%9) : (index) -> i32
    %11 = "arith.extsi"(%10) : (i32) -> i64
    %12 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %13 = "arith.index_cast"(%12) : (index) -> i32
    %14 = "arith.extsi"(%13) : (i32) -> i64
    %15 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
    %16 = "arith.index_cast"(%15) : (index) -> i32
    %17 = "arith.muli"(%arg10, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %18 = "arith.extsi"(%17) : (i32) -> i64
    %19 = "arith.muli"(%11, %18) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %20 = "arith.addi"(%19, %18) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %21 = "arith.extsi"(%arg9) : (i32) -> i64
    %22 = "arith.minsi"(%20, %21) : (i64, i64) -> i64
    %23 = "func.call"() <{callee = @triton.language.standard.zeros__Tc4096T_cfp32}> : () -> tensor<4096xf32>
    %24 = "arith.index_cast"(%19) : (i64) -> index
    %25 = "arith.index_cast"(%22) : (i64) -> index
    %26 = "scf.for"(%24, %25, %8, %23) ({
    ^bb0(%arg13: index, %arg14: tensor<4096xf32>):
      %35 = "arith.muli"(%14, %21) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %36 = "arith.index_cast"(%35) : (i64) -> index
      %37 = "arith.addi"(%arg13, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %38 = "arith.index_cast"(%arg9) : (i32) -> index
      %39 = "arith.minsi"(%37, %38) : (index, index) -> index
      %40 = "arith.maxsi"(%39, %arg13) : (index, index) -> index
      %41 = "arith.subi"(%40, %arg13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %42 = "arith.addi"(%36, %arg13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %43 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
      "linalg.fill"(%6, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg20: f32, %arg21: f32):
        "linalg.yield"(%arg20) : (f32) -> ()
      }) : (f32, memref<4096xf32>) -> ()
      %44 = "memref.subview"(%arg7, %42, %41) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %45 = "memref.subview"(%43, %41) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%44, %45) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg18: f32, %arg19: f32):
        "linalg.yield"(%arg18) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %46 = "bufferization.to_tensor"(%43) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
      %47 = "linalg.generic"(%arg14, %46, %arg14) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg15: f32, %arg16: f32, %arg17: f32):
        %48 = "arith.addf"(%arg15, %arg16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%48) : (f32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xf32>, tensor<4096xf32>) -> tensor<4096xf32>
      "scf.yield"(%47) : (tensor<4096xf32>) -> ()
    }) : (index, index, index, tensor<4096xf32>) -> tensor<4096xf32>
    %27 = "func.call"(%26) <{callee = @triton.language.standard.sum__fp32S4096S_c0_cFalse_cNone}> : (tensor<4096xf32>) -> f32
    %28 = "arith.extsi"(%16) : (i32) -> i64
    %29 = "arith.muli"(%14, %28) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %30 = "arith.index_cast"(%29) : (i64) -> index
    %31 = "tensor.empty"() : () -> tensor<1xf32>
    %32 = "linalg.fill"(%27, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      "linalg.yield"(%arg11) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %33 = "arith.addi"(%30, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %34 = "memref.subview"(%arg8, %33) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%32, %34) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<4096xf32>, sym_name = "triton.language.standard.zeros__Tc4096T_cfp32", sym_visibility = "private"}> ({
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "tensor.empty"() : () -> tensor<4096xf32>
    %5 = "linalg.fill"(%3, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<4096xf32>) -> tensor<4096xf32>
    "func.return"(%5) : (tensor<4096xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4096xf32>) -> f32, sym_name = "triton.language.standard.sum__fp32S4096S_c0_cFalse_cNone", sym_visibility = "private"}> ({
  ^bb0(%arg2: tensor<4096xf32>):
    %1 = "tt.reduce"(%arg2) <{axis = 0 : i32}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "func.call"(%arg3, %arg4) <{callee = @triton.language.standard._sum_combine__fp32_fp32}> : (f32, f32) -> f32
      "tt.reduce.return"(%2) : (f32) -> ()
    }) : (tensor<4096xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "triton.language.standard._sum_combine__fp32_fp32", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

