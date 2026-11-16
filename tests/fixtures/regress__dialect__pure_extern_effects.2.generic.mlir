"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<i32>, f32, i32, i32) -> (), sym_name = "pure_calls", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<i32>, %arg2: f32, %arg3: i32, %arg4: i32):
    %0 = "tt.extern_elementwise"(%arg2) <{libname = "libdevice", libpath = "", pure = true, symbol = "__nv_expf"}> : (f32) -> f32
    %1 = "tt.extern_elementwise"(%arg2) <{libname = "libdevice", libpath = "", pure = true, symbol = "__nv_expf"}> : (f32) -> f32
    %2 = "tt.extern_elementwise"(%arg2) <{libname = "libdevice", libpath = "", pure = true, symbol = "__nv_logf"}> : (f32) -> f32
    %3 = "tt.extern_elementwise"(%arg2) <{libname = "libdevice", libpath = "", pure = false, symbol = "__nv_impure"}> : (f32) -> f32
    %4 = "tt.elementwise_inline_asm"(%arg3) <{asm_string = "mov.b32 $0, $1;", constraints = "=r,r", packed_element = 1 : i32, pure = true}> : (i32) -> i32
    %5 = "tt.elementwise_inline_asm"(%arg3) <{asm_string = "mov.b32 $0, $1;", constraints = "=r,r", packed_element = 1 : i32, pure = true}> : (i32) -> i32
    %6 = "tt.elementwise_inline_asm"(%arg3) <{asm_string = "not.b32 $0, $1;", constraints = "=r,r", packed_element = 1 : i32, pure = true}> : (i32) -> i32
    %7 = "tt.elementwise_inline_asm"(%arg3) <{asm_string = "st.global.b32 [$1], $1;", constraints = "=r,r", packed_element = 1 : i32, pure = false}> : (i32) -> i32
    %8 = "arith.addf"(%0, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "tt.store"(%arg0, %8) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
    %9 = "arith.addi"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "tt.store"(%arg1, %9) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<i32>, i32) -> ()
    %10 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %11 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %12 = "tt.extern_elementwise"(%arg2) <{libname = "libdevice", libpath = "", pure = true, symbol = "__nv_sinf"}> : (f32) -> f32
    %13 = "tt.elementwise_inline_asm"(%arg3) <{asm_string = "mov.b32 $0, $1;", constraints = "=r,r", packed_element = 1 : i32, pure = true}> : (i32) -> i32
    %14 = "arith.sitofp"(%13) : (i32) -> f32
    %15 = "scf.for"(%10, %arg4, %11, %arg2) ({
    ^bb0(%arg5: i32, %arg6: f32):
      %16 = "tt.extern_elementwise"(%arg2) <{libname = "libdevice", libpath = "", pure = false, symbol = "__nv_impure"}> : (f32) -> f32
      %17 = "arith.addf"(%arg6, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %18 = "arith.addf"(%17, %16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %19 = "arith.addf"(%18, %14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%19) : (f32) -> ()
    }) : (i32, i32, i32, f32) -> f32
    "tt.store"(%arg0, %15) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<f32>, f32) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

