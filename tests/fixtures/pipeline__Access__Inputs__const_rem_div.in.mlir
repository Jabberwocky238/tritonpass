// 手写的 TTIR（按 Triton 3.7.1 打印的写法，没有经 Triton 生成）：偏移里有 pid % 4 与 pid / 4（常数除数）。
// 读写同一个偏移 (pid % 4)·8 + (pid / 4)·32，窗口 8 个元素。
module {
  tt.func public @const_rem_div(%x: !tt.ptr<f32> loc("x"), %o: !tt.ptr<f32> loc("o")) attributes {noinline = false} {
    %pid = tt.get_program_id x : i32
    %c4 = arith.constant 4 : i32
    %r = arith.remsi %pid, %c4 : i32
    %q = arith.divsi %pid, %c4 : i32
    %c8 = arith.constant 8 : i32
    %c32 = arith.constant 32 : i32
    %ro = arith.muli %r, %c8 : i32
    %qo = arith.muli %q, %c32 : i32
    %off = arith.addi %ro, %qo : i32
    %xp = tt.addptr %x, %off : !tt.ptr<f32>, i32
    %op = tt.addptr %o, %off : !tt.ptr<f32>, i32
    %rng = tt.make_range {end = 8 : i32, start = 0 : i32} : tensor<8xi32>
    %xs = tt.splat %xp : !tt.ptr<f32> -> tensor<8x!tt.ptr<f32>>
    %xv = tt.addptr %xs, %rng : tensor<8x!tt.ptr<f32>>, tensor<8xi32>
    %os = tt.splat %op : !tt.ptr<f32> -> tensor<8x!tt.ptr<f32>>
    %ov = tt.addptr %os, %rng : tensor<8x!tt.ptr<f32>>, tensor<8xi32>
    %v = tt.load %xv : tensor<8x!tt.ptr<f32>>
    tt.store %ov, %v : tensor<8x!tt.ptr<f32>>
    tt.return
  }
}
