// tt.fp_to_fp 向零舍入（rtz）的截断：arith.truncf 只会就近舍入，照转会悄悄改掉舍入方式；参照在这里断言，tritonpass 报错。
// 第二块是就近舍入的截断与扩宽，照常转成 arith.truncf / arith.extf。
// RUN: dope-opt %s --split-input-file --triton-arith-to-linalg

module {
  tt.func @trunc_rtz(%x: tensor<128xf32>) -> tensor<128xf16> {
    %r = tt.fp_to_fp %x, rounding = rtz : tensor<128xf32> -> tensor<128xf16>
    tt.return %r : tensor<128xf16>
  }
}

// -----

module {
  tt.func @trunc_rtne(%x: tensor<128xf32>) -> tensor<128xf8E5M2> {
    %r = tt.fp_to_fp %x, rounding = rtne : tensor<128xf32> -> tensor<128xf8E5M2>
    tt.return %r : tensor<128xf8E5M2>
  }
  tt.func @ext(%x: tensor<128xf8E4M3FN>) -> tensor<128xf32> {
    %r = tt.fp_to_fp %x : tensor<128xf8E4M3FN> -> tensor<128xf32>
    tt.return %r : tensor<128xf32>
  }
}
