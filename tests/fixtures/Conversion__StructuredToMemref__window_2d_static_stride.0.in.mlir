// 7：二维窗口。根视图 reinterpret_cast 偏移 0、各维尺寸取 UNB（2^40）、行距取静态常数；
// 窗口是对根的一次 subview，逐维下标偏移。基线的 tts.make_tptr 里逐维偏移已经乘过行距（平坦），
// 这里把乘过行距的偏移拆回下标：muli(row, 128) 的左因子 row 就是第 0 维的下标偏移。
// RUN: dope-opt --structured-to-memref --triton-ptr-to-memref --reconcile-unrealized-casts %s | FileCheck %s

module {
  // CHECK-LABEL: tt.func @tile_2d(
  // CHECK-SAME: %[[X:.*]]: memref<?xbf16>, %[[ROW:.*]]: index, %[[COL:.*]]: index, %[[M:.*]]: index, %[[N:.*]]: index)
  tt.func @tile_2d(%x: !tt.ptr<bf16>, %row: index, %col: index, %m: index, %n: index) -> tensor<16x64xbf16> {
    %c128 = arith.constant 128 : index
    %row_flat = arith.muli %row, %c128 : index
    %px = tts.make_tptr %x to sizes: [16, 64], strides: [128, 1], offsets: [%row_flat, %col], shape: [0, 0], order: [] : <bf16> to tensor<16x64x!tt.ptr<bf16>>
    %v = "tts.load"(%px, %m, %n) <{operandSegmentSizes = array<i32: 1, 2, 0>, static_mask_dims = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<16x64x!tt.ptr<bf16>>, index, index) -> tensor<16x64xbf16>
    // CHECK: %[[ROOT:.*]] = memref.reinterpret_cast %[[X]] to offset: [0], sizes: [{{.*}}], strides: [128, 1] : memref<?xbf16> to memref<{{.*}}xbf16, strided<[128, 1]>>
    // CHECK: %[[T:.*]] = memref.alloc() : memref<16x64xbf16>
    // CHECK: %[[SRC:.*]] = memref.subview %[[ROOT]][%[[ROW]], %[[COL]]] [%[[M]], %[[N]]] [1, 1]
    // CHECK: %[[DST:.*]] = memref.subview %[[T]][0, 0] [%[[M]], %[[N]]] [1, 1]
    // CHECK: linalg.copy ins(%[[SRC]] : {{.*}}) outs(%[[DST]] : {{.*}})
    tt.return %v : tensor<16x64xbf16>
  }
}
