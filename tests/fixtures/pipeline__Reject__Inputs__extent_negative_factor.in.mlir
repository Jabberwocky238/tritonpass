// 手写的 TTIR（按 Triton 3.7.1 打印的写法，没有经 Triton 生成）：偏移是 (c − pid)·a：乘法的一个因子 c − pid 的下界是负的（pid 可以比 c 大），区间求值的乘法规则要求因子下界非负，证不出就求不出范围。
module {
  tt.func public @negative_factor(%x: !tt.ptr<f32> loc("x"), %o: !tt.ptr<f32> loc("o"), %a: i32 loc("a"), %b: i32 loc("b"), %c: i32 loc("c"), %n: i32 loc("n")) attributes {noinline = false} {
    %pid = tt.get_program_id x : i32
    %d = arith.subi %c, %pid : i32
    %off = arith.muli %d, %a : i32
    %xp = tt.addptr %x, %off : !tt.ptr<f32>, i32
    %op = tt.addptr %o, %off : !tt.ptr<f32>, i32
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
