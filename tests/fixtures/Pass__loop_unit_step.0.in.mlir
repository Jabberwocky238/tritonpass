// dope-loop-unit-step 单跑（分配缓冲之后的 index 循环）：上界是运行期值、步长是常量且大于 1 的 scf.for 改写成下界 0、步长 1、
// 上界向上取整的轮数，体里用 下界 + j * 步长；上界是常数的循环、步长 1 的循环原样不动。
// RUN: dope-opt --split-input-file --dope-loop-unit-step %s | FileCheck %s

// CHECK-LABEL: func.func @block_scan(
// CHECK: %[[SPAN:.+]] = arith.subi %arg1, %arg0 : index
// CHECK: %[[ROUNDED:.+]] = arith.addi %[[SPAN]], %{{.+}} : index
// CHECK: %[[TRIPS:.+]] = arith.divsi %[[ROUNDED]], %{{.+}} : index
// CHECK: scf.for %[[J:.+]] = %{{.+}} to %[[TRIPS]] step %{{.+}} {
// CHECK: %[[SCALED:.+]] = arith.muli %[[J]], %{{.+}} : index
// CHECK: %[[START:.+]] = arith.addi %[[SCALED]], %arg0 : index
// CHECK: memref.subview %arg2[%[[START]]]
module {
  func.func @block_scan(%lo: index, %hi: index, %buf: memref<?xf32>) {
    %c512 = arith.constant 512 : index
    scf.for %i = %lo to %hi step %c512 {
      %w = memref.subview %buf[%i] [512] [1] : memref<?xf32> to memref<512xf32, strided<[1], offset: ?>>
    }
    return
  }
}

// -----

// 携带值原样带过去，结果换成新循环的结果
// CHECK-LABEL: func.func @carried(
// CHECK: %[[R:.+]] = scf.for %{{.+}} = %{{.+}} to %{{.+}} step %{{.+}} iter_args(%[[ACC:.+]] = %arg2) -> (f32) {
// CHECK: return %[[R]]
module {
  func.func @carried(%lo: index, %hi: index, %init: f32) -> f32 {
    %c4 = arith.constant 4 : index
    %r = scf.for %i = %lo to %hi step %c4 iter_args(%acc = %init) -> (f32) {
      scf.yield %acc : f32
    }
    return %r : f32
  }
}

// -----

// 上界是常数：不动
// CHECK-LABEL: func.func @constant_upper(
// CHECK-NOT: arith.divsi
module {
  func.func @constant_upper(%lo: index) {
    %c4 = arith.constant 4 : index
    %c100 = arith.constant 100 : index
    scf.for %i = %lo to %c100 step %c4 {
    }
    return
  }
}

// -----

// 步长 1：不动
// CHECK-LABEL: func.func @unit_step(
// CHECK-NOT: arith.divsi
module {
  func.func @unit_step(%lo: index, %hi: index) {
    %c1 = arith.constant 1 : index
    scf.for %i = %lo to %hi step %c1 {
    }
    return
  }
}
