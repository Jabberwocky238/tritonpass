#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, memref<?xi32>, i32, i32, memref<?xi64>, memref<?xi32>, memref<?xi32>, i32, memref<?xi32>, memref<?xi32>) -> (), sym_name = "_prepare_prefill_inputs_kernel"}> ({
  ^bb0(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: i32, %arg3: i32, %arg4: memref<?xi64>, %arg5: memref<?xi32>, %arg6: memref<?xi32>, %arg7: i32, %arg8: memref<?xi32>, %arg9: memref<?xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "builtin.unrealized_conversion_cast"(%arg6) : (memref<?xi32>) -> !tt.ptr<i32>
    %5 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<?xi32>) -> !tt.ptr<i32>
    %6 = "tensor.empty"() : () -> tensor<1xi32>
    %7 = "linalg.fill"(%2, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg39: i32, %arg40: i32):
      "linalg.yield"(%arg39) : (i32) -> ()
    }) : (i32, tensor<1xi32>) -> tensor<1xi32>
    %8 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %9 = "arith.index_cast"(%8) : (index) -> i32
    %10 = "memref.reinterpret_cast"(%arg4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
    %11 = "memref.load"(%10, %8) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
    %12 = "arith.index_cast"(%11) : (i64) -> index
    %13 = "memref.reinterpret_cast"(%arg8) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %14 = "memref.load"(%13, %12) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %15 = "memref.reinterpret_cast"(%arg9) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %16 = "memref.load"(%15, %12) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %17 = "arith.index_cast"(%16) : (i32) -> index
    %18 = "arith.cmpi"(%16, %14) <{predicate = 5 : i64}> : (i32, i32) -> i1
    "cf.cond_br"(%18)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    %19 = "memref.reinterpret_cast"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %20 = "memref.load"(%19, %8) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %21 = "arith.index_cast"(%20) : (i32) -> index
    %22 = "arith.addi"(%9, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %23 = "arith.index_cast"(%22) : (i32) -> index
    %24 = "memref.load"(%19, %23) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %25 = "arith.subi"(%24, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %26 = "arith.extsi"(%arg7) : (i32) -> i64
    %27 = "arith.muli"(%11, %26) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %28 = "arith.index_cast"(%27) : (i64) -> index
    %29 = "arith.index_cast"(%25) : (i32) -> index
    "scf.for"(%0, %29, %1) ({
    ^bb0(%arg34: index):
      %49 = "arith.addi"(%arg34, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %50 = "arith.minsi"(%49, %29) : (index, index) -> index
      %51 = "arith.maxsi"(%50, %arg34) : (index, index) -> index
      %52 = "arith.subi"(%51, %arg34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %53 = "arith.addi"(%28, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %54 = "arith.addi"(%53, %arg34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %55 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xi32>
      "linalg.fill"(%2, %55) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg37: i32, %arg38: i32):
        "linalg.yield"(%arg37) : (i32) -> ()
      }) : (i32, memref<1024xi32>) -> ()
      %56 = "memref.subview"(%arg6, %54, %52) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
      %57 = "memref.subview"(%55, %52) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xi32>, index) -> memref<?xi32, strided<[1]>>
      "linalg.copy"(%56, %57) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg35: i32, %arg36: i32):
        "linalg.yield"(%arg35) : (i32) -> ()
      }) : (memref<?xi32, strided<[1], offset: ?>>, memref<?xi32, strided<[1]>>) -> ()
      %58 = "bufferization.to_tensor"(%55) <{restrict, writable}> : (memref<1024xi32>) -> tensor<1024xi32>
      %59 = "arith.addi"(%21, %arg34) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %60 = "tensor.extract_slice"(%58, %52) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<1024xi32>, index) -> tensor<?xi32>
      %61 = "memref.subview"(%arg0, %59, %52) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xi32>, index, index) -> memref<?xi32, strided<[1], offset: ?>>
      "bufferization.materialize_in_destination"(%60, %61) <{writable}> : (tensor<?xi32>, memref<?xi32, strided<[1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %30 = "arith.addi"(%16, %25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %31 = "linalg.fill"(%30, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg32: i32, %arg33: i32):
      "linalg.yield"(%arg32) : (i32) -> ()
    }) : (i32, tensor<1xi32>) -> tensor<1xi32>
    %32 = "linalg.fill"(%arg3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg30: i32, %arg31: i32):
      "linalg.yield"(%arg30) : (i32) -> ()
    }) : (i32, tensor<1xi32>) -> tensor<1xi32>
    %33 = "tensor.empty"() : () -> tensor<1xi1>
    %34 = "linalg.generic"(%32, %7, %33) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg27: i32, %arg28: i32, %arg29: i1):
      %48 = "arith.cmpi"(%arg27, %arg28) <{predicate = 4 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%48) : (i1) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi1>) -> tensor<1xi1>
    %35 = "linalg.fill"(%14, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg25: i32, %arg26: i32):
      "linalg.yield"(%arg25) : (i32) -> ()
    }) : (i32, tensor<1xi32>) -> tensor<1xi32>
    %36 = "linalg.generic"(%31, %35, %33) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg22: i32, %arg23: i32, %arg24: i1):
      %47 = "arith.cmpi"(%arg22, %arg23) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%47) : (i1) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi1>) -> tensor<1xi1>
    %37 = "linalg.generic"(%34, %36, %34) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg19: i1, %arg20: i1, %arg21: i1):
      %46 = "arith.andi"(%arg19, %arg20) : (i1, i1) -> i1
      "linalg.yield"(%46) : (i1) -> ()
    }) : (tensor<1xi1>, tensor<1xi1>, tensor<1xi1>) -> tensor<1xi1>
    %38 = "tensor.empty"() : () -> tensor<1xi64>
    %39 = "linalg.fill"(%27, %38) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: i64, %arg18: i64):
      "linalg.yield"(%arg17) : (i64) -> ()
    }) : (i64, tensor<1xi64>) -> tensor<1xi64>
    %40 = "linalg.generic"(%31, %38) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i64):
      %45 = "arith.extsi"(%arg15) : (i32) -> i64
      "linalg.yield"(%45) : (i64) -> ()
    }) : (tensor<1xi32>, tensor<1xi64>) -> tensor<1xi64>
    %41 = "linalg.generic"(%39, %40, %39) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg12: i64, %arg13: i64, %arg14: i64):
      %44 = "arith.addi"(%arg12, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      "linalg.yield"(%44) : (i64) -> ()
    }) : (tensor<1xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %42 = "tts.gather"(%4, %41, %37, %2) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (!tt.ptr<i32>, tensor<1xi64>, tensor<1xi1>, i32) -> tensor<1xi32>
    %43 = "linalg.fill"(%11, %38) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: i64, %arg11: i64):
      "linalg.yield"(%arg10) : (i64) -> ()
    }) : (i64, tensor<1xi64>) -> tensor<1xi64>
    "tts.scatter"(%5, %43, %42, %34) : (!tt.ptr<i32>, tensor<1xi64>, tensor<1xi32>, tensor<1xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

