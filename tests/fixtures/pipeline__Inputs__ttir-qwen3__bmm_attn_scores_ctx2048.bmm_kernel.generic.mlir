#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "bmm_kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 31 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 32 : index}> : () -> index
    %6 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %7 = "tensor.empty"() : () -> tensor<32x32xf32>
    %8 = "linalg.fill"(%0, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: f32, %arg26: f32):
      "linalg.yield"(%arg25) : (f32) -> ()
    }) : (f32, tensor<32x32xf32>) -> tensor<32x32xf32>
    %9 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
    %10 = "arith.index_cast"(%9) : (index) -> i32
    %11 = "arith.extsi"(%10) : (i32) -> i64
    %12 = "arith.extsi"(%arg6) : (i32) -> i64
    %13 = "arith.muli"(%11, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %14 = "arith.index_cast"(%13) : (i64) -> index
    %15 = "arith.extsi"(%arg8) : (i32) -> i64
    %16 = "arith.muli"(%11, %15) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %17 = "arith.index_cast"(%16) : (i64) -> index
    %18 = "arith.extsi"(%arg10) : (i32) -> i64
    %19 = "arith.muli"(%11, %18) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %20 = "arith.index_cast"(%19) : (i64) -> index
    %21 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %22 = "arith.index_cast"(%21) : (index) -> i32
    %23 = "arith.extsi"(%22) : (i32) -> i64
    %24 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %25 = "arith.index_cast"(%24) : (index) -> i32
    %26 = "arith.extsi"(%25) : (i32) -> i64
    %27 = "arith.muli"(%23, %6) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %28 = "arith.index_cast"(%27) : (i64) -> index
    %29 = "arith.muli"(%26, %6) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %30 = "arith.index_cast"(%29) : (i64) -> index
    %31 = "arith.index_cast"(%arg7) : (i32) -> index
    %32 = "arith.muli"(%28, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %33 = "arith.addi"(%14, %32) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %34 = "arith.index_cast"(%arg9) : (i32) -> index
    %35 = "arith.index_cast"(%arg11) : (i32) -> index
    %36 = "memref.reinterpret_cast"(%arg2, %35) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
    %37 = "arith.addi"(%arg5, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %38 = "arith.divsi"(%37, %1) : (i32, i32) -> i32
    %39 = "arith.index_cast"(%38) : (i32) -> index
    %40:3 = "scf.for"(%3, %39, %4, %33, %17, %8) ({
    ^bb0(%arg12: index, %arg13: index, %arg14: index, %arg15: tensor<32x32xf32>):
      %49 = "memref.reinterpret_cast"(%arg1, %34) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, -9223372036854775808>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[1, ?]>>
      %50 = "memref.reinterpret_cast"(%arg0, %31) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
      %51 = "arith.addi"(%28, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %52 = "arith.index_cast"(%arg3) : (i32) -> index
      %53 = "arith.minsi"(%51, %52) : (index, index) -> index
      %54 = "arith.maxsi"(%53, %28) : (index, index) -> index
      %55 = "arith.subi"(%54, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %56 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      "linalg.fill"(%0, %56) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg23: f32, %arg24: f32):
        "linalg.yield"(%arg23) : (f32) -> ()
      }) : (f32, memref<32x32xf32>) -> ()
      %57 = "memref.subview"(%50, %arg13, %55) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index) -> memref<?x32xf32, strided<[?, 1], offset: ?>>
      %58 = "memref.subview"(%56, %55) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<32x32xf32>, index) -> memref<?x32xf32, strided<[32, 1]>>
      "linalg.copy"(%57, %58) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg21: f32, %arg22: f32):
        "linalg.yield"(%arg21) : (f32) -> ()
      }) : (memref<?x32xf32, strided<[?, 1], offset: ?>>, memref<?x32xf32, strided<[32, 1]>>) -> ()
      %59 = "bufferization.to_tensor"(%56) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %60 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      %61 = "memref.subview"(%49, %arg14, %30) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[1, ?]>>, index, index) -> memref<32x32xf32, strided<[1, ?], offset: ?>>
      "linalg.copy"(%61, %60) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg19: f32, %arg20: f32):
        "linalg.yield"(%arg19) : (f32) -> ()
      }) : (memref<32x32xf32, strided<[1, ?], offset: ?>>, memref<32x32xf32>) -> ()
      %62 = "bufferization.to_tensor"(%60) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %63 = "arith.addi"(%arg13, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %64 = "arith.addi"(%arg14, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %65 = "linalg.matmul"(%59, %62, %arg15) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg16: f32, %arg17: f32, %arg18: f32):
        %66 = "arith.mulf"(%arg16, %arg17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %67 = "arith.addf"(%arg18, %66) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%67) : (f32) -> ()
      }) : (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
      "scf.yield"(%63, %64, %65) : (index, index, tensor<32x32xf32>) -> ()
    }) : (index, index, index, index, index, tensor<32x32xf32>) -> (index, index, tensor<32x32xf32>)
    %41 = "arith.addi"(%28, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %42 = "arith.index_cast"(%arg3) : (i32) -> index
    %43 = "arith.minsi"(%41, %42) : (index, index) -> index
    %44 = "arith.maxsi"(%43, %28) : (index, index) -> index
    %45 = "arith.subi"(%44, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %46 = "arith.addi"(%30, %20) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %47 = "tensor.extract_slice"(%40#2, %45) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (tensor<32x32xf32>, index) -> tensor<?x32xf32>
    %48 = "memref.subview"(%36, %28, %46, %45) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index, index) -> memref<?x32xf32, strided<[?, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%47, %48) <{writable}> : (tensor<?x32xf32>, memref<?x32xf32, strided<[?, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

