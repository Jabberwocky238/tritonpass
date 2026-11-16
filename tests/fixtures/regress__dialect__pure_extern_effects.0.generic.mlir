"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<i32>, f32, i32, i32) -> (), sym_name = "pure_calls", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<i32>, %arg2: f32, %arg3: i32, %arg4: i32):
    %0 = "tt.extern_elementwise"(%arg2) <{libname = "libdevice", libpath = "", pure = true, symbol = "__nv_expf"}> : (f32) -> f32
    %1 = "tt.extern_elementwise"(%arg2) <{libname = "libdevice", libpath = "", pure = false, symbol = "__nv_impure"}> : (f32) -> f32
    %2 = "tt.elementwise_inline_asm"(%arg3) <{asm_string = "mov.b32 $0, $1;", constraints = "=r,r", packed_element = 1 : i32, pure = true}> : (i32) -> i32
    %3 = "tt.elementwise_inline_asm"(%arg3) <{asm_string = "st.global.b32 [$1], $1;", constraints = "=r,r", packed_element = 1 : i32, pure = false}> : (i32) -> i32
    %4 = "arith.addf"(%0, %0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "tt.store"(%arg0, %4) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
    %5 = "arith.addi"(%2, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "tt.store"(%arg1, %5) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
    %6 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %8 = "scf.for"(%6, %arg4, %7, %arg2) ({
    ^bb0(%arg5: i32, %arg6: f32):
      %9 = "tt.extern_elementwise"(%arg2) <{libname = "libdevice", libpath = "", pure = true, symbol = "__nv_sinf"}> : (f32) -> f32
      %10 = "tt.extern_elementwise"(%arg2) <{libname = "libdevice", libpath = "", pure = false, symbol = "__nv_impure"}> : (f32) -> f32
      %11 = "arith.sitofp"(%2) : (i32) -> f32
      %12 = "arith.addf"(%arg6, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %13 = "arith.addf"(%12, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %14 = "arith.addf"(%13, %11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%14) : (f32) -> ()
    }) : (i32, i32, i32, f32) -> f32
    "tt.store"(%arg0, %8) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

