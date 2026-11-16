// args 写法：被调函数的符号要加引号（Triton 的修饰名里有 `-`，如 `c-1`）时，调用处同样要把追加的 6 个 grid 参数传下去。
// 符号引用按原样留着引号，按名字找被调函数之前要去掉。
// RUN: dope-opt %s --triton-arith-to-linalg

module {
  tt.func private @"pkg.mod.helper__c-1"(%x: i32) -> i32 {
    %p = tt.get_program_id x : i32
    %n = tt.get_num_programs y : i32
    %r = arith.addi %x, %p : i32
    %s = arith.addi %r, %n : i32
    tt.return %s : i32
  }
  tt.func public @kernel(%arg0: !tt.ptr<i32>, %v: i32) {
    %c = tt.call @"pkg.mod.helper__c-1"(%v) : (i32) -> i32
    tt.store %arg0, %c : !tt.ptr<i32>
    tt.return
  }
}
