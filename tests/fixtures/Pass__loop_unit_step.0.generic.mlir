"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<?xf32>) -> (), sym_name = "block_scan"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<?xf32>):
    %0 = "arith.constant"() <{value = 512 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 511 : index}> : () -> index
    %4 = "arith.subi"(%arg1, %arg0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %5 = "arith.addi"(%4, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %6 = "arith.divsi"(%5, %0) : (index, index) -> index
    "scf.for"(%1, %6, %2) ({
    ^bb0(%arg3: index):
      %7 = "arith.muli"(%arg3, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %8 = "arith.addi"(%7, %arg0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %9 = "memref.subview"(%arg2, %8) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 512>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<512xf32, strided<[1], offset: ?>>
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, f32) -> f32, sym_name = "carried"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: f32):
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3 : index}> : () -> index
    %4 = "arith.subi"(%arg1, %arg0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %5 = "arith.addi"(%4, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %6 = "arith.divsi"(%5, %0) : (index, index) -> index
    %7 = "scf.for"(%1, %6, %2, %arg2) ({
    ^bb0(%arg3: index, %arg4: f32):
      %8 = "arith.muli"(%arg3, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %9 = "arith.addi"(%8, %arg0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%arg4) : (f32) -> ()
    }) : (index, index, index, f32) -> f32
    "func.return"(%7) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "constant_upper"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1 = "arith.constant"() <{value = 100 : index}> : () -> index
    "scf.for"(%arg0, %1, %0) ({
    ^bb0(%arg1: index):
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "unit_step"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%arg0, %arg1, %0) ({
    ^bb0(%arg2: index):
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

