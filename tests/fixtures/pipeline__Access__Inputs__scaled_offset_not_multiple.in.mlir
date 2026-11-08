// Triton 3.7.1 生成（去掉了文件位置）。反例：标量偏移的因子 96 不是 n 维行距 64 的整数倍，col0 = pid % programs_n：
//   b = load(B + col0·96 + arange(64)[None, :]·64 + arange(64)[:, None], mask=(col0 + arange(64) < N)[None, :])
module {
  tt.func public @not_multiple(%B: !tt.ptr<bf16> loc("B"), %C: !tt.ptr<bf16> loc("C"), %N: i32 loc("N"), %programs_n: i32 loc("programs_n")) attributes {noinline = false} {
    %c = arith.constant 4096 : i32
    %b = arith.constant dense<0.000000e+00> : tensor<64x64xbf16>
    %c_0 = arith.constant dense<64> : tensor<64x1xi32>
    %b_ptrs = arith.constant dense<64> : tensor<1x64xi64>
    %b_ptrs_1 = arith.constant 96 : i64
    %pid = tt.get_program_id x : i32
    %col0 = arith.remsi %pid, %programs_n : i32
    %col0_2 = arith.extsi %col0 : i32 to i64
    %rn = tt.make_range {end = 64 : i32, start = 0 : i32} : tensor<64xi32>
    %rn_3 = arith.extsi %rn : tensor<64xi32> to tensor<64xi64>
    %rn_4 = tt.splat %col0_2 : i64 -> tensor<64xi64>
    %rn_5 = arith.addi %rn_4, %rn_3 : tensor<64xi64>
    %col_ok = arith.extsi %N : i32 to i64
    %col_ok_6 = tt.splat %col_ok : i64 -> tensor<64xi64>
    %col_ok_7 = arith.cmpi slt, %rn_5, %col_ok_6 : tensor<64xi64>
    %col_ok_8 = tt.expand_dims %col_ok_7 {axis = 0 : i32} : tensor<64xi1> -> tensor<1x64xi1>
    %b_ptrs_9 = arith.muli %col0_2, %b_ptrs_1 : i64
    %b_ptrs_10 = tt.addptr %B, %b_ptrs_9 : !tt.ptr<bf16>, i64
    %b_ptrs_11 = tt.expand_dims %rn_3 {axis = 0 : i32} : tensor<64xi64> -> tensor<1x64xi64>
    %b_ptrs_12 = arith.muli %b_ptrs_11, %b_ptrs : tensor<1x64xi64>
    %b_ptrs_13 = tt.expand_dims %rn_3 {axis = 1 : i32} : tensor<64xi64> -> tensor<64x1xi64>
    %b_ptrs_14 = tt.broadcast %b_ptrs_12 : tensor<1x64xi64> -> tensor<64x64xi64>
    %b_ptrs_15 = tt.broadcast %b_ptrs_13 : tensor<64x1xi64> -> tensor<64x64xi64>
    %b_ptrs_16 = arith.addi %b_ptrs_14, %b_ptrs_15 : tensor<64x64xi64>
    %b_ptrs_17 = tt.splat %b_ptrs_10 : !tt.ptr<bf16> -> tensor<64x64x!tt.ptr<bf16>>
    %b_ptrs_18 = tt.addptr %b_ptrs_17, %b_ptrs_16 : tensor<64x64x!tt.ptr<bf16>>, tensor<64x64xi64>
    %b_19 = tt.broadcast %col_ok_8 : tensor<1x64xi1> -> tensor<64x64xi1>
    %b_20 = tt.load %b_ptrs_18, %b_19, %b : tensor<64x64x!tt.ptr<bf16>>
    %c_21 = arith.muli %pid, %c : i32
    %c_22 = tt.addptr %C, %c_21 : !tt.ptr<bf16>, i32
    %c_23 = tt.expand_dims %rn {axis = 1 : i32} : tensor<64xi32> -> tensor<64x1xi32>
    %c_24 = arith.muli %c_23, %c_0 : tensor<64x1xi32>
    %c_25 = tt.splat %c_22 : !tt.ptr<bf16> -> tensor<64x1x!tt.ptr<bf16>>
    %c_26 = tt.addptr %c_25, %c_24 : tensor<64x1x!tt.ptr<bf16>>, tensor<64x1xi32>
    %c_27 = tt.expand_dims %rn {axis = 0 : i32} : tensor<64xi32> -> tensor<1x64xi32>
    %c_28 = tt.broadcast %c_26 : tensor<64x1x!tt.ptr<bf16>> -> tensor<64x64x!tt.ptr<bf16>>
    %c_29 = tt.broadcast %c_27 : tensor<1x64xi32> -> tensor<64x64xi32>
    %c_30 = tt.addptr %c_28, %c_29 : tensor<64x64x!tt.ptr<bf16>>, tensor<64x64xi32>
    tt.store %c_30, %b_20 : tensor<64x64x!tt.ptr<bf16>>
    tt.return
  }
}
