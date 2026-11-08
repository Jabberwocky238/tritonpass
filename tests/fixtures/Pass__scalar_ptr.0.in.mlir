// dope-scalar-ptr 单跑：入口指针加一串标量偏移的标量写（无 mask）落成 1 个元素的结构化写
// （tts.make_tptr 的 offsets 是整条链的偏移之和，加 tts.store）；别的形态原样不动，留给 P6 点名拒收。
// RUN: dope-opt --split-input-file --dope-scalar-ptr %s | FileCheck %s

// ---- 直接以入口指针为目标：偏移 0 ----
module {
  // CHECK-LABEL: tt.func public @direct(
  // CHECK-SAME: %[[OUT:.+]]: !tt.ptr<f32>, %[[V:.+]]: f32
  // CHECK: %[[T:.+]] = tts.make_tptr %[[OUT]] to sizes: [1], strides: [1], offsets: [0], shape: [0], order: [] : <f32> to tensor<1x!tt.ptr<f32>>
  // CHECK: %[[S:.+]] = tt.splat %[[V]] : f32 -> tensor<1xf32>
  // CHECK: "tts.store"(%[[T]], %[[S]]) <{static_mask_dims = array<i64>}>
  // CHECK-NOT: tt.store
  tt.func public @direct(%out: !tt.ptr<f32>, %v: f32) {
    tt.store %out, %v : !tt.ptr<f32>
    tt.return
  }
}

// -----

// ---- out + pid：基址仍是入口指针，偏移 pid 转成 index 放进 offsets（这条以前把结构化分析的断言打崩） ----
module {
  // CHECK-LABEL: tt.func public @at_pid(
  // CHECK-SAME: %[[OUT:.+]]: !tt.ptr<f32>, %[[V:.+]]: f32
  // CHECK: %[[PID:.+]] = tt.get_program_id x : i32
  // CHECK: %[[IDX:.+]] = arith.index_cast %[[PID]] : i32 to index
  // CHECK: tts.make_tptr %[[OUT]] to sizes: [1], strides: [1], offsets: [%[[IDX]]], shape: [0], order: [] : <f32> to tensor<1x!tt.ptr<f32>>
  // CHECK: "tts.store"
  // CHECK-NOT: tt.store
  tt.func public @at_pid(%out: !tt.ptr<f32>, %v: f32) {
    %pid = tt.get_program_id x : i32
    %p = tt.addptr %out, %pid : !tt.ptr<f32>, i32
    tt.store %p, %v : !tt.ptr<f32>
    tt.return
  }
}

// -----

// ---- 两段偏移相加：pid * stride（stride 是整数实参）再加 pid_y ----
module {
  // CHECK-LABEL: tt.func public @chain(
  // CHECK-SAME: %[[OUT:.+]]: !tt.ptr<f32>, %[[V:.+]]: f32, %[[STRIDE:.+]]: i32
  // CHECK: %[[X:.+]] = tt.get_program_id x : i32
  // CHECK: %[[Y:.+]] = tt.get_program_id y : i32
  // CHECK: %[[OFF:.+]] = arith.muli %[[X]], %[[STRIDE]] : i32
  // CHECK: %[[A:.+]] = arith.index_cast %[[OFF]] : i32 to index
  // CHECK: %[[B:.+]] = arith.index_cast %[[Y]] : i32 to index
  // CHECK: %[[SUM:.+]] = arith.addi %[[A]], %[[B]] : index
  // CHECK: tts.make_tptr %[[OUT]] to sizes: [1], strides: [1], offsets: [%[[SUM]]], shape: [0], order: [] : <f32> to tensor<1x!tt.ptr<f32>>
  // CHECK-NOT: tt.store
  tt.func public @chain(%out: !tt.ptr<f32>, %v: f32, %stride: i32) {
    %x = tt.get_program_id x : i32
    %y = tt.get_program_id y : i32
    %off = arith.muli %x, %stride : i32
    %p1 = tt.addptr %out, %off : !tt.ptr<f32>, i32
    %p2 = tt.addptr %p1, %y : !tt.ptr<f32>, i32
    tt.store %p2, %v : !tt.ptr<f32>
    tt.return
  }
}

// -----

// ---- 64 位的偏移同样转 index ----
module {
  // CHECK-LABEL: tt.func public @i64_offset(
  // CHECK: %[[IDX:.+]] = arith.index_cast %arg2 : i64 to index
  // CHECK: tts.make_tptr %arg0 to sizes: [1], strides: [1], offsets: [%[[IDX]]], shape: [0], order: [] : <f32> to tensor<1x!tt.ptr<f32>>
  tt.func public @i64_offset(%out: !tt.ptr<f32>, %v: f32, %off: i64) {
    %p = tt.addptr %out, %off : !tt.ptr<f32>, i64
    tt.store %p, %v : !tt.ptr<f32>
    tt.return
  }
}

