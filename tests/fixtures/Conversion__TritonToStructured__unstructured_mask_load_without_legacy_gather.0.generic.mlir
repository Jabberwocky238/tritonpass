"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>) -> tensor<4x8xf32>, sym_name = "holed_row_mask_load", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>):
    %0 = "arith.constant"() <{value = dense<0xFF800000> : tensor<4x8xf32>}> : () -> tensor<4x8xf32>
    %1 = "arith.constant"() <{value = dense<1> : tensor<4xi32>}> : () -> tensor<4xi32>
    %2 = "arith.constant"() <{value = dense<3> : tensor<4xi32>}> : () -> tensor<4xi32>
    %3 = "arith.constant"() <{value = dense<8> : tensor<4x1xi32>}> : () -> tensor<4x1xi32>
    %4 = "tt.make_range"() <{end = 4 : i32, start = 0 : i32}> : () -> tensor<4xi32>
    %5 = "tt.make_range"() <{end = 8 : i32, start = 0 : i32}> : () -> tensor<8xi32>
    %6 = "arith.cmpi"(%4, %1) <{predicate = 1 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %7 = "arith.cmpi"(%4, %2) <{predicate = 2 : i64}> : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi1>
    %8 = "arith.andi"(%6, %7) : (tensor<4xi1>, tensor<4xi1>) -> tensor<4xi1>
    %9 = "tt.expand_dims"(%8) <{axis = 1 : i32}> : (tensor<4xi1>) -> tensor<4x1xi1>
    %10 = "tt.broadcast"(%9) : (tensor<4x1xi1>) -> tensor<4x8xi1>
    %11 = "tt.expand_dims"(%4) <{axis = 1 : i32}> : (tensor<4xi32>) -> tensor<4x1xi32>
    %12 = "arith.muli"(%11, %3) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x1xi32>, tensor<4x1xi32>) -> tensor<4x1xi32>
    %13 = "tt.broadcast"(%12) : (tensor<4x1xi32>) -> tensor<4x8xi32>
    %14 = "tt.expand_dims"(%5) <{axis = 0 : i32}> : (tensor<8xi32>) -> tensor<1x8xi32>
    %15 = "tt.broadcast"(%14) : (tensor<1x8xi32>) -> tensor<4x8xi32>
    %16 = "arith.addi"(%13, %15) <{overflowFlags = #arith.overflow<none>}> : (tensor<4x8xi32>, tensor<4x8xi32>) -> tensor<4x8xi32>
    %17 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<4x8x!tt.ptr<f32>>
    %18 = "tt.addptr"(%17, %16) : (tensor<4x8x!tt.ptr<f32>>, tensor<4x8xi32>) -> tensor<4x8x!tt.ptr<f32>>
    %19 = "tt.load"(%18, %10, %0) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<4x8x!tt.ptr<f32>>, tensor<4x8xi1>, tensor<4x8xf32>) -> tensor<4x8xf32>
    "tt.return"(%19) : (tensor<4x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

