"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, !tt.ptr<bf16>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "matmul_kernel_0123456789101112131415", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>, %arg2: !tt.ptr<bf16>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32):
    %0 = "arith.constant"() <{value = 256 : index}> : () -> index
    %1 = "arith.constant"() <{value = 128 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<128x256xf32>}> : () -> tensor<128x256xf32>
    %4 = "arith.constant"() <{value = 63 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 255 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 127 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %8 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %9 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %10 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %11 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %12 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %13 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %14 = "arith.addi"(%arg3, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %15 = "arith.divsi"(%14, %11) : (i32, i32) -> i32
    %16 = "arith.addi"(%arg4, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %17 = "arith.divsi"(%16, %10) : (i32, i32) -> i32
    %18 = "arith.addi"(%arg5, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %19 = "arith.divsi"(%18, %9) : (i32, i32) -> i32
    %20 = "arith.muli"(%17, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %21 = "arith.divsi"(%13, %20) : (i32, i32) -> i32
    %22 = "arith.muli"(%21, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %23 = "arith.subi"(%15, %22) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %24 = "arith.cmpi"(%23, %12) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %25 = "arith.select"(%24, %23, %12) : (i1, i32, i32) -> i32
    %26 = "arith.remsi"(%13, %25) : (i32, i32) -> i32
    %27 = "arith.addi"(%22, %26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %28 = "arith.remsi"(%13, %20) : (i32, i32) -> i32
    %29 = "arith.divsi"(%28, %25) : (i32, i32) -> i32
    %30 = "arith.muli"(%27, %11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %31 = "arith.index_cast"(%30) : (i32) -> index
    %32 = "arith.index_cast"(%30) : (i32) -> index
    %33 = "arith.muli"(%29, %10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %34 = "arith.index_cast"(%33) : (i32) -> index
    %35 = "arith.index_cast"(%33) : (i32) -> index
    %36 = "arith.index_cast"(%arg6) : (i32) -> index
    %37 = "arith.muli"(%32, %36) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %38 = "arith.index_cast"(%arg7) : (i32) -> index
    %39 = "arith.index_cast"(%arg8) : (i32) -> index
    %40 = "arith.index_cast"(%arg9) : (i32) -> index
    %41 = "arith.muli"(%35, %40) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %42 = "arith.muli"(%arg7, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %43 = "arith.index_cast"(%42) : (i32) -> index
    %44 = "arith.muli"(%arg8, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %45 = "arith.index_cast"(%44) : (i32) -> index
    %46:3 = "scf.for"(%8, %19, %7, %3, %37, %2) ({
    ^bb0(%arg12: i32, %arg13: tensor<128x256xf32>, %arg14: index, %arg15: index):
      %67 = "tts.make_tptr"(%arg1, %39, %40, %arg15, %41) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 64, 256>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index, index, index) -> tensor<64x256x!tt.ptr<bf16>>
      %68 = "tts.make_tptr"(%arg0, %36, %38, %arg14, %2) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 128, 64>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index, index, index) -> tensor<128x64x!tt.ptr<bf16>>
      %69 = "tts.load"(%68) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<128x64x!tt.ptr<bf16>>) -> tensor<128x64xbf16>
      %70 = "tts.load"(%67) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<64x256x!tt.ptr<bf16>>) -> tensor<64x256xbf16>
      %71 = "tt.dot"(%69, %70, %3) <{inputPrecision = 0 : i32, maxNumImpreciseAcc = 0 : i32}> : (tensor<128x64xbf16>, tensor<64x256xbf16>, tensor<128x256xf32>) -> tensor<128x256xf32>
      %72 = "arith.addf"(%arg13, %71) <{fastmath = #arith.fastmath<none>}> : (tensor<128x256xf32>, tensor<128x256xf32>) -> tensor<128x256xf32>
      %73 = "arith.addi"(%arg14, %43) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %74 = "arith.addi"(%arg15, %45) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%72, %73, %74) : (tensor<128x256xf32>, index, index) -> ()
    }) : (i32, i32, i32, tensor<128x256xf32>, index, index) -> (tensor<128x256xf32>, index, index)
    %47 = "arith.truncf"(%46#0) : (tensor<128x256xf32>) -> tensor<128x256xbf16>
    %48 = "arith.index_cast"(%arg10) : (i32) -> index
    %49 = "arith.muli"(%31, %48) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %50 = "arith.index_cast"(%arg11) : (i32) -> index
    %51 = "arith.muli"(%34, %50) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %52 = "tts.make_tptr"(%arg2, %48, %50, %49, %51) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 128, 256>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<bf16>, index, index, index, index) -> tensor<128x256x!tt.ptr<bf16>>
    %53 = "arith.index_cast"(%30) : (i32) -> index
    %54 = "arith.addi"(%53, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %55 = "arith.index_cast"(%arg3) : (i32) -> index
    %56 = "arith.minsi"(%54, %55) : (index, index) -> index
    %57 = "arith.maxsi"(%56, %53) : (index, index) -> index
    %58 = "arith.subi"(%57, %53) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %59 = "arith.index_cast"(%33) : (i32) -> index
    %60 = "arith.addi"(%59, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %61 = "arith.index_cast"(%arg4) : (i32) -> index
    %62 = "arith.minsi"(%60, %61) : (index, index) -> index
    %63 = "arith.maxsi"(%62, %59) : (index, index) -> index
    %64 = "arith.subi"(%63, %59) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %65 = "arith.minsi"(%58, %1) : (index, index) -> index
    %66 = "arith.minsi"(%64, %0) : (index, index) -> index
    "tts.store"(%52, %47, %65, %66) <{static_mask_dims = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<128x256x!tt.ptr<bf16>>, tensor<128x256xbf16>, index, index) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

