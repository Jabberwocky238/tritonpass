//! `triton-conditional-fold-unit-dims`（`Pipeline.cpp`）：上游 `linalg-fold-unit-extent-dims`（MLIR
//! `DropUnitDims.cpp`，reshape 策略），模块上记了 `dope.keep_unit_dims` 的 kernel 跳过（属性摘掉）。
//!
//! 上游两段：walk 驱动对每个 `linalg.generic` 试一次 `DropUnitDims`（去掉单位循环维、操作数里由常数 0 索引的单位维，
//! 操作数 `tensor.collapse_shape`、结果 `tensor.expand_shape` 回原形）；再贪婪跑 `MoveInitOperandsToInput`、
//! extract_slice 降秩、tensor 的 collapse / expand、fill、empty 的规范化与 `populateFoldTensorEmptyPatterns`。
use std::collections::{BTreeMap, BTreeSet};

use mlirformat::{AffineExpr, AffineMap, Attribute, Dim, Error, Type};
use mlirpass::{Body, GreedyConfig, Mapping, OpData, OpId, Pattern, Quiet, Rewriter, ValueId, canonicalization_patterns, pass};

use crate::ir::{dense_i32, dense_i64, i64_attr};
use crate::{Ir, Kind};

#[pass("triton-conditional-fold-unit-dims", on = "builtin.module", ty = ConditionalFoldUnitDims)]
pub fn conditional_fold_unit_dims<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    if body[op].get(Fold::KEEP).is_some() {
        body[op].remove(Fold::KEEP);
        return Ok(());
    }
    let mut generics = Vec::new();
    body.walk_post(op, &mut |o| {
        if body.is(o, Kind::LinalgGeneric) {
            generics.push(o);
        }
    });
    let mut quiet = Quiet;
    for g in generics {
        if body[g].parent.is_none() {
            continue;
        }
        let mut rw = Rewriter::new(body, &mut quiet);
        Fold::drop_unit_dims(&mut rw, g);
    }
    let mut set = canonicalization_patterns();
    set.retain(|p| Fold::CANON.contains(&p.name()));
    set.add(MoveInitOperandsToInput).add(RankReducedExtractSlice).add(FoldEmptyWithReshape(Kind::TensorExpandShape)).add(FoldEmptyWithReshape(Kind::TensorCollapseShape)).add(FoldEmptyWithExtractSlice);
    let region = body[op].regions[0];
    body.apply_greedily(region, &set, &GreedyConfig::default());
    Ok(())
}

pub struct Fold;

impl Fold {
    const KEEP: &'static str = "dope.keep_unit_dims";

    /// 上游 tensor collapse / expand、linalg.fill、tensor.empty 的规范化模式（mlirpass 里的名字）。
    const CANON: [&'static str; 24] = [
        "ComposeCollapseOfCollapse", "ComposeCollapseOfExpandOp", "CollapseWithConstant", "CollapseWithSplat", "CollapseWithFromElements", "FoldCollapseOfCastOp",
        "ComposeExpandOfExpand", "ComposeExpandOfCollapseOp", "ConvertToStaticExpandShape", "ExpandWithConstant", "ExpandWithSplat", "ExpandWithFromElements",
        "FoldConcatsOfFill", "FoldFillWithCopy", "FoldFillWithTensorExtract", "FoldFillWithPack", "FoldFillWithPad", "FoldFillWithCollapse", "FoldFillWithExpand", "FoldInsertPadIntoFill", "FoldFillWithTranspose",
        "FoldEmptyTensorWithCastOp", "FoldEmptyTensorWithDimOp", "ReplaceEmptyTensorStaticShapeDims",
    ];

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

