"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, i32) -> (), sym_name = "_simple_add"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: i32):
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !tt.ptr<f32>
    %3 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %4 = "arith.index_cast"(%3) : (index) -> i32
    %5 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %6 = "arith.index_cast"(%5) : (index) -> i32
    %7 = "arith.muli"(%4, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %8 = "tt.addptr"(%2, %7) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
    %9 = "tt.addptr"(%8, %6) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
    %10 = "tt.atomic_rmw"(%9, %1, %0) <{atomic_rmw_op = 5 : i32, scope = 1 : i32, sem = 4 : i32}> : (!tt.ptr<f32>, f32, i1) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

