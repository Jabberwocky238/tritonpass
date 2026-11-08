"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> (), sym_name = "test_scalar_store", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %5 = "scf.for"(%0, %1, %3, %4) ({
    ^bb0(%arg1: i32, %arg2: i32):
      %6 = "arith.muli"(%arg1, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %7:2 = "scf.for"(%0, %2, %3, %6, %arg2) ({
      ^bb0(%arg3: i32, %arg4: i32, %arg5: i32):
        %8 = "arith.addi"(%arg4, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %9 = "arith.sitofp"(%8) : (i32) -> f32
        "tts.scatter"(%arg0, %arg5, %9) : (!tt.ptr<f32>, i32, f32) -> ()
        %10 = "arith.addi"(%arg5, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "scf.yield"(%8, %10) : (i32, i32) -> ()
      }) : (i32, i32, i32, i32, i32) -> (i32, i32)
      "scf.yield"(%7#1) : (i32) -> ()
    }) : (i32, i32, i32, i32) -> i32
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

