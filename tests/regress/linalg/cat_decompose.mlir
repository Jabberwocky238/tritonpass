// tt.cat 转成 tensor.concat 之后，照 C++ 的 applyTensorConcatDecomposition 拆成 tensor.empty 加逐个 insert_slice。
// RUN: dope-opt %s --triton-arith-to-linalg="pids-to-func-args=false pids-to-gpu=true"

module {
  tt.func @cat1d(%x: tensor<4xf32>, %y: tensor<4xf32>) -> tensor<8xf32> {
    %r = tt.cat %x, %y : tensor<4xf32> -> tensor<8xf32>
    tt.return %r : tensor<8xf32>
  }
  tt.func @cat2d(%x: tensor<4x2xi32>, %y: tensor<4x2xi32>) -> tensor<8x2xi32> {
    %r = tt.cat %x, %y : tensor<4x2xi32> -> tensor<8x2xi32>
    tt.return %r : tensor<8x2xi32>
  }
}
