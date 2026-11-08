// dope-binary-search-to-for 单跑：二分查找形态的 scf.while 改写成有界、带守卫、读下标夹紧的 scf.for；
// 认不出的形态（下面每个「不认」的用例各自违反一条）原样不动。改写后的语义由
// tests/bench/test_bench_binary_search_exec.py 用真实 CPU 执行验证，这里钉的是结构。
// RUN: dope-opt --split-input-file --dope-binary-search-to-for %s | FileCheck %s

// ---- 认：vLLM 的写法（pred 为真取 mid + 1 的带结果 scf.if，right 用 select）----
// 结构：右端是入口整数实参、左端是常量 0，轮数取常数 16，前提「实参 ≤ 65535」记在函数属性 dope.preconditions；循环体里 mid 夹紧
// （夹到 R0 - 1，再夹回 0）、读用夹紧后的 mid、带结果的 scf.if 展平成 select、两个更新值各经 active 守卫；没有 scf.while、没有 scf.if
// CHECK-LABEL: tt.func public @vllm_shape(
// CHECK-SAME: dope.preconditions = {{\[\[}}1, -1, 65535{{\]\]}}
// CHECK-NOT: scf.while
// CHECK: %[[SIXTEEN:.+]] = arith.constant 16 : i32
// CHECK: scf.for %{{.+}} = %{{.+}} to %[[SIXTEEN]]
// CHECK: %[[ACTIVE:.+]] = arith.cmpi slt
// CHECK: %[[RAW:.+]] = arith.divsi
// CHECK: %[[CLAMP:.+]] = arith.minsi %[[RAW]],
// CHECK: %[[MID:.+]] = arith.maxsi %[[CLAMP]],
// CHECK: tt.addptr %{{.+}}, %[[MID]]
// CHECK: tt.load
// CHECK-NOT: scf.if
// CHECK: arith.select %[[ACTIVE]],
// CHECK: arith.select %[[ACTIVE]],
// CHECK: scf.yield
module {
  tt.func public @vllm_shape(%starts: !tt.ptr<i32>, %num: i32, %target: i32) -> i32 {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c2 = arith.constant 2 : i32
    %res:2 = scf.while (%left = %c0, %right = %num) : (i32, i32) -> (i32, i32) {
      %cond = arith.cmpi slt, %left, %right : i32
      scf.condition(%cond) %left, %right : i32, i32
    } do {
    ^bb0(%left: i32, %right: i32):
      %sum = arith.addi %left, %right : i32
      %mid = arith.divsi %sum, %c2 : i32
      %ptr = tt.addptr %starts, %mid : !tt.ptr<i32>, i32
      %val = tt.load %ptr : !tt.ptr<i32>
      %pred = arith.cmpi sle, %val, %target : i32
      %new_right = arith.select %pred, %right, %mid : i32
      %new_left = scf.if %pred -> (i32) {
        %next = arith.addi %mid, %c1 : i32
        scf.yield %next : i32
      } else {
        scf.yield %left : i32
      }
      scf.yield %new_left, %new_right : i32, i32
    }
    tt.return %res#0 : i32
  }
}

// -----

// ---- 认：镜像写法（pred 为真取 right = mid，否则 left = mid + 1），两个更新值都是 select ----
// CHECK-LABEL: tt.func public @mirrored_shape(
// CHECK-NOT: scf.while
// CHECK: scf.for
// CHECK: arith.minsi
module {
  tt.func public @mirrored_shape(%starts: !tt.ptr<i32>, %num: i32, %target: i32) -> i32 {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c2 = arith.constant 2 : i32
    %res:2 = scf.while (%left = %c0, %right = %num) : (i32, i32) -> (i32, i32) {
      %cond = arith.cmpi slt, %left, %right : i32
      scf.condition(%cond) %left, %right : i32, i32
    } do {
    ^bb0(%left: i32, %right: i32):
      %sum = arith.addi %left, %right : i32
      %mid = arith.divsi %sum, %c2 : i32
      %ptr = tt.addptr %starts, %mid : !tt.ptr<i32>, i32
      %val = tt.load %ptr : !tt.ptr<i32>
      %pred = arith.cmpi sge, %val, %target : i32
      %new_right = arith.select %pred, %mid, %right : i32
      %next = arith.addi %mid, %c1 : i32
      %new_left = arith.select %pred, %left, %next : i32
      scf.yield %new_left, %new_right : i32, i32
    }
    tt.return %res#0 : i32
  }
}

