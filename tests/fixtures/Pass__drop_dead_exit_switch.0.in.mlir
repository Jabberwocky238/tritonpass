// dope-drop-dead-exit-switch 单跑：lift-cf-to-scf 给多出口 tt.func 留下的纯选择器死链
// （零结果、分支皆空的 scf.index_switch，喂给它的 scf.if／index_castui）才清；别的一概不碰。
// RUN: dope-opt --split-input-file --dope-drop-dead-exit-switch %s | FileCheck %s

// ---- 死链：两层 scf.if 产出一个 i32 选择码，index_castui 转 index，switch 零结果、两个分支都空
// ——整条链清掉，只剩两层 scf.if（零结果）与真正的负载 ----
// CHECK-LABEL: tt.func public @dead_switch(
// CHECK-NOT: index_switch
// CHECK-NOT: index_castui
// CHECK: scf.if
// CHECK: scf.if
// CHECK: tt.store
module {
  tt.func public @dead_switch(%x: !tt.ptr<f32>, %bound0: i32, %bound1: i32) {
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %pid = tt.get_program_id x : i32
    %cond0 = arith.cmpi sge, %pid, %bound0 : i32
    %sel = scf.if %cond0 -> (i32) {
      scf.yield %c0_i32 : i32
    } else {
      %cond1 = arith.cmpi sge, %pid, %bound1 : i32
      %inner = scf.if %cond1 -> (i32) {
        scf.yield %c0_i32 : i32
      } else {
        %range = tt.make_range {end = 64 : i32, start = 0 : i32} : tensor<64xi32>
        %xptrs = tt.splat %x : !tt.ptr<f32> -> tensor<64x!tt.ptr<f32>>
        %ptrs = tt.addptr %xptrs, %range : tensor<64x!tt.ptr<f32>>, tensor<64xi32>
        %v = tt.load %ptrs : tensor<64x!tt.ptr<f32>>
        tt.store %ptrs, %v : tensor<64x!tt.ptr<f32>>
        scf.yield %c1_i32 : i32
      }
      scf.yield %inner : i32
    }
    %idx = arith.index_castui %sel : i32 to index
    scf.index_switch %idx
    case 0 {
      scf.yield
    }
    default {
    }
    tt.return
  }
}

// -----

// ---- 零结果，但两个分支不是都空（default 里有一条真的 arith.constant）：不是纯选择器死链，原样留着 ----
// CHECK-LABEL: tt.func public @real_switch(
// CHECK: scf.index_switch
// CHECK: default
// CHECK: arith.constant 7
module {
  tt.func public @real_switch(%idx: index) {
    scf.index_switch %idx
    case 0 {
      scf.yield
    }
    default {
      %c = arith.constant 7 : i32
      scf.yield
    }
    tt.return
  }
}

// -----

// ---- 有结果（不是零结果），分支看着也空：不碰——合同只收 scf.for 与 scf.if，带结果的 switch 本来就不是
// 这个 pass 的管辖范围，照样原样留给 P0 判 ----
// CHECK-LABEL: tt.func public @switch_with_result(
// CHECK: scf.index_switch
module {
  tt.func public @switch_with_result(%idx: index, %v: f32) {
    %s = scf.index_switch %idx -> f32
    case 0 {
      scf.yield %v : f32
    }
    default {
      scf.yield %v : f32
    }
    tt.return
  }
}
