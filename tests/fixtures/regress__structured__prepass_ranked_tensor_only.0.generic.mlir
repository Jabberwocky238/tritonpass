"builtin.module"() ({
  "tt.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> vector<4xi32>, sym_name = "vector_iter"}> ({
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "scf.for"(%0, %2, %1, %arg0) ({
    ^bb0(%arg2: index, %arg3: vector<4xi32>):
      %4 = "arith.addi"(%arg3, %arg1) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
      "scf.yield"(%4) : (vector<4xi32>) -> ()
    }) : (index, index, index, vector<4xi32>) -> vector<4xi32>
    "tt.return"(%3) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (memref<4xi32>, memref<4xi32>, i1) -> memref<4xi32>, sym_name = "memref_iter"}> ({
  ^bb0(%arg0: memref<4xi32>, %arg1: memref<4xi32>, %arg2: i1):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "scf.for"(%0, %2, %1, %arg0) ({
    ^bb0(%arg3: index, %arg4: memref<4xi32>):
      %4 = "arith.select"(%arg2, %arg4, %arg1) : (i1, memref<4xi32>, memref<4xi32>) -> memref<4xi32>
      "scf.yield"(%4) : (memref<4xi32>) -> ()
    }) : (index, index, index, memref<4xi32>) -> memref<4xi32>
    "tt.return"(%3) : (memref<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

