"builtin.module"() ({
  "func.func"() <{function_type = (f32, bf16, tensor<1024x!tt.ptr<f32>>, tensor<128x256x!tt.ptr<bf16>>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: f32, %arg1: bf16, %arg2: tensor<1024x!tt.ptr<f32>>, %arg3: tensor<128x256x!tt.ptr<bf16>>):
    %0 = "tensor.empty"() : () -> tensor<1024xf32>
    %1 = "linalg.fill"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %2 = "tensor.empty"() : () -> tensor<128x256xbf16>
    %3 = "linalg.fill"(%arg1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: bf16, %arg5: bf16):
      "linalg.yield"(%arg4) : (bf16) -> ()
    }) : (bf16, tensor<128x256xbf16>) -> tensor<128x256xbf16>
    "tt.store"(%arg2, %1) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<1024x!tt.ptr<f32>>, tensor<1024xf32>) -> ()
    "tt.store"(%arg3, %3) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<128x256x!tt.ptr<bf16>>, tensor<128x256xbf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

