//! `triton-carried-buffers-in-place`（`CarriedBuffersInPlace.cpp`）：scf.for 携带的 memref 改成原地更新加拷回，循环不再携带缓冲。
//!
//! 块级后端一般不收「控制流携带 memref」。分配缓冲之后，在线 softmax 一类循环（`M_new = max(M, m_j)`，每轮产出新的
//! M、L，旧值同轮里还要用）bufferization 给的是每轮 yield 一块新缓冲、下一轮当 iter_arg。这里改成：循环外那块初值缓冲就是携带的缓冲，
//! 体里用它，每轮末尾把要 yield 的那块新缓冲拷回去（这时旧值已不再被读）。结果相同，多一次小缓冲的拷贝。
//!
//! 只改写证得出的：初值缓冲由同一个块里排在循环前面的 op 定义、其余用处都在循环之前（循环之后不再读它，拷回去不会改掉别人看得见的
//! 东西）；每个携带的缓冲有各自不同的初值缓冲；没有哪个携带值的 yield 是另一个携带缓冲的块参数（交换，拷回的先后顺序会错）。
//! 认不出的整个循环原样不动，留给下游点名。后序：内层循环先改。
use std::collections::BTreeSet;

use mlirformat::{Error, ShapedKind, Type};
use mlirpass::{BlockId, Body, OpData, OpId, ValueId, pass};

use crate::ir::{At, Cursor};
use crate::{Ir, Kind};

#[pass("triton-carried-buffers-in-place", on = "builtin.module", ty = CarriedBuffersInPlace)]
pub fn carried_buffers_in_place<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut targets = Vec::new();
    body.walk_post(op, &mut |l| {
        if body.is(l, Kind::ScfFor) && Carried::rewritable(body, l) {
            targets.push(l);
        }
    });
    for l in targets {
        Carried::rewrite(body, l);
    }
    Ok(())
}

/// 携带缓冲的识别与改写。
struct Carried;

impl Carried {
    fn is_memref(b: &Body<'_>, v: ValueId) -> bool {
        matches!(b.ty(v), Type::Shaped(s) if s.kind == ShapedKind::MemRef)
    }

    /// `Block::findAncestorOpInBlock`：`op` 或它的祖先里落在 `block` 上的那一条。
    fn ancestor_in_block(b: &Body<'_>, block: BlockId, mut op: OpId) -> Option<OpId> {
        loop {
            let parent = b[op].parent?;
            if parent == block {
                return Some(op);
            }
            op = b.block_owner(parent)?;
        }
    }

    /// `init` 在循环以外的用处全都在循环之前（同一个块里排在循环前面）。
    fn only_used_before(b: &Body<'_>, init: ValueId, l: OpId) -> bool {
        let Some(block) = b[l].parent else { return false };
        b[init].uses.iter().all(|u| u.op == l || Self::ancestor_in_block(b, block, u.op).is_some_and(|a| a != l && b.is_before(a, l)))
    }

    fn rewritable(b: &Body<'_>, l: OpId) -> bool {
        let body = b.entry(l, 0);
        let Some(yield_) = b.terminator(body) else { return false };
        let iter_args = &b[body].args[1..];
        let mut inits = BTreeSet::new();
        let mut any = false;
        for (index, &init) in b[l].operands[3..].iter().enumerate() {
            if !Self::is_memref(b, init) {
                continue;
            }
            any = true;
            if !inits.insert(init) || !Self::only_used_before(b, init, l) {
                return false;
            }
            // 初值缓冲要由同一个块里排在循环前面的 op 定义（块参数不碰）
            let Some(def) = b.def_op(init) else { return false };
            if b[def].parent != b[l].parent || !b.is_before(def, l) {
                return false;
            }
            let yielded = b.opd(yield_, index);
            if iter_args.iter().enumerate().any(|(other, &arg)| other != index && yielded == arg && Self::is_memref(b, arg)) {
                return false; // 交换：拷回的先后顺序会错
            }
        }
        any
    }

    fn rewrite(b: &mut Body<'_>, l: OpId) {
        let old_block = b.entry(l, 0);
        let old_yield = b.terminator(old_block).expect("rewritable 核过有终结符");
        let inits = b[l].operands[3..].to_vec();
        let memref: Vec<bool> = inits.iter().map(|&v| Self::is_memref(b, v)).collect();
        let kept_inits: Vec<ValueId> = inits.iter().zip(&memref).filter(|(_, m)| !**m).map(|(v, _)| *v).collect();
        let (lb, ub, step) = (b.opd(l, 0), b.opd(l, 1), b.opd(l, 2));
        let loc = b[l].loc.clone();
        let (new, new_block) = Cursor::before(b, l).for_loop(lb, ub, step, &kept_inits);
        let old_args = b[old_block].args.to_vec();
        let new_args = b[new_block].args.to_vec();
        b.replace_all_uses(old_args[0], new_args[0]);
        let mut kept = new_args[1..].iter();
        for ((&init, &m), &old) in inits.iter().zip(&memref).zip(&old_args[1..]) {
            // 携带的缓冲就是循环外那块初值缓冲
            let to = if m { init } else { *kept.next().expect("标量携带值一一对应") };
            b.replace_all_uses(old, to);
        }
        // 旧体整段搬进新体（含旧终结符），每轮末尾把新缓冲拷回初值缓冲，终结符换成只带标量携带值的
        b.splice(old_block, None, new_block, None);
        let yielded = b[old_yield].operands.to_vec();
        let mut c = Cursor { body: b, at: At::Before(old_yield), loc };
        for ((&init, &m), &y) in inits.iter().zip(&memref).zip(&yielded) {
            if m && y != init {
                c.create(OpData::build(Kind::MemrefCopy.name()).operands(&[y, init]), &[]);
            }
        }
        let kept_yield: Vec<ValueId> = yielded.iter().zip(&memref).filter(|(_, m)| !**m).map(|(v, _)| *v).collect();
        c.create(OpData::build(Kind::ScfYield.name()).operands(&kept_yield), &[]);
        b.erase(old_yield);
        let old_results = b[l].results.to_vec();
        let new_results = b[new].results.to_vec();
        let mut slot = new_results.iter();
        for ((&init, &m), &r) in inits.iter().zip(&memref).zip(&old_results) {
            let to = if m { init } else { *slot.next().expect("标量结果一一对应") };
            b.replace_all_uses(r, to);
        }
        b.erase(l);
    }
}
