#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (1024)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>, memref<?xf32>, i32) -> (), sym_name = "add_kernel_01234", sym_visibility = "public"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: i32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1024 : i32}> : () -> i32
    %2 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
    %3 = "arith.muli"(%2, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "tt.make_range"() <{end = 1024 : i32, start = 0 : i32}> : () -> tensor<1024xi32>
    %5 = "tt.splat"(%3) : (i32) -> tensor<1024xi32>
    %6 = "arith.addi"(%5, %4) <{overflowFlags = #arith.overflow<none>}> : (tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi32>
    %7 = "tt.splat"(%arg3) : (i32) -> tensor<1024xi32>
    %8 = "arith.cmpi"(%6, %7) <{predicate = 2 : i64}> : (tensor<1024xi32>, tensor<1024xi32>) -> tensor<1024xi1>
    %9 = "bufferization.to_tensor"(%arg0) <{restrict}> : (memref<?xf32>) -> tensor<?xf32>
    %10 = "tensor.empty"() : () -> tensor<1024xf32>
    %11 = "linalg.generic"(%6, %8, %10) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg8: i32, %arg9: i1, %arg10: f32):
      %22 = "scf.if"(%arg9) ({
        %23 = "arith.index_cast"(%arg8) : (i32) -> index
        %24 = "tensor.extract"(%9, %23) : (tensor<?xf32>, index) -> f32
        "scf.yield"(%24) : (f32) -> ()
      }, {
        "scf.yield"(%0) : (f32) -> ()
      }) : (i1) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi1>, tensor<1024xf32>) -> tensor<1024xf32>
    %12 = "bufferization.to_tensor"(%arg1) <{restrict}> : (memref<?xf32>) -> tensor<?xf32>
    %13 = "linalg.generic"(%6, %8, %10) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg5: i32, %arg6: i1, %arg7: f32):
      %19 = "scf.if"(%arg6) ({
        %20 = "arith.index_cast"(%arg5) : (i32) -> index
        %21 = "tensor.extract"(%12, %20) : (tensor<?xf32>, index) -> f32
        "scf.yield"(%21) : (f32) -> ()
      }, {
        "scf.yield"(%0) : (f32) -> ()
      }) : (i1) -> f32
      "linalg.yield"(%19) : (f32) -> ()
    }) : (tensor<1024xi32>, tensor<1024xi1>, tensor<1024xf32>) -> tensor<1024xf32>
    %14 = "arith.addf"(%11, %13) <{fastmath = #arith.fastmath<none>}> : (tensor<1024xf32>, tensor<1024xf32>) -> tensor<1024xf32>
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg4: index):
      %15 = "tensor.extract"(%8, %arg4) : (tensor<1024xi1>, index) -> i1
      "scf.if"(%15) ({
        %16 = "tensor.extract"(%14, %arg4) : (tensor<1024xf32>, index) -> f32
        %17 = "tensor.extract"(%6, %arg4) : (tensor<1024xi32>, index) -> i32
        %18 = "arith.index_cast"(%17) : (i32) -> index
        "memref.store"(%16, %arg2, %18) : (f32, memref<?xf32>, index) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