    fn iterators<'a>(b: &Body<'a>, op: OpId) -> Vec<Attribute<'a>> {
        match b[op].get("iterator_types") {
            Some(Attribute::Array(xs)) => xs.clone(),
            _ => Vec::new(),
        }
    }

    fn parallel(a: &Attribute<'_>) -> bool {
        *a == Attribute::dialect("linalg.iterator_type", "<parallel>")
    }

    /// `inversePermutation(concatAffineMaps(maps))`：每个循环维第一次以 `d_i` 出现的结果位置。
    fn inverse(maps: &[AffineMap]) -> Option<Vec<usize>> {
        let n = maps.first().map_or(0, |m| m.dims) as usize;
        let mut seen = vec![None; n];
        for (i, e) in maps.iter().flat_map(|m| m.results.iter()).enumerate() {
            if let AffineExpr::Dim(d) = e
                && seen[*d as usize].is_none()
            {
                seen[*d as usize] = Some(i);
            }
        }
        seen.into_iter().collect()
    }

    fn static_shape(b: &Body<'_>, v: ValueId) -> Vec<i64> {
        b.ty(v).dims().unwrap_or_default()
    }

    /// `dropUnitDims`（GenericOp）：换掉就 true。
    fn drop_unit_dims(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let maps = Self::maps(b, op);
        if maps.is_empty() {
            return false;
        }
        let Some(inv) = Self::inverse(&maps) else { return false };
        let operands = b[op].operands.to_vec();
        let ninputs = b.segments(op, "operandSegmentSizes").map_or(operands.len() - 1, |s| s[0]);
        let shapes: Vec<Vec<i64>> = operands.iter().map(|v| Self::static_shape(b, *v)).collect();
        let all: Vec<i64> = shapes.iter().flatten().copied().collect();
        let unit: BTreeSet<usize> = inv.iter().enumerate().filter(|(_, pos)| all[**pos] == 1).map(|(d, _)| d).collect();
        let nloops = maps[0].dims as usize;
        let mut old_to_new = BTreeMap::new();
        let mut repl = Vec::new();
        for d in 0..nloops {
            if unit.contains(&d) {
                repl.push(AffineExpr::Const(0));
            } else {
                repl.push(AffineExpr::Dim(old_to_new.len() as u32));
                old_to_new.insert(d, old_to_new.len());
            }
        }
        let infos: Vec<Info> = maps.iter().zip(&shapes).map(|(m, s)| Info::of(m, s, &old_to_new, &repl)).collect();
        let new_maps: Vec<AffineMap> = infos.iter().map(|i| i.map.clone()).collect();
        if new_maps == maps || Self::inverse(&new_maps).is_none() {
            return false;
        }
        let collapsed: Vec<bool> = infos.iter().zip(&maps).map(|(i, m)| i.map.results.len() != m.results.len()).collect();
        if operands.iter().zip(&collapsed).any(|(v, c)| *c && !matches!(rw.body.ty(*v), Type::Shaped(s) if s.kind == mlirformat::ShapedKind::Tensor)) {
            return false;
        }
        let loc = rw.body[op].loc.clone();
        rw.set_before(op);
        let mut news = Vec::new();
        for (k, v) in operands.iter().enumerate() {
            if !collapsed[k] {
                news.push(*v);
                continue;
            }
            let et = rw.body.ty(*v).element_type().clone();
            let mut d = OpData::build(Kind::TensorCollapseShape.name()).operands(&[*v]).with("reassociation", Reassoc::attr(&infos[k].reassoc));
            d.loc.clone_from(&loc);
            let c = rw.create(d, &[Type::tensor(&infos[k].shape, et)]);
            news.push(rw.body.res(c, 0));
        }
        let iters: Vec<Attribute<'_>> = Self::iterators(rw.body, op).into_iter().enumerate().filter(|(i, _)| !unit.contains(i)).map(|(_, a)| a).collect();
        let outs = &news[ninputs..];
        let rts: Vec<Type<'_>> = outs.iter().map(|v| rw.body.ty(*v).clone()).collect();
        let mut d = OpData::build(Kind::LinalgGeneric.name())
            .operands(&news)
            .with("indexing_maps", Attribute::Array(new_maps.iter().map(Attribute::from).collect()))
            .with("iterator_types", Attribute::Array(iters))
            .with("operandSegmentSizes", dense_i32(&[ninputs as i64, (news.len() - ninputs) as i64]));
        d.loc.clone_from(&loc);
        let old_region = rw.body[op].regions[0];
        let g = rw.create_with(d, &rts, |b, o| {
            let r = b.add_region(o);
            b.clone_region_into(old_region, r, None, &mut Mapping::default());
        });
        Self::replace_index_ops(rw.body, g, &unit);
        let mut results = Vec::new();
        for (i, r) in rw.body[g].results.to_vec().into_iter().enumerate() {
            let k = ninputs + i;
            if !collapsed[k] {
                results.push(r);
                continue;
            }
            let orig = rw.body.ty(operands[k]).clone();
            let mut e = OpData::build(Kind::TensorExpandShape.name()).operands(&[r]).with("reassociation", Reassoc::attr(&infos[k].reassoc)).with("static_output_shape", dense_i64(&shapes[k]));
            e.loc.clone_from(&loc);
            let x = rw.create(e, &[orig]);
            results.push(rw.body.res(x, 0));
        }
        rw.replace_op(op, &results);
        true
    }

    /// `replaceUnitDimIndexOps`。
    fn replace_index_ops(b: &mut Body<'_>, g: OpId, unit: &BTreeSet<usize>) {
        let blk = b.entry(g, 0);
        for o in b.block_ops(blk) {
            if !b.is(o, Kind::LinalgIndex) {
                continue;
            }
            let dim = b.int_attr(o, "dim").unwrap_or(0) as usize;
            let loc = b[o].loc.clone();
            let new = if unit.contains(&dim) {
                let mut d = OpData::build(Kind::ArithConstant.name()).with("value", Attribute::index(0));
                d.loc = loc;
                b.create(d, &[Type::Index])
            } else {
                let dropped = unit.iter().filter(|u| **u < dim).count();
                if dropped == 0 {
                    continue;
                }
                let mut d = OpData::build(Kind::LinalgIndex.name()).with("dim", Attribute::integer((dim - dropped) as i128, Type::int(64)));
                d.loc = loc;
                b.create(d, &[Type::Index])
            };
            b.insert_before(new, o);
            let v = b.res(new, 0);
            b.replace_op(o, &[v]);
        }
    }
}

