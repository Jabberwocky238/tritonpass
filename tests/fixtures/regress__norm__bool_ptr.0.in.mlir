// dope-lower-bool-ptr：!tt.ptr<i1> 换成 !tt.ptr<i8> 要换遍整个函数的类型——函数类型的结果、scf.for / scf.while 体的块参数
// （循环里前移的 bool 指针，`mask_ptrs += BLOCK`）、非入口块的块参数；参照只换入口块参数与 op 结果，前三块过不了它自己的校验。
// 后两块：显式写出缺省地址空间 1 的 !tt.ptr<i1, 1>，换完要与 !tt.ptr<i8>（及 !tt.ptr<i8, 1>）是同一个类型，恒等的 tt.bitcast 才去得掉。
// RUN: dope-opt %s --split-input-file --dope-lower-bool-ptr

module {
  tt.func public @loop_carried(%cond: !tt.ptr<i1>, %out: !tt.ptr<f32>, %n: i32) {
    %r = tt.make_range {end = 32 : i32, start = 0 : i32} : tensor<32xi32>
    %c0 = arith.constant dense<0> : tensor<32xi8>
    %c32 = arith.constant dense<32> : tensor<32xi32>
    %zero = arith.constant dense<0.0> : tensor<32xf32>
    %one = arith.constant dense<1.0> : tensor<32xf32>
    %i0 = arith.constant 0 : i32
    %i1 = arith.constant 1 : i32
    %b = tt.splat %cond : !tt.ptr<i1> -> tensor<32x!tt.ptr<i1>>
    %p0 = tt.addptr %b, %r : tensor<32x!tt.ptr<i1>>, tensor<32xi32>
    %acc:2 = scf.for %k = %i0 to %n step %i1 iter_args(%p = %p0, %s = %zero) -> (tensor<32x!tt.ptr<i1>>, tensor<32xf32>) : i32 {
      %q = tt.bitcast %p : tensor<32x!tt.ptr<i1>> -> tensor<32x!tt.ptr<i8>>
      %v = tt.load %q : tensor<32x!tt.ptr<i8>>
      %m = arith.cmpi ne, %v, %c0 : tensor<32xi8>
      %sel = arith.select %m, %one, %zero : tensor<32xi1>, tensor<32xf32>
      %s2 = arith.addf %s, %sel : tensor<32xf32>
      %pn = tt.addptr %p, %c32 : tensor<32x!tt.ptr<i1>>, tensor<32xi32>
      scf.yield %pn, %s2 : tensor<32x!tt.ptr<i1>>, tensor<32xf32>
    }
    %ob = tt.splat %out : !tt.ptr<f32> -> tensor<32x!tt.ptr<f32>>
    %op = tt.addptr %ob, %r : tensor<32x!tt.ptr<f32>>, tensor<32xi32>
    tt.store %op, %acc#1 : tensor<32x!tt.ptr<f32>>
    tt.return
  }
}

// -----

module {
  tt.func public @while_and_blocks(%cond: !tt.ptr<i1>, %out: !tt.ptr<i8>, %n: i32, %f: i1) {
    %i0 = arith.constant 0 : i32
    %i1 = arith.constant 1 : i32
    %w:2 = scf.while (%p = %cond, %k = %i0) : (!tt.ptr<i1>, i32) -> (!tt.ptr<i1>, i32) {
      %c = arith.cmpi slt, %k, %n : i32
      scf.condition(%c) %p, %k : !tt.ptr<i1>, i32
    } do {
    ^bb0(%p2: !tt.ptr<i1>, %k2: i32):
      %pn = tt.addptr %p2, %i1 : !tt.ptr<i1>, i32
      %kn = arith.addi %k2, %i1 : i32
      scf.yield %pn, %kn : !tt.ptr<i1>, i32
    }
    cf.cond_br %f, ^bb1(%w#0 : !tt.ptr<i1>), ^bb1(%cond : !tt.ptr<i1>)
  ^bb1(%x: !tt.ptr<i1>):
    %q = tt.bitcast %x : !tt.ptr<i1> -> !tt.ptr<i8>
    %v = tt.load %q : !tt.ptr<i8>
    tt.store %out, %v : !tt.ptr<i8>
    tt.return
  }
}

// -----

module {
  tt.func private @offset_mask(%c: !tt.ptr<i1>, %k: i32) -> !tt.ptr<i1> {
    %p = tt.addptr %c, %k : !tt.ptr<i1>, i32
    tt.return %p : !tt.ptr<i1>
  }
  tt.func public @call_result(%c: !tt.ptr<i1>, %o: !tt.ptr<i8>) {
    %k = arith.constant 3 : i32
    %p = tt.call @offset_mask(%c, %k) : (!tt.ptr<i1>, i32) -> !tt.ptr<i1>
    %q = tt.bitcast %p : !tt.ptr<i1> -> !tt.ptr<i8>
    %v = tt.load %q : !tt.ptr<i8>
    tt.store %o, %v : !tt.ptr<i8>
    tt.return
  }
}

// -----

module {
  tt.func public @address_space_default(%cond: !tt.ptr<i1, 1>, %o: !tt.ptr<i8>) {
    %q = tt.bitcast %cond : !tt.ptr<i1, 1> -> !tt.ptr<i8>
    %v = tt.load %q : !tt.ptr<i8>
    tt.store %o, %v : !tt.ptr<i8>
    tt.return
  }
}

// -----

module {
  tt.func public @address_space_explicit(%cond: !tt.ptr<i1, 1>, %o: !tt.ptr<i8>) {
    %q = tt.bitcast %cond : !tt.ptr<i1, 1> -> !tt.ptr<i8, 1>
    %v = tt.load %q : !tt.ptr<i8, 1>
    tt.store %o, %v : !tt.ptr<i8>
    tt.return
  }
}