// -----

// ---- 认：循环体里没有读（整数平方根的二分）：没有地址可夹，不插 minsi；守卫照加 ----
// CHECK-LABEL: tt.func public @no_reads(
// CHECK-NOT: scf.while
// CHECK: scf.for
// CHECK-NOT: arith.minsi
// CHECK: arith.select
module {
  tt.func public @no_reads(%num: i32, %target: i32) -> i32 {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c2 = arith.constant 2 : i32
    %res:2 = scf.while (%left = %c0, %right = %num) : (i32, i32) -> (i32, i32) {
      %cond = arith.cmpi slt, %left, %right : i32
      scf.condition(%cond) %left, %right : i32, i32
    } do {
    ^bb0(%left: i32, %right: i32):
      %sum = arith.addi %left, %right : i32
      %mid = arith.divsi %sum, %c2 : i32
      %square = arith.muli %mid, %mid : i32
      %pred = arith.cmpi sle, %square, %target : i32
      %new_right = arith.select %pred, %right, %mid : i32
      %next = arith.addi %mid, %c1 : i32
      %new_left = arith.select %pred, %next, %left : i32
      scf.yield %new_left, %new_right : i32, i32
    }
    tt.return %res#0 : i32
  }
}

// -----

// ---- 不认：左端不是编译期常量（divsi 在负区间向零取整，减半与夹紧的论证不成立）----
// CHECK-LABEL: tt.func public @left_not_constant(
// CHECK: scf.while
// CHECK-NOT: scf.for
module {
  tt.func public @left_not_constant(%lo: i32, %num: i32, %target: i32) -> i32 {
    %c1 = arith.constant 1 : i32
    %c2 = arith.constant 2 : i32
    %res:2 = scf.while (%left = %lo, %right = %num) : (i32, i32) -> (i32, i32) {
      %cond = arith.cmpi slt, %left, %right : i32
      scf.condition(%cond) %left, %right : i32, i32
    } do {
    ^bb0(%left: i32, %right: i32):
      %sum = arith.addi %left, %right : i32
      %mid = arith.divsi %sum, %c2 : i32
      %pred = arith.cmpi sle, %mid, %target : i32
      %new_right = arith.select %pred, %right, %mid : i32
      %next = arith.addi %mid, %c1 : i32
      %new_left = arith.select %pred, %next, %left : i32
      scf.yield %new_left, %new_right : i32, i32
    }
    tt.return %res#0 : i32
  }
}

// -----

// ---- 不认：左端是负常量 ----
// CHECK-LABEL: tt.func public @left_negative_constant(
// CHECK: scf.while
// CHECK-NOT: scf.for
module {
  tt.func public @left_negative_constant(%num: i32, %target: i32) -> i32 {
    %lo = arith.constant -4 : i32
    %c1 = arith.constant 1 : i32
    %c2 = arith.constant 2 : i32
    %res:2 = scf.while (%left = %lo, %right = %num) : (i32, i32) -> (i32, i32) {
      %cond = arith.cmpi slt, %left, %right : i32
      scf.condition(%cond) %left, %right : i32, i32
    } do {
    ^bb0(%left: i32, %right: i32):
      %sum = arith.addi %left, %right : i32
      %mid = arith.divsi %sum, %c2 : i32
      %pred = arith.cmpi sle, %mid, %target : i32
      %new_right = arith.select %pred, %right, %mid : i32
      %next = arith.addi %mid, %c1 : i32
      %new_left = arith.select %pred, %next, %left : i32
      scf.yield %new_left, %new_right : i32, i32
    }
    tt.return %res#0 : i32
  }
}

// -----

