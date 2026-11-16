#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "bmm_kernel"}> ({
  ^bb0(%arg6: memref<?xf32>, %arg7: memref<?xf32>, %arg8: memref<?xf32>, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32, %arg15: i32, %arg16: i32, %arg17: i32, %arg18: i32, %arg19: i32, %arg20: i32, %arg21: i32):
    %10 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %11 = "arith.constant"() <{value = 0 : index}> : () -> index
    %12 = "arith.constant"() <{value = 1 : index}> : () -> index
    %13 = "arith.constant"() <{value = 32 : index}> : () -> index
    %14 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %15 = "func.call"(%arg21) <{callee = @flag_gems.utils.triton_lang_extension.program_id__c2}> : (i32) -> i64
    %16 = "arith.extsi"(%arg11) : (i32) -> i64
    %17 = "arith.muli"(%15, %16) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %18 = "arith.index_cast"(%17) : (i64) -> index
    %19 = "arith.extsi"(%arg13) : (i32) -> i64
    %20 = "arith.muli"(%15, %19) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %21 = "arith.index_cast"(%20) : (i64) -> index
    %22 = "arith.extsi"(%arg15) : (i32) -> i64
    %23 = "arith.muli"(%15, %22) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %24 = "arith.index_cast"(%23) : (i64) -> index
    %25 = "func.call"(%arg19) <{callee = @flag_gems.utils.triton_lang_extension.program_id__c0}> : (i32) -> i64
    %26 = "func.call"(%arg20) <{callee = @flag_gems.utils.triton_lang_extension.program_id__c1}> : (i32) -> i64
    %27 = "arith.muli"(%25, %14) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %28 = "arith.index_cast"(%27) : (i64) -> index
    %29 = "arith.muli"(%26, %14) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %30 = "arith.index_cast"(%29) : (i64) -> index
    %31 = "arith.index_cast"(%arg12) : (i32) -> index
    %32 = "arith.muli"(%28, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %33 = "arith.addi"(%18, %32) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %34 = "arith.index_cast"(%arg14) : (i32) -> index
    %35 = "memref.reinterpret_cast"(%arg8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[1, 1]>>
    %36 = "func.call"(%arg10) <{callee = @triton.language.standard.cdiv__i32_c32}> : (i32) -> i32
    %37 = "func.call"() <{callee = @triton.language.standard.zeros__Tc32_c32T_cfp32}> : () -> tensor<32x32xf32>
    %38 = "arith.index_cast"(%36) : (i32) -> index
    %39:3 = "scf.for"(%11, %38, %12, %33, %21, %37) ({
    ^bb0(%arg22: index, %arg23: index, %arg24: index, %arg25: tensor<32x32xf32>):
      %54 = "memref.reinterpret_cast"(%arg7, %34) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, -9223372036854775808>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[1, ?]>>
      %55 = "memref.reinterpret_cast"(%arg6, %31) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
      %56 = "arith.addi"(%28, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %57 = "arith.index_cast"(%arg9) : (i32) -> index
      %58 = "arith.minsi"(%56, %57) : (index, index) -> index
      %59 = "arith.maxsi"(%58, %28) : (index, index) -> index
      %60 = "arith.subi"(%59, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %61 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      "linalg.fill"(%10, %61) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg40: f32, %arg41: f32):
        "linalg.yield"(%arg40) : (f32) -> ()
      }) : (f32, memref<32x32xf32>) -> ()
      %62 = "memref.subview"(%55, %arg23, %60) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index) -> memref<?x32xf32, strided<[?, 1], offset: ?>>
      %63 = "memref.subview"(%61, %60) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<32x32xf32>, index) -> memref<?x32xf32, strided<[32, 1]>>
      "linalg.copy"(%62, %63) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg38: f32, %arg39: f32):
        "linalg.yield"(%arg38) : (f32) -> ()
      }) : (memref<?x32xf32, strided<[?, 1], offset: ?>>, memref<?x32xf32, strided<[32, 1]>>) -> ()
      %64 = "bufferization.to_tensor"(%61) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %65 = "arith.addi"(%30, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %66 = "arith.minsi"(%65, %12) : (index, index) -> index
      %67 = "arith.maxsi"(%66, %30) : (index, index) -> index
      %68 = "arith.subi"(%67, %30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %69 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      "linalg.fill"(%10, %69) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg36: f32, %arg37: f32):
        "linalg.yield"(%arg36) : (f32) -> ()
      }) : (f32, memref<32x32xf32>) -> ()
      %70 = "memref.subview"(%54, %arg24, %30, %68) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[1, ?]>>, index, index, index) -> memref<32x?xf32, strided<[1, ?], offset: ?>>
      %71 = "memref.subview"(%69, %68) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<32x32xf32>, index) -> memref<32x?xf32, strided<[32, 1]>>
      "linalg.copy"(%70, %71) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg34: f32, %arg35: f32):
        "linalg.yield"(%arg34) : (f32) -> ()
      }) : (memref<32x?xf32, strided<[1, ?], offset: ?>>, memref<32x?xf32, strided<[32, 1]>>) -> ()
      %72 = "bufferization.to_tensor"(%69) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %73 = "arith.addi"(%arg23, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %74 = "arith.addi"(%arg24, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %75 = "tensor.empty"() : () -> tensor<32x32xf32>
      %76 = "linalg.fill"(%10, %75) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg32: f32, %arg33: f32):
        "linalg.yield"(%arg32) : (f32) -> ()
      }) : (f32, tensor<32x32xf32>) -> tensor<32x32xf32>
      %77 = "linalg.matmul"(%64, %72, %76) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg29: f32, %arg30: f32, %arg31: f32):
        %80 = "arith.mulf"(%arg29, %arg30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %81 = "arith.addf"(%arg31, %80) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%81) : (f32) -> ()
      }) : (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
      %78 = "linalg.generic"(%arg25, %77, %arg25) <{indexing_maps = [#map3, #map3, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg26: f32, %arg27: f32, %arg28: f32):
        %79 = "arith.addf"(%arg26, %arg27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%79) : (f32) -> ()
      }) : (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
      "scf.yield"(%73, %74, %78) : (index, index, tensor<32x32xf32>) -> ()
    }) : (index, index, index, index, index, tensor<32x32xf32>) -> (index, index, tensor<32x32xf32>)
    %40 = "arith.addi"(%28, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %41 = "arith.index_cast"(%arg9) : (i32) -> index
    %42 = "arith.minsi"(%40, %41) : (index, index) -> index
    %43 = "arith.maxsi"(%42, %28) : (index, index) -> index
    %44 = "arith.subi"(%43, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %45 = "arith.addi"(%30, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %46 = "arith.minsi"(%45, %12) : (index, index) -> index
    %47 = "arith.maxsi"(%46, %30) : (index, index) -> index
    %48 = "arith.subi"(%47, %30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %49 = "arith.minsi"(%44, %13) : (index, index) -> index
    %50 = "arith.minsi"(%48, %13) : (index, index) -> index
    %51 = "arith.addi"(%24, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %52 = "tensor.extract_slice"(%39#2, %49, %50) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<32x32xf32>, index, index) -> tensor<?x?xf32>
    %53 = "memref.subview"(%35, %51, %30, %49, %50) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[1, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[1, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%52, %53) <{writable}> : (tensor<?x?xf32>, memref<?x?xf32, strided<[1, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i64, sym_name = "flag_gems.utils.triton_lang_extension.program_id__c2", sym_visibility = "private"}> ({
  ^bb0(%arg5: i32):
    %9 = "arith.extsi"(%arg5) : (i32) -> i64
    "func.return"(%9) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i64, sym_name = "flag_gems.utils.triton_lang_extension.program_id__c0", sym_visibility = "private"}> ({
  ^bb0(%arg4: i32):
    %8 = "arith.extsi"(%arg4) : (i32) -> i64
    "func.return"(%8) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i64, sym_name = "flag_gems.utils.triton_lang_extension.program_id__c1", sym_visibility = "private"}> ({
  ^bb0(%arg3: i32):
    %7 = "arith.extsi"(%arg3) : (i32) -> i64
    "func.return"(%7) : (i64) -> ()
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

