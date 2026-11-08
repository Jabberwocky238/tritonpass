#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<f16>, !tt.ptr<f16>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "fn1"}> ({
  ^bb0(%arg51: !tt.ptr<f16>, %arg52: !tt.ptr<f16>, %arg53: i32, %arg54: i32, %arg55: i32, %arg56: i32, %arg57: i32, %arg58: i32):
    %43 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %44 = "tts.make_tptr"(%arg51) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f16>) -> tensor<32x!tt.ptr<f16>>
    %45 = "tts.load"(%44) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<f16>>) -> tensor<32xf16>
    %46 = "tensor.empty"() : () -> tensor<f32>
    %47 = "linalg.fill"(%43, %46) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg70: f32, %arg71: f32):
      "linalg.yield"(%arg70) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %48 = "linalg.reduce"(%45, %47) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg68: f16, %arg69: f32):
      %63 = "arith.extf"(%arg68) : (f16) -> f32
      %64 = "arith.addf"(%63, %arg69) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%64) : (f32) -> ()
    }) : (tensor<32xf16>, tensor<f32>) -> tensor<f32>
    %49 = "tensor.extract"(%48) : (tensor<f32>) -> f32
    %50 = "arith.truncf"(%49) : (f32) -> f16
    %51 = "tensor.empty"() : () -> tensor<32xf32>
    %52 = "linalg.generic"(%45, %51) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg66: f16, %arg67: f32):
      %62 = "arith.extf"(%arg66) : (f16) -> f32
      "linalg.yield"(%62) : (f32) -> ()
    }) : (tensor<32xf16>, tensor<32xf32>) -> tensor<32xf32>
    %53 = "arith.extf"(%50) : (f16) -> f32
    %54 = "tensor.empty"() : () -> tensor<32xf32>
    %55 = "linalg.fill"(%53, %54) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg64: f32, %arg65: f32):
      "linalg.yield"(%arg64) : (f32) -> ()
    }) : (f32, tensor<32xf32>) -> tensor<32xf32>
    %56 = "linalg.generic"(%52, %55, %52) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg61: f32, %arg62: f32, %arg63: f32):
      %61 = "arith.divf"(%arg61, %arg62) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%61) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %57 = "tts.make_tptr"(%arg52) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f16>) -> tensor<32x!tt.ptr<f16>>
    %58 = "tensor.empty"() : () -> tensor<32xf16>
    %59 = "linalg.generic"(%56, %58) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg59: f32, %arg60: f16):
      %60 = "arith.truncf"(%arg59) : (f32) -> f16
      "linalg.yield"(%60) : (f16) -> ()
    }) : (tensor<32xf32>, tensor<32xf16>) -> tensor<32xf16>
    "tts.store"(%57, %59) <{static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<f16>>, tensor<32xf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!tt.ptr<f16>, !tt.ptr<f16>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "fn2"}> ({
  ^bb0(%arg34: !tt.ptr<f16>, %arg35: !tt.ptr<f16>, %arg36: i32, %arg37: i32, %arg38: i32, %arg39: i32, %arg40: i32, %arg41: i32):
    %28 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %29 = "tts.make_tptr"(%arg34) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f16>) -> tensor<32x!tt.ptr<f16>>
    %30 = "tts.load"(%29) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<f16>>) -> tensor<32xf16>
    %31 = "tensor.empty"() : () -> tensor<f32>
    %32 = "linalg.fill"(%28, %31) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg49: f32, %arg50: f32):
      "linalg.yield"(%arg49) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %33 = "linalg.reduce"(%30, %32) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg47: f16, %arg48: f32):
      %41 = "arith.extf"(%arg47) : (f16) -> f32
      %42 = "arith.addf"(%41, %arg48) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%42) : (f32) -> ()
    }) : (tensor<32xf16>, tensor<f32>) -> tensor<f32>
    %34 = "tensor.extract"(%33) : (tensor<f32>) -> f32
    %35 = "arith.truncf"(%34) : (f32) -> f16
    %36 = "tensor.empty"() : () -> tensor<32xf16>
    %37 = "linalg.fill"(%35, %36) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg45: f16, %arg46: f16):
      "linalg.yield"(%arg45) : (f16) -> ()
    }) : (f16, tensor<32xf16>) -> tensor<32xf16>
    %38 = "linalg.generic"(%30, %37, %30) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg42: f16, %arg43: f16, %arg44: f16):
      %40 = "arith.subf"(%arg42, %arg43) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
      "linalg.yield"(%40) : (f16) -> ()
    }) : (tensor<32xf16>, tensor<32xf16>, tensor<32xf16>) -> tensor<32xf16>
    %39 = "tts.make_tptr"(%arg35) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f16>) -> tensor<32x!tt.ptr<f16>>
    "tts.store"(%39, %38) <{static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<f16>>, tensor<32xf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "fn3"}> ({
  ^bb0(%arg17: !tt.ptr<bf16>, %arg18: !tt.ptr<bf16>, %arg19: i32, %arg20: i32, %arg21: i32, %arg22: i32, %arg23: i32, %arg24: i32):
    %13 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %14 = "tts.make_tptr"(%arg17) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<bf16>) -> tensor<32x!tt.ptr<bf16>>
    %15 = "tts.load"(%14) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<bf16>>) -> tensor<32xbf16>
    %16 = "tensor.empty"() : () -> tensor<f32>
    %17 = "linalg.fill"(%13, %16) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg32: f32, %arg33: f32):
      "linalg.yield"(%arg32) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %18 = "linalg.reduce"(%15, %17) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg30: bf16, %arg31: f32):
      %26 = "arith.extf"(%arg30) : (bf16) -> f32
      %27 = "arith.addf"(%26, %arg31) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%27) : (f32) -> ()
    }) : (tensor<32xbf16>, tensor<f32>) -> tensor<f32>
    %19 = "tensor.extract"(%18) : (tensor<f32>) -> f32
    %20 = "arith.truncf"(%19) : (f32) -> bf16
    %21 = "tensor.empty"() : () -> tensor<32xbf16>
    %22 = "linalg.fill"(%20, %21) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg28: bf16, %arg29: bf16):
      "linalg.yield"(%arg28) : (bf16) -> ()
    }) : (bf16, tensor<32xbf16>) -> tensor<32xbf16>
    %23 = "linalg.generic"(%15, %22, %15) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg25: bf16, %arg26: bf16, %arg27: bf16):
      %25 = "arith.subf"(%arg25, %arg26) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
      "linalg.yield"(%25) : (bf16) -> ()
    }) : (tensor<32xbf16>, tensor<32xbf16>, tensor<32xbf16>) -> tensor<32xbf16>
    %24 = "tts.make_tptr"(%arg18) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<bf16>) -> tensor<32x!tt.ptr<bf16>>
    "tts.store"(%24, %23) <{static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<bf16>>, tensor<32xbf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "fn4"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<32x!tt.ptr<f32>>
    %2 = "tts.load"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<f32>>) -> tensor<32xf32>
    %3 = "tensor.empty"() : () -> tensor<f32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %5 = "linalg.reduce"(%2, %4) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      %12 = "arith.addf"(%arg13, %arg14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%12) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<f32>) -> tensor<f32>
    %6 = "tensor.extract"(%5) : (tensor<f32>) -> f32
    %7 = "tensor.empty"() : () -> tensor<32xf32>
    %8 = "linalg.fill"(%6, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      "linalg.yield"(%arg11) : (f32) -> ()
    }) : (f32, tensor<32xf32>) -> tensor<32xf32>
    %9 = "linalg.generic"(%2, %8, %2) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32, %arg10: f32):
      %11 = "arith.subf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%11) : (f32) -> ()
    }) : (tensor<32xf32>, tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %10 = "tts.make_tptr"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 32>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<32x!tt.ptr<f32>>
    "tts.store"(%10, %9) <{static_mask_dims = array<i64>}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

