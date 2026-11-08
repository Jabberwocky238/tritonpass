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
use mlirpass::{BlockId, Body, OpData, OpId, PatternSet, Rewriter, ValueId, pass, patterns};

use crate::ir::TtBuilder;
use crate::{Ir, Kind};

#[pass("triton-carried-buffers-in-place", on = "builtin.module", ty = CarriedBuffersInPlace)]
pub fn carried_buffers_in_place<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut set = PatternSet::default();
    Carried::patterns(&mut set);
    body.walk_and_apply(op, &set);
    Ok(())
}

/// 携带缓冲的识别与改写。
pub struct Carried;

#[patterns]
impl Carried {
    /// 携带 memref 的 scf.for ⇒ 不携带缓冲：体里直接用初值缓冲，每轮末尾把要 yield 的新缓冲拷回去。
    #[rewrite("scf.for")]
    fn carry_in_place(rw: &mut Rewriter<'_, '_>, l: OpId) -> bool {
        if !Self::rewritable(rw.body, l) {
            return false;
        }
        Self::rewrite(rw, l);
        true
    }
}

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

    fn rewrite(rw: &mut Rewriter<'_, '_>, l: OpId) {
        let b = &*rw.body;
        let old_block = b.entry(l, 0);
        let old_yield = b.terminator(old_block).expect("rewritable 核过有终结符");
        let inits = b[l].operands[3..].to_vec();
        let memref: Vec<bool> = inits.iter().map(|&v| Self::is_memref(b, v)).collect();
        let kept_inits: Vec<ValueId> = inits.iter().zip(&memref).filter(|(_, m)| !**m).map(|(v, _)| *v).collect();
        let (lb, ub, step) = (b.opd(l, 0), b.opd(l, 1), b.opd(l, 2));
        rw.set_before(l);
        let (new, new_block) = rw.for_loop(lb, ub, step, &kept_inits);
        // 旧体整段搬进新体（含旧终结符）：归纳变量换成新的，携带的缓冲就是循环外那块初值缓冲，标量携带值换成新块参数
        let new_args = rw.body[new_block].args.to_vec();
        let mut kept = new_args[1..].iter();
        let mut args = vec![new_args[0]];
        args.extend(inits.iter().zip(&memref).map(|(&init, &m)| if m { init } else { *kept.next().expect("标量携带值一一对应") }));
        rw.inline_block_before(old_block, new_block, None, &args);
        // 每轮末尾把新缓冲拷回初值缓冲，终结符换成只带标量携带值的
        let yielded = rw.body[old_yield].operands.to_vec();
        rw.set_before(old_yield);
        for ((&init, &m), &y) in inits.iter().zip(&memref).zip(&yielded) {
            if m && y != init {
                rw.create(OpData::build(Kind::MemrefCopy.name()).operands(&[y, init]), &[]);
            }
        }
        let kept_yield: Vec<ValueId> = yielded.iter().zip(&memref).filter(|(_, m)| !**m).map(|(v, _)| *v).collect();
        rw.create(OpData::build(Kind::ScfYield.name()).operands(&kept_yield), &[]);
        rw.erase_op(old_yield);
        let new_results = rw.body[new].results.to_vec();
        let mut slot = new_results.iter();
        let with: Vec<ValueId> = inits.iter().zip(&memref).map(|(&init, &m)| if m { init } else { *slot.next().expect("标量结果一一对应") }).collect();
        rw.replace_op(l, &with);
    }
}
