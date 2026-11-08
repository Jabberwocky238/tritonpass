#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "bmm_kernel"}> ({
  ^bb0(%arg3: memref<?xf32>, %arg4: memref<?xf32>, %arg5: memref<?xf32>, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32):
    %16 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %17 = "arith.constant"() <{value = 0 : index}> : () -> index
    %18 = "arith.constant"() <{value = 1 : index}> : () -> index
    %19 = "arith.constant"() <{value = 32 : index}> : () -> index
    %20 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %21 = "func.call"() <{callee = @flag_gems.utils.triton_lang_extension.program_id__c2}> : () -> i64
    %22 = "arith.extsi"(%arg8) : (i32) -> i64
    %23 = "arith.muli"(%21, %22) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %24 = "arith.index_cast"(%23) : (i64) -> index
    %25 = "arith.extsi"(%arg10) : (i32) -> i64
    %26 = "arith.muli"(%21, %25) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %27 = "arith.index_cast"(%26) : (i64) -> index
    %28 = "arith.extsi"(%arg12) : (i32) -> i64
    %29 = "arith.muli"(%21, %28) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %30 = "arith.index_cast"(%29) : (i64) -> index
    %31 = "func.call"() <{callee = @flag_gems.utils.triton_lang_extension.program_id__c0}> : () -> i64
    %32 = "func.call"() <{callee = @flag_gems.utils.triton_lang_extension.program_id__c1}> : () -> i64
    %33 = "arith.muli"(%31, %20) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %34 = "arith.index_cast"(%33) : (i64) -> index
    %35 = "arith.muli"(%32, %20) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %36 = "arith.index_cast"(%35) : (i64) -> index
    %37 = "arith.index_cast"(%arg9) : (i32) -> index
    %38 = "arith.muli"(%34, %37) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %39 = "arith.addi"(%24, %38) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %40 = "arith.index_cast"(%arg11) : (i32) -> index
    %41 = "memref.reinterpret_cast"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[1, 1]>>
    %42 = "func.call"(%arg7) <{callee = @triton.language.standard.cdiv__i32_c32}> : (i32) -> i32
    %43 = "func.call"() <{callee = @triton.language.standard.zeros__Tc32_c32T_cfp32}> : () -> tensor<32x32xf32>
    %44 = "arith.index_cast"(%42) : (i32) -> index
    %45:3 = "scf.for"(%17, %44, %18, %39, %27, %43) ({
    ^bb0(%arg13: index, %arg14: index, %arg15: index, %arg16: tensor<32x32xf32>):
      %60 = "memref.reinterpret_cast"(%arg4, %40) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, -9223372036854775808>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[1, ?]>>
      %61 = "memref.reinterpret_cast"(%arg3, %37) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
      %62 = "arith.addi"(%34, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %63 = "arith.index_cast"(%arg6) : (i32) -> index
      %64 = "arith.minsi"(%62, %63) : (index, index) -> index
      %65 = "arith.maxsi"(%64, %34) : (index, index) -> index
      %66 = "arith.subi"(%65, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %67 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      "linalg.fill"(%16, %67) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg31: f32, %arg32: f32):
        "linalg.yield"(%arg31) : (f32) -> ()
      }) : (f32, memref<32x32xf32>) -> ()
      %68 = "memref.subview"(%61, %arg14, %66) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index) -> memref<?x32xf32, strided<[?, 1], offset: ?>>
      %69 = "memref.subview"(%67, %66) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<32x32xf32>, index) -> memref<?x32xf32, strided<[32, 1]>>
      "linalg.copy"(%68, %69) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg29: f32, %arg30: f32):
        "linalg.yield"(%arg29) : (f32) -> ()
      }) : (memref<?x32xf32, strided<[?, 1], offset: ?>>, memref<?x32xf32, strided<[32, 1]>>) -> ()
      %70 = "bufferization.to_tensor"(%67) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %71 = "arith.addi"(%36, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %72 = "arith.minsi"(%71, %18) : (index, index) -> index
      %73 = "arith.maxsi"(%72, %36) : (index, index) -> index
      %74 = "arith.subi"(%73, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %75 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      "linalg.fill"(%16, %75) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg27: f32, %arg28: f32):
        "linalg.yield"(%arg27) : (f32) -> ()
      }) : (f32, memref<32x32xf32>) -> ()
      %76 = "memref.subview"(%60, %arg15, %36, %74) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[1, ?]>>, index, index, index) -> memref<32x?xf32, strided<[1, ?], offset: ?>>
      %77 = "memref.subview"(%75, %74) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<32x32xf32>, index) -> memref<32x?xf32, strided<[32, 1]>>
      "linalg.copy"(%76, %77) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg25: f32, %arg26: f32):
        "linalg.yield"(%arg25) : (f32) -> ()
      }) : (memref<32x?xf32, strided<[1, ?], offset: ?>>, memref<32x?xf32, strided<[32, 1]>>) -> ()
      %78 = "bufferization.to_tensor"(%75) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %79 = "arith.addi"(%arg14, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %80 = "arith.addi"(%arg15, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %81 = "tensor.empty"() : () -> tensor<32x32xf32>
      %82 = "linalg.fill"(%16, %81) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg23: f32, %arg24: f32):
        "linalg.yield"(%arg23) : (f32) -> ()
      }) : (f32, tensor<32x32xf32>) -> tensor<32x32xf32>
      %83 = "linalg.matmul"(%70, %78, %82) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg20: f32, %arg21: f32, %arg22: f32):
        %86 = "arith.mulf"(%arg20, %arg21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %87 = "arith.addf"(%arg22, %86) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%87) : (f32) -> ()
      }) : (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
      %84 = "linalg.generic"(%arg16, %83, %arg16) <{indexing_maps = [#map3, #map3, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg17: f32, %arg18: f32, %arg19: f32):
        %85 = "arith.addf"(%arg17, %arg18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%85) : (f32) -> ()
      }) : (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
      "scf.yield"(%79, %80, %84) : (index, index, tensor<32x32xf32>) -> ()
    }) : (index, index, index, index, index, tensor<32x32xf32>) -> (index, index, tensor<32x32xf32>)
    %46 = "arith.addi"(%34, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %47 = "arith.index_cast"(%arg6) : (i32) -> index
    %48 = "arith.minsi"(%46, %47) : (index, index) -> index
    %49 = "arith.maxsi"(%48, %34) : (index, index) -> index
    %50 = "arith.subi"(%49, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %51 = "arith.addi"(%36, %19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %52 = "arith.minsi"(%51, %18) : (index, index) -> index
    %53 = "arith.maxsi"(%52, %36) : (index, index) -> index
    %54 = "arith.subi"(%53, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %55 = "arith.minsi"(%50, %19) : (index, index) -> index
    %56 = "arith.minsi"(%54, %19) : (index, index) -> index
    %57 = "arith.addi"(%30, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %58 = "tensor.extract_slice"(%45#2, %55, %56) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<32x32xf32>, index, index) -> tensor<?x?xf32>
    %59 = "memref.subview"(%41, %57, %36, %55, %56) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[1, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[1, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%58, %59) <{writable}> : (tensor<?x?xf32>, memref<?x?xf32, strided<[1, 1], offset: ?>>) -> ()
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

