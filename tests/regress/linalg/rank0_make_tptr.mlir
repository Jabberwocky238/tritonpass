// 0 维的 tts.make_tptr（只能手写；triton-to-structured 已经不从 tt.advance 产生它）：没有维可建视图。参照取第 0 维时越界
// 断言，tritonpass 以前 panic，现在报错。两块分别是读和写。
// RUN: dope-opt %s --split-input-file --structured-to-memref

module {
  tt.func @rank0_load(%x: !tt.ptr<f32>) -> tensor<f32> {
    %p = tts.make_tptr %x to sizes: [], strides: [], offsets: [], shape: [], order: [] : <f32> to tensor<!tt.ptr<f32>>
    %v = "tts.load"(%p) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<!tt.ptr<f32>>) -> tensor<f32>
    tt.return %v : tensor<f32>
  }
}

// -----

module {
  tt.func @rank0_store(%x: !tt.ptr<f32>, %v: tensor<f32>) {
    %p = tts.make_tptr %x to sizes: [], strides: [], offsets: [], shape: [], order: [] : <f32> to tensor<!tt.ptr<f32>>
    "tts.store"(%p, %v) <{static_mask_dims = array<i64>}> : (tensor<!tt.ptr<f32>>, tensor<f32>) -> ()
    tt.return
  }
}
