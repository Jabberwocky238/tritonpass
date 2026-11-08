// 7：行距是整数标量实参（只经 index_cast 这类无损转换）：运行期值原样放进 reinterpret_cast 的 strides，
// 视图类型写 strided<[?, 1]>；窗口起点同样把 muli(row, stride) 拆回 row。
// RUN: dope-opt --structured-to-memref --triton-ptr-to-memref --reconcile-unrealized-casts %s | FileCheck %s

module {
  // CHECK-LABEL: tt.func @tile_runtime_stride(
  // CHECK-SAME: %[[X:.*]]: memref<?xbf16>, %[[STRIDE:.*]]: i32, %[[ROW:.*]]: index, %[[COL:.*]]: index)
  tt.func @tile_runtime_stride(%x: !tt.ptr<bf16>, %stride: i32, %row: index, %col: index) -> tensor<16x64xbf16> {
    %s = arith.index_cast %stride : i32 to index
    %row_flat = arith.muli %row, %s : index
    %px = tts.make_tptr %x to sizes: [16, 64], strides: [%s, 1], offsets: [%row_flat, %col], shape: [0, 0], order: [] : <bf16> to tensor<16x64x!tt.ptr<bf16>>
    %v = "tts.load"(%px) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<16x64x!tt.ptr<bf16>>) -> tensor<16x64xbf16>
    // CHECK: %[[S:.*]] = arith.index_cast %[[STRIDE]] : i32 to index
    // CHECK: %[[ROOT:.*]] = memref.reinterpret_cast %[[X]] to offset: [0], sizes: [{{.*}}], strides: [%[[S]], 1] : memref<?xbf16> to memref<{{.*}}xbf16, strided<[?, 1]>>
    // CHECK: %[[T:.*]] = memref.alloc() : memref<16x64xbf16>
    // CHECK: %[[W:.*]] = memref.subview %[[ROOT]][%[[ROW]], %[[COL]]] [16, 64] [1, 1]
    // CHECK: linalg.copy ins(%[[W]] : {{.*}}) outs(%[[T]] : memref<16x64xbf16>)
    tt.return %v : tensor<16x64xbf16>
  }
}
