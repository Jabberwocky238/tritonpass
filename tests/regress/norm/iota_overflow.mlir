// dope-fold-iota-integers：分析在 i64 里照 i32 的表达式算常量，没管 i32 的回绕；连乘两次 INT_MIN 后 i64 也溢出了。按 i32 的语义
// arange(0, 4) * INT_MIN * INT_MIN 每一格都是 0，掩码是 0 < n。溢出就认不出、原样不动（以前除法 i64::MIN / -1 处 panic，
// debug 构建里乘法先 panic）。参照在 int64 里回绕着照样折，两块都折出错的常量（如 -4.6e18）。
// RUN: dope-opt %s --split-input-file --dope-fold-iota-integers

module {
  tt.func public @divide_overflow(%x: tensor<4xf32>, %n: i32) -> tensor<4xf32> {
    %r = tt.make_range {end = 4 : i32, start = 0 : i32} : tensor<4xi32>
    %k = arith.constant dense<-2147483648> : tensor<4xi32>
    %a = arith.muli %r, %k : tensor<4xi32>
    %b = arith.muli %a, %k : tensor<4xi32>
    %m1 = arith.constant dense<-1> : tensor<4xi32>
    %c = arith.divsi %b, %m1 : tensor<4xi32>
    %ns = tt.splat %n : i32 -> tensor<4xi32>
    %cmp = arith.cmpi slt, %c, %ns : tensor<4xi32>
    %zero = arith.constant dense<0.0> : tensor<4xf32>
    %s = arith.select %cmp, %x, %zero : tensor<4xi1>, tensor<4xf32>
    tt.return %s : tensor<4xf32>
  }
}

// -----

module {
  tt.func public @multiply_overflow(%x: tensor<4xf32>, %n: i32) -> tensor<4xf32> {
    %r = tt.make_range {end = 4 : i32, start = 0 : i32} : tensor<4xi32>
    %k = arith.constant dense<-2147483648> : tensor<4xi32>
    %a = arith.muli %r, %k : tensor<4xi32>
    %b = arith.muli %a, %k : tensor<4xi32>
    %ns = tt.splat %n : i32 -> tensor<4xi32>
    %cmp = arith.cmpi slt, %b, %ns : tensor<4xi32>
    %zero = arith.constant dense<0.0> : tensor<4xf32>
    %s = arith.select %cmp, %x, %zero : tensor<4xi1>, tensor<4xf32>
    tt.return %s : tensor<4xf32>
  }
}
