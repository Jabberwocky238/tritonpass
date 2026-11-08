"builtin.module"() ({
  "builtin.module"() ({
    "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "nested1", sym_visibility = "public"}> ({
    ^bb0(%arg101: !tt.ptr<f32>, %arg102: !tt.ptr<f32>, %arg103: i32, %arg104: i32, %arg105: i32, %arg106: i32, %arg107: i32, %arg108: i32):
      %162 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %163 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %164 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %165 = "arith.constant"() <{value = 32 : i32}> : () -> i32
      %166 = "tt.make_range"() <{end = 2 : i32, start = 0 : i32}> : () -> tensor<2xi32>
      %167 = "tt.expand_dims"(%166) <{axis = 1 : i32}> : (tensor<2xi32>) -> tensor<2x1xi32>
      %168 = "tt.splat"(%arg105) : (i32) -> tensor<2x1xi32>
      %169 = "arith.muli"(%167, %168) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x1xi32>, tensor<2x1xi32>) -> tensor<2x1xi32>
      %170 = "tt.expand_dims"(%166) <{axis = 0 : i32}> : (tensor<2xi32>) -> tensor<1x2xi32>
      %171 = "tt.splat"(%arg106) : (i32) -> tensor<1x2xi32>
      %172 = "arith.muli"(%170, %171) <{overflowFlags = #arith.overflow<none>}> : (tensor<1x2xi32>, tensor<1x2xi32>) -> tensor<1x2xi32>
      %173 = "tt.broadcast"(%169) : (tensor<2x1xi32>) -> tensor<2x2xi32>
      %174 = "tt.broadcast"(%172) : (tensor<1x2xi32>) -> tensor<2x2xi32>
      %175 = "arith.addi"(%173, %174) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
      %176 = "tt.splat"(%arg101) : (!tt.ptr<f32>) -> tensor<2x2x!tt.ptr<f32>>
      %177 = "tt.addptr"(%176, %175) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
      %178:5 = "tts.get_structured_state"(%177) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
      %179 = "tt.splat"(%arg107) : (i32) -> tensor<2x1xi32>
      %180 = "arith.muli"(%179, %167) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x1xi32>, tensor<2x1xi32>) -> tensor<2x1xi32>
      %181 = "tt.splat"(%arg102) : (!tt.ptr<f32>) -> tensor<2x1x!tt.ptr<f32>>
      %182 = "tt.addptr"(%181, %180) : (tensor<2x1x!tt.ptr<f32>>, tensor<2x1xi32>) -> tensor<2x1x!tt.ptr<f32>>
      %183 = "tt.splat"(%arg108) : (i32) -> tensor<1x2xi32>
      %184 = "arith.muli"(%183, %170) <{overflowFlags = #arith.overflow<none>}> : (tensor<1x2xi32>, tensor<1x2xi32>) -> tensor<1x2xi32>
      %185 = "tt.broadcast"(%182) : (tensor<2x1x!tt.ptr<f32>>) -> tensor<2x2x!tt.ptr<f32>>
      %186 = "tt.broadcast"(%184) : (tensor<1x2xi32>) -> tensor<2x2xi32>
      %187 = "tt.addptr"(%185, %186) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
      %188:5 = "tts.get_structured_state"(%187) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
      %189 = "arith.muli"(%arg106, %165) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %190 = "tt.splat"(%189) : (i32) -> tensor<2x2xi32>
      %191:10 = "scf.for"(%164, %163, %162, %178#0, %178#1, %178#2, %178#3, %178#4, %188#0, %188#1, %188#2, %188#3, %188#4) ({
      ^bb0(%arg109: i32, %arg110: tensor<2x2x!tt.ptr<f32>>, %arg111: index, %arg112: index, %arg113: index, %arg114: index, %arg115: tensor<2x2x!tt.ptr<f32>>, %arg116: index, %arg117: index, %arg118: index, %arg119: index):
        %192 = "tt.load"(%arg110) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
        "tt.store"(%arg115, %192) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
        %193 = "tt.addptr"(%arg110, %190) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
        %194:5 = "tts.get_structured_state"(%193) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
        %195 = "tt.addptr"(%arg115, %190) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
        %196:5 = "tts.get_structured_state"(%195) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
        "scf.yield"(%194#0, %194#1, %194#2, %194#3, %194#4, %196#0, %196#1, %196#2, %196#3, %196#4) : (tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index) -> ()
      }) : (i32, i32, i32, tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
      "tt.return"() : () -> ()
    }) {noinline = false} : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32, i32, i32, i32, i32) -> (), sym_name = "nested2", sym_visibility = "public"}> ({
    ^bb0(%arg71: !tt.ptr<f32>, %arg72: !tt.ptr<f32>, %arg73: i32, %arg74: i32, %arg75: i32, %arg76: i32, %arg77: i32, %arg78: i32):
      %121 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %122 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %123 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %124 = "arith.constant"() <{value = 32 : i32}> : () -> i32
      %125 = "tt.make_range"() <{end = 2 : i32, start = 0 : i32}> : () -> tensor<2xi32>
      %126 = "tt.expand_dims"(%125) <{axis = 1 : i32}> : (tensor<2xi32>) -> tensor<2x1xi32>
      %127 = "tt.splat"(%arg75) : (i32) -> tensor<2x1xi32>
      %128 = "arith.muli"(%126, %127) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x1xi32>, tensor<2x1xi32>) -> tensor<2x1xi32>
      %129 = "tt.expand_dims"(%125) <{axis = 0 : i32}> : (tensor<2xi32>) -> tensor<1x2xi32>
      %130 = "tt.splat"(%arg76) : (i32) -> tensor<1x2xi32>
      %131 = "arith.muli"(%129, %130) <{overflowFlags = #arith.overflow<none>}> : (tensor<1x2xi32>, tensor<1x2xi32>) -> tensor<1x2xi32>
      %132 = "tt.broadcast"(%128) : (tensor<2x1xi32>) -> tensor<2x2xi32>
      %133 = "tt.broadcast"(%131) : (tensor<1x2xi32>) -> tensor<2x2xi32>
      %134 = "arith.addi"(%132, %133) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
      %135 = "tt.splat"(%arg71) : (!tt.ptr<f32>) -> tensor<2x2x!tt.ptr<f32>>
      %136 = "tt.addptr"(%135, %134) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
      %137:5 = "tts.get_structured_state"(%136) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
      %138 = "tt.splat"(%arg77) : (i32) -> tensor<2x1xi32>
      %139 = "arith.muli"(%138, %126) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x1xi32>, tensor<2x1xi32>) -> tensor<2x1xi32>
      %140 = "tt.splat"(%arg72) : (!tt.ptr<f32>) -> tensor<2x1x!tt.ptr<f32>>
      %141 = "tt.addptr"(%140, %139) : (tensor<2x1x!tt.ptr<f32>>, tensor<2x1xi32>) -> tensor<2x1x!tt.ptr<f32>>
      %142 = "tt.splat"(%arg78) : (i32) -> tensor<1x2xi32>
      %143 = "arith.muli"(%142, %129) <{overflowFlags = #arith.overflow<none>}> : (tensor<1x2xi32>, tensor<1x2xi32>) -> tensor<1x2xi32>
      %144 = "tt.broadcast"(%141) : (tensor<2x1x!tt.ptr<f32>>) -> tensor<2x2x!tt.ptr<f32>>
      %145 = "tt.broadcast"(%143) : (tensor<1x2xi32>) -> tensor<2x2xi32>
      %146 = "tt.addptr"(%144, %145) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
      %147:5 = "tts.get_structured_state"(%146) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
      %148 = "arith.muli"(%arg76, %124) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %149 = "tt.splat"(%148) : (i32) -> tensor<2x2xi32>
      %150:10 = "scf.for"(%123, %122, %121, %137#0, %137#1, %137#2, %137#3, %137#4, %147#0, %147#1, %147#2, %147#3, %147#4) ({
      ^bb0(%arg79: i32, %arg80: tensor<2x2x!tt.ptr<f32>>, %arg81: index, %arg82: index, %arg83: index, %arg84: index, %arg85: tensor<2x2x!tt.ptr<f32>>, %arg86: index, %arg87: index, %arg88: index, %arg89: index):
        %151 = "tt.load"(%arg80) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
        "tt.store"(%arg85, %151) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
        %152 = "tt.addptr"(%arg80, %149) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
        %153:5 = "tts.get_structured_state"(%152) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
        %154 = "tt.addptr"(%arg85, %149) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
        %155:5 = "tts.get_structured_state"(%154) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
        %156:10 = "scf.for"(%123, %122, %121, %153#0, %153#1, %153#2, %153#3, %153#4, %155#0, %155#1, %155#2, %155#3, %155#4) ({
        ^bb0(%arg90: i32, %arg91: tensor<2x2x!tt.ptr<f32>>, %arg92: index, %arg93: index, %arg94: index, %arg95: index, %arg96: tensor<2x2x!tt.ptr<f32>>, %arg97: index, %arg98: index, %arg99: index, %arg100: index):
          %157 = "tt.load"(%arg91) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
          "tt.store"(%arg96, %157) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
          %158 = "tt.addptr"(%arg91, %149) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
          %159:5 = "tts.get_structured_state"(%158) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
          %160 = "tt.addptr"(%arg96, %149) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
          %161:5 = "tts.get_structured_state"(%160) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
          "scf.yield"(%159#0, %159#1, %159#2, %159#3, %159#4, %161#0, %161#1, %161#2, %161#3, %161#4) : (tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index) -> ()
        }) : (i32, i32, i32, tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
        "scf.yield"(%156#0, %156#1, %156#2, %156#3, %156#4, %156#5, %156#6, %156#7, %156#8, %156#9) : (tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index) -> ()
      }) : (i32, i32, i32, tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
      "tt.return"() : () -> ()
    }) {noinline = false} : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32) -> (), sym_name = "nested2_use_loop_results", sym_visibility = "public"}> ({
    ^bb0(%arg45: !tt.ptr<f32>, %arg46: !tt.ptr<f32>, %arg47: i32, %arg48: i32):
      %81 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %82 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %83 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %84 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %85 = "tt.make_range"() <{end = 2 : i32, start = 0 : i32}> : () -> tensor<2xi32>
      %86 = "tt.expand_dims"(%85) <{axis = 1 : i32}> : (tensor<2xi32>) -> tensor<2x1xi32>
      %87 = "tt.splat"(%arg47) : (i32) -> tensor<2x1xi32>
      %88 = "arith.muli"(%86, %87) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x1xi32>, tensor<2x1xi32>) -> tensor<2x1xi32>
      %89 = "tt.expand_dims"(%85) <{axis = 0 : i32}> : (tensor<2xi32>) -> tensor<1x2xi32>
      %90 = "tt.splat"(%arg48) : (i32) -> tensor<1x2xi32>
      %91 = "arith.muli"(%89, %90) <{overflowFlags = #arith.overflow<none>}> : (tensor<1x2xi32>, tensor<1x2xi32>) -> tensor<1x2xi32>
      %92 = "tt.broadcast"(%88) : (tensor<2x1xi32>) -> tensor<2x2xi32>
      %93 = "tt.broadcast"(%91) : (tensor<1x2xi32>) -> tensor<2x2xi32>
      %94 = "arith.addi"(%92, %93) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
      %95 = "tt.splat"(%arg45) : (!tt.ptr<f32>) -> tensor<2x2x!tt.ptr<f32>>
      %96 = "tt.addptr"(%95, %94) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
      %97:5 = "tts.get_structured_state"(%96) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
      %98 = "tt.splat"(%arg46) : (!tt.ptr<f32>) -> tensor<2x1x!tt.ptr<f32>>
      %99 = "tt.addptr"(%98, %88) : (tensor<2x1x!tt.ptr<f32>>, tensor<2x1xi32>) -> tensor<2x1x!tt.ptr<f32>>
      %100 = "tt.broadcast"(%99) : (tensor<2x1x!tt.ptr<f32>>) -> tensor<2x2x!tt.ptr<f32>>
      %101 = "tt.addptr"(%100, %93) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
      %102:5 = "tts.get_structured_state"(%101) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
      %103 = "arith.muli"(%arg48, %84) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %104 = "tt.splat"(%103) : (i32) -> tensor<2x2xi32>
      %105:10 = "scf.for"(%83, %82, %81, %97#0, %97#1, %97#2, %97#3, %97#4, %102#0, %102#1, %102#2, %102#3, %102#4) ({
      ^bb0(%arg49: i32, %arg50: tensor<2x2x!tt.ptr<f32>>, %arg51: index, %arg52: index, %arg53: index, %arg54: index, %arg55: tensor<2x2x!tt.ptr<f32>>, %arg56: index, %arg57: index, %arg58: index, %arg59: index):
        %106 = "tt.load"(%arg50) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
        "tt.store"(%arg55, %106) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
        %107 = "tt.addptr"(%arg50, %104) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
        %108:5 = "tts.get_structured_state"(%107) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
        %109 = "tt.addptr"(%arg55, %104) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
        %110:5 = "tts.get_structured_state"(%109) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
        %111:10 = "scf.for"(%83, %82, %81, %108#0, %108#1, %108#2, %108#3, %108#4, %110#0, %110#1, %110#2, %110#3, %110#4) ({
        ^bb0(%arg60: i32, %arg61: tensor<2x2x!tt.ptr<f32>>, %arg62: index, %arg63: index, %arg64: index, %arg65: index, %arg66: tensor<2x2x!tt.ptr<f32>>, %arg67: index, %arg68: index, %arg69: index, %arg70: index):
          %116 = "tt.load"(%arg61) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
          "tt.store"(%arg66, %116) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
          %117 = "tt.addptr"(%arg61, %104) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
          %118:5 = "tts.get_structured_state"(%117) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
          %119 = "tt.addptr"(%arg66, %104) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
          %120:5 = "tts.get_structured_state"(%119) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
          "scf.yield"(%118#0, %118#1, %118#2, %118#3, %118#4, %120#0, %120#1, %120#2, %120#3, %120#4) : (tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index) -> ()
        }) : (i32, i32, i32, tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
        %112 = "tt.addptr"(%111#0, %104) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
        %113:5 = "tts.get_structured_state"(%112) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
        %114 = "tt.addptr"(%111#5, %104) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
        %115:5 = "tts.get_structured_state"(%114) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
        "scf.yield"(%113#0, %113#1, %113#2, %113#3, %113#4, %115#0, %115#1, %115#2, %115#3, %115#4) : (tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index) -> ()
      }) : (i32, i32, i32, tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
      "tt.return"() : () -> ()
    }) {noinline = false} : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "tt.func"() <{function_type = (!tt.ptr<f32>, !tt.ptr<f32>, i32, i32) -> (), sym_name = "nested3", sym_visibility = "public"}> ({
    ^bb0(%arg8: !tt.ptr<f32>, %arg9: !tt.ptr<f32>, %arg10: i32, %arg11: i32):
      %40 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %41 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %42 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %43 = "tt.make_range"() <{end = 2 : i32, start = 0 : i32}> : () -> tensor<2xi32>
      %44 = "tt.expand_dims"(%43) <{axis = 1 : i32}> : (tensor<2xi32>) -> tensor<2x1xi32>
      %45 = "tt.splat"(%arg10) : (i32) -> tensor<2x1xi32>
      %46 = "arith.muli"(%44, %45) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x1xi32>, tensor<2x1xi32>) -> tensor<2x1xi32>
      %47 = "tt.expand_dims"(%43) <{axis = 0 : i32}> : (tensor<2xi32>) -> tensor<1x2xi32>
      %48 = "tt.splat"(%arg11) : (i32) -> tensor<1x2xi32>
      %49 = "arith.muli"(%47, %48) <{overflowFlags = #arith.overflow<none>}> : (tensor<1x2xi32>, tensor<1x2xi32>) -> tensor<1x2xi32>
      %50 = "tt.broadcast"(%46) : (tensor<2x1xi32>) -> tensor<2x2xi32>
      %51 = "tt.broadcast"(%49) : (tensor<1x2xi32>) -> tensor<2x2xi32>
      %52 = "arith.addi"(%50, %51) <{overflowFlags = #arith.overflow<none>}> : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
      %53 = "tt.splat"(%arg8) : (!tt.ptr<f32>) -> tensor<2x2x!tt.ptr<f32>>
      %54 = "tt.addptr"(%53, %52) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
      %55:5 = "tts.get_structured_state"(%54) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
      %56 = "tt.splat"(%arg9) : (!tt.ptr<f32>) -> tensor<2x1x!tt.ptr<f32>>
      %57 = "tt.addptr"(%56, %46) : (tensor<2x1x!tt.ptr<f32>>, tensor<2x1xi32>) -> tensor<2x1x!tt.ptr<f32>>
      %58 = "tt.broadcast"(%57) : (tensor<2x1x!tt.ptr<f32>>) -> tensor<2x2x!tt.ptr<f32>>
      %59 = "tt.addptr"(%58, %51) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
      %60:5 = "tts.get_structured_state"(%59) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
      %61 = "arith.muli"(%arg11, %42) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %62 = "tt.splat"(%61) : (i32) -> tensor<2x2xi32>
      %63 = "arith.muli"(%arg11, %42) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %64 = "tt.splat"(%63) : (i32) -> tensor<2x2xi32>
      %65:10 = "scf.for"(%41, %42, %40, %55#0, %55#1, %55#2, %55#3, %55#4, %60#0, %60#1, %60#2, %60#3, %60#4) ({
      ^bb0(%arg12: i32, %arg13: tensor<2x2x!tt.ptr<f32>>, %arg14: index, %arg15: index, %arg16: index, %arg17: index, %arg18: tensor<2x2x!tt.ptr<f32>>, %arg19: index, %arg20: index, %arg21: index, %arg22: index):
        %66 = "tt.load"(%arg13) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
        %67:10 = "scf.for"(%41, %42, %40, %arg13, %arg14, %arg15, %arg16, %arg17, %arg18, %arg19, %arg20, %arg21, %arg22) ({
        ^bb0(%arg23: i32, %arg24: tensor<2x2x!tt.ptr<f32>>, %arg25: index, %arg26: index, %arg27: index, %arg28: index, %arg29: tensor<2x2x!tt.ptr<f32>>, %arg30: index, %arg31: index, %arg32: index, %arg33: index):
          %70 = "tt.addptr"(%arg24, %62) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
          %71:5 = "tts.get_structured_state"(%70) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
          %72 = "tt.load"(%70) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
          %73:10 = "scf.for"(%41, %42, %40, %71#0, %71#1, %71#2, %71#3, %71#4, %arg29, %arg30, %arg31, %arg32, %arg33) ({
          ^bb0(%arg34: i32, %arg35: tensor<2x2x!tt.ptr<f32>>, %arg36: index, %arg37: index, %arg38: index, %arg39: index, %arg40: tensor<2x2x!tt.ptr<f32>>, %arg41: index, %arg42: index, %arg43: index, %arg44: index):
            %74 = "tt.addptr"(%arg35, %62) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
            %75:5 = "tts.get_structured_state"(%74) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
            %76 = "tt.load"(%74) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (tensor<2x2x!tt.ptr<f32>>) -> tensor<2x2xf32>
            "tt.store"(%arg40, %66) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
            %77 = "tt.addptr"(%arg40, %62) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
            "tt.store"(%77, %72) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
            %78 = "tt.addptr"(%77, %62) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
            "tt.store"(%78, %76) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xf32>) -> ()
            %79 = "tt.addptr"(%78, %62) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
            %80:5 = "tts.get_structured_state"(%79) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
            "scf.yield"(%75#0, %75#1, %75#2, %75#3, %75#4, %80#0, %80#1, %80#2, %80#3, %80#4) : (tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index) -> ()
          }) : (i32, i32, i32, tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
          "scf.yield"(%73#0, %73#1, %73#2, %73#3, %73#4, %73#5, %73#6, %73#7, %73#8, %73#9) : (tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index) -> ()
        }) : (i32, i32, i32, tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
        %68 = "tt.addptr"(%67#0, %64) : (tensor<2x2x!tt.ptr<f32>>, tensor<2x2xi32>) -> tensor<2x2x!tt.ptr<f32>>
        %69:5 = "tts.get_structured_state"(%68) <{resultSegmentSizes = array<i32: 1, 2, 2>}> : (tensor<2x2x!tt.ptr<f32>>) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
        "scf.yield"(%69#0, %69#1, %69#2, %69#3, %69#4, %67#5, %67#6, %67#7, %67#8, %67#9) : (tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index) -> ()
      }) : (i32, i32, i32, tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index) -> (tensor<2x2x!tt.ptr<f32>>, index, index, index, index, tensor<2x2x!tt.ptr<f32>>, index, index, index, index)
      "tt.return"() : () -> ()
    }) {noinline = false} : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "tt.func"() <{arg_attrs = [{tt.divisibility = 16 : i32}, {tt.divisibility = 16 : i32}, {}, {tt.divisibility = 16 : i32}], function_type = (!tt.ptr<f32>, !tt.ptr<i8>, i32, i32) -> (), sym_name = "nested1_with_i1_tensor_iter_arg", sym_visibility = "public"}> ({
    ^bb0(%arg0: !tt.ptr<f32>, %arg1: !tt.ptr<i8>, %arg2: i32, %arg3: i32):
      %0 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<8x1024xf32>}> : () -> tensor<8x1024xf32>
      %1 = "arith.constant"() <{value = 1024 : i32}> : () -> i32
      %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %3 = "arith.constant"() <{value = dense<1.000000e+00> : tensor<8x1024xf32>}> : () -> tensor<8x1024xf32>
      %4 = "arith.constant"() <{value = dense<true> : tensor<8x1024xi1>}> : () -> tensor<8x1024xi1>
      %5 = "arith.constant"() <{value = 8 : i32}> : () -> i32
      %6 = "tt.get_program_id"() <{axis = 0 : i32}> : () -> i32
      %7 = "arith.muli"(%6, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %8 = "tt.make_range"() <{end = 8 : i32, start = 0 : i32}> : () -> tensor<8xi32>
      %9 = "tt.expand_dims"(%8) <{axis = 1 : i32}> : (tensor<8xi32>) -> tensor<8x1xi32>
      %10 = "tt.splat"(%7) : (i32) -> tensor<8x1xi32>
      %11 = "arith.addi"(%10, %9) <{overflowFlags = #arith.overflow<none>}> : (tensor<8x1xi32>, tensor<8x1xi32>) -> tensor<8x1xi32>
      %12 = "tt.splat"(%arg3) : (i32) -> tensor<8x1xi32>
      %13 = "arith.muli"(%11, %12) <{overflowFlags = #arith.overflow<none>}> : (tensor<8x1xi32>, tensor<8x1xi32>) -> tensor<8x1xi32>
      %14 = "tt.splat"(%arg0) : (!tt.ptr<f32>) -> tensor<8x1x!tt.ptr<f32>>
      %15 = "tt.addptr"(%14, %13) : (tensor<8x1x!tt.ptr<f32>>, tensor<8x1xi32>) -> tensor<8x1x!tt.ptr<f32>>
      %16 = "tt.splat"(%arg1) : (!tt.ptr<i8>) -> tensor<8x1x!tt.ptr<i8>>
      %17 = "tt.addptr"(%16, %11) : (tensor<8x1x!tt.ptr<i8>>, tensor<8x1xi32>) -> tensor<8x1x!tt.ptr<i8>>
      %18 = "tt.splat"(%arg2) : (i32) -> tensor<8x1xi32>
      %19 = "arith.cmpi"(%11, %18) <{predicate = 2 : i64}> : (tensor<8x1xi32>, tensor<8x1xi32>) -> tensor<8x1xi1>
      %20 = "tt.make_range"() <{end = 1024 : i32, start = 0 : i32}> : () -> tensor<1024xi32>
      %21 = "tt.expand_dims"(%20) <{axis = 0 : i32}> : (tensor<1024xi32>) -> tensor<1x1024xi32>
      %22 = "tt.splat"(%arg3) : (i32) -> tensor<1x1024xi32>
      %23 = "tt.broadcast"(%19) : (tensor<8x1xi1>) -> tensor<8x1024xi1>
      %24 = "tt.broadcast"(%15) : (tensor<8x1x!tt.ptr<f32>>) -> tensor<8x1024x!tt.ptr<f32>>
      %25 = "scf.for"(%2, %arg3, %1, %4) ({
      ^bb0(%arg6: i32, %arg7: tensor<8x1024xi1>):
        %30 = "tt.splat"(%arg6) : (i32) -> tensor<1x1024xi32>
        %31 = "arith.addi"(%30, %21) <{overflowFlags = #arith.overflow<none>}> : (tensor<1x1024xi32>, tensor<1x1024xi32>) -> tensor<1x1024xi32>
        %32 = "arith.cmpi"(%31, %22) <{predicate = 2 : i64}> : (tensor<1x1024xi32>, tensor<1x1024xi32>) -> tensor<1x1024xi1>
        %33 = "tt.broadcast"(%32) : (tensor<1x1024xi1>) -> tensor<8x1024xi1>
        %34 = "arith.andi"(%23, %33) : (tensor<8x1024xi1>, tensor<8x1024xi1>) -> tensor<8x1024xi1>
        %35 = "tt.broadcast"(%31) : (tensor<1x1024xi32>) -> tensor<8x1024xi32>
        %36 = "tt.addptr"(%24, %35) : (tensor<8x1024x!tt.ptr<f32>>, tensor<8x1024xi32>) -> tensor<8x1024x!tt.ptr<f32>>
        %37 = "tt.load"(%36, %34, %3) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 1, 1>}> : (tensor<8x1024x!tt.ptr<f32>>, tensor<8x1024xi1>, tensor<8x1024xf32>) -> tensor<8x1024xf32>
        %38 = "arith.cmpf"(%37, %0) <{fastmath = #arith.fastmath<none>, predicate = 13 : i64}> : (tensor<8x1024xf32>, tensor<8x1024xf32>) -> tensor<8x1024xi1>
        %39 = "arith.andi"(%arg7, %38) : (tensor<8x1024xi1>, tensor<8x1024xi1>) -> tensor<8x1024xi1>
        "scf.yield"(%39) : (tensor<8x1024xi1>) -> ()
      }) : (i32, i32, i32, tensor<8x1024xi1>) -> tensor<8x1024xi1>
      %26 = "tt.reduce"(%25) <{axis = 1 : i32}> ({
      ^bb0(%arg4: i1, %arg5: i1):
        %29 = "arith.andi"(%arg4, %arg5) : (i1, i1) -> i1
        "tt.reduce.return"(%29) : (i1) -> ()
      }) : (tensor<8x1024xi1>) -> tensor<8xi1>
      %27 = "tt.expand_dims"(%26) <{axis = 1 : i32}> : (tensor<8xi1>) -> tensor<8x1xi1>
      %28 = "arith.extui"(%27) : (tensor<8x1xi1>) -> tensor<8x1xi8>
      "tt.store"(%17, %28, %19) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32}> : (tensor<8x1x!tt.ptr<i8>>, tensor<8x1xi8>, tensor<8x1xi1>) -> ()
      "tt.return"() : () -> ()
    }) {noinline = false} : () -> ()
  }) : () -> ()
}) : () -> ()

