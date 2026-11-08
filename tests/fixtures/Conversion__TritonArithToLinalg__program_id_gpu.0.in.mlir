// 5：tt.get_program_id、tt.get_num_programs 变成 gpu.block_id、gpu.grid_dim（结果是 index），
// Triton 里当 i32 用的地方补一条 arith.index_cast；入口参数不多出任何网格参数。
// RUN: dope-opt --triton-arith-to-linalg="pids-to-func-args=false pids-to-gpu=true" %s | FileCheck %s

module {
  // CHECK-LABEL: func.func @kernel(%arg0: !tt.ptr<i32>)
  // CHECK-NOT: tt.get_program_id
  // CHECK-NOT: tt.get_num_programs
  tt.func @kernel(%arg0: !tt.ptr<i32>) {
    // CHECK: %[[PX:.*]] = gpu.block_id  x
    // CHECK: %[[PX32:.*]] = arith.index_cast %[[PX]] : index to i32
    %0 = tt.get_program_id x : i32
    // CHECK: %[[PY:.*]] = gpu.block_id  y
    // CHECK: %[[PY32:.*]] = arith.index_cast %[[PY]] : index to i32
    %1 = tt.get_program_id y : i32
    // CHECK: %[[PZ:.*]] = gpu.block_id  z
    // CHECK: %[[PZ32:.*]] = arith.index_cast %[[PZ]] : index to i32
    %2 = tt.get_program_id z : i32
    // CHECK: %[[NX:.*]] = gpu.grid_dim  x
    // CHECK: %[[NX32:.*]] = arith.index_cast %[[NX]] : index to i32
    %3 = tt.get_num_programs x : i32
    // CHECK: %[[NY:.*]] = gpu.grid_dim  y
    // CHECK: %[[NY32:.*]] = arith.index_cast %[[NY]] : index to i32
    %4 = tt.get_num_programs y : i32
    // CHECK: %[[NZ:.*]] = gpu.grid_dim  z
    // CHECK: %[[NZ32:.*]] = arith.index_cast %[[NZ]] : index to i32
    %5 = tt.get_num_programs z : i32
    // CHECK: arith.addi %[[PX32]], %[[PY32]] : i32
    %6 = arith.addi %0, %1 : i32
    %7 = arith.addi %2, %3 : i32
    %8 = arith.addi %4, %5 : i32
    %9 = arith.addi %6, %7 : i32
    %10 = arith.addi %9, %8 : i32
    tt.store %arg0, %10 : !tt.ptr<i32>
    tt.return
  }
}