/// `UnitExtentReplacementInfo`。
struct Info {
    map: AffineMap,
    reassoc: Vec<Vec<i64>>,
    shape: Vec<i64>,
}

impl Info {
    /// `dropUnitExtentFromOperandMetadata`。
    fn of(m: &AffineMap, shape: &[i64], old_to_new: &BTreeMap<usize, usize>, repl: &[AffineExpr]) -> Self {
        let exprs = &m.results;
        let unit = |d: usize| match &exprs[d] {
            AffineExpr::Dim(p) => !old_to_new.contains_key(&(*p as usize)) && shape[d] == 1,
            e => shape[d] == 1 && e.replace(repl, &[]).simplify(old_to_new.len() as u32, m.syms).as_const() == Some(0),
        };
        let mut info = Self { map: AffineMap { dims: old_to_new.len() as u32, syms: m.syms, results: Vec::new() }, reassoc: Vec::new(), shape: Vec::new() };
        let mut group = Vec::new();
        let mut d = 0;
        while d < shape.len() && unit(d) {
            group.push(d as i64);
            d += 1;
        }
        while d < shape.len() {
            group.push(d as i64);
            info.map.results.push(exprs[d].replace(repl, &[]).simplify(old_to_new.len() as u32, m.syms));
            info.shape.push(shape[d]);
            d += 1;
            while d < shape.len() && unit(d) {
                group.push(d as i64);
                d += 1;
            }
            info.reassoc.push(core::mem::take(&mut group));
        }
        info
    }
}

struct Reassoc;

impl Reassoc {
    fn attr(groups: &[Vec<i64>]) -> Attribute<'static> {
        Attribute::Array(groups.iter().map(|g| Attribute::Array(g.iter().map(|i| i64_attr(*i)).collect())).collect())
    }

    /// `getReassociationMapForFoldingUnitDims`（静态尺寸，动态的当非单位）。
    fn folding_unit_dims(sizes: &[i64]) -> Vec<Vec<i64>> {
        let mut out: Vec<Vec<i64>> = Vec::new();
        let mut cur = Vec::new();
        for (d, s) in sizes.iter().enumerate() {
            cur.push(d as i64);
            if *s == 1 {
                continue;
            }
            out.push(core::mem::take(&mut cur));
        }
        if !cur.is_empty()
            && let Some(last) = out.last_mut()
        {
            last.extend(cur);
        }
        out
    }
}

/// `MoveInitOperandsToInput`。
struct MoveInitOperandsToInput;

