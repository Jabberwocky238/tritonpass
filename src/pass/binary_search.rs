//! `triton-binary-search-to-for`（`BinarySearchToFor.cpp`）：二分查找形态的 scf.while 改写成有界的 scf.for。
//!
//! 块级后端一般不收 scf.while；vLLM 注意力 kernel 都用同一个「按全局下标找落在哪个序列」的二分查找。认的形态（严格匹配，认不出
//! 的原样不动，由 P0 点名拒收）：
//!
//!   while (left, right) = (L0, R0)，都是 i32，L0 是非负整数常量：
//!     before: cond = cmpi slt left, right ; condition(cond) left, right
//!     after : mid = divsi(addi(left, right), 2) ；只有标量 arith、`tt.load(addptr(基址, mid))`；
//!             (left', right') = pred ? (mid + 1, right) : (left, mid)（或镜像）；yield left', right'
//!
//! 轮数：区间宽度是编译期常量时取它的 bit_length；R0 是入口整数实参（L0 = 0）时取常数 16，前提「R0 ≤ 65535」记进函数属性
//! `dope.preconditions`；别的形态在运行期精确算。体里：重算 active = left < right，用 select 守住已收敛的轮；带结果的 scf.if
//! 展平成 select；有读时 mid 夹紧到 [0, R0 - 1]。
use std::collections::BTreeMap;

use mlirformat::arith::CmpIPredicate;
use mlirformat::{Attribute, Error, Type};
use mlirpass::{Body, Mapping, OpData, OpId, ValueId, pass};

use crate::ir::{At, Cursor, i64_attr, int};
use crate::{Ir, Kind};

#[pass("triton-binary-search-to-for", on = "builtin.module", ty = BinarySearchToFor)]
pub fn binary_search_to_for<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let matches: Vec<Match> = body.ops_in(op).into_iter().filter(|o| body.is(*o, Kind::ScfWhile)).filter_map(|o| Match::of(body, o)).collect();
    for m in matches {
        m.rewrite(body);
    }
    Ok(())
}

/// 常数轮数（R0 是入口实参时）。
const CONSTANT_TRIPS: i64 = 16;

/// 认出来的一个二分查找。
struct Match {
    loop_: OpId,
    /// after 块里的 divsi 结果
    mid: ValueId,
    has_load: bool,
}

/// 「按 cond 二选一」：arith.select，或带 else 分支、结果取这一个的 scf.if。
struct Choice {
    cond: ValueId,
    when_true: ValueId,
    when_false: ValueId,
    op: OpId,
}

impl Match {
    fn i32(b: &Body<'_>, v: ValueId) -> bool {
        matches!(b.ty(v), Type::Integer { width: 32, .. })
    }

    /// `v` 是 addi(x, 1)（两种次序）就返回 x。
    fn plus_one_base(b: &Body<'_>, v: ValueId) -> Option<ValueId> {
        let add = b.def_of(v, Kind::ArithAddi)?;
        let (l, r) = (b.opd(add, 0), b.opd(add, 1));
        if b.const_int(r) == Some(1) {
            return Some(l);
        }
        (b.const_int(l) == Some(1)).then_some(r)
    }

    fn choice(b: &Body<'_>, v: ValueId) -> Option<Choice> {
        if let Some(s) = b.def_of(v, Kind::ArithSelect) {
            return Some(Choice { cond: b.opd(s, 0), when_true: b.opd(s, 1), when_false: b.opd(s, 2), op: s });
        }
        let i = b.def_of(v, Kind::ScfIf)?;
        let else_region = *b[i].regions.get(1)?;
        if b[else_region].blocks.is_empty() {
            return None;
        }
        let index = b[i].results.iter().position(|r| *r == v)?;
        let then_y = b.terminator(b.entry(i, 0))?;
        let else_y = b.terminator(b.entry(i, 1))?;
        Some(Choice { cond: b.opd(i, 0), when_true: b.opd(then_y, index), when_false: b.opd(else_y, index), op: i })
    }

    /// 值定义在 `loop_` 之外。
    fn outside(b: &Body<'_>, v: ValueId, loop_: OpId) -> bool {
        let block = match b[v].def {
            mlirpass::Def::Result(o, _) => b[o].parent,
            mlirpass::Def::Arg(blk, _) => Some(blk),
        };
        let mut owner = block.and_then(|blk| b.block_owner(blk));
        while let Some(o) = owner {
            if o == loop_ {
                return false;
            }
            owner = b.parent_op(o);
        }
        true
    }

