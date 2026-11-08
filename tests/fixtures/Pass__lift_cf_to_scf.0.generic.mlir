"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, i32) -> (), sym_name = "guard_return", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "arith.cmpi"(%arg1, %1) <{predicate = 5 : i64}> : (i32, i32) -> i1
    "scf.if"(%2) ({
      "scf.yield"() : () -> ()
    }, {
      %3 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      "tt.store"(%arg0, %3) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> (), sym_name = "no_branch", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "tt.store"(%arg0, %0) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, i32) -> (), sym_name = "back_edge_loop", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: i32):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %5 = "scf.while"(%3) ({
    ^bb0(%arg3: i32):
      %6 = "arith.cmpi"(%arg3, %arg1) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %7:3 = "scf.if"(%6) ({
        %9 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
        "tt.store"(%arg0, %9) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
        %10 = "arith.addi"(%arg3, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "scf.yield"(%10, %2, %1) : (i32, i32, i32) -> ()
      }, {
        "scf.yield"(%0, %1, %2) : (i32, i32, i32) -> ()
      }) : (i1) -> (i32, i32, i32)
      %8 = "arith.trunci"(%7#2) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i1
      "scf.condition"(%8, %7#0) : (i1, i32) -> ()
    }, {
    ^bb0(%arg2: i32):
      "scf.yield"(%arg2) : (i32) -> ()
    }) : (i32) -> i32
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

