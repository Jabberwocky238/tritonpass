"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>) -> (), sym_name = "add_ptr_into_make_block_ptr", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 32768 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %3 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %4 = "arith.constant"() <{value = 512 : i64}> : () -> i64
    %5 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %6 = "arith.extsi"(%5) : (i32) -> i64
    %7 = "arith.muli"(%6, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %8 = "arith.trunci"(%7) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %9 = "tt.make_tensor_ptr"(%arg0, %4, %3, %3, %2, %8, %0) <{order = array<i32: 1, 0>}> : (!tt.ptr<bf16>, i64, i64, i64, i64, i32, i32) -> !tt.ptr<tensor<512x64xbf16>>
    %10 = "tt.make_tensor_ptr"(%arg1, %4, %3, %3, %2, %8, %0) <{order = array<i32: 1, 0>}> : (!tt.ptr<bf16>, i64, i64, i64, i64, i32, i32) -> !tt.ptr<tensor<512x64xbf16>>
    %11 = "tt.load"(%9) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<tensor<512x64xbf16>>) -> tensor<512x64xbf16>
    "tt.store"(%10, %11) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<tensor<512x64xbf16>>, tensor<512x64xbf16>) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

