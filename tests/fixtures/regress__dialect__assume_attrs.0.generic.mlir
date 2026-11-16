"builtin.module"() ({
  "tt.func"() <{function_type = (i32) -> (), sym_name = "assume_attrs", sym_visibility = "public"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %2 = "arith.cmpi"(%arg0, %0) <{predicate = 4 : i64}> : (i32, i32) -> i1
    "llvm.intr.assume"(%2) <{op_bundle_sizes = array<i32>}> {tt.note = 1 : i32} : (i1) -> ()
    %3 = "arith.cmpi"(%arg0, %1) <{predicate = 2 : i64}> : (i32, i32) -> i1
    "llvm.intr.assume"(%3) <{op_bundle_sizes = array<i32>}> : (i1) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

