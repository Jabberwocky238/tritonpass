// 手写的 TTIR（按 Triton 3.7.1 打印的写法，没有经 Triton 生成）：读指针 x 的偏移 %off 里有乘进偏移的运行期整数实参，
// 写指针 o 的偏移是普通的 pid·32（写指针的偏移带 select、shli 这类运算会先 E-EXTENT）。偏移是 pid·(a·b·c)：三个标量连乘。
module {
  tt.func public @k(%x: !tt.ptr<f32> loc("x"), %o: !tt.ptr<f32> loc("o"), %a: i32 loc("a"), %b: i32 loc("b"), %c: i32 loc("c"), %n: i32 loc("n")) attributes {noinline = false} {
    %pid = tt.get_program_id x : i32
    %t = arith.muli %a, %b : i32
    %t2 = arith.muli %t, %c : i32
    %off = arith.muli %pid, %t2 : i32
    %c32 = arith.constant 32 : i32
    %obase = arith.muli %pid, %c32 : i32
    %xp = tt.addptr %x, %off : !tt.ptr<f32>, i32
    %op = tt.addptr %o, %obase : !tt.ptr<f32>, i32
    %r = tt.make_range {end = 32 : i32, start = 0 : i32} : tensor<32xi32>
    %xs = tt.splat %xp : !tt.ptr<f32> -> tensor<32x!tt.ptr<f32>>
    %xv = tt.addptr %xs, %r : tensor<32x!tt.ptr<f32>>, tensor<32xi32>
    %os = tt.splat %op : !tt.ptr<f32> -> tensor<32x!tt.ptr<f32>>
    %ov = tt.addptr %os, %r : tensor<32x!tt.ptr<f32>>, tensor<32xi32>
    %v = tt.load %xv : tensor<32x!tt.ptr<f32>>
    tt.store %ov, %v : tensor<32x!tt.ptr<f32>>
    tt.return
  }
}
