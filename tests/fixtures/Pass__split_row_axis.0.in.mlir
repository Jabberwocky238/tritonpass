// dope-split-row-axis 单跑：行轴是「两个下标的乘积」的 tile（注意力 q tile 的 16 行 = 4 个 token × 4 个头，行偏移
// `(tok0 + m // 4) * stride0 + (kvh * 4 + m % 4) * stride1` 不是行号 m 的仿射函数），改成多维窗口加一次维度折叠：
// 读 = 三维 tt.load 之后 tt.reshape 回 [R, W]；写 = 值先 tt.reshape 成 [r, c, W] 再三维 tt.store；一维的行（每行一个元素）补一根长 1 的尾轴
// 当载体，窗口是 [r, c, 1]。行 mask 的两个前缀约束（token 下标 < 界、头下标 < 界）各放到各自的轴上。改写过的 module 带 `dope.split_row_axis`
// 标记（给单位维去除用）。认不出的访存整条原样不动，也不留下改写途中造出来的 op。
// RUN: dope-opt --split-input-file --dope-split-row-axis %s | FileCheck %s

module {
  // 读：Q tile 的 16 行。三维窗口 [4, 4, 128]，读完折成 [16, 128]；行 mask 是 token 下标 < qlen - qpos0 与头下标 < nh - kvh4 两个前缀约束
  // CHECK: module attributes {dope.split_row_axis}
  // CHECK-LABEL: tt.func public @load_rows(
  // CHECK-NOT: arith.divsi
  // CHECK-NOT: arith.remsi
  // CHECK: arith.cmpi slt, {{.*}} : tensor<4xi32>
  // CHECK: arith.cmpi slt, {{.*}} : tensor<4xi32>
  // CHECK: %[[PTR:.+]] = tt.addptr {{.*}} : tensor<4x4x128x!tt.ptr<bf16>>, tensor<4x4x128xi64>
  // CHECK: %[[LOAD:.+]] = tt.load %[[PTR]], {{.*}}, {{.*}} : tensor<4x4x128x!tt.ptr<bf16>>
  // CHECK: %[[FLAT:.+]] = tt.reshape %[[LOAD]] : tensor<4x4x128xbf16> -> tensor<16x128xbf16>
  // CHECK: tt.return %[[FLAT]]
  tt.func public @load_rows(%q: !tt.ptr<bf16>, %tok0: i32, %qpos0: i32, %qlen: i32, %kvh4: i32, %nh: i32, %s0: i64, %s1: i64) -> tensor<16x128xbf16> {
    %c4 = arith.constant dense<4> : tensor<16xi32>
    %m = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %d = tt.make_range {end = 128 : i32, start = 0 : i32} : tensor<128xi32>
    %t = arith.divsi %m, %c4 : tensor<16xi32>
    %qp0 = tt.splat %qpos0 : i32 -> tensor<16xi32>
    %qpos = arith.addi %qp0, %t : tensor<16xi32>
    %tk0 = tt.splat %tok0 : i32 -> tensor<16xi32>
    %row0 = arith.addi %tk0, %qpos : tensor<16xi32>
    %h = arith.remsi %m, %c4 : tensor<16xi32>
    %khs = tt.splat %kvh4 : i32 -> tensor<16xi32>
    %row1 = arith.addi %khs, %h : tensor<16xi32>
    %r0e = tt.expand_dims %row0 {axis = 1 : i32} : tensor<16xi32> -> tensor<16x1xi32>
    %r0x = arith.extsi %r0e : tensor<16x1xi32> to tensor<16x1xi64>
    %s0s = tt.splat %s0 : i64 -> tensor<16x1xi64>
    %o0 = arith.muli %r0x, %s0s : tensor<16x1xi64>
    %r1e = tt.expand_dims %row1 {axis = 1 : i32} : tensor<16xi32> -> tensor<16x1xi32>
    %r1x = arith.extsi %r1e : tensor<16x1xi32> to tensor<16x1xi64>
    %s1s = tt.splat %s1 : i64 -> tensor<16x1xi64>
    %o1 = arith.muli %r1x, %s1s : tensor<16x1xi64>
    %o01 = arith.addi %o0, %o1 : tensor<16x1xi64>
    %de = tt.expand_dims %d {axis = 0 : i32} : tensor<128xi32> -> tensor<1x128xi32>
    %dx = arith.extsi %de : tensor<1x128xi32> to tensor<1x128xi64>
    %ob = tt.broadcast %o01 : tensor<16x1xi64> -> tensor<16x128xi64>
    %db = tt.broadcast %dx : tensor<1x128xi64> -> tensor<16x128xi64>
    %off = arith.addi %ob, %db : tensor<16x128xi64>
    %qlens = tt.splat %qlen : i32 -> tensor<16xi32>
    %m0 = arith.cmpi slt, %qpos, %qlens : tensor<16xi32>
    %nhs = tt.splat %nh : i32 -> tensor<16xi32>
    %m1 = arith.cmpi slt, %row1, %nhs : tensor<16xi32>
    %m0e = tt.expand_dims %m0 {axis = 1 : i32} : tensor<16xi1> -> tensor<16x1xi1>
    %m1e = tt.expand_dims %m1 {axis = 1 : i32} : tensor<16xi1> -> tensor<16x1xi1>
    %m0b = tt.broadcast %m0e : tensor<16x1xi1> -> tensor<16x128xi1>
    %m1b = tt.broadcast %m1e : tensor<16x1xi1> -> tensor<16x128xi1>
    %mask = arith.andi %m0b, %m1b : tensor<16x128xi1>
    %qs = tt.splat %q : !tt.ptr<bf16> -> tensor<16x128x!tt.ptr<bf16>>
    %qa = tt.addptr %qs, %off : tensor<16x128x!tt.ptr<bf16>>, tensor<16x128xi64>
    %z = arith.constant dense<0.000000e+00> : tensor<16x128xbf16>
    %val = tt.load %qa, %mask, %z : tensor<16x128x!tt.ptr<bf16>>
    tt.return %val : tensor<16x128xbf16>
  }
}

