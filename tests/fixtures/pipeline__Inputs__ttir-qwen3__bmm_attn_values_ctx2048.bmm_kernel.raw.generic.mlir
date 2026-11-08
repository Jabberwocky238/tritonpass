#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "bmm_kernel"}> ({
  ^bb0(%arg3: memref<?xf32>, %arg4: memref<?xf32>, %arg5: memref<?xf32>, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32):
    %16 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %17 = "arith.constant"() <{value = 0 : index}> : () -> index
    %18 = "arith.constant"() <{value = 1 : index}> : () -> index
    %19 = "arith.constant"() <{value = 32 : index}> : () -> index
    %20 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %21 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %22 = "func.call"() <{callee = @flag_gems.utils.triton_lang_extension.program_id__c2}> : () -> i64
    %23 = "arith.extsi"(%arg9) : (i32) -> i64
    %24 = "arith.muli"(%22, %23) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %25 = "arith.index_cast"(%24) : (i64) -> index
    %26 = "arith.extsi"(%arg11) : (i32) -> i64
    %27 = "arith.muli"(%22, %26) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %28 = "arith.index_cast"(%27) : (i64) -> index
    %29 = "arith.extsi"(%arg13) : (i32) -> i64
    %30 = "arith.muli"(%22, %29) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %31 = "arith.index_cast"(%30) : (i64) -> index
    %32 = "func.call"() <{callee = @flag_gems.utils.triton_lang_extension.program_id__c0}> : () -> i64
    %33 = "func.call"() <{callee = @flag_gems.utils.triton_lang_extension.program_id__c1}> : () -> i64
    %34 = "arith.muli"(%32, %21) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %35 = "arith.index_cast"(%34) : (i64) -> index
    %36 = "arith.muli"(%33, %21) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %37 = "arith.index_cast"(%36) : (i64) -> index
    %38 = "arith.index_cast"(%arg10) : (i32) -> index
    %39 = "arith.muli"(%35, %38) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %40 = "arith.addi"(%25, %39) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %41 = "arith.index_cast"(%arg12) : (i32) -> index
    %42 = "arith.index_cast"(%arg14) : (i32) -> index
    %43 = "memref.reinterpret_cast"(%arg5, %42) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %44 = "func.call"(%arg8) <{callee = @triton.language.standard.cdiv__i32_c32}> : (i32) -> i32
    %45 = "func.call"() <{callee = @triton.language.standard.zeros__Tc32_c32T_cfp32}> : () -> tensor<32x32xf32>
    %46 = "arith.index_cast"(%44) : (i32) -> index
    %47:3 = "scf.for"(%17, %46, %18, %40, %28, %45) ({
    ^bb0(%arg15: index, %arg16: index, %arg17: index, %arg18: tensor<32x32xf32>):
      %56 = "memref.reinterpret_cast"(%arg4, %41) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
      %57 = "memref.reinterpret_cast"(%arg3, %38) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
      %58 = "arith.addi"(%35, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %59 = "arith.index_cast"(%arg6) : (i32) -> index
      %60 = "arith.minsi"(%58, %59) : (index, index) -> index
      %61 = "arith.maxsi"(%60, %35) : (index, index) -> index
      %62 = "arith.subi"(%61, %35) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %63 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      "linalg.fill"(%16, %63) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg31: f32, %arg32: f32):
        "linalg.yield"(%arg31) : (f32) -> ()
      }) : (f32, memref<32x32xf32>) -> ()
      %64 = "memref.subview"(%57, %arg16, %62) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index) -> memref<?x32xf32, strided<[?, 1], offset: ?>>
      %65 = "memref.subview"(%63, %62) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<32x32xf32>, index) -> memref<?x32xf32, strided<[32, 1]>>
      "linalg.copy"(%64, %65) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg29: f32, %arg30: f32):
        "linalg.yield"(%arg29) : (f32) -> ()
      }) : (memref<?x32xf32, strided<[?, 1], offset: ?>>, memref<?x32xf32, strided<[32, 1]>>) -> ()
      %66 = "bufferization.to_tensor"(%63) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %67 = "arith.addi"(%37, %arg17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %68 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      %69 = "memref.subview"(%56, %67) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index) -> memref<32x32xf32, strided<[?, 1], offset: ?>>
      "linalg.copy"(%69, %68) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg27: f32, %arg28: f32):
        "linalg.yield"(%arg27) : (f32) -> ()
      }) : (memref<32x32xf32, strided<[?, 1], offset: ?>>, memref<32x32xf32>) -> ()
      %70 = "bufferization.to_tensor"(%68) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %71 = "arith.addi"(%arg16, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %72 = "arith.muli"(%arg12, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %73 = "arith.index_cast"(%72) : (i32) -> index
      %74 = "arith.addi"(%arg17, %73) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %75 = "tensor.empty"() : () -> tensor<32x32xf32>
      %76 = "linalg.fill"(%16, %75) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg25: f32, %arg26: f32):
        "linalg.yield"(%arg25) : (f32) -> ()
      }) : (f32, tensor<32x32xf32>) -> tensor<32x32xf32>
      %77 = "linalg.matmul"(%66, %70, %76) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg22: f32, %arg23: f32, %arg24: f32):
        %80 = "arith.mulf"(%arg22, %arg23) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %81 = "arith.addf"(%arg24, %80) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%81) : (f32) -> ()
      }) : (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
      %78 = "linalg.generic"(%arg18, %77, %arg18) <{indexing_maps = [#map3, #map3, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg19: f32, %arg20: f32, %arg21: f32):
        %79 = "arith.addf"(%arg19, %arg20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%79) : (f32) -> ()
      }) : (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
      "scf.yield"(%71, %74, %78) : (index, index, tensor<32x32xf32>) -> ()
    }) : (index, index, index, index, index, tensor<32x32xf32>) -> (index, index, tensor<32x32xf32>)
    %48 = "arith.addi"(%35, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %49 = "arith.index_cast"(%arg6) : (i32) -> index
    %50 = "arith.minsi"(%48, %49) : (index, index) -> index
    %51 = "arith.maxsi"(%50, %35) : (index, index) -> index
    %52 = "arith.subi"(%51, %35) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %53 = "arith.addi"(%37, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %54 = "tensor.extract_slice"(%47#2, %52) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (tensor<32x32xf32>, index) -> tensor<?x32xf32>
    %55 = "memref.subview"(%43, %35, %53, %52) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index, index) -> memref<?x32xf32, strided<[?, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%54, %55) <{writable}> : (tensor<?x32xf32>, memref<?x32xf32, strided<[?, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "flag_gems.utils.triton_lang_extension.program_id__c2", sym_visibility = "private"}> ({
    %13 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
    %14 = "arith.index_cast"(%13) : (index) -> i32
    %15 = "arith.extsi"(%14) : (i32) -> i64
    "func.return"(%15) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "flag_gems.utils.triton_lang_extension.program_id__c0", sym_visibility = "private"}> ({
    %10 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %11 = "arith.index_cast"(%10) : (index) -> i32
    %12 = "arith.extsi"(%11) : (i32) -> i64
    "func.return"(%12) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "flag_gems.utils.triton_lang_extension.program_id__c1", sym_visibility = "private"}> ({
    %7 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %8 = "arith.index_cast"(%7) : (index) -> i32
    %9 = "arith.extsi"(%8) : (i32) -> i64
    "func.return"(%9) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c32", sym_visibility = "private"}> ({
  ^bb0(%arg2: i32):
    %3 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 31 : i32}> : () -> i32
    %5 = "arith.addi"(%arg2, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "arith.divsi"(%5, %3) : (i32, i32) -> i32
    "func.return"(%6) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<32x32xf32>, sym_name = "triton.language.standard.zeros__Tc32_c32T_cfp32", sym_visibility = "private"}> ({
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<32x32xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg0: f32, %arg1: f32):
      "linalg.yield"(%arg0) : (f32) -> ()
    }) : (f32, tensor<32x32xf32>) -> tensor<32x32xf32>
    "func.return"(%2) : (tensor<32x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

