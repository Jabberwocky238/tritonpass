// 有函数体、返回指针的函数：triton-ptr-to-memref 把结果类型换成 memref，return 的操作数却还是指针。参照照 C++ 这样转、
// 被自己的验证器拒收；tritonpass 在转换里报错。第二块：只是声明的照常换类型，调用处的结果经 cast 接回指针。
// RUN: dope-opt %s --split-input-file --triton-ptr-to-memref

module {
  tt.func @ret_ptr(%a: !tt.ptr<f32>, %n: i32) -> !tt.ptr<f32> {
    %q = tt.addptr %a, %n : !tt.ptr<f32>, i32
    tt.return %q : !tt.ptr<f32>
  }
}

// -----

module {
  func.func private @ext(i32) -> !tt.ptr<f32>
  func.func @caller(%n: i32) -> i32 {
    %p = call @ext(%n) : (i32) -> !tt.ptr<f32>
    %v = tt.load %p : !tt.ptr<f32>
    %i = arith.fptosi %v : f32 to i32
    return %i : i32
  }
}
