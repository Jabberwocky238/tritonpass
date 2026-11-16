// gather 的读：rewriteGather 先把行偏移 index_cast 成 index，再建 alloc、填 other、建循环；以前 index_cast 落在 alloc
// 与 fill 之后。
// RUN: dope-opt %s --structured-to-memref

module {
  tt.func @gather_rows(%src: !tt.ptr<f32>, %idx: tensor<8xi32>, %n: index) -> tensor<8x16xf32> {
    %c16 = arith.constant 16 : index
    %other = arith.constant -1.0 : f32
    %p = tts.make_gather_scatter_tptr %src to sizes: [8, 16] gather_scatter_dim: 0 gather_scatter_offset: %idx, strides: [%c16, 1], offsets: [0, 0] : tensor<8xi32> <f32> to !tt.ptr<tensor<8x16xf32>>
    %v = "tts.load"(%p, %n, %other) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808, 16>}> : (!tt.ptr<tensor<8x16xf32>>, index, f32) -> tensor<8x16xf32>
    tt.return %v : tensor<8x16xf32>
  }
}