    /// 单个 arith op 能不能在已收敛的轮里照常执行：标量；除与取余的除数是正常量。
    fn safe_arith(b: &Body<'_>, op: OpId) -> bool {
        if !b[op].name.starts_with("arith.") {
            return false;
        }
        if b[op].operands.iter().chain(&b[op].results).any(|v| matches!(b.ty(*v), Type::Shaped(_))) {
            return false;
        }
        if matches!(b.kind(op), Some(Kind::ArithDivsi | Kind::ArithDivui | Kind::ArithRemsi | Kind::ArithRemui | Kind::ArithCeildivsi | Kind::ArithCeildivui | Kind::ArithFloordivsi)) {
            return b.const_int(b.opd(op, 1)).is_some_and(|d| d > 0);
        }
        true
    }

    fn of(b: &Body<'_>, loop_: OpId) -> Option<Self> {
        let inits = &b[loop_].operands;
        if inits.len() != 2 || b[loop_].results.len() != 2 || !inits.iter().chain(&b[loop_].results).all(|v| Self::i32(b, *v)) {
            return None;
        }
        if b.const_int(inits[0]).is_none_or(|l| l < 0) {
            return None;
        }
        let before = b.entry(loop_, 0);
        let (bargs, bops) = (&b[before].args, &b.block_ops(before));
        if bops.len() != 2 || bargs.len() != 2 {
            return None;
        }
        let (cmp, cond) = (bops[0], bops[1]);
        if !b.is(cmp, Kind::ArithCmpi) || !b.is(cond, Kind::ScfCondition) || b.int_attr(cmp, "predicate") != Some(CmpIPredicate::slt as i128) || b.opd(cmp, 0) != bargs[0] || b.opd(cmp, 1) != bargs[1] || b[cond].operands[..] != [b.res(cmp, 0), bargs[0], bargs[1]] {
            return None;
        }
        let after = b.entry(loop_, 1);
        if b[after].args.len() != 2 {
            return None;
        }
        let (left, right) = (b[after].args[0], b[after].args[1]);
        let y = b.terminator(after).filter(|y| b.is(*y, Kind::ScfYield) && b[*y].operands.len() == 2)?;
        let (lc, rc) = (Self::choice(b, b.opd(y, 0))?, Self::choice(b, b.opd(y, 1))?);
        if lc.cond != rc.cond {
            return None;
        }
        let mid = match (Self::plus_one_base(b, lc.when_true), Self::plus_one_base(b, lc.when_false)) {
            (Some(m), _) if lc.when_false == left && rc.when_true == right && rc.when_false == m => m,
            (_, Some(m)) if lc.when_true == left && rc.when_false == right && rc.when_true == m => m,
            _ => return None,
        };
        let div = b.def_of(mid, Kind::ArithDivsi).filter(|d| b[*d].parent == Some(after) && b.const_int(b.opd(*d, 1)) == Some(2))?;
        let sum = b.def_of(b.opd(div, 0), Kind::ArithAddi)?;
        let (sl, sr) = (b.opd(sum, 0), b.opd(sum, 1));
        if !((sl == left && sr == right) || (sl == right && sr == left)) {
            return None;
        }
        let mut has_load = false;
        let ops = &b.block_ops(after);
        for &o in &ops[..ops.len() - 1] {
            if Self::safe_arith(b, o) {
                continue;
            }
            match b.kind(o) {
                Some(Kind::TtAddptr) => {
                    if matches!(b.ty(b.res(o, 0)), Type::Shaped(_)) || !Self::outside(b, b.opd(o, 0), loop_) || matches!(b.ty(b.opd(o, 1)), Type::Shaped(_)) {
                        return None;
                    }
                }
                Some(Kind::TtLoad) => {
                    let addr = b.def_of(b.opd(o, 0), Kind::TtAddptr)?;
                    if b[o].operands.len() != 1 || matches!(b.ty(b.res(o, 0)), Type::Shaped(_)) || b.opd(addr, 1) != mid || !Self::outside(b, b.opd(addr, 0), loop_) {
                        return None;
                    }
                    has_load = true;
                }
                Some(Kind::ScfIf) => {
                    if o != lc.op && o != rc.op {
                        return None;
                    }
                    for r in &b[o].regions {
                        if b[*r].blocks.len() != 1 {
                            return None;
                        }
                        let inner = &b.block_ops(b[*r].blocks[0]);
                        if !inner[..inner.len().saturating_sub(1)].iter().all(|x| Self::safe_arith(b, *x)) {
                            return None;
                        }
                    }
                }
                _ => return None,
            }
        }
        Some(Self { loop_, mid, has_load })
    }

