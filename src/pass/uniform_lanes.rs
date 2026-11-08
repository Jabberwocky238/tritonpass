//! `triton-fold-uniform-lanes`（`FoldUniformLanes.cpp`）：一个 tile 里整条都取同一个值的下标张量落回标量，按块对齐的取模
//! 落回 arange，与常量的比较每格都一样的折成常量，无 mask 的一致地址读落回一次标量读。
//!
//!   1. `divsi(x, splat c)`：x = splat(a) + arange(start, end)，c 是正常量，a 非负且是 c 的倍数（或没有 a），整个 tile 落在同一个
//!      商里 ⇒ `splat(a / c + floor(start / c))`；
//!   2. `remsi(x, splat c)`，条件同上 ⇒ `arange(start mod c, start mod c + (end - start))`；
//!   3. `arange` 与常量的比较每格结果一样 ⇒ 全真或全假的常量张量；
//!   4. `addptr(splat p, splat s)` 的无 mask 读 ⇒ `splat(load(addptr(p, s)))`。
//! 改写过就跑一遍 canonicalize（折掉留下的常量 select、取反）；什么都没改就不碰 IR。
use mlirformat::arith::CmpIPredicate;
use mlirformat::{Attribute, Error, Type};
use mlirpass::{Body, Def, OpData, OpId, PassManager, Passes, ValueId, pass};

use crate::ir::{Cursor, dense_i32, int, integer};
use crate::{Ir, Kind};

const MAX_DEPTH: u32 = 8;

#[pass("triton-fold-uniform-lanes", on = "builtin.module", ty = FoldUniformLanes)]
pub fn fold_uniform_lanes<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let (mut divs, mut rems, mut cmps) = (Vec::new(), Vec::new(), Vec::new());
    body.walk_post(op, &mut |o| match body.kind(o) {
        Some(Kind::ArithDivsi) => divs.push(o),
        Some(Kind::ArithRemsi) => rems.push(o),
        Some(Kind::ArithCmpi) => cmps.push(o),
        _ => {}
    });
    let mut changed = false;
    for o in divs {
        changed |= Lanes::fold_div(body, o);
    }
    for o in rems {
        changed |= Lanes::fold_rem(body, o);
    }
    for o in cmps {
        changed |= Lanes::fold_compare(body, o);
    }
    let mut loads = Vec::new();
    body.walk_post(op, &mut |o| {
        if body.is(o, Kind::TtLoad) {
            loads.push(o);
        }
    });
    for o in loads {
        changed |= Lanes::fold_load(body, o);
    }
    if changed {
        Canon::run(body, op)?;
    }
    Ok(())
}

/// 跑本 crate 的 canonicalize（认得 tt）。
pub(crate) struct Canon;

impl Canon {
    pub fn run(body: &mut Body<'_>, op: OpId) -> Result<(), Error> {
        let mut passes = Passes::new();
        passes.register::<mlirpass::Canonicalize>().register::<mlirpass::Cse>();
        PassManager::parse(&passes, &format!("{}(canonicalize)", body[op].name))?.run_on(body, op, &moremath::ThreadSingle)
    }
}

/// 一维 i32 张量 x 的形态：x[i] = base + start + i。
struct Lane {
    base: Option<ValueId>,
    start: i64,
    count: i64,
}

struct Lanes;

impl Lanes {
    fn constant(b: &Body<'_>, v: ValueId) -> Option<i64> {
        b.def_of(v, Kind::ArithConstant)?;
        let c = b.const_int(v)?;
        i64::try_from(c).ok().filter(|_| !matches!(b.ty(v), Type::Shaped(_)))
    }

    /// 张量整数常量的 splat 值，或 tt.splat 铺开的标量常量。
    fn splat_constant(b: &Body<'_>, v: ValueId) -> Option<i64> {
        if b.def_of(v, Kind::ArithConstant).is_some() && matches!(b.ty(v), Type::Shaped(_)) {
            return b.const_int(v).and_then(|c| i64::try_from(c).ok());
        }
        let s = b.def_of(v, Kind::TtSplat)?;
        Self::constant(b, b.opd(s, 0))
    }

