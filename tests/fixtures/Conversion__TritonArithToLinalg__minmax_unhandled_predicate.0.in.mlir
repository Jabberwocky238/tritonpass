// 「比较加选择」收成 min、max 的转换只认 gt、lt（浮点还有 ge、le）；别的谓词（le、ge、无序的……）它没有对应的
// min 或 max：不改写，留着比较加选择。基线在这里 llvm_unreachable，整型的 a <= b 选 a、浮点的 une 一类的合法写法
// 会把进程杀死。
// RUN: dope-opt --triton-arith-to-linalg %s | FileCheck %s

module {
  // 有符号的 slt 收成 minsi，作对照
  // CHECK-LABEL: func.func @slt_is_min(
  // CHECK: arith.minsi
  tt.func @slt_is_min(%a: tensor<8xi32>, %b: tensor<8xi32>) -> tensor<8xi32> {
    %c = arith.cmpi slt, %a, %b : tensor<8xi32>
    %v = arith.select %c, %a, %b : tensor<8xi1>, tensor<8xi32>
    tt.return %v : tensor<8xi32>
  }

  // ule、sge：不改写，比较与选择都留着
  // CHECK-LABEL: func.func @ule_stays(
  // CHECK: arith.cmpi ule
  // CHECK: arith.select
  tt.func @ule_stays(%a: tensor<8xi32>, %b: tensor<8xi32>) -> tensor<8xi32> {
    %c = arith.cmpi ule, %a, %b : tensor<8xi32>
    %v = arith.select %c, %a, %b : tensor<8xi1>, tensor<8xi32>
    tt.return %v : tensor<8xi32>
  }

  // CHECK-LABEL: func.func @sge_stays(
  // CHECK: arith.cmpi sge
  // CHECK: arith.select
  tt.func @sge_stays(%a: tensor<8xi64>, %b: tensor<8xi64>) -> tensor<8xi64> {
    %c = arith.cmpi sge, %a, %b : tensor<8xi64>
    %v = arith.select %c, %a, %b : tensor<8xi1>, tensor<8xi64>
    tt.return %v : tensor<8xi64>
  }

  // 浮点：une、ugt 同理
  // CHECK-LABEL: func.func @une_stays(
  // CHECK: arith.cmpf une
  // CHECK: arith.select
  tt.func @une_stays(%a: tensor<8xf32>, %b: tensor<8xf32>) -> tensor<8xf32> {
    %c = arith.cmpf une, %a, %b : tensor<8xf32>
    %v = arith.select %c, %a, %b : tensor<8xi1>, tensor<8xf32>
    tt.return %v : tensor<8xf32>
  }

  // CHECK-LABEL: func.func @ugt_stays(
  // CHECK: arith.cmpf ugt
  // CHECK: arith.select
  tt.func @ugt_stays(%a: tensor<8xf32>, %b: tensor<8xf32>) -> tensor<8xf32> {
    %c = arith.cmpf ugt, %a, %b : tensor<8xf32>
    %v = arith.select %c, %a, %b : tensor<8xi1>, tensor<8xf32>
    tt.return %v : tensor<8xf32>
  }
}
