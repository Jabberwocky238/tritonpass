"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i32>, i32, i32) -> i32, sym_name = "vllm_shape", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32, %arg2: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %5 = "arith.subi"(%arg1, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %7:2 = "scf.for"(%6, %3, %4, %0, %arg1) ({
    ^bb0(%arg3: i32, %arg4: i32, %arg5: i32):
      %8 = "arith.cmpi"(%arg4, %arg5) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %9 = "arith.addi"(%arg4, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %10 = "arith.divsi"(%9, %2) : (i32, i32) -> i32
      %11 = "arith.minsi"(%10, %5) : (i32, i32) -> i32
      %12 = "arith.maxsi"(%11, %6) : (i32, i32) -> i32
      %13 = "tt.addptr"(%arg0, %12) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      %14 = "tt.load"(%13) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
      %15 = "arith.cmpi"(%14, %arg2) <{predicate = 3 : i64}> : (i32, i32) -> i1
      %16 = "arith.select"(%15, %arg5, %12) : (i1, i32, i32) -> i32
      %17 = "arith.addi"(%12, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %18 = "arith.select"(%15, %17, %arg4) : (i1, i32, i32) -> i32
      %19 = "arith.select"(%8, %18, %arg4) : (i1, i32, i32) -> i32
      %20 = "arith.select"(%8, %16, %arg5) : (i1, i32, i32) -> i32
      "scf.yield"(%19, %20) : (i32, i32) -> ()
    }) : (i32, i32, i32, i32, i32) -> (i32, i32)
    "tt.return"(%7#0) : (i32) -> ()
  }) {dope.preconditions = [[1, -1, 65535]]} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i32>, i32, i32) -> i32, sym_name = "mirrored_shape", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32, %arg2: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %5 = "arith.subi"(%arg1, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %7:2 = "scf.for"(%6, %3, %4, %0, %arg1) ({
    ^bb0(%arg3: i32, %arg4: i32, %arg5: i32):
      %8 = "arith.cmpi"(%arg4, %arg5) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %9 = "arith.addi"(%arg4, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %10 = "arith.divsi"(%9, %2) : (i32, i32) -> i32
      %11 = "arith.minsi"(%10, %5) : (i32, i32) -> i32
      %12 = "arith.maxsi"(%11, %6) : (i32, i32) -> i32
      %13 = "tt.addptr"(%arg0, %12) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      %14 = "tt.load"(%13) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
      %15 = "arith.cmpi"(%14, %arg2) <{predicate = 5 : i64}> : (i32, i32) -> i1
      %16 = "arith.select"(%15, %12, %arg5) : (i1, i32, i32) -> i32
      %17 = "arith.addi"(%12, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %18 = "arith.select"(%15, %arg4, %17) : (i1, i32, i32) -> i32
      %19 = "arith.select"(%8, %18, %arg4) : (i1, i32, i32) -> i32
      %20 = "arith.select"(%8, %16, %arg5) : (i1, i32, i32) -> i32
      "scf.yield"(%19, %20) : (i32, i32) -> ()
    }) : (i32, i32, i32, i32, i32) -> (i32, i32)
    "tt.return"(%7#0) : (i32) -> ()
  }) {dope.preconditions = [[1, -1, 65535]]} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (i32, i32) -> i32, sym_name = "no_reads", sym_visibility = "public"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %5 = "arith.subi"(%arg0, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %7:2 = "scf.for"(%6, %3, %4, %0, %arg0) ({
    ^bb0(%arg2: i32, %arg3: i32, %arg4: i32):
      %8 = "arith.cmpi"(%arg3, %arg4) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %9 = "arith.addi"(%arg3, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %10 = "arith.divsi"(%9, %2) : (i32, i32) -> i32
      %11 = "arith.muli"(%10, %10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %12 = "arith.cmpi"(%11, %arg1) <{predicate = 3 : i64}> : (i32, i32) -> i1
      %13 = "arith.select"(%12, %arg4, %10) : (i1, i32, i32) -> i32
      %14 = "arith.addi"(%10, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %15 = "arith.select"(%12, %14, %arg3) : (i1, i32, i32) -> i32
      %16 = "arith.select"(%8, %15, %arg3) : (i1, i32, i32) -> i32
      %17 = "arith.select"(%8, %13, %arg4) : (i1, i32, i32) -> i32
      "scf.yield"(%16, %17) : (i32, i32) -> ()
    }) : (i32, i32, i32, i32, i32) -> (i32, i32)
    "tt.return"(%7#0) : (i32) -> ()
  }) {dope.preconditions = [[0, -1, 65535]]} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (i32, i32, i32) -> i32, sym_name = "left_not_constant", sym_visibility = "public"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %2:2 = "scf.while"(%arg0, %arg1) ({
    ^bb0(%arg5: i32, %arg6: i32):
      %9 = "arith.cmpi"(%arg5, %arg6) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%9, %arg5, %arg6) : (i1, i32, i32) -> ()
    }, {
    ^bb0(%arg3: i32, %arg4: i32):
      %3 = "arith.addi"(%arg3, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %4 = "arith.divsi"(%3, %1) : (i32, i32) -> i32
      %5 = "arith.cmpi"(%4, %arg2) <{predicate = 3 : i64}> : (i32, i32) -> i1
      %6 = "arith.select"(%5, %arg4, %4) : (i1, i32, i32) -> i32
      %7 = "arith.addi"(%4, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %8 = "arith.select"(%5, %7, %arg3) : (i1, i32, i32) -> i32
      "scf.yield"(%8, %6) : (i32, i32) -> ()
    }) : (i32, i32) -> (i32, i32)
    "tt.return"(%2#0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (i32, i32) -> i32, sym_name = "left_negative_constant", sym_visibility = "public"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.constant"() <{value = -4 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3:2 = "scf.while"(%0, %arg0) ({
    ^bb0(%arg4: i32, %arg5: i32):
      %10 = "arith.cmpi"(%arg4, %arg5) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%10, %arg4, %arg5) : (i1, i32, i32) -> ()
    }, {
    ^bb0(%arg2: i32, %arg3: i32):
      %4 = "arith.addi"(%arg2, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %5 = "arith.divsi"(%4, %2) : (i32, i32) -> i32
      %6 = "arith.cmpi"(%5, %arg1) <{predicate = 3 : i64}> : (i32, i32) -> i1
      %7 = "arith.select"(%6, %arg3, %5) : (i1, i32, i32) -> i32
      %8 = "arith.addi"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %9 = "arith.select"(%6, %8, %arg2) : (i1, i32, i32) -> i32
      "scf.yield"(%9, %7) : (i32, i32) -> ()
    }) : (i32, i32) -> (i32, i32)
    "tt.return"(%3#0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (i32, i32) -> i32, sym_name = "condition_sle", sym_visibility = "public"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3:2 = "scf.while"(%0, %arg0) ({
    ^bb0(%arg4: i32, %arg5: i32):
      %10 = "arith.cmpi"(%arg4, %arg5) <{predicate = 3 : i64}> : (i32, i32) -> i1
      "scf.condition"(%10, %arg4, %arg5) : (i1, i32, i32) -> ()
    }, {
    ^bb0(%arg2: i32, %arg3: i32):
      %4 = "arith.addi"(%arg2, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %5 = "arith.divsi"(%4, %2) : (i32, i32) -> i32
      %6 = "arith.cmpi"(%5, %arg1) <{predicate = 3 : i64}> : (i32, i32) -> i1
      %7 = "arith.select"(%6, %arg3, %5) : (i1, i32, i32) -> i32
      %8 = "arith.addi"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %9 = "arith.select"(%6, %8, %arg2) : (i1, i32, i32) -> i32
      "scf.yield"(%9, %7) : (i32, i32) -> ()
    }) : (i32, i32) -> (i32, i32)
    "tt.return"(%3#0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (i32, i32) -> i32, sym_name = "mid_divides_by_three", sym_visibility = "public"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %3:2 = "scf.while"(%0, %arg0) ({
    ^bb0(%arg4: i32, %arg5: i32):
      %10 = "arith.cmpi"(%arg4, %arg5) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%10, %arg4, %arg5) : (i1, i32, i32) -> ()
    }, {
    ^bb0(%arg2: i32, %arg3: i32):
      %4 = "arith.addi"(%arg2, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %5 = "arith.divsi"(%4, %2) : (i32, i32) -> i32
      %6 = "arith.cmpi"(%5, %arg1) <{predicate = 3 : i64}> : (i32, i32) -> i1
      %7 = "arith.select"(%6, %arg3, %5) : (i1, i32, i32) -> i32
      %8 = "arith.addi"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %9 = "arith.select"(%6, %8, %arg2) : (i1, i32, i32) -> i32
      "scf.yield"(%9, %7) : (i32, i32) -> ()
    }) : (i32, i32) -> (i32, i32)
    "tt.return"(%3#0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (i32, i32) -> i32, sym_name = "left_is_mid_not_mid_plus_one", sym_visibility = "public"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %2:2 = "scf.while"(%0, %arg0) ({
    ^bb0(%arg4: i32, %arg5: i32):
      %8 = "arith.cmpi"(%arg4, %arg5) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%8, %arg4, %arg5) : (i1, i32, i32) -> ()
    }, {
    ^bb0(%arg2: i32, %arg3: i32):
      %3 = "arith.addi"(%arg2, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %4 = "arith.divsi"(%3, %1) : (i32, i32) -> i32
      %5 = "arith.cmpi"(%4, %arg1) <{predicate = 3 : i64}> : (i32, i32) -> i1
      %6 = "arith.select"(%5, %arg3, %4) : (i1, i32, i32) -> i32
      %7 = "arith.select"(%5, %4, %arg2) : (i1, i32, i32) -> i32
      "scf.yield"(%7, %6) : (i32, i32) -> ()
    }) : (i32, i32) -> (i32, i32)
    "tt.return"(%2#0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (i32, i32) -> i32, sym_name = "two_different_predicates", sym_visibility = "public"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3:2 = "scf.while"(%0, %arg0) ({
    ^bb0(%arg4: i32, %arg5: i32):
      %11 = "arith.cmpi"(%arg4, %arg5) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%11, %arg4, %arg5) : (i1, i32, i32) -> ()
    }, {
    ^bb0(%arg2: i32, %arg3: i32):
      %4 = "arith.addi"(%arg2, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %5 = "arith.divsi"(%4, %2) : (i32, i32) -> i32
      %6 = "arith.cmpi"(%5, %arg1) <{predicate = 3 : i64}> : (i32, i32) -> i1
      %7 = "arith.cmpi"(%5, %arg1) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %8 = "arith.select"(%6, %arg3, %5) : (i1, i32, i32) -> i32
      %9 = "arith.addi"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %10 = "arith.select"(%7, %9, %arg2) : (i1, i32, i32) -> i32
      "scf.yield"(%10, %8) : (i32, i32) -> ()
    }) : (i32, i32) -> (i32, i32)
    "tt.return"(%3#0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i32>, i32, i32) -> i32, sym_name = "body_has_store", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32, %arg2: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3:2 = "scf.while"(%0, %arg1) ({
    ^bb0(%arg5: i32, %arg6: i32):
      %10 = "arith.cmpi"(%arg5, %arg6) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%10, %arg5, %arg6) : (i1, i32, i32) -> ()
    }, {
    ^bb0(%arg3: i32, %arg4: i32):
      %4 = "arith.addi"(%arg3, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %5 = "arith.divsi"(%4, %2) : (i32, i32) -> i32
      "tt.store"(%arg0, %5) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
      %6 = "arith.cmpi"(%5, %arg2) <{predicate = 3 : i64}> : (i32, i32) -> i1
      %7 = "arith.select"(%6, %arg4, %5) : (i1, i32, i32) -> i32
      %8 = "arith.addi"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %9 = "arith.select"(%6, %8, %arg3) : (i1, i32, i32) -> i32
      "scf.yield"(%9, %7) : (i32, i32) -> ()
    }) : (i32, i32) -> (i32, i32)
    "tt.return"(%3#0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i32>, i32, i32) -> i32, sym_name = "load_index_is_not_mid", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32, %arg2: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3:2 = "scf.while"(%0, %arg1) ({
    ^bb0(%arg5: i32, %arg6: i32):
      %12 = "arith.cmpi"(%arg5, %arg6) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%12, %arg5, %arg6) : (i1, i32, i32) -> ()
    }, {
    ^bb0(%arg3: i32, %arg4: i32):
      %4 = "arith.addi"(%arg3, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %5 = "arith.divsi"(%4, %2) : (i32, i32) -> i32
      %6 = "tt.addptr"(%arg0, %arg3) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      %7 = "tt.load"(%6) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
      %8 = "arith.cmpi"(%7, %arg2) <{predicate = 3 : i64}> : (i32, i32) -> i1
      %9 = "arith.select"(%8, %arg4, %5) : (i1, i32, i32) -> i32
      %10 = "arith.addi"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %11 = "arith.select"(%8, %10, %arg3) : (i1, i32, i32) -> i32
      "scf.yield"(%11, %9) : (i32, i32) -> ()
    }) : (i32, i32) -> (i32, i32)
    "tt.return"(%3#0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i32>, i32, i32) -> i32, sym_name = "divide_by_loaded_value", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32, %arg2: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3:2 = "scf.while"(%0, %arg1) ({
    ^bb0(%arg5: i32, %arg6: i32):
      %13 = "arith.cmpi"(%arg5, %arg6) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%13, %arg5, %arg6) : (i1, i32, i32) -> ()
    }, {
    ^bb0(%arg3: i32, %arg4: i32):
      %4 = "arith.addi"(%arg3, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %5 = "arith.divsi"(%4, %2) : (i32, i32) -> i32
      %6 = "tt.addptr"(%arg0, %5) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      %7 = "tt.load"(%6) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
      %8 = "arith.divsi"(%arg2, %7) : (i32, i32) -> i32
      %9 = "arith.cmpi"(%8, %arg2) <{predicate = 3 : i64}> : (i32, i32) -> i1
      %10 = "arith.select"(%9, %arg4, %5) : (i1, i32, i32) -> i32
      %11 = "arith.addi"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %12 = "arith.select"(%9, %11, %arg3) : (i1, i32, i32) -> i32
      "scf.yield"(%12, %10) : (i32, i32) -> ()
    }) : (i32, i32) -> (i32, i32)
    "tt.return"(%3#0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (i64, i64) -> i64, sym_name = "wide_i64", sym_visibility = "public"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %1 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    %3:2 = "scf.while"(%0, %arg0) ({
    ^bb0(%arg4: i64, %arg5: i64):
      %10 = "arith.cmpi"(%arg4, %arg5) <{predicate = 2 : i64}> : (i64, i64) -> i1
      "scf.condition"(%10, %arg4, %arg5) : (i1, i64, i64) -> ()
    }, {
    ^bb0(%arg2: i64, %arg3: i64):
      %4 = "arith.addi"(%arg2, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %5 = "arith.divsi"(%4, %2) : (i64, i64) -> i64
      %6 = "arith.cmpi"(%5, %arg1) <{predicate = 3 : i64}> : (i64, i64) -> i1
      %7 = "arith.select"(%6, %arg3, %5) : (i1, i64, i64) -> i64
      %8 = "arith.addi"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %9 = "arith.select"(%6, %8, %arg2) : (i1, i64, i64) -> i64
      "scf.yield"(%9, %7) : (i64, i64) -> ()
    }) : (i64, i64) -> (i64, i64)
    "tt.return"(%3#0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i32>, i32) -> i32, sym_name = "constant_width", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 100 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %6 = "arith.subi"(%3, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %7 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %8:2 = "scf.for"(%7, %4, %5, %0, %3) ({
    ^bb0(%arg2: i32, %arg3: i32, %arg4: i32):
      %9 = "arith.cmpi"(%arg3, %arg4) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %10 = "arith.addi"(%arg3, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %11 = "arith.divsi"(%10, %2) : (i32, i32) -> i32
      %12 = "arith.minsi"(%11, %6) : (i32, i32) -> i32
      %13 = "arith.maxsi"(%12, %7) : (i32, i32) -> i32
      %14 = "tt.addptr"(%arg0, %13) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      %15 = "tt.load"(%14) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
      %16 = "arith.cmpi"(%15, %arg1) <{predicate = 3 : i64}> : (i32, i32) -> i1
      %17 = "arith.select"(%16, %arg4, %13) : (i1, i32, i32) -> i32
      %18 = "arith.addi"(%13, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %19 = "arith.select"(%16, %18, %arg3) : (i1, i32, i32) -> i32
      %20 = "arith.select"(%9, %19, %arg3) : (i1, i32, i32) -> i32
      %21 = "arith.select"(%9, %17, %arg4) : (i1, i32, i32) -> i32
      "scf.yield"(%20, %21) : (i32, i32) -> ()
    }) : (i32, i32, i32, i32, i32) -> (i32, i32)
    "tt.return"(%8#0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i32>, i32, i32) -> i32, sym_name = "derived_width", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32, %arg2: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3 = "arith.addi"(%arg1, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "arith.cmpi"(%0, %3) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %5 = "arith.subi"(%3, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %7 = "arith.cmpi"(%5, %6) <{predicate = 4 : i64}> : (i32, i32) -> i1
    %8 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %9 = "arith.maxsi"(%5, %8) : (i32, i32) -> i32
    %10 = "arith.constant"() <{value = 65536 : i32}> : () -> i32
    %11 = "arith.cmpi"(%9, %10) <{predicate = 5 : i64}> : (i32, i32) -> i1
    %12 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %13 = "arith.shrsi"(%9, %12) : (i32, i32) -> i32
    %14 = "arith.select"(%11, %13, %9) : (i1, i32, i32) -> i32
    %15 = "arith.select"(%11, %12, %6) : (i1, i32, i32) -> i32
    %16 = "arith.addi"(%6, %15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %17 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %18 = "arith.cmpi"(%14, %17) <{predicate = 5 : i64}> : (i32, i32) -> i1
    %19 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %20 = "arith.shrsi"(%14, %19) : (i32, i32) -> i32
    %21 = "arith.select"(%18, %20, %14) : (i1, i32, i32) -> i32
    %22 = "arith.select"(%18, %19, %6) : (i1, i32, i32) -> i32
    %23 = "arith.addi"(%16, %22) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %24 = "arith.cmpi"(%21, %12) <{predicate = 5 : i64}> : (i32, i32) -> i1
    %25 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %26 = "arith.shrsi"(%21, %25) : (i32, i32) -> i32
    %27 = "arith.select"(%24, %26, %21) : (i1, i32, i32) -> i32
    %28 = "arith.select"(%24, %25, %6) : (i1, i32, i32) -> i32
    %29 = "arith.addi"(%23, %28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %30 = "arith.cmpi"(%27, %25) <{predicate = 5 : i64}> : (i32, i32) -> i1
    %31 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %32 = "arith.shrsi"(%27, %31) : (i32, i32) -> i32
    %33 = "arith.select"(%30, %32, %27) : (i1, i32, i32) -> i32
    %34 = "arith.select"(%30, %31, %6) : (i1, i32, i32) -> i32
    %35 = "arith.addi"(%29, %34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %36 = "arith.cmpi"(%33, %31) <{predicate = 5 : i64}> : (i32, i32) -> i1
    %37 = "arith.shrsi"(%33, %8) : (i32, i32) -> i32
    %38 = "arith.select"(%36, %37, %33) : (i1, i32, i32) -> i32
    %39 = "arith.select"(%36, %8, %6) : (i1, i32, i32) -> i32
    %40 = "arith.addi"(%35, %39) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %41 = "arith.addi"(%40, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %42 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %43 = "arith.select"(%7, %41, %42) : (i1, i32, i32) -> i32
    %44 = "arith.select"(%4, %43, %6) : (i1, i32, i32) -> i32
    %45 = "arith.subi"(%3, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %46:2 = "scf.for"(%6, %44, %8, %0, %3) ({
    ^bb0(%arg3: i32, %arg4: i32, %arg5: i32):
      %47 = "arith.cmpi"(%arg4, %arg5) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %48 = "arith.addi"(%arg4, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %49 = "arith.divsi"(%48, %2) : (i32, i32) -> i32
      %50 = "arith.minsi"(%49, %45) : (i32, i32) -> i32
      %51 = "arith.maxsi"(%50, %6) : (i32, i32) -> i32
      %52 = "tt.addptr"(%arg0, %51) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
      %53 = "tt.load"(%52) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
      %54 = "arith.cmpi"(%53, %arg2) <{predicate = 3 : i64}> : (i32, i32) -> i1
      %55 = "arith.select"(%54, %arg5, %51) : (i1, i32, i32) -> i32
      %56 = "arith.addi"(%51, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %57 = "arith.select"(%54, %56, %arg4) : (i1, i32, i32) -> i32
      %58 = "arith.select"(%47, %57, %arg4) : (i1, i32, i32) -> i32
      %59 = "arith.select"(%47, %55, %arg5) : (i1, i32, i32) -> i32
      "scf.yield"(%58, %59) : (i32, i32) -> ()
    }) : (i32, i32, i32, i32, i32) -> (i32, i32)
    "tt.return"(%46#0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

