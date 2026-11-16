// MLIR 的 BoolAttr 就是 i1 的 IntegerAttr：`isVolatile = 1 : i1` 与 `isVolatile = true` 是同一个属性，`pure = 1 : i1` 同理。
// volatile 的读另有写效应，没用到也不能删；pure 的 extern_elementwise 没用到就删。原先只认 `true`：volatile 的读被删掉，pure 的留着。
// 过一遍 triton-to-structured，读成了不带 isVolatile 的 tts.load，两边印法才一样（tritonpass 照写法印 `1 : i1`，参照印 `true`）。
// RUN: dope-opt %s --pass-pipeline='builtin.module(canonicalize, triton-to-structured)'
module {
  tt.func public @volatile_i1(%p: !tt.ptr<f32>, %x: f32) {
    %r = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %ps = tt.splat %p : !tt.ptr<f32> -> tensor<16x!tt.ptr<f32>>
    %pa = tt.addptr %ps, %r : tensor<16x!tt.ptr<f32>>, tensor<16xi32>
    %v = tt.load %pa {isVolatile = 1 : i1} : tensor<16x!tt.ptr<f32>>
    %e = tt.extern_elementwise %x {libname = "libdevice", libpath = "", pure = 1 : i1, symbol = "__nv_expf"} : (f32) -> f32
    tt.return
  }
}
