// Triton 3.7.1 生成（去掉了文件位置）。打包权重矩阵乘的一种写法：[BLOCK_K, TILE_N] = [64, 64] 的窗口，k 在内（行距 1）、
// n 在外（行距 BLOCK_K = 64）；标量首列 col0 = (pid % programs_n)·64 乘过 BLOCK_K 单独加进地址，掩码是 col0 + arange < N：
//   rn = col0 + arange(TILE_N); b = load(B + col0·BLOCK_K + arange(TILE_N)[None, :]·BLOCK_K + arange(BLOCK_K)[:, None], mask=(rn < N)[None, :])
module {
  tt.func public @packed_masked(%B: !tt.ptr<bf16> loc("B"), %C: !tt.ptr<bf16> loc("C"), %N: i32 loc("N"), %programs_n: i32 loc("programs_n")) attributes {noinline = false} {
    %c = arith.constant 4096 : i32
    %b = arith.constant dense<0.000000e+00> : tensor<64x64xbf16>
    %b_ptrs = arith.constant 4096 : i64
    %c_0 = arith.constant dense<64> : tensor<64x1xi32>
    %b_ptrs_1 = arith.constant dense<64> : tensor<1x64xi64>
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
    %b_ptrs_10 = arith.muli %col0_2, %b_ptrs : i64
    %b_ptrs_11 = tt.addptr %B, %b_ptrs_10 : !tt.ptr<bf16>, i64
    %b_ptrs_12 = tt.expand_dims %rn_4 {axis = 0 : i32} : tensor<64xi64> -> tensor<1x64xi64>
    %b_ptrs_13 = arith.muli %b_ptrs_12, %b_ptrs_1 : tensor<1x64xi64>
    %b_ptrs_14 = tt.expand_dims %rn_4 {axis = 1 : i32} : tensor<64xi64> -> tensor<64x1xi64>
    %b_ptrs_15 = tt.broadcast %b_ptrs_13 : tensor<1x64xi64> -> tensor<64x64xi64>
    %b_ptrs_16 = tt.broadcast %b_ptrs_14 : tensor<64x1xi64> -> tensor<64x64xi64>
    %b_ptrs_17 = arith.addi %b_ptrs_15, %b_ptrs_16 : tensor<64x64xi64>
    %b_ptrs_18 = tt.splat %b_ptrs_11 : !tt.ptr<bf16> -> tensor<64x64x!tt.ptr<bf16>>
    %b_ptrs_19 = tt.addptr %b_ptrs_18, %b_ptrs_17 : tensor<64x64x!tt.ptr<bf16>>, tensor<64x64xi64>
    %b_20 = tt.broadcast %col_ok_9 : tensor<1x64xi1> -> tensor<64x64xi1>
    %b_21 = tt.load %b_ptrs_19, %b_20, %b : tensor<64x64x!tt.ptr<bf16>>
    %c_22 = arith.muli %pid, %c : i32
    %c_23 = tt.addptr %C, %c_22 : !tt.ptr<bf16>, i32
    %c_24 = tt.expand_dims %rn {axis = 1 : i32} : tensor<64xi32> -> tensor<64x1xi32>
    %c_25 = arith.muli %c_24, %c_0 : tensor<64x1xi32>
    %c_26 = tt.splat %c_23 : !tt.ptr<bf16> -> tensor<64x1x!tt.ptr<bf16>>
    %c_27 = tt.addptr %c_26, %c_25 : tensor<64x1x!tt.ptr<bf16>>, tensor<64x1xi32>
    %c_28 = tt.expand_dims %rn {axis = 0 : i32} : tensor<64xi32> -> tensor<1x64xi32>
    %c_29 = tt.broadcast %c_27 : tensor<64x1x!tt.ptr<bf16>> -> tensor<64x64x!tt.ptr<bf16>>
    %c_30 = tt.broadcast %c_28 : tensor<1x64xi32> -> tensor<64x64xi32>
    %c_31 = tt.addptr %c_29, %c_30 : tensor<64x64x!tt.ptr<bf16>>, tensor<64x64xi32>
    tt.store %c_31, %b_21 : tensor<64x64x!tt.ptr<bf16>>
    tt.return
  }
}
