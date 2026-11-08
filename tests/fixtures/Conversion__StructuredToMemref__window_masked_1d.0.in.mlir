// 7、6：全局内存只经「根视图加一次 memref.subview」，逐维偏移；mask 的读写落成
// 静态 alloc、动态大小的 subview 与 linalg.copy。
// 一维、行距 1 的访问以入口参数本身为根：没有 reinterpret_cast；参数是 memref<?xT>。
// RUN: dope-opt --structured-to-memref --triton-ptr-to-memref --reconcile-unrealized-casts %s | FileCheck %s

module {
  // CHECK-LABEL: tt.func @masked_1d(
  // CHECK-SAME: %[[X:.*]]: memref<?xbf16>, %[[O:.*]]: memref<?xbf16>, %[[START:.*]]: index, %[[VALID:.*]]: index)
  tt.func @masked_1d(%x: !tt.ptr<bf16>, %o: !tt.ptr<bf16>, %start: index, %valid: index) {
    %px = tts.make_tptr %x to sizes: [1024], strides: [1], offsets: [%start], shape: [0], order: [] : <bf16> to tensor<1024x!tt.ptr<bf16>>
    %v = "tts.load"(%px, %valid) <{operandSegmentSizes = array<i32: 1, 1, 0>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<1024x!tt.ptr<bf16>>, index) -> tensor<1024xbf16>
    %po = tts.make_tptr %o to sizes: [1024], strides: [1], offsets: [%start], shape: [0], order: [] : <bf16> to tensor<1024x!tt.ptr<bf16>>
    "tts.store"(%po, %v, %valid) <{static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<1024x!tt.ptr<bf16>>, tensor<1024xbf16>, index) -> ()
    // 读：静态 tile、源是根上的一次 subview（偏移 start、大小 valid）、目标是 tile 的前缀、linalg.copy
    // CHECK-NOT: memref.reinterpret_cast
    // CHECK: %[[T:.*]] = memref.alloc() : memref<1024xbf16>
    // CHECK: %[[SRC:.*]] = memref.subview %[[X]][%[[START]]] [%[[VALID]]] [1] : memref<?xbf16> to memref<?xbf16, strided<[1], offset: ?>>
    // CHECK: %[[DST:.*]] = memref.subview %[[T]][0] [%[[VALID]]] [1] : memref<1024xbf16> to memref<?xbf16, strided<[1]>>
    // CHECK: linalg.copy ins(%[[SRC]] : memref<?xbf16, strided<[1], offset: ?>>) outs(%[[DST]] : memref<?xbf16, strided<[1]>>)
    // CHECK: %[[VAL:.*]] = bufferization.to_tensor %[[T]] restrict writable : memref<1024xbf16> to tensor<1024xbf16>
    // 写：只写前 valid 个，目标是输出根上的一次 subview
    // CHECK: %[[SLICE:.*]] = tensor.extract_slice %[[VAL]][0] [%[[VALID]]] [1] : tensor<1024xbf16> to tensor<?xbf16>
    // CHECK: %[[OUT:.*]] = memref.subview %[[O]][%[[START]]] [%[[VALID]]] [1] : memref<?xbf16> to memref<?xbf16, strided<[1], offset: ?>>
    // CHECK: bufferization.materialize_in_destination %[[SLICE]] in writable %[[OUT]]
    // CHECK-NOT: memref.copy
    // CHECK-NOT: scf.if
    tt.return
  }
}
