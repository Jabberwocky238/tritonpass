//! `triton-squeeze-unit-dims`（`SqueezeUnitDims.cpp`）：访存窗口里 size 为 1、行距为 0 的维没有真实范围，从窗口里去掉；
//! 丢掉的维的平坦偏移并进第一个留下的维，mask 的有效个数乘进去；读出的值 `tensor.expand_shape` 回原形，存入的值先
//! `tensor.collapse_shape`。任何窗口要留单位维当载体（偏移没地方落）时整个 kernel 不动、记 `dope.keep_unit_dims`
//! （拆过行轴的 kernel 只跳过那个窗口）。
use mlirformat::{Attribute, Error, Type};
use mlirpass::{Body, OpData, OpId, ValueId, pass};

use super::ofr::Ofr;
use super::window::{Tptr, Window};
use crate::ir::{Cursor, dense_i32, dense_i64, dense_values, i64_attr};
use crate::{Ir, Kind};

#[pass("triton-squeeze-unit-dims", on = "builtin.module", ty = SqueezeUnitDims)]
pub fn squeeze_unit_dims<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let split = body[op].get(Squeeze::SPLIT).is_some();
    body[op].remove(Squeeze::SPLIT);
    let mut accesses = Vec::new();
    body.walk_post(op, &mut |o| {
        if matches!(body.kind(o), Some(Kind::TtsLoad | Kind::TtsStore)) {
            accesses.push(o);
        }
    });
    let window = |b: &Body<'_>, a: OpId| b.def_of(b.opd(a, 0), Kind::TtsMakeTptr).map(|m| (m, Tptr::of(b, m)));
    for &a in &accesses {
        let Some((_, t)) = window(body, a) else { continue };
        let drop = Squeeze::droppable(body, &t);
        if !drop.is_empty() && Squeeze::needs_carrier(body, &t, &drop) {
            if split {
                continue;
            }
            body[op].set(Squeeze::KEEP, Attribute::Unit);
            return Ok(());
        }
    }
    for a in accesses {
        let Some((make, t)) = window(body, a) else { continue };
        let drop = Squeeze::droppable(body, &t);
        if drop.is_empty() || (split && Squeeze::needs_carrier(body, &t, &drop)) {
            continue;
        }
        Squeeze { drop: &drop, t: &t }.rewrite(body, a);
        if body[body.res(make, 0)].uses.is_empty() {
            body.erase(make);
        }
    }
    Ok(())
}

struct Squeeze<'d> {
    drop: &'d [usize],
    t: &'d Tptr,
}

