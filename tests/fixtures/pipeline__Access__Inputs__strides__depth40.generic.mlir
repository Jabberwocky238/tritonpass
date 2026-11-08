"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, i32, i32, i32, i32) -> (), sym_name = "k"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %2 = "arith.index_cast"(%1) : (index) -> i32
    %3 = "arith.muli"(%2, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "arith.addi"(%3, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %5 = "arith.muli"(%4, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "arith.addi"(%5, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %7 = "arith.muli"(%6, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %8 = "arith.addi"(%7, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %9 = "arith.muli"(%8, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %10 = "arith.addi"(%9, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %11 = "arith.muli"(%10, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %12 = "arith.addi"(%11, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %13 = "arith.muli"(%12, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %14 = "arith.addi"(%13, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %15 = "arith.muli"(%14, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %16 = "arith.addi"(%15, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %17 = "arith.muli"(%16, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %18 = "arith.addi"(%17, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %19 = "arith.muli"(%18, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %20 = "arith.addi"(%19, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %21 = "arith.muli"(%20, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %22 = "arith.addi"(%21, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %23 = "arith.muli"(%22, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %24 = "arith.addi"(%23, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %25 = "arith.muli"(%24, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %26 = "arith.addi"(%25, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %27 = "arith.muli"(%26, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %28 = "arith.addi"(%27, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %29 = "arith.muli"(%28, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %30 = "arith.addi"(%29, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %31 = "arith.muli"(%30, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %32 = "arith.addi"(%31, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %33 = "arith.muli"(%32, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %34 = "arith.addi"(%33, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %35 = "arith.muli"(%34, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %36 = "arith.addi"(%35, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %37 = "arith.muli"(%36, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %38 = "arith.addi"(%37, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %39 = "arith.muli"(%38, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %40 = "arith.addi"(%39, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %41 = "arith.muli"(%40, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %42 = "arith.addi"(%41, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %43 = "arith.muli"(%42, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %44 = "arith.addi"(%43, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %45 = "arith.muli"(%44, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %46 = "arith.addi"(%45, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %47 = "arith.muli"(%46, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %48 = "arith.addi"(%47, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %49 = "arith.muli"(%48, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %50 = "arith.addi"(%49, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %51 = "arith.muli"(%50, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %52 = "arith.addi"(%51, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %53 = "arith.muli"(%52, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %54 = "arith.addi"(%53, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %55 = "arith.muli"(%54, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %56 = "arith.addi"(%55, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %57 = "arith.muli"(%56, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %58 = "arith.addi"(%57, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %59 = "arith.muli"(%58, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %60 = "arith.addi"(%59, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %61 = "arith.muli"(%60, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %62 = "arith.addi"(%61, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %63 = "arith.muli"(%62, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %64 = "arith.addi"(%63, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %65 = "arith.muli"(%64, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %66 = "arith.addi"(%65, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %67 = "arith.muli"(%66, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %68 = "arith.addi"(%67, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %69 = "arith.muli"(%68, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %70 = "arith.addi"(%69, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %71 = "arith.muli"(%70, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %72 = "arith.addi"(%71, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %73 = "arith.muli"(%72, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %74 = "arith.addi"(%73, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %75 = "arith.muli"(%74, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %76 = "arith.addi"(%75, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %77 = "arith.muli"(%76, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %78 = "arith.addi"(%77, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %79 = "arith.muli"(%78, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %80 = "arith.addi"(%79, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %81 = "arith.muli"(%80, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %82 = "arith.addi"(%81, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %83 = "arith.muli"(%82, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %84 = "arith.addi"(%83, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %85 = "arith.index_cast"(%84) : (i32) -> index
    %86 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %87 = "arith.index_cast"(%86) : (i32) -> index
    %88 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32xf32>
    %89 = "memref.subview"(%arg0, %85) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 32>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<32xf32, strided<[1], offset: ?>>
    "linalg.copy"(%89, %88) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (memref<32xf32, strided<[1], offset: ?>>, memref<32xf32>) -> ()
    %90 = "bufferization.to_tensor"(%88) <{restrict, writable}> : (memref<32xf32>) -> tensor<32xf32>
    %91 = "memref.subview"(%arg1, %87) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 32>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<32xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%90, %91) <{writable}> : (tensor<32xf32>, memref<32xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

