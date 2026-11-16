"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i32, i32, i32, i32, i32) -> i32, sym_name = "pkg.mod.helper__c-1", sym_visibility = "private"}> ({
  ^bb0(%arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32):
    %1 = "arith.addi"(%arg8, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "arith.addi"(%1, %arg10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!tt.ptr<i32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "func.call"(%arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7) <{callee = @"pkg.mod.helper__c-1"}> : (i32, i32, i32, i32, i32, i32, i32) -> i32
    "tt.store"(%arg0, %0) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

