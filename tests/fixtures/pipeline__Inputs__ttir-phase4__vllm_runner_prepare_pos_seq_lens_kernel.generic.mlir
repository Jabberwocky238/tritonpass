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
    "scf.if"(%11) ({
      %49 = "arith.index_cast"(%10) : (i32) -> index
      %50 = "arith.index_cast"(%arg5) : (i32) -> index
      "scf.for"(%49, %50, %1) ({
      ^bb0(%arg22: index):
        %51 = "arith.addi"(%arg22, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %52 = "arith.minsi"(%51, %50) : (index, index) -> index
        %53 = "arith.maxsi"(%52, %arg22) : (index, index) -> index
        %54 = "arith.subi"(%53, %arg22) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %55 = "tensor.extract_slice"(%5, %54) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xi32>, index) -> tensor<?xi32>
        %56 = "memref.subview"(%arg1, %arg22, %54) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
        "bufferization.materialize_in_destination"(%55, %56) <{writable}> : (tensor<?xi32>, memref<?xi32, strided<[1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }, {
      %12 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
      %13 = "memref.load"(%12, %6) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
      %14 = "arith.index_cast"(%13) : (i64) -> index
      %15 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
      %16 = "memref.load"(%15, %14) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
      %17 = "memref.reinterpret_cast"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
      %18 = "memref.load"(%17, %6) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
      %19 = "arith.index_cast"(%18) : (i32) -> index
      %20 = "arith.addi"(%7, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %21 = "arith.index_cast"(%20) : (i32) -> index
      %22 = "memref.load"(%17, %21) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
      %23 = "arith.subi"(%22, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %24 = "arith.addi"(%16, %23) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %25 = "tensor.empty"() : () -> tensor<1xi32>
      %26 = "linalg.fill"(%24, %25) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg20: i32, %arg21: i32):
        "linalg.yield"(%arg20) : (i32) -> ()
      }) : (i32, tensor<1xi32>) -> tensor<1xi32>
      %27 = "memref.subview"(%arg1, %6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%26, %27) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1], offset: ?>>) -> ()
      %28 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
      ^bb0(%arg19: i32):
        %47 = "linalg.index"() <{dim = 0 : i64}> : () -> index
        %48 = "arith.index_cast"(%47) : (index) -> i32
        "linalg.yield"(%48) : (i32) -> ()
      }) : (tensor<1024xi32>) -> tensor<1024xi32>
      %29 = "linalg.fill"(%16, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg17: i32, %arg18: i32):
        "linalg.yield"(%arg17) : (i32) -> ()
      }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
      %30 = "arith.index_cast"(%23) : (i32) -> index
      "scf.for"(%2, %30, %1) ({
      ^bb0(%arg6: index):
        %31 = "arith.index_cast"(%arg6) : (index) -> i32
        %32 = "linalg.fill"(%31, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg15: i32, %arg16: i32):
          "linalg.yield"(%arg15) : (i32) -> ()
        }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
        %33 = "linalg.generic"(%32, %28, %32) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg12: i32, %arg13: i32, %arg14: i32):
          %46 = "arith.addi"(%arg12, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%46) : (i32) -> ()
        }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
        %34 = "linalg.generic"(%29, %33, %29) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg9: i32, %arg10: i32, %arg11: i32):
          %45 = "arith.addi"(%arg9, %arg10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "linalg.yield"(%45) : (i32) -> ()
        }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
        %35 = "tensor.empty"() : () -> tensor<1024xi64>
        %36 = "linalg.generic"(%34, %35) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg7: i32, %arg8: i64):
          %44 = "arith.extsi"(%arg7) : (i32) -> i64
          "linalg.yield"(%44) : (i64) -> ()
        }) : (tensor<1024xi32>, tensor<1024xi64>) -> tensor<1024xi64>
        %37 = "arith.addi"(%arg6, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %38 = "arith.minsi"(%37, %30) : (index, index) -> index
        %39 = "arith.maxsi"(%38, %arg6) : (index, index) -> index
        %40 = "arith.subi"(%39, %arg6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %41 = "arith.addi"(%19, %arg6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %42 = "tensor.extract_slice"(%36, %40) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xi64>, index) -> tensor<?xi64>
        %43 = "memref.subview"(%arg0, %41, %40) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi64>, index, index) -> memref<?xi64, strided<[1], offset: ?>>
        "bufferization.materialize_in_destination"(%42, %43) <{writable}> : (tensor<?xi64>, memref<?xi64, strided<[1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

