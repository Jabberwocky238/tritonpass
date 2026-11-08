#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xi64>, i32) -> (), sym_name = "argmax_kernel_inner"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xi64>, %arg2: i32):
    %0 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 4096 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 4096 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %7 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %8 = "arith.index_cast"(%7) : (index) -> i32
    %9 = "arith.extsi"(%8) : (i32) -> i64
    %10 = "arith.divsi"(%arg2, %1) : (i32, i32) -> i32
    %11 = "arith.remsi"(%arg2, %1) : (i32, i32) -> i32
    %12 = "tensor.empty"() : () -> tensor<4096xi32>
    %13 = "linalg.generic"(%12) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg30: i32):
      %79 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %80 = "arith.index_cast"(%79) : (index) -> i32
      "linalg.yield"(%80) : (i32) -> ()
    }) : (tensor<4096xi32>) -> tensor<4096xi32>
    %14 = "arith.extsi"(%arg2) : (i32) -> i64
    %15 = "arith.muli"(%9, %14) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %16 = "arith.index_cast"(%15) : (i64) -> index
    %17 = "arith.index_cast"(%10) : (i32) -> index
    %18:2 = "scf.for"(%2, %17, %3, %0, %5) ({
    ^bb0(%arg17: index, %arg18: f32, %arg19: i32):
      %54 = "arith.index_cast"(%arg17) : (index) -> i32
      %55 = "arith.muli"(%54, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %56 = "arith.index_cast"(%55) : (i32) -> index
      %57 = "arith.addi"(%16, %56) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %58 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
      %59 = "memref.subview"(%arg0, %57) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4096>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<4096xf32, strided<[1], offset: ?>>
      "linalg.copy"(%59, %58) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg28: f32, %arg29: f32):
        "linalg.yield"(%arg28) : (f32) -> ()
      }) : (memref<4096xf32, strided<[1], offset: ?>>, memref<4096xf32>) -> ()
      %60 = "bufferization.to_tensor"(%58) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
      %61 = "tensor.empty"() : () -> tensor<f32>
      %62 = "linalg.fill"(%0, %61) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg26: f32, %arg27: f32):
        "linalg.yield"(%arg26) : (f32) -> ()
      }) : (f32, tensor<f32>) -> tensor<f32>
      %63 = "tensor.empty"() : () -> tensor<i32>
      %64 = "linalg.fill"(%6, %63) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg24: i32, %arg25: i32):
        "linalg.yield"(%arg24) : (i32) -> ()
      }) : (i32, tensor<i32>) -> tensor<i32>
      %65:2 = "linalg.reduce"(%60, %13, %62, %64) <{dimensions = array<i64: 0>}> ({
      ^bb0(%arg20: f32, %arg21: i32, %arg22: f32, %arg23: i32):
        %72 = "arith.cmpf"(%arg20, %arg22) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
        %73 = "arith.cmpi"(%arg21, %arg23) <{predicate = 2 : i64}> : (i32, i32) -> i1
        %74 = "arith.andi"(%72, %73) : (i1, i1) -> i1
        %75 = "arith.cmpf"(%arg20, %arg22) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
        %76 = "arith.ori"(%75, %74) : (i1, i1) -> i1
        %77 = "arith.select"(%76, %arg20, %arg22) : (i1, f32, f32) -> f32
        %78 = "arith.select"(%76, %arg21, %arg23) : (i1, i32, i32) -> i32
        "linalg.yield"(%77, %78) : (f32, i32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xi32>, tensor<f32>, tensor<i32>) -> (tensor<f32>, tensor<i32>)
      %66 = "tensor.extract"(%65#0) : (tensor<f32>) -> f32
      %67 = "tensor.extract"(%65#1) : (tensor<i32>) -> i32
      %68 = "arith.cmpf"(%66, %arg18) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      %69 = "arith.select"(%68, %66, %arg18) : (i1, f32, f32) -> f32
      %70 = "arith.addi"(%55, %67) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %71 = "arith.select"(%68, %70, %arg19) : (i1, i32, i32) -> i32
      "scf.yield"(%69, %71) : (f32, i32) -> ()
    }) : (index, index, index, f32, i32) -> (f32, i32)
    %19 = "arith.cmpi"(%11, %5) <{predicate = 1 : i64}> : (i32, i32) -> i1
    %20 = "scf.if"(%19) ({
      %25 = "arith.muli"(%10, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %26 = "arith.index_cast"(%25) : (i32) -> index
      %27 = "arith.addi"(%26, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %28 = "arith.index_cast"(%arg2) : (i32) -> index
      %29 = "arith.minsi"(%27, %28) : (index, index) -> index
      %30 = "arith.maxsi"(%29, %26) : (index, index) -> index
      %31 = "arith.subi"(%30, %26) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %32 = "arith.addi"(%16, %26) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %33 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
      "linalg.fill"(%0, %33) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg15: f32, %arg16: f32):
        "linalg.yield"(%arg15) : (f32) -> ()
      }) : (f32, memref<4096xf32>) -> ()
      %34 = "memref.subview"(%arg0, %32, %31) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
      %35 = "memref.subview"(%33, %31) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<4096xf32>, index) -> memref<?xf32, strided<[1]>>
      "linalg.copy"(%34, %35) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg13: f32, %arg14: f32):
        "linalg.yield"(%arg13) : (f32) -> ()
      }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
      %36 = "bufferization.to_tensor"(%33) <{restrict, writable}> : (memref<4096xf32>) -> tensor<4096xf32>
      %37 = "tensor.empty"() : () -> tensor<f32>
      %38 = "linalg.fill"(%0, %37) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg11: f32, %arg12: f32):
        "linalg.yield"(%arg11) : (f32) -> ()
      }) : (f32, tensor<f32>) -> tensor<f32>
      %39 = "tensor.empty"() : () -> tensor<i32>
      %40 = "linalg.fill"(%6, %39) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg9: i32, %arg10: i32):
        "linalg.yield"(%arg9) : (i32) -> ()
      }) : (i32, tensor<i32>) -> tensor<i32>
      %41:2 = "linalg.reduce"(%36, %13, %38, %40) <{dimensions = array<i64: 0>}> ({
      ^bb0(%arg5: f32, %arg6: i32, %arg7: f32, %arg8: i32):
        %47 = "arith.cmpf"(%arg5, %arg7) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
        %48 = "arith.cmpi"(%arg6, %arg8) <{predicate = 2 : i64}> : (i32, i32) -> i1
        %49 = "arith.andi"(%47, %48) : (i1, i1) -> i1
        %50 = "arith.cmpf"(%arg5, %arg7) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
        %51 = "arith.ori"(%50, %49) : (i1, i1) -> i1
        %52 = "arith.select"(%51, %arg5, %arg7) : (i1, f32, f32) -> f32
        %53 = "arith.select"(%51, %arg6, %arg8) : (i1, i32, i32) -> i32
        "linalg.yield"(%52, %53) : (f32, i32) -> ()
      }) : (tensor<4096xf32>, tensor<4096xi32>, tensor<f32>, tensor<i32>) -> (tensor<f32>, tensor<i32>)
      %42 = "tensor.extract"(%41#0) : (tensor<f32>) -> f32
      %43 = "tensor.extract"(%41#1) : (tensor<i32>) -> i32
      %44 = "arith.cmpf"(%42, %18#0) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      %45 = "arith.addi"(%25, %43) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %46 = "arith.select"(%44, %45, %18#1) : (i1, i32, i32) -> i32
      "scf.yield"(%46) : (i32) -> ()
    }, {
      "scf.yield"(%18#1) : (i32) -> ()
    }) : (i1) -> i32
    %21 = "arith.extsi"(%20) : (i32) -> i64
    %22 = "tensor.empty"() : () -> tensor<1xi64>
    %23 = "linalg.fill"(%21, %22) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: i64, %arg4: i64):
      "linalg.yield"(%arg3) : (i64) -> ()
    }) : (i64, tensor<1xi64>) -> tensor<1xi64>
    %24 = "memref.subview"(%arg1, %7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi64>, index) -> memref<1xi64, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%23, %24) <{writable}> : (tensor<1xi64>, memref<1xi64, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

