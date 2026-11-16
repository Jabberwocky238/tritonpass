// 非结构化的行 mask 把 tts.make_tptr 换成 tts.make_gather_scatter_tptr，这一维的偏移与行距要化成 i32。它们是静态的时候，
// C++ 的 getMixedOffsets / getMixedStrides 给的是 i64 的整数属性：物化成 `arith.constant … : i64` 再 arith.trunci
// （不是 index 常量再 arith.index_cast）。后面不接 canonicalize 才看得到这两条。
// 第一块是行 mask（偏移静态），第二块是列 mask（偏移、行距都静态）。
// RUN: dope-opt %s --split-input-file --triton-to-structured
module {
  tt.func public @holed_row_mask(%in: !tt.ptr<f32>, %out: !tt.ptr<f32>) {
    %c1 = arith.constant dense<1> : tensor<4xi32>
    %c8 = arith.constant dense<8> : tensor<4x1xi32>
    %r = tt.make_range {end = 4 : i32, start = 0 : i32} : tensor<4xi32>
    %c = tt.make_range {end = 8 : i32, start = 0 : i32} : tensor<8xi32>
    %hole = arith.cmpi ne, %r, %c1 : tensor<4xi32>
    %hole2d = tt.expand_dims %hole {axis = 1 : i32} : tensor<4xi1> -> tensor<4x1xi1>
    %mask = tt.broadcast %hole2d : tensor<4x1xi1> -> tensor<4x8xi1>
    %r2d = tt.expand_dims %r {axis = 1 : i32} : tensor<4xi32> -> tensor<4x1xi32>
    %row = arith.muli %r2d, %c8 : tensor<4x1xi32>
    %rowb = tt.broadcast %row : tensor<4x1xi32> -> tensor<4x8xi32>
    %c2d = tt.expand_dims %c {axis = 0 : i32} : tensor<8xi32> -> tensor<1x8xi32>
    %colb = tt.broadcast %c2d : tensor<1x8xi32> -> tensor<4x8xi32>
    %off = arith.addi %rowb, %colb : tensor<4x8xi32>
    %ib = tt.splat %in : !tt.ptr<f32> -> tensor<4x8x!tt.ptr<f32>>
    %ip = tt.addptr %ib, %off : tensor<4x8x!tt.ptr<f32>>, tensor<4x8xi32>
    %v = tt.load %ip, %mask : tensor<4x8x!tt.ptr<f32>>
    %ob = tt.splat %out : !tt.ptr<f32> -> tensor<4x8x!tt.ptr<f32>>
    %op = tt.addptr %ob, %off : tensor<4x8x!tt.ptr<f32>>, tensor<4x8xi32>
    tt.store %op, %v, %mask : tensor<4x8x!tt.ptr<f32>>
    tt.return
  }
}

// -----

module {
  tt.func public @holed_col_mask(%in: !tt.ptr<f32>, %out: !tt.ptr<f32>) {
    %c1 = arith.constant dense<1> : tensor<8xi32>
    %c8 = arith.constant dense<8> : tensor<4x1xi32>
    %r = tt.make_range {end = 4 : i32, start = 0 : i32} : tensor<4xi32>
    %c = tt.make_range {end = 8 : i32, start = 0 : i32} : tensor<8xi32>
    %hole = arith.cmpi ne, %c, %c1 : tensor<8xi32>
    %hole2d = tt.expand_dims %hole {axis = 0 : i32} : tensor<8xi1> -> tensor<1x8xi1>
    %mask = tt.broadcast %hole2d : tensor<1x8xi1> -> tensor<4x8xi1>
    %r2d = tt.expand_dims %r {axis = 1 : i32} : tensor<4xi32> -> tensor<4x1xi32>
    %row = arith.muli %r2d, %c8 : tensor<4x1xi32>
    %rowb = tt.broadcast %row : tensor<4x1xi32> -> tensor<4x8xi32>
    %c2d = tt.expand_dims %c {axis = 0 : i32} : tensor<8xi32> -> tensor<1x8xi32>
    %colb = tt.broadcast %c2d : tensor<1x8xi32> -> tensor<4x8xi32>
    %off = arith.addi %rowb, %colb : tensor<4x8xi32>
    %ib = tt.splat %in : !tt.ptr<f32> -> tensor<4x8x!tt.ptr<f32>>
    %ip = tt.addptr %ib, %off : tensor<4x8x!tt.ptr<f32>>, tensor<4x8xi32>
    %v = tt.load %ip, %mask : tensor<4x8x!tt.ptr<f32>>
    %ob = tt.splat %out : !tt.ptr<f32> -> tensor<4x8x!tt.ptr<f32>>
    %op = tt.addptr %ob, %off : tensor<4x8x!tt.ptr<f32>>, tensor<4x8xi32>
    tt.store %op, %v, %mask : tensor<4x8x!tt.ptr<f32>>
    tt.return
  }
}