    /// 值非负：常量、程序号、下界非负的 scf.for 归纳变量，及它们经加、乘、取 max、无损转换、除以正常量得到的值。
    fn non_negative(b: &Body<'_>, v: ValueId, depth: u32) -> bool {
        if depth > MAX_DEPTH {
            return false;
        }
        if let Some(c) = Self::constant(b, v) {
            return c >= 0;
        }
        if let Def::Arg(blk, i) = b[v].def {
            return b.block_owner(blk).filter(|l| b.is(*l, Kind::ScfFor)).is_some_and(|l| i == 0 && Self::non_negative(b, b.opd(l, 0), depth + 1));
        }
        let Some(def) = b.def_op(v) else { return false };
        match b.kind(def) {
            Some(Kind::TtGetProgramId) => true,
            Some(Kind::ArithAddi | Kind::ArithMuli | Kind::ArithMinsi) => Self::non_negative(b, b.opd(def, 0), depth + 1) && Self::non_negative(b, b.opd(def, 1), depth + 1),
            Some(Kind::ArithMaxsi) => Self::non_negative(b, b.opd(def, 0), depth + 1) || Self::non_negative(b, b.opd(def, 1), depth + 1),
            Some(Kind::ArithExtsi | Kind::ArithExtui | Kind::ArithIndexCast) => Self::non_negative(b, b.opd(def, 0), depth + 1),
            Some(Kind::ArithDivsi | Kind::ArithRemsi) => Self::constant(b, b.opd(def, 1)).is_some_and(|d| d > 0) && Self::non_negative(b, b.opd(def, 0), depth + 1),
            _ => false,
        }
    }

    /// 值是 c 的倍数。
    fn multiple_of(b: &Body<'_>, v: ValueId, c: i64, depth: u32) -> bool {
        if depth > MAX_DEPTH {
            return false;
        }
        if let Some(k) = Self::constant(b, v) {
            return k % c == 0;
        }
        let Some(def) = b.def_op(v) else { return false };
        match b.kind(def) {
            Some(Kind::ArithMuli) => Self::multiple_of(b, b.opd(def, 0), c, depth + 1) || Self::multiple_of(b, b.opd(def, 1), c, depth + 1),
            Some(Kind::ArithAddi | Kind::ArithSubi) => Self::multiple_of(b, b.opd(def, 0), c, depth + 1) && Self::multiple_of(b, b.opd(def, 1), c, depth + 1),
            Some(Kind::ArithExtsi | Kind::ArithIndexCast) => Self::multiple_of(b, b.opd(def, 0), c, depth + 1),
            _ => false,
        }
    }

    fn i32_tensor_1d(t: &Type<'_>) -> bool {
        t.dims().is_some_and(|d| d.len() == 1) && matches!(t.element_type(), Type::Integer { width: 32, .. })
    }

    fn lane(b: &Body<'_>, v: ValueId, depth: u32) -> Option<Lane> {
        if depth > MAX_DEPTH || !Self::i32_tensor_1d(b.ty(v)) {
            return None;
        }
        let def = b.def_op(v)?;
        match b.kind(def) {
            Some(Kind::TtMakeRange) => {
                let (s, e) = (b.int_attr(def, "start")?, b.int_attr(def, "end")?);
                Some(Lane { base: None, start: s as i64, count: (e - s) as i64 })
            }
            Some(Kind::ArithAddi) => {
                for side in 0..2 {
                    let Some(s) = b.def_of(b.opd(def, side), Kind::TtSplat) else { continue };
                    if !matches!(b.ty(b.opd(s, 0)), Type::Integer { width: 32, .. }) {
                        continue;
                    }
                    let rest = Self::lane(b, b.opd(def, 1 - side), depth + 1)?;
                    if rest.base.is_some() {
                        return None;
                    }
                    return Some(Lane { base: Some(b.opd(s, 0)), start: rest.start, count: rest.count });
                }
                None
            }
            _ => None,
        }
    }

    fn aligned(b: &Body<'_>, l: &Lane, c: i64) -> bool {
        if c <= 0 || l.start < 0 || l.count <= 0 || l.start / c != (l.start + l.count - 1) / c {
            return false;
        }
        l.base.is_none_or(|a| Self::non_negative(b, a, 0) && Self::multiple_of(b, a, c, 0))
    }