// ---- 不认：条件是 left <= right（不是 left < right：收敛条件不同，上界论证不成立）----
// CHECK-LABEL: tt.func public @condition_sle(
// CHECK: scf.while
// CHECK-NOT: scf.for
module {
  tt.func public @condition_sle(%num: i32, %target: i32) -> i32 {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c2 = arith.constant 2 : i32
    %res:2 = scf.while (%left = %c0, %right = %num) : (i32, i32) -> (i32, i32) {
      %cond = arith.cmpi sle, %left, %right : i32
      scf.condition(%cond) %left, %right : i32, i32
    } do {
    ^bb0(%left: i32, %right: i32):
      %sum = arith.addi %left, %right : i32
      %mid = arith.divsi %sum, %c2 : i32
      %pred = arith.cmpi sle, %mid, %target : i32
      %new_right = arith.select %pred, %right, %mid : i32
      %next = arith.addi %mid, %c1 : i32
      %new_left = arith.select %pred, %next, %left : i32
      scf.yield %new_left, %new_right : i32, i32
    }
    tt.return %res#0 : i32
  }
}

// -----

// ---- 不认：mid 不是 (left + right) / 2（除以 3：每轮不一定减半）----
// CHECK-LABEL: tt.func public @mid_divides_by_three(
// CHECK: scf.while
// CHECK-NOT: scf.for
module {
  tt.func public @mid_divides_by_three(%num: i32, %target: i32) -> i32 {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c3 = arith.constant 3 : i32
    %res:2 = scf.while (%left = %c0, %right = %num) : (i32, i32) -> (i32, i32) {
      %cond = arith.cmpi slt, %left, %right : i32
      scf.condition(%cond) %left, %right : i32, i32
    } do {
    ^bb0(%left: i32, %right: i32):
      %sum = arith.addi %left, %right : i32
      %mid = arith.divsi %sum, %c3 : i32
      %pred = arith.cmpi sle, %mid, %target : i32
      %new_right = arith.select %pred, %right, %mid : i32
      %next = arith.addi %mid, %c1 : i32
      %new_left = arith.select %pred, %next, %left : i32
      scf.yield %new_left, %new_right : i32, i32
    }
    tt.return %res#0 : i32
  }
}

// -----

// ---- 不认：pred 为真时 left = mid（少了 + 1）：区间可能不缩小，原循环可能不终止 ----
// CHECK-LABEL: tt.func public @left_is_mid_not_mid_plus_one(
// CHECK: scf.while
// CHECK-NOT: scf.for
module {
  tt.func public @left_is_mid_not_mid_plus_one(%num: i32, %target: i32) -> i32 {
    %c0 = arith.constant 0 : i32
    %c2 = arith.constant 2 : i32
    %res:2 = scf.while (%left = %c0, %right = %num) : (i32, i32) -> (i32, i32) {
      %cond = arith.cmpi slt, %left, %right : i32
      scf.condition(%cond) %left, %right : i32, i32
    } do {
    ^bb0(%left: i32, %right: i32):
      %sum = arith.addi %left, %right : i32
      %mid = arith.divsi %sum, %c2 : i32
      %pred = arith.cmpi sle, %mid, %target : i32
      %new_right = arith.select %pred, %right, %mid : i32
      %new_left = arith.select %pred, %mid, %left : i32
      scf.yield %new_left, %new_right : i32, i32
    }
    tt.return %res#0 : i32
  }
}

// -----

// ---- 不认：两个更新值不是同一个 pred 选的（可能同时动或都不动）----
// CHECK-LABEL: tt.func public @two_different_predicates(
// CHECK: scf.while
// CHECK-NOT: scf.for
module {
  tt.func public @two_different_predicates(%num: i32, %target: i32) -> i32 {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c2 = arith.constant 2 : i32
    %res:2 = scf.while (%left = %c0, %right = %num) : (i32, i32) -> (i32, i32) {
      %cond = arith.cmpi slt, %left, %right : i32
      scf.condition(%cond) %left, %right : i32, i32
    } do {
    ^bb0(%left: i32, %right: i32):
      %sum = arith.addi %left, %right : i32
      %mid = arith.divsi %sum, %c2 : i32
      %pred_a = arith.cmpi sle, %mid, %target : i32
      %pred_b = arith.cmpi slt, %mid, %target : i32
      %new_right = arith.select %pred_a, %right, %mid : i32
      %next = arith.addi %mid, %c1 : i32
      %new_left = arith.select %pred_b, %next, %left : i32
      scf.yield %new_left, %new_right : i32, i32
    }
    tt.return %res#0 : i32
  }
}

