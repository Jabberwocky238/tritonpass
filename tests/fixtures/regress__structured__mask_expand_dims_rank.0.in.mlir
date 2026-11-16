// mask 分析里 tt.expand_dims 的源分析出来的状态比源张量的秩短时，按 axis 插入 / 按维下标改会越界。参照断言崩溃；
// tritonpass 报警告、认不出这个 mask，读写原样留着（登记在 tests/divergences/structured.txt）。
// 第一块：(r != 1) & splat(c) 的与分析成功却没有维（一边认不出、另一边是标量），再 expand_dims 到第 1 维；
// 第二块：4x1 的 cmpi ne 认不出（留下非结构化 mask、没有维），再 expand_dims 成 4x1x1。
// RUN: dope-opt %s --split-input-file --triton-to-structured
module {
  tt.func @kernel(%arg0 : !tt.ptr<f32>, %arg1 : !tt.ptr<f32>, %c : i1) {
    %r = tt.make_range {end = 4 : i32, start = 0 : i32} : tensor<4xi32>
    %one = arith.constant dense<1> : tensor<4xi32>
    %ne = arith.cmpi ne, %r, %one : tensor<4xi32>
    %cs = tt.splat %c : i1 -> tensor<4xi1>
    %m1 = arith.andi %ne, %cs : tensor<4xi1>
    %m2 = tt.expand_dims %m1 {axis = 1 : i32} : tensor<4xi1> -> tensor<4x1xi1>
    %r2 = tt.expand_dims %r {axis = 1 : i32} : tensor<4xi32> -> tensor<4x1xi32>
    %p = tt.splat %arg0 : !tt.ptr<f32> -> tensor<4x1x!tt.ptr<f32>>
    %ptrs = tt.addptr %p, %r2 : tensor<4x1x!tt.ptr<f32>>, tensor<4x1xi32>
    %v = tt.load %ptrs, %m2 : tensor<4x1x!tt.ptr<f32>>
    %q = tt.splat %arg1 : !tt.ptr<f32> -> tensor<4x1x!tt.ptr<f32>>
    %qptrs = tt.addptr %q, %r2 : tensor<4x1x!tt.ptr<f32>>, tensor<4x1xi32>
    tt.store %qptrs, %v, %m2 : tensor<4x1x!tt.ptr<f32>>
    tt.return
  }
}

// -----

module {
  tt.func @k(%a: !tt.ptr<f32>, %b: !tt.ptr<f32>) {
    %one = arith.constant dense<1> : tensor<4x1xi32>
    %r = tt.make_range {end = 4 : i32, start = 0 : i32} : tensor<4xi32>
    %r2 = tt.expand_dims %r {axis = 1 : i32} : tensor<4xi32> -> tensor<4x1xi32>
    %ne = arith.cmpi ne, %r2, %one : tensor<4x1xi32>
    %m3 = tt.expand_dims %ne {axis = 2 : i32} : tensor<4x1xi1> -> tensor<4x1x1xi1>
    %r3 = tt.expand_dims %r2 {axis = 2 : i32} : tensor<4x1xi32> -> tensor<4x1x1xi32>
    %pa = tt.splat %a : !tt.ptr<f32> -> tensor<4x1x1x!tt.ptr<f32>>
    %pa2 = tt.addptr %pa, %r3 : tensor<4x1x1x!tt.ptr<f32>>, tensor<4x1x1xi32>
    %v = tt.load %pa2, %m3 : tensor<4x1x1x!tt.ptr<f32>>
    %pb = tt.splat %b : !tt.ptr<f32> -> tensor<4x1x1x!tt.ptr<f32>>
    %pb2 = tt.addptr %pb, %r3 : tensor<4x1x1x!tt.ptr<f32>>, tensor<4x1x1xi32>
    tt.store %pb2, %v, %m3 : tensor<4x1x1x!tt.ptr<f32>>
    tt.return
  }
}
