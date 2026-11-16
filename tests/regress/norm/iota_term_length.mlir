// dope-fold-iota-integers：长 1 的 arange 经 broadcast 铺到长 8 的轴上，与同一根轴上长 8 的项相加。两项长度不同，逐位相加的模型
// 表达不了（要先把长 1 的那项铺开），认不出、原样不动。参照在第一块里断言失败（idx < size()），在第二块（两个加数换了次序）里
// 只把长 1 的项加到第一位上，折出 [3, 1, 2, …, 7] 这个错的向量（应是 [3, 4, …, 10]）。
// RUN: dope-opt %s --split-input-file --dope-fold-iota-integers

module {
  tt.func public @short_term_left(%x: tensor<4x8xf32>, %n: i32) -> tensor<4x8xf32> {
    %a = tt.make_range {end = 4 : i32, start = 3 : i32} : tensor<1xi32>
    %ae = tt.expand_dims %a {axis = 0 : i32} : tensor<1xi32> -> tensor<1x1xi32>
    %ab = tt.broadcast %ae : tensor<1x1xi32> -> tensor<1x8xi32>
    %c = tt.make_range {end = 8 : i32, start = 0 : i32} : tensor<8xi32>
    %ce = tt.expand_dims %c {axis = 0 : i32} : tensor<8xi32> -> tensor<1x8xi32>
    %s = arith.addi %ab, %ce : tensor<1x8xi32>
    %sb = tt.broadcast %s : tensor<1x8xi32> -> tensor<4x8xi32>
    %ns = tt.splat %n : i32 -> tensor<4x8xi32>
    %mask = arith.cmpi slt, %sb, %ns : tensor<4x8xi32>
    %zero = arith.constant dense<0.0> : tensor<4x8xf32>
    %r = arith.select %mask, %x, %zero : tensor<4x8xi1>, tensor<4x8xf32>
    tt.return %r : tensor<4x8xf32>
  }
}

// -----

module {
  tt.func public @short_term_right(%x: tensor<4x8xf32>, %n: i32) -> tensor<4x8xf32> {
    %a = tt.make_range {end = 4 : i32, start = 3 : i32} : tensor<1xi32>
    %ae = tt.expand_dims %a {axis = 0 : i32} : tensor<1xi32> -> tensor<1x1xi32>
    %ab = tt.broadcast %ae : tensor<1x1xi32> -> tensor<1x8xi32>
    %c = tt.make_range {end = 8 : i32, start = 0 : i32} : tensor<8xi32>
    %ce = tt.expand_dims %c {axis = 0 : i32} : tensor<8xi32> -> tensor<1x8xi32>
    %s = arith.addi %ce, %ab : tensor<1x8xi32>
    %sb = tt.broadcast %s : tensor<1x8xi32> -> tensor<4x8xi32>
    %ns = tt.splat %n : i32 -> tensor<4x8xi32>
    %mask = arith.cmpi slt, %sb, %ns : tensor<4x8xi32>
    %zero = arith.constant dense<0.0> : tensor<4x8xf32>
    %r = arith.select %mask, %x, %zero : tensor<4x8xi1>, tensor<4x8xf32>
    tt.return %r : tensor<4x8xf32>
  }
}
