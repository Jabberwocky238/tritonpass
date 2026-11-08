"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, i32, i32, f32) -> (), sym_name = "_layer_norm_fwd_fused_0123456789", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<f32>, %arg3: !tt.ptr<f32>, %arg4: !tt.ptr<f32>, %arg5: !tt.ptr<f32>, %arg6: i32, %arg7: i32, %arg8: f32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 256 : index}> : () -> index
    %2 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<256xf32>}> : () -> tensor<256xf32>
    %3 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %6 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %7 = "arith.muli"(%6, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %8 = "arith.index_cast"(%7) : (i32) -> index
    %9 = "arith.index_cast"(%7) : (i32) -> index
    %10 = "scf.for"(%4, %arg7, %3, %2) ({
    ^bb0(%arg16: i32, %arg17: tensor<256xf32>):
      %87 = "arith.index_cast"(%arg16) : (i32) -> index
      %88 = "arith.addi"(%8, %87) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %89 = "tts.make_tptr"(%arg0, %88) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 256>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<256x!tt.ptr<f32>>
      %90 = "arith.index_cast"(%arg16) : (i32) -> index
      %91 = "arith.addi"(%90, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %92 = "arith.index_cast"(%arg7) : (i32) -> index
      %93 = "arith.minsi"(%91, %92) : (index, index) -> index
      %94 = "arith.maxsi"(%93, %90) : (index, index) -> index
      %95 = "arith.subi"(%94, %90) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %96 = "tts.load"(%89, %95, %0) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<256x!tt.ptr<f32>>, index, f32) -> tensor<256xf32>
      %97 = "arith.addf"(%arg17, %96) <{fastmath = #arith.fastmath<none>}> : (tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      "scf.yield"(%97) : (tensor<256xf32>) -> ()
    }) : (i32, i32, i32, tensor<256xf32>) -> tensor<256xf32>
    %11 = "tt.reduce"(%10) <{axis = 0 : i32}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      %86 = "arith.addf"(%arg14, %arg15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "tt.reduce.return"(%86) : (f32) -> ()
    }) : (tensor<256xf32>) -> f32
    %12 = "arith.sitofp"(%arg7) : (i32) -> f32
    %13 = "arith.divf"(%11, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %14 = "tt.make_range"() <{end = 256 : i32, start = 0 : i32}> : () -> tensor<256xi32>
    %15 = "tt.splat"(%arg7) : (i32) -> tensor<256xi32>
    %16 = "tt.splat"(%13) : (f32) -> tensor<256xf32>
    %17 = "scf.for"(%4, %arg7, %3, %2) ({
    ^bb0(%arg12: i32, %arg13: tensor<256xf32>):
      %69 = "tt.splat"(%arg12) : (i32) -> tensor<256xi32>
      %70 = "arith.addi"(%69, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<256xi32>, tensor<256xi32>) -> tensor<256xi32>
      %71 = "arith.cmpi"(%70, %15) <{predicate = 2 : i64}> : (tensor<256xi32>, tensor<256xi32>) -> tensor<256xi1>
      %72 = "arith.index_cast"(%arg12) : (i32) -> index
      %73 = "arith.addi"(%8, %72) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %74 = "tts.make_tptr"(%arg0, %73) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 256>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<256x!tt.ptr<f32>>
      %75 = "arith.index_cast"(%arg12) : (i32) -> index
      %76 = "arith.addi"(%75, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %77 = "arith.index_cast"(%arg7) : (i32) -> index
      %78 = "arith.minsi"(%76, %77) : (index, index) -> index
      %79 = "arith.maxsi"(%78, %75) : (index, index) -> index
      %80 = "arith.subi"(%79, %75) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %81 = "tts.load"(%74, %80, %0) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<256x!tt.ptr<f32>>, index, f32) -> tensor<256xf32>
      %82 = "arith.subf"(%81, %16) <{fastmath = #arith.fastmath<none>}> : (tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      %83 = "arith.select"(%71, %82, %2) : (tensor<256xi1>, tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      %84 = "arith.mulf"(%83, %83) <{fastmath = #arith.fastmath<none>}> : (tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      %85 = "arith.addf"(%arg13, %84) <{fastmath = #arith.fastmath<none>}> : (tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      "scf.yield"(%85) : (tensor<256xf32>) -> ()
    }) : (i32, i32, i32, tensor<256xf32>) -> tensor<256xf32>
    %18 = "tt.reduce"(%17) <{axis = 0 : i32}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      %68 = "arith.addf"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "tt.reduce.return"(%68) : (f32) -> ()
    }) : (tensor<256xf32>) -> f32
    %19 = "arith.divf"(%18, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %20 = "arith.addf"(%19, %arg8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %21 = "math.sqrt"(%20) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %22 = "arith.divf"(%5, %21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %23 = "tt.addptr"(%arg4, %6) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
    "tt.store"(%23, %13) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
    %24 = "tt.addptr"(%arg5, %6) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
    "tt.store"(%24, %22) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
    %25 = "tt.splat"(%13) : (f32) -> tensor<256xf32>
    %26 = "tt.splat"(%22) : (f32) -> tensor<256xf32>
    "scf.for"(%4, %arg7, %3) ({
    ^bb0(%arg9: i32):
      %27 = "arith.index_cast"(%arg9) : (i32) -> index
      %28 = "tts.make_tptr"(%arg2, %27) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 256>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<256x!tt.ptr<f32>>
      %29 = "arith.index_cast"(%arg9) : (i32) -> index
      %30 = "arith.addi"(%29, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %31 = "arith.index_cast"(%arg7) : (i32) -> index
      %32 = "arith.minsi"(%30, %31) : (index, index) -> index
      %33 = "arith.maxsi"(%32, %29) : (index, index) -> index
      %34 = "arith.subi"(%33, %29) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %35 = "tts.load"(%28, %34) <{operandSegmentSizes = array<i32: 1, 1, 0>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<256x!tt.ptr<f32>>, index) -> tensor<256xf32>
      %36 = "arith.index_cast"(%arg9) : (i32) -> index
      %37 = "tts.make_tptr"(%arg3, %36) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 256>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<256x!tt.ptr<f32>>
      %38 = "arith.index_cast"(%arg9) : (i32) -> index
      %39 = "arith.addi"(%38, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "arith.index_cast"(%arg7) : (i32) -> index
      %41 = "arith.minsi"(%39, %40) : (index, index) -> index
      %42 = "arith.maxsi"(%41, %38) : (index, index) -> index
      %43 = "arith.subi"(%42, %38) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %44 = "tts.load"(%37, %43) <{operandSegmentSizes = array<i32: 1, 1, 0>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<256x!tt.ptr<f32>>, index) -> tensor<256xf32>
      %45 = "arith.index_cast"(%arg9) : (i32) -> index
      %46 = "arith.addi"(%8, %45) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %47 = "tts.make_tptr"(%arg0, %46) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 256>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<256x!tt.ptr<f32>>
      %48 = "arith.index_cast"(%arg9) : (i32) -> index
      %49 = "arith.addi"(%48, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %50 = "arith.index_cast"(%arg7) : (i32) -> index
      %51 = "arith.minsi"(%49, %50) : (index, index) -> index
      %52 = "arith.maxsi"(%51, %48) : (index, index) -> index
      %53 = "arith.subi"(%52, %48) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %54 = "tts.load"(%47, %53, %0) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<256x!tt.ptr<f32>>, index, f32) -> tensor<256xf32>
      %55 = "arith.subf"(%54, %25) <{fastmath = #arith.fastmath<none>}> : (tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      %56 = "arith.mulf"(%55, %26) <{fastmath = #arith.fastmath<none>}> : (tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      %57 = "arith.mulf"(%56, %35) <{fastmath = #arith.fastmath<none>}> : (tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      %58 = "arith.addf"(%57, %44) <{fastmath = #arith.fastmath<none>}> : (tensor<256xf32>, tensor<256xf32>) -> tensor<256xf32>
      %59 = "arith.index_cast"(%arg9) : (i32) -> index
      %60 = "arith.addi"(%9, %59) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %61 = "tts.make_tptr"(%arg1, %60) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 256>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<256x!tt.ptr<f32>>
      %62 = "arith.index_cast"(%arg9) : (i32) -> index
      %63 = "arith.addi"(%62, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %64 = "arith.index_cast"(%arg7) : (i32) -> index
      %65 = "arith.minsi"(%63, %64) : (index, index) -> index
      %66 = "arith.maxsi"(%65, %62) : (index, index) -> index
      %67 = "arith.subi"(%66, %62) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "tts.store"(%61, %58, %67) <{static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<256x!tt.ptr<f32>>, tensor<256xf32>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (i32, i32, i32) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

