// dope-fold-uniform-lanes 单跑：整个 tile 取同一个商的下标张量落回标量、按块对齐的取模落回 arange、arange 对常数的恒真恒假比较
// 落成常量、无 mask 的一致地址读落回一次标量读再铺开。只改写证得出的形态（下面每个「不认」的用例各自违反一条）。
// RUN: dope-opt --split-input-file --dope-fold-uniform-lanes %s | FileCheck %s

// ---- 认：TILE 等于块大小，base = j * 16 非负（scf.for 的归纳变量下界为常量 0）且是 16 的倍数 ----
// 商整个 tile 同一个 ⇒ splat(j * 16 / 16)；取模 ⇒ arange(0, 16)
// CHECK-LABEL: tt.func public @aligned(
// CHECK-NOT: arith.remsi
// CHECK: scf.for
// CHECK: arith.divsi {{.*}} : i32
// CHECK: tt.splat {{.*}} : i32 -> tensor<16xi32>
// CHECK: tt.make_range {end = 16 : i32, start = 0 : i32}
module {
  tt.func public @aligned(%out: !tt.ptr<i32>, %n: i32) {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c16 = arith.constant 16 : i32
    %cst16 = arith.constant dense<16> : tensor<16xi32>
    %r = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %os = tt.splat %out : !tt.ptr<i32> -> tensor<16x!tt.ptr<i32>>
    scf.for %j = %c0 to %n step %c1 : i32 {
      %base = arith.muli %j, %c16 : i32
      %bs = tt.splat %base : i32 -> tensor<16xi32>
      %x = arith.addi %bs, %r : tensor<16xi32>
      %q = arith.divsi %x, %cst16 : tensor<16xi32>
      %m = arith.remsi %x, %cst16 : tensor<16xi32>
      %v = arith.addi %q, %m : tensor<16xi32>
      %p = tt.addptr %os, %r : tensor<16x!tt.ptr<i32>>, tensor<16xi32>
      tt.store %p, %v : tensor<16x!tt.ptr<i32>>
    }
    tt.return
  }
}

// -----

// ---- 不认：base 不是块的倍数（j * 8，TILE 16 对块 16：商可能跨两个值）----
// CHECK-LABEL: tt.func public @base_not_a_multiple(
// CHECK: arith.divsi {{.*}} : tensor<16xi32>
// CHECK: arith.remsi {{.*}} : tensor<16xi32>
module {
  tt.func public @base_not_a_multiple(%out: !tt.ptr<i32>, %n: i32) {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c8 = arith.constant 8 : i32
    %cst16 = arith.constant dense<16> : tensor<16xi32>
    %r = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %os = tt.splat %out : !tt.ptr<i32> -> tensor<16x!tt.ptr<i32>>
    scf.for %j = %c0 to %n step %c1 : i32 {
      %base = arith.muli %j, %c8 : i32
      %bs = tt.splat %base : i32 -> tensor<16xi32>
      %x = arith.addi %bs, %r : tensor<16xi32>
      %q = arith.divsi %x, %cst16 : tensor<16xi32>
      %m = arith.remsi %x, %cst16 : tensor<16xi32>
      %v = arith.addi %q, %m : tensor<16xi32>
      %p = tt.addptr %os, %r : tensor<16x!tt.ptr<i32>>, tensor<16xi32>
      tt.store %p, %v : tensor<16x!tt.ptr<i32>>
    }
    tt.return
  }
}

// -----

// ---- 不认：base 可能是负数（入口实参乘 16，没有非负的证明）：有符号除向零取整，商不再整块同一个 ----
// CHECK-LABEL: tt.func public @base_maybe_negative(
// CHECK: arith.divsi {{.*}} : tensor<16xi32>
module {
  tt.func public @base_maybe_negative(%out: !tt.ptr<i32>, %a: i32) {
    %c16 = arith.constant 16 : i32
    %cst16 = arith.constant dense<16> : tensor<16xi32>
    %r = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %os = tt.splat %out : !tt.ptr<i32> -> tensor<16x!tt.ptr<i32>>
    %base = arith.muli %a, %c16 : i32
    %bs = tt.splat %base : i32 -> tensor<16xi32>
    %x = arith.addi %bs, %r : tensor<16xi32>
    %q = arith.divsi %x, %cst16 : tensor<16xi32>
    %p = tt.addptr %os, %r : tensor<16x!tt.ptr<i32>>, tensor<16xi32>
    tt.store %p, %q : tensor<16x!tt.ptr<i32>>
    tt.return
  }
}

// -----

