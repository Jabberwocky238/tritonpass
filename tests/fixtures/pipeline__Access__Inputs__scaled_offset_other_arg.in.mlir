// Triton 3.7.1 生成（去掉了文件位置）。反例：标量偏移乘的是另一个运行期实参 other，不是 n 维的行距 stride_n，col0 = pid·64：
//   b = load(B + col0·other + arange(64)[None, :]·stride_n + arange(64)[:, None], mask=(col0 + arange(64) < N)[None, :])
module {
  tt.func public @other_arg(%B: !tt.ptr<bf16> loc("B"), %C: !tt.ptr<bf16> loc("C"), %N: i32 loc("N"), %stride_n: i32 loc("stride_n"), %other: i32 loc("other")) attributes {noinline = false} {
    %c = arith.constant 4096 : i32
    %b = arith.constant dense<0.000000e+00> : tensor<64x64xbf16>
    %c_0 = arith.constant dense<64> : tensor<64x1xi32>
    %c64_i32 = arith.constant 64 : i32
    %pid = tt.get_program_id x : i32
    %col0 = arith.muli %pid, %c64_i32 : i32
    %rn = tt.make_range {end = 64 : i32, start = 0 : i32} : tensor<64xi32>
    %rn_1 = tt.splat %col0 : i32 -> tensor<64xi32>
    %rn_2 = arith.addi %rn_1, %rn : tensor<64xi32>
    %col_ok = tt.splat %N : i32 -> tensor<64xi32>
    %col_ok_3 = arith.cmpi slt, %rn_2, %col_ok : tensor<64xi32>
    %col_ok_4 = tt.expand_dims %col_ok_3 {axis = 0 : i32} : tensor<64xi1> -> tensor<1x64xi1>
    %b_ptrs = arith.muli %col0, %other : i32
    %b_ptrs_5 = tt.addptr %B, %b_ptrs : !tt.ptr<bf16>, i32
    %b_ptrs_6 = tt.expand_dims %rn {axis = 0 : i32} : tensor<64xi32> -> tensor<1x64xi32>
    %b_ptrs_7 = tt.splat %stride_n : i32 -> tensor<1x64xi32>
    %b_ptrs_8 = arith.muli %b_ptrs_6, %b_ptrs_7 : tensor<1x64xi32>
    %b_ptrs_9 = tt.expand_dims %rn {axis = 1 : i32} : tensor<64xi32> -> tensor<64x1xi32>
    %b_ptrs_10 = tt.broadcast %b_ptrs_8 : tensor<1x64xi32> -> tensor<64x64xi32>
    %b_ptrs_11 = tt.broadcast %b_ptrs_9 : tensor<64x1xi32> -> tensor<64x64xi32>
    %b_ptrs_12 = arith.addi %b_ptrs_10, %b_ptrs_11 : tensor<64x64xi32>
    %b_ptrs_13 = tt.splat %b_ptrs_5 : !tt.ptr<bf16> -> tensor<64x64x!tt.ptr<bf16>>
    %b_ptrs_14 = tt.addptr %b_ptrs_13, %b_ptrs_12 : tensor<64x64x!tt.ptr<bf16>>, tensor<64x64xi32>
    %b_15 = tt.broadcast %col_ok_4 : tensor<1x64xi1> -> tensor<64x64xi1>
    %b_16 = tt.load %b_ptrs_14, %b_15, %b : tensor<64x64x!tt.ptr<bf16>>
    %c_17 = arith.muli %pid, %c : i32
    %c_18 = tt.addptr %C, %c_17 : !tt.ptr<bf16>, i32
    %c_19 = arith.muli %b_ptrs_9, %c_0 : tensor<64x1xi32>
    %c_20 = tt.splat %c_18 : !tt.ptr<bf16> -> tensor<64x1x!tt.ptr<bf16>>
    %c_21 = tt.addptr %c_20, %c_19 : tensor<64x1x!tt.ptr<bf16>>, tensor<64x1xi32>
    %c_22 = tt.broadcast %c_21 : tensor<64x1x!tt.ptr<bf16>> -> tensor<64x64x!tt.ptr<bf16>>
    %c_23 = tt.broadcast %b_ptrs_6 : tensor<1x64xi32> -> tensor<64x64xi32>
    %c_24 = tt.addptr %c_22, %c_23 : tensor<64x64x!tt.ptr<bf16>>, tensor<64x64xi32>
    tt.store %c_24, %b_16 : tensor<64x64x!tt.ptr<bf16>>
    tt.return
  }
}
