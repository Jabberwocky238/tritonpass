// 手写的 TTIR（按 Triton 3.7.1 打印的写法，没有经 Triton 生成）：被除数是 pid - 1，下界是 -1（divsi 向零取整，pid = 0 时商是 0，但下界证不出非负）。
// 写指针的偏移是 m·32 加一个 32 个元素的窗口；m 的算式如下。
module {
  tt.func public @const_div_minus1(%o: !tt.ptr<f32> loc("o")) attributes {noinline = false} {
    %pid = tt.get_program_id x : i32
    %c1 = arith.constant 1 : i32
    %c8 = arith.constant 8 : i32
    %pm = arith.subi %pid, %c1 : i32
    %m = arith.divsi %pm, %c8 : i32
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
