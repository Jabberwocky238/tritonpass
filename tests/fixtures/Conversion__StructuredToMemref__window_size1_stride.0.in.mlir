// 大小为 1 的维上的行距不影响寻址，取什么值都收：负常数、复杂表达式、零，根视图里都规整成正行距（该维以下各维大小的乘积），
// 窗口的偏移里这一维取 0；偏移里原来乘在这个行距上的平坦偏移归给行距为 1 的那一维。
// RUN: dope-opt --split-input-file --structured-to-memref --triton-ptr-to-memref --reconcile-unrealized-casts %s | FileCheck %s

module {
  // CHECK-LABEL: tt.func @size1_negative(
  // CHECK: memref.reinterpret_cast %{{.*}} to offset: [0], sizes: [{{.*}}], strides: [16, 1] : memref<?xf32> to memref<{{.*}}xf32, strided<[16, 1]>>
  // CHECK: memref.subview %{{.*}}[0, 0] [1, 16] [1, 1]
  tt.func @size1_negative(%x: !tt.ptr<f32>) -> tensor<1x16xf32> {
    %px = tts.make_tptr %x to sizes: [1, 16], strides: [-8, 1], offsets: [0, 0], shape: [0, 0], order: [] : <f32> to tensor<1x16x!tt.ptr<f32>>
    %v = "tts.load"(%px) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<1x16x!tt.ptr<f32>>) -> tensor<1x16xf32>
    tt.return %v : tensor<1x16xf32>
  }
}

// -----

module {
  // CHECK-LABEL: tt.func @size1_bad(
  // CHECK: memref.reinterpret_cast %{{.*}} to offset: [0], sizes: [{{.*}}], strides: [16, 1] : memref<?xf32> to memref<{{.*}}xf32, strided<[16, 1]>>
  // CHECK: memref.subview %{{.*}}[0, 0] [1, 16] [1, 1]
  tt.func @size1_bad(%x: !tt.ptr<f32>, %a: index, %b: index) -> tensor<1x16xf32> {
    %ab = arith.muli %a, %b : index
    %px = tts.make_tptr %x to sizes: [1, 16], strides: [%ab, 1], offsets: [0, 0], shape: [0, 0], order: [] : <f32> to tensor<1x16x!tt.ptr<f32>>
    %v = "tts.load"(%px) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<1x16x!tt.ptr<f32>>) -> tensor<1x16xf32>
    tt.return %v : tensor<1x16xf32>
  }
}

// -----

module {
  // 复杂行距乘出来的平坦偏移（这一维的下标不为 0）：整个归给行距为 1 的那一维
  // CHECK-LABEL: tt.func @size1_bad_with_offset(
  // CHECK: memref.subview %{{.*}}[0, %{{.*}}] [1, 16] [1, 1]
  tt.func @size1_bad_with_offset(%x: !tt.ptr<f32>, %a: index, %b: index, %i: index) -> tensor<1x16xf32> {
    %ab = arith.muli %a, %b : index
    %flat = arith.muli %i, %ab : index
    %px = tts.make_tptr %x to sizes: [1, 16], strides: [%ab, 1], offsets: [%flat, 0], shape: [0, 0], order: [] : <f32> to tensor<1x16x!tt.ptr<f32>>
    %v = "tts.load"(%px) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<1x16x!tt.ptr<f32>>) -> tensor<1x16xf32>
    tt.return %v : tensor<1x16xf32>
  }
}
