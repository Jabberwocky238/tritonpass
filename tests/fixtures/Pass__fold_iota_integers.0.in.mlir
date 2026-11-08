// dope-fold-iota-integers 单跑：arith.select 条件里只由 arange 与标量派生的整型张量比较，折成 f32 上的比较（整型张量没有加减乘除）。
// 访存的 mask 不动（结构化分析读 `arange < 界` 的原形）；认不出的比较原样留着。
// RUN: dope-opt --split-input-file --dope-fold-iota-integers %s | FileCheck %s

// ---- 因果掩码：(lim + t) <= (ctx + m // 4) ----
// 条件里没有整型张量的加、除；arange 经 sitofp 进 f32，台阶用比较加 select 搭出 m // 4，最后一次 f32 的比较
// CHECK-LABEL: tt.func public @causal(
// CHECK-NOT: arith.divsi
// CHECK-NOT: arith.cmpi sle
// CHECK: arith.sitofp {{.*}} : tensor<16xi32> to tensor<16xf32>
// CHECK: arith.cmpf oge
// CHECK: arith.select
// CHECK: arith.cmpf ole, {{.*}} : tensor<16x16xf32>
// CHECK: arith.select {{.*}} : tensor<16x16xi1>, tensor<16x16xf32>
module {
  tt.func public @causal(%x: tensor<16x16xf32>, %ctx: i32, %lim: i32) -> tensor<16x16xf32> {
    %r16 = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %c4 = arith.constant dense<4> : tensor<16xi32>
    %qp = arith.divsi %r16, %c4 : tensor<16xi32>
    %cs = tt.splat %ctx : i32 -> tensor<16xi32>
    %qa = arith.addi %cs, %qp : tensor<16xi32>
    %qa2 = tt.expand_dims %qa {axis = 1 : i32} : tensor<16xi32> -> tensor<16x1xi32>
    %qab = tt.broadcast %qa2 : tensor<16x1xi32> -> tensor<16x16xi32>
    %ls = tt.splat %lim : i32 -> tensor<16xi32>
    %so = arith.addi %ls, %r16 : tensor<16xi32>
    %so2 = tt.expand_dims %so {axis = 0 : i32} : tensor<16xi32> -> tensor<1x16xi32>
    %sob = tt.broadcast %so2 : tensor<1x16xi32> -> tensor<16x16xi32>
    %m = arith.cmpi sle, %sob, %qab : tensor<16x16xi32>
    %ninf = arith.constant dense<0xFF800000> : tensor<16x16xf32>
    %s = arith.select %m, %x, %ninf : tensor<16x16xi1>, tensor<16x16xf32>
    tt.return %s : tensor<16x16xf32>
  }
}

// -----

// ---- 访存的 mask 不动：只进 tt.load 的 mask 的 cmpi 原样留着（没有 select 用它） ----
// CHECK-LABEL: tt.func public @memory_mask_untouched(
// CHECK: arith.cmpi slt, {{.*}} : tensor<16xi32>
// CHECK-NOT: arith.cmpf
module {
  tt.func public @memory_mask_untouched(%p: tensor<16x!tt.ptr<f32>>, %n: i32) -> tensor<16xf32> {
    %r = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %ns = tt.splat %n : i32 -> tensor<16xi32>
    %m = arith.cmpi slt, %r, %ns : tensor<16xi32>
    %v = tt.load %p, %m : tensor<16x!tt.ptr<f32>>
    tt.return %v : tensor<16xf32>
  }
}

// -----

// ---- 同一个 cmpi 既进访存的 mask 又进 select：访存那一份不动，select 用折好的副本 ----
// CHECK-LABEL: tt.func public @shared_mask(
// CHECK: arith.cmpi slt, {{.*}} : tensor<16xi32>
// CHECK: tt.load
// CHECK: arith.cmpf olt
// CHECK: arith.select
module {
  tt.func public @shared_mask(%p: tensor<16x!tt.ptr<f32>>, %n: i32) -> tensor<16xf32> {
    %r = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %ns = tt.splat %n : i32 -> tensor<16xi32>
    %m = arith.cmpi slt, %r, %ns : tensor<16xi32>
    %v = tt.load %p, %m : tensor<16x!tt.ptr<f32>>
    %z = arith.constant dense<0.000000e+00> : tensor<16xf32>
    %s = arith.select %m, %v, %z : tensor<16xi1>, tensor<16xf32>
    tt.return %s : tensor<16xf32>
  }
}

// -----

// ---- 不认：两个 arange 张量相乘（不是各轴可分的和）：原样留着 ----
// CHECK-LABEL: tt.func public @product_of_ranges(
// CHECK: arith.cmpi slt, {{.*}} : tensor<16xi32>
// CHECK-NOT: arith.cmpf
module {
  tt.func public @product_of_ranges(%x: tensor<16xf32>, %n: i32) -> tensor<16xf32> {
    %r = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %sq = arith.muli %r, %r : tensor<16xi32>
    %ns = tt.splat %n : i32 -> tensor<16xi32>
    %m = arith.cmpi slt, %sq, %ns : tensor<16xi32>
    %z = arith.constant dense<0.000000e+00> : tensor<16xf32>
    %s = arith.select %m, %x, %z : tensor<16xi1>, tensor<16xf32>
    tt.return %s : tensor<16xf32>
  }
}

// -----

// ---- 不认：台阶太多（交替的 0 1 0 1 …，一个台阶一次比较，超过上限）：原样留着 ----
// CHECK-LABEL: tt.func public @too_many_steps(
// CHECK: arith.cmpi slt, {{.*}} : tensor<64xi32>
// CHECK-NOT: arith.cmpf
module {
  tt.func public @too_many_steps(%x: tensor<64xf32>, %n: i32) -> tensor<64xf32> {
    %r = tt.make_range {end = 64 : i32, start = 0 : i32} : tensor<64xi32>
    %c2 = arith.constant dense<2> : tensor<64xi32>
    %odd = arith.remsi %r, %c2 : tensor<64xi32>
    %ns = tt.splat %n : i32 -> tensor<64xi32>
    %m = arith.cmpi slt, %odd, %ns : tensor<64xi32>
    %z = arith.constant dense<0.000000e+00> : tensor<64xf32>
    %s = arith.select %m, %x, %z : tensor<64xi1>, tensor<64xf32>
    tt.return %s : tensor<64xf32>
  }
}
