// 结构化分析遇到逐元素不同的常量（mask 或偏移里）：分析失败、访存留着不转，不再断言把进程杀死（基线在这里断言）。
// 整条流水线在 P0 就拒收这样的常量；这里单跑结构化分析，核这道防线本身。
// RUN: dope-opt --triton-to-structured %s | FileCheck %s

module {
  // CHECK-LABEL: tt.func @nonsplat_mask(
  // 带这个 mask 的读留着 tt.load，没有变成 tts.load
  // CHECK: tt.load
  // CHECK-NOT: tts.load
  tt.func @nonsplat_mask(%x: !tt.ptr<f32>, %o: !tt.ptr<f32>) {
    %r = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %xs = tt.splat %x : !tt.ptr<f32> -> tensor<16x!tt.ptr<f32>>
    %xp = tt.addptr %xs, %r : tensor<16x!tt.ptr<f32>>, tensor<16xi32>
    %os = tt.splat %o : !tt.ptr<f32> -> tensor<16x!tt.ptr<f32>>
    %op = tt.addptr %os, %r : tensor<16x!tt.ptr<f32>>, tensor<16xi32>
    %m = arith.constant dense<[true,false,true,false,true,false,true,false,true,false,true,false,true,false,true,false]> : tensor<16xi1>
    %v = tt.load %xp, %m : tensor<16x!tt.ptr<f32>>
    tt.store %op, %v : tensor<16x!tt.ptr<f32>>
    tt.return
  }

  // CHECK-LABEL: tt.func @nonsplat_offset(
  // CHECK: tt.load
  // CHECK-NOT: tts.load
  tt.func @nonsplat_offset(%x: !tt.ptr<f32>, %o: !tt.ptr<f32>) {
    %r = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %xs = tt.splat %x : !tt.ptr<f32> -> tensor<16x!tt.ptr<f32>>
    %off = arith.constant dense<[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]> : tensor<16xi32>
    %xp = tt.addptr %xs, %off : tensor<16x!tt.ptr<f32>>, tensor<16xi32>
    %os = tt.splat %o : !tt.ptr<f32> -> tensor<16x!tt.ptr<f32>>
    %op = tt.addptr %os, %r : tensor<16x!tt.ptr<f32>>, tensor<16xi32>
    %v = tt.load %xp : tensor<16x!tt.ptr<f32>>
    tt.store %op, %v : tensor<16x!tt.ptr<f32>>
    tt.return
  }

  // 整数的按位与不是 mask 的写法：分析失败，读留着 tt.load
  // CHECK-LABEL: tt.func @andi_mask(
  // CHECK: tt.load
  // CHECK-NOT: tts.load
  tt.func @andi_mask(%x: !tt.ptr<f32>, %o: !tt.ptr<f32>, %n: i32) {
    %r = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %c15 = arith.constant dense<15> : tensor<16xi32>
    %ns = tt.splat %n : i32 -> tensor<16xi32>
    %xs = tt.splat %x : !tt.ptr<f32> -> tensor<16x!tt.ptr<f32>>
    %xp = tt.addptr %xs, %r : tensor<16x!tt.ptr<f32>>, tensor<16xi32>
    %os = tt.splat %o : !tt.ptr<f32> -> tensor<16x!tt.ptr<f32>>
    %op = tt.addptr %os, %r : tensor<16x!tt.ptr<f32>>, tensor<16xi32>
    %a = arith.andi %r, %c15 : tensor<16xi32>
    %m = arith.cmpi slt, %a, %ns : tensor<16xi32>
    %v = tt.load %xp, %m : tensor<16x!tt.ptr<f32>>
    tt.store %op, %v : tensor<16x!tt.ptr<f32>>
    tt.return
  }
}
