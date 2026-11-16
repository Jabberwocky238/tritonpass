"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f16>, i64, i32, tensor<16xf32>, tensor<16xi32>, tensor<16x16xf16>) -> (), sym_name = "attr_dict_order", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f16>, %arg1: i64, %arg2: i32, %arg3: tensor<16xf32>, %arg4: tensor<16xi32>, %arg5: tensor<16x16xf16>):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %2 = "tt.make_tensor_ptr"(%arg0, %arg1, %1, %0) <{order = array<i32: 0>}> {zz = 1 : i32} : (!tt.ptr<f16>, i64, i64, i32) -> !tt.ptr<tensor<16xf16>>
    %3 = "tt.load"(%2) <{boundaryCheck = array<i32: 0>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> {zz = 2 : i32} : (!tt.ptr<tensor<16xf16>>) -> tensor<16xf16>
    "tt.store"(%2, %3) <{boundaryCheck = array<i32: 0>, cache = 1 : i32, evict = 1 : i32}> {zz = 3 : i32} : (!tt.ptr<tensor<16xf16>>, tensor<16xf16>) -> ()
    %4 = "tt.gather"(%arg3, %arg4) <{axis = 0 : i32, efficient_layout}> {bz = 4 : i32, zz = 4 : i32} : (tensor<16xf32>, tensor<16xi32>) -> tensor<16xf32>
    %5 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<16x16xf32>}> : () -> tensor<16x16xf32>
    %6 = "tt.dot"(%arg5, %arg5, %5) <{inputPrecision = 2 : i32, maxNumImpreciseAcc = 5 : i32}> {zz = 5 : i32} : (tensor<16x16xf16>, tensor<16x16xf16>, tensor<16x16xf32>) -> tensor<16x16xf32>
    %7 = "tt.make_tensor_descriptor"(%arg0, %arg2, %1) <{padding = 2 : i32}> {zz = 6 : i32} : (!tt.ptr<f16>, i32, i64) -> !tt.tensordesc<tensor<16xf16>>
    "tt.print"(%4, %6) <{hex = false, isSigned = array<i32: 0, 0>, prefix = "x"}> : (tensor<16xf32>, tensor<16x16xf32>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

