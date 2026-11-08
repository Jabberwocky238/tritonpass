// 地址空间写什么都擦（`all` 是 Triton 的 `tl.debug_barrier()` 发的，别的组合手写得出）。
// SCOPES-LABEL: tt.func public @scopes
// SCOPES-NOT: ttg.barrier
// SCOPES: tt.return
module {
  tt.func public @scopes() {
    ttg.barrier all
    ttg.barrier local
    ttg.barrier none
    tt.return
  }
}

