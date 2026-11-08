"builtin.module"() ({
  "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32) -> (), sym_name = "nested_who_knows_how_many_levels", sym_visibility = "public"}> ({
  ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<f32>, %arg2: i32, %arg3: i32):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3 = "tt.make_range"() <{end = 2 : i32, start = 0 : i32}> : () -> tensor<2xi32>
    %4 = "tt.expand_dims"(%3) <{axis = 1 : i32}> : (tensor<2xi32>) -> tensor<2x1xi32>
    %5 = "tt.splat"(%arg2) : (i32) -> tensor<2x1xi32>
    %6 = "arith.muli"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x1xi32>, tensor<2x1xi32>) -> tensor<2x1xi32>
    %7 = "tt.expand_dims"(%3) <{axis = 0 : i32}> : (tensor<2xi32>) -> tensor<1x2xi32>
    %8 = "tt.splat"(%arg3) : (i32) -> tensor<1x2xi32>
    %9 = "arith.muli"(%7, %8) <{overflowFlags = #arith.overflow<none>}> : (tensor<1x2xi32>, tensor<1x2xi32>) -> tensor<1x2xi32>
    %10 = "tt.broadcast"(%6) : (tensor<2x1xi32>) -> tensor<2x2xi32>
    %11 = "tt.broadcast"(%9) : (tensor<1x2xi32>) -> tensor<2x2xi32>
    %12 = "arith.addi"(%10, %11) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
    %13 = "arith.muli"(%arg3, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %14 = "tt.splat"(%13) : (i32) -> tensor<2x2xi32>
    %15:2 = "scf.for"(%0, %2, %1, %12, %12) ({
    ^bb0(%arg4: i32, %arg5: tensor<2x2xi32>, %arg6: tensor<2x2xi32>):
      %16 = "tts.gather"(%arg0, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
      %17:3 = "scf.for"(%0, %2, %1, %arg5, %arg6, %16) ({
      ^bb0(%arg16: i32, %arg17: tensor<2x2xi32>, %arg18: tensor<2x2xi32>, %arg19: tensor<2x2xf32>):
        %31 = "arith.addi"(%arg17, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
        %32 = "tts.gather"(%arg0, %31) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
        %33:4 = "scf.for"(%0, %2, %1, %31, %arg18, %arg19, %32) ({
        ^bb0(%arg20: i32, %arg21: tensor<2x2xi32>, %arg22: tensor<2x2xi32>, %arg23: tensor<2x2xf32>, %arg24: tensor<2x2xf32>):
          %35 = "arith.addi"(%arg21, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
          %36 = "tts.gather"(%arg0, %35) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
          "tts.scatter"(%arg1, %arg22, %arg23) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
          %37 = "arith.addi"(%arg22, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
          "tts.scatter"(%arg1, %37, %arg24) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
          %38 = "arith.addi"(%37, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
          "tts.scatter"(%arg1, %38, %36) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
          %39 = "arith.addi"(%38, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
          %40:5 = "scf.for"(%0, %2, %1, %arg23, %35, %arg24, %36, %39) ({
          ^bb0(%arg40: i32, %arg41: tensor<2x2xf32>, %arg42: tensor<2x2xi32>, %arg43: tensor<2x2xf32>, %arg44: tensor<2x2xf32>, %arg45: tensor<2x2xi32>):
            %52 = "tts.gather"(%arg0, %arg42) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
            %53:5 = "scf.for"(%0, %2, %1, %arg42, %arg43, %arg44, %arg45, %52) ({
            ^bb0(%arg46: i32, %arg47: tensor<2x2xi32>, %arg48: tensor<2x2xf32>, %arg49: tensor<2x2xf32>, %arg50: tensor<2x2xi32>, %arg51: tensor<2x2xf32>):
              %54 = "arith.addi"(%arg47, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
              %55 = "tts.gather"(%arg0, %54) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
              %56:5 = "scf.for"(%0, %2, %1, %54, %arg49, %arg50, %arg51, %55) ({
              ^bb0(%arg52: i32, %arg53: tensor<2x2xi32>, %arg54: tensor<2x2xf32>, %arg55: tensor<2x2xi32>, %arg56: tensor<2x2xf32>, %arg57: tensor<2x2xf32>):
                %57 = "arith.addi"(%arg53, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                %58 = "tts.gather"(%arg0, %57) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
                "tts.scatter"(%arg1, %arg55, %arg56) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
                %59 = "arith.addi"(%arg55, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                "tts.scatter"(%arg1, %59, %arg57) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
                %60 = "arith.addi"(%59, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                "tts.scatter"(%arg1, %60, %58) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
                %61 = "arith.addi"(%60, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                %62:5 = "scf.for"(%0, %2, %1, %arg56, %57, %arg57, %58, %61) ({
                ^bb0(%arg58: i32, %arg59: tensor<2x2xf32>, %arg60: tensor<2x2xi32>, %arg61: tensor<2x2xf32>, %arg62: tensor<2x2xf32>, %arg63: tensor<2x2xi32>):
                  %63 = "tts.gather"(%arg0, %arg60) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
                  %64:5 = "scf.for"(%0, %2, %1, %arg60, %arg61, %arg62, %arg63, %63) ({
                  ^bb0(%arg64: i32, %arg65: tensor<2x2xi32>, %arg66: tensor<2x2xf32>, %arg67: tensor<2x2xf32>, %arg68: tensor<2x2xi32>, %arg69: tensor<2x2xf32>):
                    %65 = "arith.addi"(%arg65, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                    %66 = "tts.gather"(%arg0, %65) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
                    %67:5 = "scf.for"(%0, %2, %1, %65, %arg67, %arg68, %arg69, %66) ({
                    ^bb0(%arg70: i32, %arg71: tensor<2x2xi32>, %arg72: tensor<2x2xf32>, %arg73: tensor<2x2xi32>, %arg74: tensor<2x2xf32>, %arg75: tensor<2x2xf32>):
                      %68 = "arith.addi"(%arg71, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                      %69 = "tts.gather"(%arg0, %68) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
                      "tts.scatter"(%arg1, %arg73, %arg74) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
                      %70 = "arith.addi"(%arg73, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                      "tts.scatter"(%arg1, %70, %arg75) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
                      %71 = "arith.addi"(%70, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                      "tts.scatter"(%arg1, %71, %69) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
                      %72 = "arith.addi"(%71, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                      %73:5 = "scf.for"(%0, %2, %1, %arg74, %68, %arg75, %69, %72) ({
                      ^bb0(%arg76: i32, %arg77: tensor<2x2xf32>, %arg78: tensor<2x2xi32>, %arg79: tensor<2x2xf32>, %arg80: tensor<2x2xf32>, %arg81: tensor<2x2xi32>):
                        %74 = "tts.gather"(%arg0, %arg78) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
                        %75:4 = "scf.for"(%0, %2, %1, %arg78, %arg79, %arg80, %arg81) ({
                        ^bb0(%arg82: i32, %arg83: tensor<2x2xi32>, %arg84: tensor<2x2xf32>, %arg85: tensor<2x2xf32>, %arg86: tensor<2x2xi32>):
                          %76 = "arith.addi"(%arg83, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                          %77 = "tts.gather"(%arg0, %76) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
                          %78:3 = "scf.for"(%0, %2, %1, %76, %arg85, %arg86) ({
                          ^bb0(%arg87: i32, %arg88: tensor<2x2xi32>, %arg89: tensor<2x2xf32>, %arg90: tensor<2x2xi32>):
                            %79 = "arith.addi"(%arg88, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                            %80 = "tts.gather"(%arg0, %79) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
                            "tts.scatter"(%arg1, %arg90, %74) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
                            %81 = "arith.addi"(%arg90, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                            "tts.scatter"(%arg1, %81, %77) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
                            %82 = "arith.addi"(%81, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                            "tts.scatter"(%arg1, %82, %80) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
                            %83 = "arith.addi"(%82, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                            "scf.yield"(%79, %80, %83) : (tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xi32>) -> ()
                          }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xi32>) -> (tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xi32>)
                          "scf.yield"(%78#0, %77, %78#1, %78#2) : (tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>) -> ()
                        }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>) -> (tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>)
                        "scf.yield"(%74, %75#0, %75#1, %75#2, %75#3) : (tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>) -> ()
                      }) : (i32, i32, i32, tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>) -> (tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>)
                      "scf.yield"(%73#1, %73#3, %73#4, %73#0, %73#2) : (tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>) -> ()
                    }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>) -> (tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>)
                    "scf.yield"(%67#0, %67#4, %67#1, %67#2, %67#3) : (tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
                  }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>) -> (tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>)
                  "scf.yield"(%64#4, %64#0, %64#1, %64#2, %64#3) : (tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>) -> ()
                }) : (i32, i32, i32, tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>) -> (tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>)
                "scf.yield"(%62#1, %62#3, %62#4, %62#0, %62#2) : (tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>) -> ()
              }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>) -> (tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>)
              "scf.yield"(%56#0, %56#4, %56#1, %56#2, %56#3) : (tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
            }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>) -> (tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>)
            "scf.yield"(%53#4, %53#0, %53#1, %53#2, %53#3) : (tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>) -> ()
          }) : (i32, i32, i32, tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>) -> (tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>)
          %41:5 = "scf.for"(%0, %2, %1, %40#0, %40#1, %40#2, %40#3, %40#4) ({
          ^bb0(%arg25: i32, %arg26: tensor<2x2xf32>, %arg27: tensor<2x2xi32>, %arg28: tensor<2x2xf32>, %arg29: tensor<2x2xf32>, %arg30: tensor<2x2xi32>):
            %42 = "tts.gather"(%arg0, %arg27) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
            %43:4 = "scf.for"(%0, %2, %1, %arg27, %arg28, %arg29, %arg30) ({
            ^bb0(%arg31: i32, %arg32: tensor<2x2xi32>, %arg33: tensor<2x2xf32>, %arg34: tensor<2x2xf32>, %arg35: tensor<2x2xi32>):
              %44 = "arith.addi"(%arg32, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
              %45 = "tts.gather"(%arg0, %44) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
              %46:3 = "scf.for"(%0, %2, %1, %44, %arg34, %arg35) ({
              ^bb0(%arg36: i32, %arg37: tensor<2x2xi32>, %arg38: tensor<2x2xf32>, %arg39: tensor<2x2xi32>):
                %47 = "arith.addi"(%arg37, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                %48 = "tts.gather"(%arg0, %47) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
                "tts.scatter"(%arg1, %arg39, %42) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
                %49 = "arith.addi"(%arg39, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                "tts.scatter"(%arg1, %49, %45) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
                %50 = "arith.addi"(%49, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                "tts.scatter"(%arg1, %50, %48) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
                %51 = "arith.addi"(%50, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
                "scf.yield"(%47, %48, %51) : (tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xi32>) -> ()
              }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xi32>) -> (tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xi32>)
              "scf.yield"(%46#0, %45, %46#1, %46#2) : (tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>) -> ()
            }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>) -> (tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>)
            "scf.yield"(%42, %43#0, %43#1, %43#2, %43#3) : (tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>) -> ()
          }) : (i32, i32, i32, tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>) -> (tensor<2x2xf32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>, tensor<2x2xi32>)
          "scf.yield"(%41#1, %41#4, %41#0, %41#2) : (tensor<2x2xi32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>) -> ()
        }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>) -> (tensor<2x2xi32>, tensor<2x2xi32>, tensor<2x2xf32>, tensor<2x2xf32>)
        %34 = "arith.addi"(%33#0, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
        "scf.yield"(%34, %33#1, %33#2) : (tensor<2x2xi32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
      }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xi32>, tensor<2x2xf32>) -> (tensor<2x2xi32>, tensor<2x2xi32>, tensor<2x2xf32>)
      %18:2 = "scf.for"(%0, %2, %1, %17#0, %17#1) ({
      ^bb0(%arg7: i32, %arg8: tensor<2x2xi32>, %arg9: tensor<2x2xi32>):
        %20 = "tts.gather"(%arg0, %arg8) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
        %21:2 = "scf.for"(%0, %2, %1, %arg8, %arg9) ({
        ^bb0(%arg10: i32, %arg11: tensor<2x2xi32>, %arg12: tensor<2x2xi32>):
          %23 = "arith.addi"(%arg11, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
          %24 = "tts.gather"(%arg0, %23) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
          %25:2 = "scf.for"(%0, %2, %1, %23, %arg12) ({
          ^bb0(%arg13: i32, %arg14: tensor<2x2xi32>, %arg15: tensor<2x2xi32>):
            %26 = "arith.addi"(%arg14, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
            %27 = "tts.gather"(%arg0, %26) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>}> : (!tt.ptr<f32>, tensor<2x2xi32>) -> tensor<2x2xf32>
            "tts.scatter"(%arg1, %arg15, %20) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
            %28 = "arith.addi"(%arg15, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
            "tts.scatter"(%arg1, %28, %24) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
            %29 = "arith.addi"(%28, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
            "tts.scatter"(%arg1, %29, %27) : (!tt.ptr<f32>, tensor<2x2xi32>, tensor<2x2xf32>) -> ()
            %30 = "arith.addi"(%29, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
            "scf.yield"(%26, %30) : (tensor<2x2xi32>, tensor<2x2xi32>) -> ()
          }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xi32>) -> (tensor<2x2xi32>, tensor<2x2xi32>)
          "scf.yield"(%25#0, %25#1) : (tensor<2x2xi32>, tensor<2x2xi32>) -> ()
        }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xi32>) -> (tensor<2x2xi32>, tensor<2x2xi32>)
        %22 = "arith.addi"(%21#0, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
        "scf.yield"(%22, %21#1) : (tensor<2x2xi32>, tensor<2x2xi32>) -> ()
      }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xi32>) -> (tensor<2x2xi32>, tensor<2x2xi32>)
      %19 = "arith.addi"(%18#0, %14) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
      "scf.yield"(%19, %18#1) : (tensor<2x2xi32>, tensor<2x2xi32>) -> ()
    }) : (i32, i32, i32, tensor<2x2xi32>, tensor<2x2xi32>) -> (tensor<2x2xi32>, tensor<2x2xi32>)
    "tt.return"() : () -> ()
  }) {noinline = false} : () -> ()
}) : () -> ()

