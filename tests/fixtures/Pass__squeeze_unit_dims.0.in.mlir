// dope-squeeze-unit-dims（P5 与 P8 之间）：访存窗口里 size 为 1 且行距为 0 的维（expand_dims
// 留下的）没有真实的范围，从窗口里去掉：tts.make_tptr 的平坦偏移是各维之和，丢掉的维的偏移并进第一个留下的维；
// mask 里丢掉的维（0 或 1 个有效）并进留下的维。读出来的值再 tensor.expand_shape 回原形，存入的值先 tensor.collapse_shape。
// 这样窗口与 tile 都不带 size 为 1 的维（合同的窗口不降秩，也没有 reshape），后面把 expand_shape 折进消费者的 map。
// RUN: dope-opt --split-input-file --dope-squeeze-unit-dims %s | FileCheck %s

// 读：1x32 的窗口变一维的 32
module {
  // CHECK-LABEL: tt.func public @load_row(
  // CHECK-SAME: %[[P:.*]]: !tt.ptr<i8>, %[[N:.*]]: index)
  tt.func public @load_row(%p: !tt.ptr<i8>, %n: index) -> tensor<1x32xi8> {
    %m = tts.make_tptr %p to sizes: [1, 32], strides: [0, 1], offsets: [%n, 0], shape: [0, 0], order: [] : <i8> to tensor<1x32x!tt.ptr<i8>>
    // CHECK: %[[M:.*]] = tts.make_tptr %[[P]] to sizes: [32], strides: [1], offsets: [%[[N]]], shape: [0], order: [] : <i8> to tensor<32x!tt.ptr<i8>>
    // CHECK: %[[V:.*]] = "tts.load"(%[[M]]) {{.*}} : (tensor<32x!tt.ptr<i8>>) -> tensor<32xi8>
    // CHECK: %[[E:.*]] = tensor.expand_shape %[[V]] {{\[\[}}0, 1{{\]\]}} output_shape [1, 32] : tensor<32xi8> into tensor<1x32xi8>
    %v = "tts.load"(%m) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<1x32x!tt.ptr<i8>>) -> tensor<1x32xi8>
    // CHECK: return %[[E]]
    tt.return %v : tensor<1x32xi8>
  }
}

// -----

// 读：32x1 的列向量，留下的维保持原来的行距
module {
  // CHECK-LABEL: tt.func public @load_col(
  tt.func public @load_col(%p: !tt.ptr<f32>) -> tensor<32x1xf32> {
    // CHECK: tts.make_tptr %{{.*}} to sizes: [32], strides: [64], offsets: [0], shape: [0], order: [] : <f32> to tensor<32x!tt.ptr<f32>>
    %m = tts.make_tptr %p to sizes: [32, 1], strides: [64, 0], offsets: [0, 0], shape: [0, 0], order: [] : <f32> to tensor<32x1x!tt.ptr<f32>>
    // CHECK: tensor.expand_shape %{{.*}} {{\[\[}}0, 1{{\]\]}} output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %v = "tts.load"(%m) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<32x1x!tt.ptr<f32>>) -> tensor<32x1xf32>
    tt.return %v : tensor<32x1xf32>
  }
}

// -----

// 读带 mask：丢掉的维的有效个数（0 或 1）乘进留下的维
module {
  // CHECK-LABEL: tt.func public @load_masked(
  // CHECK-SAME: %[[P:.*]]: !tt.ptr<f32>, %[[R:.*]]: index, %[[C:.*]]: index)
  tt.func public @load_masked(%p: !tt.ptr<f32>, %r: index, %c: index) -> tensor<1x32xf32> {
    %m = tts.make_tptr %p to sizes: [1, 32], strides: [0, 1], offsets: [0, 0], shape: [0, 0], order: [] : <f32> to tensor<1x32x!tt.ptr<f32>>
    // CHECK: %[[VALID:.*]] = arith.muli %[[C]], %[[R]] : index
    // CHECK: "tts.load"(%{{.*}}, %[[VALID]])
    %v = "tts.load"(%m, %r, %c) <{operandSegmentSizes = array<i32: 1, 2, 0>, static_mask_dims = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<1x32x!tt.ptr<f32>>, index, index) -> tensor<1x32xf32>
    tt.return %v : tensor<1x32xf32>
  }
}

// -----

