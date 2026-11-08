"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, i32) -> (), sym_name = "k"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: i32):
    "tt.print"(%arg1) <{hex = false, isSigned = array<i32: 0>, prefix = "x"}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