// ---- 不认：TILE 32 对块 16，一个 tile 跨两个块，商取两个值 ----
// CHECK-LABEL: tt.func public @tile_spans_two_blocks(
// CHECK: arith.divsi {{.*}} : tensor<32xi32>
module {
  tt.func public @tile_spans_two_blocks(%out: !tt.ptr<i32>, %n: i32) {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c32 = arith.constant 32 : i32
    %cst16 = arith.constant dense<16> : tensor<32xi32>
    %r = tt.make_range {end = 32 : i32, start = 0 : i32} : tensor<32xi32>
    %os = tt.splat %out : !tt.ptr<i32> -> tensor<32x!tt.ptr<i32>>
    scf.for %j = %c0 to %n step %c1 : i32 {
      %base = arith.muli %j, %c32 : i32
      %bs = tt.splat %base : i32 -> tensor<32xi32>
      %x = arith.addi %bs, %r : tensor<32xi32>
      %q = arith.divsi %x, %cst16 : tensor<32xi32>
      %p = tt.addptr %os, %r : tensor<32x!tt.ptr<i32>>, tensor<32xi32>
      tt.store %p, %q : tensor<32x!tt.ptr<i32>>
    }
    tt.return
  }
}

// -----

// ---- 页号读：地址整条一致的无 mask 读落回一次标量读再铺开；带 mask 的读不动 ----
// CHECK-LABEL: tt.func public @uniform_load(
// CHECK: tt.load {{.*}} : !tt.ptr<i32>
// CHECK: tt.splat {{.*}} : i32 -> tensor<16xi32>
// CHECK-LABEL: tt.func public @masked_uniform_load(
// CHECK: tt.load {{.*}}, {{.*}} : tensor<16x!tt.ptr<i32>>
module {
  tt.func public @uniform_load(%bt: !tt.ptr<i32>, %out: !tt.ptr<i32>, %j: i32) {
    %s = tt.splat %j : i32 -> tensor<16xi32>
    %bs = tt.splat %bt : !tt.ptr<i32> -> tensor<16x!tt.ptr<i32>>
    %p = tt.addptr %bs, %s : tensor<16x!tt.ptr<i32>>, tensor<16xi32>
    %v = tt.load %p : tensor<16x!tt.ptr<i32>>
    %r = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %os = tt.splat %out : !tt.ptr<i32> -> tensor<16x!tt.ptr<i32>>
    %op = tt.addptr %os, %r : tensor<16x!tt.ptr<i32>>, tensor<16xi32>
    tt.store %op, %v : tensor<16x!tt.ptr<i32>>
    tt.return
  }
  tt.func public @masked_uniform_load(%bt: !tt.ptr<i32>, %out: !tt.ptr<i32>, %j: i32, %n: i32) {
    %s = tt.splat %j : i32 -> tensor<16xi32>
    %bs = tt.splat %bt : !tt.ptr<i32> -> tensor<16x!tt.ptr<i32>>
    %p = tt.addptr %bs, %s : tensor<16x!tt.ptr<i32>>, tensor<16xi32>
    %r = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %ns = tt.splat %n : i32 -> tensor<16xi32>
    %m = arith.cmpi slt, %r, %ns : tensor<16xi32>
    %v = tt.load %p, %m : tensor<16x!tt.ptr<i32>>
    %os = tt.splat %out : !tt.ptr<i32> -> tensor<16x!tt.ptr<i32>>
    %op = tt.addptr %os, %r : tensor<16x!tt.ptr<i32>>, tensor<16xi32>
    tt.store %op, %v : tensor<16x!tt.ptr<i32>>
    tt.return
  }
}

// -----

// ---- arange 对常数的比较每一格结果都一样 ⇒ 全真常量；有一格不同的不动 ----
// 全真的那个比较折掉之后 canonicalize 把 `andi(全真, 比较)` 化简成那个比较本身：只剩对 100 的一个 cmpi，没有 andi
// CHECK-LABEL: tt.func public @range_compare(
// CHECK-NOT: arith.andi
// CHECK: arith.cmpi slt, {{.*}} : tensor<128xi32>
// CHECK-NOT: arith.cmpi
module {
  tt.func public @range_compare(%out: !tt.ptr<i32>) {
    %r = tt.make_range {end = 128 : i32, start = 0 : i32} : tensor<128xi32>
    %c128 = arith.constant dense<128> : tensor<128xi32>
    %c100 = arith.constant dense<100> : tensor<128xi32>
    %all = arith.cmpi slt, %r, %c128 : tensor<128xi32>
    %some = arith.cmpi slt, %r, %c100 : tensor<128xi32>
    %both = arith.andi %all, %some : tensor<128xi1>
    %z = arith.constant dense<0> : tensor<128xi32>
    %o = arith.constant dense<1> : tensor<128xi32>
    %v = arith.select %both, %o, %z : tensor<128xi1>, tensor<128xi32>
    %os = tt.splat %out : !tt.ptr<i32> -> tensor<128x!tt.ptr<i32>>
    %op = tt.addptr %os, %r : tensor<128x!tt.ptr<i32>>, tensor<128xi32>
    tt.store %op, %v : tensor<128x!tt.ptr<i32>>
    tt.return
  }
}
