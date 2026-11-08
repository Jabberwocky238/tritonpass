"builtin.module"() ({
  "func.func"() <{function_type = (memref<16xf32>, index) -> (), sym_name = "online_update"}> ({
  ^bb0(%arg0: memref<16xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
    "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, memref<16xf32>) -> ()
    "scf.for"(%0, %arg1, %1) ({
    ^bb0(%arg2: index):
      %4 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
      "linalg.copy"(%3, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg3: f32, %arg4: f32):
        "linalg.yield"(%arg3) : (f32) -> ()
      }) : (memref<16xf32>, memref<16xf32>) -> ()
      "memref.copy"(%4, %3) : (memref<16xf32>, memref<16xf32>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "memref.copy"(%3, %arg0) : (memref<16xf32>, memref<16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16xf32>, memref<16xf32>, index) -> (), sym_name = "init_read_after"}> ({
  ^bb0(%arg0: memref<16xf32>, %arg1: memref<16xf32>, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
    "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32):
      "linalg.yield"(%arg7) : (f32) -> ()
    }) : (f32, memref<16xf32>) -> ()
    %4 = "scf.for"(%0, %arg2, %1, %3) ({
    ^bb0(%arg3: index, %arg4: memref<16xf32>):
      %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
      "linalg.copy"(%arg4, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg5: f32, %arg6: f32):
        "linalg.yield"(%arg5) : (f32) -> ()
      }) : (memref<16xf32>, memref<16xf32>) -> ()
      "scf.yield"(%5) : (memref<16xf32>) -> ()
    }) : (index, index, index, memref<16xf32>) -> memref<16xf32>
    "memref.copy"(%4, %arg0) : (memref<16xf32>, memref<16xf32>) -> ()
    "memref.copy"(%3, %arg1) : (memref<16xf32>, memref<16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16xf32>, index) -> (), sym_name = "swap"}> ({
  ^bb0(%arg0: memref<16xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
    %4 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
    "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32):
      "linalg.yield"(%arg7) : (f32) -> ()
    }) : (f32, memref<16xf32>) -> ()
    "linalg.fill"(%2, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, memref<16xf32>) -> ()
    %5:2 = "scf.for"(%0, %arg1, %1, %3, %4) ({
    ^bb0(%arg2: index, %arg3: memref<16xf32>, %arg4: memref<16xf32>):
      "scf.yield"(%arg4, %arg3) : (memref<16xf32>, memref<16xf32>) -> ()
    }) : (index, index, index, memref<16xf32>, memref<16xf32>) -> (memref<16xf32>, memref<16xf32>)
    "memref.copy"(%5#0, %arg0) : (memref<16xf32>, memref<16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16xf32>, index) -> (), sym_name = "mixed"}> ({
  ^bb0(%arg0: memref<16xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
    "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, memref<16xf32>) -> ()
    %4 = "scf.for"(%0, %arg1, %1, %0) ({
    ^bb0(%arg2: index, %arg3: index):
      %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
      "linalg.copy"(%3, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg4: f32, %arg5: f32):
        "linalg.yield"(%arg4) : (f32) -> ()
      }) : (memref<16xf32>, memref<16xf32>) -> ()
      %6 = "arith.addi"(%arg3, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "memref.copy"(%5, %3) : (memref<16xf32>, memref<16xf32>) -> ()
      "scf.yield"(%6) : (index) -> ()
    }) : (index, index, index, index) -> index
    "memref.copy"(%3, %arg0) : (memref<16xf32>, memref<16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

