// 带掩码、没有 other 的读，元素是 f8E4M3FNUZ：structured-to-memref 要把掩出去的部分填 0，而 mlirformat 的 ApFloat 没有这种浮点的布局，
// 建不出 0。原先在 `ir::float` 里 panic，现在这条改写不做、tts.load 合法化失败而报错（登记在 tests/divergences/dialect.txt）。
// RUN: dope-opt %s --pass-pipeline='builtin.module(dope-lift-cf-to-scf, dope-drop-dead-exit-switch, dope-binary-search-to-for, dope-drop-thread-barrier, dope-drop-assume, dope-loop-lower-bound-zero, \
// RUN:   dope-fold-uniform-lanes, dope-fold-iota-integers, dope-split-row-axis, dope-normalize-loop-index, dope-lower-bool-ptr, dope-scalar-ptr, \
// RUN:   triton-to-structured, cse, canonicalize, triton-to-unstructured, dope-squeeze-unit-dims, triton-arith-to-linalg{pids-to-func-args=false pids-to-gpu=true}, \
// RUN:   structured-to-memref, triton-ptr-to-memref, reconcile-unrealized-casts, remove-dead-values, cse, canonicalize)'
module {
  tt.func public @masked_load_fnuz(%src: !tt.ptr<f8E4M3FNUZ>, %dst: !tt.ptr<f8E4M3FNUZ>, %n: i32) {
    %r = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %ns = tt.splat %n : i32 -> tensor<16xi32>
    %m = arith.cmpi slt, %r, %ns : tensor<16xi32>
    %ps = tt.splat %src : !tt.ptr<f8E4M3FNUZ> -> tensor<16x!tt.ptr<f8E4M3FNUZ>>
    %pa = tt.addptr %ps, %r : tensor<16x!tt.ptr<f8E4M3FNUZ>>, tensor<16xi32>
    %v = tt.load %pa, %m : tensor<16x!tt.ptr<f8E4M3FNUZ>>
    %qs = tt.splat %dst : !tt.ptr<f8E4M3FNUZ> -> tensor<16x!tt.ptr<f8E4M3FNUZ>>
    %qa = tt.addptr %qs, %r : tensor<16x!tt.ptr<f8E4M3FNUZ>>, tensor<16xi32>
    tt.store %qa, %v, %m : tensor<16x!tt.ptr<f8E4M3FNUZ>>
    tt.return
  }
}
