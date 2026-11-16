// 两个循环串接：第二个循环携带的指针初值是第一个循环的结果。照 C++ 的 getLoopInitArgPtrState，取第一个循环的状态时用的是
// 第二个循环里的下标（取哪个携带值照搬，不在这里改）；下标连同偏移、行距越过第一个循环的携带值时参照断言崩溃，tritonpass
// 报警告、第二个循环的这个指针不当结构化的处理，读与加法原样留着（登记在 tests/divergences/structured.txt）。
// 第一块：越过第一个循环的结果个数（getResult 越界）；第二块：越过它的初值个数（getInitArgs 越界）。
// RUN: dope-opt %s --split-input-file --triton-to-structured
module {
  tt.func @kernel(%arg0 : !tt.ptr<f32>, %arg1 : !tt.ptr<f32>, %n : i32) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %i0 = arith.constant 0 : i32
    %cst4 = arith.constant dense<4> : tensor<4xi32>
    %r = tt.make_range {end = 4 : i32, start = 0 : i32} : tensor<4xi32>
    %0 = tt.splat %arg0 : !tt.ptr<f32> -> tensor<4x!tt.ptr<f32>>
    %p0 = tt.addptr %0, %r : tensor<4x!tt.ptr<f32>>, tensor<4xi32>
    %1 = tt.splat %arg1 : !tt.ptr<f32> -> tensor<4x!tt.ptr<f32>>
    %q0 = tt.addptr %1, %r : tensor<4x!tt.ptr<f32>>, tensor<4xi32>
    %res = scf.for %iv = %c0 to %c4 step %c1 iter_args(%p = %p0) -> (tensor<4x!tt.ptr<f32>>) {
      %pn = tt.addptr %p, %cst4 : tensor<4x!tt.ptr<f32>>, tensor<4xi32>
      scf.yield %pn : tensor<4x!tt.ptr<f32>>
    }
    %res2:2 = scf.for %iv = %c0 to %c4 step %c1 iter_args(%cnt = %i0, %p = %res) -> (i32, tensor<4x!tt.ptr<f32>>) {
      %v = tt.load %p : tensor<4x!tt.ptr<f32>>
      tt.store %q0, %v : tensor<4x!tt.ptr<f32>>
      %pn = tt.addptr %p, %cst4 : tensor<4x!tt.ptr<f32>>, tensor<4xi32>
      %cn = arith.addi %cnt, %n : i32
      scf.yield %cn, %pn : i32, tensor<4x!tt.ptr<f32>>
    }
    tt.return
  }
}

// -----

module {
  tt.func @kernel(%arg0 : !tt.ptr<f32>, %arg1 : !tt.ptr<f32>, %n : i32) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %i0 = arith.constant 0 : i32
    %cst4 = arith.constant dense<4> : tensor<4xi32>
    %r = tt.make_range {end = 4 : i32, start = 0 : i32} : tensor<4xi32>
    %0 = tt.splat %arg0 : !tt.ptr<f32> -> tensor<4x!tt.ptr<f32>>
    %p0 = tt.addptr %0, %r : tensor<4x!tt.ptr<f32>>, tensor<4xi32>
    %1 = tt.splat %arg1 : !tt.ptr<f32> -> tensor<4x!tt.ptr<f32>>
    %q0 = tt.addptr %1, %r : tensor<4x!tt.ptr<f32>>, tensor<4xi32>
    %res = scf.for %iv = %c0 to %c4 step %c1 iter_args(%p = %p0) -> (tensor<4x!tt.ptr<f32>>) {
      %pn = tt.addptr %p, %cst4 : tensor<4x!tt.ptr<f32>>, tensor<4xi32>
      scf.yield %pn : tensor<4x!tt.ptr<f32>>
    }
    %res2:5 = scf.for %iv = %c0 to %c4 step %c1 iter_args(%c1a = %i0, %c2a = %i0, %c3a = %i0, %cnt = %i0, %p = %res) -> (i32, i32, i32, i32, tensor<4x!tt.ptr<f32>>) {
      %v = tt.load %p : tensor<4x!tt.ptr<f32>>
      tt.store %q0, %v : tensor<4x!tt.ptr<f32>>
      %pn = tt.addptr %p, %cst4 : tensor<4x!tt.ptr<f32>>, tensor<4xi32>
      %cn = arith.addi %cnt, %n : i32
      %c1n = arith.addi %c1a, %n : i32
      %c2n = arith.addi %c2a, %n : i32
      %c3n = arith.addi %c3a, %n : i32
      scf.yield %c1n, %c2n, %c3n, %cn, %pn : i32, i32, i32, i32, tensor<4x!tt.ptr<f32>>
    }
    tt.return
  }
}
