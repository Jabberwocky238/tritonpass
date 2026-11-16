// tt.func ⇒ func.func 照 C++ 的 moduleOp.walk 换整个 module 里的函数，嵌套 module 里的也换；以前只换顶层的。
// args 写法追加 grid 参数仍只给顶层函数（C++ 的 getOps<FuncOp>）。
// RUN: dope-opt %s --triton-arith-to-linalg="pids-to-func-args=false pids-to-gpu=true"
// RUN: dope-opt %s --triton-arith-to-linalg

module {
  module {
    tt.func public @inner(%x: tensor<4xf32>, %y: tensor<4xf32>) -> tensor<4xf32> {
      %r = arith.addf %x, %y : tensor<4xf32>
      tt.return %r : tensor<4xf32>
    }
  }
  tt.func private @outer(%x: i32) -> i32 {
    tt.return %x : i32
  }
}
