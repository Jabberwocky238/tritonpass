//! `triton-conditional-fold-unit-dims`（`Pipeline.cpp`）：上游 `linalg-fold-unit-extent-dims`（MLIR
//! `DropUnitDims.cpp`，reshape 策略），模块上记了 `dope.keep_unit_dims` 的 kernel 跳过（属性摘掉）。
//!
//! 上游两段：walk 驱动对每个 `linalg.generic` 试一次 `DropUnitDims`（去掉单位循环维、操作数里由常数 0 索引的单位维，
//! 操作数 `tensor.collapse_shape`、结果 `tensor.expand_shape` 回原形）；再贪婪跑 `MoveInitOperandsToInput`、
//! extract_slice 降秩、tensor 的 collapse / expand、fill、empty 的规范化与 `populateFoldTensorEmptyPatterns`。
use mlirformat::{AffineMap, Attribute, Error};
use mlirpass::{Body, DropUnitDimsStrategy, GreedyConfig, OpId, pass};

#[pass("triton-conditional-fold-unit-dims", on = "builtin.module", ty = ConditionalFoldUnitDims)]
pub fn conditional_fold_unit_dims<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    if body[op].get(Fold::KEEP).is_some() {
        body[op].remove(Fold::KEEP);
        return Ok(());
    }
    // 上游 linalg-fold-unit-extent-dims（reshape 策略），mlirpass 的同一份
    let s = DropUnitDimsStrategy::ReassociativeReshape;
    body.walk_and_apply(op, &s.patterns());
    let set = s.canonicalizations();
    for r in body[op].regions.clone() {
        body.apply_greedily(r, &set, &GreedyConfig::default());
    }
    Ok(())
}

pub struct Fold;

impl Fold {
    const KEEP: &'static str = "dope.keep_unit_dims";

    pub fn maps(b: &Body<'_>, op: OpId) -> Vec<AffineMap> {
        match b[op].get("indexing_maps") {
            Some(Attribute::Array(xs)) => xs
                .iter()
                .filter_map(|a| match a {
                    Attribute::Builtin { name, body, .. } if name == "affine_map" => AffineMap::parse(body),
                    _ => None,
                })
                .collect(),
            _ => Vec::new(),
        }
    }
}
