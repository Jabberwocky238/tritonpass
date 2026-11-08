#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi64>, memref<?xi32>, memref<?xi64>, memref<?xi32>, memref<?xi32>, i32) -> (), sym_name = "_prepare_pos_seq_lens_kernel"}> ({
  ^bb0(%arg0: memref<?xi64>, %arg1: memref<?xi32>, %arg2: memref<?xi64>, %arg3: memref<?xi32>, %arg4: memref<?xi32>, %arg5: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "tensor.empty"() : () -> tensor<1024xi32>
    %5 = "linalg.fill"(%0, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %6 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %7 = "arith.index_cast"(%6) : (index) -> i32
    %8 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
    %9 = "arith.index_cast"(%8) : (index) -> i32
    %10 = "arith.subi"(%9, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %11 = "arith.cmpi"(%7, %10) <{predicate = 0 : i64}> : (i32, i32) -> i1
    "cf.cond_br"(%11)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %12 = "arith.index_cast"(%10) : (i32) -> index
    %13 = "arith.index_cast"(%arg5) : (i32) -> index
    "scf.for"(%12, %13, %1) ({
    ^bb0(%arg22: index):
      %51 = "arith.addi"(%arg22, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %52 = "arith.minsi"(%51, %13) : (index, index) -> index
      %53 = "arith.maxsi"(%52, %arg22) : (index, index) -> index
      %54 = "arith.subi"(%53, %arg22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %55 = "tensor.extract_slice"(%5, %54) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xi32>, index) -> tensor<?xi32>
      %56 = "memref.subview"(%arg1, %arg22, %54) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%55, %56) <{writable}> : (tensor<?xi32>, memref<?xi32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    %14 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
    %15 = "memref.load"(%14, %6) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
    %16 = "arith.index_cast"(%15) : (i64) -> index
    %17 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %18 = "memref.load"(%17, %16) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %19 = "memref.reinterpret_cast"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %20 = "memref.load"(%19, %6) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %21 = "arith.index_cast"(%20) : (i32) -> index
    %22 = "arith.addi"(%7, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %23 = "arith.index_cast"(%22) : (i32) -> index
    %24 = "memref.load"(%19, %23) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %25 = "arith.subi"(%24, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %26 = "arith.addi"(%18, %25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %27 = "tensor.empty"() : () -> tensor<1xi32>
    %28 = "linalg.fill"(%26, %27) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32):
      "linalg.yield"(%arg20) : (i32) -> ()
    }) : (i32, tensor<1xi32>) -> tensor<1xi32>
    %29 = "memref.subview"(%arg1, %6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%28, %29) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1], offset: ?>>) -> ()
    %30 = "arith.index_cast"(%25) : (i32) -> index
    "scf.for"(%2, %30, %1) ({
    ^bb0(%arg6: index):
      %31 = "arith.index_cast"(%arg6) : (index) -> i32
      %32 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
      ^bb0(%arg19: i32):
        %49 = "linalg.index"() <{dim = 0 : i64}> : () -> index
        %50 = "arith.index_cast"(%49) : (index) -> i32
        "linalg.yield"(%50) : (i32) -> ()
      }) : (tensor<1024xi32>) -> tensor<1024xi32>
      %33 = "linalg.fill"(%31, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg17: i32, %arg18: i32):
        "linalg.yield"(%arg17) : (i32) -> ()
      }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
      %34 = "linalg.generic"(%33, %32, %33) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg14: i32, %arg15: i32, %arg16: i32):
        %48 = "arith.addi"(%arg14, %arg15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%48) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %35 = "linalg.fill"(%18, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg12: i32, %arg13: i32):
        "linalg.yield"(%arg12) : (i32) -> ()
      }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
      %36 = "linalg.generic"(%35, %34, %35) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg9: i32, %arg10: i32, %arg11: i32):
        %47 = "arith.addi"(%arg9, %arg10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%47) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %37 = "tensor.empty"() : () -> tensor<1024xi64>
      %38 = "linalg.generic"(%36, %37) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg7: i32, %arg8: i64):
        %46 = "arith.extsi"(%arg7) : (i32) -> i64
        "linalg.yield"(%46) : (i64) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi64>) -> tensor<1024xi64>
      %39 = "arith.addi"(%arg6, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %40 = "arith.minsi"(%39, %30) : (index, index) -> index
      %41 = "arith.maxsi"(%40, %arg6) : (index, index) -> index
      %42 = "arith.subi"(%41, %arg6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %43 = "arith.addi"(%21, %arg6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %44 = "tensor.extract_slice"(%38, %42) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xi64>, index) -> tensor<?xi64>
      %45 = "memref.subview"(%arg0, %43, %42) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi64>, index, index) -> memref<?xi64, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%44, %45) <{writable}> : (tensor<?xi64>, memref<?xi64, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

