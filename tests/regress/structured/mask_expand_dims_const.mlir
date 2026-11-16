// mask 是常量布尔张量的 tt.expand_dims（skip-prepass 时 canonicalize 不先把它折掉）：常量分析成标量，没有维也没有
// 非结构化 mask，按 axis 插入越界。参照断言崩溃；tritonpass 报警告、认不出这个 mask（登记在 tests/divergences/structured.txt）。
// RUN: dope-opt %s --triton-to-structured=skip-prepass=true
module {
  tt.func @k(%a: !tt.ptr<f32>, %b: !tt.ptr<f32>) {
    %t = arith.constant dense<true> : tensor<4x1xi1>
    %m3 = tt.expand_dims %t {axis = 2 : i32} : tensor<4x1xi1> -> tensor<4x1x1xi1>
    %r = tt.make_range {end = 4 : i32, start = 0 : i32} : tensor<4xi32>
    %r2 = tt.expand_dims %r {axis = 1 : i32} : tensor<4xi32> -> tensor<4x1xi32>
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
