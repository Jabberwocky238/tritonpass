// 7：拆不进某一维的标量偏移（基线把 splat 来的标量偏移塞进第 0 维的平坦偏移里）交给静态行距为 1 的那一维吸收：
// 第 0 维的下标偏移取 muli(row, stride) 的左因子 row，余量 pending 加进第 1 维（行距 1）的窗口起点。
// 地址 = 基址 + (row + i0)·stride + (col + pending + i1)，与基线的平坦偏移逐项相同。
// RUN: dope-opt --structured-to-memref --triton-ptr-to-memref --reconcile-unrealized-casts %s | FileCheck %s

module {
  // CHECK-LABEL: tt.func @remainder(
  // CHECK-SAME: %[[X:.*]]: memref<?xf32>, %[[STRIDE:.*]]: i32, %[[ROW:.*]]: index, %[[COL:.*]]: index, %[[PENDING:.*]]: index)
  tt.func @remainder(%x: !tt.ptr<f32>, %stride: i32, %row: index, %col: index, %pending: index) -> tensor<8x32xf32> {
    %s = arith.index_cast %stride : i32 to index
    %m = arith.muli %row, %s : index
    %f0 = arith.addi %m, %pending : index
    %px = tts.make_tptr %x to sizes: [8, 32], strides: [%s, 1], offsets: [%f0, %col], shape: [0, 0], order: [] : <f32> to tensor<8x32x!tt.ptr<f32>>
    %v = "tts.load"(%px) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<8x32x!tt.ptr<f32>>) -> tensor<8x32xf32>
    // CHECK: %[[ROOT:.*]] = memref.reinterpret_cast %[[X]] to offset: [0], sizes: [{{.*}}], strides: [%{{.*}}, 1]
    // CHECK: %[[START1:.*]] = arith.addi %[[COL]], %[[PENDING]] : index
    // CHECK: memref.subview %[[ROOT]][%[[ROW]], %[[START1]]] [8, 32] [1, 1]
    tt.return %v : tensor<8x32xf32>
  }
}
