"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "wrap_side_by_side_masked_loop_01234567", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<-9.900000e+01> : tensor<4x4xf32>}> : () -> tensor<4x4xf32>
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = dense<2> : tensor<4x1xi32>}> : () -> tensor<4x1xi32>
    %6 = "arith.constant"() <{value = dense<6> : tensor<4xi32>}> : () -> tensor<4xi32>
    %7 = "arith.constant"() <{value = dense<2> : tensor<4xi32>}> : () -> tensor<4xi32>
    %8 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %9 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %10 = "arith.addi"(%9, %7) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %11 = "tt.splat"(%arg3) : (i32) -> tensor<4xi32>
    %12 = "arith.remsi"(%9, %11) : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %13 = "arith.addi"(%12, %6) <{overflowFlags = #arith.overflow<none>}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %14 = "tt.expand_dims"(%10) <{axis = 1 : i32}> : (tensor<4xi32>) -> tensor<4x1xi32>
    %15 = "tt.splat"(%arg4) : (i32) -> tensor<4x1xi32>
    %16 = "arith.muli"(%14, %15) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x1xi32>, tensor<4x1xi32>) -> tensor<4x1xi32>
    %17 = "tt.expand_dims"(%13) <{axis = 0 : i32}> : (tensor<4xi32>) -> tensor<1x4xi32>
    %18 = "tt.splat"(%arg5) : (i32) -> tensor<1x4xi32>
    %19 = "arith.muli"(%17, %18) <{overflowFlags = #arith.overflow<none>}> : (tensor<1x4xi32>, tensor<1x4xi32>) -> tensor<1x4xi32>
    %20 = "tt.broadcast"(%16) : (tensor<4x1xi32>) -> tensor<4x4xi32>
    %21 = "tt.broadcast"(%19) : (tensor<1x4xi32>) -> tensor<4x4xi32>
    %22 = "arith.addi"(%20, %21) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x4xi32>, tensor<4x4xi32>) -> tensor<4x4xi32>
    %23 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<4x4x!tt.ptr<f32>>
    %24 = "tt.addptr"(%23, %22) : (tensor<4x4x!tt.ptr<f32>>, tensor<4x4xi32>) -> tensor<4x4x!tt.ptr<f32>>
    %25 = "tt.expand_dims"(%9) <{axis = 1 : i32}> : (tensor<4xi32>) -> tensor<4x1xi32>
    %26 = "arith.index_cast"(%arg6) : (i32) -> index
    %27 = "arith.index_cast"(%arg7) : (i32) -> index
    %28 = "arith.cmpi"(%25, %5) <{predicate = 2 : i64}> : (tensor<4x1xi32>, tensor<4x1xi32>) -> tensor<4x1xi1>
    %29 = "tt.broadcast"(%28) : (tensor<4x1xi1>) -> tensor<4x4xi1>
    %30 = "arith.muli"(%arg4, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %31 = "tt.splat"(%30) : (i32) -> tensor<4x4xi32>
    %32 = "arith.muli"(%arg5, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %33 = "arith.index_cast"(%32) : (i32) -> index
    %34:2 = "scf.for"(%3, %4, %2, %24, %0) ({
    ^bb0(%arg8: i32, %arg9: tensor<4x4x!tt.ptr<f32>>, %arg10: index):
      %35 = "tts.make_tptr"(%arg1, %26, %27, %arg10, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 4, 4>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<4x4x!tt.ptr<f32>>
      %36 = "tt.load"(%arg9, %29, %1) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<4x4x!tt.ptr<f32>>, tensor<4x4xi1>, tensor<4x4xf32>) -> tensor<4x4xf32>
      "tts.store"(%35, %36) <{static_mask_dims = array<i64>}> : (tensor<4x4x!tt.ptr<f32>>, tensor<4x4xf32>) -> ()
      %37 = "tt.addptr"(%arg9, %31) : (tensor<4x4x!tt.ptr<f32>>, tensor<4x4xi32>) -> tensor<4x4x!tt.ptr<f32>>
      %38 = "arith.addi"(%arg10, %33) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%37, %38) : (tensor<4x4x!tt.ptr<f32>>, index) -> ()
    }) : (i32, i32, i32, tensor<4x4x!tt.ptr<f32>>, index) -> (tensor<4x4x!tt.ptr<f32>>, index)
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

