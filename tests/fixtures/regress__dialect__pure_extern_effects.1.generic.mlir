"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<i32>, f32, i32, i32) -> (), sym_name = "pure_calls", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<i32>, %arg2: f32, %arg3: i32, %arg4: i32):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "tt.extern_elementwise"(%arg2) <{libname = "libdevice", libpath = "", pure = true, symbol = "__nv_expf"}> : (f32) -> f32
    %3 = "tt.extern_elementwise"(%arg2) <{libname = "libdevice", libpath = "", pure = true, symbol = "__nv_expf"}> : (f32) -> f32
    %4 = "tt.extern_elementwise"(%arg2) <{libname = "libdevice", libpath = "", pure = false, symbol = "__nv_impure"}> : (f32) -> f32
    %5 = "tt.elementwise_inline_asm"(%arg3) <{asm_string = "mov.b32 $0, $1;", constraints = "=r,r", packed_element = 1 : i32, pure = true}> : (i32) -> i32
    %6 = "tt.elementwise_inline_asm"(%arg3) <{asm_string = "mov.b32 $0, $1;", constraints = "=r,r", packed_element = 1 : i32, pure = true}> : (i32) -> i32
    %7 = "tt.elementwise_inline_asm"(%arg3) <{asm_string = "st.global.b32 [$1], $1;", constraints = "=r,r", packed_element = 1 : i32, pure = false}> : (i32) -> i32
    %8 = "arith.addf"(%2, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "tt.store"(%arg0, %8) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
    %9 = "arith.addi"(%5, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "tt.store"(%arg1, %9) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
    %10 = "scf.for"(%1, %arg4, %0, %arg2) ({
    ^bb0(%arg5: i32, %arg6: f32):
      %11 = "tt.extern_elementwise"(%arg2) <{libname = "libdevice", libpath = "", pure = true, symbol = "__nv_sinf"}> : (f32) -> f32
      %12 = "tt.extern_elementwise"(%arg2) <{libname = "libdevice", libpath = "", pure = false, symbol = "__nv_impure"}> : (f32) -> f32
      %13 = "tt.elementwise_inline_asm"(%arg3) <{asm_string = "mov.b32 $0, $1;", constraints = "=r,r", packed_element = 1 : i32, pure = true}> : (i32) -> i32
      %14 = "arith.sitofp"(%13) : (i32) -> f32
      %15 = "arith.addf"(%arg6, %11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %16 = "arith.addf"(%15, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %17 = "arith.addf"(%16, %14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%17) : (f32) -> ()
    }) : (i32, i32, i32, f32) -> f32
    "tt.store"(%arg0, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

