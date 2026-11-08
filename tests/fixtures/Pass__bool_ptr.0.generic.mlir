"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<i8>, !tt.ptr<f32>) -> (), sym_name = "where_like", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i8>, %arg1: !tt.ptr<f32>):
    %0 = "tt.make_range"() <{end = 32 : i32, start = 0 : i32}> : () -> tensor<32xi32>
    %1 = "arith.constant"() <{value = dense<0> : tensor<32xi8>}> : () -> tensor<32xi8>
    %2 = "tt.splat"(%arg0) : (!tt.ptr<i8>) -> tensor<32x!tt.ptr<i8>>
    %3 = "tt.addptr"(%2, %0) : (tensor<32x!tt.ptr<i8>>, tensor<32xi32>) -> tensor<32x!tt.ptr<i8>>
    %4 = "tt.load"(%3) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<32x!tt.ptr<i8>>) -> tensor<32xi8>
    %5 = "arith.cmpi"(%4, %1) <{predicate = 1 : i64}> : (tensor<32xi8>, tensor<32xi8>) -> tensor<32xi1>
    %6 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<32xf32>}> : () -> tensor<32xf32>
    %7 = "arith.constant"() <{value = dense<1.000000e+00> : tensor<32xf32>}> : () -> tensor<32xf32>
    %8 = "arith.select"(%5, %7, %6) : (tensor<32xi1>, tensor<32xf32>, tensor<32xf32>) -> tensor<32xf32>
    %9 = "tt.splat"(%arg1) : (!tt.ptr<f32>) -> tensor<32x!tt.ptr<f32>>
    %10 = "tt.addptr"(%9, %0) : (tensor<32x!tt.ptr<f32>>, tensor<32xi32>) -> tensor<32x!tt.ptr<f32>>
    "tt.store"(%10, %8) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<32x!tt.ptr<f32>>, tensor<32xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

