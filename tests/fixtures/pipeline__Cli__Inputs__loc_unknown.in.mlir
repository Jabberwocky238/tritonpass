// 位置未知的诊断：被拒的 op 带 loc(unknown)，JSON 里 loc 写 null，文本里写 <unknown>。
module {
  tt.func public @k(%p: !tt.ptr<f32>, %x: i32) {
    tt.print "x" {hex = false, isSigned = array<i32: 0>} : %x : i32 loc(unknown)
    tt.return
  }
}
