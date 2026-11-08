"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i32>, i32) -> (), sym_name = "aligned", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %3 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %4 = "tt.splat"(%arg0) : (!tt.ptr<i32>) -> tensor<16x!tt.ptr<i32>>
    "scf.for"(%0, %arg1, %1) ({
    ^bb0(%arg2: i32):
      %5 = "arith.muli"(%arg2, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %6 = "arith.divsi"(%5, %2) : (i32, i32) -> i32
      %7 = "tt.splat"(%6) : (i32) -> tensor<16xi32>
      %8 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
      %9 = "arith.addi"(%7, %8) <{overflowFlags = #arith.overflow<none>}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
      %10 = "tt.addptr"(%4, %3) : (tensor<16x!tt.ptr<i32>>, tensor<16xi32>) -> tensor<16x!tt.ptr<i32>>
      "tt.store"(%10, %9) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<16x!tt.ptr<i32>>, tensor<16xi32>) -> ()
      "scf.yield"() : () -> ()
    }) : (i32, i32, i32) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i32>, i32) -> (), sym_name = "base_not_a_multiple", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = dense<16> : tensor<16xi32>}> : () -> tensor<16xi32>
    %4 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %5 = "tt.splat"(%arg0) : (!tt.ptr<i32>) -> tensor<16x!tt.ptr<i32>>
    "scf.for"(%0, %arg1, %1) ({
    ^bb0(%arg2: i32):
      %6 = "arith.muli"(%arg2, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %7 = "tt.splat"(%6) : (i32) -> tensor<16xi32>
      %8 = "arith.addi"(%7, %4) <{overflowFlags = #arith.overflow<none>}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
      %9 = "arith.divsi"(%8, %3) : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
      %10 = "arith.remsi"(%8, %3) : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
      %11 = "arith.addi"(%9, %10) <{overflowFlags = #arith.overflow<none>}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
      %12 = "tt.addptr"(%5, %4) : (tensor<16x!tt.ptr<i32>>, tensor<16xi32>) -> tensor<16x!tt.ptr<i32>>
      "tt.store"(%12, %11) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<16x!tt.ptr<i32>>, tensor<16xi32>) -> ()
      "scf.yield"() : () -> ()
    }) : (i32, i32, i32) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i32>, i32) -> (), sym_name = "base_maybe_negative", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32):
    %0 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = dense<16> : tensor<16xi32>}> : () -> tensor<16xi32>
    %2 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %3 = "tt.splat"(%arg0) : (!tt.ptr<i32>) -> tensor<16x!tt.ptr<i32>>
    %4 = "arith.muli"(%arg1, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %5 = "tt.splat"(%4) : (i32) -> tensor<16xi32>
    %6 = "arith.addi"(%5, %2) <{overflowFlags = #arith.overflow<none>}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %7 = "arith.divsi"(%6, %1) : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
    %8 = "tt.addptr"(%3, %2) : (tensor<16x!tt.ptr<i32>>, tensor<16xi32>) -> tensor<16x!tt.ptr<i32>>
    "tt.store"(%8, %7) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<16x!tt.ptr<i32>>, tensor<16xi32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i32>, i32) -> (), sym_name = "tile_spans_two_blocks", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = dense<16> : tensor<32xi32>}> : () -> tensor<32xi32>
    %4 = "tt.make_range"() <{end = 32 : i32, start = 0 : i32}> : () -> tensor<32xi32>
    %5 = "tt.splat"(%arg0) : (!tt.ptr<i32>) -> tensor<32x!tt.ptr<i32>>
    "scf.for"(%0, %arg1, %1) ({
    ^bb0(%arg2: i32):
      %6 = "arith.muli"(%arg2, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %7 = "tt.splat"(%6) : (i32) -> tensor<32xi32>
      %8 = "arith.addi"(%7, %4) <{overflowFlags = #arith.overflow<none>}> : (tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
      %9 = "arith.divsi"(%8, %3) : (tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
      %10 = "tt.addptr"(%5, %4) : (tensor<32x!tt.ptr<i32>>, tensor<32xi32>) -> tensor<32x!tt.ptr<i32>>
      "tt.store"(%10, %9) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<i32>>, tensor<32xi32>) -> ()
      "scf.yield"() : () -> ()
    }) : (i32, i32, i32) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i32>, !tt.ptr<i32>, i32) -> (), sym_name = "uniform_load", sym_visibility = "public"}> ({
  ^bb0(%arg4: !tt.ptr<i32>, %arg5: !tt.ptr<i32>, %arg6: i32):
    %9 = "tt.addptr"(%arg4, %arg6) : (!tt.ptr<i32>, i32) -> !tt.ptr<i32>
    %10 = "tt.load"(%9) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i32>) -> i32
    %11 = "tt.splat"(%10) : (i32) -> tensor<16xi32>
    %12 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %13 = "tt.splat"(%arg5) : (!tt.ptr<i32>) -> tensor<16x!tt.ptr<i32>>
    %14 = "tt.addptr"(%13, %12) : (tensor<16x!tt.ptr<i32>>, tensor<16xi32>) -> tensor<16x!tt.ptr<i32>>
    "tt.store"(%14, %11) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<16x!tt.ptr<i32>>, tensor<16xi32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
  "tt.func"() <{function_type = (!tt.ptr<i32>, !tt.ptr<i32>, i32, i32) -> (), sym_name = "masked_uniform_load", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i32>, %arg1: !tt.ptr<i32>, %arg2: i32, %arg3: i32):
    %0 = "tt.splat"(%arg2) : (i32) -> tensor<16xi32>
    %1 = "tt.splat"(%arg0) : (!tt.ptr<i32>) -> tensor<16x!tt.ptr<i32>>
    %2 = "tt.addptr"(%1, %0) : (tensor<16x!tt.ptr<i32>>, tensor<16xi32>) -> tensor<16x!tt.ptr<i32>>
    %3 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %4 = "tt.splat"(%arg3) : (i32) -> tensor<16xi32>
    %5 = "arith.cmpi"(%3, %4) <{predicate = 2 : i64}> : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi1>
    %6 = "tt.load"(%2, %5) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<16x!tt.ptr<i32>>, tensor<16xi1>) -> tensor<16xi32>
    %7 = "tt.splat"(%arg1) : (!tt.ptr<i32>) -> tensor<16x!tt.ptr<i32>>
    %8 = "tt.addptr"(%7, %3) : (tensor<16x!tt.ptr<i32>>, tensor<16xi32>) -> tensor<16x!tt.ptr<i32>>
    "tt.store"(%8, %6) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<16x!tt.ptr<i32>>, tensor<16xi32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i32>) -> (), sym_name = "range_compare", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i32>):
    %0 = "arith.constant"() <{value = dense<1> : tensor<128xi32>}> : () -> tensor<128xi32>
    %1 = "arith.constant"() <{value = dense<0> : tensor<128xi32>}> : () -> tensor<128xi32>
    %2 = "arith.constant"() <{value = dense<100> : tensor<128xi32>}> : () -> tensor<128xi32>
    %3 = "tt.make_range"() <{end = 128 : i32, start = 0 : i32}> : () -> tensor<128xi32>
    %4 = "arith.cmpi"(%3, %2) <{predicate = 2 : i64}> : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %5 = "arith.select"(%4, %0, %1) : (tensor<128xi1>, tensor<128xi32>, tensor<128xi32>) -> tensor<128xi32>
    %6 = "tt.splat"(%arg0) : (!tt.ptr<i32>) -> tensor<128x!tt.ptr<i32>>
    %7 = "tt.addptr"(%6, %3) : (tensor<128x!tt.ptr<i32>>, tensor<128xi32>) -> tensor<128x!tt.ptr<i32>>
    "tt.store"(%7, %5) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<128x!tt.ptr<i32>>, tensor<128xi32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

