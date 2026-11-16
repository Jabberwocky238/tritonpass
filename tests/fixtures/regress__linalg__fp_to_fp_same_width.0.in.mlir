// 位宽相同的 fp8 互转（x.to(tl.float8e5)，x 是 float8e4nv）：tt.fp_to_fp 既不是扩宽也不是截断，arith.extf、arith.truncf
// 都表达不了。参照照样建 extf、被自己的验证器拒收；tritonpass 在转换里报错。
// RUN: dope-opt %s --triton-arith-to-linalg="pids-to-func-args=false pids-to-gpu=true"

module {
  tt.func @e4_to_e5(%x: tensor<128xf8E4M3FN>) -> tensor<128xf8E5M2> {
    %r = tt.fp_to_fp %x : tensor<128xf8E4M3FN> -> tensor<128xf8E5M2>
    tt.return %r : tensor<128xf8E5M2>
  }
}
