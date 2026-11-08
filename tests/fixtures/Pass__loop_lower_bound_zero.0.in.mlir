// dope-loop-lower-bound-zero 单跑：体里有矩阵乘、下界是运行期值、步长为 1 的 scf.for 改写成「下界 0、上界 = 原上界减原下界」，
// 体里用 j' + 原下界当原来的归纳变量；别的循环（没有矩阵乘、下界已是常数 0、步长不是 1）原样不动。
// RUN: dope-opt --split-input-file --dope-loop-lower-bound-zero %s | FileCheck %s

// CHECK-LABEL: tt.func public @runtime_lower_with_dot(
// CHECK: %[[ZERO:.+]] = arith.constant 0 : i32
// CHECK: %[[SPAN:.+]] = arith.subi %arg2, %arg1 : i32
// CHECK: scf.for %[[J:.+]] = %[[ZERO]] to %[[SPAN]] step
// CHECK: %[[ORIG:.+]] = arith.addi %[[J]], %arg1 : i32
// CHECK: arith.muli %[[ORIG]],
module {
  tt.func public @runtime_lower_with_dot(%out: !tt.ptr<f32>, %lo: i32, %hi: i32, %a: tensor<16x16xbf16>, %b: tensor<16x16xbf16>) {
    %c1 = arith.constant 1 : i32
    %c16 = arith.constant 16 : i32
    %zero = arith.constant dense<0.000000e+00> : tensor<16x16xf32>
    %r = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %acc = scf.for %j = %lo to %hi step %c1 iter_args(%s = %zero) -> (tensor<16x16xf32>) : i32 {
      %base = arith.muli %j, %c16 : i32
      %next = tt.dot %a, %b, %s : tensor<16x16xbf16> * tensor<16x16xbf16> -> tensor<16x16xf32>
      scf.yield %next : tensor<16x16xf32>
    }
    tt.return
  }
}

// -----

// 没有矩阵乘：不动
// CHECK-LABEL: tt.func public @runtime_lower_no_dot(
// CHECK-NOT: arith.subi
// CHECK: scf.for %{{.+}} = %arg0 to %arg1
module {
  tt.func public @runtime_lower_no_dot(%lo: i32, %hi: i32) {
    %c1 = arith.constant 1 : i32
    scf.for %j = %lo to %hi step %c1 : i32 {
    }
    tt.return
  }
}

// -----

// 下界已经是常数 0：不动
// CHECK-LABEL: tt.func public @zero_lower_with_dot(
// CHECK-NOT: arith.subi
module {
  tt.func public @zero_lower_with_dot(%hi: i32, %a: tensor<16x16xbf16>, %b: tensor<16x16xbf16>) {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %zero = arith.constant dense<0.000000e+00> : tensor<16x16xf32>
    %acc = scf.for %j = %c0 to %hi step %c1 iter_args(%s = %zero) -> (tensor<16x16xf32>) : i32 {
      %next = tt.dot %a, %b, %s : tensor<16x16xbf16> * tensor<16x16xbf16> -> tensor<16x16xf32>
      scf.yield %next : tensor<16x16xf32>
    }
    tt.return
  }
}

// -----

// 步长不是 1：不动（轮数 = 上下界之差除以步长向上取整，换下界要改轮数的算法，不是这里的事）
// CHECK-LABEL: tt.func public @step_two_with_dot(
// CHECK-NOT: arith.subi
module {
  tt.func public @step_two_with_dot(%lo: i32, %hi: i32, %a: tensor<16x16xbf16>, %b: tensor<16x16xbf16>) {
    %c2 = arith.constant 2 : i32
    %zero = arith.constant dense<0.000000e+00> : tensor<16x16xf32>
    %acc = scf.for %j = %lo to %hi step %c2 iter_args(%s = %zero) -> (tensor<16x16xf32>) : i32 {
      %next = tt.dot %a, %b, %s : tensor<16x16xbf16> * tensor<16x16xbf16> -> tensor<16x16xf32>
      scf.yield %next : tensor<16x16xf32>
    }
    tt.return
  }
}
