// dope-split-row-axis：行偏移里有 i16 的常量（经 extsi 到 i32）。重建行偏移时 to_i64 只认 i32 / i64，i16 记下失败，可失败只在
// 下一片行叶之前查，最后一片（这里也是唯一一片）重建完不查，造出 arith.muli (i16, i64) -> i16。认不出就整条访存原样不动；
// 参照造出同样的 op，过不了它自己的校验。
// RUN: dope-opt %s --dope-split-row-axis

module {
  tt.func public @narrow_row_constant(%q: !tt.ptr<f32>, %v: tensor<16xf32>, %tok0: i32, %qpos0: i32) {
    %c4 = arith.constant dense<4> : tensor<16xi32>
    %m = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %t = arith.divsi %m, %c4 : tensor<16xi32>
    %qp0 = tt.splat %qpos0 : i32 -> tensor<16xi32>
    %qpos = arith.addi %qp0, %t : tensor<16xi32>
    %tk0 = tt.splat %tok0 : i32 -> tensor<16xi32>
    %row0 = arith.addi %tk0, %qpos : tensor<16xi32>
    %h = arith.remsi %m, %c4 : tensor<16xi32>
    %k16 = arith.constant dense<3> : tensor<16xi16>
    %k = arith.extsi %k16 : tensor<16xi16> to tensor<16xi32>
    %row1 = arith.addi %k, %h : tensor<16xi32>
    %c512 = arith.constant dense<512> : tensor<16xi32>
    %c16 = arith.constant dense<16> : tensor<16xi32>
    %a0 = arith.muli %row0, %c512 : tensor<16xi32>
    %a1 = arith.muli %row1, %c16 : tensor<16xi32>
    %off = arith.addi %a0, %a1 : tensor<16xi32>
    %qs = tt.splat %q : !tt.ptr<f32> -> tensor<16x!tt.ptr<f32>>
    %qa = tt.addptr %qs, %off : tensor<16x!tt.ptr<f32>>, tensor<16xi32>
    tt.store %qa, %v : tensor<16x!tt.ptr<f32>>
    tt.return
  }
}
