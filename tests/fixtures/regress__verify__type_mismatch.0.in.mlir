// 类型对不上的 IR：参照（MLIR 的 verifier）读入时就报错，tritonpass 读入之后的类型检查（tritonpass::verify）也要报错。
// mlirpass 自己的 verify 只查分支与 affine，这些以前都照样印出来。
// 流水线随便给一个 pass（mlirpass 不收空的 `builtin.module()`）：读入时就该报错，跑不到它。
// RUN: dope-opt %s --split-input-file --pass-pipeline='builtin.module(cse)'

// tt.addptr 的结果与指针不同型（TypesMatchWith）
tt.func @addptr(%a: !tt.ptr<f32>, %o: i32) {
  %q = "tt.addptr"(%a, %o) : (!tt.ptr<f32>, i32) -> !tt.ptr<i8>
  tt.return
}

// -----

// scf.for 的迭代参数与 yield 不同型
func.func @for_yield(%n: index) -> i32 {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %z = arith.constant 0 : i32
  %r = scf.for %i = %c0 to %n step %c1 iter_args(%acc = %z) -> (i32) {
    %w = arith.constant 1 : i64
    scf.yield %w : i64
  }
  return %r : i32
}

// -----

// arith.addi 的操作数与结果不同型（SameOperandsAndResultType）
func.func @addi(%a: i32, %b: i64) -> i32 {
  %c = "arith.addi"(%a, %b) : (i32, i64) -> i32
  return %c : i32
}

// -----

// func.call 的实参个数与被调函数的签名不符
func.func private @callee(i32, i32) -> i32
func.func @call(%x: i32) -> i32 {
  %r = func.call @callee(%x) : (i32) -> i32
  return %r : i32
}

// -----

// func.return 的值与函数的结果类型不符
func.func @ret(%x: i64) -> i32 {
  "func.return"(%x) : (i64) -> ()
}

// -----

// scf.if 两支 yield 的类型与结果不符
func.func @if_yield(%c: i1) -> i32 {
  %r = scf.if %c -> (i32) {
    %a = arith.constant 1 : i32
    scf.yield %a : i32
  } else {
    %b = arith.constant 2 : i64
    "scf.yield"(%b) : (i64) -> ()
  }
  return %r : i32
}

// -----

// tt.load 的结果不是指针指向的类型
tt.func @load(%p: !tt.ptr<f32>) {
  %v = "tt.load"(%p) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<f32>) -> i32
  tt.return
}
