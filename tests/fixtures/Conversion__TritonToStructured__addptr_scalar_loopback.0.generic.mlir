"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, i32) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>, %arg2: i32):
    %0 = "tt.addptr"(%arg0, %arg2) : (!tt.ptr<bf16>, i32) -> !tt.ptr<bf16>
    %1 = "tt.addptr"(%arg1, %arg2) : (!tt.ptr<bf16>, i32) -> !tt.ptr<bf16>
    %2 = "tt.load"(%0) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<bf16>) -> bf16
    "tt.store"(%1, %2) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<bf16>, bf16) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

