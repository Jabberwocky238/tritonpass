// bool 指针：Triton 前端对 `*u1` 的读写先 tt.bitcast 成 !tt.ptr<i8> 再读写，
// 读出来与 0 比得 i1，写入前先扩成 i8。dope-opt 收下这一种 bitcast，缓冲按 i8 交出：
// 入口参数、splat、addptr 的类型里 !tt.ptr<i1> 全换成 !tt.ptr<i8>，bitcast 随之成了恒等、去掉。
// 别的指针 bitcast 一律 E-OP（Reject/ops.mlir）。
// RUN: dope-opt --dope-lower-bool-ptr %s | FileCheck %s

module {
  // CHECK-LABEL: tt.func public @where_like(%arg0: !tt.ptr<i8>, %arg1: !tt.ptr<f32>)
  tt.func public @where_like(%cond: !tt.ptr<i1>, %out: !tt.ptr<f32>) {
    %r = tt.make_range {end = 32 : i32, start = 0 : i32} : tensor<32xi32>
    %c0 = arith.constant dense<0> : tensor<32xi8>
    // CHECK: %[[B:.*]] = tt.splat %arg0 : !tt.ptr<i8> -> tensor<32x!tt.ptr<i8>>
    %b = tt.splat %cond : !tt.ptr<i1> -> tensor<32x!tt.ptr<i1>>
    // CHECK: %[[P:.*]] = tt.addptr %[[B]], %{{.*}} : tensor<32x!tt.ptr<i8>>, tensor<32xi32>
    %p = tt.addptr %b, %r : tensor<32x!tt.ptr<i1>>, tensor<32xi32>
    // CHECK-NOT: tt.bitcast
    %q = tt.bitcast %p : tensor<32x!tt.ptr<i1>> -> tensor<32x!tt.ptr<i8>>
    // CHECK: %[[V:.*]] = tt.load %[[P]] : tensor<32x!tt.ptr<i8>>
    %v = tt.load %q : tensor<32x!tt.ptr<i8>>
    // CHECK: arith.cmpi ne, %[[V]], %{{.*}} : tensor<32xi8>
    %m = arith.cmpi ne, %v, %c0 : tensor<32xi8>
    %zero = arith.constant dense<0.0> : tensor<32xf32>
    %one = arith.constant dense<1.0> : tensor<32xf32>
    %sel = arith.select %m, %one, %zero : tensor<32xi1>, tensor<32xf32>
    %ob = tt.splat %out : !tt.ptr<f32> -> tensor<32x!tt.ptr<f32>>
    %op = tt.addptr %ob, %r : tensor<32x!tt.ptr<f32>>, tensor<32xi32>
    tt.store %op, %sel : tensor<32x!tt.ptr<f32>>
    tt.return
  }
}
