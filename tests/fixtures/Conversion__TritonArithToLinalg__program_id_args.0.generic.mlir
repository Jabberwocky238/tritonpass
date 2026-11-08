"builtin.module"() ({
  "func.func"() <{arg_attrs = [{}, {dope.sys = "num_programs_x"}, {dope.sys = "num_programs_y"}, {dope.sys = "num_programs_z"}, {dope.sys = "program_id_x"}, {dope.sys = "program_id_y"}, {dope.sys = "program_id_z"}], function_type = (!tt.ptr<i32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32):
    %0 = "arith.addi"(%arg4, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "tt.store"(%arg0, %0) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

