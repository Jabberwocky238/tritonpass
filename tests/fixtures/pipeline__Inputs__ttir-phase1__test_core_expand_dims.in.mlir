#loc = loc("triton@v3.7.1/python/test/unit/language/test_core.py":689:0)
#loc2 = loc("dummy"(#loc))
module {
  tt.func public @expand_dims_kernel(%dummy: !tt.ptr<f32> loc("dummy"(#loc))) attributes {noinline = false} {
    tt.return loc(#loc1)
  } loc(#loc)
} loc(#loc)
#loc1 = loc("triton@v3.7.1/python/test/unit/language/test_core.py":726:4)