// -----

module {
  // 写：算完的 [16, 128] 先拆回 [4, 4, 128]，再三维写出，mask 同读
  // CHECK: module attributes {dope.split_row_axis}
  // CHECK-LABEL: tt.func public @store_rows(
  // CHECK: %[[PTR:.+]] = tt.addptr {{.*}} : tensor<4x4x128x!tt.ptr<f32>>, tensor<4x4x128xi64>
  // CHECK: %[[SPLIT:.+]] = tt.reshape %arg1 : tensor<16x128xf32> -> tensor<4x4x128xf32>
  // CHECK: tt.store %[[PTR]], %[[SPLIT]], {{.*}} : tensor<4x4x128x!tt.ptr<f32>>
  tt.func public @store_rows(%q: !tt.ptr<f32>, %v: tensor<16x128xf32>, %tok0: i32, %qpos0: i32, %qlen: i32, %kvh4: i32, %nh: i32, %s0: i64, %s1: i64) {
    %c4 = arith.constant dense<4> : tensor<16xi32>
    %m = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %d = tt.make_range {end = 128 : i32, start = 0 : i32} : tensor<128xi32>
    %t = arith.divsi %m, %c4 : tensor<16xi32>
    %qp0 = tt.splat %qpos0 : i32 -> tensor<16xi32>
    %qpos = arith.addi %qp0, %t : tensor<16xi32>
    %tk0 = tt.splat %tok0 : i32 -> tensor<16xi32>
    %row0 = arith.addi %tk0, %qpos : tensor<16xi32>
    %h = arith.remsi %m, %c4 : tensor<16xi32>
    %khs = tt.splat %kvh4 : i32 -> tensor<16xi32>
    %row1 = arith.addi %khs, %h : tensor<16xi32>
    %r0e = tt.expand_dims %row0 {axis = 1 : i32} : tensor<16xi32> -> tensor<16x1xi32>
    %r0x = arith.extsi %r0e : tensor<16x1xi32> to tensor<16x1xi64>
    %s0s = tt.splat %s0 : i64 -> tensor<16x1xi64>
    %o0 = arith.muli %r0x, %s0s : tensor<16x1xi64>
    %r1e = tt.expand_dims %row1 {axis = 1 : i32} : tensor<16xi32> -> tensor<16x1xi32>
    %r1x = arith.extsi %r1e : tensor<16x1xi32> to tensor<16x1xi64>
    %s1s = tt.splat %s1 : i64 -> tensor<16x1xi64>
    %o1 = arith.muli %r1x, %s1s : tensor<16x1xi64>
    %o01 = arith.addi %o0, %o1 : tensor<16x1xi64>
    %de = tt.expand_dims %d {axis = 0 : i32} : tensor<128xi32> -> tensor<1x128xi32>
    %dx = arith.extsi %de : tensor<1x128xi32> to tensor<1x128xi64>
    %ob = tt.broadcast %o01 : tensor<16x1xi64> -> tensor<16x128xi64>
    %db = tt.broadcast %dx : tensor<1x128xi64> -> tensor<16x128xi64>
    %off = arith.addi %ob, %db : tensor<16x128xi64>
    %qlens = tt.splat %qlen : i32 -> tensor<16xi32>
    %m0 = arith.cmpi slt, %qpos, %qlens : tensor<16xi32>
    %nhs = tt.splat %nh : i32 -> tensor<16xi32>
    %m1 = arith.cmpi slt, %row1, %nhs : tensor<16xi32>
    %m0e = tt.expand_dims %m0 {axis = 1 : i32} : tensor<16xi1> -> tensor<16x1xi1>
    %m1e = tt.expand_dims %m1 {axis = 1 : i32} : tensor<16xi1> -> tensor<16x1xi1>
    %m0b = tt.broadcast %m0e : tensor<16x1xi1> -> tensor<16x128xi1>
    %m1b = tt.broadcast %m1e : tensor<16x1xi1> -> tensor<16x128xi1>
    %mask = arith.andi %m0b, %m1b : tensor<16x128xi1>
    %qs = tt.splat %q : !tt.ptr<f32> -> tensor<16x128x!tt.ptr<f32>>
    %qa = tt.addptr %qs, %off : tensor<16x128x!tt.ptr<f32>>, tensor<16x128xi64>
    tt.store %qa, %v, %mask : tensor<16x128x!tt.ptr<f32>>
    tt.return
  }
}

