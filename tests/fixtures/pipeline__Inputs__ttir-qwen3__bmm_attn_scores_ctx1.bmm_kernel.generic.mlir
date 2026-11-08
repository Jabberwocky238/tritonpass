#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32, i32, i32, i32, i32, i32, i32) -> (), sym_name = "bmm_kernel"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32):
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
    %12 = "arith.extsi"(%arg5) : (i32) -> i64
    %13 = "arith.muli"(%11, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %14 = "arith.index_cast"(%13) : (i64) -> index
    %15 = "arith.extsi"(%arg7) : (i32) -> i64
    %16 = "arith.muli"(%11, %15) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %17 = "arith.index_cast"(%16) : (i64) -> index
    %18 = "arith.extsi"(%arg9) : (i32) -> i64
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
    %31 = "arith.index_cast"(%arg6) : (i32) -> index
    %32 = "arith.muli"(%28, %31) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %33 = "arith.addi"(%14, %32) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %34 = "arith.index_cast"(%arg8) : (i32) -> index
    %35 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, 1>}> : (memref<?xf32>) -> memref<1099511627776x1099511627776xf32, strided<[1, 1]>>
    %36 = "arith.addi"(%arg4, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %37 = "arith.divsi"(%36, %1) : (i32, i32) -> i32
    %38 = "arith.index_cast"(%37) : (i32) -> index
    %39:3 = "scf.for"(%3, %38, %4, %33, %17, %8) ({
    ^bb0(%arg10: index, %arg11: index, %arg12: index, %arg13: tensor<32x32xf32>):
      %54 = "memref.reinterpret_cast"(%arg1, %34) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: 1, -9223372036854775808>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[1, ?]>>
      %55 = "memref.reinterpret_cast"(%arg0, %31) <{operandSegmentSizes = array<i32: 1, 0, 0, 1>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776, 1099511627776>, static_strides = array<i64: -9223372036854775808, 1>}> : (memref<?xf32>, index) -> memref<1099511627776x1099511627776xf32, strided<[?, 1]>>
      %56 = "arith.addi"(%28, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %57 = "arith.index_cast"(%arg3) : (i32) -> index
      %58 = "arith.minsi"(%56, %57) : (index, index) -> index
      %59 = "arith.maxsi"(%58, %28) : (index, index) -> index
      %60 = "arith.subi"(%59, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %61 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      "linalg.fill"(%0, %61) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg23: f32, %arg24: f32):
        "linalg.yield"(%arg23) : (f32) -> ()
      }) : (f32, memref<32x32xf32>) -> ()
      %62 = "memref.subview"(%55, %arg11, %60) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[?, 1]>>, index, index) -> memref<?x32xf32, strided<[?, 1], offset: ?>>
      %63 = "memref.subview"(%61, %60) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 32>, static_strides = array<i64: 1, 1>}> : (memref<32x32xf32>, index) -> memref<?x32xf32, strided<[32, 1]>>
      "linalg.copy"(%62, %63) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg21: f32, %arg22: f32):
        "linalg.yield"(%arg21) : (f32) -> ()
      }) : (memref<?x32xf32, strided<[?, 1], offset: ?>>, memref<?x32xf32, strided<[32, 1]>>) -> ()
      %64 = "bufferization.to_tensor"(%61) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %65 = "arith.addi"(%30, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %66 = "arith.minsi"(%65, %4) : (index, index) -> index
      %67 = "arith.maxsi"(%66, %30) : (index, index) -> index
      %68 = "arith.subi"(%67, %30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %69 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
      "linalg.fill"(%0, %69) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg19: f32, %arg20: f32):
        "linalg.yield"(%arg19) : (f32) -> ()
      }) : (f32, memref<32x32xf32>) -> ()
      %70 = "memref.subview"(%54, %arg12, %30, %68) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[1, ?]>>, index, index, index) -> memref<32x?xf32, strided<[1, ?], offset: ?>>
      %71 = "memref.subview"(%69, %68) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<32x32xf32>, index) -> memref<32x?xf32, strided<[32, 1]>>
      "linalg.copy"(%70, %71) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg17: f32, %arg18: f32):
        "linalg.yield"(%arg17) : (f32) -> ()
      }) : (memref<32x?xf32, strided<[1, ?], offset: ?>>, memref<32x?xf32, strided<[32, 1]>>) -> ()
      %72 = "bufferization.to_tensor"(%69) <{restrict, writable}> : (memref<32x32xf32>) -> tensor<32x32xf32>
      %73 = "arith.addi"(%arg11, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %74 = "arith.addi"(%arg12, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %75 = "linalg.matmul"(%64, %72, %arg13) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg14: f32, %arg15: f32, %arg16: f32):
        %76 = "arith.mulf"(%arg14, %arg15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %77 = "arith.addf"(%arg16, %76) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%77) : (f32) -> ()
      }) : (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
      "scf.yield"(%73, %74, %75) : (index, index, tensor<32x32xf32>) -> ()
    }) : (index, index, index, index, index, tensor<32x32xf32>) -> (index, index, tensor<32x32xf32>)
    %40 = "arith.addi"(%28, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %41 = "arith.index_cast"(%arg3) : (i32) -> index
    %42 = "arith.minsi"(%40, %41) : (index, index) -> index
    %43 = "arith.maxsi"(%42, %28) : (index, index) -> index
    %44 = "arith.subi"(%43, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %45 = "arith.addi"(%30, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %46 = "arith.minsi"(%45, %4) : (index, index) -> index
    %47 = "arith.maxsi"(%46, %30) : (index, index) -> index
    %48 = "arith.subi"(%47, %30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %49 = "arith.minsi"(%44, %5) : (index, index) -> index
    %50 = "arith.minsi"(%48, %5) : (index, index) -> index
    %51 = "arith.addi"(%20, %28) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %52 = "tensor.extract_slice"(%39#2, %49, %50) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<32x32xf32>, index, index) -> tensor<?x?xf32>
    %53 = "memref.subview"(%35, %51, %30, %49, %50) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<1099511627776x1099511627776xf32, strided<[1, 1]>>, index, index, index, index) -> memref<?x?xf32, strided<[1, 1], offset: ?>>
    "bufferization.materialize_in_destination"(%52, %53) <{writable}> : (tensor<?x?xf32>, memref<?x?xf32, strided<[1, 1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

