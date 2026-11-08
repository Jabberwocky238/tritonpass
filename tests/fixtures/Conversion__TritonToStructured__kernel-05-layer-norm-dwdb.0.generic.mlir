"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, i32, i32) -> (), sym_name = "_layer_norm_bwd_dwdb_0123456", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<f32>, %arg3: !tt.ptr<f32>, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 256 : index}> : () -> index
    %2 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<256x256xf32>}> : () -> tensor<256x256xf32>
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %5 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %6 = "arith.muli"(%5, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %7 = "arith.index_cast"(%6) : (i32) -> index
    %8 = "arith.index_cast"(%6) : (i32) -> index
    %9 = "arith.index_cast"(%6) : (i32) -> index
    %10 = "arith.index_cast"(%6) : (i32) -> index
    %11:2 = "scf.for"(%3, %arg4, %4, %2, %2) ({
    ^bb0(%arg10: i32, %arg11: tensor<256x256xf32>, %arg12: tensor<256x256xf32>):
      %30 = "arith.index_cast"(%arg10) : (i32) -> index
      %31 = "arith.index_cast"(%arg5) : (i32) -> index
      %32 = "arith.muli"(%30, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %33 = "tts.make_tptr"(%arg0, %31, %32, %10) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, order = array<i32>, sizes = array<i64: 256, 256>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, index, index, index) -> tensor<256x256x!tt.ptr<f32>>
      %34 = "arith.index_cast"(%arg10) : (i32) -> index
      %35 = "arith.addi"(%34, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %36 = "arith.index_cast"(%arg4) : (i32) -> index
      %37 = "arith.minsi"(%35, %36) : (index, index) -> index
      %38 = "arith.maxsi"(%37, %34) : (index, index) -> index
      %39 = "arith.subi"(%38, %34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "arith.index_cast"(%6) : (i32) -> index
      %41 = "arith.addi"(%40, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %42 = "arith.index_cast"(%arg5) : (i32) -> index
      %43 = "arith.minsi"(%41, %42) : (index, index) -> index
      %44 = "arith.maxsi"(%43, %40) : (index, index) -> index
      %45 = "arith.subi"(%44, %40) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %46 = "arith.minsi"(%39, %1) : (index, index) -> index
      %47 = "arith.minsi"(%45, %1) : (index, index) -> index
      %48 = "tts.load"(%33, %46, %47, %0) <{operandSegmentSizes = array<i32: 1, 2, 1>, static_mask_dims = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<256x256x!tt.ptr<f32>>, index, index, f32) -> tensor<256x256xf32>
      %49 = "arith.addf"(%arg11, %48) <{fastmath = #arith.fastmath<none>}> : (tensor<256x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
      %50 = "arith.index_cast"(%arg10) : (i32) -> index
      %51 = "arith.index_cast"(%arg5) : (i32) -> index
      %52 = "arith.muli"(%50, %51) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %53 = "tts.make_tptr"(%arg1, %51, %52, %9) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, order = array<i32>, sizes = array<i64: 256, 256>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, 1>}> : (!tt.ptr<f32>, index, index, index) -> tensor<256x256x!tt.ptr<f32>>
      %54 = "arith.index_cast"(%arg10) : (i32) -> index
      %55 = "arith.addi"(%54, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %56 = "arith.index_cast"(%arg4) : (i32) -> index
      %57 = "arith.minsi"(%55, %56) : (index, index) -> index
      %58 = "arith.maxsi"(%57, %54) : (index, index) -> index
      %59 = "arith.subi"(%58, %54) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %60 = "arith.index_cast"(%6) : (i32) -> index
      %61 = "arith.addi"(%60, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %62 = "arith.index_cast"(%arg5) : (i32) -> index
      %63 = "arith.minsi"(%61, %62) : (index, index) -> index
      %64 = "arith.maxsi"(%63, %60) : (index, index) -> index
      %65 = "arith.subi"(%64, %60) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %66 = "arith.minsi"(%59, %1) : (index, index) -> index
      %67 = "arith.minsi"(%65, %1) : (index, index) -> index
      %68 = "tts.load"(%53, %66, %67, %0) <{operandSegmentSizes = array<i32: 1, 2, 1>, static_mask_dims = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<256x256x!tt.ptr<f32>>, index, index, f32) -> tensor<256x256xf32>
      %69 = "arith.addf"(%arg12, %68) <{fastmath = #arith.fastmath<none>}> : (tensor<256x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
      "scf.yield"(%49, %69) : (tensor<256x256xf32>, tensor<256x256xf32>) -> ()
    }) : (i32, i32, i32, tensor<256x256xf32>, tensor<256x256xf32>) -> (tensor<256x256xf32>, tensor<256x256xf32>)
    %12 = "tt.reduce"(%11#0) <{axis = 0 : i32}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      %29 = "arith.addf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "tt.reduce.return"(%29) : (f32) -> ()
    }) : (tensor<256x256xf32>) -> tensor<256xf32>
    %13 = "tt.reduce"(%11#1) <{axis = 0 : i32}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      %28 = "arith.addf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "tt.reduce.return"(%28) : (f32) -> ()
    }) : (tensor<256x256xf32>) -> tensor<256xf32>
    %14 = "tts.make_tptr"(%arg2, %8) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 256>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<256x!tt.ptr<f32>>
    %15 = "arith.index_cast"(%6) : (i32) -> index
    %16 = "arith.addi"(%15, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %17 = "arith.index_cast"(%arg5) : (i32) -> index
    %18 = "arith.minsi"(%16, %17) : (index, index) -> index
    %19 = "arith.maxsi"(%18, %15) : (index, index) -> index
    %20 = "arith.subi"(%19, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "tts.store"(%14, %12, %20) <{static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<256x!tt.ptr<f32>>, tensor<256xf32>, index) -> ()
    %21 = "tts.make_tptr"(%arg3, %7) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 256>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<256x!tt.ptr<f32>>
    %22 = "arith.index_cast"(%6) : (i32) -> index
    %23 = "arith.addi"(%22, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %24 = "arith.index_cast"(%arg5) : (i32) -> index
    %25 = "arith.minsi"(%23, %24) : (index, index) -> index
    %26 = "arith.maxsi"(%25, %22) : (index, index) -> index
    %27 = "arith.subi"(%26, %22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "tts.store"(%21, %13, %27) <{static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<256x!tt.ptr<f32>>, tensor<256xf32>, index) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