// -----

module {
  // 一维的行（每行一个元素，如 softmax 的每行最大值与指数和）：补一根长 1 的尾轴当载体，窗口 [4, 4, 1]，值先拆成 [4, 4, 1]
  // CHECK: module attributes {dope.split_row_axis}
  // CHECK-LABEL: tt.func public @store_col(
  // CHECK: tt.addptr {{.*}} : tensor<4x4x1x!tt.ptr<f32>>, tensor<4x4x1xi64>
  // CHECK: %[[SPLIT:.+]] = tt.reshape %arg1 : tensor<16xf32> -> tensor<4x4x1xf32>
  // CHECK: tt.store {{.*}}, %[[SPLIT]], {{.*}} : tensor<4x4x1x!tt.ptr<f32>>
  tt.func public @store_col(%q: !tt.ptr<f32>, %v: tensor<16xf32>, %tok0: i32, %qpos0: i32, %qlen: i32, %kvh4: i32, %nh: i32) {
    %c4 = arith.constant dense<4> : tensor<16xi32>
    %m = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %t = arith.divsi %m, %c4 : tensor<16xi32>
    %qp0 = tt.splat %qpos0 : i32 -> tensor<16xi32>
    %qpos = arith.addi %qp0, %t : tensor<16xi32>
    %tk0 = tt.splat %tok0 : i32 -> tensor<16xi32>
    %row0 = arith.addi %tk0, %qpos : tensor<16xi32>
    %h = arith.remsi %m, %c4 : tensor<16xi32>
    %khs = tt.splat %kvh4 : i32 -> tensor<16xi32>
    %row1 = arith.addi %khs, %h : tensor<16xi32>
    %c512 = arith.constant dense<512> : tensor<16xi32>
    %c16 = arith.constant dense<16> : tensor<16xi32>
    %a0 = arith.muli %row0, %c512 : tensor<16xi32>
    %a1 = arith.muli %row1, %c16 : tensor<16xi32>
    %off = arith.addi %a0, %a1 : tensor<16xi32>
    %qlens = tt.splat %qlen : i32 -> tensor<16xi32>
    %m0 = arith.cmpi slt, %qpos, %qlens : tensor<16xi32>
    %nhs = tt.splat %nh : i32 -> tensor<16xi32>
    %m1 = arith.cmpi slt, %row1, %nhs : tensor<16xi32>
    %mask = arith.andi %m0, %m1 : tensor<16xi1>
    %qs = tt.splat %q : !tt.ptr<f32> -> tensor<16x!tt.ptr<f32>>
    %qa = tt.addptr %qs, %off : tensor<16x!tt.ptr<f32>>, tensor<16xi32>
    tt.store %qa, %v, %mask : tensor<16x!tt.ptr<f32>>
    tt.return
  }
}

