"builtin.module"() ({
  "tt.func"() <{arg_attrs = [{tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}], function_type = (!tt.ptr<f8E4M3FN>, !tt.ptr<bf16>, !tt.ptr<f32>, i32) -> (), sym_name = "scalar_mask_loop", sym_visibility = "public"}> ({
  ^bb0(%arg18: !tt.ptr<f8E4M3FN>, %arg19: !tt.ptr<bf16>, %arg20: !tt.ptr<f32>, %arg21: i32):
    %40 = "arith.constant"() <{value = 1 : index}> : () -> index
    %41 = "arith.constant"() <{value = 0 : index}> : () -> index
    %42 = "arith.constant"() <{value = dense<4.480000e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %43 = "arith.constant"() <{value = dense<-4.480000e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %44 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %45 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %46 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %47 = "arith.index_cast"(%46) : (i32) -> index
    %48 = "tt.get_num_programs"() <{axis = 0 : i32}> : () -> i32
    %49 = "arith.index_cast"(%48) : (i32) -> index
    %50 = "arith.addi"(%arg21, %48) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %51 = "arith.subi"(%50, %44) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %52 = "arith.divsi"(%51, %48) : (i32, i32) -> i32
    %53 = "tt.load"(%arg20) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<f32>) -> f32
    %54 = "scf.for"(%45, %52, %44, %47) ({
    ^bb0(%arg22: i32, %arg23: index):
      %55 = "tts.make_tptr"(%arg19, %41, %arg23) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 1>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<bf16>, index, index) -> tensor<1x!tt.ptr<bf16>>
      %56 = "arith.index_cast"(%arg21) : (i32) -> index
      %57 = "arith.cmpi"(%arg23, %56) <{predicate = 2 : i64}> : (index, index) -> i1
      %58 = "arith.select"(%57, %40, %41) : (i1, index, index) -> index
      %59 = "tts.load"(%55, %58) <{operandSegmentSizes = array<i32: 1, 1, 0>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<1x!tt.ptr<bf16>>, index) -> tensor<1xbf16>
      %60 = "arith.extf"(%59) : (tensor<1xbf16>) -> tensor<1xf32>
      %61 = "tt.splat"(%53) : (f32) -> tensor<1xf32>
      %62 = "arith.mulf"(%60, %61) <{fastmath = #arith.fastmath<none>}> : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
      %63 = "tt.clampf"(%62, %43, %42) <{propagateNan = 0 : i32}> : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
      %64 = "tt.fp_to_fp"(%63) <{rounding = 1 : i32}> : (tensor<1xf32>) -> tensor<1xf8E4M3FN>
      %65 = "tts.make_tptr"(%arg18, %41, %arg23) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 1>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<f8E4M3FN>, index, index) -> tensor<1x!tt.ptr<f8E4M3FN>>
      "tts.store"(%65, %64, %58) <{static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<1x!tt.ptr<f8E4M3FN>>, tensor<1xf8E4M3FN>, index) -> ()
      %66 = "arith.addi"(%arg23, %49) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%66) : (index) -> ()
    }) : (i32, i32, i32, index) -> index
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32) -> (), sym_name = "constant_zero_singleton_mask_loop", sym_visibility = "public"}> ({
  ^bb0(%arg12: !tt.ptr<f32>, %arg13: !tt.ptr<f32>, %arg14: i32, %arg15: i32):
    %28 = "arith.constant"() <{value = 1 : index}> : () -> index
    %29 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %30 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %31 = "arith.constant"() <{value = 0 : index}> : () -> index
    %32 = "scf.for"(%29, %arg15, %30, %31) ({
    ^bb0(%arg16: i32, %arg17: index):
      %33 = "tts.make_tptr"(%arg12, %31, %arg17) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 1>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<f32>, index, index) -> tensor<1x!tt.ptr<f32>>
      %34 = "arith.index_cast"(%arg14) : (i32) -> index
      %35 = "arith.cmpi"(%arg17, %34) <{predicate = 2 : i64}> : (index, index) -> i1
      %36 = "arith.select"(%35, %28, %31) : (i1, index, index) -> index
      %37 = "tts.load"(%33, %36) <{operandSegmentSizes = array<i32: 1, 1, 0>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<1x!tt.ptr<f32>>, index) -> tensor<1xf32>
      %38 = "tts.make_tptr"(%arg13, %31, %arg17) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 1>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<f32>, index, index) -> tensor<1x!tt.ptr<f32>>
      "tts.store"(%38, %37, %36) <{static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<1x!tt.ptr<f32>>, tensor<1xf32>, index) -> ()
      %39 = "arith.addi"(%arg17, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%39) : (index) -> ()
    }) : (i32, i32, i32, index) -> index
    "tt.return"() : () -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32) -> (), sym_name = "constant_two_singleton_mask_loop", sym_visibility = "public"}> ({
  ^bb0(%arg6: !tt.ptr<f32>, %arg7: !tt.ptr<f32>, %arg8: i32, %arg9: i32):
    %15 = "arith.constant"() <{value = 1 : index}> : () -> index
    %16 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %17 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %18 = "arith.constant"() <{value = 2 : index}> : () -> index
    %19 = "arith.constant"() <{value = 0 : index}> : () -> index
    %20 = "scf.for"(%16, %arg9, %17, %18) ({
    ^bb0(%arg10: i32, %arg11: index):
      %21 = "tts.make_tptr"(%arg6, %19, %arg11) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 1>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<f32>, index, index) -> tensor<1x!tt.ptr<f32>>
      %22 = "arith.index_cast"(%arg8) : (i32) -> index
      %23 = "arith.cmpi"(%arg11, %22) <{predicate = 2 : i64}> : (index, index) -> i1
      %24 = "arith.select"(%23, %15, %19) : (i1, index, index) -> index
      %25 = "tts.load"(%21, %24) <{operandSegmentSizes = array<i32: 1, 1, 0>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<1x!tt.ptr<f32>>, index) -> tensor<1xf32>
      %26 = "tts.make_tptr"(%arg7, %19, %arg11) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, order = array<i32>, sizes = array<i64: 1>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: -9223372036854775808>}> : (!tt.ptr<f32>, index, index) -> tensor<1x!tt.ptr<f32>>
      "tts.store"(%26, %25, %24) <{static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<1x!tt.ptr<f32>>, tensor<1xf32>, index) -> ()
      %27 = "arith.addi"(%arg11, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%27) : (index) -> ()
    }) : (i32, i32, i32, index) -> index
    "tt.return"() : () -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32) -> (), sym_name = "expanded_scalar_singleton_mask_fallback", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = dense<1> : tensor<1x1xi32>}> : () -> tensor<1x1xi32>
    %3 = "arith.constant"() <{value = dense<-9.000000e+00> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %4 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %5 = "tt.splat"(%4) : (i32) -> tensor<1x1xi32>
    %6 = "scf.for"(%0, %arg3, %1, %5) ({
    ^bb0(%arg4: i32, %arg5: tensor<1x1xi32>):
      %7 = "tt.splat"(%arg2) : (i32) -> tensor<1x1xi32>
      %8 = "arith.cmpi"(%arg5, %7) <{predicate = 2 : i64}> : (tensor<1x1xi32>, tensor<1x1xi32>) -> tensor<1x1xi1>
      %9 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<1x1x!tt.ptr<f32>>
      %10 = "tt.addptr"(%9, %arg5) : (tensor<1x1x!tt.ptr<f32>>, tensor<1x1xi32>) -> tensor<1x1x!tt.ptr<f32>>
      %11 = "tt.load"(%10, %8, %3) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<1x1x!tt.ptr<f32>>, tensor<1x1xi1>, tensor<1x1xf32>) -> tensor<1x1xf32>
      %12 = "tt.splat"(%arg1) : (!tt.ptr<f32>) -> tensor<1x1x!tt.ptr<f32>>
      %13 = "tt.addptr"(%12, %arg5) : (tensor<1x1x!tt.ptr<f32>>, tensor<1x1xi32>) -> tensor<1x1x!tt.ptr<f32>>
      "tt.store"(%13, %11, %8) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<1x1x!tt.ptr<f32>>, tensor<1x1xf32>, tensor<1x1xi1>) -> ()
      %14 = "arith.addi"(%arg5, %2) <{overflowFlags = #arith.overflow<none>}> : (tensor<1x1xi32>, tensor<1x1xi32>) -> tensor<1x1xi32>
      "scf.yield"(%14) : (tensor<1x1xi32>) -> ()
    }) : (i32, i32, i32, tensor<1x1xi32>) -> tensor<1x1xi32>
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

