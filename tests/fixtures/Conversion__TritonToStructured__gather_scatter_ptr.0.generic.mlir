"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i64, i64, i64, i64, i64, i64, i64) -> (), sym_name = "row_gather2", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i64, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 16 : index}> : () -> index
    %2 = "arith.constant"() <{value = dense<8> : tensor<16x1xi32>}> : () -> tensor<16x1xi32>
    %3 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %4 = "tt.get_program_id"() <{axis = 2 : i32}> : () -> i32
    %5 = "arith.muli"(%arg5, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "tt.make_range"() <{end = 16 : i32, start = 0 : i32}> : () -> tensor<16xi32>
    %7 = "tt.expand_dims"(%6) <{axis = 1 : i32}> : (tensor<16xi32>) -> tensor<16x1xi32>
    %8 = "arith.remsi"(%7, %2) : (tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
    %9 = "arith.muli"(%arg3, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %10 = "arith.divsi"(%7, %2) : (tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
    %11 = "arith.extsi"(%arg2) : (i32) -> i64
    %12 = "arith.muli"(%11, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %13 = "arith.index_cast"(%12) : (i64) -> index
    %14 = "tt.splat"(%arg4) : (i32) -> tensor<16x1xi32>
    %15 = "arith.addi"(%10, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
    %16 = "arith.index_cast"(%arg6) : (i64) -> index
    %17 = "tt.splat"(%9) : (i32) -> tensor<16x1xi32>
    %18 = "arith.addi"(%8, %17) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
    %19 = "arith.index_cast"(%arg8) : (i64) -> index
    %20 = "arith.index_cast"(%16) : (index) -> i32
    %21 = "tt.splat"(%20) : (i32) -> tensor<16x1xi32>
    %22 = "arith.muli"(%15, %21) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
    %23 = "arith.index_cast"(%19) : (index) -> i32
    %24 = "tt.splat"(%23) : (i32) -> tensor<16x1xi32>
    %25 = "arith.muli"(%18, %24) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
    %26 = "arith.addi"(%22, %25) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
    %27 = "arith.index_cast"(%13) : (index) -> i32
    %28 = "tt.splat"(%27) : (i32) -> tensor<16x1xi32>
    %29 = "arith.addi"(%28, %26) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
    %30 = "tensor.collapse_shape"(%29) <{reassociation = [[0, 1]]}> : (tensor<16x1xi32>) -> tensor<16xi32>
    %31 = "tts.make_gather_scatter_tptr"(%arg0, %30) <{gather_scatter_dim = 0 : i32, operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, sizes = array<i64: 16, 16>, static_offsets = array<i64: 0, 0>, static_strides = array<i64: 1, 1>}> : (!tt.ptr<f32>, tensor<16xi32>) -> !tt.ptr<tensor<16x16xf32>>
    %32 = "arith.index_cast"(%5) : (i32) -> index
    %33 = "arith.minsi"(%32, %1) : (index, index) -> index
    %34 = "arith.maxsi"(%33, %0) : (index, index) -> index
    %35 = "arith.minsi"(%34, %1) : (index, index) -> index
    %36 = "tts.load"(%31, %35) <{operandSegmentSizes = array<i32: 1, 1, 0>, static_mask_dims = array<i64: -9223372036854775808, 8>}> : (!tt.ptr<tensor<16x16xf32>>, index) -> tensor<16x16xf32>
    %37 = "arith.muli"(%11, %arg10) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %38 = "arith.extsi"(%4) : (i32) -> i64
    %39 = "arith.muli"(%38, %arg12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %40 = "arith.addi"(%37, %39) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %41 = "arith.index_cast"(%40) : (i64) -> index
    %42 = "arith.index_cast"(%arg9) : (i64) -> index
    %43 = "arith.index_cast"(%arg11) : (i64) -> index
    %44 = "arith.index_cast"(%42) : (index) -> i32
    %45 = "tt.splat"(%44) : (i32) -> tensor<16x1xi32>
    %46 = "arith.muli"(%15, %45) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
    %47 = "arith.index_cast"(%43) : (index) -> i32
    %48 = "tt.splat"(%47) : (i32) -> tensor<16x1xi32>
    %49 = "arith.muli"(%18, %48) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
    %50 = "arith.addi"(%46, %49) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
    %51 = "arith.index_cast"(%41) : (index) -> i32
    %52 = "tt.splat"(%51) : (i32) -> tensor<16x1xi32>
    %53 = "arith.addi"(%52, %50) <{overflowFlags = #arith.overflow<none>}> : (tensor<16x1xi32>, tensor<16x1xi32>) -> tensor<16x1xi32>
    %54 = "tensor.collapse_shape"(%53) <{reassociation = [[0, 1]]}> : (tensor<16x1xi32>) -> tensor<16xi32>
    %55 = "tts.make_gather_scatter_tptr"(%arg1, %54) <{gather_scatter_dim = 0 : i32, operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, sizes = array<i64: 16, 16>, static_offsets = array<i64: 0, 0>, static_strides = array<i64: 1, 1>}> : (!tt.ptr<f32>, tensor<16xi32>) -> !tt.ptr<tensor<16x16xf32>>
    "tts.store"(%55, %36, %35) <{static_mask_dims = array<i64: -9223372036854775808, 8>}> : (!tt.ptr<tensor<16x16xf32>>, tensor<16x16xf32>, index) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

