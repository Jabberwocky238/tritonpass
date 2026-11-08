"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, i32, i32) -> (), sym_name = "dead_switch", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: i32, %arg2: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %3 = "arith.cmpi"(%2, %arg1) <{predicate = 5 : i64}> : (i32, i32) -> i1
    "scf.if"(%3) ({
      "scf.yield"() : () -> ()
    }, {
      %4 = "arith.cmpi"(%2, %arg2) <{predicate = 5 : i64}> : (i32, i32) -> i1
      "scf.if"(%4) ({
        "scf.yield"() : () -> ()
      }, {
        %5 = "tt.make_range"() <{end = 64 : i32, start = 0 : i32}> : () -> tensor<64xi32>
        %6 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<64x!tt.ptr<f32>>
        %7 = "tt.addptr"(%6, %5) : (tensor<64x!tt.ptr<f32>>, tensor<64xi32>) -> tensor<64x!tt.ptr<f32>>
        %8 = "tt.load"(%7) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<64x!tt.ptr<f32>>) -> tensor<64xf32>
        "tt.store"(%7, %8) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<64x!tt.ptr<f32>>, tensor<64xf32>) -> ()
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (index) -> (), sym_name = "real_switch", sym_visibility = "public"}> ({
  ^bb0(%arg0: index):
    "scf.index_switch"(%arg0) <{cases = array<i64: 0>}> ({
      %0 = "arith.constant"() <{value = 7 : i32}> : () -> i32
      "scf.yield"() : () -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : (index) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (index, f32) -> (), sym_name = "switch_with_result", sym_visibility = "public"}> ({
  ^bb0(%arg0: index, %arg1: f32):
    %0 = "scf.index_switch"(%arg0) <{cases = array<i64: 0>}> ({
      "scf.yield"(%arg1) : (f32) -> ()
    }, {
      "scf.yield"(%arg1) : (f32) -> ()
    }) : (index) -> f32
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

