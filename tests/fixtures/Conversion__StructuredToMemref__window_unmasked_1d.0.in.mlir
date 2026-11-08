// 7：整块有效（无 mask）的读写：窗口大小静态，源只有根上的一次 subview，没有第二个 subview；
// 读是 linalg.copy ins(窗口) outs(tile)，写直接把值落进窗口。
// RUN: dope-opt --structured-to-memref --triton-ptr-to-memref --reconcile-unrealized-casts %s | FileCheck %s

module {
  // CHECK-LABEL: tt.func @unmasked_1d(
  // CHECK-SAME: %[[X:.*]]: memref<?xf32>, %[[O:.*]]: memref<?xf32>, %[[START:.*]]: index)
  tt.func @unmasked_1d(%x: !tt.ptr<f32>, %o: !tt.ptr<f32>, %start: index) {
    %px = tts.make_tptr %x to sizes: [256], strides: [1], offsets: [%start], shape: [0], order: [] : <f32> to tensor<256x!tt.ptr<f32>>
    %v = "tts.load"(%px) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<256x!tt.ptr<f32>>) -> tensor<256xf32>
    %po = tts.make_tptr %o to sizes: [256], strides: [1], offsets: [%start], shape: [0], order: [] : <f32> to tensor<256x!tt.ptr<f32>>
    "tts.store"(%po, %v) <{static_mask_dims = array<i64>}> : (tensor<256x!tt.ptr<f32>>, tensor<256xf32>) -> ()
    // CHECK-NOT: memref.reinterpret_cast
    // CHECK: %[[T:.*]] = memref.alloc() : memref<256xf32>
    // CHECK: %[[W:.*]] = memref.subview %[[X]][%[[START]]] [256] [1] : memref<?xf32> to memref<256xf32, strided<[1], offset: ?>>
    // CHECK-NOT: memref.subview
    // CHECK: linalg.copy ins(%[[W]] : memref<256xf32, strided<[1], offset: ?>>) outs(%[[T]] : memref<256xf32>)
    // CHECK: %[[VAL:.*]] = bufferization.to_tensor %[[T]] restrict writable : memref<256xf32> to tensor<256xf32>
    // CHECK: %[[OW:.*]] = memref.subview %[[O]][%[[START]]] [256] [1] : memref<?xf32> to memref<256xf32, strided<[1], offset: ?>>
    // CHECK: bufferization.materialize_in_destination %[[VAL]] in writable %[[OW]]
    tt.return
  }
}
