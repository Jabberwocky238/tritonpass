"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i32>, !tt.ptr<i32>) -> (), sym_name = "spin_lock", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: !tt.ptr<i32>):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "scf.while"() ({
      %5 = "tt.atomic_cas"(%arg0, %0, %1) <{scope = 1 : i32, sem = 4 : i32}> : (!tt.ptr<i32>, i32, i32) -> i32
      %6 = "arith.cmpi"(%5, %1) <{predicate = 0 : i64}> : (i32, i32) -> i1
      "scf.condition"(%6) : (i1) -> ()
    }, {
      "scf.yield"() : () -> ()
    }) {tt.note = 1 : i32} : () -> ()
    %2 = "scf.while"() ({
      %3 = "tt.atomic_rmw"(%arg1, %1) <{atomic_rmw_op = 4 : i32, scope = 1 : i32, sem = 4 : i32}> : (!tt.ptr<i32>, i32) -> i32
      %4 = "arith.cmpi"(%3, %1) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%4, %3) : (i1, i32) -> ()
    }, {
    ^bb0(%arg2: i32):
      "scf.yield"() : () -> ()
    }) : () -> i32
    "tt.store"(%arg1, %2) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

