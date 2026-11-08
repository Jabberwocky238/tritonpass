"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, i32, i32, tensor<16x16xbf16>, tensor<16x16xbf16>) -> (), sym_name = "runtime_lower_with_dot", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: i32, %arg2: i32, %arg3: tensor<16x16xbf16>, %arg4: tensor<16x16xbf16>):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<16x16xf32>}> : () -> tensor<16x16xf32>
    %3 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %4 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %5 = "arith.subi"(%arg2, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "scf.for"(%4, %5, %0, %2) ({
    ^bb0(%arg5: i32, %arg6: tensor<16x16xf32>):
      %7 = "arith.addi"(%arg5, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %8 = "arith.muli"(%7, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %9 = "tt.dot"(%arg3, %arg4, %arg6) <{inputPrecision = 2 : i32, maxNumImpreciseAcc = 0 : i32}> : (tensor<16x16xbf16>, tensor<16x16xbf16>, tensor<16x16xf32>) -> tensor<16x16xf32>
      "scf.yield"(%9) : (tensor<16x16xf32>) -> ()
    }) : (i32, i32, i32, tensor<16x16xf32>) -> tensor<16x16xf32>
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (i32, i32) -> (), sym_name = "runtime_lower_no_dot", sym_visibility = "public"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "scf.for"(%arg0, %arg1, %0) ({
    ^bb0(%arg2: i32):
      "scf.yield"() : () -> ()
    }) : (i32, i32, i32) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (i32, tensor<16x16xbf16>, tensor<16x16xbf16>) -> (), sym_name = "zero_lower_with_dot", sym_visibility = "public"}> ({
  ^bb0(%arg0: i32, %arg1: tensor<16x16xbf16>, %arg2: tensor<16x16xbf16>):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<16x16xf32>}> : () -> tensor<16x16xf32>
    %3 = "scf.for"(%0, %arg0, %1, %2) ({
    ^bb0(%arg3: i32, %arg4: tensor<16x16xf32>):
      %4 = "tt.dot"(%arg1, %arg2, %arg4) <{inputPrecision = 2 : i32, maxNumImpreciseAcc = 0 : i32}> : (tensor<16x16xbf16>, tensor<16x16xbf16>, tensor<16x16xf32>) -> tensor<16x16xf32>
      "scf.yield"(%4) : (tensor<16x16xf32>) -> ()
    }) : (i32, i32, i32, tensor<16x16xf32>) -> tensor<16x16xf32>
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (i32, i32, tensor<16x16xbf16>, tensor<16x16xbf16>) -> (), sym_name = "step_two_with_dot", sym_visibility = "public"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: tensor<16x16xbf16>, %arg3: tensor<16x16xbf16>):
    %0 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<16x16xf32>}> : () -> tensor<16x16xf32>
    %2 = "scf.for"(%arg0, %arg1, %0, %1) ({
    ^bb0(%arg4: i32, %arg5: tensor<16x16xf32>):
      %3 = "tt.dot"(%arg2, %arg3, %arg5) <{inputPrecision = 2 : i32, maxNumImpreciseAcc = 0 : i32}> : (tensor<16x16xbf16>, tensor<16x16xbf16>, tensor<16x16xf32>) -> tensor<16x16xf32>
      "scf.yield"(%3) : (tensor<16x16xf32>) -> ()
    }) : (i32, i32, i32, tensor<16x16xf32>) -> tensor<16x16xf32>
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