impl Pattern for MoveInitOperandsToInput {
    fn name(&self) -> &str {
        "MoveInitOperandsToInput"
    }

    fn root(&self) -> Option<&str> {
        Some(Kind::LinalgGeneric.name())
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let operands = b[op].operands.to_vec();
        if operands.iter().chain(b[op].results.iter()).any(|v| matches!(b.ty(*v), Type::Shaped(s) if s.kind == mlirformat::ShapedKind::MemRef)) {
            return false;
        }
        let iters = Fold::iterators(b, op);
        if !iters.iter().all(Fold::parallel) {
            return false;
        }
        let ninputs = b.segments(op, "operandSegmentSizes").map_or(operands.len() - 1, |s| s[0]);
        let blk = b.entry(op, 0);
        let args = b[blk].args.to_vec();
        let candidates: Vec<usize> = (ninputs..operands.len()).filter(|k| !b[args[*k]].uses.is_empty()).collect();
        if candidates.is_empty() {
            return false;
        }
        let maps = Fold::maps(b, op);
        let mut new_maps: Vec<AffineMap> = maps[..ninputs].to_vec();
        let mut ins: Vec<ValueId> = operands[..ninputs].to_vec();
        for k in &candidates {
            ins.push(operands[*k]);
            new_maps.push(maps[*k].clone());
        }
        new_maps.extend(maps[ninputs..].iter().cloned());
        let loc = b[op].loc.clone();
        let mut outs: Vec<ValueId> = operands[ninputs..].to_vec();
        for k in &candidates {
            let v = operands[*k];
            let t = rw.body.ty(v).clone();
            match rw.body.def_op(v) {
                Some(d) => rw.set_after(d),
                None => {
                    let Some(vb) = (match rw.body[v].def {
                        mlirpass::Def::Arg(vb, _) => Some(vb),
                        mlirpass::Def::Result(..) => None,
                    }) else { return false };
                    rw.set_start(vb);
                }
            }
            let mut e = OpData::build(Kind::TensorEmpty.name());
            e.loc.clone_from(&loc);
            let dims = t.dims().unwrap_or_default();
            if dims.contains(&Dim::DYNAMIC) {
                return false;
            }
            let o = rw.create(e, &[Type::tensor(&dims, t.element_type().clone())]);
            outs[*k - ninputs] = rw.body.res(o, 0);
        }
        rw.set_before(op);
        let mut all = ins.clone();
        all.extend(&outs);
        let mut d = OpData::build(Kind::LinalgGeneric.name())
            .operands(&all)
            .with("indexing_maps", Attribute::Array(new_maps.iter().map(Attribute::from).collect()))
            .with("iterator_types", Attribute::Array(iters))
            .with("operandSegmentSizes", dense_i32(&[ins.len() as i64, outs.len() as i64]));
        d.attributes.clone_from(&rw.body[op].attributes);
        d.loc.clone_from(&loc);
        let rts: Vec<Type<'_>> = rw.body[op].results.iter().map(|r| rw.body.ty(*r).clone()).collect();
        let body_ops = rw.body.block_ops(blk);
        let g = rw.create_with(d, &rts, |b, o| {
            let r = b.add_region(o);
            let mut types: Vec<(Type<'_>, Option<mlirformat::Str<'_>>)> = Vec::new();
            for a in &args[..ninputs] {
                types.push((b.ty(*a).clone(), loc.clone()));
            }
            for k in &candidates {
                types.push((b.ty(args[*k]).clone(), loc.clone()));
            }
            for a in &args[ninputs..] {
                types.push((b.ty(*a).clone(), loc.clone()));
            }
            let nb = b.add_block(r, &types);
            let nargs = b[nb].args.to_vec();
            let mut map = Mapping::default();
            for (i, a) in args[..ninputs].iter().enumerate() {
                map.map(*a, nargs[i]);
            }
            for (j, k) in candidates.iter().enumerate() {
                map.map(args[*k], nargs[ninputs + j]);
            }
            for (j, a) in args[ninputs..].iter().enumerate() {
                if !candidates.contains(&(ninputs + j)) {
                    map.map(*a, nargs[ninputs + candidates.len() + j]);
                }
            }
            for bo in body_ops {
                let c = b.clone_op(bo, &mut map);
                b.insert(c, nb, None);
            }
        });
        let results = rw.body[g].results.to_vec();
        rw.replace_op(op, &results);
        true
    }
}

