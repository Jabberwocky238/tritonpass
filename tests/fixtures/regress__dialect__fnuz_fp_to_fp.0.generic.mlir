"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f8E5M2FNUZ>, !tt.ptr<f8E4M3FNUZ>) -> (), sym_name = "fp_to_fp_fnuz_zero", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f8E5M2FNUZ>, %arg1: !tt.ptr<f8E4M3FNUZ>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f8E5M2FNUZ}> : () -> f8E5M2FNUZ
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<16xf8E4M3FNUZ>}> : () -> tensor<16xf8E4M3FNUZ>
    "tt.store"(%arg0, %0) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f8E5M2FNUZ>, f8E5M2FNUZ) -> ()
    %2 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %3 = "tt.splat"(%arg1) : (!tt.ptr<f8E4M3FNUZ>) -> tensor<16x!tt.ptr<f8E4M3FNUZ>>
    %4 = "tt.addptr"(%3, %2) : (tensor<16x!tt.ptr<f8E4M3FNUZ>>, tensor<16xi32>) -> tensor<16x!tt.ptr<f8E4M3FNUZ>>
    "tt.store"(%4, %1) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<16x!tt.ptr<f8E4M3FNUZ>>, tensor<16xf8E4M3FNUZ>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

