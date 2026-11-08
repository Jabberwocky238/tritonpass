// 循环体里的 barrier 一样擦，循环本身与体里别的 op 不动。
// LOOP-LABEL: tt.func public @in_loop
// LOOP-NOT: ttg.barrier
// LOOP: scf.for
// LOOP: tt.load
// LOOP: tt.return
module {
  tt.func public @in_loop(%x: !tt.ptr<f32>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %offs = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %xp = tt.splat %x : !tt.ptr<f32> -> tensor<16x!tt.ptr<f32>>
    %xa = tt.addptr %xp, %offs : tensor<16x!tt.ptr<f32>>, tensor<16xi32>
    scf.for %i = %c0 to %c4 step %c1 {
      ttg.barrier all
      %v = tt.load %xa : tensor<16x!tt.ptr<f32>>
      ttg.barrier local
      scf.yield
    }
    tt.return
  }
}

