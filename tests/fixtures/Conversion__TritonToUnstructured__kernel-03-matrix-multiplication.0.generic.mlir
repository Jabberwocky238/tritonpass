"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, !tt.ptr<bf16>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "matmul_kernel_0123456789101112131415", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>, %arg2: !tt.ptr<bf16>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<128x256xf32>}> : () -> tensor<128x256xf32>
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 63 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 255 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 127 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %8 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %9 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %10 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %11 = "arith.addi"(%arg3, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %12 = "arith.divsi"(%11, %8) : (i32, i32) -> i32
    %13 = "arith.addi"(%arg4, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %14 = "arith.divsi"(%13, %7) : (i32, i32) -> i32
    %15 = "arith.addi"(%arg5, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %16 = "arith.divsi"(%15, %6) : (i32, i32) -> i32
    %17 = "arith.muli"(%14, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %18 = "arith.divsi"(%10, %17) : (i32, i32) -> i32
    %19 = "arith.muli"(%18, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %20 = "arith.subi"(%12, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %21 = "arith.cmpi"(%20, %9) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %22 = "arith.select"(%21, %20, %9) : (i1, i32, i32) -> i32
    %23 = "arith.remsi"(%10, %22) : (i32, i32) -> i32
    %24 = "arith.addi"(%19, %23) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %25 = "arith.remsi"(%10, %17) : (i32, i32) -> i32
    %26 = "arith.divsi"(%25, %22) : (i32, i32) -> i32
    %27 = "arith.muli"(%24, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %28 = "tt.make_range"() <{end = 128 : i32, start = 0 : i32}> : () -> tensor<128xi32>
    %29 = "tt.splat"(%27) : (i32) -> tensor<128xi32>
    %30 = "arith.addi"(%29, %28) <{overflowFlags = #arith.overflow<none>}> : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
    %31 = "arith.muli"(%26, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %32 = "tt.make_range"() <{end = 256 : i32, start = 0 : i32}> : () -> tensor<256xi32>
    %33 = "tt.splat"(%31) : (i32) -> tensor<256xi32>
    %34 = "arith.addi"(%33, %32) <{overflowFlags = #arith.overflow<none>}> : (tensor<256xi32>, tensor<256xi32>) -> tensor<256xi32>
    %35 = "tt.make_range"() <{end = 64 : i32, start = 0 : i32}> : () -> tensor<64xi32>
    %36 = "tt.expand_dims"(%30) <{axis = 1 : i32}> : (tensor<128xi32>) -> tensor<128x1xi32>
    %37 = "tt.splat"(%arg6) : (i32) -> tensor<128x1xi32>
    %38 = "arith.muli"(%36, %37) <{overflowFlags = #arith.overflow<none>}> : (tensor<128x1xi32>, tensor<128x1xi32>) -> tensor<128x1xi32>
    %39 = "tt.expand_dims"(%35) <{axis = 0 : i32}> : (tensor<64xi32>) -> tensor<1x64xi32>
    %40 = "tt.splat"(%arg7) : (i32) -> tensor<1x64xi32>
    %41 = "arith.muli"(%39, %40) <{overflowFlags = #arith.overflow<none>}> : (tensor<1x64xi32>, tensor<1x64xi32>) -> tensor<1x64xi32>
    %42 = "tt.broadcast"(%38) : (tensor<128x1xi32>) -> tensor<128x64xi32>
    %43 = "tt.broadcast"(%41) : (tensor<1x64xi32>) -> tensor<128x64xi32>
    %44 = "arith.addi"(%42, %43) <{overflowFlags = #arith.overflow<none>}> : (tensor<128x64xi32>, tensor<128x64xi32>) -> tensor<128x64xi32>
    %45 = "tt.expand_dims"(%35) <{axis = 1 : i32}> : (tensor<64xi32>) -> tensor<64x1xi32>
    %46 = "tt.splat"(%arg8) : (i32) -> tensor<64x1xi32>
    %47 = "arith.muli"(%45, %46) <{overflowFlags = #arith.overflow<none>}> : (tensor<64x1xi32>, tensor<64x1xi32>) -> tensor<64x1xi32>
    %48 = "tt.expand_dims"(%34) <{axis = 0 : i32}> : (tensor<256xi32>) -> tensor<1x256xi32>
    %49 = "tt.splat"(%arg9) : (i32) -> tensor<1x256xi32>
    %50 = "arith.muli"(%48, %49) <{overflowFlags = #arith.overflow<none>}> : (tensor<1x256xi32>, tensor<1x256xi32>) -> tensor<1x256xi32>
    %51 = "tt.broadcast"(%47) : (tensor<64x1xi32>) -> tensor<64x256xi32>
    %52 = "tt.broadcast"(%50) : (tensor<1x256xi32>) -> tensor<64x256xi32>
    %53 = "arith.addi"(%51, %52) <{overflowFlags = #arith.overflow<none>}> : (tensor<64x256xi32>, tensor<64x256xi32>) -> tensor<64x256xi32>
    %54 = "arith.muli"(%arg7, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %55 = "tt.splat"(%54) : (i32) -> tensor<128x64xi32>
    %56 = "arith.muli"(%arg8, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %57 = "tt.splat"(%56) : (i32) -> tensor<64x256xi32>
    %58:3 = "scf.for"(%1, %16, %5, %0, %44, %53) ({
    ^bb0(%arg12: i32, %arg13: tensor<128x256xf32>, %arg14: tensor<128x64xi32>, %arg15: tensor<64x256xi32>):
      %74 = "tts.gather"(%arg0, %arg14) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<bf16>, tensor<128x64xi32>) -> tensor<128x64xbf16>
      %75 = "tts.gather"(%arg1, %arg15) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<bf16>, tensor<64x256xi32>) -> tensor<64x256xbf16>
      %76 = "tt.dot"(%74, %75, %0) <{inputPrecision = 0 : i32, maxNumImpreciseAcc = 0 : i32}> : (tensor<128x64xbf16>, tensor<64x256xbf16>, tensor<128x256xf32>) -> tensor<128x256xf32>
      %77 = "arith.addf"(%arg13, %76) <{fastmath = #arith.fastmath<none>}> : (tensor<128x256xf32>, tensor<128x256xf32>) -> tensor<128x256xf32>
      %78 = "arith.addi"(%arg14, %55) <{overflowFlags = #arith.overflow<none>}> : (tensor<128x64xi32>, tensor<128x64xi32>) -> tensor<128x64xi32>
      %79 = "arith.addi"(%arg15, %57) <{overflowFlags = #arith.overflow<none>}> : (tensor<64x256xi32>, tensor<64x256xi32>) -> tensor<64x256xi32>
      "scf.yield"(%77, %78, %79) : (tensor<128x256xf32>, tensor<128x64xi32>, tensor<64x256xi32>) -> ()
    }) : (i32, i32, i32, tensor<128x256xf32>, tensor<128x64xi32>, tensor<64x256xi32>) -> (tensor<128x256xf32>, tensor<128x64xi32>, tensor<64x256xi32>)
    %59 = "arith.truncf"(%58#0) : (tensor<128x256xf32>) -> tensor<128x256xbf16>
    %60 = "tt.splat"(%arg10) : (i32) -> tensor<128x1xi32>
    %61 = "arith.muli"(%60, %36) <{overflowFlags = #arith.overflow<none>}> : (tensor<128x1xi32>, tensor<128x1xi32>) -> tensor<128x1xi32>
    %62 = "tt.splat"(%arg11) : (i32) -> tensor<1x256xi32>
    %63 = "arith.muli"(%62, %48) <{overflowFlags = #arith.overflow<none>}> : (tensor<1x256xi32>, tensor<1x256xi32>) -> tensor<1x256xi32>
    %64 = "tt.broadcast"(%61) : (tensor<128x1xi32>) -> tensor<128x256xi32>
    %65 = "tt.broadcast"(%63) : (tensor<1x256xi32>) -> tensor<128x256xi32>
    %66 = "arith.addi"(%64, %65) <{overflowFlags = #arith.overflow<none>}> : (tensor<128x256xi32>, tensor<128x256xi32>) -> tensor<128x256xi32>
    %67 = "tt.splat"(%arg3) : (i32) -> tensor<128x1xi32>
    %68 = "arith.cmpi"(%36, %67) <{predicate = 2 : i64}> : (tensor<128x1xi32>, tensor<128x1xi32>) -> tensor<128x1xi1>
    %69 = "tt.splat"(%arg4) : (i32) -> tensor<1x256xi32>
    %70 = "arith.cmpi"(%48, %69) <{predicate = 2 : i64}> : (tensor<1x256xi32>, tensor<1x256xi32>) -> tensor<1x256xi1>
    %71 = "tt.broadcast"(%68) : (tensor<128x1xi1>) -> tensor<128x256xi1>
    %72 = "tt.broadcast"(%70) : (tensor<1x256xi1>) -> tensor<128x256xi1>
    %73 = "arith.andi"(%71, %72) : (tensor<128x256xi1>, tensor<128x256xi1>) -> tensor<128x256xi1>
    "tts.scatter"(%arg2, %66, %59, %73) : (!tt.ptr<bf16>, tensor<128x256xi32>, tensor<128x256xbf16>, tensor<128x256xi1>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