    /// 入口函数（tt.func）入口块的参数：它的下标。
    fn entry_argument(b: &Body<'_>, v: ValueId) -> Option<u32> {
        let mlirpass::Def::Arg(blk, i) = b[v].def else { return None };
        let f = b.block_owner(blk).filter(|f| b.is(*f, Kind::TtFunc))?;
        (b.entry(f, 0) == blk).then_some(i)
    }

    /// 函数属性 `dope.preconditions`：每条 `[实参下标, 系数, 常数]`，意思是 系数·实参 + 常数 ≥ 0；同一条不记两遍。
    fn add_precondition(b: &mut Body<'_>, anchor: OpId, arg: u32, limit: i64) {
        let mut f = b.parent_op(anchor);
        while let Some(o) = f {
            if b.is(o, Kind::TtFunc) {
                break;
            }
            f = b.parent_op(o);
        }
        let Some(f) = f else { return };
        let mut list = match b[f].get("dope.preconditions") {
            Some(Attribute::Array(xs)) => xs.clone(),
            _ => Vec::new(),
        };
        let entry = Attribute::Array(vec![i64_attr(i64::from(arg)), i64_attr(-1), i64_attr(limit)]);
        if !list.contains(&entry) {
            list.push(entry);
        }
        b[f].set("dope.preconditions", Attribute::Array(list));
    }