// -----

// ---- 不认：循环体里有写（tt.store）：在已经收敛的轮里照常执行会多写 ----
// CHECK-LABEL: tt.func public @body_has_store(
// CHECK: scf.while
// CHECK-NOT: scf.for
module {
  tt.func public @body_has_store(%out: !tt.ptr<i32>, %num: i32, %target: i32) -> i32 {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c2 = arith.constant 2 : i32
    %res:2 = scf.while (%left = %c0, %right = %num) : (i32, i32) -> (i32, i32) {
      %cond = arith.cmpi slt, %left, %right : i32
      scf.condition(%cond) %left, %right : i32, i32
    } do {
    ^bb0(%left: i32, %right: i32):
      %sum = arith.addi %left, %right : i32
      %mid = arith.divsi %sum, %c2 : i32
      tt.store %out, %mid : !tt.ptr<i32>
      %pred = arith.cmpi sle, %mid, %target : i32
      %new_right = arith.select %pred, %right, %mid : i32
      %next = arith.addi %mid, %c1 : i32
      %new_left = arith.select %pred, %next, %left : i32
      scf.yield %new_left, %new_right : i32, i32
    }
    tt.return %res#0 : i32
  }
}

// -----

// ---- 不认：读的下标不是 mid（夹紧的是 mid，别的下标没法保证落在搜索范围内）----
// CHECK-LABEL: tt.func public @load_index_is_not_mid(
// CHECK: scf.while
// CHECK-NOT: scf.for
module {
  tt.func public @load_index_is_not_mid(%starts: !tt.ptr<i32>, %num: i32, %target: i32) -> i32 {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c2 = arith.constant 2 : i32
    %res:2 = scf.while (%left = %c0, %right = %num) : (i32, i32) -> (i32, i32) {
      %cond = arith.cmpi slt, %left, %right : i32
      scf.condition(%cond) %left, %right : i32, i32
    } do {
    ^bb0(%left: i32, %right: i32):
      %sum = arith.addi %left, %right : i32
      %mid = arith.divsi %sum, %c2 : i32
      %ptr = tt.addptr %starts, %left : !tt.ptr<i32>, i32
      %val = tt.load %ptr : !tt.ptr<i32>
      %pred = arith.cmpi sle, %val, %target : i32
      %new_right = arith.select %pred, %right, %mid : i32
      %next = arith.addi %mid, %c1 : i32
      %new_left = arith.select %pred, %next, %left : i32
      scf.yield %new_left, %new_right : i32, i32
    }
    tt.return %res#0 : i32
  }
}

// -----

// ---- 不认：循环体里除以读到的值（除数不是正常量：已经收敛的轮里读到夹紧后的元素，可能除零）----
// CHECK-LABEL: tt.func public @divide_by_loaded_value(
// CHECK: scf.while
// CHECK-NOT: scf.for
module {
  tt.func public @divide_by_loaded_value(%starts: !tt.ptr<i32>, %num: i32, %target: i32) -> i32 {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c2 = arith.constant 2 : i32
    %res:2 = scf.while (%left = %c0, %right = %num) : (i32, i32) -> (i32, i32) {
      %cond = arith.cmpi slt, %left, %right : i32
      scf.condition(%cond) %left, %right : i32, i32
    } do {
    ^bb0(%left: i32, %right: i32):
      %sum = arith.addi %left, %right : i32
      %mid = arith.divsi %sum, %c2 : i32
      %ptr = tt.addptr %starts, %mid : !tt.ptr<i32>, i32
      %val = tt.load %ptr : !tt.ptr<i32>
      %ratio = arith.divsi %target, %val : i32
      %pred = arith.cmpi sle, %ratio, %target : i32
      %new_right = arith.select %pred, %right, %mid : i32
      %next = arith.addi %mid, %c1 : i32
      %new_left = arith.select %pred, %next, %left : i32
      scf.yield %new_left, %new_right : i32, i32
    }
    tt.return %res#0 : i32
  }
}