/// `RankReducedExtractSliceOp`。
struct RankReducedExtractSlice;

impl Pattern for RankReducedExtractSlice {
    fn name(&self) -> &str {
        "RankReducedExtractSliceOp"
    }

    fn root(&self) -> Option<&str> {
        Some(Kind::TensorExtractSlice.name())
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let rt = b.ty(b.res(op, 0)).clone();
        let shape = rt.dims().unwrap_or_default();
        let re = Reassoc::folding_unit_dims(&shape);
        if re.len() == shape.len() {
            return false;
        }
        let mut drop = shape.len() - re.len();
        let reduced: Vec<i64> = shape.iter().copied().filter(|s| {
            if *s == 1 && drop > 0 {
                drop -= 1;
                false
            } else {
                true
            }
        }).collect();
        let mut d = b[op].clone();
        d.results = mlirpass::Ids::new();
        d.regions = mlirpass::Ids::new();
        d.parent = None;
        let loc = d.loc.clone();
        rw.set_before(op);
        let s = rw.create(d, &[Type::tensor(&reduced, rt.element_type().clone())]);
        let sv = rw.body.res(s, 0);
        // ExpandShapeOp 的 builder 推 output_shape：动态维是新切片的 tensor.dim，折成切片的 size 操作数
        let seg = rw.body.segments(s, "operandSegmentSizes").unwrap_or_default();
        let (no, ns) = (seg.get(1).copied().unwrap_or(0), seg.get(2).copied().unwrap_or(0));
        let mut eops = vec![sv];
        eops.extend(rw.body[s].operands[1 + no..1 + no + ns].iter().copied());
        let mut e = OpData::build(Kind::TensorExpandShape.name()).operands(&eops).with("reassociation", Reassoc::attr(&re)).with("static_output_shape", dense_i64(&shape));
        e.loc = loc;
        let x = rw.create(e, &[rt]);
        let xv = rw.body.res(x, 0);
        rw.replace_op(op, &[xv]);
        true
    }
}

/// `FoldEmptyTensorWithReshapeOp`（静态形状）。
struct FoldEmptyWithReshape(Kind);

impl Pattern for FoldEmptyWithReshape {
    fn name(&self) -> &str {
        "FoldEmptyTensorWithReshapeOp"
    }

    fn root(&self) -> Option<&str> {
        Some(self.0.name())
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        if b.def_of(b.opd(op, 0), Kind::TensorEmpty).is_none() {
            return false;
        }
        let rt = b.ty(b.res(op, 0)).clone();
        if rt.dims().unwrap_or_default().contains(&Dim::DYNAMIC) {
            return false;
        }
        let mut e = OpData::build(Kind::TensorEmpty.name());
        e.loc.clone_from(&b[op].loc);
        rw.set_before(op);
        let n = rw.create(e, &[rt]);
        let v = rw.body.res(n, 0);
        rw.replace_op(op, &[v]);
        true
    }
}

/// `FoldEmptyTensorWithExtractSliceOp`。
struct FoldEmptyWithExtractSlice;

impl Pattern for FoldEmptyWithExtractSlice {
    fn name(&self) -> &str {
        "FoldEmptyTensorWithExtractSliceOp"
    }

    fn root(&self) -> Option<&str> {
        Some(Kind::TensorExtractSlice.name())
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        if b.def_of(b.opd(op, 0), Kind::TensorEmpty).is_none() {
            return false;
        }
        let seg = b.segments(op, "operandSegmentSizes").unwrap_or_default();
        let (no, ns) = (seg.get(1).copied().unwrap_or(0), seg.get(2).copied().unwrap_or(0));
        let sizes: Vec<ValueId> = b[op].operands[1 + no..1 + no + ns].to_vec();
        let rt = b.ty(b.res(op, 0)).clone();
        let mut e = OpData::build(Kind::TensorEmpty.name()).operands(&sizes);
        e.loc.clone_from(&b[op].loc);
        rw.set_before(op);
        let n = rw.create(e, &[rt]);
        let v = rw.body.res(n, 0);
        rw.replace_op(op, &[v]);
        true
    }
}
