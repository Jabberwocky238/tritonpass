// dope-carried-buffers-in-place 单跑：scf.for 携带的 memref 改成循环外初值缓冲上原地更新、每轮末尾拷回，循环不再携带缓冲；
// 认不出的（初值缓冲在循环之后还被读、携带值互相交换）整个循环原样不动。
// RUN: dope-opt --split-input-file --dope-carried-buffers-in-place %s | FileCheck %s

// CHECK-LABEL: func.func @online_update(
// CHECK: %[[STATE:.+]] = memref.alloc() : memref<16xf32>
// CHECK: scf.for %{{.+}} = %{{.+}} to %{{.+}} step %{{.+}} {
// CHECK: %[[FRESH:.+]] = memref.alloc() : memref<16xf32>
// CHECK: memref.copy %[[FRESH]], %[[STATE]]
// CHECK-NEXT: }
// CHECK: memref.copy %[[STATE]], %arg0
module {
  func.func @online_update(%out: memref<16xf32>, %n: index) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %zero = arith.constant 0.0 : f32
    %init = memref.alloc() : memref<16xf32>
    linalg.fill ins(%zero : f32) outs(%init : memref<16xf32>)
    %final = scf.for %i = %c0 to %n step %c1 iter_args(%m = %init) -> (memref<16xf32>) {
      %fresh = memref.alloc() : memref<16xf32>
      linalg.copy ins(%m : memref<16xf32>) outs(%fresh : memref<16xf32>)
      scf.yield %fresh : memref<16xf32>
    }
    memref.copy %final, %out : memref<16xf32> to memref<16xf32>
    return
  }
}

// -----

// 初值缓冲在循环之后还被读：拷回会改掉它，不动
// CHECK-LABEL: func.func @init_read_after(
// CHECK: iter_args
module {
  func.func @init_read_after(%out: memref<16xf32>, %out2: memref<16xf32>, %n: index) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %zero = arith.constant 0.0 : f32
    %init = memref.alloc() : memref<16xf32>
    linalg.fill ins(%zero : f32) outs(%init : memref<16xf32>)
    %final = scf.for %i = %c0 to %n step %c1 iter_args(%m = %init) -> (memref<16xf32>) {
      %fresh = memref.alloc() : memref<16xf32>
      linalg.copy ins(%m : memref<16xf32>) outs(%fresh : memref<16xf32>)
      scf.yield %fresh : memref<16xf32>
    }
    memref.copy %final, %out : memref<16xf32> to memref<16xf32>
    memref.copy %init, %out2 : memref<16xf32> to memref<16xf32>
    return
  }
}

// -----

// 两个携带值互相交换：拷回的先后顺序会错，不动
// CHECK-LABEL: func.func @swap(
// CHECK: iter_args
module {
  func.func @swap(%out: memref<16xf32>, %n: index) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %zero = arith.constant 0.0 : f32
    %a = memref.alloc() : memref<16xf32>
    %b = memref.alloc() : memref<16xf32>
    linalg.fill ins(%zero : f32) outs(%a : memref<16xf32>)
    linalg.fill ins(%zero : f32) outs(%b : memref<16xf32>)
    %r:2 = scf.for %i = %c0 to %n step %c1 iter_args(%x = %a, %y = %b) -> (memref<16xf32>, memref<16xf32>) {
      scf.yield %y, %x : memref<16xf32>, memref<16xf32>
    }
    memref.copy %r#0, %out : memref<16xf32> to memref<16xf32>
    return
  }
}

// -----

// 标量携带值留在循环上，只有 memref 的改成原地
// CHECK-LABEL: func.func @mixed(
// CHECK: scf.for %{{.+}} = %{{.+}} to %{{.+}} step %{{.+}} iter_args(%{{.+}} = %{{.+}}) -> (index) {
module {
  func.func @mixed(%out: memref<16xf32>, %n: index) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %zero = arith.constant 0.0 : f32
    %init = memref.alloc() : memref<16xf32>
    linalg.fill ins(%zero : f32) outs(%init : memref<16xf32>)
    %r:2 = scf.for %i = %c0 to %n step %c1 iter_args(%m = %init, %count = %c0) -> (memref<16xf32>, index) {
      %fresh = memref.alloc() : memref<16xf32>
      linalg.copy ins(%m : memref<16xf32>) outs(%fresh : memref<16xf32>)
      %next = arith.addi %count, %c1 : index
      scf.yield %fresh, %next : memref<16xf32>, index
    }
    memref.copy %r#0, %out : memref<16xf32> to memref<16xf32>
    return
  }
}