// 写：值先 collapse_shape
module {
  // CHECK-LABEL: tt.func public @store_row(
  // CHECK-SAME: %[[O:.*]]: !tt.ptr<f32>, %[[V:.*]]: tensor<1x32xf32>)
  tt.func public @store_row(%o: !tt.ptr<f32>, %v: tensor<1x32xf32>) {
    %m = tts.make_tptr %o to sizes: [1, 32], strides: [0, 1], offsets: [0, 0], shape: [0, 0], order: [] : <f32> to tensor<1x32x!tt.ptr<f32>>
    // CHECK: %[[C:.*]] = tensor.collapse_shape %[[V]] {{\[\[}}0, 1{{\]\]}} : tensor<1x32xf32> into tensor<32xf32>
    // CHECK: "tts.store"(%{{.*}}, %[[C]]) {{.*}} : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "tts.store"(%m, %v) <{static_mask_dims = array<i64>}> : (tensor<1x32x!tt.ptr<f32>>, tensor<1x32xf32>) -> ()
    tt.return
  }
}

// -----

// 没有 size 为 1 的维的窗口不动
module {
  // CHECK-LABEL: tt.func public @untouched(
  tt.func public @untouched(%p: !tt.ptr<f32>) -> tensor<16x32xf32> {
    // CHECK: tts.make_tptr %{{.*}} to sizes: [16, 32], strides: [32, 1], offsets: [0, 0]
    %m = tts.make_tptr %p to sizes: [16, 32], strides: [32, 1], offsets: [0, 0], shape: [0, 0], order: [] : <f32> to tensor<16x32x!tt.ptr<f32>>
    // CHECK-NOT: tensor.expand_shape
    %v = "tts.load"(%m) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<16x32x!tt.ptr<f32>>) -> tensor<16x32xf32>
    tt.return %v : tensor<16x32xf32>
  }
}

// -----

// 读带静态 mask：丢掉的维静态为 1 时留下的维的 mask 原样，静态为 0 时整个无效
module {
  // CHECK-LABEL: tt.func public @load_static_mask(
  tt.func public @load_static_mask(%p: !tt.ptr<f32>) -> (tensor<1x32xf32>, tensor<1x32xf32>) {
    %m = tts.make_tptr %p to sizes: [1, 32], strides: [0, 1], offsets: [0, 0], shape: [0, 0], order: [] : <f32> to tensor<1x32x!tt.ptr<f32>>
    // CHECK: "tts.load"(%{{.*}}) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64: 20>}>
    %a = "tts.load"(%m) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64: 1, 20>}> : (tensor<1x32x!tt.ptr<f32>>) -> tensor<1x32xf32>
    // CHECK: "tts.load"(%{{.*}}) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64: 0>}>
    %b = "tts.load"(%m) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64: 0, 20>}> : (tensor<1x32x!tt.ptr<f32>>) -> tensor<1x32xf32>
    tt.return %a, %b : tensor<1x32xf32>, tensor<1x32xf32>
  }
}

// -----

// 中间的单位维：丢掉的维归入前一个留下的维的组，它的偏移并进第一个留下的维
module {
  // CHECK-LABEL: tt.func public @load_middle(
  // CHECK-SAME: %[[P:.*]]: !tt.ptr<f32>, %[[K:.*]]: index)
  tt.func public @load_middle(%p: !tt.ptr<f32>, %k: index) -> tensor<4x1x8xf32> {
    // CHECK: %[[OFF:.*]] = arith.addi %{{.*}}, %{{.*}} : index
    // CHECK: tts.make_tptr %[[P]] to sizes: [4, 8], strides: [8, 1], offsets: [%[[OFF]], 0]
    %m = tts.make_tptr %p to sizes: [4, 1, 8], strides: [8, 0, 1], offsets: [16, %k, 0], shape: [0, 0, 0], order: [] : <f32> to tensor<4x1x8x!tt.ptr<f32>>
    // CHECK: tensor.expand_shape %{{.*}} {{\[\[}}0, 1], [2{{\]\]}} output_shape [4, 1, 8] : tensor<4x8xf32> into tensor<4x1x8xf32>
    %v = "tts.load"(%m) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<4x1x8x!tt.ptr<f32>>) -> tensor<4x1x8xf32>
    tt.return %v : tensor<4x1x8xf32>
  }
}

// -----

// 全是单位维：留最后一维
module {
  // CHECK-LABEL: tt.func public @load_all_units(
  tt.func public @load_all_units(%p: !tt.ptr<f32>) -> tensor<1x1xf32> {
    // CHECK: tts.make_tptr %{{.*}} to sizes: [1], strides: [0], offsets: [0], shape: [0], order: []
    %m = tts.make_tptr %p to sizes: [1, 1], strides: [0, 0], offsets: [0, 0], shape: [0, 0], order: [] : <f32> to tensor<1x1x!tt.ptr<f32>>
    // CHECK: tensor.expand_shape %{{.*}} {{\[\[}}0, 1{{\]\]}} output_shape [1, 1] : tensor<1xf32> into tensor<1x1xf32>
    %v = "tts.load"(%m) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<1x1x!tt.ptr<f32>>) -> tensor<1x1xf32>
    tt.return %v : tensor<1x1xf32>
  }
}

