// 一条 barrier 夹在读与写之间：擦掉之后读写的次序由程序次序给出，别的 op 一个不动。
// ONE-LABEL: tt.func public @one
// ONE-NOT: ttg.barrier
// ONE: tt.load
// ONE: tt.store
// ONE: tt.return
module {
  tt.func public @one(%x: !tt.ptr<f32>, %y: !tt.ptr<f32>) {
    %offs = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %xp = tt.splat %x : !tt.ptr<f32> -> tensor<16x!tt.ptr<f32>>
    %xa = tt.addptr %xp, %offs : tensor<16x!tt.ptr<f32>>, tensor<16xi32>
    %v = tt.load %xa : tensor<16x!tt.ptr<f32>>
    ttg.barrier all
    %yp = tt.splat %y : !tt.ptr<f32> -> tensor<16x!tt.ptr<f32>>
    %ya = tt.addptr %yp, %offs : tensor<16x!tt.ptr<f32>>, tensor<16xi32>
    tt.store %ya, %v : tensor<16x!tt.ptr<f32>>
    tt.return
  }
}