impl Squeeze<'_> {
    const SPLIT: &'static str = "dope.split_row_axis";
    const KEEP: &'static str = "dope.keep_unit_dims";

    /// 要丢的维：size 为 1 且静态行距为 0；全是这样的维时留最后一维。
    fn droppable(b: &Body<'_>, t: &Tptr) -> Vec<usize> {
        if t.is_block_ptr() || !t.is_structured_ptr() || t.sizes.len() < 2 {
            return Vec::new();
        }
        let mut drop: Vec<usize> = (0..t.sizes.len()).filter(|d| t.sizes[*d] == 1 && Window::const_int(b, t.strides[*d]) == Some(0)).collect();
        if drop.len() == t.sizes.len() {
            drop.pop();
        }
        drop
    }

    /// 留下的维没有静态行距 1、窗口却带着非零偏移：要留一个单位维当载体。
    fn needs_carrier(b: &Body<'_>, t: &Tptr, drop: &[usize]) -> bool {
        if (0..t.strides.len()).any(|d| !drop.contains(&d) && Window::const_int(b, t.strides[d]) == Some(1)) || drop.is_empty() {
            return false;
        }
        t.offsets.iter().any(|o| Window::const_int(b, *o) != Some(0))
    }

    /// 去掉丢的维：偏移加进第一个留下的维（`fold` 是加还是乘）。
    fn fold(&self, c: &mut Cursor<'_, '_>, xs: &[Ofr], mul: bool) -> Vec<Ofr> {
        let mut carried = Ofr::idx(i64::from(mul));
        for &d in self.drop {
            carried = if mul { c.mul_ofr(carried, xs[d]) } else { c.add_ofr(carried, xs[d]) };
        }
        let mut first = true;
        let mut out = Vec::new();
        for (d, x) in xs.iter().enumerate() {
            if self.drop.contains(&d) {
                continue;
            }
            out.push(match (first, mul) {
                (false, _) => *x,
                (true, false) => c.add_ofr(*x, carried),
                (true, true) => c.mul_ofr(*x, carried),
            });
            first = false;
        }
        out
    }

    fn kept<T: Copy>(&self, xs: &[T]) -> Vec<T> {
        xs.iter().enumerate().filter(|(d, _)| !self.drop.contains(d)).map(|(_, x)| *x).collect()
    }

    /// 每个留下的维带上紧随其后的丢掉的维；开头丢掉的维并进第一个留下的维。
    fn reassociation(&self, rank: usize) -> Attribute<'static> {
        let mut groups = Vec::new();
        let mut cur = Vec::new();
        let mut kept = false;
        for d in 0..rank {
            let dropped = self.drop.contains(&d);
            if !dropped && kept {
                groups.push(Attribute::Array(core::mem::take(&mut cur)));
            }
            cur.push(i64_attr(d as i64));
            kept |= !dropped;
        }
        groups.push(Attribute::Array(cur));
        Attribute::Array(groups)
    }

    fn mask_dims(b: &Body<'_>, op: OpId, from: usize, n: usize) -> Vec<Ofr> {
        Tptr::mixed(b, op, "static_mask_dims", &b[op].operands[from..from + n])
    }

    fn split_dims(dims: &[Ofr]) -> (Vec<ValueId>, Vec<i64>) {
        (dims.iter().filter_map(|d| d.value()).collect(), dims.iter().map(|d| d.static_value()).collect())
    }

    fn rewrite(&self, b: &mut Body<'_>, op: OpId) {
        let t = self.t;
        let load = b.is(op, Kind::TtsLoad);
        let n = dense_values(b[op].get("static_mask_dims")).len();
        let ops = b[op].operands.clone();
        let (mask, other) = if load {
            let seg = dense_values(b[op].get("operandSegmentSizes"));
            let nd = seg.get(1).copied().unwrap_or(0) as usize;
            let other = (seg.get(2).copied().unwrap_or(0) > 0).then(|| ops[1 + nd]);
            (if n > 0 { Self::mask_dims(b, op, 1, nd) } else { Vec::new() }, other)
        } else {
            (if n > 0 { Self::mask_dims(b, op, 2, ops.len() - 2) } else { Vec::new() }, None)
        };
        let full_ty = b.ty(if load { b.res(op, 0) } else { ops[1] }).clone();
        let full_dims = full_ty.dims().unwrap_or_default();
        let rank = t.sizes.len();
        let re = self.reassociation(rank);
        let mut c = Cursor::before(b, op);
        let offsets = self.fold(&mut c, &t.offsets, false);
        let sizes = self.kept(&t.sizes);
        let strides = self.kept(&t.strides);
        let base_ty = c.body.ty(t.base).clone();
        let to = |xs: &[Ofr]| xs.iter().map(|o| crate::ir::Ofr::from(*o)).collect::<Vec<_>>();
        let shape = vec![crate::ir::Ofr::C(0); sizes.len()];
        let ptr = c.make_tptr(t.base, &sizes, &to(&strides), &to(&offsets), &shape, &[], Type::tensor(&sizes, base_ty));
        let mask = if mask.is_empty() { mask } else { self.fold(&mut c, &mask, true) };
        let (dynd, statd) = Self::split_dims(&mask);
        let small = Type::tensor(&self.kept(&full_dims), full_ty.element_type().owned());
        if load {
            let mut operands = vec![ptr];
            operands.extend(&dynd);
            operands.extend(other);
            let d = OpData::build(Kind::TtsLoad.name()).operands(&operands).with("operandSegmentSizes", dense_i32(&[1, dynd.len() as i64, i64::from(other.is_some())])).with("static_mask_dims", dense_i64(&statd));
            let l = c.create(d, &[small]);
            let lv = c.body.res(l, 0);
            let e = OpData::build(Kind::TensorExpandShape.name()).operands(&[lv]).with("reassociation", re).with("static_output_shape", dense_i64(&full_dims));
            let e = c.create(e, &[full_ty]);
            let ev = c.body.res(e, 0);
            b.replace_op(op, &[ev]);
        } else {
            let col = OpData::build(Kind::TensorCollapseShape.name()).operands(&[ops[1]]).with("reassociation", re);
            let col = c.create(col, &[small]);
            let cv = c.body.res(col, 0);
            let mut operands = vec![ptr, cv];
            operands.extend(&dynd);
            c.create(OpData::build(Kind::TtsStore.name()).operands(&operands).with("static_mask_dims", dense_i64(&statd)), &[]);
            b.erase(op);
        }
    }
}
