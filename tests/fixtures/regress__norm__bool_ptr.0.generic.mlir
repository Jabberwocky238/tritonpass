// -----
// -----
// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i8>, !tt.ptr<i8>) -> (), sym_name = "address_space_default", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i8>, %arg1: !tt.ptr<i8>):
    %0 = "tt.load"(%arg0) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i8>) -> i8
    "tt.store"(%arg1, %0) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i8>, i8) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i8>, !tt.ptr<i8>) -> (), sym_name = "address_space_explicit", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i8>, %arg1: !tt.ptr<i8>):
    %0 = "tt.load"(%arg0) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<i8>) -> i8
    "tt.store"(%arg1, %0) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i8>, i8) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

