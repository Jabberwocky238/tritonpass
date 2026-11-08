// 6：masked load 的 other。非零：整块 linalg.fill 在 copy 之前，没有 scf.if 守卫（基线是 scf.if 加 fill，
// 守卫只是少填一次、语义无差，却会让 calcc 为它生成 calvx.if）；+0 或没有 other：越界读合同定义为 0，
// 窗口只有一部分有效时同样在 copy 之前整块填 +0（标准 MLIR 自己带着这个值，不留未初始化的尾部）；
// 整块有效（没有 mask）的读拷贝覆盖整块，不填。
// RUN: dope-opt --structured-to-memref --triton-ptr-to-memref --reconcile-unrealized-casts %s | FileCheck %s

module {
  // CHECK-LABEL: tt.func @other_nonzero(
  tt.func @other_nonzero(%x: !tt.ptr<f32>, %start: index, %valid: index) -> tensor<128xf32> {
    %px = tts.make_tptr %x to sizes: [128], strides: [1], offsets: [%start], shape: [0], order: [] : <f32> to tensor<128x!tt.ptr<f32>>
    %other = arith.constant 0xFF800000 : f32
    %v = "tts.load"(%px, %valid, %other) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<128x!tt.ptr<f32>>, index, f32) -> tensor<128xf32>
    // CHECK-NOT: scf.if
    // CHECK: %[[OTHER:.*]] = arith.constant 0xFF800000 : f32
    // CHECK: %[[T:.*]] = memref.alloc() : memref<128xf32>
    // CHECK: linalg.fill ins(%[[OTHER]] : f32) outs(%[[T]] : memref<128xf32>)
    // CHECK: linalg.copy
    // CHECK-NOT: scf.if
    tt.return %v : tensor<128xf32>
  }

  // CHECK-LABEL: tt.func @other_zero(
  tt.func @other_zero(%x: !tt.ptr<f32>, %start: index, %valid: index) -> tensor<128xf32> {
    %px = tts.make_tptr %x to sizes: [128], strides: [1], offsets: [%start], shape: [0], order: [] : <f32> to tensor<128x!tt.ptr<f32>>
    %other = arith.constant 0.0 : f32
    %v = "tts.load"(%px, %valid, %other) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<128x!tt.ptr<f32>>, index, f32) -> tensor<128xf32>
    // CHECK: %[[ZERO:.*]] = arith.constant 0.000000e+00 : f32
    // CHECK: %[[T:.*]] = memref.alloc() : memref<128xf32>
    // CHECK: linalg.fill ins(%[[ZERO]] : f32) outs(%[[T]] : memref<128xf32>)
    // CHECK-NOT: linalg.fill
    // CHECK: linalg.copy
    tt.return %v : tensor<128xf32>
  }

  // CHECK-LABEL: tt.func @other_negative_zero(
  tt.func @other_negative_zero(%x: !tt.ptr<f32>, %start: index, %valid: index) -> tensor<128xf32> {
    %px = tts.make_tptr %x to sizes: [128], strides: [1], offsets: [%start], shape: [0], order: [] : <f32> to tensor<128x!tt.ptr<f32>>
    %other = arith.constant -0.0 : f32
    %v = "tts.load"(%px, %valid, %other) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<128x!tt.ptr<f32>>, index, f32) -> tensor<128xf32>
    // CHECK: %[[NZ:.*]] = arith.constant -0.000000e+00 : f32
    // CHECK: %[[T:.*]] = memref.alloc() : memref<128xf32>
    // CHECK: linalg.fill ins(%[[NZ]] : f32) outs(%[[T]] : memref<128xf32>)
    // CHECK-NOT: linalg.fill
    // CHECK: linalg.copy
    tt.return %v : tensor<128xf32>
  }

  // CHECK-LABEL: tt.func @other_none(
  tt.func @other_none(%x: !tt.ptr<f32>, %start: index, %valid: index) -> tensor<128xf32> {
    %px = tts.make_tptr %x to sizes: [128], strides: [1], offsets: [%start], shape: [0], order: [] : <f32> to tensor<128x!tt.ptr<f32>>
    %v = "tts.load"(%px, %valid) <{operandSegmentSizes = array<i32: 1, 1, 0>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<128x!tt.ptr<f32>>, index) -> tensor<128xf32>
    // CHECK: %[[ZERO:.*]] = arith.constant 0.000000e+00 : f32
    // CHECK: %[[T:.*]] = memref.alloc() : memref<128xf32>
    // CHECK: linalg.fill ins(%[[ZERO]] : f32) outs(%[[T]] : memref<128xf32>)
    // CHECK-NOT: linalg.fill
    // CHECK: linalg.copy
    tt.return %v : tensor<128xf32>
  }

  // CHECK-LABEL: tt.func @other_none_bf16(
  tt.func @other_none_bf16(%x: !tt.ptr<bf16>, %start: index, %valid: index) -> tensor<128xbf16> {
    %px = tts.make_tptr %x to sizes: [128], strides: [1], offsets: [%start], shape: [0], order: [] : <bf16> to tensor<128x!tt.ptr<bf16>>
    %v = "tts.load"(%px, %valid) <{operandSegmentSizes = array<i32: 1, 1, 0>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<128x!tt.ptr<bf16>>, index) -> tensor<128xbf16>
    // CHECK: %[[ZERO:.*]] = arith.constant 0.000000e+00 : bf16
    // CHECK: %[[T:.*]] = memref.alloc() : memref<128xbf16>
    // CHECK: linalg.fill ins(%[[ZERO]] : bf16) outs(%[[T]] : memref<128xbf16>)
    // CHECK: linalg.copy
    tt.return %v : tensor<128xbf16>
  }

  // CHECK-LABEL: tt.func @unmasked(
  tt.func @unmasked(%x: !tt.ptr<f32>, %start: index) -> tensor<128xf32> {
    %px = tts.make_tptr %x to sizes: [128], strides: [1], offsets: [%start], shape: [0], order: [] : <f32> to tensor<128x!tt.ptr<f32>>
    %v = "tts.load"(%px) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<128x!tt.ptr<f32>>) -> tensor<128xf32>
    // CHECK: memref.alloc() : memref<128xf32>
    // CHECK-NOT: linalg.fill
    // CHECK: linalg.copy
    tt.return %v : tensor<128xf32>
  }
}
