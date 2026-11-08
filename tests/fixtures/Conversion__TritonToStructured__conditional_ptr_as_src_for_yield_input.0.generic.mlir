"builtin.module"() ({
  "tt.func"() <{arg_attrs = [{tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}], function_type = (!tt.ptr<i64>, !tt.ptr<i64>, !tt.ptr<i64>, i32, i32, i32, i32) -> (), sym_name = "gather_kernel", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<i64>, %arg1: !tt.ptr<i64>, %arg2: !tt.ptr<i64>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 512 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %4 = "tt.make_range"() <{end = 512 : i32, start = 0 : i32}> : () -> tensor<512xi32>
    %5 = "arith.muli"(%3, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "arith.index_cast"(%5) : (i32) -> index
    %7 = "arith.index_cast"(%5) : (i32) -> index
    %8 = "tts.make_tptr"(%arg1, %7) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 512>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<i64>, index) -> tensor<512x!tt.ptr<i64>>
    %9 = "tt.splat"(%arg3) : (i32) -> tensor<512xi32>
    %10 = "arith.cmpi"(%4, %9) <{predicate = 2 : i64}> : (tensor<512xi32>, tensor<512xi32>) -> tensor<512xi1>
    %11 = "arith.index_cast"(%arg3) : (i32) -> index
    %12 = "arith.minsi"(%11, %1) : (index, index) -> index
    %13 = "arith.maxsi"(%12, %0) : (index, index) -> index
    %14 = "tts.load"(%8, %13) <{operandSegmentSizes = array<i32: 1, 1, 0>, static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<512x!tt.ptr<i64>>, index) -> tensor<512xi64>
    %15 = "arith.cmpi"(%arg4, %2) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %16 = "scf.if"(%15) ({
      %26 = "arith.extsi"(%arg5) : (i32) -> i64
      %27 = "tt.splat"(%26) : (i64) -> tensor<512xi64>
      %28 = "arith.muli"(%14, %27) <{overflowFlags = #arith.overflow<none>}> : (tensor<512xi64>, tensor<512xi64>) -> tensor<512xi64>
      %29 = "tt.splat"(%arg0) : (!tt.ptr<i64>) -> tensor<512x!tt.ptr<i64>>
      %30 = "tt.addptr"(%29, %28) : (tensor<512x!tt.ptr<i64>>, tensor<512xi64>) -> tensor<512x!tt.ptr<i64>>
      %31 = "tt.addptr"(%30, %4) : (tensor<512x!tt.ptr<i64>>, tensor<512xi32>) -> tensor<512x!tt.ptr<i64>>
      "scf.yield"(%31) : (tensor<512x!tt.ptr<i64>>) -> ()
    }, {
      %22 = "arith.muli"(%3, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %23 = "tt.addptr"(%arg0, %22) : (!tt.ptr<i64>, i32) -> !tt.ptr<i64>
      %24 = "tt.splat"(%23) : (!tt.ptr<i64>) -> tensor<512x!tt.ptr<i64>>
      %25 = "tt.addptr"(%24, %14) : (tensor<512x!tt.ptr<i64>>, tensor<512xi64>) -> tensor<512x!tt.ptr<i64>>
      "scf.yield"(%25) : (tensor<512x!tt.ptr<i64>>) -> ()
    }) : (i1) -> tensor<512x!tt.ptr<i64>>
    %17 = "tt.load"(%16, %10) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (tensor<512x!tt.ptr<i64>>, tensor<512xi1>) -> tensor<512xi64>
    %18 = "tts.make_tptr"(%arg2, %6) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, order = array<i32>, sizes = array<i64: 512>, static_offsets = array<i64: -9223372036854775808>, static_shape = array<i64: 0>, static_strides = array<i64: 1>}> : (!tt.ptr<i64>, index) -> tensor<512x!tt.ptr<i64>>
    %19 = "arith.index_cast"(%arg3) : (i32) -> index
    %20 = "arith.minsi"(%19, %1) : (index, index) -> index
    %21 = "arith.maxsi"(%20, %0) : (index, index) -> index
    "tts.store"(%18, %17, %21) <{static_mask_dims = array<i64: -9223372036854775808>}> : (tensor<512x!tt.ptr<i64>>, tensor<512xi64>, index) -> ()
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

