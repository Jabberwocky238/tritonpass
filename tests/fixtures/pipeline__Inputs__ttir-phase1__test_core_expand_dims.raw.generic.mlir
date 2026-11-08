"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "expand_dims_kernel"}> ({
  ^bb0(%arg2: memref<?xf32>):
    "func.call"() <{callee = @triton.language.standard.sum__i32S32S_cNone_cFalse_cNone}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "triton.language.standard.sum__i32S32S_cNone_cFalse_cNone", sym_visibility = "private"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "triton.language.standard._sum_combine__i32_i32", sym_visibility = "private"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.addi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