// -----

module {
  // 行轴没有除与取模（行偏移就是行号的仿射函数）：不改，没有标记
  // CHECK-NOT: dope.split_row_axis
  // CHECK-LABEL: tt.func public @affine_rows(
  // CHECK-NOT: tt.reshape
  // CHECK: tt.load {{.*}} : tensor<16x128x!tt.ptr<f32>>
  tt.func public @affine_rows(%q: !tt.ptr<f32>, %s0: i64) -> tensor<16x128xf32> {
    %m = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %d = tt.make_range {end = 128 : i32, start = 0 : i32} : tensor<128xi32>
    %me = tt.expand_dims %m {axis = 1 : i32} : tensor<16xi32> -> tensor<16x1xi32>
    %mx = arith.extsi %me : tensor<16x1xi32> to tensor<16x1xi64>
    %s0s = tt.splat %s0 : i64 -> tensor<16x1xi64>
    %o0 = arith.muli %mx, %s0s : tensor<16x1xi64>
    %de = tt.expand_dims %d {axis = 0 : i32} : tensor<128xi32> -> tensor<1x128xi32>
    %dx = arith.extsi %de : tensor<1x128xi32> to tensor<1x128xi64>
    %ob = tt.broadcast %o0 : tensor<16x1xi64> -> tensor<16x128xi64>
    %db = tt.broadcast %dx : tensor<1x128xi64> -> tensor<16x128xi64>
    %off = arith.addi %ob, %db : tensor<16x128xi64>
    %qs = tt.splat %q : !tt.ptr<f32> -> tensor<16x128x!tt.ptr<f32>>
    %qa = tt.addptr %qs, %off : tensor<16x128x!tt.ptr<f32>>, tensor<16x128xi64>
    %val = tt.load %qa : tensor<16x128x!tt.ptr<f32>>
    tt.return %val : tensor<16x128xf32>
  }
}

// -----

