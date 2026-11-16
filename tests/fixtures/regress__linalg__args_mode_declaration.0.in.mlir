// args 写法要给每个顶层 tt.func 的入口块末尾追加 6 个 grid 参数；只是声明的 tt.func 没有入口块。参照（C++ 的
// getBody().front()）在这里断言，tritonpass 以前 panic，现在报错。gpu 写法不碰签名，声明照常换成 func.func。
// RUN: dope-opt %s --triton-arith-to-linalg
// RUN: dope-opt %s --triton-arith-to-linalg="pids-to-func-args=false pids-to-gpu=true"

module {
  tt.func private @decl(i32) -> i32
  tt.func public @k(%arg0: !tt.ptr<i32>, %v: i32) {
    %p = tt.get_program_id x : i32
    %s = arith.addi %v, %p : i32
    tt.store %arg0, %s : !tt.ptr<i32>
    tt.return
  }
}
