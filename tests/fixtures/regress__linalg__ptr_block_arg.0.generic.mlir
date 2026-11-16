"builtin.module"() ({
  "tt.func"() <{function_type = (memref<?xf32>, i1, i32) -> (), sym_name = "cf"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: i1, %arg2: i32):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !tt.ptr<f32>
    %1 = "tt.addptr"(%0, %arg2) : (!tt.ptr<f32>, i32) -> !tt.ptr<f32>
    "cf.cond_br"(%arg1, %1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, !tt.ptr<f32>) -> ()
  ^bb1(%2: !tt.ptr<f32>):  // pred: ^bb0
    %3 = "tt.load"(%2) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<f32>) -> f32
    "tt.store"(%2, %3) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
    "tt.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

