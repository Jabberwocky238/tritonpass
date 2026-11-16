// gather / scatter 的行指针：行距是常量 op 定义的值时照 getMixedStridesForMemref 的 getAsOpFoldResult 折成静态，
// 每行的 reinterpret_cast 写 strided<[16, 1]>，不是带一个动态操作数的 strided<[?, 1]>。
// RUN: dope-opt %s --structured-to-memref

module {
  tt.func @scatter_rows(%dst: !tt.ptr<f32>, %idx: tensor<8xi32>, %v: tensor<8x16xf32>) {
    %c16 = arith.constant 16 : index
    %p = tts.make_gather_scatter_tptr %dst to sizes: [8, 16] gather_scatter_dim: 0 gather_scatter_offset: %idx, strides: [%c16, 1], offsets: [0, 0] : tensor<8xi32> <f32> to !tt.ptr<tensor<8x16xf32>>
    "tts.store"(%p, %v) <{static_mask_dims = array<i64>}> : (!tt.ptr<tensor<8x16xf32>>, tensor<8x16xf32>) -> ()
    tt.return
  }
}
