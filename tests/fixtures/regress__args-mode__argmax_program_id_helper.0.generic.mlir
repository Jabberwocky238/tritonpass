#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xi64>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "argmax_kernel_inner"}> ({
  ^bb0(%arg15: memref<?xf32>, %arg16: memref<?xi64>, %arg17: i32, %arg18: i32, %arg19: i32, %arg20: i32, %arg21: i32, %arg22: i32, %arg23: i32):
    %15 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %16 = "arith.constant"() <{value = 4096 : i32}> : () -> i32
    %17 = "arith.constant"() <{value = 0 : index}> : () -> index
    %18 = "arith.constant"() <{value = 1 : index}> : () -> index
    %19 = "arith.constant"() <{value = 4096 : index}> : () -> index
    %20 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %21 = "func.call"(%arg21) <{callee = @flag_gems.utils.triton_lang_extension.program_id__c0}> : (i32) -> i64
    "func.call"() <{callee = @flag_gems.utils.limits.get_dtype_min__cfp32}> : () -> ()
    %22 = "arith.divsi"(%arg17, %16) : (i32, i32) -> i32
    %23 = "arith.remsi"(%arg17, %16) : (i32, i32) -> i32
    %24 = "arith.index_cast"(%22) : (i32) -> index
    %25:2 = "scf.for"(%17, %24, %18, %15, %20) ({
    ^bb0(%arg30: index, %arg31: f32, %arg32: i32):
      %52 = "arith.index_cast"(%arg30) : (index) -> i32
      %53 = "arith.muli"(%52, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %54 = "arith.index_cast"(%53) : (i32) -> index
      %55 = "arith.extsi"(%arg17) : (i32) -> i64
      %56 = "arith.muli"(%21, %55) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %57 = "arith.index_cast"(%56) : (i64) -> index
      %58 = "arith.addi"(%57, %54) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %59 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
      %60 = "memref.subview"(%arg15, %58) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4096>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<4096xf32, strided<[1], offset: ?>>
      "linalg.copy"(%60, %59) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg33: f32, %arg34: f32):
        "linalg.yield"(%arg33) : (f32) -> ()
      }) : (memref<4096xf32, strided<[1], offset: ?>>, memref<4096xf32>) -> ()
      %61 = "bufferization.to_tensor"(%59) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
      %62:2 = "func.call"(%61) <{callee = @triton.language.standard.max__fp32S4096S_c0_cTrue_cTrue_cFalse}> : (tensor<4096xf32>) -> (f32, i32)
      %63 = "arith.cmpf"(%62#0, %arg31) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      %64 = "arith.select"(%63, %62#0, %arg31) : (i1, f32, f32) -> f32
      %65 = "arith.addi"(%53, %62#1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %66 = "arith.select"(%63, %65, %arg32) : (i1, i32, i32) -> i32
      "scf.yield"(%64, %66) : (f32, i32) -> ()
    }) : (index, index, index, f32, i32) -> (f32, i32)
    %26 = "arith.cmpi"(%23, %20) <{predicate = 1 : i64}> : (i32, i32) -> i1
    %27 = "scf.if"(%26) ({
      %33 = "arith.muli"(%22, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %34 = "arith.index_cast"(%33) : (i32) -> index
      %35 = "arith.extsi"(%arg17) : (i32) -> i64
      %36 = "arith.muli"(%21, %35) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %37 = "arith.index_cast"(%36) : (i64) -> index
      %38 = "arith.addi"(%34, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %39 = "arith.index_cast"(%arg17) : (i32) -> index
      %40 = "arith.minsi"(%38, %39) : (index, index) -> index
      %41 = "arith.maxsi"(%40, %34) : (index, index) -> index
      %42 = "arith.subi"(%41, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %43 = "arith.addi"(%37, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %44 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
      "linalg.fill"(%15, %44) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg28: f32, %arg29: f32):
        "linalg.yield"(%arg28) : (f32) -> ()
      }) : (f32, memref<4096xf32>) -> ()
      %45 = "memref.subview"(%arg15, %43, %42) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %46 = "memref.subview"(%44, %42) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%45, %46) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg26: f32, %arg27: f32):
        "linalg.yield"(%arg26) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %47 = "bufferization.to_tensor"(%44) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
      %48:2 = "func.call"(%47) <{callee = @triton.language.standard.max__fp32S4096S_c0_cTrue_cTrue_cFalse}> : (tensor<4096xf32>) -> (f32, i32)
      %49 = "arith.cmpf"(%48#0, %25#0) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      %50 = "arith.addi"(%33, %48#1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %51 = "arith.select"(%49, %50, %25#1) : (i1, i32, i32) -> i32
      "scf.yield"(%51) : (i32) -> ()
    }, {
      "scf.yield"(%25#1) : (i32) -> ()
    }) : (i1) -> i32
    %28 = "arith.extsi"(%27) : (i32) -> i64
    %29 = "arith.index_cast"(%21) : (i64) -> index
    %30 = "tensor.empty"() : () -> tensor<1xi64>
    %31 = "linalg.fill"(%28, %30) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: i64, %arg25: i64):
      "linalg.yield"(%arg24) : (i64) -> ()
    }) : (i64, tensor<1xi64>) -> tensor<1xi64>
    %32 = "memref.subview"(%arg16, %29) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi64>, index) -> memref<1xi64, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%31, %32) <{writable}> : (tensor<1xi64>, memref<1xi64, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i64, sym_name = "flag_gems.utils.triton_lang_extension.program_id__c0", sym_visibility = "private"}> ({
  ^bb0(%arg14: i32):
    %14 = "arith.extsi"(%arg14) : (i32) -> i64
    "func.return"(%14) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "flag_gems.utils.limits.get_dtype_min__cfp32", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4096xf32>) -> (f32, i32), sym_name = "triton.language.standard.max__fp32S4096S_c0_cTrue_cTrue_cFalse", sym_visibility = "private"}> ({
  ^bb0(%arg8: tensor<4096xf32>):
    %8 = "tensor.empty"() : () -> tensor<4096xi32>
    %9 = "linalg.generic"(%8) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg13: i32):
      %12 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %13 = "arith.index_cast"(%12) : (index) -> i32
      "linalg.yield"(%13) : (i32) -> ()
    }) : (tensor<4096xi32>) -> tensor<4096xi32>
    %10:2 = "tt.reduce"(%arg8, %9) <{axis = 0 : i32}> ({
    ^bb0(%arg9: f32, %arg10: i32, %arg11: f32, %arg12: i32):
      %11:2 = "func.call"(%arg9, %arg10, %arg11, %arg12) <{callee = @triton.language.standard._argmax_combine_tie_break_left__fp32_i32_fp32_i32}> : (f32, i32, f32, i32) -> (f32, i32)
      "tt.reduce.return"(%11#0, %11#1) : (f32, i32) -> ()
    }) : (tensor<4096xf32>, tensor<4096xi32>) -> (f32, i32)
    "func.return"(%10#0, %10#1) : (f32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32, f32, i32) -> (f32, i32), sym_name = "triton.language.standard._argmax_combine_tie_break_left__fp32_i32_fp32_i32", sym_visibility = "private"}> ({
  ^bb0(%arg4: f32, %arg5: i32, %arg6: f32, %arg7: i32):
    %7:2 = "func.call"(%arg4, %arg5, %arg6, %arg7) <{callee = @triton.language.standard._argmax_combine__fp32_i32_fp32_i32_cTrue}> : (f32, i32, f32, i32) -> (f32, i32)
    "func.return"(%7#0, %7#1) : (f32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32, f32, i32) -> (f32, i32), sym_name = "triton.language.standard._argmax_combine__fp32_i32_fp32_i32_cTrue", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32, %arg1: i32, %arg2: f32, %arg3: i32):
    %0 = "arith.cmpf"(%arg0, %arg2) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %1 = "arith.cmpi"(%arg1, %arg3) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %2 = "arith.andi"(%0, %1) : (i1, i1) -> i1
    %3 = "arith.cmpf"(%arg0, %arg2) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
    %4 = "arith.ori"(%3, %2) : (i1, i1) -> i1
    %5 = "arith.select"(%4, %arg0, %arg2) : (i1, f32, f32) -> f32
    %6 = "arith.select"(%4, %arg1, %arg3) : (i1, i32, i32) -> i32
    "func.return"(%5, %6) : (f32, i32) -> ()
  }) : () -> ()
}) : () -> ()

