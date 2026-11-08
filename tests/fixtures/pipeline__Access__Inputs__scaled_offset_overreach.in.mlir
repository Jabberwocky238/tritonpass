// Triton 3.7.1 生成（去掉了文件位置）。反例：地址比掩码多走一列——掩码管的是 col0 + arange < N，读的却是第 col0 + 1 + arange 列：
//   b = load(B + (col0 + 1)·64 + arange(64)[None, :]·64 + arange(64)[:, None], mask=(col0 + arange(64) < N)[None, :])
// 每个 program 最后一个有效列之后还多读一列，范围必须把它算进去。
module {
  tt.func public @overreach(%B: !tt.ptr<bf16> loc("B"), %C: !tt.ptr<bf16> loc("C"), %N: i32 loc("N"), %programs_n: i32 loc("programs_n")) attributes {noinline = false} {
    %c = arith.constant 4096 : i32
    %b = arith.constant dense<0.000000e+00> : tensor<64x64xbf16>
    %c_0 = arith.constant dense<64> : tensor<64x1xi32>
    %b_ptrs = arith.constant dense<64> : tensor<1x64xi64>
    %b_ptrs_1 = arith.constant 1 : i64
    %c64_i64 = arith.constant 64 : i64
    %pid = tt.get_program_id x : i32
    %col0 = arith.remsi %pid, %programs_n : i32
    %col0_2 = arith.extsi %col0 : i32 to i64
    %col0_3 = arith.muli %col0_2, %c64_i64 : i64
    %rn = tt.make_range {end = 64 : i32, start = 0 : i32} : tensor<64xi32>
    %rn_4 = arith.extsi %rn : tensor<64xi32> to tensor<64xi64>
    %rn_5 = tt.splat %col0_3 : i64 -> tensor<64xi64>
    %rn_6 = arith.addi %rn_5, %rn_4 : tensor<64xi64>
    %col_ok = arith.extsi %N : i32 to i64
    %col_ok_7 = tt.splat %col_ok : i64 -> tensor<64xi64>
    %col_ok_8 = arith.cmpi slt, %rn_6, %col_ok_7 : tensor<64xi64>
    %col_ok_9 = tt.expand_dims %col_ok_8 {axis = 0 : i32} : tensor<64xi1> -> tensor<1x64xi1>
    %b_ptrs_10 = arith.addi %col0_3, %b_ptrs_1 : i64
    %b_ptrs_11 = arith.muli %b_ptrs_10, %c64_i64 : i64
    %b_ptrs_12 = tt.addptr %B, %b_ptrs_11 : !tt.ptr<bf16>, i64
    %b_ptrs_13 = tt.expand_dims %rn_4 {axis = 0 : i32} : tensor<64xi64> -> tensor<1x64xi64>
    %b_ptrs_14 = arith.muli %b_ptrs_13, %b_ptrs : tensor<1x64xi64>
    %b_ptrs_15 = tt.expand_dims %rn_4 {axis = 1 : i32} : tensor<64xi64> -> tensor<64x1xi64>
    %b_ptrs_16 = tt.broadcast %b_ptrs_14 : tensor<1x64xi64> -> tensor<64x64xi64>
    %b_ptrs_17 = tt.broadcast %b_ptrs_15 : tensor<64x1xi64> -> tensor<64x64xi64>
    %b_ptrs_18 = arith.addi %b_ptrs_16, %b_ptrs_17 : tensor<64x64xi64>
    %b_ptrs_19 = tt.splat %b_ptrs_12 : !tt.ptr<bf16> -> tensor<64x64x!tt.ptr<bf16>>
    %b_ptrs_20 = tt.addptr %b_ptrs_19, %b_ptrs_18 : tensor<64x64x!tt.ptr<bf16>>, tensor<64x64xi64>
    %b_21 = tt.broadcast %col_ok_9 : tensor<1x64xi1> -> tensor<64x64xi1>
    %b_22 = tt.load %b_ptrs_20, %b_21, %b : tensor<64x64x!tt.ptr<bf16>>
    %c_23 = arith.muli %pid, %c : i32
    %c_24 = tt.addptr %C, %c_23 : !tt.ptr<bf16>, i32
    %c_25 = tt.expand_dims %rn {axis = 1 : i32} : tensor<64xi32> -> tensor<64x1xi32>
    %c_26 = arith.muli %c_25, %c_0 : tensor<64x1xi32>
    %c_27 = tt.splat %c_24 : !tt.ptr<bf16> -> tensor<64x1x!tt.ptr<bf16>>
    %c_28 = tt.addptr %c_27, %c_26 : tensor<64x1x!tt.ptr<bf16>>, tensor<64x1xi32>
    %c_29 = tt.expand_dims %rn {axis = 0 : i32} : tensor<64xi32> -> tensor<1x64xi32>
    %c_30 = tt.broadcast %c_28 : tensor<64x1x!tt.ptr<bf16>> -> tensor<64x64x!tt.ptr<bf16>>
    %c_31 = tt.broadcast %c_29 : tensor<1x64xi32> -> tensor<64x64xi32>
    %c_32 = tt.addptr %c_30, %c_31 : tensor<64x64x!tt.ptr<bf16>>, tensor<64x64xi32>
    tt.store %c_32, %b_22 : tensor<64x64x!tt.ptr<bf16>>
    tt.return
  }
}
