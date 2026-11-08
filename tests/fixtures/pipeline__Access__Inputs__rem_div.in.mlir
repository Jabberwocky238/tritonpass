// 手写的 TTIR（按 Triton 3.7.1 打印的写法，没有经 Triton 生成）：偏移里有 pid % t 与 pid / t，除数 t 是运行期整数实参
// （FlagGems 逐元素生成器的 N 维写法就是这样拆程序号的）。读写同一个偏移 (pid % t)·16 + (pid / t)·64，窗口 16 个元素。
module {
  tt.func public @rem_div(%x: !tt.ptr<f32> loc("x"), %o: !tt.ptr<f32> loc("o"), %t: i32 loc("t")) attributes {noinline = false} {
    %pid = tt.get_program_id x : i32
    %r = arith.remsi %pid, %t : i32
    %q = arith.divsi %pid, %t : i32
    %c16 = arith.constant 16 : i32
    %c64 = arith.constant 64 : i32
    %ro = arith.muli %r, %c16 : i32
    %qo = arith.muli %q, %c64 : i32
    %off = arith.addi %ro, %qo : i32
    %xp = tt.addptr %x, %off : !tt.ptr<f32>, i32
    %op = tt.addptr %o, %off : !tt.ptr<f32>, i32
    %rng = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %xs = tt.splat %xp : !tt.ptr<f32> -> tensor<16x!tt.ptr<f32>>
    %xv = tt.addptr %xs, %rng : tensor<16x!tt.ptr<f32>>, tensor<16xi32>
    %os = tt.splat %op : !tt.ptr<f32> -> tensor<16x!tt.ptr<f32>>
    %ov = tt.addptr %os, %rng : tensor<16x!tt.ptr<f32>>, tensor<16xi32>
    %v = tt.load %xv : tensor<16x!tt.ptr<f32>>
    tt.store %ov, %v : tensor<16x!tt.ptr<f32>>
    tt.return
  }
}
