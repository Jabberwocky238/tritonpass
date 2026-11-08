#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, memref<?xi64>, memref<?xi64>, memref<?xi32>, memref<?xi32>, memref<?xi32>, memref<?xi32>, i32, memref<?xi32>, memref<?xi64>) -> (), sym_name = "_combine_sampled_and_draft_tokens_kernel"}> ({
  ^bb0(%arg0: memref<?xi32>, %arg1: memref<?xi64>, %arg2: memref<?xi64>, %arg3: memref<?xi32>, %arg4: memref<?xi32>, %arg5: memref<?xi32>, %arg6: memref<?xi32>, %arg7: i32, %arg8: memref<?xi32>, %arg9: memref<?xi64>):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "builtin.unrealized_conversion_cast"(%arg9) : (memref<?xi64>) -> !tt.ptr<i64>
    %3 = "builtin.unrealized_conversion_cast"(%arg6) : (memref<?xi32>) -> !tt.ptr<i32>
    %4 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xi32>) -> !tt.ptr<i32>
    %5 = "tensor.empty"() : () -> tensor<1xi32>
    %6 = "linalg.fill"(%0, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg32: i32, %arg33: i32):
      "linalg.yield"(%arg32) : (i32) -> ()
    }) : (i32, tensor<1xi32>) -> tensor<1xi32>
    %7 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %8 = "arith.index_cast"(%7) : (index) -> i32
    %9 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
    %10 = "memref.load"(%9, %7) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
    %11 = "memref.reinterpret_cast"(%arg8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %12 = "memref.load"(%11, %7) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %13 = "arith.addi"(%8, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %14 = "arith.index_cast"(%13) : (i32) -> index
    %15 = "memref.load"(%11, %14) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %16 = "arith.subi"(%15, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %17 = "arith.subi"(%16, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %18 = "memref.reinterpret_cast"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %19 = "memref.load"(%18, %14) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %20 = "arith.subi"(%19, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %21 = "linalg.fill"(%16, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: i32, %arg31: i32):
      "linalg.yield"(%arg30) : (i32) -> ()
    }) : (i32, tensor<1xi32>) -> tensor<1xi32>
    %22 = "tensor.empty"() : () -> tensor<1xi1>
    %23 = "linalg.generic"(%21, %6, %22) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg27: i32, %arg28: i32, %arg29: i1):
      %54 = "arith.cmpi"(%arg27, %arg28) <{predicate = 4 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%54) : (i1) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi1>) -> tensor<1xi1>
    %24 = "linalg.fill"(%12, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: i32, %arg26: i32):
      "linalg.yield"(%arg25) : (i32) -> ()
    }) : (i32, tensor<1xi32>) -> tensor<1xi32>
    %25 = "linalg.fill"(%20, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg23: i32, %arg24: i32):
      "linalg.yield"(%arg23) : (i32) -> ()
    }) : (i32, tensor<1xi32>) -> tensor<1xi32>
    %26 = "tensor.empty"() : () -> tensor<1xi64>
    %27 = "linalg.generic"(%25, %26) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i64):
      %53 = "arith.extsi"(%arg21) : (i32) -> i64
      "linalg.yield"(%53) : (i64) -> ()
    }) : (tensor<1xi32>, tensor<1xi64>) -> tensor<1xi64>
    "tts.scatter"(%2, %24, %27, %23) : (!tt.ptr<i64>, tensor<1xi32>, tensor<1xi64>, tensor<1xi1>) -> ()
    %28 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %29 = "memref.load"(%28, %7) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %30 = "arith.index_cast"(%10) : (i64) -> index
    %31 = "memref.reinterpret_cast"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %32 = "memref.load"(%31, %30) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %33 = "arith.cmpi"(%29, %32) <{predicate = 3 : i64}> : (i32, i32) -> i1
    "cf.cond_br"(%33)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    %34 = "arith.subi"(%29, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %35 = "arith.cmpi"(%34, %32) <{predicate = 5 : i64}> : (i32, i32) -> i1
    "scf.if"(%35) ({
      %47 = "memref.reinterpret_cast"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
      %48 = "memref.load"(%47, %30) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
      %49 = "arith.trunci"(%48) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      %50 = "arith.index_cast"(%20) : (i32) -> index
      %51 = "linalg.fill"(%49, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg19: i32, %arg20: i32):
        "linalg.yield"(%arg19) : (i32) -> ()
      }) : (i32, tensor<1xi32>) -> tensor<1xi32>
      %52 = "memref.subview"(%arg0, %50) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi32>, index) -> memref<1xi32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%51, %52) <{writable}> : (tensor<1xi32>, memref<1xi32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    %36 = "arith.cmpi"(%17, %0) <{predicate = 4 : i64}> : (i32, i32) -> i1
    "scf.if"(%36) ({
      %37 = "linalg.fill"(%17, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg17: i32, %arg18: i32):
        "linalg.yield"(%arg17) : (i32) -> ()
      }) : (i32, tensor<1xi32>) -> tensor<1xi32>
      %38 = "linalg.generic"(%37, %6, %22) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg14: i32, %arg15: i32, %arg16: i1):
        %46 = "arith.cmpi"(%arg14, %arg15) <{predicate = 4 : i64}> : (i32, i32) -> i1
        "linalg.yield"(%46) : (i1) -> ()
      }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi1>) -> tensor<1xi1>
      %39 = "arith.extsi"(%arg7) : (i32) -> i64
      %40 = "arith.muli"(%10, %39) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %41 = "linalg.fill"(%40, %26) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg12: i64, %arg13: i64):
        "linalg.yield"(%arg12) : (i64) -> ()
      }) : (i64, tensor<1xi64>) -> tensor<1xi64>
      %42 = "tts.gather"(%3, %41, %38) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (!tt.ptr<i32>, tensor<1xi64>, tensor<1xi1>) -> tensor<1xi32>
      %43 = "arith.subi"(%1, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %44 = "arith.addi"(%19, %43) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %45 = "linalg.fill"(%44, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg10: i32, %arg11: i32):
        "linalg.yield"(%arg10) : (i32) -> ()
      }) : (i32, tensor<1xi32>) -> tensor<1xi32>
      "tts.scatter"(%4, %45, %42, %38) : (!tt.ptr<i32>, tensor<1xi32>, tensor<1xi32>, tensor<1xi1>) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

