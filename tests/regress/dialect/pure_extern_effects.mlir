// pure 的 tt.extern_elementwise / tt.elementwise_inline_asm 没有内存效应、可推测执行（`getEffects` / `getSpeculatability`）：
// cse 合并相同的、去掉没用的，canonicalize 去掉没用的，licm 提出循环；不 pure 的照旧读写、不动。原先一律当成读写。
// RUN: dope-opt %s --cse
// RUN: dope-opt %s --canonicalize
// RUN: dope-opt %s --loop-invariant-code-motion
module {
  tt.func public @pure_calls(%p: !tt.ptr<f32>, %pi: !tt.ptr<i32>, %x: f32, %i: i32, %n: i32) {
    %e0 = tt.extern_elementwise %x {libname = "libdevice", libpath = "", pure = true, symbol = "__nv_expf"} : (f32) -> f32
    %e1 = tt.extern_elementwise %x {libname = "libdevice", libpath = "", pure = true, symbol = "__nv_expf"} : (f32) -> f32
    %e2 = tt.extern_elementwise %x {libname = "libdevice", libpath = "", pure = true, symbol = "__nv_logf"} : (f32) -> f32
    %e3 = tt.extern_elementwise %x {libname = "libdevice", libpath = "", pure = false, symbol = "__nv_impure"} : (f32) -> f32
    %a0 = tt.elementwise_inline_asm "mov.b32 $0, $1;" {constraints = "=r,r", packed_element = 1 : i32, pure = true} %i : i32 -> i32
    %a1 = tt.elementwise_inline_asm "mov.b32 $0, $1;" {constraints = "=r,r", packed_element = 1 : i32, pure = true} %i : i32 -> i32
    %a2 = tt.elementwise_inline_asm "not.b32 $0, $1;" {constraints = "=r,r", packed_element = 1 : i32, pure = true} %i : i32 -> i32
    %a3 = tt.elementwise_inline_asm "st.global.b32 [$1], $1;" {constraints = "=r,r", packed_element = 1 : i32, pure = false} %i : i32 -> i32
    %s = arith.addf %e0, %e1 : f32
    tt.store %p, %s : !tt.ptr<f32>
    %t = arith.addi %a0, %a1 : i32
    tt.store %pi, %t : !tt.ptr<i32>
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %r = scf.for %k = %c0 to %n step %c1 iter_args(%acc = %x) -> (f32) : i32 {
      %h = tt.extern_elementwise %x {libname = "libdevice", libpath = "", pure = true, symbol = "__nv_sinf"} : (f32) -> f32
      %g = tt.extern_elementwise %x {libname = "libdevice", libpath = "", pure = false, symbol = "__nv_impure"} : (f32) -> f32
      %q = tt.elementwise_inline_asm "mov.b32 $0, $1;" {constraints = "=r,r", packed_element = 1 : i32, pure = true} %i : i32 -> i32
      %qf = arith.sitofp %q : i32 to f32
      %u = arith.addf %acc, %h : f32
      %w = arith.addf %u, %g : f32
      %z = arith.addf %w, %qf : f32
      scf.yield %z : f32
    }
    tt.store %p, %r : !tt.ptr<f32>
    tt.return
  }
}
