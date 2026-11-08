#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>, !tt.ptr<bf16>, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "matmul_kernel_with_block_pointers_01234567891011"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>, %arg2: !tt.ptr<bf16>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32):
    %0 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 64 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %4 = "tensor.empty"() : () -> tensor<128x64xbf16>
    %5 = "linalg.fill"(%3, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: bf16, %arg25: bf16):
      "linalg.yield"(%arg24) : (bf16) -> ()
    }) : (bf16, tensor<128x64xbf16>) -> tensor<128x64xbf16>
    %6 = "arith.extsi"(%arg3) : (i32) -> i64
    %7 = "arith.extsi"(%arg5) : (i32) -> i64
    %8 = "arith.extsi"(%arg6) : (i32) -> i64
    %9 = "arith.extsi"(%arg7) : (i32) -> i64
    %10 = "tt.make_tensor_ptr"(%arg0, %6, %7, %8, %9, %arg12, %1) <{order = array<i32: 1, 0>}> : (!tt.ptr<bf16>, i64, i64, i64, i64, i32, i32) -> !tt.ptr<tensor<128x64xbf16>>
    %11 = "tt.advance"(%10, %1, %2) : (!tt.ptr<tensor<128x64xbf16>>, i32, i32) -> !tt.ptr<tensor<128x64xbf16>>
    %12:3 = "scf.for"(%1, %arg5, %2, %5, %11, %10) ({
    ^bb0(%arg14: i32, %arg15: tensor<128x64xbf16>, %arg16: !tt.ptr<tensor<128x64xbf16>>, %arg17: !tt.ptr<tensor<128x64xbf16>>):
      %18 = "tt.load"(%arg16) <{boundaryCheck = array<i32: 0, 1>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<tensor<128x64xbf16>>) -> tensor<128x64xbf16>
      %19 = "tt.load"(%arg17) <{boundaryCheck = array<i32: 0, 1>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<tensor<128x64xbf16>>) -> tensor<128x64xbf16>
      %20 = "linalg.generic"(%18, %19, %18) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg21: bf16, %arg22: bf16, %arg23: bf16):
        %25 = "arith.addf"(%arg21, %arg22) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
        "linalg.yield"(%25) : (bf16) -> ()
      }) : (tensor<128x64xbf16>, tensor<128x64xbf16>, tensor<128x64xbf16>) -> tensor<128x64xbf16>
      %21 = "linalg.generic"(%arg15, %20, %arg15) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg18: bf16, %arg19: bf16, %arg20: bf16):
        %24 = "arith.addf"(%arg18, %arg19) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
        "linalg.yield"(%24) : (bf16) -> ()
      }) : (tensor<128x64xbf16>, tensor<128x64xbf16>, tensor<128x64xbf16>) -> tensor<128x64xbf16>
      %22 = "tt.advance"(%arg16, %1, %2) : (!tt.ptr<tensor<128x64xbf16>>, i32, i32) -> !tt.ptr<tensor<128x64xbf16>>
      %23 = "tt.advance"(%arg17, %2, %1) : (!tt.ptr<tensor<128x64xbf16>>, i32, i32) -> !tt.ptr<tensor<128x64xbf16>>
      "scf.yield"(%21, %22, %23) : (tensor<128x64xbf16>, !tt.ptr<tensor<128x64xbf16>>, !tt.ptr<tensor<128x64xbf16>>) -> ()
    }) : (i32, i32, i32, tensor<128x64xbf16>, !tt.ptr<tensor<128x64xbf16>>, !tt.ptr<tensor<128x64xbf16>>) -> (tensor<128x64xbf16>, !tt.ptr<tensor<128x64xbf16>>, !tt.ptr<tensor<128x64xbf16>>)
    %13 = "arith.extsi"(%arg10) : (i32) -> i64
    %14 = "arith.extsi"(%arg11) : (i32) -> i64
    %15 = "arith.extsi"(%arg4) : (i32) -> i64
    %16 = "arith.muli"(%arg13, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %17 = "tt.make_tensor_ptr"(%arg2, %6, %15, %13, %14, %arg12, %16) <{order = array<i32: 1, 0>}> : (!tt.ptr<bf16>, i64, i64, i64, i64, i32, i32) -> !tt.ptr<tensor<128x64xbf16>>
    "tt.store"(%17, %12#0) <{boundaryCheck = array<i32: 0, 1>, cache = 1 : i32, evict = 1 : i32}> : (!tt.ptr<tensor<128x64xbf16>>, tensor<128x64xbf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

