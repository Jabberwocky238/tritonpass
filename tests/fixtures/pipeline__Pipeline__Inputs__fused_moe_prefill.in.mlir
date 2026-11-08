// vLLM 0.32.0 的 fused_moe_kernel（invoke_fused_moe_triton_kernel 预填充的排序写法：sorted_token_ids 每行一个 token 号，
// H = 2048、中间层 768、32 个专家选 8；bf16，BLOCK 16×64×128）经 Triton 3.7.1 生成的 TTIR，去掉了文件位置。
module {
  tt.func public @fused_moe_kernel(%a_ptr: !tt.ptr<bf16> loc("a_ptr"), %b_ptr: !tt.ptr<bf16> loc("b_ptr"), %c_ptr: !tt.ptr<bf16> loc("c_ptr"), %topk_weights_ptr: !tt.ptr<f32> loc("topk_weights_ptr"), %sorted_token_ids_ptr: !tt.ptr<i32> loc("sorted_token_ids_ptr"), %expert_ids_ptr: !tt.ptr<i32> loc("expert_ids_ptr"), %num_tokens_post_padded_ptr: !tt.ptr<i32> loc("num_tokens_post_padded_ptr"), %N: i32 loc("N"), %K: i32 loc("K"), %EM: i32 loc("EM"), %num_valid_tokens: i32 loc("num_valid_tokens"), %stride_am: i32 loc("stride_am"), %stride_be: i32 loc("stride_be"), %stride_bn: i32 loc("stride_bn"), %stride_cm: i32 loc("stride_cm"), %stride_asm: i32 loc("stride_asm"), %stride_ask: i32 loc("stride_ask"), %stride_bse: i32 loc("stride_bse"), %stride_bsk: i32 loc("stride_bsk"), %stride_bsn: i32 loc("stride_bsn"), %stride_bbe: i32 loc("stride_bbe"), %stride_bbn: i32 loc("stride_bbn")) attributes {noinline = false} {
    %c127_i32 = arith.constant 127 : i32
    %cst = arith.constant dense<0.000000e+00> : tensor<16x64xbf16>
    %num_pid_n = arith.constant 63 : i32
    %num_pid_m = arith.constant 15 : i32
    %cst_0 = arith.constant dense<0.000000e+00> : tensor<128x64xbf16>
    %cst_1 = arith.constant dense<0.000000e+00> : tensor<16x128xbf16>
    %c0_i32 = arith.constant 0 : i32
    %c-1_i64 = arith.constant -1 : i64
    %cst_2 = arith.constant dense<128> : tensor<128x64xi32>
    %cst_3 = arith.constant dense<128> : tensor<16x128xi32>
    %cst_4 = arith.constant dense<0.000000e+00> : tensor<16x64xf32>
    %c128_i32 = arith.constant 128 : i32
    %cst_5 = arith.constant dense<8> : tensor<16x1xi64>
    %c64_i32 = arith.constant 64 : i32
    %c16_i32 = arith.constant 16 : i32
    %c1_i32 = arith.constant 1 : i32
    %pid = tt.get_program_id x : i32
    %num_pid_m_6 = arith.addi %EM, %num_pid_m : i32
    %num_pid_m_7 = arith.divsi %num_pid_m_6, %c16_i32 : i32
    %num_pid_n_8 = arith.addi %N, %num_pid_n : i32
    %num_pid_n_9 = arith.divsi %num_pid_n_8, %c64_i32 : i32
    %group_id = arith.divsi %pid, %num_pid_n_9 : i32
    %group_size_m = arith.subi %num_pid_m_7, %group_id : i32
    %group_size_m_10 = arith.minsi %group_size_m, %c1_i32 : i32
    %pid_m = arith.remsi %pid, %num_pid_n_9 : i32
    %pid_m_11 = arith.remsi %pid_m, %group_size_m_10 : i32
    %pid_m_12 = arith.addi %group_id, %pid_m_11 : i32
    %pid_n = arith.divsi %pid_m, %group_size_m_10 : i32
    %offs = tt.make_range {end = 16 : i32, start = 0 : i32} : tensor<16xi32>
    %offs_13 = arith.extsi %offs : tensor<16xi32> to tensor<16xi64>
    %num_tokens_post_padded = tt.load %num_tokens_post_padded_ptr : !tt.ptr<i32>
    %0 = arith.muli %pid_m_12, %c16_i32 : i32
    %1 = arith.cmpi sge, %0, %num_tokens_post_padded : i32
    cf.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    tt.return
  ^bb2:  // pred: ^bb0
    %offs_token_id = arith.extsi %0 : i32 to i64
    %offs_token_id_14 = tt.splat %offs_token_id : i64 -> tensor<16xi64>
    %offs_token_id_15 = arith.addi %offs_token_id_14, %offs_13 : tensor<16xi64>
    %offs_token = tt.splat %sorted_token_ids_ptr : !tt.ptr<i32> -> tensor<16x!tt.ptr<i32>>
    %offs_token_16 = tt.addptr %offs_token, %offs_token_id_15 : tensor<16x!tt.ptr<i32>>, tensor<16xi64>
    %offs_token_17 = tt.load %offs_token_16 : tensor<16x!tt.ptr<i32>>
    %offs_token_18 = arith.extsi %offs_token_17 : tensor<16xi32> to tensor<16xi64>
    %token_mask = arith.extsi %num_valid_tokens : i32 to i64
    %token_mask_19 = tt.splat %token_mask : i64 -> tensor<16xi64>
    %token_mask_20 = arith.cmpi slt, %offs_token_18, %token_mask_19 : tensor<16xi64>
    %off_experts = tt.addptr %expert_ids_ptr, %pid_m_12 : !tt.ptr<i32>, i32
    %off_experts_21 = tt.load %off_experts : !tt.ptr<i32>
    %off_experts_22 = arith.extsi %off_experts_21 : i32 to i64
    %2 = arith.cmpi eq, %off_experts_22, %c-1_i64 : i64
    cf.cond_br %2, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %offs_cn = arith.muli %pid_n, %c64_i32 : i32
    %offs_cn_23 = tt.make_range {end = 64 : i32, start = 0 : i32} : tensor<64xi32>
    %offs_cn_24 = tt.splat %offs_cn : i32 -> tensor<64xi32>
    %offs_cn_25 = arith.addi %offs_cn_24, %offs_cn_23 : tensor<64xi32>
    %c_ptrs = tt.expand_dims %offs_token_18 {axis = 1 : i32} : tensor<16xi64> -> tensor<16x1xi64>
    %c_ptrs_26 = arith.extsi %stride_cm : i32 to i64
    %c_ptrs_27 = tt.splat %c_ptrs_26 : i64 -> tensor<16x1xi64>
    %c_ptrs_28 = arith.muli %c_ptrs_27, %c_ptrs : tensor<16x1xi64>
    %c_ptrs_29 = tt.splat %c_ptr : !tt.ptr<bf16> -> tensor<16x1x!tt.ptr<bf16>>
    %c_ptrs_30 = tt.addptr %c_ptrs_29, %c_ptrs_28 : tensor<16x1x!tt.ptr<bf16>>, tensor<16x1xi64>
    %c_ptrs_31 = tt.expand_dims %offs_cn_25 {axis = 0 : i32} : tensor<64xi32> -> tensor<1x64xi32>
    %c_ptrs_32 = tt.broadcast %c_ptrs_30 : tensor<16x1x!tt.ptr<bf16>> -> tensor<16x64x!tt.ptr<bf16>>
    %c_ptrs_33 = tt.broadcast %c_ptrs_31 : tensor<1x64xi32> -> tensor<16x64xi32>
    %c_ptrs_34 = tt.addptr %c_ptrs_32, %c_ptrs_33 : tensor<16x64x!tt.ptr<bf16>>, tensor<16x64xi32>
    %c_mask = tt.expand_dims %token_mask_20 {axis = 1 : i32} : tensor<16xi1> -> tensor<16x1xi1>
    %c_mask_35 = tt.splat %N : i32 -> tensor<1x64xi32>
    %c_mask_36 = arith.cmpi slt, %c_ptrs_31, %c_mask_35 : tensor<1x64xi32>
    %c_mask_37 = tt.broadcast %c_mask : tensor<16x1xi1> -> tensor<16x64xi1>
    %c_mask_38 = tt.broadcast %c_mask_36 : tensor<1x64xi1> -> tensor<16x64xi1>
    %c_mask_39 = arith.andi %c_mask_37, %c_mask_38 : tensor<16x64xi1>
    tt.store %c_ptrs_34, %cst, %c_mask_39 : tensor<16x64x!tt.ptr<bf16>>
    tt.return
  ^bb4:  // pred: ^bb2
    %offs_bn = arith.muli %pid_n, %c64_i32 : i32
    %offs_bn_40 = tt.make_range {end = 64 : i32, start = 0 : i32} : tensor<64xi32>
    %offs_bn_41 = arith.extsi %offs_bn_40 : tensor<64xi32> to tensor<64xi64>
    %offs_bn_42 = arith.extsi %offs_bn : i32 to i64
    %offs_bn_43 = tt.splat %offs_bn_42 : i64 -> tensor<64xi64>
    %offs_bn_44 = arith.addi %offs_bn_43, %offs_bn_41 : tensor<64xi64>
    %offs_bn_45 = arith.extsi %N : i32 to i64
    %offs_bn_46 = tt.splat %offs_bn_45 : i64 -> tensor<64xi64>
    %offs_bn_47 = arith.remsi %offs_bn_44, %offs_bn_46 : tensor<64xi64>
    %offs_k = tt.make_range {end = 128 : i32, start = 0 : i32} : tensor<128xi32>
    %a_ptrs = tt.expand_dims %offs_token_18 {axis = 1 : i32} : tensor<16xi64> -> tensor<16x1xi64>
    %a_ptrs_48 = arith.divsi %a_ptrs, %cst_5 : tensor<16x1xi64>
    %a_ptrs_49 = arith.extsi %stride_am : i32 to i64
    %a_ptrs_50 = tt.splat %a_ptrs_49 : i64 -> tensor<16x1xi64>
    %a_ptrs_51 = arith.muli %a_ptrs_48, %a_ptrs_50 : tensor<16x1xi64>
    %a_ptrs_52 = tt.expand_dims %offs_k {axis = 0 : i32} : tensor<128xi32> -> tensor<1x128xi32>
    %a_ptrs_53 = arith.extsi %a_ptrs_52 : tensor<1x128xi32> to tensor<1x128xi64>
    %a_ptrs_54 = tt.broadcast %a_ptrs_51 : tensor<16x1xi64> -> tensor<16x128xi64>
    %a_ptrs_55 = tt.broadcast %a_ptrs_53 : tensor<1x128xi64> -> tensor<16x128xi64>
    %a_ptrs_56 = arith.addi %a_ptrs_54, %a_ptrs_55 : tensor<16x128xi64>
    %a_ptrs_57 = tt.splat %a_ptr : !tt.ptr<bf16> -> tensor<16x128x!tt.ptr<bf16>>
    %a_ptrs_58 = tt.addptr %a_ptrs_57, %a_ptrs_56 : tensor<16x128x!tt.ptr<bf16>>, tensor<16x128xi64>
    %b_ptrs = arith.extsi %stride_be : i32 to i64
    %b_ptrs_59 = arith.muli %off_experts_22, %b_ptrs : i64
    %b_ptrs_60 = tt.addptr %b_ptr, %b_ptrs_59 : !tt.ptr<bf16>, i64
    %b_ptrs_61 = tt.expand_dims %offs_k {axis = 1 : i32} : tensor<128xi32> -> tensor<128x1xi32>
    %b_ptrs_62 = tt.expand_dims %offs_bn_47 {axis = 0 : i32} : tensor<64xi64> -> tensor<1x64xi64>
    %b_ptrs_63 = arith.extsi %stride_bn : i32 to i64
    %b_ptrs_64 = tt.splat %b_ptrs_63 : i64 -> tensor<1x64xi64>
    %b_ptrs_65 = arith.muli %b_ptrs_62, %b_ptrs_64 : tensor<1x64xi64>
    %b_ptrs_66 = arith.extsi %b_ptrs_61 : tensor<128x1xi32> to tensor<128x1xi64>
    %b_ptrs_67 = tt.broadcast %b_ptrs_66 : tensor<128x1xi64> -> tensor<128x64xi64>
    %b_ptrs_68 = tt.broadcast %b_ptrs_65 : tensor<1x64xi64> -> tensor<128x64xi64>
    %b_ptrs_69 = arith.addi %b_ptrs_67, %b_ptrs_68 : tensor<128x64xi64>
    %b_ptrs_70 = tt.splat %b_ptrs_60 : !tt.ptr<bf16> -> tensor<128x64x!tt.ptr<bf16>>
    %b_ptrs_71 = tt.addptr %b_ptrs_70, %b_ptrs_69 : tensor<128x64x!tt.ptr<bf16>>, tensor<128x64xi64>
    %3 = arith.addi %K, %c127_i32 : i32
    %4 = arith.divsi %3, %c128_i32 : i32
    %a = tt.expand_dims %token_mask_20 {axis = 1 : i32} : tensor<16xi1> -> tensor<16x1xi1>
    %a_72 = tt.broadcast %a : tensor<16x1xi1> -> tensor<16x128xi1>
    %accumulator:3 = scf.for %k = %c0_i32 to %4 step %c1_i32 iter_args(%a_ptrs_91 = %a_ptrs_58, %b_ptrs_92 = %b_ptrs_71, %accumulator_93 = %cst_4) -> (tensor<16x128x!tt.ptr<bf16>>, tensor<128x64x!tt.ptr<bf16>>, tensor<16x64xf32>)  : i32 {
      %a_94 = arith.muli %k, %c128_i32 : i32
      %a_95 = arith.subi %K, %a_94 : i32
      %a_96 = tt.splat %a_95 : i32 -> tensor<1x128xi32>
      %a_97 = arith.cmpi slt, %a_ptrs_52, %a_96 : tensor<1x128xi32>
      %a_98 = tt.broadcast %a_97 : tensor<1x128xi1> -> tensor<16x128xi1>
      %a_99 = arith.andi %a_72, %a_98 : tensor<16x128xi1>
      %a_100 = tt.load %a_ptrs_91, %a_99, %cst_1 : tensor<16x128x!tt.ptr<bf16>>
      %b = tt.splat %a_95 : i32 -> tensor<128x1xi32>
      %b_101 = arith.cmpi slt, %b_ptrs_61, %b : tensor<128x1xi32>
      %b_102 = tt.broadcast %b_101 : tensor<128x1xi1> -> tensor<128x64xi1>
      %b_103 = tt.load %b_ptrs_92, %b_102, %cst_0 : tensor<128x64x!tt.ptr<bf16>>
      %accumulator_104 = tt.dot %a_100, %b_103, %accumulator_93 : tensor<16x128xbf16> * tensor<128x64xbf16> -> tensor<16x64xf32>
      %a_ptrs_105 = tt.addptr %a_ptrs_91, %cst_3 : tensor<16x128x!tt.ptr<bf16>>, tensor<16x128xi32>
      %b_ptrs_106 = tt.addptr %b_ptrs_92, %cst_2 : tensor<128x64x!tt.ptr<bf16>>, tensor<128x64xi32>
      scf.yield %a_ptrs_105, %b_ptrs_106, %accumulator_104 : tensor<16x128x!tt.ptr<bf16>>, tensor<128x64x!tt.ptr<bf16>>, tensor<16x64xf32>
    }
    %accumulator_73 = arith.truncf %accumulator#2 : tensor<16x64xf32> to tensor<16x64xbf16>
    %offs_cn_74 = tt.splat %offs_bn : i32 -> tensor<64xi32>
    %offs_cn_75 = arith.addi %offs_cn_74, %offs_bn_40 : tensor<64xi32>
    %c_ptrs_76 = arith.extsi %stride_cm : i32 to i64
    %c_ptrs_77 = tt.splat %c_ptrs_76 : i64 -> tensor<16x1xi64>
    %c_ptrs_78 = arith.muli %c_ptrs_77, %a_ptrs : tensor<16x1xi64>
    %c_ptrs_79 = tt.splat %c_ptr : !tt.ptr<bf16> -> tensor<16x1x!tt.ptr<bf16>>
    %c_ptrs_80 = tt.addptr %c_ptrs_79, %c_ptrs_78 : tensor<16x1x!tt.ptr<bf16>>, tensor<16x1xi64>
    %c_ptrs_81 = tt.expand_dims %offs_cn_75 {axis = 0 : i32} : tensor<64xi32> -> tensor<1x64xi32>
    %c_ptrs_82 = tt.broadcast %c_ptrs_80 : tensor<16x1x!tt.ptr<bf16>> -> tensor<16x64x!tt.ptr<bf16>>
    %c_ptrs_83 = tt.broadcast %c_ptrs_81 : tensor<1x64xi32> -> tensor<16x64xi32>
    %c_ptrs_84 = tt.addptr %c_ptrs_82, %c_ptrs_83 : tensor<16x64x!tt.ptr<bf16>>, tensor<16x64xi32>
    %c_mask_85 = tt.expand_dims %token_mask_20 {axis = 1 : i32} : tensor<16xi1> -> tensor<16x1xi1>
    %c_mask_86 = tt.splat %N : i32 -> tensor<1x64xi32>
    %c_mask_87 = arith.cmpi slt, %c_ptrs_81, %c_mask_86 : tensor<1x64xi32>
    %c_mask_88 = tt.broadcast %c_mask_85 : tensor<16x1xi1> -> tensor<16x64xi1>
    %c_mask_89 = tt.broadcast %c_mask_87 : tensor<1x64xi1> -> tensor<16x64xi1>
    %c_mask_90 = arith.andi %c_mask_88, %c_mask_89 : tensor<16x64xi1>
    tt.store %c_ptrs_84, %accumulator_73, %c_mask_90 : tensor<16x64x!tt.ptr<bf16>>
    tt.return
  }
}
