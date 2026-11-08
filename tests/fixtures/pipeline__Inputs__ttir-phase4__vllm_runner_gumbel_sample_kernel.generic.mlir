#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi64>, i32, memref<?xf32>, i32, i32, i32, i32, memref<?xf32>, i32, memref<?xi64>, memref<?xi64>, memref<?xi64>, memref<?xf32>, i32) -> (), sym_name = "_gumbel_sample_kernel"}> ({
  ^bb0(%arg0: memref<?xi64>, %arg1: i32, %arg2: memref<?xf32>, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: memref<?xf32>, %arg8: i32, %arg9: memref<?xi64>, %arg10: memref<?xi64>, %arg11: memref<?xi64>, %arg12: memref<?xf32>, %arg13: i32):
    %0 = "arith.constant"() <{value = 1.250000e-01 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %5 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 0.142857149 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 0.166666672 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = 2.000000e-01 : f32}> : () -> f32
    %9 = "arith.constant"() <{value = 2.500000e-01 : f32}> : () -> f32
    %10 = "arith.constant"() <{value = 0.333333343 : f32}> : () -> f32
    %11 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %12 = "arith.constant"() <{value = 5.96046448E-8 : f32}> : () -> f32
    %13 = "arith.constant"() <{value = 4294967295 : i64}> : () -> i64
    %14 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %15 = "arith.constant"() <{value = 13 : i32}> : () -> i32
    %16 = "arith.constant"() <{value = 19 : i32}> : () -> i32
    %17 = "arith.constant"() <{value = 15 : i32}> : () -> i32
    %18 = "arith.constant"() <{value = 17 : i32}> : () -> i32
    %19 = "arith.constant"() <{value = -430675100 : i32}> : () -> i32
    %20 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %21 = "arith.constant"() <{value = 461845907 : i32}> : () -> i32
    %22 = "arith.constant"() <{value = -862048943 : i32}> : () -> i32
    %23 = "arith.constant"() <{value = -1028477387 : i32}> : () -> i32
    %24 = "arith.constant"() <{value = -2048144789 : i32}> : () -> i32
    %25 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %26 = "arith.constant"() <{value = 65535 : i32}> : () -> i32
    %27 = "arith.constant"() <{value = 1.52587891E-5 : f32}> : () -> f32
    %28 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    %29 = "arith.constant"() <{value = 2.32830644E-10 : f32}> : () -> f32
    %30 = "arith.constant"() <{value = 1024 : i32}> : () -> i32
    %31 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %32 = "builtin.unrealized_conversion_cast"(%arg12) : (memref<?xf32>) -> !tt.ptr<f32>
    %33 = "builtin.unrealized_conversion_cast"(%arg10) : (memref<?xi64>) -> !tt.ptr<i64>
    %34 = "tensor.empty"() : () -> tensor<1024xf32>
    %35 = "linalg.fill"(%0, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg256: f32, %arg257: f32):
      "linalg.yield"(%arg256) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %36 = "linalg.fill"(%6, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg254: f32, %arg255: f32):
      "linalg.yield"(%arg254) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %37 = "linalg.fill"(%7, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg252: f32, %arg253: f32):
      "linalg.yield"(%arg252) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %38 = "linalg.fill"(%8, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg250: f32, %arg251: f32):
      "linalg.yield"(%arg250) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %39 = "linalg.fill"(%9, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg248: f32, %arg249: f32):
      "linalg.yield"(%arg248) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %40 = "linalg.fill"(%10, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg246: f32, %arg247: f32):
      "linalg.yield"(%arg246) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %41 = "linalg.fill"(%11, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg244: f32, %arg245: f32):
      "linalg.yield"(%arg244) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %42 = "linalg.fill"(%12, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg242: f32, %arg243: f32):
      "linalg.yield"(%arg242) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %43 = "tensor.empty"() : () -> tensor<1024xi32>
    %44 = "linalg.fill"(%15, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg240: i32, %arg241: i32):
      "linalg.yield"(%arg240) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %45 = "linalg.fill"(%16, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg238: i32, %arg239: i32):
      "linalg.yield"(%arg238) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %46 = "linalg.fill"(%17, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg236: i32, %arg237: i32):
      "linalg.yield"(%arg236) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %47 = "linalg.fill"(%18, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg234: i32, %arg235: i32):
      "linalg.yield"(%arg234) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %48 = "linalg.fill"(%19, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg232: i32, %arg233: i32):
      "linalg.yield"(%arg232) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %49 = "linalg.fill"(%20, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg230: i32, %arg231: i32):
      "linalg.yield"(%arg230) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %50 = "linalg.fill"(%21, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg228: i32, %arg229: i32):
      "linalg.yield"(%arg228) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %51 = "linalg.fill"(%22, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg226: i32, %arg227: i32):
      "linalg.yield"(%arg226) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %52 = "linalg.fill"(%23, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg224: i32, %arg225: i32):
      "linalg.yield"(%arg224) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %53 = "linalg.fill"(%24, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg222: i32, %arg223: i32):
      "linalg.yield"(%arg222) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %54 = "linalg.fill"(%25, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg220: i32, %arg221: i32):
      "linalg.yield"(%arg220) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %55 = "linalg.fill"(%26, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg218: i32, %arg219: i32):
      "linalg.yield"(%arg218) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %56 = "linalg.fill"(%27, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg216: f32, %arg217: f32):
      "linalg.yield"(%arg216) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %57 = "linalg.fill"(%28, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg214: f32, %arg215: f32):
      "linalg.yield"(%arg214) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %58 = "linalg.fill"(%29, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg212: f32, %arg213: f32):
      "linalg.yield"(%arg212) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %59 = "linalg.fill"(%2, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg210: f32, %arg211: f32):
      "linalg.yield"(%arg210) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %60 = "linalg.fill"(%4, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg208: f32, %arg209: f32):
      "linalg.yield"(%arg208) : (f32) -> ()
    }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
    %61 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %62 = "arith.index_cast"(%61) : (index) -> i32
    %63 = "arith.extsi"(%62) : (i32) -> i64
    %64 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %65 = "arith.index_cast"(%64) : (index) -> i32
    %66 = "arith.muli"(%65, %30) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %67 = "arith.index_cast"(%66) : (i32) -> index
    %68 = "linalg.generic"(%43) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg207: i32):
      %283 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %284 = "arith.index_cast"(%283) : (index) -> i32
      "linalg.yield"(%284) : (i32) -> ()
    }) : (tensor<1024xi32>) -> tensor<1024xi32>
    %69 = "linalg.fill"(%66, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg205: i32, %arg206: i32):
      "linalg.yield"(%arg205) : (i32) -> ()
    }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
    %70 = "linalg.generic"(%69, %68, %69) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg202: i32, %arg203: i32, %arg204: i32):
      %282 = "arith.addi"(%arg202, %arg203) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%282) : (i32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %71 = "arith.extsi"(%arg8) : (i32) -> i64
    %72 = "arith.muli"(%63, %71) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %73 = "arith.index_cast"(%72) : (i64) -> index
    %74 = "arith.addi"(%67, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %75 = "arith.index_cast"(%arg13) : (i32) -> index
    %76 = "arith.minsi"(%74, %75) : (index, index) -> index
    %77 = "arith.maxsi"(%76, %67) : (index, index) -> index
    %78 = "arith.subi"(%77, %67) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %79 = "arith.addi"(%73, %67) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %80 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xf32>
    "linalg.fill"(%4, %80) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg200: f32, %arg201: f32):
      "linalg.yield"(%arg200) : (f32) -> ()
    }) : (f32, memref<1024xf32>) -> ()
    %81 = "memref.subview"(%arg7, %79, %78) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<?xf32>, index, index) -> memref<?xf32, strided<[1], offset: ?>>
    %82 = "memref.subview"(%80, %78) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (memref<1024xf32>, index) -> memref<?xf32, strided<[1]>>
    "linalg.copy"(%81, %82) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg198: f32, %arg199: f32):
      "linalg.yield"(%arg198) : (f32) -> ()
    }) : (memref<?xf32, strided<[1], offset: ?>>, memref<?xf32, strided<[1]>>) -> ()
    %83 = "bufferization.to_tensor"(%80) <{restrict, writable}> : (memref<1024xf32>) -> tensor<1024xf32>
    %84 = "memref.reinterpret_cast"(%arg9) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
    %85 = "memref.load"(%84, %61) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
    %86 = "arith.cmpi"(%85, %1) <{predicate = 5 : i64}> : (i64, i64) -> i1
    %87 = "tts.gather"(%32, %85, %86, %2) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (!tt.ptr<f32>, i64, i1, f32) -> f32
    %88 = "tts.gather"(%33, %85, %86, %1) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (!tt.ptr<i64>, i64, i1, i64) -> i64
    %89 = "memref.reinterpret_cast"(%arg11) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1099511627776>, static_strides = array<i64: 1>}> : (memref<?xi64>) -> memref<1099511627776xi64, strided<[1]>>
    %90 = "memref.load"(%89, %61) <{nontemporal = false}> : (memref<1099511627776xi64, strided<[1]>>, index) -> i64
    %91 = "arith.cmpf"(%87, %2) <{fastmath = #arith.fastmath<none>, predicate = 13 : i64}> : (f32, f32) -> i1
    %92 = "scf.if"(%91) ({
      %123 = "arith.andi"(%88, %13) : (i64, i64) -> i64
      %124 = "arith.trunci"(%123) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      %125 = "arith.muli"(%124, %22) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %126 = "arith.shli"(%125, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %127 = "arith.shrui"(%125, %18) : (i32, i32) -> i32
      %128 = "arith.ori"(%126, %127) : (i32, i32) -> i32
      %129 = "arith.muli"(%128, %21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %130 = "arith.shli"(%129, %15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %131 = "arith.shrui"(%129, %16) : (i32, i32) -> i32
      %132 = "arith.ori"(%130, %131) : (i32, i32) -> i32
      %133 = "arith.muli"(%132, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %134 = "arith.addi"(%133, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %135 = "arith.shrsi"(%88, %14) : (i64, i64) -> i64
      %136 = "arith.andi"(%135, %13) : (i64, i64) -> i64
      %137 = "arith.trunci"(%136) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      %138 = "arith.muli"(%137, %22) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %139 = "arith.shli"(%138, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %140 = "arith.shrui"(%138, %18) : (i32, i32) -> i32
      %141 = "arith.ori"(%139, %140) : (i32, i32) -> i32
      %142 = "arith.muli"(%141, %21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %143 = "arith.xori"(%134, %142) : (i32, i32) -> i32
      %144 = "arith.shli"(%143, %15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %145 = "arith.shrui"(%143, %16) : (i32, i32) -> i32
      %146 = "arith.ori"(%144, %145) : (i32, i32) -> i32
      %147 = "arith.muli"(%146, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %148 = "arith.addi"(%147, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %149 = "arith.andi"(%90, %13) : (i64, i64) -> i64
      %150 = "arith.trunci"(%149) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      %151 = "arith.muli"(%150, %22) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %152 = "arith.shli"(%151, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %153 = "arith.shrui"(%151, %18) : (i32, i32) -> i32
      %154 = "arith.ori"(%152, %153) : (i32, i32) -> i32
      %155 = "arith.muli"(%154, %21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %156 = "arith.xori"(%148, %155) : (i32, i32) -> i32
      %157 = "arith.shli"(%156, %15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %158 = "arith.shrui"(%156, %16) : (i32, i32) -> i32
      %159 = "arith.ori"(%157, %158) : (i32, i32) -> i32
      %160 = "arith.muli"(%159, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %161 = "arith.addi"(%160, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %162 = "linalg.generic"(%70, %51, %70) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg195: i32, %arg196: i32, %arg197: i32):
        %281 = "arith.muli"(%arg195, %arg196) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%281) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %163 = "linalg.generic"(%162, %46, %162) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg192: i32, %arg193: i32, %arg194: i32):
        %280 = "arith.shli"(%arg192, %arg193) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%280) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %164 = "linalg.generic"(%162, %47, %162) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg189: i32, %arg190: i32, %arg191: i32):
        %279 = "arith.shrui"(%arg189, %arg190) : (i32, i32) -> i32
        "linalg.yield"(%279) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %165 = "linalg.generic"(%163, %164, %163) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg186: i32, %arg187: i32, %arg188: i32):
        %278 = "arith.ori"(%arg186, %arg187) : (i32, i32) -> i32
        "linalg.yield"(%278) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %166 = "linalg.generic"(%165, %50, %165) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg183: i32, %arg184: i32, %arg185: i32):
        %277 = "arith.muli"(%arg183, %arg184) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%277) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %167 = "linalg.fill"(%161, %43) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg181: i32, %arg182: i32):
        "linalg.yield"(%arg181) : (i32) -> ()
      }) : (i32, tensor<1024xi32>) -> tensor<1024xi32>
      %168 = "linalg.generic"(%167, %166, %167) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg178: i32, %arg179: i32, %arg180: i32):
        %276 = "arith.xori"(%arg178, %arg179) : (i32, i32) -> i32
        "linalg.yield"(%276) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %169 = "linalg.generic"(%168, %44, %168) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg175: i32, %arg176: i32, %arg177: i32):
        %275 = "arith.shli"(%arg175, %arg176) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%275) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %170 = "linalg.generic"(%168, %45, %168) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg172: i32, %arg173: i32, %arg174: i32):
        %274 = "arith.shrui"(%arg172, %arg173) : (i32, i32) -> i32
        "linalg.yield"(%274) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %171 = "linalg.generic"(%169, %170, %169) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg169: i32, %arg170: i32, %arg171: i32):
        %273 = "arith.ori"(%arg169, %arg170) : (i32, i32) -> i32
        "linalg.yield"(%273) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %172 = "linalg.generic"(%171, %49, %171) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg166: i32, %arg167: i32, %arg168: i32):
        %272 = "arith.muli"(%arg166, %arg167) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%272) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %173 = "linalg.generic"(%172, %48, %172) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg163: i32, %arg164: i32, %arg165: i32):
        %271 = "arith.addi"(%arg163, %arg164) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%271) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %174 = "linalg.generic"(%173, %54, %173) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg160: i32, %arg161: i32, %arg162: i32):
        %270 = "arith.xori"(%arg160, %arg161) : (i32, i32) -> i32
        "linalg.yield"(%270) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %175 = "linalg.generic"(%174, %54, %174) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg157: i32, %arg158: i32, %arg159: i32):
        %269 = "arith.shrui"(%arg157, %arg158) : (i32, i32) -> i32
        "linalg.yield"(%269) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %176 = "linalg.generic"(%174, %175, %174) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg154: i32, %arg155: i32, %arg156: i32):
        %268 = "arith.xori"(%arg154, %arg155) : (i32, i32) -> i32
        "linalg.yield"(%268) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %177 = "linalg.generic"(%176, %53, %176) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg151: i32, %arg152: i32, %arg153: i32):
        %267 = "arith.muli"(%arg151, %arg152) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%267) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %178 = "linalg.generic"(%177, %44, %177) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg148: i32, %arg149: i32, %arg150: i32):
        %266 = "arith.shrui"(%arg148, %arg149) : (i32, i32) -> i32
        "linalg.yield"(%266) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %179 = "linalg.generic"(%177, %178, %177) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg145: i32, %arg146: i32, %arg147: i32):
        %265 = "arith.xori"(%arg145, %arg146) : (i32, i32) -> i32
        "linalg.yield"(%265) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %180 = "linalg.generic"(%179, %52, %179) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg142: i32, %arg143: i32, %arg144: i32):
        %264 = "arith.muli"(%arg142, %arg143) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%264) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %181 = "linalg.generic"(%180, %54, %180) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg139: i32, %arg140: i32, %arg141: i32):
        %263 = "arith.shrui"(%arg139, %arg140) : (i32, i32) -> i32
        "linalg.yield"(%263) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %182 = "linalg.generic"(%180, %181, %180) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg136: i32, %arg137: i32, %arg138: i32):
        %262 = "arith.xori"(%arg136, %arg137) : (i32, i32) -> i32
        "linalg.yield"(%262) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %183 = "linalg.generic"(%182, %54, %182) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg133: i32, %arg134: i32, %arg135: i32):
        %261 = "arith.shrui"(%arg133, %arg134) : (i32, i32) -> i32
        "linalg.yield"(%261) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %184 = "linalg.generic"(%182, %55, %182) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg130: i32, %arg131: i32, %arg132: i32):
        %260 = "arith.andi"(%arg130, %arg131) : (i32, i32) -> i32
        "linalg.yield"(%260) : (i32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
      %185 = "linalg.generic"(%183, %34) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg128: i32, %arg129: f32):
        %259 = "arith.sitofp"(%arg128) : (i32) -> f32
        "linalg.yield"(%259) : (f32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xf32>) -> tensor<1024xf32>
      %186 = "linalg.generic"(%185, %56, %185) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg125: f32, %arg126: f32, %arg127: f32):
        %258 = "arith.mulf"(%arg125, %arg126) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%258) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %187 = "linalg.generic"(%184, %34) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg123: i32, %arg124: f32):
        %257 = "arith.sitofp"(%arg123) : (i32) -> f32
        "linalg.yield"(%257) : (f32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xf32>) -> tensor<1024xf32>
      %188 = "linalg.generic"(%187, %57, %187) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg120: f32, %arg121: f32, %arg122: f32):
        %256 = "arith.addf"(%arg120, %arg121) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%256) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %189 = "linalg.generic"(%188, %58, %188) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg117: f32, %arg118: f32, %arg119: f32):
        %255 = "arith.mulf"(%arg117, %arg118) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%255) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %190 = "linalg.generic"(%186, %189, %186) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg114: f32, %arg115: f32, %arg116: f32):
        %254 = "arith.addf"(%arg114, %arg115) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%254) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %191 = "linalg.generic"(%190, %35, %190) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg111: f32, %arg112: f32, %arg113: f32):
        %253 = "arith.mulf"(%arg111, %arg112) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%253) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %192 = "linalg.generic"(%191, %36, %191) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg108: f32, %arg109: f32, %arg110: f32):
        %252 = "arith.addf"(%arg108, %arg109) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%252) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %193 = "linalg.generic"(%190, %192, %190) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg105: f32, %arg106: f32, %arg107: f32):
        %251 = "arith.mulf"(%arg105, %arg106) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%251) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %194 = "linalg.generic"(%193, %37, %193) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg102: f32, %arg103: f32, %arg104: f32):
        %250 = "arith.addf"(%arg102, %arg103) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%250) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %195 = "linalg.generic"(%190, %194, %190) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg99: f32, %arg100: f32, %arg101: f32):
        %249 = "arith.mulf"(%arg99, %arg100) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%249) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %196 = "linalg.generic"(%195, %38, %195) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg96: f32, %arg97: f32, %arg98: f32):
        %248 = "arith.addf"(%arg96, %arg97) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%248) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %197 = "linalg.generic"(%190, %196, %190) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg93: f32, %arg94: f32, %arg95: f32):
        %247 = "arith.mulf"(%arg93, %arg94) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%247) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %198 = "linalg.generic"(%197, %39, %197) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg90: f32, %arg91: f32, %arg92: f32):
        %246 = "arith.addf"(%arg90, %arg91) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%246) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %199 = "linalg.generic"(%190, %198, %190) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg87: f32, %arg88: f32, %arg89: f32):
        %245 = "arith.mulf"(%arg87, %arg88) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%245) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %200 = "linalg.generic"(%199, %40, %199) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg84: f32, %arg85: f32, %arg86: f32):
        %244 = "arith.addf"(%arg84, %arg85) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%244) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %201 = "linalg.generic"(%190, %200, %190) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg81: f32, %arg82: f32, %arg83: f32):
        %243 = "arith.mulf"(%arg81, %arg82) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%243) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %202 = "linalg.generic"(%201, %57, %201) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg78: f32, %arg79: f32, %arg80: f32):
        %242 = "arith.addf"(%arg78, %arg79) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%242) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %203 = "linalg.generic"(%190, %202, %190) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg75: f32, %arg76: f32, %arg77: f32):
        %241 = "arith.mulf"(%arg75, %arg76) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%241) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %204 = "linalg.generic"(%203, %41, %203) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg72: f32, %arg73: f32, %arg74: f32):
        %240 = "arith.addf"(%arg72, %arg73) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%240) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %205 = "linalg.generic"(%59, %190, %59) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg69: f32, %arg70: f32, %arg71: f32):
        %239 = "arith.subf"(%arg69, %arg70) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%239) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %206 = "linalg.generic"(%205, %204, %205) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg66: f32, %arg67: f32, %arg68: f32):
        %238 = "arith.mulf"(%arg66, %arg67) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%238) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %207 = "linalg.generic"(%41, %190, %41) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg63: f32, %arg64: f32, %arg65: f32):
        %237 = "arith.subf"(%arg63, %arg64) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%237) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %208 = "linalg.generic"(%207, %42, %207) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg60: f32, %arg61: f32, %arg62: f32):
        %236 = "arith.maxnumf"(%arg60, %arg61) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%236) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %209 = "linalg.generic"(%208, %208) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg58: f32, %arg59: f32):
        %235 = "math.log"(%arg58) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%235) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %210 = "tensor.empty"() : () -> tensor<1024xi1>
      %211 = "linalg.generic"(%190, %39, %210) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg55: f32, %arg56: f32, %arg57: i1):
        %234 = "arith.cmpf"(%arg55, %arg56) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%234) : (i1) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xi1>) -> tensor<1024xi1>
      %212 = "linalg.generic"(%211, %206, %209, %206) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg51: i1, %arg52: f32, %arg53: f32, %arg54: f32):
        %233 = "arith.select"(%arg51, %arg52, %arg53) : (i1, f32, f32) -> f32
        "linalg.yield"(%233) : (f32) -> ()
      }) : (tensor<1024xi1>, tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %213 = "linalg.generic"(%59, %212, %59) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg48: f32, %arg49: f32, %arg50: f32):
        %232 = "arith.subf"(%arg48, %arg49) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%232) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %214 = "linalg.generic"(%213, %213) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg46: f32, %arg47: f32):
        %231 = "math.log"(%arg46) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%231) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %215 = "linalg.generic"(%59, %214, %59) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg43: f32, %arg44: f32, %arg45: f32):
        %230 = "arith.subf"(%arg43, %arg44) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%230) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %216 = "linalg.generic"(%83, %215, %83) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg40: f32, %arg41: f32, %arg42: f32):
        %229 = "arith.addf"(%arg40, %arg41) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%229) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %217 = "arith.subi"(%66, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %218 = "linalg.generic"(%68, %34) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg38: i32, %arg39: f32):
        %228 = "arith.sitofp"(%arg38) : (i32) -> f32
        "linalg.yield"(%228) : (f32) -> ()
      }) : (tensor<1024xi32>, tensor<1024xf32>) -> tensor<1024xf32>
      %219 = "linalg.generic"(%218, %59, %218) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg35: f32, %arg36: f32, %arg37: f32):
        %227 = "arith.addf"(%arg35, %arg36) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%227) : (f32) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      %220 = "arith.subi"(%5, %217) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %221 = "arith.sitofp"(%220) : (i32) -> f32
      %222 = "linalg.fill"(%221, %34) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg33: f32, %arg34: f32):
        "linalg.yield"(%arg33) : (f32) -> ()
      }) : (f32, tensor<1024xf32>) -> tensor<1024xf32>
      %223 = "linalg.generic"(%219, %222, %210) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg30: f32, %arg31: f32, %arg32: i1):
        %226 = "arith.cmpf"(%arg30, %arg31) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
        "linalg.yield"(%226) : (i1) -> ()
      }) : (tensor<1024xf32>, tensor<1024xf32>, tensor<1024xi1>) -> tensor<1024xi1>
      %224 = "linalg.generic"(%223, %216, %60, %216) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
      ^bb0(%arg26: i1, %arg27: f32, %arg28: f32, %arg29: f32):
        %225 = "arith.select"(%arg26, %arg27, %arg28) : (i1, f32, f32) -> f32
        "linalg.yield"(%225) : (f32) -> ()
      }) : (tensor<1024xi1>, tensor<1024xf32>, tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
      "scf.yield"(%224) : (tensor<1024xf32>) -> ()
    }, {
      "scf.yield"(%83) : (tensor<1024xf32>) -> ()
    }) : (i1) -> tensor<1024xf32>
    %93 = "tensor.empty"() : () -> tensor<f32>
    %94 = "linalg.fill"(%4, %93) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg24: f32, %arg25: f32):
      "linalg.yield"(%arg24) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %95 = "tensor.empty"() : () -> tensor<i32>
    %96 = "linalg.fill"(%31, %95) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg22: i32, %arg23: i32):
      "linalg.yield"(%arg22) : (i32) -> ()
    }) : (i32, tensor<i32>) -> tensor<i32>
    %97:2 = "linalg.reduce"(%92, %68, %94, %96) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg18: f32, %arg19: i32, %arg20: f32, %arg21: i32):
      %116 = "arith.cmpf"(%arg18, %arg20) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      %117 = "arith.cmpi"(%arg19, %arg21) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %118 = "arith.andi"(%116, %117) : (i1, i1) -> i1
      %119 = "arith.cmpf"(%arg18, %arg20) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      %120 = "arith.ori"(%119, %118) : (i1, i1) -> i1
      %121 = "arith.select"(%120, %arg18, %arg20) : (i1, f32, f32) -> f32
      %122 = "arith.select"(%120, %arg19, %arg21) : (i1, i32, i32) -> i32
      "linalg.yield"(%121, %122) : (f32, i32) -> ()
    }) : (tensor<1024xf32>, tensor<1024xi32>, tensor<f32>, tensor<i32>) -> (tensor<f32>, tensor<i32>)
    %98 = "tensor.extract"(%97#0) : (tensor<f32>) -> f32
    %99 = "tensor.extract"(%97#1) : (tensor<i32>) -> i32
    %100 = "arith.addi"(%66, %99) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %101 = "arith.extsi"(%arg1) : (i32) -> i64
    %102 = "arith.muli"(%63, %101) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %103 = "arith.extsi"(%100) : (i32) -> i64
    %104 = "arith.index_cast"(%102) : (i64) -> index
    %105 = "tensor.empty"() : () -> tensor<1xi64>
    %106 = "linalg.fill"(%103, %105) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg16: i64, %arg17: i64):
      "linalg.yield"(%arg16) : (i64) -> ()
    }) : (i64, tensor<1xi64>) -> tensor<1xi64>
    %107 = "arith.addi"(%104, %64) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %108 = "memref.subview"(%arg0, %107) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xi64>, index) -> memref<1xi64, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%106, %108) <{writable}> : (tensor<1xi64>, memref<1xi64, strided<[1], offset: ?>>) -> ()
    %109 = "arith.extsi"(%arg3) : (i32) -> i64
    %110 = "arith.muli"(%63, %109) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %111 = "arith.index_cast"(%110) : (i64) -> index
    %112 = "tensor.empty"() : () -> tensor<1xf32>
    %113 = "linalg.fill"(%98, %112) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      "linalg.yield"(%arg14) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %114 = "arith.addi"(%111, %64) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %115 = "memref.subview"(%arg2, %114) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    "bufferization.materialize_in_destination"(%113, %115) <{writable}> : (tensor<1xf32>, memref<1xf32, strided<[1], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