    fn fold_div(b: &mut Body<'_>, op: OpId) -> bool {
        let (Some(c), Some(l)) = (Self::splat_constant(b, b.opd(op, 1)), Self::lane(b, b.opd(op, 0), 0)) else { return false };
        if !Self::aligned(b, &l, c) {
            return false;
        }
        let ty = b.ty(b.res(op, 0)).clone();
        let mut k = Cursor::before(b, op);
        let mut total = l.base.map(|a| {
            let cv = k.i32(c);
            k.binary(Kind::ArithDivsi, a, cv)
        });
        let tail = l.start / c;
        if tail != 0 || total.is_none() {
            let tv = k.i32(tail);
            total = Some(match total {
                Some(t) => k.binary(Kind::ArithAddi, t, tv),
                None => tv,
            });
        }
        let splat = k.value(Kind::TtSplat, &[total.expect("有值")], ty);
        b.replace_op(op, &[splat]);
        true
    }

    fn fold_rem(b: &mut Body<'_>, op: OpId) -> bool {
        let (Some(c), Some(l)) = (Self::splat_constant(b, b.opd(op, 1)), Self::lane(b, b.opd(op, 0), 0)) else { return false };
        if !Self::aligned(b, &l, c) {
            return false;
        }
        let ty = b.ty(b.res(op, 0)).clone();
        let start = l.start % c;
        let mut k = Cursor::before(b, op);
        let r = k.value_with(Kind::TtMakeRange, &[], &[("end", Attribute::of_int(i128::from(start + l.count), int(32))), ("start", Attribute::of_int(i128::from(start), int(32)))], ty);
        b.replace_op(op, &[r]);
        true
    }

    fn fold_compare(b: &mut Body<'_>, op: OpId) -> bool {
        let Some(c) = Self::splat_constant(b, b.opd(op, 1)) else { return false };
        let Some(range) = b.def_of(b.opd(op, 0), Kind::TtMakeRange) else { return false };
        let ty = b.ty(b.res(op, 0)).clone();
        if !matches!(ty, Type::Shaped(_)) {
            return false;
        }
        let (Some(s), Some(e)) = (b.int_attr(range, "start"), b.int_attr(range, "end")) else { return false };
        let (lo, hi) = (s as i64, e as i64 - 1);
        let pick = |t: bool, f: bool| if t { Some(true) } else if f { Some(false) } else { None };
        let all = match b.int_attr(op, "predicate") {
            Some(p) if p == CmpIPredicate::slt as i128 => pick(hi < c, lo >= c),
            Some(p) if p == CmpIPredicate::sle as i128 => pick(hi <= c, lo > c),
            Some(p) if p == CmpIPredicate::sgt as i128 => pick(lo > c, hi <= c),
            Some(p) if p == CmpIPredicate::sge as i128 => pick(lo >= c, hi < c),
            _ => None,
        };
        let Some(all) = all else { return false };
        let mut k = Cursor::before(b, op);
        let v = k.constant(integer(1, i128::from(all)), ty);
        b.replace_op(op, &[v]);
        true
    }

    fn fold_load(b: &mut Body<'_>, op: OpId) -> bool {
        if b[op].operands.len() != 1 {
            return false;
        }
        let ty = b.ty(b.res(op, 0)).clone();
        if !matches!(ty, Type::Shaped(_)) {
            return false;
        }
        let Some(add) = b.def_of(b.opd(op, 0), Kind::TtAddptr) else { return false };
        let (Some(base), Some(off)) = (b.def_of(b.opd(add, 0), Kind::TtSplat), b.def_of(b.opd(add, 1), Kind::TtSplat)) else { return false };
        let (p, s) = (b.opd(base, 0), b.opd(off, 0));
        let p_ty = b.ty(p).clone();
        let elem = ty.element_type().clone();
        let attrs: Vec<(&str, Attribute<'_>)> = ["cache", "evict", "isVolatile"].iter().filter_map(|n| b[op].get(n).map(|a| (*n, a.clone()))).collect();
        let mut k = Cursor::before(b, op);
        let sp = k.value(Kind::TtAddptr, &[p, s], p_ty);
        let mut d = OpData::build(Kind::TtLoad.name()).operands(&[sp]).with("boundaryCheck", dense_i32(&[])).with("operandSegmentSizes", dense_i32(&[1, 0, 0]));
        for (n, a) in attrs {
            d.set(n, a);
        }
        let l = k.create(d, &[elem]);
        let lv = k.body.res(l, 0);
        let splat = k.value(Kind::TtSplat, &[lv], ty);
        b.replace_op(op, &[splat]);
        true
    }
}