// -----

// 拆行轴（dope-split-row-axis）的 kernel：module 带 dope.split_row_axis。一维的行结果造出来的 [t, h, 1] 窗口，被丢的单位维上没有行距为 1 的维、
// 偏移是标量，要保留那个单位维当载体；但这种 kernel 里还有大量别的单位维广播（`m[:, None]`），不能整个 kernel 都不去单位维：
// 只把这个窗口留着，不设 dope.keep_unit_dims，别的窗口照旧去单位维；标记 dope.split_row_axis 用完摘掉。
// CHECK-NOT: dope.split_row_axis
// CHECK-NOT: dope.keep_unit_dims
module attributes {dope.split_row_axis} {
  // CHECK-LABEL: tt.func public @split_window_keeps_carrier(
  tt.func public @split_window_keeps_carrier(%o: !tt.ptr<f32>, %v: tensor<4x4x1xf32>, %n: index) {
    // CHECK: tts.make_tptr %{{.*}} to sizes: [4, 4, 1], strides: [512, 16, 0], offsets: [0, 0, %{{.*}}], shape: [0, 0, 0], order: [] : <f32> to tensor<4x4x1x!tt.ptr<f32>>
    %m = tts.make_tptr %o to sizes: [4, 4, 1], strides: [512, 16, 0], offsets: [0, 0, %n], shape: [0, 0, 0], order: [] : <f32> to tensor<4x4x1x!tt.ptr<f32>>
    // CHECK: "tts.store"(%{{.*}}, %arg1) {{.*}} : (tensor<4x4x1x!tt.ptr<f32>>, tensor<4x4x1xf32>) -> ()
    "tts.store"(%m, %v) <{static_mask_dims = array<i64>}> : (tensor<4x4x1x!tt.ptr<f32>>, tensor<4x4x1xf32>) -> ()
    tt.return
  }

  // 同一个 module 里别的窗口照旧去单位维
  // CHECK-LABEL: tt.func public @other_window_squeezed(
  tt.func public @other_window_squeezed(%p: !tt.ptr<f32>) -> tensor<1x32xf32> {
    // CHECK: tts.make_tptr %{{.*}} to sizes: [32], strides: [1], offsets: [0], shape: [0], order: [] : <f32> to tensor<32x!tt.ptr<f32>>
    %m = tts.make_tptr %p to sizes: [1, 32], strides: [0, 1], offsets: [0, 0], shape: [0, 0], order: [] : <f32> to tensor<1x32x!tt.ptr<f32>>
    %v = "tts.load"(%m) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<1x32x!tt.ptr<f32>>) -> tensor<1x32xf32>
    tt.return %v : tensor<1x32xf32>
  }
}

// -----

// 没有 dope.split_row_axis 的 kernel 里同样的窗口：整个 kernel 不去单位维，也不跑后面的单位维折叠（dope.keep_unit_dims 标记，由折叠一步用完摘掉）
// CHECK: module attributes {dope.keep_unit_dims}
module {
  // CHECK-LABEL: tt.func public @whole_kernel_keeps_unit_dims(
  tt.func public @whole_kernel_keeps_unit_dims(%o: !tt.ptr<f32>, %v: tensor<4x4x1xf32>, %p: !tt.ptr<f32>) -> tensor<1x32xf32> {
    %n = arith.constant 7 : index
    // CHECK: tts.make_tptr %{{.*}} to sizes: [4, 4, 1], strides: [512, 16, 0], offsets: [0, 0, %{{.*}}]
    %m = tts.make_tptr %o to sizes: [4, 4, 1], strides: [512, 16, 0], offsets: [0, 0, %n], shape: [0, 0, 0], order: [] : <f32> to tensor<4x4x1x!tt.ptr<f32>>
    "tts.store"(%m, %v) <{static_mask_dims = array<i64>}> : (tensor<4x4x1x!tt.ptr<f32>>, tensor<4x4x1xf32>) -> ()
    // CHECK: tts.make_tptr %{{.*}} to sizes: [1, 32], strides: [0, 1]
    %w = tts.make_tptr %p to sizes: [1, 32], strides: [0, 1], offsets: [0, 0], shape: [0, 0], order: [] : <f32> to tensor<1x32x!tt.ptr<f32>>
    %r = "tts.load"(%w) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<1x32x!tt.ptr<f32>>) -> tensor<1x32xf32>
    tt.return %r : tensor<1x32xf32>
  }
}
