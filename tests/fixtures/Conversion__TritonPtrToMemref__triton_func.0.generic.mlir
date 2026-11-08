"builtin.module"() ({
  "tt.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32) -> (), sym_name = "add_kernel_01234", sym_visibility = "public"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: i32):
    %0 = "arith.constant"() <{value = 1024 : i32}> : () -> i32
    %1 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<?xf32>) -> !tt.ptr<f32>
    %2 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<?xf32>) -> !tt.ptr<f32>
    %3 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !tt.ptr<f32>
    %4 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %5 = "arith.muli"(%4, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "tt.make_range"() <{end = 1024 : i32, start = 0 : i32}> : () -> tensor<1024xi32>
    %7 = "tt.splat"(%5) : (i32) -> tensor<1024xi32>
    %8 = "arith.addi"(%7, %6) <{overflowFlags = #arith.overflow<none>}> : (tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %9 = "tt.splat"(%arg3) : (i32) -> tensor<1024xi32>
    %10 = "arith.cmpi"(%8, %9) <{predicate = 2 : i64}> : (tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi1>
    %11 = "tt.splat"(%3) : (!tt.ptr<f32>) -> tensor<1024x!tt.ptr<f32>>
    %12 = "tt.addptr"(%11, %8) : (tensor<1024x!tt.ptr<f32>>, tensor<1024xi32>) -> tensor<1024x!tt.ptr<f32>>
    %13 = "tt.load"(%12, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<1024x!tt.ptr<f32>>, tensor<1024xi1>) -> tensor<1024xf32>
    %14 = "tt.splat"(%2) : (!tt.ptr<f32>) -> tensor<1024x!tt.ptr<f32>>
    %15 = "tt.addptr"(%14, %8) : (tensor<1024x!tt.ptr<f32>>, tensor<1024xi32>) -> tensor<1024x!tt.ptr<f32>>
    %16 = "tt.load"(%15, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<1024x!tt.ptr<f32>>, tensor<1024xi1>) -> tensor<1024xf32>
    %17 = "arith.addf"(%13, %16) <{fastmath = #arith.fastmath<none>}> : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    %18 = "tt.splat"(%1) : (!tt.ptr<f32>) -> tensor<1024x!tt.ptr<f32>>
    %19 = "tt.addptr"(%18, %8) : (tensor<1024x!tt.ptr<f32>>, tensor<1024xi32>) -> tensor<1024x!tt.ptr<f32>>
    "tt.store"(%19, %17, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<1024x!tt.ptr<f32>>, tensor<1024xf32>, tensor<1024xi1>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

