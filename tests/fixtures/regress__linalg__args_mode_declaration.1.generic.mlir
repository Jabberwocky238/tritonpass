"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "decl", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!tt.ptr<i32>, i32) -> (), sym_name = "k"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32):
    %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %1 = "arith.index_cast"(%0) : (index) -> i32
    %2 = "arith.addi"(%arg1, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "tt.store"(%arg0, %2) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