// -----

// ---- 带 mask 的标量写不改写：悄悄改成无条件写是错数据，原样留给 P6 点名 ----
module {
  // CHECK-LABEL: tt.func public @masked(
  // CHECK: tt.store %arg0, %{{.*}}, %[[MASK:.+]] : !tt.ptr<f32>
  // CHECK-NOT: tts.
  tt.func public @masked(%out: !tt.ptr<f32>, %flag: i32) {
    %c = arith.constant 1.0 : f32
    %c0 = arith.constant 0 : i32
    %m = arith.cmpi eq, %flag, %c0 : i32
    tt.store %out, %c, %m : !tt.ptr<f32>
    tt.return
  }
}

// -----

// ---- 标量读不改写：二期目标 kernel 不要标量读（控制值与写法 G 的下标是后面几期的事） ----
module {
  // CHECK-LABEL: tt.func public @scalar_load(
  // CHECK: %[[L:.+]] = tt.load %arg0 : !tt.ptr<f32>
  // CHECK-NOT: tts.load
  // CHECK-NOT: tensor.extract
  // CHECK: tt.splat %[[L]] : f32 -> tensor<1xf32>
  tt.func public @scalar_load(%p: !tt.ptr<f32>, %out: !tt.ptr<f32>) {
    %s = tt.load %p : !tt.ptr<f32>
    tt.store %out, %s : !tt.ptr<f32>
    tt.return
  }
}

// -----

// ---- 指针的根不是入口参数：scf.if 选出来的指针、arith.select 选出来的指针都原样不动 ----
module {
  // CHECK-LABEL: tt.func public @if_pointer(
  // CHECK: %[[P:.+]] = scf.if
  // CHECK: tt.store %[[P]], %arg2 : !tt.ptr<f32>
  // CHECK-NOT: tts.
  tt.func public @if_pointer(%a: !tt.ptr<f32>, %b: !tt.ptr<f32>, %v: f32, %flag: i32) {
    %c0 = arith.constant 0 : i32
    %cond = arith.cmpi eq, %flag, %c0 : i32
    %p = scf.if %cond -> (!tt.ptr<f32>) {
      scf.yield %a : !tt.ptr<f32>
    } else {
      scf.yield %b : !tt.ptr<f32>
    }
    tt.store %p, %v : !tt.ptr<f32>
    tt.return
  }
}

// -----

module {
  // CHECK-LABEL: tt.func public @select_pointer(
  // CHECK: %[[P:.+]] = arith.select
  // CHECK: tt.store %[[P]], %arg2 : !tt.ptr<f32>
  // CHECK-NOT: tts.
  tt.func public @select_pointer(%a: !tt.ptr<f32>, %b: !tt.ptr<f32>, %v: f32, %flag: i32) {
    %c0 = arith.constant 0 : i32
    %cond = arith.cmpi eq, %flag, %c0 : i32
    %p = arith.select %cond, %a, %b : !tt.ptr<f32>
    tt.store %p, %v : !tt.ptr<f32>
    tt.return
  }
}

// -----

// ---- 指针链的根是 scf.if 选出来的指针再加偏移：链走到 scf.if 的结果就停，不改写 ----
module {
  // CHECK-LABEL: tt.func public @if_pointer_plus_offset(
  // CHECK: tt.store %{{.*}}, %arg2 : !tt.ptr<f32>
  // CHECK-NOT: tts.
  tt.func public @if_pointer_plus_offset(%a: !tt.ptr<f32>, %b: !tt.ptr<f32>, %v: f32, %flag: i32) {
    %c0 = arith.constant 0 : i32
    %cond = arith.cmpi eq, %flag, %c0 : i32
    %p = scf.if %cond -> (!tt.ptr<f32>) {
      scf.yield %a : !tt.ptr<f32>
    } else {
      scf.yield %b : !tt.ptr<f32>
    }
    %pid = tt.get_program_id x : i32
    %q = tt.addptr %p, %pid : !tt.ptr<f32>, i32
    tt.store %q, %v : !tt.ptr<f32>
    tt.return
  }
}

// -----

// ---- 张量指针的写不是标量写，不归这一步 ----
module {
  // CHECK-LABEL: tt.func public @tensor_store(
  // CHECK: tt.store %{{.*}}, %{{.*}} : tensor<16x!tt.ptr<f32>>
  // CHECK-NOT: tts.
  tt.func public @tensor_store(%out: !tt.ptr<f32>, %v: f32) {
    %r = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %vs = tt.splat %v : f32 -> tensor<16xf32>
    %os = tt.splat %out : !tt.ptr<f32> -> tensor<16x!tt.ptr<f32>>
    %op = tt.addptr %os, %r : tensor<16x!tt.ptr<f32>>, tensor<16xi32>
    tt.store %op, %vs : tensor<16x!tt.ptr<f32>>
    tt.return
  }
}
