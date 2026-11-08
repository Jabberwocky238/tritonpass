#loc = loc("triton@v3.7.1/python/test/unit/language/test_core.py":2558:0)
#loc2 = loc("triton@v3.7.1/python/test/unit/language/test_core.py":2560:15)
#loc3 = loc(unknown)
#loc7 = loc("out_ptr"(#loc))
#loc8 = loc("x"(#loc2))
#loc10 = loc(callsite(#loc3 at #loc8))
module {
  tt.func public @kernel_dtype(%out_ptr: !tt.ptr<i32> loc("out_ptr"(#loc))) attributes {noinline = false} {
    %x = arith.constant dense<1> : tensor<1024xi32> loc(#loc9)
    %x_0 = "tt.reduce"(%x) <{axis = 0 : i32}> ({
    ^bb0(%x_1: i32 loc(callsite(#loc3 at #loc8)), %x_2: i32 loc(callsite(#loc3 at #loc8))):
      %x_3 = arith.addi %x_1, %x_2 : i32 loc(#loc11)
      tt.reduce.return %x_3 : i32 loc(#loc9)
    }) : (tensor<1024xi32>) -> i32 loc(#loc9)
    tt.store %out_ptr, %x_0 : !tt.ptr<i32> loc(#loc5)
    tt.return loc(#loc6)
  } loc(#loc)
} loc(#loc)
#loc1 = loc("triton@v3.7.1/python/triton/language/standard.py":293:36)
#loc4 = loc("triton@v3.7.1/python/triton/language/standard.py":263:15)
#loc5 = loc("triton@v3.7.1/python/test/unit/language/test_core.py":2561:22)
#loc6 = loc("triton@v3.7.1/python/test/unit/language/test_core.py":2561:4)
#loc9 = loc(callsite(#loc1 at #loc8))
#loc11 = loc(callsite(#loc4 at #loc9))
