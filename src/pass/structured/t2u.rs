//! `triton-to-unstructured`（triton-shared `TritonToUnstructuredPass.cpp`）：结构化不了的访存落成 `tts.gather` / `tts.scatter`：
//! 一个取自入口实参的基址加一份偏移张量。从入口的指针实参（与 tt.int_to_ptr）起按使用链广度优先走，tt.addptr 换成偏移的加法、
//! splat / broadcast / expand_dims 换成偏移上的同名 op、scf.for 的携带指针改成携带偏移。成了再跑 canonicalize、cse。
//! 失败照 C++：已经做的改动留着，只是不再往下（语料里不出现）。
use std::collections::{BTreeMap, BTreeSet, VecDeque};

use mlirformat::{Error, Type};
use mlirpass::{Body, OpData, OpId, PassManager, Passes, ValueId, pass};

use crate::ir::{dense_i32, int, integer, TtBuilder};
use mlirpass::{Quiet, Rewriter};
use crate::{Ir, Kind};

/// 选项同 triton-shared 的 `Passes.td`。
#[pass("triton-to-unstructured", on = "builtin.module")]
pub struct TritonToUnstructured {
    /// 每个指针起始偏移的位宽
    #[opt("offset-bit-width", default = 32)]
    offset_bits: u32,
}

impl mlirpass::Run for TritonToUnstructured {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        if !(Unstructured { bits: self.offset_bits, ..Unstructured::default() }).process(body, op) {
            return Ok(());
        }
        let mut passes = Passes::new();
        passes.register::<mlirpass::Canonicalize>().register::<mlirpass::Cse>();
        PassManager::parse(&passes, &format!("{}(canonicalize, cse)", body[op].name))?.run_on(body, op, &moremath::ThreadSingle)
    }
}

