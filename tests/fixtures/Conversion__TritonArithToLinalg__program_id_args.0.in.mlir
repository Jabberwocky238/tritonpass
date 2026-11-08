// 5 的后备写法 B′：网格放在函数末尾的 6 个 i32 参数里（num_programs 三个、pid 三个），
// 每个带参数属性 dope.sys，calcc 据它改发 sys.query，不当入口参数。
// RUN: dope-opt --triton-arith-to-linalg="pids-to-func-args=true dope-sys-attrs=true" %s | FileCheck %s

module {
  // CHECK-LABEL: func.func @kernel(
  // CHECK-SAME: %arg0: !tt.ptr<i32>,
  // CHECK-SAME: %arg1: i32 {dope.sys = "num_programs_x"},
  // CHECK-SAME: %arg2: i32 {dope.sys = "num_programs_y"},
  // CHECK-SAME: %arg3: i32 {dope.sys = "num_programs_z"},
  // CHECK-SAME: %arg4: i32 {dope.sys = "program_id_x"},
  // CHECK-SAME: %arg5: i32 {dope.sys = "program_id_y"},
  // CHECK-SAME: %arg6: i32 {dope.sys = "program_id_z"})
  tt.func @kernel(%arg0: !tt.ptr<i32>) {
    %0 = tt.get_program_id x : i32
    %1 = tt.get_num_programs y : i32
    // CHECK: %[[S:.*]] = arith.addi %arg4, %arg2 : i32
    %2 = arith.addi %0, %1 : i32
    // CHECK: tt.store %arg0, %[[S]] : !tt.ptr<i32>
    tt.store %arg0, %2 : !tt.ptr<i32>
    tt.return
  }
}
