"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<bf16>, !tt.ptr<bf16>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: !tt.ptr<bf16>, %arg1: !tt.ptr<bf16>):
    %0 = "arith.constant"() <{value = 6 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<6> : tensor<256x128xi32>}> : () -> tensor<256x128xi32>
    %2 = "tt.make_range"() <{end = 768 : i32, start = 512 : i32}> : () -> tensor<256xi32>
    %3 = "tt.expand_dims"(%2) <{axis = 1 : i32}> : (tensor<256xi32>) -> tensor<256x1xi32>
    %4 = "tt.broadcast"(%3) : (tensor<256x1xi32>) -> tensor<256x128xi32>
    %5 = "tt.make_range"() <{end = 1152 : i32, start = 1024 : i32}> : () -> tensor<128xi32>
    %6 = "tt.expand_dims"(%5) <{axis = 0 : i32}> : (tensor<128xi32>) -> tensor<1x128xi32>
    %7 = "tt.broadcast"(%6) : (tensor<1x128xi32>) -> tensor<256x128xi32>
    %8 = "arith.muli"(%7, %1) <{overflowFlags = #arith.overflow<none>}> : (tensor<256x128xi32>, tensor<256x128xi32>) -> tensor<256x128xi32>
    %9 = "arith.addi"(%4, %8) <{overflowFlags = #arith.overflow<none>}> : (tensor<256x128xi32>, tensor<256x128xi32>) -> tensor<256x128xi32>
    %10 = "tts.make_tptr"(%arg1, %0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, order = array<i32>, sizes = array<i64: 256, 128>, static_offsets = array<i64: 512, 6144>, static_shape = array<i64: 0, 0>, static_strides = array<i64: 1, -9223372036854775808>}> : (!tt.ptr<bf16>, index) -> tensor<256x128x!tt.ptr<bf16>>
    %11 = "tts.load"(%10) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<256x128x!tt.ptr<bf16>>) -> tensor<256x128xbf16>
    "tts.store"(%10, %11) <{static_mask_dims = array<i64>}> : (tensor<256x128x!tt.ptr<bf16>>, tensor<256x128xbf16>) -> ()
    %12 = "arith.sitofp"(%9) : (tensor<256x128xi32>) -> tensor<256x128xbf16>
    "tts.store"(%10, %12) <{static_mask_dims = array<i64>}> : (tensor<256x128x!tt.ptr<bf16>>, tensor<256x128xbf16>) -> ()
    "tt.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

