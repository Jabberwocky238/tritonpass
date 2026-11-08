"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32) -> (), sym_name = "nested_who_knows_how_many_levels", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %4 = "arith.index_cast"(%arg2) : (i32) -> index
    %5 = "arith.index_cast"(%arg3) : (i32) -> index
    %6 = "arith.muli"(%arg3, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %7 = "arith.index_cast"(%6) : (i32) -> index
    %8:2 = "scf.for"(%2, %3, %1, %0, %0) ({
    ^bb0(%arg4: i32, %arg5: index, %arg6: index):
      %9 = "tts.make_tptr"(%arg0, %4, %5, %arg5, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
      %10 = "tts.load"(%9) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
      %11:3 = "scf.for"(%2, %3, %1, %arg5, %arg6, %10) ({
      ^bb0(%arg16: i32, %arg17: index, %arg18: index, %arg19: tensor<2x2xf32>):
        %31 = "arith.addi"(%arg17, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %32 = "tts.make_tptr"(%arg0, %4, %5, %31, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
        %33 = "tts.load"(%32) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
        %34:4 = "scf.for"(%2, %3, %1, %31, %arg18, %arg19, %33) ({
        ^bb0(%arg20: i32, %arg21: index, %arg22: index, %arg23: tensor<2x2xf32>, %arg24: tensor<2x2xf32>):
          %36 = "tts.make_tptr"(%arg1, %4, %5, %arg22, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
          %37 = "arith.addi"(%arg21, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %38 = "tts.make_tptr"(%arg0, %4, %5, %37, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
          %39 = "tts.load"(%38) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
          "tts.store"(%36, %arg23) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
          %40 = "arith.addi"(%arg22, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %41 = "tts.make_tptr"(%arg1, %4, %5, %40, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
          "tts.store"(%41, %arg24) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
          %42 = "arith.addi"(%40, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %43 = "tts.make_tptr"(%arg1, %4, %5, %42, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
          "tts.store"(%43, %39) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
          %44 = "arith.addi"(%42, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %45:2 = "scf.for"(%2, %3, %1, %37, %44) ({
          ^bb0(%arg37: i32, %arg38: index, %arg39: index):
            %64 = "tts.make_tptr"(%arg0, %4, %5, %arg38, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
            %65 = "tts.load"(%64) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
            %66:3 = "scf.for"(%2, %3, %1, %arg38, %arg39, %65) ({
            ^bb0(%arg40: i32, %arg41: index, %arg42: index, %arg43: tensor<2x2xf32>):
              %67 = "arith.addi"(%arg41, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
              %68 = "tts.make_tptr"(%arg0, %4, %5, %67, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
              %69 = "tts.load"(%68) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
              %70:4 = "scf.for"(%2, %3, %1, %67, %arg42, %arg43, %69) ({
              ^bb0(%arg44: i32, %arg45: index, %arg46: index, %arg47: tensor<2x2xf32>, %arg48: tensor<2x2xf32>):
                %71 = "tts.make_tptr"(%arg1, %4, %5, %arg46, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                %72 = "arith.addi"(%arg45, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                %73 = "tts.make_tptr"(%arg0, %4, %5, %72, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                %74 = "tts.load"(%73) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
                "tts.store"(%71, %arg47) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
                %75 = "arith.addi"(%arg46, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                %76 = "tts.make_tptr"(%arg1, %4, %5, %75, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                "tts.store"(%76, %arg48) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
                %77 = "arith.addi"(%75, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                %78 = "tts.make_tptr"(%arg1, %4, %5, %77, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                "tts.store"(%78, %74) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
                %79 = "arith.addi"(%77, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                %80 = "ub.poison"() <{value = #ub.poison}> : () -> tensor<2x2xf32>
                %81:4 = "scf.for"(%2, %3, %1, %80, %72, %80, %79) ({
                ^bb0(%arg49: i32, %arg50: tensor<2x2xf32>, %arg51: index, %arg52: tensor<2x2xf32>, %arg53: index):
                  %82 = "tts.make_tptr"(%arg0, %4, %5, %arg51, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                  %83 = "tts.load"(%82) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
                  %84:4 = "scf.for"(%2, %3, %1, %arg51, %80, %arg53, %83) ({
                  ^bb0(%arg54: i32, %arg55: index, %arg56: tensor<2x2xf32>, %arg57: index, %arg58: tensor<2x2xf32>):
                    %85 = "arith.addi"(%arg55, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                    %86 = "tts.make_tptr"(%arg0, %4, %5, %85, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                    %87 = "tts.load"(%86) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
                    %88:4 = "scf.for"(%2, %3, %1, %85, %arg57, %arg58, %87) ({
                    ^bb0(%arg59: i32, %arg60: index, %arg61: index, %arg62: tensor<2x2xf32>, %arg63: tensor<2x2xf32>):
                      %89 = "tts.make_tptr"(%arg1, %4, %5, %arg61, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                      %90 = "arith.addi"(%arg60, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                      %91 = "tts.make_tptr"(%arg0, %4, %5, %90, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                      %92 = "tts.load"(%91) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
                      "tts.store"(%89, %arg62) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
                      %93 = "arith.addi"(%arg61, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                      %94 = "tts.make_tptr"(%arg1, %4, %5, %93, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                      "tts.store"(%94, %arg63) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
                      %95 = "arith.addi"(%93, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                      %96 = "tts.make_tptr"(%arg1, %4, %5, %95, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                      "tts.store"(%96, %92) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
                      %97 = "arith.addi"(%95, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                      %98:4 = "scf.for"(%2, %3, %1, %80, %90, %80, %97) ({
                      ^bb0(%arg64: i32, %arg65: tensor<2x2xf32>, %arg66: index, %arg67: tensor<2x2xf32>, %arg68: index):
                        %99 = "tts.make_tptr"(%arg0, %4, %5, %arg66, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                        %100 = "tts.load"(%99) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
                        %101:3 = "scf.for"(%2, %3, %1, %arg66, %80, %arg68) ({
                        ^bb0(%arg69: i32, %arg70: index, %arg71: tensor<2x2xf32>, %arg72: index):
                          %102 = "arith.addi"(%arg70, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                          %103 = "tts.make_tptr"(%arg0, %4, %5, %102, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                          %104 = "tts.load"(%103) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
                          %105:2 = "scf.for"(%2, %3, %1, %102, %arg72) ({
                          ^bb0(%arg73: i32, %arg74: index, %arg75: index):
                            %106 = "tts.make_tptr"(%arg1, %4, %5, %arg75, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                            %107 = "arith.addi"(%arg74, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                            %108 = "tts.make_tptr"(%arg0, %4, %5, %107, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                            %109 = "tts.load"(%108) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
                            "tts.store"(%106, %100) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
                            %110 = "arith.addi"(%arg75, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                            %111 = "tts.make_tptr"(%arg1, %4, %5, %110, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                            "tts.store"(%111, %104) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
                            %112 = "arith.addi"(%110, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                            %113 = "tts.make_tptr"(%arg1, %4, %5, %112, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                            "tts.store"(%113, %109) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
                            %114 = "arith.addi"(%112, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                            "scf.yield"(%107, %114) : (index, index) -> ()
                          }) : (i32, i32, i32, index, index) -> (index, index)
                          "scf.yield"(%105#0, %104, %105#1) : (index, tensor<2x2xf32>, index) -> ()
                        }) : (i32, i32, i32, index, tensor<2x2xf32>, index) -> (index, tensor<2x2xf32>, index)
                        "scf.yield"(%100, %101#0, %101#1, %101#2) : (tensor<2x2xf32>, index, tensor<2x2xf32>, index) -> ()
                      }) : (i32, i32, i32, tensor<2x2xf32>, index, tensor<2x2xf32>, index) -> (tensor<2x2xf32>, index, tensor<2x2xf32>, index)
                      "scf.yield"(%98#1, %98#3, %98#0, %98#2) : (index, index, tensor<2x2xf32>, tensor<2x2xf32>) -> ()
                    }) : (i32, i32, i32, index, index, tensor<2x2xf32>, tensor<2x2xf32>) -> (index, index, tensor<2x2xf32>, tensor<2x2xf32>)
                    "scf.yield"(%88#0, %88#3, %88#1, %88#2) : (index, tensor<2x2xf32>, index, tensor<2x2xf32>) -> ()
                  }) : (i32, i32, i32, index, tensor<2x2xf32>, index, tensor<2x2xf32>) -> (index, tensor<2x2xf32>, index, tensor<2x2xf32>)
                  "scf.yield"(%84#3, %84#0, %84#1, %84#2) : (tensor<2x2xf32>, index, tensor<2x2xf32>, index) -> ()
                }) : (i32, i32, i32, tensor<2x2xf32>, index, tensor<2x2xf32>, index) -> (tensor<2x2xf32>, index, tensor<2x2xf32>, index)
                "scf.yield"(%81#1, %81#3, %81#0, %81#2) : (index, index, tensor<2x2xf32>, tensor<2x2xf32>) -> ()
              }) : (i32, i32, i32, index, index, tensor<2x2xf32>, tensor<2x2xf32>) -> (index, index, tensor<2x2xf32>, tensor<2x2xf32>)
              "scf.yield"(%70#0, %70#1, %70#2) : (index, index, tensor<2x2xf32>) -> ()
            }) : (i32, i32, i32, index, index, tensor<2x2xf32>) -> (index, index, tensor<2x2xf32>)
            "scf.yield"(%66#0, %66#1) : (index, index) -> ()
          }) : (i32, i32, i32, index, index) -> (index, index)
          %46 = "ub.poison"() <{value = #ub.poison}> : () -> tensor<2x2xf32>
          %47:4 = "scf.for"(%2, %3, %1, %46, %45#0, %46, %45#1) ({
          ^bb0(%arg25: i32, %arg26: tensor<2x2xf32>, %arg27: index, %arg28: tensor<2x2xf32>, %arg29: index):
            %48 = "tts.make_tptr"(%arg0, %4, %5, %arg27, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
            %49 = "tts.load"(%48) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
            %50:3 = "scf.for"(%2, %3, %1, %arg27, %46, %arg29) ({
            ^bb0(%arg30: i32, %arg31: index, %arg32: tensor<2x2xf32>, %arg33: index):
              %51 = "arith.addi"(%arg31, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
              %52 = "tts.make_tptr"(%arg0, %4, %5, %51, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
              %53 = "tts.load"(%52) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
              %54:2 = "scf.for"(%2, %3, %1, %51, %arg33) ({
              ^bb0(%arg34: i32, %arg35: index, %arg36: index):
                %55 = "tts.make_tptr"(%arg1, %4, %5, %arg36, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                %56 = "arith.addi"(%arg35, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                %57 = "tts.make_tptr"(%arg0, %4, %5, %56, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                %58 = "tts.load"(%57) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
                "tts.store"(%55, %49) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
                %59 = "arith.addi"(%arg36, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                %60 = "tts.make_tptr"(%arg1, %4, %5, %59, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                "tts.store"(%60, %53) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
                %61 = "arith.addi"(%59, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                %62 = "tts.make_tptr"(%arg1, %4, %5, %61, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
                "tts.store"(%62, %58) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
                %63 = "arith.addi"(%61, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
                "scf.yield"(%56, %63) : (index, index) -> ()
              }) : (i32, i32, i32, index, index) -> (index, index)
              "scf.yield"(%54#0, %53, %54#1) : (index, tensor<2x2xf32>, index) -> ()
            }) : (i32, i32, i32, index, tensor<2x2xf32>, index) -> (index, tensor<2x2xf32>, index)
            "scf.yield"(%49, %50#0, %50#1, %50#2) : (tensor<2x2xf32>, index, tensor<2x2xf32>, index) -> ()
          }) : (i32, i32, i32, tensor<2x2xf32>, index, tensor<2x2xf32>, index) -> (tensor<2x2xf32>, index, tensor<2x2xf32>, index)
          "scf.yield"(%47#1, %47#3, %47#0, %47#2) : (index, index, tensor<2x2xf32>, tensor<2x2xf32>) -> ()
        }) : (i32, i32, i32, index, index, tensor<2x2xf32>, tensor<2x2xf32>) -> (index, index, tensor<2x2xf32>, tensor<2x2xf32>)
        %35 = "arith.addi"(%34#0, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        "scf.yield"(%35, %34#1, %34#2) : (index, index, tensor<2x2xf32>) -> ()
      }) : (i32, i32, i32, index, index, tensor<2x2xf32>) -> (index, index, tensor<2x2xf32>)
      %12:2 = "scf.for"(%2, %3, %1, %11#0, %11#1) ({
      ^bb0(%arg7: i32, %arg8: index, %arg9: index):
        %14 = "tts.make_tptr"(%arg0, %4, %5, %arg8, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
        %15 = "tts.load"(%14) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
        %16:2 = "scf.for"(%2, %3, %1, %arg8, %arg9) ({
        ^bb0(%arg10: i32, %arg11: index, %arg12: index):
          %18 = "arith.addi"(%arg11, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %19 = "tts.make_tptr"(%arg0, %4, %5, %18, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
          %20 = "tts.load"(%19) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
          %21:2 = "scf.for"(%2, %3, %1, %18, %arg12) ({
          ^bb0(%arg13: i32, %arg14: index, %arg15: index):
            %22 = "tts.make_tptr"(%arg1, %4, %5, %arg15, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
            %23 = "arith.addi"(%arg14, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %24 = "tts.make_tptr"(%arg0, %4, %5, %23, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
            %25 = "tts.load"(%24) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
            "tts.store"(%22, %15) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
            %26 = "arith.addi"(%arg15, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %27 = "tts.make_tptr"(%arg1, %4, %5, %26, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
            "tts.store"(%27, %20) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
            %28 = "arith.addi"(%26, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %29 = "tts.make_tptr"(%arg1, %4, %5, %28, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, order = array<i32>, sizes = array<i64: 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_shape = array<i64: 0, 0>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (!tt.ptr<f32>, index, index, index, index) -> tensor<2x2x!tt.ptr<f32>>
            "tts.store"(%29, %25) <{static_mask_dims = array<i64>}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
            %30 = "arith.addi"(%28, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            "scf.yield"(%23, %30) : (index, index) -> ()
          }) : (i32, i32, i32, index, index) -> (index, index)
          "scf.yield"(%21#0, %21#1) : (index, index) -> ()
        }) : (i32, i32, i32, index, index) -> (index, index)
        %17 = "arith.addi"(%16#0, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        "scf.yield"(%17, %16#1) : (index, index) -> ()
      }) : (i32, i32, i32, index, index) -> (index, index)
      %13 = "arith.addi"(%12#0, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%13, %12#1) : (index, index) -> ()
    }) : (i32, i32, i32, index, index) -> (index, index)
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

