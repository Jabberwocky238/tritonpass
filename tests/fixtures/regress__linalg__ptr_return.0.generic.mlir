// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> memref<?xf32>, sym_name = "ext", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "caller"}> ({
  ^bb0(%arg0: i32):
    %0 = "func.call"(%arg0) <{callee = @ext}> : (i32) -> memref<?xf32>
    %1 = "builtin.unrealized_conversion_cast"(%0) : (memref<?xf32>) -> !tt.ptr<f32>
    %2 = "tt.load"(%1) <{boundaryCheck = array<i32>, cache = 1 : i32, evict = 1 : i32, isVolatile = false, operandSegmentSizes = array<i32: 1, 0, 0>}> : (!tt.ptr<f32>) -> f32
    %3 = "arith.fptosi"(%2) : (f32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

