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
    %20 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %21 = "func.call"() <{callee = @flag_gems.utils.triton_lang_extension.program_id__c2}> : () -> i64
    %22 = "arith.extsi"(%arg9) : (i32) -> i64
    %23 = "arith.muli"(%21, %22) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %24 = "arith.index_cast"(%23) : (i64) -> index
    %25 = "arith.extsi"(%arg11) : (i32) -> i64
    %26 = "arith.muli"(%21, %25) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %27 = "arith.index_cast"(%26) : (i64) -> index
    %28 = "arith.extsi"(%arg13) : (i32) -> i64
    %29 = "arith.muli"(%21, %28) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %30 = "arith.index_cast"(%29) : (i64) -> index
    %31 = "func.call"() <{callee = @flag_gems.utils.triton_lang_extension.program_id__c0}> : () -> i64
    %32 = "func.call"() <{callee = @flag_gems.utils.triton_lang_extension.program_id__c1}> : () -> i64
    %33 = "arith.muli"(%31, %20) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %34 = "arith.index_cast"(%33) : (i64) -> index
    %35 = "arith.muli"(%32, %20) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %36 = "arith.index_cast"(%35) : (i64) -> index
    %37 = "arith.index_cast"(%arg10) : (i32) -> index
    %38 = "arith.muli"(%34, %37) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %39 = "arith.addi"(%24, %38) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %40 = "arith.index_cast"(%arg12) : (i32) -> index
    %41 = "arith.index_cast"(%arg14) : (i32) -> index
    %42 = "memref.reinterpret_cast"(%arg5, %41) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %43 = "func.call"(%arg8) <{callee = @triton.language.standard.cdiv__i32_c32}> : (i32) -> i32
    %44 = "func.call"() <{callee = @triton.language.standard.zeros__Tc32_c32T_cfp32}> : () -> tensor<32x32xf32>
    %45 = "arith.index_cast"(%43) : (i32) -> index
    %46:3 = "scf.for"(%17, %45, %18, %39, %27, %44) ({
    ^bb0(%arg15: index, %arg16: index, %arg17: index, %arg18: tensor<32x32xf32>):
      %62 = "memref.reinterpret_cast"(%arg4, %40) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, -9223372036854775808>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[1, ?]>>
      %63 = "memref.reinterpret_cast"(%arg3, %37) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
      %64 = "arith.addi"(%34, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %65 = "arith.index_cast"(%arg6) : (i32) -> index
      %66 = "arith.minsi"(%64, %65) : (index, index) -> index
      %67 = "arith.maxsi"(%66, %34) : (index, index) -> index
      %68 = "arith.subi"(%67, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %69 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      "linalg.fill"(%16, %69) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg33: f32, %arg34: f32):
        "linalg.yield"(%arg33) : (f32) -> ()
      }) : (f32, memref<32x32xf32>) -> ()
      %70 = "memref.subview"(%63, %arg16, %68) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index) -> memref<?x32xf32, strided<[?, 1], offset: ?>>
      %71 = "memref.subview"(%69, %68) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<32x32xf32>, index) -> memref<?x32xf32, strided<[32, 1]>>
      "linalg.copy"(%70, %71) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg31: f32, %arg32: f32):
        "linalg.yield"(%arg31) : (f32) -> ()
      }) : (memref<?x32xf32, strided<[?, 1], offset: ?>>, memref<?x32xf32, strided<[32, 1]>>) -> ()
      %72 = "bufferization.to_tensor"(%69) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %73 = "arith.addi"(%36, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %74 = "arith.index_cast"(%arg7) : (i32) -> index
      %75 = "arith.minsi"(%73, %74) : (index, index) -> index
      %76 = "arith.maxsi"(%75, %36) : (index, index) -> index
      %77 = "arith.subi"(%76, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %78 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      "linalg.fill"(%16, %78) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg29: f32, %arg30: f32):
        "linalg.yield"(%arg29) : (f32) -> ()
      }) : (f32, memref<32x32xf32>) -> ()
      %79 = "memref.subview"(%62, %arg17, %36, %77) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[1, ?]>>, index, index, index) -> memref<32x?xf32, strided<[1, ?], offset: ?>>
      %80 = "memref.subview"(%78, %77) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<32x32xf32>, index) -> memref<32x?xf32, strided<[32, 1]>>
      "linalg.copy"(%79, %80) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg27: f32, %arg28: f32):
        "linalg.yield"(%arg27) : (f32) -> ()
      }) : (memref<32x?xf32, strided<[1, ?], offset: ?>>, memref<32x?xf32, strided<[32, 1]>>) -> ()
      %81 = "bufferization.to_tensor"(%78) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %82 = "arith.addi"(%arg16, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %83 = "arith.addi"(%arg17, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %84 = "tensor.empty"() : () -> tensor<32x32xf32>
      %85 = "linalg.fill"(%16, %84) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg25: f32, %arg26: f32):
        "linalg.yield"(%arg25) : (f32) -> ()
      }) : (f32, tensor<32x32xf32>) -> tensor<32x32xf32>
      %86 = "linalg.matmul"(%72, %81, %85) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg22: f32, %arg23: f32, %arg24: f32):
        %89 = "arith.mulf"(%arg22, %arg23) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %90 = "arith.addf"(%arg24, %89) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%90) : (f32) -> ()
      }) : (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
      %87 = "linalg.generic"(%arg18, %86, %arg18) <{indexing_maps = [#map3, #map3, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg19: f32, %arg20: f32, %arg21: f32):
        %88 = "arith.addf"(%arg19, %arg20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%88) : (f32) -> ()
      }) : (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
      "scf.yield"(%82, %83, %87) : (index, index, tensor<32x32xf32>) -> ()
    }) : (index, index, index, index, index, tensor<32x32xf32>) -> (index, index, tensor<32x32xf32>)
    %47 = "arith.addi"(%34, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %48 = "arith.index_cast"(%arg6) : (i32) -> index
    %49 = "arith.minsi"(%47, %48) : (index, index) -> index
    %50 = "arith.maxsi"(%49, %34) : (index, index) -> index
    %51 = "arith.subi"(%50, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %52 = "arith.addi"(%36, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %53 = "arith.index_cast"(%arg7) : (i32) -> index
    %54 = "arith.minsi"(%52, %53) : (index, index) -> index
    %55 = "arith.maxsi"(%54, %36) : (index, index) -> index
    %56 = "arith.subi"(%55, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %57 = "arith.minsi"(%51, %19) : (index, index) -> index
    %58 = "arith.minsi"(%56, %19) : (index, index) -> index
    %59 = "arith.addi"(%36, %30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %60 = "tensor.extract_slice"(%46#2, %57, %58) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<32x32xf32>, index, index) -> tensor<?x?xf32>
    %61 = "memref.subview"(%42, %34, %59, %57, %58) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[?, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%60, %61) <{writable}> : (tensor<?x?xf32>, memref<?x?xf32, strided<[?, 1], offset: ?>>) -> ()
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

