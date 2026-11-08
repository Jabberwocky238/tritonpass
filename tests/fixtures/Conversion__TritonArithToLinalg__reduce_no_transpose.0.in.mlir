// 归约沿原来的轴直接 linalg.reduce，不先 linalg.transpose 把归约轴换到最前：转置落到 CalVX 是 m.transpose，
// 下游编译器不收，保留轴的 linalg.reduce 是硬要求。三维的 axis 0、1、2 各一例，再加二维的按行求和。
// RUN: dope-opt --split-input-file --triton-arith-to-linalg %s | FileCheck %s

module {
  // CHECK-LABEL: func.func @sum_axis0(
  // CHECK-NOT: linalg.transpose
  // CHECK: linalg.reduce ins(%{{.*}} : tensor<4x8x16xf32>) outs(%{{.*}} : tensor<8x16xf32>) dimensions = [0]
  // CHECK-NOT: linalg.transpose
  tt.func @sum_axis0(%s: f32, %o: tensor<8x16x!tt.ptr<f32>>) {
    %x = tt.splat %s : f32 -> tensor<4x8x16xf32>
    %r = "tt.reduce"(%x) ({
    ^bb0(%a: f32, %b: f32):
      %c = arith.addf %a, %b : f32
      tt.reduce.return %c : f32
    }) {axis = 0 : i32} : (tensor<4x8x16xf32>) -> tensor<8x16xf32>
    tt.store %o, %r : tensor<8x16x!tt.ptr<f32>>
    tt.return
  }
}

// -----

module {
  // CHECK-LABEL: func.func @sum_axis1(
  // CHECK-NOT: linalg.transpose
  // CHECK: linalg.reduce ins(%{{.*}} : tensor<4x8x16xf32>) outs(%{{.*}} : tensor<4x16xf32>) dimensions = [1]
  // CHECK-NOT: linalg.transpose
  tt.func @sum_axis1(%s: f32, %o: tensor<4x16x!tt.ptr<f32>>) {
    %x = tt.splat %s : f32 -> tensor<4x8x16xf32>
    %r = "tt.reduce"(%x) ({
    ^bb0(%a: f32, %b: f32):
      %c = arith.addf %a, %b : f32
      tt.reduce.return %c : f32
    }) {axis = 1 : i32} : (tensor<4x8x16xf32>) -> tensor<4x16xf32>
    tt.store %o, %r : tensor<4x16x!tt.ptr<f32>>
    tt.return
  }
}

// -----

module {
  // 最后一维：基线的旧写法（transpose-reduce-to-rank0 置假）也会转，这里同样不转
  // CHECK-LABEL: func.func @sum_axis2(
  // CHECK-NOT: linalg.transpose
  // CHECK: linalg.reduce ins(%{{.*}} : tensor<4x8x16xf32>) outs(%{{.*}} : tensor<4x8xf32>) dimensions = [2]
  // CHECK-NOT: linalg.transpose
  tt.func @sum_axis2(%s: f32, %o: tensor<4x8x!tt.ptr<f32>>) {
    %x = tt.splat %s : f32 -> tensor<4x8x16xf32>
    %r = "tt.reduce"(%x) ({
    ^bb0(%a: f32, %b: f32):
      %c = arith.addf %a, %b : f32
      tt.reduce.return %c : f32
    }) {axis = 2 : i32} : (tensor<4x8x16xf32>) -> tensor<4x8xf32>
    tt.store %o, %r : tensor<4x8x!tt.ptr<f32>>
    tt.return
  }
}

// -----

module {
  // 二维沿 axis 1（最常见的「按行求和」）
  // CHECK-LABEL: func.func @sum_rows(
  // CHECK-NOT: linalg.transpose
  // CHECK: linalg.reduce ins(%{{.*}} : tensor<4x128xf32>) outs(%{{.*}} : tensor<4xf32>) dimensions = [1]
  // CHECK-NOT: linalg.transpose
  tt.func @sum_rows(%s: f32, %o: tensor<4x!tt.ptr<f32>>) {
    %x = tt.splat %s : f32 -> tensor<4x128xf32>
    %r = "tt.reduce"(%x) ({
    ^bb0(%a: f32, %b: f32):
      %c = arith.addf %a, %b : f32
      tt.reduce.return %c : f32
    }) {axis = 1 : i32} : (tensor<4x128xf32>) -> tensor<4xf32>
    tt.store %o, %r : tensor<4x!tt.ptr<f32>>
    tt.return
  }
}
