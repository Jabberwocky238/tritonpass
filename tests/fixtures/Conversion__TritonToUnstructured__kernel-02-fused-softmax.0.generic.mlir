"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32) -> (), sym_name = "softmax_kernel_012345", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32):
    %0 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %1 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %2 = "arith.muli"(%1, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %3 = "tt.make_range"() <{end = 128 : i32, start = 0 : i32}> : () -> tensor<128xi32>
    %4 = "tt.splat"(%2) : (i32) -> tensor<128xi32>
    %5 = "arith.addi"(%4, %3) <{overflowFlags = #arith.overflow<none>}> : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
    %6 = "tt.splat"(%arg4) : (i32) -> tensor<128xi32>
    %7 = "arith.cmpi"(%3, %6) <{predicate = 2 : i64}> : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %8 = "tts.gather"(%arg1, %5, %7, %0) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (!tt.ptr<f32>, tensor<128xi32>, tensor<128xi1>, f32) -> tensor<128xf32>
    %9 = "tt.reduce"(%8) <{axis = 0 : i32}> ({
    ^bb0(%arg7: f32, %arg8: f32):
      %20 = "arith.cmpf"(%arg7, %arg8) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      %21 = "arith.select"(%20, %arg7, %arg8) : (i1, f32, f32) -> f32
      "tt.reduce.return"(%21) : (f32) -> ()
    }) : (tensor<128xf32>) -> f32
    %10 = "tt.splat"(%9) : (f32) -> tensor<128xf32>
    %11 = "arith.subf"(%8, %10) <{fastmath = #arith.fastmath<none>}> : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %12 = "math.exp"(%11) <{fastmath = #arith.fastmath<none>}> : (tensor<128xf32>) -> tensor<128xf32>
    %13 = "tt.reduce"(%12) <{axis = 0 : i32}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      %19 = "arith.addf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "tt.reduce.return"(%19) : (f32) -> ()
    }) : (tensor<128xf32>) -> f32
    %14 = "tt.splat"(%13) : (f32) -> tensor<128xf32>
    %15 = "arith.divf"(%12, %14) <{fastmath = #arith.fastmath<none>}> : (tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %16 = "arith.muli"(%1, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %17 = "tt.splat"(%16) : (i32) -> tensor<128xi32>
    %18 = "arith.addi"(%17, %3) <{overflowFlags = #arith.overflow<none>}> : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
    "tts.scatter"(%arg0, %18, %15, %7) : (!tt.ptr<f32>, tensor<128xi32>, tensor<128xf32>, tensor<128xi1>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

