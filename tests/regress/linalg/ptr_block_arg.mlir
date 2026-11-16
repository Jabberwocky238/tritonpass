// 函数签名里的指针换成 memref 时只换入口块（convertFuncOpTypes 只对入口块做 applySignatureConversion）；
// 别的块里指针类型的块参数原样留着，分支传进去的是源物化的 cast。以前所有块一起换，分支的操作数类型对不上而报错。
// RUN: dope-opt %s --triton-ptr-to-memref

module {
  tt.func @cf(%a: !tt.ptr<f32>, %c: i1, %n: i32) {
    %q = tt.addptr %a, %n : !tt.ptr<f32>, i32
    cf.cond_br %c, ^bb1(%q : !tt.ptr<f32>), ^bb2
  ^bb1(%p: !tt.ptr<f32>):
    %v = tt.load %p : !tt.ptr<f32>
    tt.store %p, %v : !tt.ptr<f32>
    tt.return
  ^bb2:
    tt.return
  }
}
