#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "bmm_kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 31 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 32 : index}> : () -> index
    %5 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %7 = "tensor.empty"() : () -> tensor<32x32xf32>
    %8 = "linalg.fill"(%0, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg28: f32, %arg29: f32):
      "linalg.yield"(%arg28) : (f32) -> ()
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
    %37 = "arith.addi"(%arg5, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %38 = "arith.divsi"(%37, %5) : (i32, i32) -> i32
    %39 = "arith.muli"(%arg9, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %40 = "arith.index_cast"(%39) : (i32) -> index
    %41 = "arith.index_cast"(%38) : (i32) -> index
    %42:4 = "scf.for"(%2, %41, %3, %2, %33, %17, %8) ({
    ^bb0(%arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: tensor<32x32xf32>):
      %51 = "memref.reinterpret_cast"(%arg1, %34) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
      %52 = "memref.reinterpret_cast"(%arg0, %31) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
      %53 = "arith.addi"(%28, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %54 = "arith.index_cast"(%arg3) : (i32) -> index
      %55 = "arith.minsi"(%53, %54) : (index, index) -> index
      %56 = "arith.maxsi"(%55, %28) : (index, index) -> index
      %57 = "arith.subi"(%56, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %58 = "arith.addi"(%arg13, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %59 = "arith.index_cast"(%arg5) : (i32) -> index
      %60 = "arith.minsi"(%58, %59) : (index, index) -> index
      %61 = "arith.maxsi"(%60, %arg13) : (index, index) -> index
      %62 = "arith.subi"(%61, %arg13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %63 = "arith.minsi"(%57, %4) : (index, index) -> index
      %64 = "arith.minsi"(%62, %4) : (index, index) -> index
      %65 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      "linalg.fill"(%0, %65) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg26: f32, %arg27: f32):
        "linalg.yield"(%arg26) : (f32) -> ()
      }) : (f32, memref<32x32xf32>) -> ()
      %66 = "memref.subview"(%52, %arg14, %63, %64) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index, index) -> memref<?x?xf32, strided<[?, 1], offset: ?>>
      %67 = "memref.subview"(%65, %63, %64) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<32x32xf32>, index, index) -> memref<?x?xf32, strided<[32, 1]>>
      "linalg.copy"(%66, %67) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg24: f32, %arg25: f32):
        "linalg.yield"(%arg24) : (f32) -> ()
      }) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, memref<?x?xf32, strided<[32, 1]>>) -> ()
      %68 = "bufferization.to_tensor"(%65) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %69 = "arith.addi"(%30, %arg15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %70 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      "linalg.fill"(%0, %70) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg22: f32, %arg23: f32):
        "linalg.yield"(%arg22) : (f32) -> ()
      }) : (f32, memref<32x32xf32>) -> ()
      %71 = "memref.subview"(%51, %69, %62) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index) -> memref<?x32xf32, strided<[?, 1], offset: ?>>
      %72 = "memref.subview"(%70, %62) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<32x32xf32>, index) -> memref<?x32xf32, strided<[32, 1]>>
      "linalg.copy"(%71, %72) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg20: f32, %arg21: f32):
        "linalg.yield"(%arg20) : (f32) -> ()
      }) : (memref<?x32xf32, strided<[?, 1], offset: ?>>, memref<?x32xf32, strided<[32, 1]>>) -> ()
      %73 = "bufferization.to_tensor"(%70) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %74 = "arith.addi"(%arg14, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %75 = "arith.addi"(%arg15, %40) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %76 = "linalg.matmul"(%68, %73, %arg16) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg17: f32, %arg18: f32, %arg19: f32):
        %77 = "arith.mulf"(%arg17, %arg18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %78 = "arith.addf"(%arg19, %77) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%78) : (f32) -> ()
      }) : (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
      "scf.yield"(%58, %74, %75, %76) : (index, index, index, tensor<32x32xf32>) -> ()
    }) : (index, index, index, index, index, index, tensor<32x32xf32>) -> (index, index, index, tensor<32x32xf32>)
    %43 = "arith.addi"(%28, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %44 = "arith.index_cast"(%arg3) : (i32) -> index
    %45 = "arith.minsi"(%43, %44) : (index, index) -> index
    %46 = "arith.maxsi"(%45, %28) : (index, index) -> index
    %47 = "arith.subi"(%46, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %48 = "arith.addi"(%30, %20) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %49 = "tensor.extract_slice"(%42#3, %47) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (tensor<32x32xf32>, index) -> tensor<?x32xf32>
    %50 = "memref.subview"(%36, %28, %48, %47) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index, index) -> memref<?x32xf32, strided<[?, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%49, %50) <{writable}> : (tensor<?x32xf32>, memref<?x32xf32, strided<[?, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

