"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, !tt.ptr<f32>, i32) -> (), sym_name = "add_kernel_01234", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: !tt.ptr<f32>, %arg3: i32):
    %0 = "arith.constant"() <{value = 1024 : i32}> : () -> i32
    %1 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %2 = "arith.muli"(%1, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %3 = "tt.make_range"() <{end = 1024 : i32, start = 0 : i32}> : () -> tensor<1024xi32>
    %4 = "tt.splat"(%2) : (i32) -> tensor<1024xi32>
    %5 = "arith.addi"(%4, %3) <{overflowFlags = #arith.overflow<none>}> : (tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %6 = "tt.splat"(%arg3) : (i32) -> tensor<1024xi32>
    %7 = "arith.cmpi"(%5, %6) <{predicate = 2 : i64}> : (tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi1>
    %8 = "tts.gather"(%arg0, %5, %7) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (!tt.ptr<f32>, tensor<1024xi32>, tensor<1024xi1>) -> tensor<1024xf32>
    %9 = "tts.gather"(%arg1, %5, %7) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (!tt.ptr<f32>, tensor<1024xi32>, tensor<1024xi1>) -> tensor<1024xf32>
    %10 = "arith.addf"(%8, %9) <{fastmath = #arith.fastmath<none>}> : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    "tts.scatter"(%arg2, %5, %10, %7) : (!tt.ptr<f32>, tensor<1024xi32>, tensor<1024xf32>, tensor<1024xi1>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

