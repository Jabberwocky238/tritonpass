"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<i32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<i32>):
    %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %1 = "arith.index_cast"(%0) : (index) -> i32
    %2 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %3 = "arith.index_cast"(%2) : (index) -> i32
    %4 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
    %5 = "arith.index_cast"(%4) : (index) -> i32
    %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
    %7 = "arith.index_cast"(%6) : (index) -> i32
    %8 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
    %9 = "arith.index_cast"(%8) : (index) -> i32
    %10 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
    %11 = "arith.index_cast"(%10) : (index) -> i32
    %12 = "arith.addi"(%1, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %13 = "arith.addi"(%5, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %14 = "arith.addi"(%9, %11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %15 = "arith.addi"(%12, %13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %16 = "arith.addi"(%15, %14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "tt.store"(%arg0, %16) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

