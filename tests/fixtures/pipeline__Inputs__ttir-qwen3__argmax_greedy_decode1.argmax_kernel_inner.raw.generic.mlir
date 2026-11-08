#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xi64>, i32) -> (), sym_name = "argmax_kernel_inner"}> ({
  ^bb0(%arg14: memref<?xf32>, %arg15: memref<?xi64>, %arg16: i32):
    %17 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %18 = "arith.constant"() <{value = 4096 : i32}> : () -> i32
    %19 = "arith.constant"() <{value = 0 : index}> : () -> index
    %20 = "arith.constant"() <{value = 1 : index}> : () -> index
    %21 = "arith.constant"() <{value = 4096 : index}> : () -> index
    %22 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %23 = "func.call"() <{callee = @flag_gems.utils.triton_lang_extension.program_id__c0}> : () -> i64
    "func.call"() <{callee = @flag_gems.utils.limits.get_dtype_min__cfp32}> : () -> ()
    %24 = "arith.divsi"(%arg16, %18) : (i32, i32) -> i32
    %25 = "arith.remsi"(%arg16, %18) : (i32, i32) -> i32
    %26 = "arith.index_cast"(%24) : (i32) -> index
    %27:2 = "scf.for"(%19, %26, %20, %17, %22) ({
    ^bb0(%arg23: index, %arg24: f32, %arg25: i32):
      %54 = "arith.index_cast"(%arg23) : (index) -> i32
      %55 = "arith.muli"(%54, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %56 = "arith.index_cast"(%55) : (i32) -> index
      %57 = "arith.extsi"(%arg16) : (i32) -> i64
      %58 = "arith.muli"(%23, %57) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %59 = "arith.index_cast"(%58) : (i64) -> index
      %60 = "arith.addi"(%59, %56) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %61 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
      %62 = "memref.subview"(%arg14, %60) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4096>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<4096xf32, strided<[1], offset: ?>>
      "linalg.copy"(%62, %61) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg26: f32, %arg27: f32):
        "linalg.yield"(%arg26) : (f32) -> ()
      }) : (memref<4096xf32, strided<[1], offset: ?>>, memref<4096xf32>) -> ()
      %63 = "bufferization.to_tensor"(%61) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
      %64:2 = "func.call"(%63) <{callee = @triton.language.standard.max__fp32S4096S_c0_cTrue_cTrue_cFalse}> : (tensor<4096xf32>) -> (f32, i32)
      %65 = "arith.cmpf"(%64#0, %arg24) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      %66 = "arith.select"(%65, %64#0, %arg24) : (i1, f32, f32) -> f32
      %67 = "arith.addi"(%55, %64#1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %68 = "arith.select"(%65, %67, %arg25) : (i1, i32, i32) -> i32
      "scf.yield"(%66, %68) : (f32, i32) -> ()
    }) : (index, index, index, f32, i32) -> (f32, i32)
    %28 = "arith.cmpi"(%25, %22) <{predicate = 1 : i64}> : (i32, i32) -> i1
    %29 = "scf.if"(%28) ({
      %35 = "arith.muli"(%24, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %36 = "arith.index_cast"(%35) : (i32) -> index
      %37 = "arith.extsi"(%arg16) : (i32) -> i64
      %38 = "arith.muli"(%23, %37) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %39 = "arith.index_cast"(%38) : (i64) -> index
      %40 = "arith.addi"(%36, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %41 = "arith.index_cast"(%arg16) : (i32) -> index
      %42 = "arith.minsi"(%40, %41) : (index, index) -> index
      %43 = "arith.maxsi"(%42, %36) : (index, index) -> index
      %44 = "arith.subi"(%43, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %45 = "arith.addi"(%39, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %46 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
      "linalg.fill"(%17, %46) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg21: f32, %arg22: f32):
        "linalg.yield"(%arg21) : (f32) -> ()
      }) : (f32, memref<4096xf32>) -> ()
      %47 = "memref.subview"(%arg14, %45, %44) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %48 = "memref.subview"(%46, %44) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%47, %48) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg19: f32, %arg20: f32):
        "linalg.yield"(%arg19) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %49 = "bufferization.to_tensor"(%46) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
      %50:2 = "func.call"(%49) <{callee = @triton.language.standard.max__fp32S4096S_c0_cTrue_cTrue_cFalse}> : (tensor<4096xf32>) -> (f32, i32)
      %51 = "arith.cmpf"(%50#0, %27#0) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      %52 = "arith.addi"(%35, %50#1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %53 = "arith.select"(%51, %52, %27#1) : (i1, i32, i32) -> i32
      "scf.yield"(%53) : (i32) -> ()
    }, {
      "scf.yield"(%27#1) : (i32) -> ()
    }) : (i1) -> i32
    %30 = "arith.extsi"(%29) : (i32) -> i64
    %31 = "arith.index_cast"(%23) : (i64) -> index
    %32 = "tensor.empty"() : () -> tensor<1xi64>
    %33 = "linalg.fill"(%30, %32) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: i64, %arg18: i64):
      "linalg.yield"(%arg17) : (i64) -> ()
    }) : (i64, tensor<1xi64>) -> tensor<1xi64>
    %34 = "memref.subview"(%arg15, %31) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi64>, index) -> memref<1xi64, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%33, %34) <{writable}> : (tensor<1xi64>, memref<1xi64, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "flag_gems.utils.triton_lang_extension.program_id__c0", sym_visibility = "private"}> ({
    %14 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %15 = "arith.index_cast"(%14) : (index) -> i32
    %16 = "arith.extsi"(%15) : (i32) -> i64
    "func.return"(%16) : (i64) -> ()
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

