//! Triton 的 pass：TTIR 上的规范化、结构化访存分析（triton-shared 的移植）、到 linalg / memref 的转换。全是 mlirpass 的 pass，
//! 按名字登记在 [`TritonPasses`] 里。
#[path = "pass/binary_search.rs"]
mod binary_search;
#[path = "pass/canon.rs"]
mod canon;
#[path = "pass/carried_buffers.rs"]
mod carried_buffers;
#[path = "pass/drops.rs"]
mod drops;
#[path = "pass/iota_integers.rs"]
mod iota_integers;
#[path = "pass/lift_cf.rs"]
mod lift_cf;
#[path = "pass/linalg/arith_to_linalg.rs"]
mod arith_to_linalg;
#[path = "pass/linalg/structured_to_memref.rs"]
mod structured_to_memref;
#[path = "pass/linalg/ptr_to_memref.rs"]
mod ptr_to_memref;
#[path = "pass/linalg/fold_unit_dims.rs"]
mod fold_unit_dims;
#[path = "pass/loops.rs"]
mod loops;
#[path = "pass/ptrs.rs"]
mod ptrs;
#[path = "pass/split_row_axis.rs"]
mod split_row_axis;
#[path = "pass/squeeze_unit_dims.rs"]
mod squeeze_unit_dims;
#[path = "pass/structured/mask.rs"]
mod mask;
#[path = "pass/structured/ofr.rs"]
mod ofr;
#[path = "pass/structured/ptr_analysis.rs"]
mod ptr_analysis;
#[path = "pass/structured/ptr_state.rs"]
mod ptr_state;
#[path = "pass/structured/t2s.rs"]
mod t2s;
#[path = "pass/structured/t2u.rs"]
mod t2u;
#[path = "pass/window.rs"]
mod window;
#[path = "pass/uniform_lanes.rs"]
mod uniform_lanes;

use mlirpass::Passes;

pub use arith_to_linalg::TritonArithToLinalg;
pub use binary_search::BinarySearchToFor;
pub use canon::TtInterfaces;
pub use carried_buffers::CarriedBuffersInPlace;
pub use drops::{DropAssume, DropThreadBarrier};
pub use fold_unit_dims::{ConditionalFoldUnitDims, Fold};
pub use iota_integers::FoldIotaIntegers;
pub use lift_cf::{DropDeadExitSwitch, LiftCfToScf};
pub use loops::{LoopLowerBoundZero, LoopUnitStep, NormalizeLoopIndex};
pub use ofr::{Ofr, OfrBuilder};
pub use ptr_to_memref::TritonPtrToMemref;
pub use ptrs::{LowerBoolPtr, ScalarPtr};
pub use split_row_axis::SplitRowAxis;
pub use squeeze_unit_dims::SqueezeUnitDims;
pub use structured_to_memref::StructuredToMemref;
pub use t2s::TritonToStructured;
pub use t2u::TritonToUnstructured;
pub use uniform_lanes::FoldUniformLanes;
pub use window::{StrideInfo, StrideKind, Tptr, UNBOUNDED, Window, WindowIssue, WindowPlan};

/// 本 crate 的全部 pass：`Passes::with(TritonPasses::add)` 登记。
pub struct TritonPasses;

impl TritonPasses {
    pub fn add(p: &mut Passes) {
        p.register::<LiftCfToScf>()
            .register::<DropDeadExitSwitch>()
            .register::<BinarySearchToFor>()
            .register::<DropThreadBarrier>()
            .register::<DropAssume>()
            .register::<LoopLowerBoundZero>()
            .register::<FoldUniformLanes>()
            .register::<FoldIotaIntegers>()
            .register::<SplitRowAxis>()
            .register::<NormalizeLoopIndex>()
            .register::<LowerBoolPtr>()
            .register::<ScalarPtr>()
            .register::<TritonToStructured>()
            .register::<TritonToUnstructured>()
            .register::<SqueezeUnitDims>()
            .register::<TritonArithToLinalg>()
            .register::<StructuredToMemref>()
            .register::<TritonPtrToMemref>()
            .register::<ConditionalFoldUnitDims>()
            .register::<LoopUnitStep>()
            .register::<CarriedBuffersInPlace>();
    }
}
