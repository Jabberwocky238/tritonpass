#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xbf16>, memref<?xf32>, memref<?xi32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "_fwd_kernel_stage2"}> ({
  ^bb0(%arg3: memref<?xf32>, %arg4: memref<?xbf16>, %arg5: memref<?xf32>, %arg6: memref<?xi32>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32):
    %7 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %8 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %9 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %10 = "arith.constant"() <{value = 0 : index}> : () -> index
    %11 = "arith.constant"() <{value = 8 : index}> : () -> index
    %12 = "arith.constant"() <{value = 1 : index}> : () -> index
    %13 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %14 = "arith.index_cast"(%13) : (index) -> i32
    %15 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %16 = "arith.index_cast"(%15) : (index) -> i32
    %17 = "memref.reinterpret_cast"(%arg6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %18 = "memref.load"(%17, %13) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %19 = "func.call"() <{callee = @triton.language.standard.zeros__Tc128T_cfp32}> : () -> tensor<128xf32>
    %20 = "arith.muli"(%14, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %21 = "arith.muli"(%16, %arg8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %22 = "arith.addi"(%20, %21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %23 = "arith.index_cast"(%22) : (i32) -> index
    %24 = "arith.addi"(%22, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %25:3 = "scf.for"(%10, %11, %12, %8, %9, %19) ({
    ^bb0(%arg22: index, %arg23: f32, %arg24: f32, %arg25: tensor<128xf32>):
      %47 = "arith.index_cast"(%arg22) : (index) -> i32
      %48 = "func.call"(%18) <{callee = @triton.language.standard.cdiv__i32_c8}> : (i32) -> i32
      %49 = "arith.muli"(%48, %47) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %50 = "arith.addi"(%49, %48) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %51 = "arith.minsi"(%50, %18) : (i32, i32) -> i32
      %52 = "arith.cmpi"(%51, %49) <{predicate = 4 : i64}> : (i32, i32) -> i1
      %53:3 = "scf.if"(%52) ({
        %54 = "arith.muli"(%47, %arg9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %55 = "arith.index_cast"(%54) : (i32) -> index
        %56 = "arith.addi"(%23, %55) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %57 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32>
        %58 = "memref.subview"(%arg3, %56) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<128xf32, strided<[1], offset: ?>>
        "linalg.copy"(%58, %57) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg39: f32, %arg40: f32):
          "linalg.yield"(%arg39) : (f32) -> ()
        }) : (memref<128xf32, strided<[1], offset: ?>>, memref<128xf32>) -> ()
        %59 = "bufferization.to_tensor"(%57) <{restrict, writable}> : (memref<128xf32>) -> tensor<128xf32>
        %60 = "arith.addi"(%24, %54) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %61 = "arith.index_cast"(%60) : (i32) -> index
        %62 = "memref.reinterpret_cast"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<1099511627776xf32, strided<[1]>>
        %63 = "memref.load"(%62, %61) <{nontemporal = false}> : (memref<1099511627776xf32, strided<[1]>>, index) -> f32
        %64 = "arith.maxnumf"(%63, %arg24) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %65 = "arith.subf"(%arg24, %64) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %66 = "math.exp"(%65) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        %67 = "tensor.empty"() : () -> tensor<128xf32>
        %68 = "linalg.fill"(%66, %67) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg37: f32, %arg38: f32):
          "linalg.yield"(%arg37) : (f32) -> ()
        }) : (f32, tensor<128xf32>) -> tensor<128xf32>
        %69 = "linalg.generic"(%arg25, %68, %arg25) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg34: f32, %arg35: f32, %arg36: f32):
          %79 = "arith.mulf"(%arg34, %arg35) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%79) : (f32) -> ()
        }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
        %70 = "arith.subf"(%63, %64) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %71 = "math.exp"(%70) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        %72 = "linalg.fill"(%71, %67) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg32: f32, %arg33: f32):
          "linalg.yield"(%arg32) : (f32) -> ()
        }) : (f32, tensor<128xf32>) -> tensor<128xf32>
        %73 = "linalg.generic"(%72, %59, %72) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg29: f32, %arg30: f32, %arg31: f32):
          %78 = "arith.mulf"(%arg29, %arg30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%78) : (f32) -> ()
        }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
        %74 = "linalg.generic"(%69, %73, %69) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg26: f32, %arg27: f32, %arg28: f32):
          %77 = "arith.addf"(%arg26, %arg27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%77) : (f32) -> ()
        }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
        %75 = "arith.mulf"(%arg23, %66) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %76 = "arith.addf"(%75, %71) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "scf.yield"(%76, %64, %74) : (f32, f32, tensor<128xf32>) -> ()
      }, {
        "scf.yield"(%arg23, %arg24, %arg25) : (f32, f32, tensor<128xf32>) -> ()
      }) : (i1) -> (f32, f32, tensor<128xf32>)
      "scf.yield"(%53#0, %53#1, %53#2) : (f32, f32, tensor<128xf32>) -> ()
    }) : (index, index, index, f32, f32, tensor<128xf32>) -> (f32, f32, tensor<128xf32>)
    %26 = "tensor.empty"() : () -> tensor<128xf32>
    %27 = "linalg.fill"(%25#0, %26) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: f32, %arg21: f32):
      "linalg.yield"(%arg20) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %28 = "linalg.generic"(%25#2, %27, %25#2) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg17: f32, %arg18: f32, %arg19: f32):
      %46 = "arith.divf"(%arg17, %arg18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%46) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %29 = "arith.muli"(%14, %arg10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %30 = "arith.index_cast"(%29) : (i32) -> index
    %31 = "arith.muli"(%16, %arg11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %32 = "arith.index_cast"(%31) : (i32) -> index
    %33 = "tensor.empty"() : () -> tensor<128xbf16>
    %34 = "linalg.generic"(%28, %33) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: bf16):
      %45 = "arith.truncf"(%arg15) : (f32) -> bf16
      "linalg.yield"(%45) : (bf16) -> ()
    }) : (tensor<128xf32>, tensor<128xbf16>) -> tensor<128xbf16>
    %35 = "arith.addi"(%30, %32) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %36 = "memref.subview"(%arg4, %35) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index) -> memref<128xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%34, %36) <{writable}> : (tensor<128xbf16>, memref<128xbf16, strided<[1], offset: ?>>) -> ()
    %37 = "math.log"(%25#0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %38 = "arith.addf"(%25#1, %37) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %39 = "arith.muli"(%14, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %40 = "arith.index_cast"(%39) : (i32) -> index
    %41 = "tensor.empty"() : () -> tensor<1xf32>
    %42 = "linalg.fill"(%38, %41) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      "linalg.yield"(%arg13) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %43 = "arith.addi"(%40, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %44 = "memref.subview"(%arg5, %43) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%42, %44) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<128xf32>, sym_name = "triton.language.standard.zeros__Tc128T_cfp32", sym_visibility = "private"}> ({
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "tensor.empty"() : () -> tensor<128xf32>
    %6 = "linalg.fill"(%4, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    "func.return"(%6) : (tensor<128xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "triton.language.standard.cdiv__i32_c8", sym_visibility = "private"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %2 = "arith.addi"(%arg0, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %3 = "arith.divsi"(%2, %0) : (i32, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

