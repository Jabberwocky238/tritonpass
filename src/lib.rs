//! Triton 的 TTIR ⇒ 块级标准 MLIR（func / arith / math / scf / memref / linalg），建在 mlirformat / mlirpass 上。
//
// ```text
//   TTIR（Triton 的 `str(mod)`，自定义形式带 loc）
//      │  tt / tts / ttg 方言 + triton-* pass（结构化访存分析移植自 triton-shared）
//      ▼
//   块级标准 MLIR ⇒ 交给任意以标准 MLIR 为输入的后端
// ```
//
// 用法：在下游的 mlirpass 上下文里 `load_triton(&mut opt)`、`interfaces.register(&TtInterfaces)`、
// `passes.with(TritonPasses::add)`，然后按名字拼流水线。
mod dialect;
mod grid;
mod ir;
mod kind;
mod pass;

pub use dialect::{TtDialect, TtgDialect, TtsDialect, load_triton, pointee};
pub use grid::GridEncoding;
pub use ir::{At, Build, Cursor, DYNAMIC, TtBuilder, Ir, dense_i32, dense_i64, dense_values, float, float_kind, i64_attr, int, integer};
pub use kind::{Kind, Namespace};
pub use pass::*;

// ⚠ mlirpass-macros 的 #[pass] / #[patterns] 展开成 `crate::…`：在根上转出这几个名字。
#[allow(unused_imports, reason = "给 mlirpass 的宏展开用")]
pub(crate) use mlirpass::{ConversionPatterns, ConversionRewriter, Lowering, OpId, OptLowering, OptionValue, Options, PassDecl, Pattern, PatternSet, Plain, Rewriter, Run, ValueId};
