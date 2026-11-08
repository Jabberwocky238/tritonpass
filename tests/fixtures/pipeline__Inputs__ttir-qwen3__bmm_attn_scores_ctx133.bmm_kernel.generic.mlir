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
    ^bb0(%arg27: f32, %arg28: f32):
      "linalg.yield"(%arg27) : (f32) -> ()
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
      %56 = "memref.reinterpret_cast"(%arg1, %34) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, -9223372036854775808>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[1, ?]>>
      %57 = "memref.reinterpret_cast"(%arg0, %31) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
      %58 = "arith.addi"(%28, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %59 = "arith.index_cast"(%arg3) : (i32) -> index
      %60 = "arith.minsi"(%58, %59) : (index, index) -> index
      %61 = "arith.maxsi"(%60, %28) : (index, index) -> index
      %62 = "arith.subi"(%61, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %63 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      "linalg.fill"(%0, %63) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg25: f32, %arg26: f32):
        "linalg.yield"(%arg25) : (f32) -> ()
      }) : (f32, memref<32x32xf32>) -> ()
      %64 = "memref.subview"(%57, %arg13, %62) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index) -> memref<?x32xf32, strided<[?, 1], offset: ?>>
      %65 = "memref.subview"(%63, %62) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<32x32xf32>, index) -> memref<?x32xf32, strided<[32, 1]>>
      "linalg.copy"(%64, %65) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg23: f32, %arg24: f32):
        "linalg.yield"(%arg23) : (f32) -> ()
      }) : (memref<?x32xf32, strided<[?, 1], offset: ?>>, memref<?x32xf32, strided<[32, 1]>>) -> ()
      %66 = "bufferization.to_tensor"(%63) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %67 = "arith.addi"(%30, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %68 = "arith.index_cast"(%arg4) : (i32) -> index
      %69 = "arith.minsi"(%67, %68) : (index, index) -> index
      %70 = "arith.maxsi"(%69, %30) : (index, index) -> index
      %71 = "arith.subi"(%70, %30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %72 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      "linalg.fill"(%0, %72) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg21: f32, %arg22: f32):
        "linalg.yield"(%arg21) : (f32) -> ()
      }) : (f32, memref<32x32xf32>) -> ()
      %73 = "memref.subview"(%56, %arg14, %30, %71) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[1, ?]>>, index, index, index) -> memref<32x?xf32, strided<[1, ?], offset: ?>>
      %74 = "memref.subview"(%72, %71) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<32x32xf32>, index) -> memref<32x?xf32, strided<[32, 1]>>
      "linalg.copy"(%73, %74) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg19: f32, %arg20: f32):
        "linalg.yield"(%arg19) : (f32) -> ()
      }) : (memref<32x?xf32, strided<[1, ?], offset: ?>>, memref<32x?xf32, strided<[32, 1]>>) -> ()
      %75 = "bufferization.to_tensor"(%72) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %76 = "arith.addi"(%arg13, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %77 = "arith.addi"(%arg14, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %78 = "linalg.matmul"(%66, %75, %arg15) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg16: f32, %arg17: f32, %arg18: f32):
        %79 = "arith.mulf"(%arg16, %arg17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %80 = "arith.addf"(%arg18, %79) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%80) : (f32) -> ()
      }) : (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
      "scf.yield"(%76, %77, %78) : (index, index, tensor<32x32xf32>) -> ()
    }) : (index, index, index, index, index, tensor<32x32xf32>) -> (index, index, tensor<32x32xf32>)
    %41 = "arith.addi"(%28, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %42 = "arith.index_cast"(%arg3) : (i32) -> index
    %43 = "arith.minsi"(%41, %42) : (index, index) -> index
    %44 = "arith.maxsi"(%43, %28) : (index, index) -> index
    %45 = "arith.subi"(%44, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %46 = "arith.addi"(%30, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %47 = "arith.index_cast"(%arg4) : (i32) -> index
    %48 = "arith.minsi"(%46, %47) : (index, index) -> index
    %49 = "arith.maxsi"(%48, %30) : (index, index) -> index
    %50 = "arith.subi"(%49, %30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %51 = "arith.minsi"(%45, %5) : (index, index) -> index
    %52 = "arith.minsi"(%50, %5) : (index, index) -> index
    %53 = "arith.addi"(%30, %20) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %54 = "tensor.extract_slice"(%40#2, %51, %52) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<32x32xf32>, index, index) -> tensor<?x?xf32>
    %55 = "memref.subview"(%36, %28, %53, %51, %52) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[?, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%54, %55) <{writable}> : (tensor<?x?xf32>, memref<?x?xf32, strided<[?, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

