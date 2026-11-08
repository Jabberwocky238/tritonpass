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
      %55 = "memref.reinterpret_cast"(%arg4, %40) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, -9223372036854775808>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[1, ?]>>
      %56 = "memref.reinterpret_cast"(%arg3, %37) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
      %57 = "arith.addi"(%34, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %58 = "arith.index_cast"(%arg6) : (i32) -> index
      %59 = "arith.minsi"(%57, %58) : (index, index) -> index
      %60 = "arith.maxsi"(%59, %34) : (index, index) -> index
      %61 = "arith.subi"(%60, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %62 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      "linalg.fill"(%16, %62) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg31: f32, %arg32: f32):
        "linalg.yield"(%arg31) : (f32) -> ()
      }) : (f32, memref<32x32xf32>) -> ()
      %63 = "memref.subview"(%56, %arg16, %61) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index) -> memref<?x32xf32, strided<[?, 1], offset: ?>>
      %64 = "memref.subview"(%62, %61) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<32x32xf32>, index) -> memref<?x32xf32, strided<[32, 1]>>
      "linalg.copy"(%63, %64) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg29: f32, %arg30: f32):
        "linalg.yield"(%arg29) : (f32) -> ()
      }) : (memref<?x32xf32, strided<[?, 1], offset: ?>>, memref<?x32xf32, strided<[32, 1]>>) -> ()
      %65 = "bufferization.to_tensor"(%62) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %66 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      %67 = "memref.subview"(%55, %arg17, %36) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[1, ?]>>, index, index) -> memref<32x32xf32, strided<[1, ?], offset: ?>>
      "linalg.copy"(%67, %66) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg27: f32, %arg28: f32):
        "linalg.yield"(%arg27) : (f32) -> ()
      }) : (memref<32x32xf32, strided<[1, ?], offset: ?>>, memref<32x32xf32>) -> ()
      %68 = "bufferization.to_tensor"(%66) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %69 = "arith.addi"(%arg16, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %70 = "arith.addi"(%arg17, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %71 = "tensor.empty"() : () -> tensor<32x32xf32>
      %72 = "linalg.fill"(%16, %71) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg25: f32, %arg26: f32):
        "linalg.yield"(%arg25) : (f32) -> ()
      }) : (f32, tensor<32x32xf32>) -> tensor<32x32xf32>
      %73 = "linalg.matmul"(%65, %68, %72) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg22: f32, %arg23: f32, %arg24: f32):
        %76 = "arith.mulf"(%arg22, %arg23) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %77 = "arith.addf"(%arg24, %76) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%77) : (f32) -> ()
      }) : (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
      %74 = "linalg.generic"(%arg18, %73, %arg18) <{indexing_maps = [#map3, #map3, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg19: f32, %arg20: f32, %arg21: f32):
        %75 = "arith.addf"(%arg19, %arg20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%75) : (f32) -> ()
      }) : (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
      "scf.yield"(%69, %70, %74) : (index, index, tensor<32x32xf32>) -> ()
    }) : (index, index, index, index, index, tensor<32x32xf32>) -> (index, index, tensor<32x32xf32>)
    %47 = "arith.addi"(%34, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %48 = "arith.index_cast"(%arg6) : (i32) -> index
    %49 = "arith.minsi"(%47, %48) : (index, index) -> index
    %50 = "arith.maxsi"(%49, %34) : (index, index) -> index
    %51 = "arith.subi"(%50, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %52 = "arith.addi"(%36, %30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %53 = "tensor.extract_slice"(%46#2, %51) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (tensor<32x32xf32>, index) -> tensor<?x32xf32>
    %54 = "memref.subview"(%42, %34, %52, %51) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index, index) -> memref<?x32xf32, strided<[?, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%53, %54) <{writable}> : (tensor<?x32xf32>, memref<?x32xf32, strided<[?, 1], offset: ?>>) -> ()
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

