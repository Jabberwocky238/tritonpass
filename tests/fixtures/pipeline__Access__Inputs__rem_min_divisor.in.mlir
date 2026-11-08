// 手写的 TTIR：模数是 min(pid, 7) + 1——写不成 pointValue 的单一符号值（里面有 program_id），但区间求值
// 认得 program_id 的区间，min、加常数都不改变「下界非负」这件事，模数的区间下界证得出 1（恒为正，取模
// 不会撞见除数为 0）。练的是取模回绕判据之外、矩阵乘按 L2 缓存分组重排 program 顺序时新冒出来的那条
// 既有缺口的第一层（模数本身随 pid 变、但区间能证非负时也该收）。
module {
  tt.func public @min_divisor(%o: !tt.ptr<f32> loc("o"), %n: i32 loc("n")) attributes {noinline = false} {
    %pid = tt.get_program_id x : i32
    %c7 = arith.constant 7 : i32
    %c1 = arith.constant 1 : i32
    %mn = arith.minsi %pid, %c7 : i32
    %divisor = arith.addi %mn, %c1 : i32
    %m = arith.remsi %n, %divisor : i32
    %c16 = arith.constant 16 : i32
    %base = arith.muli %m, %c16 : i32
    %r = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %bs = tt.splat %base : i32 -> tensor<16xi32>
    %offs = arith.addi %bs, %r : tensor<16xi32>
    %os = tt.splat %o : !tt.ptr<f32> -> tensor<16x!tt.ptr<f32>>
    %op = tt.addptr %os, %offs : tensor<16x!tt.ptr<f32>>, tensor<16xi32>
    %v = arith.constant dense<1.0> : tensor<16xf32>
    tt.store %op, %v : tensor<16x!tt.ptr<f32>>
    tt.return
  }
}
