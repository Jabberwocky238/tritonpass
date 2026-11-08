#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xbf16>, memref<?xf32>, memref<?xi32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "_fwd_kernel_stage2"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xbf16>, %arg2: memref<?xf32>, %arg3: memref<?xi32>, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 8 : index}> : () -> index
    %5 = "arith.constant"() <{value = 1 : index}> : () -> index
    %6 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 128 : i32}> : () -> i32
    %8 = "tensor.empty"() : () -> tensor<128xf32>
    %9 = "linalg.fill"(%0, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg38: f32, %arg39: f32):
      "linalg.yield"(%arg38) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %10 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %11 = "arith.index_cast"(%10) : (index) -> i32
    %12 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %13 = "arith.index_cast"(%12) : (index) -> i32
    %14 = "memref.reinterpret_cast"(%arg3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi32>) -> memref<1099511627776xi32, strided<[1]>>
    %15 = "memref.load"(%14, %10) <{nontemporal = false}> : (memref<1099511627776xi32, strided<[1]>>, index) -> i32
    %16 = "arith.muli"(%11, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %17 = "arith.muli"(%13, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %18 = "arith.addi"(%16, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %19 = "arith.index_cast"(%18) : (i32) -> index
    %20 = "arith.addi"(%18, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %21 = "arith.addi"(%15, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %22 = "arith.divsi"(%21, %1) : (i32, i32) -> i32
    %23:3 = "scf.for"(%3, %4, %5, %0, %6, %9) ({
    ^bb0(%arg19: index, %arg20: f32, %arg21: f32, %arg22: tensor<128xf32>):
      %44 = "arith.index_cast"(%arg19) : (index) -> i32
      %45 = "arith.muli"(%22, %44) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %46 = "arith.addi"(%45, %22) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %47 = "arith.minsi"(%46, %15) : (i32, i32) -> i32
      %48 = "arith.cmpi"(%47, %45) <{predicate = 4 : i64}> : (i32, i32) -> i1
      %49:3 = "scf.if"(%48) ({
        %50 = "arith.muli"(%44, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %51 = "arith.index_cast"(%50) : (i32) -> index
        %52 = "arith.addi"(%19, %51) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %53 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32>
        %54 = "memref.subview"(%arg0, %52) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<128xf32, strided<[1], offset: ?>>
        "linalg.copy"(%54, %53) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg36: f32, %arg37: f32):
          "linalg.yield"(%arg36) : (f32) -> ()
        }) : (memref<128xf32, strided<[1], offset: ?>>, memref<128xf32>) -> ()
        %55 = "bufferization.to_tensor"(%53) <{restrict, writable}> : (memref<128xf32>) -> tensor<128xf32>
        %56 = "arith.addi"(%20, %50) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %57 = "arith.index_cast"(%56) : (i32) -> index
        %58 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xf32>) -> memref<1099511627776xf32, strided<[1]>>
        %59 = "memref.load"(%58, %57) <{nontemporal = false}> : (memref<1099511627776xf32, strided<[1]>>, index) -> f32
        %60 = "arith.maxnumf"(%59, %arg21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %61 = "arith.subf"(%arg21, %60) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %62 = "math.exp"(%61) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        %63 = "linalg.fill"(%62, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg34: f32, %arg35: f32):
          "linalg.yield"(%arg34) : (f32) -> ()
        }) : (f32, tensor<128xf32>) -> tensor<128xf32>
        %64 = "linalg.generic"(%arg22, %63, %arg22) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg31: f32, %arg32: f32, %arg33: f32):
          %74 = "arith.mulf"(%arg31, %arg32) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%74) : (f32) -> ()
        }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
        %65 = "arith.subf"(%59, %60) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %66 = "math.exp"(%65) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        %67 = "linalg.fill"(%66, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg29: f32, %arg30: f32):
          "linalg.yield"(%arg29) : (f32) -> ()
        }) : (f32, tensor<128xf32>) -> tensor<128xf32>
        %68 = "linalg.generic"(%67, %55, %67) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg26: f32, %arg27: f32, %arg28: f32):
          %73 = "arith.mulf"(%arg26, %arg27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%73) : (f32) -> ()
        }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
        %69 = "linalg.generic"(%64, %68, %64) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
        ^bb0(%arg23: f32, %arg24: f32, %arg25: f32):
          %72 = "arith.addf"(%arg23, %arg24) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "linalg.yield"(%72) : (f32) -> ()
        }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
        %70 = "arith.mulf"(%arg20, %62) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %71 = "arith.addf"(%70, %66) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "scf.yield"(%71, %60, %69) : (f32, f32, tensor<128xf32>) -> ()
      }, {
        "scf.yield"(%arg20, %arg21, %arg22) : (f32, f32, tensor<128xf32>) -> ()
      }) : (i1) -> (f32, f32, tensor<128xf32>)
      "scf.yield"(%49#0, %49#1, %49#2) : (f32, f32, tensor<128xf32>) -> ()
    }) : (index, index, index, f32, f32, tensor<128xf32>) -> (f32, f32, tensor<128xf32>)
    %24 = "linalg.fill"(%23#0, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: f32, %arg18: f32):
      "linalg.yield"(%arg17) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %25 = "linalg.generic"(%23#2, %24, %23#2) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32, %arg16: f32):
      %43 = "arith.divf"(%arg14, %arg15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%43) : (f32) -> ()
    }) : (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) -> tensor<128xf32>
    %26 = "arith.muli"(%11, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %27 = "arith.index_cast"(%26) : (i32) -> index
    %28 = "arith.muli"(%13, %arg8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %29 = "arith.index_cast"(%28) : (i32) -> index
    %30 = "tensor.empty"() : () -> tensor<128xbf16>
    %31 = "linalg.generic"(%25, %30) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: f32, %arg13: bf16):
      %42 = "arith.truncf"(%arg12) : (f32) -> bf16
      "linalg.yield"(%42) : (bf16) -> ()
    }) : (tensor<128xf32>, tensor<128xbf16>) -> tensor<128xbf16>
    %32 = "arith.addi"(%27, %29) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %33 = "memref.subview"(%arg1, %32) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<?xbf16>, index) -> memref<128xbf16, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%31, %33) <{writable}> : (tensor<128xbf16>, memref<128xbf16, strided<[1], offset: ?>>) -> ()
    %34 = "math.log"(%23#0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %35 = "arith.addf"(%23#1, %34) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %36 = "arith.muli"(%11, %arg9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %37 = "arith.index_cast"(%36) : (i32) -> index
    %38 = "tensor.empty"() : () -> tensor<1xf32>
    %39 = "linalg.fill"(%35, %38) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %40 = "arith.addi"(%37, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %41 = "memref.subview"(%arg2, %40) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%39, %41) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

