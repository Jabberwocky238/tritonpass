// 本仓新增用例（不在基线）：tt.broadcast 直接把一份已经是张量的指针铺大（这里是行维从 1 铺成 4），不经
// tt.addptr 产出目标形状——常见于「某个操作数在某一维行距是 0」的广播读（矩阵乘 M=1 的行、RMSNorm 的权重
// 按行广播一类），见 PtrAnalysis.cpp 的 rewriteBroadcastOp 与 PROVENANCE。
// RUN: dope-opt --triton-to-structured=enable-make-gather-scatter=false --cse --canonicalize %s | FileCheck %s

// CHECK-LABEL: tt.func public @row_broadcast_ptr(
// CHECK: tts.make_tptr %{{.*}} to sizes: [4, 4], strides: [0, 1], offsets: [0, 0]
// CHECK: "tts.load"
module {
  tt.func public @row_broadcast_ptr(%a_ptr: !tt.ptr<f32>) -> tensor<4x4xf32> {
    %r4 = tt.make_range {end = 4 : i32, start = 0 : i32} : tensor<4xi32>
    %a_base = tt.splat %a_ptr : !tt.ptr<f32> -> tensor<1x4x!tt.ptr<f32>>
    %a_col = tt.expand_dims %r4 {axis = 0 : i32} : tensor<4xi32> -> tensor<1x4xi32>
    %a_ptrs = tt.addptr %a_base, %a_col : tensor<1x4x!tt.ptr<f32>>, tensor<1x4xi32>
    %a_ptrs_b = tt.broadcast %a_ptrs : tensor<1x4x!tt.ptr<f32>> -> tensor<4x4x!tt.ptr<f32>>
    %v = tt.load %a_ptrs_b : tensor<4x4x!tt.ptr<f32>>
    tt.return %v : tensor<4x4xf32>
  }
}