#[derive(Default)]
struct Unstructured {
    /// 值 ⇒（基址, 指针类型, 位宽, 偏移）
    map: BTreeMap<ValueId, (ValueId, Type<'static>, u32, ValueId)>,
    /// `offset-bit-width`
    bits: u32,
}

fn ptr_like(t: &Type<'_>) -> bool {
    matches!(t.element_type(), Type::Extended(e) if e.name == "tt.ptr")
}

/// 指针类型 ⇒ 同形的整数偏移类型。
fn offset_type(t: &Type<'_>, bits: u32) -> Type<'static> {
    match t {
        Type::Shaped(_) => Type::tensor(&t.dims().unwrap_or_default(), int(bits)),
        _ => int(bits),
    }
}

impl Unstructured {
    #[allow(clippy::too_many_lines)]
    fn process(&mut self, b: &mut Body<'_>, root: OpId) -> bool {
        let default_bits = self.bits;
        let mut args: BTreeSet<ValueId> = BTreeSet::new();
        let mut work: VecDeque<ValueId> = VecDeque::new();
        let mut funcs = Vec::new();
        b.walk_post(root, &mut |o| {
            if matches!(b.kind(o), Some(Kind::TtFunc | Kind::FuncFunc)) && !b[b[o].regions[0]].blocks.is_empty() {
                funcs.push(o);
            }
        });
        for f in funcs {
            let entry = b.entry(f, 0);
            for a in b[entry].args.to_vec() {
                if !ptr_like(b.ty(a)) {
                    continue;
                }
                let loc = b[a].loc.clone();
                let mut q = Quiet;
                let mut c = Rewriter::new(b, &mut q);
                c.set_start(entry);
                c.loc = loc;
                let zero = c.scalar(integer(default_bits, 0), int(default_bits));
                args.insert(a);
                let t = b.ty(a).owned();
                self.map.entry(a).or_insert((a, t, default_bits, zero));
                work.push_back(a);
            }
        }
        let mut i2p = Vec::new();
        b.walk_post(root, &mut |o| {
            if b.is(o, Kind::TtIntToPtr) && !matches!(b.ty(b.res(o, 0)), Type::Shaped(_)) {
                i2p.push(o);
            }
        });
        for o in i2p {
            let mut q = Quiet;
            let mut c = Rewriter::new(b, &mut q);
            c.before_op(o);
            let zero = c.scalar(integer(default_bits, 0), int(default_bits));
            let r = b.res(o, 0);
            let t = b.ty(r).owned();
            self.map.entry(r).or_insert((r, t, default_bits, zero));
            work.push_back(r);
        }
        let mut to_delete: Vec<OpId> = Vec::new();
        let mut users: Vec<OpId> = Vec::new();
        while let Some(v) = work.pop_front() {
            let uses: Vec<mlirpass::Use> = b[v].uses.iter().rev().copied().collect();
            for u in uses {
                let user = u.op;
                let ok = match b.kind(user) {
                    Some(Kind::TtPtrToInt) => {
                        if matches!(b.ty(b.res(user, 0)), Type::Shaped(_)) {
                            false
                        } else {
                            let (p, pt, _, off) = self.map[&b.opd(user, 0)].clone();
                            let mut q = Quiet;
                            let mut c = Rewriter::new(b, &mut q);
                            c.before_op(user);
                            let m = c.value(Kind::TtAddptr, &[p, off], pt);
                            b.set_operand(user, 0, m);
                            true
                        }
                    }
                    Some(Kind::TtAddptr) => {
                        let (p, pt, lw, prev) = self.map[&b.opd(user, 0)].clone();
                        let mut off = b.opd(user, 1);
                        let rw = b.ty(off).element_type().int_width().map_or(32, |x| x.0);
                        let w = lw.max(rw);
                        let mut q = Quiet;
                        let mut c = Rewriter::new(b, &mut q);
                        c.before_op(user);
                        let prev = if lw < w { c.value(Kind::ArithExtsi, &[prev], offset_type(&pt, w)) } else { prev };
                        if rw < w {
                            off = c.value(Kind::ArithExtsi, &[off], offset_type(&pt, w));
                        }
                        let rt = c.body.ty(c.body.res(user, 0)).owned();
                        let acc = c.value(Kind::ArithAddi, &[prev, off], offset_type(&rt, w));
                        let r = b.res(user, 0);
                        self.map.entry(r).or_insert((p, rt, w, acc));
                        work.push_back(r);
                        to_delete.push(user);
                        true
                    }
                    Some(k @ (Kind::TtSplat | Kind::TtBroadcast | Kind::TtExpandDims)) => {
                        let r = b.res(user, 0);
                        let rt = b.ty(r).owned();
                        if ptr_like(&rt) {
                            let (p, _, w, off) = self.map[&b.opd(user, 0)].clone();
                            let mut q = Quiet;
                            let mut c = Rewriter::new(b, &mut q);
                            c.before_op(user);
                            // C++ 用不带属性的通用 `create` 克隆
                            let o = c.create(OpData::named(k.name()).operands(&[off]), &[offset_type(&rt, w)]);
                            let nv = c.body.res(o, 0);
                            self.map.entry(r).or_insert((p, rt, w, nv));
                            work.push_back(r);
                            to_delete.push(user);
                        }
                        true
                    }
                    Some(Kind::TtsMakeGatherScatterTptr) => true,
                    Some(Kind::TtLoad | Kind::TtStore | Kind::TtMakeTensorPtr) => {
                        users.push(user);
                        true
                    }
                    Some(Kind::TtsMakeTptr) => {
                        if !args.contains(&b.opd(user, 0)) {
                            users.push(user);
                        }
                        true
                    }
                    Some(Kind::ScfFor) => {
                        let idx = u.index as usize - 3;
                        let init = b.opd(user, 3 + idx);
                        let (p, pt, w, _) = self.map[&init].clone();
                        let ot = offset_type(&pt, w);
                        let it = b[b.entry(user, 0)].args[idx + 1];
                        b[it].ty = ot.clone();
                        let r = b.res(user, idx);
                        b[r].ty = ot;
                        self.map.entry(it).or_insert((p, pt.clone(), w, it));
                        self.map.entry(r).or_insert((p, pt, w, r));
                        work.push_back(it);
                        work.push_back(r);
                        true
                    }
                    Some(Kind::ScfYield) => !b.parent_op(user).is_some_and(|p| b.is(p, Kind::ScfIf)),
                    _ => false,
                };
                if !ok {
                    return false;
                }
            }
        }
        for op in users {
            let ok = match b.kind(op) {
                Some(Kind::TtLoad) => {
                    let (p, _, _, off) = self.map[&b.opd(op, 0)].clone();
                    let mask = (b[op].operands.len() >= 2).then(|| b.opd(op, 1));
                    let other = (b[op].operands.len() >= 3).then(|| b.opd(op, 2));
                    let rt = b.ty(b.res(op, 0)).clone();
                    let mut q = Quiet;
                    let mut c = Rewriter::new(b, &mut q);
                    c.before_op(op);
                    let other = match other {
                        Some(o) => match crate::pass::ptr_analysis::PtrAnalysis::scalar_value_pub(o, &mut c) {
                            Some(s) => Some(s),
                            None => return false,
                        },
                        None => None,
                    };
                    let mut operands = vec![p, off];
                    operands.extend(mask);
                    operands.extend(other);
                    let g = c.create(OpData::build(Kind::TtsGather.name()).operands(&operands).with("operandSegmentSizes", dense_i32(&[1, 1, i64::from(mask.is_some()), i64::from(other.is_some())])), &[rt]);
                    let gv = c.body.res(g, 0);
                    b.replace_op(op, &[gv]);
                    true
                }
                Some(Kind::TtStore) => {
                    let (p, _, _, off) = self.map[&b.opd(op, 0)].clone();
                    let val = b.opd(op, 1);
                    let mask = (b[op].operands.len() >= 3).then(|| b.opd(op, 2));
                    let mut q = Quiet;
                    let mut c = Rewriter::new(b, &mut q);
                    c.before_op(op);
                    let mut operands = vec![p, off, val];
                    operands.extend(mask);
                    c.create(OpData::build(Kind::TtsScatter.name()).operands(&operands), &[]);
                    b.erase(op);
                    true
                }
                Some(Kind::TtsMakeTptr | Kind::TtMakeTensorPtr) => {
                    let (p, _, _, base_off) = self.map[&b.opd(op, 0)].clone();
                    b.set_operand(op, 0, p);
                    // 第一个动态偏移操作数（tts.make_tptr：基址、行距之后；tt.make_tensor_ptr：shape、strides 之后）
                    let at = if b.is(op, Kind::TtsMakeTptr) {
                        let seg = crate::ir::dense_values(b[op].get("operandSegmentSizes"));
                        1 + seg.get(1).copied().unwrap_or(0) as usize
                    } else {
                        1 + 2 * (b[op].operands.len() - 1) / 3
                    };
                    let cur = b.opd(op, at);
                    let (bt, ct) = (b.ty(base_off).clone(), b.ty(cur).clone());
                    let mut q = Quiet;
                    let mut c = Rewriter::new(b, &mut q);
                    c.before_op(op);
                    let mut bo = base_off;
                    if bt != ct {
                        if matches!(ct, Type::Index) {
                            bo = c.value(Kind::ArithIndexCast, &[bo], Type::Index);
                        } else if let (Some((bw, _)), Some((cw, _))) = (bt.int_width(), ct.int_width()) {
                            bo = c.value(if bw < cw { Kind::ArithExtsi } else { Kind::ArithTrunci }, &[bo], ct.owned());
                        }
                    }
                    let acc = c.value(Kind::ArithAddi, &[bo, cur], ct.owned());
                    b.set_operand(op, at, acc);
                    true
                }
                _ => false,
            };
            if !ok {
                return false;
            }
        }
        for op in to_delete {
            let r = b.res(op, 0);
            let off = self.map[&r].3;
            b.replace_op(op, &[off]);
        }
        true
    }
}
