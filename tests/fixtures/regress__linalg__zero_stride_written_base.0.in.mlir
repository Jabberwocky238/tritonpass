// 零行距的读只许只读广播：同一个基址在别处经 tts.make_tptr 交给 tts.store（被写），这样的读不收（参照报 E-STRIDE），
// 只读的照常收。被写的基址在转换之前一次算好，两种情形都要和以前逐次扫用处时一样。
// RUN: dope-opt %s --split-input-file --structured-to-memref

module {
  tt.func @bcast_written(%x: !tt.ptr<f32>, %col: index, %v: tensor<64xf32>) -> tensor<16x64xf32> {
    %px = tts.make_tptr %x to sizes: [16, 64], strides: [0, 1], offsets: [0, %col], shape: [0, 0], order: [] : <f32> to tensor<16x64x!tt.ptr<f32>>
    %r = "tts.load"(%px) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<16x64x!tt.ptr<f32>>) -> tensor<16x64xf32>
    %po = tts.make_tptr %x to sizes: [64], strides: [1], offsets: [%col], shape: [0], order: [] : <f32> to tensor<64x!tt.ptr<f32>>
    "tts.store"(%po, %v) <{static_mask_dims = array<i64>}> : (tensor<64x!tt.ptr<f32>>, tensor<64xf32>) -> ()
    tt.return %r : tensor<16x64xf32>
  }
}

// -----

module {
  tt.func @bcast_readonly(%x: !tt.ptr<f32>, %o: !tt.ptr<f32>, %col: index, %v: tensor<64xf32>) -> tensor<16x64xf32> {
    %px = tts.make_tptr %x to sizes: [16, 64], strides: [0, 1], offsets: [0, %col], shape: [0, 0], order: [] : <f32> to tensor<16x64x!tt.ptr<f32>>
    %r = "tts.load"(%px) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<16x64x!tt.ptr<f32>>) -> tensor<16x64xf32>
    %po = tts.make_tptr %o to sizes: [64], strides: [1], offsets: [%col], shape: [0], order: [] : <f32> to tensor<64x!tt.ptr<f32>>
    "tts.store"(%po, %v) <{static_mask_dims = array<i64>}> : (tensor<64x!tt.ptr<f32>>, tensor<64xf32>) -> ()
    tt.return %r : tensor<16x64xf32>
  }
}
