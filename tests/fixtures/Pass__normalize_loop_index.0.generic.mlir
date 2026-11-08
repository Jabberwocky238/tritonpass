"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, i32, i32) -> (), sym_name = "no_iter_args", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: i32, %arg2: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.index_cast"(%0) : (i32) -> index
    %3 = "arith.index_cast"(%arg1) : (i32) -> index
    %4 = "arith.index_cast"(%1) : (i32) -> index
    "scf.for"(%2, %3, %4) ({
    ^bb0(%arg3: index):
      %5 = "arith.index_cast"(%arg3) : (index) -> i32
      %6 = "arith.muli"(%5, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %7 = "tt.addptr"(%arg0, %6) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      %8 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      "tt.store"(%7, %8) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, i32) -> f32, sym_name = "with_f32_iter_arg", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1024 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "arith.index_cast"(%0) : (i32) -> index
    %4 = "arith.index_cast"(%arg1) : (i32) -> index
    %5 = "arith.index_cast"(%1) : (i32) -> index
    %6 = "scf.for"(%3, %4, %5, %2) ({
    ^bb0(%arg2: index, %arg3: f32):
      %7 = "arith.index_cast"(%arg2) : (index) -> i32
      %8 = "tt.addptr"(%arg0, %7) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
      %9 = "tt.load"(%8) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<f32>) -> f32
      %10 = "arith.addf"(%arg3, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%10) : (f32) -> ()
    }) : (index, index, index, f32) -> f32
    "tt.return"(%6) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> (), sym_name = "already_index", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    "scf.for"(%0, %2, %1) ({
    ^bb0(%arg1: index):
      %3 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      "tt.store"(%arg0, %3) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