    #[allow(clippy::too_many_lines)]
    fn rewrite(&self, b: &mut Body<'_>) {
        let loop_ = self.loop_;
        let (init_left, init_right) = (b.opd(loop_, 0), b.opd(loop_, 1));
        let mut consts: BTreeMap<i64, ValueId> = BTreeMap::new();
        let mut c = Cursor::before(b, loop_);
        let mut constant = |c: &mut Cursor<'_, '_>, n: i64| *consts.entry(n).or_insert_with(|| c.i32(n));
        let trip = match (c.body.const_int(init_left), c.body.const_int(init_right)) {
            (Some(lo), Some(hi)) => {
                let width = hi - lo;
                let bits = if width > 0 { 128 - width.leading_zeros() } else { 0 };
                constant(&mut c, i64::from(bits))
            }
            (Some(0), None) if Self::entry_argument(c.body, init_right).is_some() => {
                let t = constant(&mut c, CONSTANT_TRIPS);
                let arg = Self::entry_argument(c.body, init_right).unwrap_or(0);
                Self::add_precondition(c.body, loop_, arg, (1 << CONSTANT_TRIPS) - 1);
                t
            }
            _ => {
                let non_empty = c.cmpi(CmpIPredicate::slt, init_left, init_right);
                let width = c.binary(Kind::ArithSubi, init_right, init_left);
                let zero = constant(&mut c, 0);
                let width_positive = c.cmpi(CmpIPredicate::sgt, width, zero);
                let one = constant(&mut c, 1);
                let mut remaining = c.binary(Kind::ArithMaxsi, width, one);
                let mut log2 = constant(&mut c, 0);
                for shift in [16, 8, 4, 2, 1] {
                    let k = constant(&mut c, 1 << shift);
                    let big = c.cmpi(CmpIPredicate::sge, remaining, k);
                    let s = constant(&mut c, shift);
                    let shifted = c.binary(Kind::ArithShrsi, remaining, s);
                    remaining = c.select(big, shifted, remaining);
                    let s2 = constant(&mut c, shift);
                    let z = constant(&mut c, 0);
                    let inc = c.select(big, s2, z);
                    log2 = c.binary(Kind::ArithAddi, log2, inc);
                }
                let one = constant(&mut c, 1);
                let bit_length = c.binary(Kind::ArithAddi, log2, one);
                let thirty_two = constant(&mut c, 32);
                let t = c.select(width_positive, bit_length, thirty_two);
                let z = constant(&mut c, 0);
                c.select(non_empty, t, z)
            }
        };
        let one = constant(&mut c, 1);
        let last_index = c.binary(Kind::ArithSubi, init_right, one);
        let zero = constant(&mut c, 0);
        let one = constant(&mut c, 1);
        drop(c);

        let after = b.entry(loop_, 1);
        let y = b.terminator(after).expect("after 有 yield");
        let left_if = b.def_of(b.opd(y, 0), Kind::ScfIf);
        let right_if = b.def_of(b.opd(y, 1), Kind::ScfIf);
        // scf.for (0, trip, 1) iter_args(init_left, init_right)
        let i32t = int(32);
        let mut d = OpData::build(Kind::ScfFor.name()).operands(&[zero, trip, one, init_left, init_right]);
        d.loc.clone_from(&b[loop_].loc);
        let for_op = b.create(d, &[i32t.clone(), i32t.clone()]);
        b.insert_before(for_op, loop_);
        let region = b.add_region(for_op);
        let block = b.add_block(region, &[(i32t.clone(), None), (i32t.clone(), None), (i32t.clone(), None)]);
        let loc = b[loop_].loc.clone();
        for a in b[block].args.clone() {
            b[a].loc.clone_from(&loc);
        }
        let (left, right) = (b[block].args[1], b[block].args[2]);
        let mut c = Cursor { body: b, at: At::End(block), loc: loc.clone() };
        let active = c.cmpi(CmpIPredicate::slt, left, right);
        let mut map = Mapping::default();
        map.map(c.body[after].args[0], left);
        map.map(c.body[after].args[1], right);
        let ops = c.body.block_ops(after);
        let mut const_zero_in_body: Option<ValueId> = None;
        for &o in &ops[..ops.len() - 1] {
            if Some(o) == left_if || Some(o) == right_if {
                if !map.values.contains_key(&c.body.res(o, 0)) {
                    Self::flatten_if(&mut c, o, &mut map);
                }
                continue;
            }
            let cloned = c.body.clone_op(o, &mut map);
            c.place(cloned);
            if self.has_load && c.body[o].results.len() == 1 && c.body.res(o, 0) == self.mid {
                let r = c.body.res(cloned, 0);
                let clamped = c.binary(Kind::ArithMinsi, r, last_index);
                // 区间为空（R0 <= 0）时常数轮数的循环也会跑：再夹回 0
                let z = *const_zero_in_body.get_or_insert(zero);
                let clamped = c.binary(Kind::ArithMaxsi, clamped, z);
                map.map(self.mid, clamped);
            }
        }
        let new_left = map.get(c.body.opd(y, 0));
        let new_right = map.get(c.body.opd(y, 1));
        let kept_left = c.select(active, new_left, left);
        let kept_right = c.select(active, new_right, right);
        c.create(OpData::build(Kind::ScfYield.name()).operands(&[kept_left, kept_right]), &[]);
        let results = b[for_op].results.to_vec();
        b.replace_op(loop_, &results);
    }

    /// scf.if 两支的内容（不含终结符）克隆到游标处，结果换成 select。
    fn flatten_if(c: &mut Cursor<'_, '_>, i: OpId, map: &mut Mapping) {
        let iloc = c.body[i].loc.clone();
        for r in 0..2 {
            let blk = c.body.entry(i, r);
            let ops = c.body.block_ops(blk);
            for &o in &ops[..ops.len() - 1] {
                let cl = c.body.clone_op(o, map);
                c.place(cl);
            }
        }
        let cond = map.get(c.body.opd(i, 0));
        let then_y = c.body.terminator(c.body.entry(i, 0)).expect("then 有 yield");
        let else_y = c.body.terminator(c.body.entry(i, 1)).expect("else 有 yield");
        let saved = c.loc.clone();
        c.loc = iloc;
        for (k, r) in c.body[i].results.clone().into_iter().enumerate() {
            let (t, f) = (map.get(c.body.opd(then_y, k)), map.get(c.body.opd(else_y, k)));
            let s = c.select(cond, t, f);
            map.map(r, s);
        }
        c.loc = saved;
    }
}
