// prepass 只把元素是整数 / 指针的有秩张量（与指针）换成 tuple 展开（C++ 的 `RankedTensorType`）；scf.for 携带的 vector、
// memref 不动，不该插 tts.get_structured_state。
// RUN: dope-opt %s --split-input-file --triton-to-structured
module {
  tt.func @vector_iter(%v0: vector<4xi32>, %d: vector<4xi32>) -> vector<4xi32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %res = scf.for %iv = %c0 to %c4 step %c1 iter_args(%v = %v0) -> (vector<4xi32>) {
      %vn = arith.addi %v, %d : vector<4xi32>
      scf.yield %vn : vector<4xi32>
    }
    tt.return %res : vector<4xi32>
  }
}

// -----

module {
  tt.func @memref_iter(%m0: memref<4xi32>, %m1: memref<4xi32>, %c: i1) -> memref<4xi32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %res = scf.for %iv = %c0 to %c4 step %c1 iter_args(%m = %m0) -> (memref<4xi32>) {
      %mn = arith.select %c, %m, %m1 : memref<4xi32>
      scf.yield %mn : memref<4xi32>
    }
    tt.return %res : memref<4xi32>
  }
}
