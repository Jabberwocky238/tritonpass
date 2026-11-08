// 7：零行距的只读广播一期就收：只读指针的行距 0 原样放进根视图（strided<[0, 1]>），
// 窗口第 0 维的偏移取 0；size 为 1 的维上的 0 行距不是真广播（没有别名），规整成正行距。
// RUN: dope-opt --structured-to-memref --triton-ptr-to-memref --reconcile-unrealized-casts %s | FileCheck %s

module {
  // CHECK-LABEL: tt.func @broadcast_read(
  // CHECK-SAME: %[[X:.*]]: memref<?xf32>, %[[COL:.*]]: index)
  tt.func @broadcast_read(%x: !tt.ptr<f32>, %col: index) -> tensor<16x64xf32> {
    %px = tts.make_tptr %x to sizes: [16, 64], strides: [0, 1], offsets: [0, %col], shape: [0, 0], order: [] : <f32> to tensor<16x64x!tt.ptr<f32>>
    %v = "tts.load"(%px) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<16x64x!tt.ptr<f32>>) -> tensor<16x64xf32>
    // CHECK: %[[ROOT:.*]] = memref.reinterpret_cast %[[X]] to offset: [0], sizes: [{{.*}}], strides: [0, 1] : memref<?xf32> to memref<{{.*}}xf32, strided<[0, 1]>>
    // CHECK: memref.subview %[[ROOT]][0, %[[COL]]] [16, 64] [1, 1]
    tt.return %v : tensor<16x64xf32>
  }

  // CHECK-LABEL: tt.func @size_one_dim(
  // CHECK-SAME: %[[Y:.*]]: memref<?xf32>, %[[COL1:.*]]: index)
  tt.func @size_one_dim(%y: !tt.ptr<f32>, %col: index) -> tensor<1x64xf32> {
    %py = tts.make_tptr %y to sizes: [1, 64], strides: [0, 1], offsets: [0, %col], shape: [0, 0], order: [] : <f32> to tensor<1x64x!tt.ptr<f32>>
    %v = "tts.load"(%py) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<1x64x!tt.ptr<f32>>) -> tensor<1x64xf32>
    // CHECK: %[[ROOT1:.*]] = memref.reinterpret_cast %[[Y]] to offset: [0], sizes: [{{.*}}], strides: [64, 1]
    // CHECK-NOT: strides: [0,
    tt.return %v : tensor<1x64xf32>
  }
}
