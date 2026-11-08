// 手写的 TTIR（按 Triton 3.7.1 打印的写法，没有经 Triton 生成）：模数是 a - b：两个实参都非负，差却可以是负数，x % (a - b) 的上界 (a - b) - 1 就不成立。
// 写指针的偏移是 m·32 加一个 32 个元素的窗口；m 的算式如下。
module {
  tt.func public @runtime_sub_rem(%o: !tt.ptr<f32> loc("o"), %a: i32 loc("a"), %b: i32 loc("b")) attributes {noinline = false} {
    %pid = tt.get_program_id x : i32
    %t = arith.subi %a, %b : i32
    %m = arith.remsi %pid, %t : i32
    %c32 = arith.constant 32 : i32
    %base = arith.muli %m, %c32 : i32
    %r = tt.make_range {end = 32 : i32, start = 0 : i32} : tensor<32xi32>
    %bs = tt.splat %base : i32 -> tensor<32xi32>
    %offs = arith.addi %bs, %r : tensor<32xi32>
    %os = tt.splat %o : !tt.ptr<f32> -> tensor<32x!tt.ptr<f32>>
    %op = tt.addptr %os, %offs : tensor<32x!tt.ptr<f32>>, tensor<32xi32>
    %v = arith.constant dense<1.0> : tensor<32xf32>
    tt.store %op, %v : tensor<32x!tt.ptr<f32>>
    tt.return
  }
}
