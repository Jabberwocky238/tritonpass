#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map4 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xbf16>, memref<?xbf16>, memref<?xbf16>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "matmul_kernel_persistent"}> ({
  ^bb0(%arg7: memref<?xbf16>, %arg8: memref<?xbf16>, %arg9: memref<?xbf16>, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32, %arg15: i32):
    %20 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %21 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %22 = "arith.constant"() <{value = 132 : index}> : () -> index
    %23 = "arith.constant"() <{value = 0 : index}> : () -> index
    %24 = "arith.constant"() <{value = 1 : index}> : () -> index
    %25 = "arith.constant"() <{value = 64 : index}> : () -> index
    %26 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %27 = "arith.constant"() <{value = 128 : index}> : () -> index
    %28 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %29 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %30 = "arith.constant"() <{value = 132 : i32}> : () -> i32
    %31 = "tensor.empty"() : () -> tensor<128xi32>
    %32 = "linalg.fill"(%20, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg60: i32, %arg61: i32):
      "linalg.yield"(%arg60) : (i32) -> ()
    }) : (i32, tensor<128xi32>) -> tensor<128xi32>
    %33 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %34 = "arith.index_cast"(%33) : (index) -> i32
    %35 = "func.call"(%arg10) <{callee = @triton.language.standard.cdiv__i32_c128}> : (i32) -> i32
    %36 = "func.call"(%arg11) <{callee = @triton.language.standard.cdiv__i32_c128}> : (i32) -> i32
    %37 = "func.call"(%arg12) <{callee = @triton.language.standard.cdiv__i32_c64}> : (i32) -> i32
    %38 = "arith.muli"(%35, %36) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %39 = "arith.subi"(%34, %30) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %40 = "arith.muli"(%36, %29) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %41 = "arith.index_cast"(%38) : (i32) -> index
    %42 = "scf.for"(%33, %41, %22, %39) ({
    ^bb0(%arg16: index, %arg17: i32):
      %43 = "arith.index_cast"(%arg16) : (index) -> i32
      %44:2 = "func.call"(%43, %40, %35) <{callee = @vllm.model_executor.determinism.batch_invariant._compute_pid__i32_i32_i32_c8}> : (i32, i32, i32) -> (i32, i32)
      %45 = "arith.muli"(%44#0, %28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %46 = "arith.muli"(%44#1, %28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %47 = "linalg.generic"(%31) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
      ^bb0(%arg59: i32):
        %125 = "linalg.index"() <{dim = 0 : i64}> : () -> index
        %126 = "arith.index_cast"(%125) : (index) -> i32
        "linalg.yield"(%126) : (i32) -> ()
      }) : (tensor<128xi32>) -> tensor<128xi32>
      %48 = "linalg.fill"(%45, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg57: i32, %arg58: i32):
        "linalg.yield"(%arg57) : (i32) -> ()
      }) : (i32, tensor<128xi32>) -> tensor<128xi32>
      %49 = "linalg.generic"(%48, %47, %48) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg54: i32, %arg55: i32, %arg56: i32):
        %124 = "arith.addi"(%arg54, %arg55) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%124) : (i32) -> ()
      }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
      %50 = "linalg.fill"(%46, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg52: i32, %arg53: i32):
        "linalg.yield"(%arg52) : (i32) -> ()
      }) : (i32, tensor<128xi32>) -> tensor<128xi32>
      %51 = "linalg.generic"(%50, %47, %50) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg49: i32, %arg50: i32, %arg51: i32):
        %123 = "arith.addi"(%arg49, %arg50) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%123) : (i32) -> ()
      }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
      %52 = "linalg.fill"(%arg10, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg47: i32, %arg48: i32):
        "linalg.yield"(%arg47) : (i32) -> ()
      }) : (i32, tensor<128xi32>) -> tensor<128xi32>
      %53 = "tensor.empty"() : () -> tensor<128xi1>
      %54 = "linalg.generic"(%49, %52, %53) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg44: i32, %arg45: i32, %arg46: i1):
        %122 = "arith.cmpi"(%arg44, %arg45) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "linalg.yield"(%122) : (i1) -> ()
      }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi1>) -> tensor<128xi1>
      %55 = "linalg.generic"(%54, %49, %32, %49) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg40: i1, %arg41: i32, %arg42: i32, %arg43: i32):
        %121 = "arith.select"(%arg40, %arg41, %arg42) {tt.contiguity = dense<128> : tensor<1xi32>, tt.divisibility = dense<128> : tensor<1xi32>} : (i1, i32, i32) -> i32
        "linalg.yield"(%121) : (i32) -> ()
      }) : (tensor<128xi1>, tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
      %56 = "linalg.fill"(%arg11, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg38: i32, %arg39: i32):
        "linalg.yield"(%arg38) : (i32) -> ()
      }) : (i32, tensor<128xi32>) -> tensor<128xi32>
      %57 = "linalg.generic"(%51, %56, %53) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg35: i32, %arg36: i32, %arg37: i1):
        %120 = "arith.cmpi"(%arg35, %arg36) <{predicate = 2 : i64}> : (i32, i32) -> i1
        "linalg.yield"(%120) : (i1) -> ()
      }) : (tensor<128xi32>, tensor<128xi32>, tensor<128xi1>) -> tensor<128xi1>
      %58 = "linalg.generic"(%57, %51, %32, %51) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg31: i1, %arg32: i32, %arg33: i32, %arg34: i32):
        %119 = "arith.select"(%arg31, %arg32, %arg33) {tt.contiguity = dense<128> : tensor<1xi32>, tt.divisibility = dense<128> : tensor<1xi32>} : (i1, i32, i32) -> i32
        "linalg.yield"(%119) : (i32) -> ()
      }) : (tensor<128xi1>, tensor<128xi32>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
      %59 = "func.call"() <{callee = @triton.language.standard.zeros__Tc128_c128T_cfp32}> : () -> tensor<128x128xf32>
      %60 = "arith.index_cast"(%37) : (i32) -> index
      %61 = "scf.for"(%23, %60, %24, %59) ({
      ^bb0(%arg20: index, %arg21: tensor<128x128xf32>):
        %87 = "arith.index_cast"(%arg20) : (index) -> i32
        %88 = "arith.muli"(%87, %21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %89 = "arith.index_cast"(%88) : (i32) -> index
        %90 = "arith.index_cast"(%arg13) : (i32) -> index
        %91 = "arith.index_cast"(%arg14) : (i32) -> index
        %92 = "arith.subi"(%arg12, %88) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %93 = "arith.index_cast"(%92) : (i32) -> index
        %94 = "arith.minsi"(%93, %25) : (index, index) -> index
        %95 = "arith.maxsi"(%94, %23) : (index, index) -> index
        %96 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128x64xbf16>
        "linalg.fill"(%26, %96) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg29: bf16, %arg30: bf16):
          "linalg.yield"(%arg29) : (bf16) -> ()
        }) : (bf16, memref<128x64xbf16>) -> ()
        "scf.for"(%23, %27, %24) ({
        ^bb0(%arg28: index):
          %112 = "tensor.extract"(%55, %arg28) : (tensor<128xi32>, index) -> i32
          %113 = "arith.index_cast"(%112) : (i32) -> index
          %114 = "arith.muli"(%113, %90) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %115 = "arith.addi"(%114, %89) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %116 = "memref.reinterpret_cast"(%arg7, %115, %90) <{operandSegmentSizes = array<i32: 1, 1, 0, 1>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1, 64>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xbf16>, index, index) -> memref<1x64xbf16, strided<[?, 1], offset: ?>>
          %117 = "memref.subview"(%116, %95) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1x64xbf16, strided<[?, 1], offset: ?>>, index) -> memref<1x?xbf16, strided<[?, 1], offset: ?>>
          %118 = "memref.subview"(%96, %arg28, %95) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 1, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<128x64xbf16>, index, index) -> memref<1x?xbf16, strided<[64, 1], offset: ?>>
          "memref.copy"(%117, %118) : (memref<1x?xbf16, strided<[?, 1], offset: ?>>, memref<1x?xbf16, strided<[64, 1], offset: ?>>) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %97 = "bufferization.to_tensor"(%96) <{restrict, writable}> : (memref<128x64xbf16>) -> tensor<128x64xbf16>
        %98 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xbf16>
        "linalg.fill"(%26, %98) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg26: bf16, %arg27: bf16):
          "linalg.yield"(%arg26) : (bf16) -> ()
        }) : (bf16, memref<64x128xbf16>) -> ()
        "scf.for"(%23, %27, %24) ({
        ^bb0(%arg25: index):
          %105 = "tensor.extract"(%58, %arg25) : (tensor<128xi32>, index) -> i32
          %106 = "arith.index_cast"(%105) : (i32) -> index
          %107 = "arith.muli"(%106, %91) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %108 = "arith.addi"(%89, %107) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %109 = "memref.reinterpret_cast"(%arg8, %108, %91) <{operandSegmentSizes = array<i32: 1, 1, 0, 1>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 64, 1>, static_strides = array<i64: 1, -9223372036854775808>}> : (memref<?xbf16>, index, index) -> memref<64x1xbf16, strided<[1, ?], offset: ?>>
          %110 = "memref.subview"(%109, %95) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (memref<64x1xbf16, strided<[1, ?], offset: ?>>, index) -> memref<?x1xbf16, strided<[1, ?], offset: ?>>
          %111 = "memref.subview"(%98, %arg25, %95) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 1>, static_strides = array<i64: 1, 1>}> : (memref<64x128xbf16>, index, index) -> memref<?x1xbf16, strided<[128, 1], offset: ?>>
          "memref.copy"(%110, %111) : (memref<?x1xbf16, strided<[1, ?], offset: ?>>, memref<?x1xbf16, strided<[128, 1], offset: ?>>) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %99 = "bufferization.to_tensor"(%98) <{restrict, writable}> : (memref<64x128xbf16>) -> tensor<64x128xbf16>
        %100 = "linalg.matmul"(%97, %99, %arg21) <{indexing_maps = [#map1, #map2, #map3], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg22: bf16, %arg23: bf16, %arg24: f32):
          %101 = "arith.extf"(%arg22) : (bf16) -> f32
          %102 = "arith.extf"(%arg23) : (bf16) -> f32
          %103 = "arith.mulf"(%101, %102) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          %104 = "arith.addf"(%arg24, %103) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%104) : (f32) -> ()
        }) : (tensor<128x64xbf16>, tensor<64x128xbf16>, tensor<128x128xf32>) -> tensor<128x128xf32>
        "scf.yield"(%100) : (tensor<128x128xf32>) -> ()
      }) : (index, index, index, tensor<128x128xf32>) -> tensor<128x128xf32>
      %62 = "arith.addi"(%arg17, %30) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %63:2 = "func.call"(%62, %40, %35) <{callee = @vllm.model_executor.determinism.batch_invariant._compute_pid__i32_i32_i32_c8}> : (i32, i32, i32) -> (i32, i32)
      %64 = "arith.muli"(%63#0, %28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %65 = "arith.index_cast"(%64) : (i32) -> index
      %66 = "arith.muli"(%63#1, %28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %67 = "arith.index_cast"(%66) : (i32) -> index
      %68 = "arith.index_cast"(%arg15) : (i32) -> index
      %69 = "memref.reinterpret_cast"(%arg9, %68) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xbf16>, index) -> memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>
      %70 = "tensor.empty"() : () -> tensor<128x128xbf16>
      %71 = "linalg.generic"(%61, %70) <{indexing_maps = [#map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg18: f32, %arg19: bf16):
        %86 = "arith.truncf"(%arg18) : (f32) -> bf16
        "linalg.yield"(%86) : (bf16) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xbf16>) -> tensor<128x128xbf16>
      %72 = "arith.addi"(%65, %27) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %73 = "arith.index_cast"(%arg10) : (i32) -> index
      %74 = "arith.minsi"(%72, %73) : (index, index) -> index
      %75 = "arith.maxsi"(%74, %65) : (index, index) -> index
      %76 = "arith.subi"(%75, %65) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %77 = "arith.addi"(%67, %27) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %78 = "arith.index_cast"(%arg11) : (i32) -> index
      %79 = "arith.minsi"(%77, %78) : (index, index) -> index
      %80 = "arith.maxsi"(%79, %67) : (index, index) -> index
      %81 = "arith.subi"(%80, %67) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %82 = "arith.minsi"(%76, %27) : (index, index) -> index
      %83 = "arith.minsi"(%81, %27) : (index, index) -> index
      %84 = "tensor.extract_slice"(%71, %82, %83) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<128x128xbf16>, index, index) -> tensor<?x?xbf16>
      %85 = "memref.subview"(%69, %65, %67, %82, %83) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xbf16, strided<[?, 1]>>, index, index, index, index) -> memref<?x?xbf16, strided<[?, 1], offset: ?>>
      "bufferization.materialize_in_destination"(%84, %85) <{writable}> : (tensor<?x?xbf16>, memref<?x?xbf16, strided<[?, 1], offset: ?>>) -> ()
      "scf.yield"(%62) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c128", sym_visibility = "private"}> ({
  ^bb0(%arg6: i32):
    %16 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %17 = "arith.constant"() <{value = 127 : i32}> : () -> i32
    %18 = "arith.addi"(%arg6, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %19 = "arith.divsi"(%18, %16) : (i32, i32) -> i32
    "func.return"(%19) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c64", sym_visibility = "private"}> ({
  ^bb0(%arg5: i32):
    %12 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %13 = "arith.constant"() <{value = 63 : i32}> : () -> i32
    %14 = "arith.addi"(%arg5, %13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %15 = "arith.divsi"(%14, %12) : (i32, i32) -> i32
    "func.return"(%15) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, i32) -> (i32, i32), sym_name = "vllm.model_executor.determinism.batch_invariant._compute_pid__i32_i32_i32_c8", sym_visibility = "private"}> ({
  ^bb0(%arg2: i32, %arg3: i32, %arg4: i32):
    %3 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %4 = "arith.divsi"(%arg2, %arg3) : (i32, i32) -> i32
    %5 = "arith.muli"(%4, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "arith.subi"(%arg4, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %7 = "arith.minsi"(%6, %3) : (i32, i32) -> i32
    %8 = "arith.remsi"(%arg2, %7) : (i32, i32) -> i32
    %9 = "arith.addi"(%5, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %10 = "arith.remsi"(%arg2, %arg3) : (i32, i32) -> i32
    %11 = "arith.divsi"(%10, %7) : (i32, i32) -> i32
    "func.return"(%9, %11) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<128x128xf32>, sym_name = "triton.language.standard.zeros__Tc128_c128T_cfp32", sym_visibility = "private"}> ({
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<128x128xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg0: f32, %arg1: f32):
      "linalg.yield"(%arg0) : (f32) -> ()
    }) : (f32, tensor<128x128xf32>) -> tensor<128x128xf32>
    "func.return"(%2) : (tensor<128x128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