// -----

// ---- 不认：不是 i32（这里是 i64：上界按位宽推，只认 i32）----
// CHECK-LABEL: tt.func public @wide_i64(
// CHECK: scf.while
// CHECK-NOT: scf.for
module {
  tt.func public @wide_i64(%num: i64, %target: i64) -> i64 {
    %c0 = arith.constant 0 : i64
    %c1 = arith.constant 1 : i64
    %c2 = arith.constant 2 : i64
    %res:2 = scf.while (%left = %c0, %right = %num) : (i64, i64) -> (i64, i64) {
      %cond = arith.cmpi slt, %left, %right : i64
      scf.condition(%cond) %left, %right : i64, i64
    } do {
    ^bb0(%left: i64, %right: i64):
      %sum = arith.addi %left, %right : i64
      %mid = arith.divsi %sum, %c2 : i64
      %pred = arith.cmpi sle, %mid, %target : i64
      %new_right = arith.select %pred, %right, %mid : i64
      %next = arith.addi %mid, %c1 : i64
      %new_left = arith.select %pred, %next, %left : i64
      scf.yield %new_left, %new_right : i64, i64
    }
    tt.return %res#0 : i64
  }
}

// -----

// ---- 右端是编译期常量：轮数就是宽度的 bit_length（100 → 7），不要发射前提 ----
// CHECK-LABEL: tt.func public @constant_width(
// CHECK-NOT: dope.preconditions
// CHECK: %[[SEVEN:.+]] = arith.constant 7 : i32
// CHECK: scf.for %{{.+}} = %{{.+}} to %[[SEVEN]]
module {
  tt.func public @constant_width(%starts: !tt.ptr<i32>, %target: i32) -> i32 {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c2 = arith.constant 2 : i32
    %c100 = arith.constant 100 : i32
    %res:2 = scf.while (%left = %c0, %right = %c100) : (i32, i32) -> (i32, i32) {
      %cond = arith.cmpi slt, %left, %right : i32
      scf.condition(%cond) %left, %right : i32, i32
    } do {
    ^bb0(%left: i32, %right: i32):
      %sum = arith.addi %left, %right : i32
      %mid = arith.divsi %sum, %c2 : i32
      %ptr = tt.addptr %starts, %mid : !tt.ptr<i32>, i32
      %val = tt.load %ptr : !tt.ptr<i32>
      %pred = arith.cmpi sle, %val, %target : i32
      %new_right = arith.select %pred, %right, %mid : i32
      %next = arith.addi %mid, %c1 : i32
      %new_left = arith.select %pred, %next, %left : i32
      scf.yield %new_left, %new_right : i32, i32
    }
    tt.return %res#0 : i32
  }
}

// -----

// ---- 右端不是入口实参（实参加一）：前提表达不了，仍在运行期精确算轮数，不记前提 ----
// CHECK-LABEL: tt.func public @derived_width(
// CHECK-NOT: dope.preconditions
// CHECK: arith.cmpi sge
// CHECK: scf.for
module {
  tt.func public @derived_width(%starts: !tt.ptr<i32>, %num: i32, %target: i32) -> i32 {
    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c2 = arith.constant 2 : i32
    %n1 = arith.addi %num, %c1 : i32
    %res:2 = scf.while (%left = %c0, %right = %n1) : (i32, i32) -> (i32, i32) {
      %cond = arith.cmpi slt, %left, %right : i32
      scf.condition(%cond) %left, %right : i32, i32
    } do {
    ^bb0(%left: i32, %right: i32):
      %sum = arith.addi %left, %right : i32
      %mid = arith.divsi %sum, %c2 : i32
      %ptr = tt.addptr %starts, %mid : !tt.ptr<i32>, i32
      %val = tt.load %ptr : !tt.ptr<i32>
      %pred = arith.cmpi sle, %val, %target : i32
      %new_right = arith.select %pred, %right, %mid : i32
      %next = arith.addi %mid, %c1 : i32
      %new_left = arith.select %pred, %next, %left : i32
      scf.yield %new_left, %new_right : i32, i32
    }
    tt.return %res#0 : i32
  }
}
