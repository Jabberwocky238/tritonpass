// 自定义形式里固有属性与其余属性合成一个 attr-dict，按名字排（MLIR 的 DictionaryAttr 是排好序的）。tt.store、tt.gather、tt.dot、
// tt.make_tensor_ptr、tt.make_tensor_descriptor 原先把固有属性接在后面不排（印成 `{zz = 1 : i32, boundaryCheck = …}`）。
// 夹具只比通用形式，这里只护住读入这一半；印法照 dope-opt 的重印手工核对过。
// 只读入、印出：流水线里放一个对这份输入什么也不做的 pass（tritonpass 不认空的 `builtin.module()`）。
// RUN: dope-opt %s --pass-pipeline='builtin.module(reconcile-unrealized-casts)'
module {
  tt.func public @attr_dict_order(%base: !tt.ptr<f16>, %m: i64, %n: i32, %t: tensor<16xf32>, %idx: tensor<16xi32>, %a: tensor<16x16xf16>) {
    %c0_i32 = arith.constant 0 : i32
    %c1_i64 = arith.constant 1 : i64
    %bp = tt.make_tensor_ptr %base, [%m], [%c1_i64], [%c0_i32] {order = array<i32: 0>, zz = 1 : i32} : <tensor<16xf16>>
    %v = tt.load %bp {boundaryCheck = array<i32: 0>, zz = 2 : i32} : !tt.ptr<tensor<16xf16>>
    tt.store %bp, %v {boundaryCheck = array<i32: 0>, zz = 3 : i32} : !tt.ptr<tensor<16xf16>>
    %g = tt.gather %t[%idx] {axis = 0 : i32, bz = 4 : i32, efficient_layout, zz = 4 : i32} : (tensor<16xf32>, tensor<16xi32>) -> tensor<16xf32>
    %z = arith.constant dense<0.000000e+00> : tensor<16x16xf32>
    %d = tt.dot %a, %a, %z {maxNumImpreciseAcc = 5 : i32, zz = 5 : i32} : tensor<16x16xf16> * tensor<16x16xf16> -> tensor<16x16xf32>
    %desc = tt.make_tensor_descriptor %base, [%n], [%c1_i64] {padding = 2 : i32, zz = 6 : i32} : <f16>, <tensor<16xf16>>
    tt.print "x" {hex = false, isSigned = array<i32: 0, 0>} : %g, %d : tensor<16xf32>, tensor<16x16xf32>
    tt.return
  }
}