module {
  // 行 mask 不是两根轴上前缀约束的合取（这里是「或」）：认不出，整条访存原样不动，改写途中造的 op 一个不留，没有标记
  // CHECK-NOT: dope.split_row_axis
  // CHECK-LABEL: tt.func public @unrecognized_mask(
  // CHECK-NOT: tensor<4x4
  // CHECK-NOT: tt.reshape
  // CHECK: tt.load {{.*}} : tensor<16x128x!tt.ptr<bf16>>
  tt.func public @unrecognized_mask(%q: !tt.ptr<bf16>, %tok0: i32, %qpos0: i32, %qlen: i32, %kvh4: i32, %nh: i32, %s0: i64, %s1: i64) -> tensor<16x128xbf16> {
    %c4 = arith.constant dense<4> : tensor<16xi32>
    %m = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %d = tt.make_range {end = 128 : i32, start = 0 : i32} : tensor<128xi32>
    %t = arith.divsi %m, %c4 : tensor<16xi32>
    %qp0 = tt.splat %qpos0 : i32 -> tensor<16xi32>
    %qpos = arith.addi %qp0, %t : tensor<16xi32>
    %tk0 = tt.splat %tok0 : i32 -> tensor<16xi32>
    %row0 = arith.addi %tk0, %qpos : tensor<16xi32>
    %h = arith.remsi %m, %c4 : tensor<16xi32>
    %khs = tt.splat %kvh4 : i32 -> tensor<16xi32>
    %row1 = arith.addi %khs, %h : tensor<16xi32>
    %r0e = tt.expand_dims %row0 {axis = 1 : i32} : tensor<16xi32> -> tensor<16x1xi32>
    %r0x = arith.extsi %r0e : tensor<16x1xi32> to tensor<16x1xi64>
    %s0s = tt.splat %s0 : i64 -> tensor<16x1xi64>
    %o0 = arith.muli %r0x, %s0s : tensor<16x1xi64>
    %r1e = tt.expand_dims %row1 {axis = 1 : i32} : tensor<16xi32> -> tensor<16x1xi32>
    %r1x = arith.extsi %r1e : tensor<16x1xi32> to tensor<16x1xi64>
    %s1s = tt.splat %s1 : i64 -> tensor<16x1xi64>
    %o1 = arith.muli %r1x, %s1s : tensor<16x1xi64>
    %o01 = arith.addi %o0, %o1 : tensor<16x1xi64>
    %de = tt.expand_dims %d {axis = 0 : i32} : tensor<128xi32> -> tensor<1x128xi32>
    %dx = arith.extsi %de : tensor<1x128xi32> to tensor<1x128xi64>
    %ob = tt.broadcast %o01 : tensor<16x1xi64> -> tensor<16x128xi64>
    %db = tt.broadcast %dx : tensor<1x128xi64> -> tensor<16x128xi64>
    %off = arith.addi %ob, %db : tensor<16x128xi64>
    %qlens = tt.splat %qlen : i32 -> tensor<16xi32>
    %m0 = arith.cmpi slt, %qpos, %qlens : tensor<16xi32>
    %nhs = tt.splat %nh : i32 -> tensor<16xi32>
    %m1 = arith.cmpi slt, %row1, %nhs : tensor<16xi32>
    %m0e = tt.expand_dims %m0 {axis = 1 : i32} : tensor<16xi1> -> tensor<16x1xi1>
    %m1e = tt.expand_dims %m1 {axis = 1 : i32} : tensor<16xi1> -> tensor<16x1xi1>
    %m0b = tt.broadcast %m0e : tensor<16x1xi1> -> tensor<16x128xi1>
    %m1b = tt.broadcast %m1e : tensor<16x1xi1> -> tensor<16x128xi1>
    %mask = arith.ori %m0b, %m1b : tensor<16x128xi1>
    %qs = tt.splat %q : !tt.ptr<bf16> -> tensor<16x128x!tt.ptr<bf16>>
    %qa = tt.addptr %qs, %off : tensor<16x128x!tt.ptr<bf16>>, tensor<16x128xi64>
    %z = arith.constant dense<0.000000e+00> : tensor<16x128xbf16>
    %val = tt.load %qa, %mask, %z : tensor<16x128x!tt.ptr<bf16>>
    tt.return %val : tensor<16x128xbf16>
  }
}
