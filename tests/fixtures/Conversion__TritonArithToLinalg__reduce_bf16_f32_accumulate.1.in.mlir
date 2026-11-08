// 归约的 bf16 输入一律先 extf 成 f32 再累加，累加完 truncf 回 bf16 一次：sum、max 都一样，
// 结果是标量还是张量也一样（基线只在结果是标量的 sum 上这样做，张量结果与 max 留着 bf16 逐步舍入）。
// RUN: dope-opt --split-input-file --triton-arith-to-linalg %s | FileCheck %s

module {
  // 张量结果的 sum：输出缓冲是 f32，体里是「extf 元素、addf」，末了对整个结果 truncf 一次
  // CHECK-LABEL: func.func @sum_rows_bf16(
  // CHECK: %[[ZERO:.+]] = arith.constant 0.000000e+00 : f32
  // CHECK: %[[EMPTY:.+]] = tensor.empty() : tensor<4xf32>
  // CHECK: %[[INIT:.+]] = linalg.fill ins(%[[ZERO]] : f32) outs(%[[EMPTY]] : tensor<4xf32>) -> tensor<4xf32>
  // CHECK: %[[RED:.+]] = linalg.reduce ins(%{{.*}} : tensor<4x128xbf16>) outs(%[[INIT]] : tensor<4xf32>) dimensions = [1]
  // CHECK: (%[[IN:.+]]: bf16, %[[ACC:.+]]: f32) {
  // CHECK:   %[[EXT:.+]] = arith.extf %[[IN]] : bf16 to f32
  // CHECK:   %[[SUM:.+]] = arith.addf %[[EXT]], %[[ACC]] : f32
  // CHECK:   linalg.yield %[[SUM]] : f32
  // CHECK: }
  // CHECK: %[[OUT:.+]] = linalg.generic {{.*}} ins(%[[RED]] : tensor<4xf32>) outs(%{{.*}} : tensor<4xbf16>) {
  // CHECK:   arith.truncf %{{.*}} : f32 to bf16
  // CHECK: } -> tensor<4xbf16>
  // CHECK-NOT: arith.truncf
  // CHECK: tt.store %{{.*}}, %[[OUT]]
  tt.func @sum_rows_bf16(%s: bf16, %o: tensor<4x!tt.ptr<bf16>>) {
    %x = tt.splat %s : bf16 -> tensor<4x128xbf16>
    %r = "tt.reduce"(%x) ({
    ^bb0(%a: bf16, %b: bf16):
      %c = arith.addf %a, %b : bf16
      tt.reduce.return %c : bf16
    }) {axis = 1 : i32} : (tensor<4x128xbf16>) -> tensor<4xbf16>
    tt.store %o, %r : tensor<4x!tt.ptr<bf16>>
    tt.return
  }
}

// -----

module {
  // 张量结果的 max：同样升 f32，幺元是 f32 的 -inf（0xFF800000），不是 bf16 的 -inf
  // CHECK-LABEL: func.func @max_rows_bf16(
  // CHECK: %[[NEGINF:.+]] = arith.constant 0xFF800000 : f32
  // CHECK: %[[INIT:.+]] = linalg.fill ins(%[[NEGINF]] : f32) outs(%{{.*}} : tensor<4xf32>) -> tensor<4xf32>
  // CHECK: %[[RED:.+]] = linalg.reduce ins(%{{.*}} : tensor<4x128xbf16>) outs(%[[INIT]] : tensor<4xf32>) dimensions = [1]
  // CHECK: (%[[IN:.+]]: bf16, %[[ACC:.+]]: f32) {
  // CHECK:   %[[EXT:.+]] = arith.extf %[[IN]] : bf16 to f32
  // CHECK:   %[[MAX:.+]] = arith.maximumf %[[EXT]], %[[ACC]] : f32
  // CHECK:   linalg.yield %[[MAX]] : f32
  // CHECK: }
  // CHECK: linalg.generic {{.*}} ins(%[[RED]] : tensor<4xf32>) outs(%{{.*}} : tensor<4xbf16>) {
  // CHECK:   arith.truncf %{{.*}} : f32 to bf16
  // CHECK: } -> tensor<4xbf16>
  // CHECK-NOT: arith.truncf
  tt.func @max_rows_bf16(%s: bf16, %o: tensor<4x!tt.ptr<bf16>>) {
    %x = tt.splat %s : bf16 -> tensor<4x128xbf16>
    %r = "tt.reduce"(%x) ({
    ^bb0(%a: bf16, %b: bf16):
      %c = arith.maximumf %a, %b : bf16
      tt.reduce.return %c : bf16
    }) {axis = 1 : i32} : (tensor<4x128xbf16>) -> tensor<4xbf16>
    tt.store %o, %r : tensor<4x!tt.ptr<bf16>>
    tt.return
  }
}

// -----

module {
  // 一维全归约到标量的 max：基线只对标量结果的 sum 升 f32，max 留着 bf16
  // CHECK-LABEL: func.func @max_all_bf16(
  // CHECK: %[[NEGINF:.+]] = arith.constant 0xFF800000 : f32
  // CHECK: linalg.fill ins(%[[NEGINF]] : f32) outs(%{{.*}} : tensor<f32>) -> tensor<f32>
  // CHECK: linalg.reduce ins(%{{.*}} : tensor<128xbf16>) outs(%{{.*}} : tensor<f32>) dimensions = [0]
  // CHECK: (%[[IN:.+]]: bf16, %[[ACC:.+]]: f32) {
  // CHECK:   %[[EXT:.+]] = arith.extf %[[IN]] : bf16 to f32
  // CHECK:   %[[MAX:.+]] = arith.maximumf %[[EXT]], %[[ACC]] : f32
  // CHECK: }
  // CHECK: %[[SCALAR:.+]] = tensor.extract %{{.*}}[] : tensor<f32>
  // CHECK: arith.truncf %[[SCALAR]] : f32 to bf16
  tt.func @max_all_bf16(%s: bf16, %o: !tt.ptr<bf16>) {
    %x = tt.splat %s : bf16 -> tensor<128xbf16>
    %r = "tt.reduce"(%x) ({
    ^bb0(%a: bf16, %b: bf16):
      %c = arith.maximumf %a, %b : bf16
      tt.reduce.return %c : bf16
    }) {axis = 0 : i32} : (tensor<128xbf16>) -> bf16
    tt.store %o, %r : !tt.ptr<bf16>
    tt.return
  }
}

// -----

module {
  // f32 的归约不受影响：没有 extf、没有 truncf
  // CHECK-LABEL: func.func @sum_rows_f32(
  // CHECK-NOT: arith.extf
  // CHECK: linalg.reduce ins(%{{.*}} : tensor<4x128xf32>) outs(%{{.*}} : tensor<4xf32>) dimensions = [1]
  // CHECK-NOT: arith.truncf
  tt.func @sum_rows_f32(%s: f32, %o: tensor<4x!tt.ptr<f32>>) {
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
