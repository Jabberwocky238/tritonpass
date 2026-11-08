//! Triton 的方言：`tt`（Triton 3.7.1 的 `TritonOps.td`）、`tts`（triton-shared 的结构化方言，`TritonStructuredDialect.td`）。
//! 两个 `.gen.rs` 由 `mlirformat tblgen` 生成，不手改；语法写在 C++ 里的 op 手写在 `tt_hand`，按名字注入。
#[path = "dialect/tt.gen.rs"]
mod tt;
#[path = "dialect/tt_hand.rs"]
mod tt_hand;
#[path = "dialect/tts.gen.rs"]
mod tts;
#[path = "dialect/ttg.rs"]
mod ttg;
#[path = "dialect/traits.gen.rs"]
mod traits;
#[path = "dialect/upstream_hand.rs"]
mod upstream_hand;

use mlirformat::{MlirOpt, Op};

pub use tt::TtDialect;
pub use tt_hand::pointee;
pub use tts::TtsDialect;
pub use ttg::TtgDialect;

/// 往 `opt` 里装 Triton 的方言，并注入手写语法的 op。
pub fn load_triton(opt: &mut MlirOpt) {
    opt.load(TtDialect);
    opt.load(TtsDialect);
    opt.load(TtgDialect);
    traits::register(opt.infos_mut());
    opt.inject(tt_hand::FuncOp::template())
        .inject(tt_hand::CallOp::template())
        .inject(tt_hand::LoadOp::template())
        .inject(tt_hand::StoreOp::template())
        .inject(tt_hand::AtomicRMWOp::template())
        .inject(tt_hand::AtomicCASOp::template())
        .inject(tt_hand::GatherOp::template())
        .inject(tt_hand::ExternElementwiseOp::template())
        .inject(tt_hand::UnsplatOp::template())
        .inject(tt_hand::DescriptorLoadOp::template())
        .inject(tt_hand::DescriptorGatherOp::template())
        .inject(tt_hand::DescriptorScatterOp::template())
        .inject(tt_hand::DotOp::template())
        .inject(tt_hand::MakeTensorPtrOp::template())
        .inject(tt_hand::MakeTensorDescOp::template())
        .inject(tt_hand::ClampFOp::template())
        .inject(upstream_hand::WhileOp::template())
        .inject(upstream_hand::AssumeOp::template());
}
