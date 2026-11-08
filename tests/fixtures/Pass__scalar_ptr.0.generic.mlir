"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, f32) -> (), sym_name = "direct", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: f32):
    %0 = "tts.make_tptr"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 1>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<1x!tt.ptr<f32>>
    %1 = "tt.splat"(%arg1) : (f32) -> tensor<1xf32>
    "tts.store"(%0, %1) <{static_mask_dims = array<i64>}> : (tensor<1x!tt.ptr<f32>>, tensor<1xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, f32) -> (), sym_name = "at_pid", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: f32):
    %0 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %1 = "tt.addptr"(%arg0, %0) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
    %2 = "arith.index_cast"(%0) : (i32) -> index
    %3 = "tts.make_tptr"(%arg0, %2) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 1>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<1x!tt.ptr<f32>>
    %4 = "tt.splat"(%arg1) : (f32) -> tensor<1xf32>
    "tts.store"(%3, %4) <{static_mask_dims = array<i64>}> : (tensor<1x!tt.ptr<f32>>, tensor<1xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, f32, i32) -> (), sym_name = "chain", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: f32, %arg2: i32):
    %0 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %1 = "tt.get_program_id"() <{axis = 1 : i32}> : () -> i32
    %2 = "arith.muli"(%0, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %3 = "tt.addptr"(%arg0, %2) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
    %4 = "tt.addptr"(%3, %1) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
    %5 = "arith.index_cast"(%2) : (i32) -> index
    %6 = "arith.index_cast"(%1) : (i32) -> index
    %7 = "arith.addi"(%5, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %8 = "tts.make_tptr"(%arg0, %7) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 1>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<1x!tt.ptr<f32>>
    %9 = "tt.splat"(%arg1) : (f32) -> tensor<1xf32>
    "tts.store"(%8, %9) <{static_mask_dims = array<i64>}> : (tensor<1x!tt.ptr<f32>>, tensor<1xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, f32, i64) -> (), sym_name = "i64_offset", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: f32, %arg2: i64):
    %0 = "tt.addptr"(%arg0, %arg2) : (!tt.ptr<f32>, i64) -> !tt.ptr<f32>
    %1 = "arith.index_cast"(%arg2) : (i64) -> index
    %2 = "tts.make_tptr"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 1>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>, index) -> tensor<1x!tt.ptr<f32>>
    %3 = "tt.splat"(%arg1) : (f32) -> tensor<1xf32>
    "tts.store"(%2, %3) <{static_mask_dims = array<i64>}> : (tensor<1x!tt.ptr<f32>>, tensor<1xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, i32) -> (), sym_name = "masked", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: i32):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "arith.cmpi"(%arg1, %1) <{predicate = 0 : i64}> : (i32, i32) -> i1
    "tt.store"(%arg0, %0, %2) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32, i1) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>) -> (), sym_name = "scalar_load", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>):
    %0 = "tt.load"(%arg0) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<f32>) -> f32
    %1 = "tts.make_tptr"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, order = array<i32>, sizes = array<i64: 1>, static_offsets = array<i64: 0>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<f32>) -> tensor<1x!tt.ptr<f32>>
    %2 = "tt.splat"(%0) : (f32) -> tensor<1xf32>
    "tts.store"(%1, %2) <{static_mask_dims = array<i64>}> : (tensor<1x!tt.ptr<f32>>, tensor<1xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, f32, i32) -> (), sym_name = "if_pointer", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: f32, %arg3: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.cmpi"(%arg3, %0) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %2 = "scf.if"(%1) ({
      "scf.yield"(%arg0) : (!tt.ptr<f32>) -> ()
    }, {
      "scf.yield"(%arg1) : (!tt.ptr<f32>) -> ()
    }) : (i1) -> !tt.ptr<f32>
    "tt.store"(%2, %arg2) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, f32, i32) -> (), sym_name = "select_pointer", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: f32, %arg3: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.cmpi"(%arg3, %0) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %2 = "arith.select"(%1, %arg0, %arg1) : (i1, !tt.ptr<f32>, !tt.ptr<f32>) -> !tt.ptr<f32>
    "tt.store"(%2, %arg2) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, f32, i32) -> (), sym_name = "if_pointer_plus_offset", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: f32, %arg3: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.cmpi"(%arg3, %0) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %2 = "scf.if"(%1) ({
      "scf.yield"(%arg0) : (!tt.ptr<f32>) -> ()
    }, {
      "scf.yield"(%arg1) : (!tt.ptr<f32>) -> ()
    }) : (i1) -> !tt.ptr<f32>
    %3 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %4 = "tt.addptr"(%2, %3) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
    "tt.store"(%4, %arg2) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, f32) -> (), sym_name = "tensor_store", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: f32):
    %0 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %1 = "tt.splat"(%arg1) : (f32) -> tensor<16xf32>
    %2 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<16x!tt.ptr<f32>>
    %3 = "tt.addptr"(%2, %0) : (tensor<16x!tt.ptr<f32>>, tensor<16xi32>) -> tensor<16x!tt.ptr<f32>>
    "tt.store"(%3, %1) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<16x!tt.ptr<f32>>, tensor<16xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

