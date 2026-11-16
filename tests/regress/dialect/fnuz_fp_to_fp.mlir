// fp_to_fp 的源是 ±0 时折成目标类型的 0（`FpToFpOp::fold`）。目标是 f8E4M3FNUZ / f8E5M2FNUZ（Triton 的 TT_Float 收这两种）时，
// mlirformat 的 ApFloat 没有它们的布局，建不出常量：原先在 `ir::float` 里 panic，现在不折（登记在 tests/divergences/dialect.txt）。
// RUN: dope-opt %s --canonicalize
module {
  tt.func public @fp_to_fp_fnuz_zero(%p: !tt.ptr<f8E5M2FNUZ>, %q: !tt.ptr<f8E4M3FNUZ>) {
    %neg = arith.constant -0.000000e+00 : f32
    %pos = arith.constant dense<0.000000e+00> : tensor<16xf32>
    %a = tt.fp_to_fp %neg, rounding = rtne : f32 -> f8E5M2FNUZ
    %b = tt.fp_to_fp %pos, rounding = rtne : tensor<16xf32> -> tensor<16xf8E4M3FNUZ>
    tt.store %p, %a : !tt.ptr<f8E5M2FNUZ>
    %r = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %qs = tt.splat %q : !tt.ptr<f8E4M3FNUZ> -> tensor<16x!tt.ptr<f8E4M3FNUZ>>
    %qa = tt.addptr %qs, %r : tensor<16x!tt.ptr<f8E4M3FNUZ>>, tensor<16xi32>
    tt.store %qa, %b : tensor<16x!tt.ptr<f8E4M3FNUZ>>
    tt.return
  }
}
