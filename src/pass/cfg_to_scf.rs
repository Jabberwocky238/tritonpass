//! 上游 `lift-cf-to-scf`（MLIR `Transforms/Utils/CFGToSCF.cpp` + `Conversion/ControlFlowToSCF`）的移植：区域里的 cf 分支
//! 结构化成 `scf.if` / `scf.index_switch`。算法、建 op 的次序与位置逐段照上游（选择码常量插在入口块开头、后建的在前；
//! 返回类 op 先合成一个出口块；分支区域按支配树的先序取块）。
//!
//! ⚠ 只移植了无环的部分：TTIR 里的循环早已是 `scf.for` / `scf.while`，cf 只用来表达早退。区域里有环（cf 的回边）就
//! 报「结构化不了」（[`Lift::Cyclic`]），调用方原样留着交给 P0 拒收——上游会把它结构化成 `scf.while`，这一处不同记在这里。
use std::collections::{BTreeMap, BTreeSet};

use mlirformat::{Attribute, Type};
use mlirpass::{BlockId, Body, OpData, OpId, RegionId, ValueId};

use crate::Kind;
use crate::ir::{Build, Ir, int, integer};

/// 结构化的结局。
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Lift {
    /// 区域本来就只有一块（或是空的），什么也没做
    Unchanged,
    /// 结构化完了
    Done,
    /// 有不支持的形状（不可达的块、不是 cf 的带后继的终结符、环）：IR 可能已经改了一半，调用方要回滚
    Failed,
    /// 有环
    Cyclic,
}

/// 一条边：`from` 块终结符的第 `index` 个后继。
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct Edge {
    from: BlockId,
    index: usize,
}

/// 一次结构化的状态：选择码常量与 poison 的缓存、出口合并表。
pub struct CfgToScf {
    region: RegionId,
    /// 选择码常量（`arith.constant N : i32`），按值缓存
    switch_values: Vec<Option<ValueId>>,
    /// `ub.poison`，按类型缓存
    undef: Vec<(Type<'static>, ValueId)>,
    /// 区域所属 op 的位置（上游 `region.getLoc()`）
    loc: Option<String>,
}

impl CfgToScf {
    /// 结构化 `region`。
    pub fn run(body: &mut Body<'_>, region: RegionId) -> Lift {
        let blocks = body.blocks(region);
        if blocks.len() <= 1 {
            return Lift::Unchanged;
        }
        let owner = body[region].parent;
        let mut s = Self { region, switch_values: Vec::new(), undef: Vec::new(), loc: body[owner].loc.as_deref().map(String::from) };
        if !s.preconditions(body) {
            return Lift::Failed;
        }
        if s.has_cycle(body) {
            return Lift::Cyclic;
        }
        s.combine_exits(body);
        let mut work = vec![body.blocks(region)[0]];
        while let Some(current) = work.pop() {
            match s.branches(body, current) {
                Some(more) => work.extend(more),
                None => return Lift::Failed,
            }
        }
        Lift::Done
    }

    // ---- 后继与后继操作数 ------------------------------------------------------------------

    fn term(body: &Body<'_>, b: BlockId) -> OpId {
        body.terminator(b).expect("块有终结符")
    }

    fn successors(body: &Body<'_>, b: BlockId) -> Vec<BlockId> {
        body.terminator(b).map(|t| body[t].successors.to_vec()).unwrap_or_default()
    }

    /// `operandSegmentSizes` 读成个数表。
    fn segments(body: &Body<'_>, op: OpId, name: &str) -> Vec<usize> {
        match body[op].get(name) {
            Some(Attribute::DenseArray { values, .. }) => values.iter().filter_map(|v| v.parse().ok()).collect(),
            _ => Vec::new(),
        }
    }

    /// 终结符给第 `i` 个后继的操作数在 `operands` 里的区间。
    fn succ_range(body: &Body<'_>, term: OpId, i: usize) -> std::ops::Range<usize> {
        match body.kind(term) {
            Some(Kind::CfBr) => 0..body[term].operands.len(),
            Some(Kind::CfCondBr) => {
                let seg = Self::segments(body, term, "operandSegmentSizes");
                let (t, f) = (seg.get(1).copied().unwrap_or(0), seg.get(2).copied().unwrap_or(0));
                if i == 0 { 1..1 + t } else { 1 + t..1 + t + f }
            }
            Some(Kind::CfSwitch) => {
                let seg = Self::segments(body, term, "operandSegmentSizes");
                let default = seg.get(1).copied().unwrap_or(0);
                if i == 0 {
                    return 1..1 + default;
                }
                let cases = Self::segments(body, term, "case_operand_segments");
                let start = 1 + default + cases.iter().take(i - 1).sum::<usize>();
                start..start + cases.get(i - 1).copied().unwrap_or(0)
            }
            _ => 0..0,
        }
    }

    fn succ_operands(body: &Body<'_>, e: Edge) -> Vec<ValueId> {
        let t = Self::term(body, e.from);
        body[t].operands[Self::succ_range(body, t, e.index)].to_vec()
    }

    /// 换掉第 `i` 个后继的操作数，重写段长。
    fn set_succ_operands(body: &mut Body<'_>, e: Edge, new: &[ValueId]) {
        let t = Self::term(body, e.from);
        let r = Self::succ_range(body, t, e.index);
        let mut ops = body[t].operands.to_vec();
        let old_len = r.len();
        ops.splice(r, new.iter().copied());
        body.set_operands(t, ops);
        match body.kind(t) {
            Some(Kind::CfCondBr) => {
                let mut seg = Self::segments(body, t, "operandSegmentSizes");
                seg[1 + e.index] = new.len();
                Self::put_segments(body, t, "operandSegmentSizes", &seg);
            }
            Some(Kind::CfSwitch) => {
                if e.index == 0 {
                    let mut seg = Self::segments(body, t, "operandSegmentSizes");
                    seg[1] = new.len();
                    Self::put_segments(body, t, "operandSegmentSizes", &seg);
                } else {
                    let mut cases = Self::segments(body, t, "case_operand_segments");
                    cases[e.index - 1] = new.len();
                    Self::put_segments(body, t, "case_operand_segments", &cases);
                    let mut seg = Self::segments(body, t, "operandSegmentSizes");
                    seg[2] = seg[2] + new.len() - old_len;
                    Self::put_segments(body, t, "operandSegmentSizes", &seg);
                }
            }
            _ => {}
        }
    }

    fn put_segments(body: &mut Body<'_>, op: OpId, name: &str, seg: &[usize]) {
        let a = Attribute::DenseArray { ty: int(32), values: seg.iter().map(|n| n.to_string().into()).collect() };
        body[op].set(name, a);
    }

    fn set_successor(body: &mut Body<'_>, e: Edge, to: BlockId) {
        let t = Self::term(body, e.from);
        body[t].successors[e.index] = to;
    }

    fn edges(body: &Body<'_>, b: BlockId) -> Vec<Edge> {
        (0..Self::successors(body, b).len()).map(|index| Edge { from: b, index }).collect()
    }

    /// 区域里指向 `b` 的边。⚠ 上游按使用链的次序（后加的在前）；这里按块序、后继序的逆序取，同一个次序。
    fn preds(&self, body: &Body<'_>, b: BlockId) -> Vec<Edge> {
        let region = body[b].parent.unwrap_or(self.region);
        let mut out: Vec<Edge> = body.blocks(region).into_iter().flat_map(|x| Self::edges(body, x)).filter(|e| Self::successors(body, e.from)[e.index] == b).collect();
        out.reverse();
        out
    }

    fn single_pred(&self, body: &Body<'_>, b: BlockId) -> Option<BlockId> {
        let p = self.preds(body, b);
        (p.len() == 1).then(|| p[0].from)
    }

    // ---- 常量 ----------------------------------------------------------------------------

    /// 插在区域入口块的开头（后建的在前，照上游 `OpBuilder::atBlockBegin`）。
    fn at_region_begin<'a>(&self, body: &mut Body<'a>, mut data: OpData<'a>, ty: Type<'a>) -> ValueId {
        data.loc = self.loc.clone().map(Into::into);
        let o = body.create(data, &[ty]);
        let entry = body.blocks(self.region)[0];
        body.insert(o, entry, Some(0));
        body.res(o, 0)
    }

    /// `getCFGSwitchValue`：`arith.constant N : i32`。
    fn switch_value(&mut self, body: &mut Body<'_>, n: usize) -> ValueId {
        if let Some(Some(v)) = self.switch_values.get(n) {
            return *v;
        }
        let v = self.at_region_begin(body, Body::constant_data(integer(32, n as i128), &int(32)), int(32));
        if self.switch_values.len() <= n {
            self.switch_values.resize(n + 1, None);
        }
        self.switch_values[n] = Some(v);
        v
    }

    /// `getUndefValue`：`ub.poison`。
    fn undef_value(&mut self, body: &mut Body<'_>, ty: &Type<'_>) -> ValueId {
        if let Some((_, v)) = self.undef.iter().find(|(t, _)| t == &ty.owned()) {
            return *v;
        }
        let data = OpData::build(Kind::UbPoison.name()).with("value", Attribute::dialect("ub.poison", ""));
        let v = self.at_region_begin(body, data, ty.owned());
        self.undef.push((ty.owned(), v));
        v
    }

    // ---- 前提 ----------------------------------------------------------------------------

    fn preconditions(&self, body: &Body<'_>) -> bool {
        let blocks = body.blocks(self.region);
        for (i, &b) in blocks.iter().enumerate() {
            if i > 0 && self.preds(body, b).is_empty() {
                return false; // 不可达的块
            }
            let t = Self::term(body, b);
            if !body[t].successors.is_empty() && !matches!(body.kind(t), Some(Kind::CfBr | Kind::CfCondBr | Kind::CfSwitch)) {
                return false;
            }
        }
        true
    }

    fn has_cycle(&self, body: &Body<'_>) -> bool {
        // 有没有回边：从入口 DFS，碰到栈上的块就是环
        let entry = body.blocks(self.region)[0];
        let mut state: BTreeMap<BlockId, u8> = BTreeMap::new();
        let mut stack = vec![(entry, 0usize)];
        state.insert(entry, 1);
        while let Some((b, i)) = stack.pop() {
            let succ = Self::successors(body, b);
            match succ.get(i) {
                Some(&s) => {
                    stack.push((b, i + 1));
                    match state.get(&s) {
                        Some(1) => return true,
                        Some(_) => {}
                        None => {
                            state.insert(s, 1);
                            stack.push((s, 0));
                        }
                    }
                }
                None => {
                    state.insert(b, 2);
                }
            }
        }
        false
    }

    // ---- 返回类 op 合成单出口 ---------------------------------------------------------------

    /// 两个返回类 op 等价：同名、同属性、同操作数类型（操作数本身不论）。
    fn equivalent(body: &Body<'_>, a: OpId, b: OpId) -> bool {
        body[a].name == body[b].name && body[a].properties == body[b].properties && body[a].attributes == body[b].attributes && body.types(&body[a].operands) == body.types(&body[b].operands)
    }

    /// `createSingleExitBlocksForReturnLike`。
    fn combine_exits(&mut self, body: &mut Body<'_>) {
        // 返回类 op ⇒ 合并后的出口块
        let mut exits: Vec<(OpId, BlockId)> = Vec::new();
        let mut i = 0;
        while i < body.blocks(self.region).len() {
            let b = body.blocks(self.region)[i];
            i += 1;
            let t = Self::term(body, b);
            if !body[t].successors.is_empty() {
                continue;
            }
            let found = exits.iter().find(|(r, _)| Self::equivalent(body, *r, t)).copied();
            if let Some((r, _)) = found
                && r == t
            {
                continue;
            }
            let operands = body[t].operands.to_vec();
            let loc = body[t].loc.clone();
            let exit = match found {
                Some((_, e)) => e,
                None => {
                    let tys: Vec<(Type<'_>, Option<mlirformat::Str<'_>>)> = body.types(&operands).into_iter().map(|t| (t, None)).collect();
                    let e = body.add_block(self.region, &tys);
                    for a in body[e].args.clone() {
                        body[a].loc.clone_from(&loc);
                    }
                    exits.push((t, e));
                    e
                }
            };
            // 单目的地的分支：只有缺省目的地的 cf.switch（`createSingleDestinationBranch`）
            let flag = self.switch_value(body, 0);
            let sw = Self::switch_op(body, flag, exit, &operands, &[], &[], loc);
            body.insert_before(sw, t);
            if found.is_some() {
                body.erase(t);
            } else {
                body.detach(t);
                body.insert(t, exit, None);
                let args = body[exit].args.to_vec();
                body.set_operands(t, args);
            }
        }
    }

    /// `cf.switch %flag : i32, [default: ^d(args), N: ^c(args), …]`
    fn switch_op<'a>(body: &mut Body<'a>, flag: ValueId, default: BlockId, default_args: &[ValueId], cases: &[(usize, BlockId)], case_args: &[Vec<ValueId>], loc: Option<mlirformat::Str<'a>>) -> OpId {
        let mut operands = vec![flag];
        operands.extend_from_slice(default_args);
        let case_total: usize = case_args.iter().map(Vec::len).sum();
        case_args.iter().for_each(|a| operands.extend_from_slice(a));
        let mut data = OpData::build(Kind::CfSwitch.name()).operands(&operands);
        if !cases.is_empty() {
            data.set("case_values", Attribute::Builtin { name: "dense".into(), body: format!("<[{}]>", cases.iter().map(|(v, _)| v.to_string()).collect::<Vec<_>>().join(", ")).into(), ty: Some(Type::tensor(&[cases.len() as i64], int(32))) });
        }
        data.set("case_operand_segments", Attribute::DenseArray { ty: int(32), values: case_args.iter().map(|a| a.len().to_string().into()).collect() });
        data.set("operandSegmentSizes", Attribute::DenseArray { ty: int(32), values: vec!["1".into(), default_args.len().to_string().into(), case_total.to_string().into()] });
        data.successors = core::iter::once(default).chain(cases.iter().map(|(_, b)| *b)).collect();
        data.loc = loc;
        body.create(data, &[])
    }

    // ---- 支配树 ----------------------------------------------------------------------------

    /// `entry` 所在区域的支配树：每块的直接支配者，与按 DFS 先序号排的孩子。
    fn dominators(&self, body: &Body<'_>, at: BlockId) -> (BTreeMap<BlockId, BlockId>, BTreeMap<BlockId, Vec<BlockId>>) {
        let region = body[at].parent.unwrap_or(self.region);
        let entry = body.blocks(region)[0];
        // DFS 先序（后继按次序）
        let mut order = Vec::new();
        let mut seen = BTreeSet::new();
        let mut stack = vec![entry];
        while let Some(b) = stack.pop() {
            if !seen.insert(b) {
                continue;
            }
            order.push(b);
            for s in Self::successors(body, b).into_iter().rev() {
                if !seen.contains(&s) {
                    stack.push(s);
                }
            }
        }
        let num: BTreeMap<BlockId, usize> = order.iter().enumerate().map(|(i, b)| (*b, i)).collect();
        // 逆后序上的迭代（Cooper–Harvey–Kennedy）
        let rpo: Vec<BlockId> = body.post_order(entry).into_iter().rev().collect();
        let rpo_num: BTreeMap<BlockId, usize> = rpo.iter().enumerate().map(|(i, b)| (*b, i)).collect();
        let mut idom: BTreeMap<BlockId, BlockId> = BTreeMap::new();
        idom.insert(entry, entry);
        let preds_of = |b: BlockId| -> Vec<BlockId> { self.preds(body, b).into_iter().map(|e| e.from).collect() };
        let mut changed = true;
        while changed {
            changed = false;
            for &b in rpo.iter().skip(1) {
                let mut new: Option<BlockId> = None;
                for p in preds_of(b) {
                    if !idom.contains_key(&p) {
                        continue;
                    }
                    new = Some(match new {
                        None => p,
                        Some(mut x) => {
                            let mut y = p;
                            while x != y {
                                while rpo_num[&x] > rpo_num[&y] {
                                    x = idom[&x];
                                }
                                while rpo_num[&y] > rpo_num[&x] {
                                    y = idom[&y];
                                }
                            }
                            x
                        }
                    });
                }
                if let Some(n) = new
                    && idom.get(&b) != Some(&n)
                {
                    idom.insert(b, n);
                    changed = true;
                }
            }
        }
        let mut children: BTreeMap<BlockId, Vec<BlockId>> = BTreeMap::new();
        let mut by_num: Vec<BlockId> = idom.keys().copied().filter(|b| *b != entry).collect();
        by_num.sort_by_key(|b| num.get(b).copied().unwrap_or(usize::MAX));
        for b in by_num {
            children.entry(idom[&b]).or_default().push(b);
        }
        (idom, children)
    }

    /// 支配树上 `n` 的子树，先序。
    fn dominated(children: &BTreeMap<BlockId, Vec<BlockId>>, n: BlockId) -> Vec<BlockId> {
        let mut out = Vec::new();
        let mut stack = vec![n];
        while let Some(b) = stack.pop() {
            out.push(b);
            if let Some(cs) = children.get(&b) {
                stack.extend(cs.iter().rev());
            }
        }
        out
    }

    // ---- 分支结构化 -------------------------------------------------------------------------

    /// 块挪进 `region` 的末尾。
    fn move_block(body: &mut Body<'_>, b: BlockId, region: RegionId) {
        body.remove_block(b);
        let at = body[region].blocks.len();
        body.region_insert(region, at, b);
        body[b].parent = Some(region);
    }

    /// 新建一个不在任何区域里的块（参数照 `like` 的），先挂在本区域末尾。
    fn new_block_like<'a>(&self, body: &mut Body<'a>, like: Option<BlockId>) -> BlockId {
        let tys: Vec<(Type<'a>, Option<mlirformat::Str<'a>>)> = like.map(|l| body[l].args.iter().map(|a| (body[*a].ty.clone(), None)).collect()).unwrap_or_default();
        let b = body.add_block(self.region, &tys);
        if let Some(l) = like {
            let locs: Vec<_> = body[l].args.iter().map(|a| body[*a].loc.clone()).collect();
            for (a, loc) in body[b].args.clone().into_iter().zip(locs) {
                body[a].loc = loc;
            }
        }
        b
    }

    /// `EdgeMultiplexer::create` + 重定向 + `createSwitch`：所有 `edges` 先到一个新块，再分派到原来的目的地。
    fn multiplex(&mut self, body: &mut Body<'_>, edges: &[Edge]) -> BlockId {
        let loc = body[Self::term(body, edges[0].from)].loc.clone();
        let targets: Vec<BlockId> = edges.iter().map(|e| Self::successors(body, e.from)[e.index]).collect();
        // 新块插在第一个目的地之后
        let region = body[targets[0]].parent.unwrap_or(self.region);
        let m = body.add_block(region, &[]);
        body.remove_block(m);
        let pos = body[region].blocks.iter().position(|b| *b == targets[0]).map_or(0, |p| p + 1);
        body.region_insert(region, pos, m);
        body[m].parent = Some(region);
        // 每个不同的目的地的参数依次加到新块上
        let mut mapping: Vec<(BlockId, usize)> = Vec::new();
        for t in &targets {
            if mapping.iter().any(|(b, _)| b == t) {
                continue;
            }
            let offset = body[m].args.len();
            mapping.push((*t, offset));
            let args: Vec<(Type<'_>, Option<String>)> = body[*t].args.iter().map(|a| (body[*a].ty.clone(), body[*a].loc.as_deref().map(String::from))).collect();
            for (ty, l) in args {
                let a = body.add_arg(m, ty);
                body[a].loc = l.map(Into::into);
            }
        }
        let discriminator = (mapping.len() > 1).then(|| {
            let a = body.add_arg(m, int(32));
            body[a].loc.clone_from(&loc);
            a
        });
        // 重定向
        for e in edges {
            let succ = Self::successors(body, e.from)[e.index];
            let (k, offset) = mapping.iter().enumerate().find(|(_, (b, _))| *b == succ).map(|(k, (_, o))| (k, *o)).expect("边的目的地在表里");
            let old = Self::succ_operands(body, *e);
            let margs = body[m].args.to_vec();
            let n_succ = body[succ].args.len();
            let mut new = Vec::with_capacity(margs.len());
            for (i, a) in margs.iter().enumerate() {
                if i >= offset && i < offset + n_succ {
                    new.push(old[i - offset]);
                } else if Some(*a) == discriminator {
                    new.push(self.switch_value(body, k));
                } else {
                    let ty = body[*a].ty.clone();
                    new.push(self.undef_value(body, &ty));
                }
            }
            Self::set_successor(body, *e, m);
            Self::set_succ_operands(body, *e, &new);
        }
        // 分派：最后一个当缺省
        let margs = body[m].args.to_vec();
        let mut cases: Vec<(usize, BlockId)> = Vec::new();
        let mut case_args: Vec<Vec<ValueId>> = Vec::new();
        for (k, (succ, offset)) in mapping.iter().enumerate() {
            cases.push((k, *succ));
            case_args.push(margs[*offset..*offset + body[*succ].args.len()].to_vec());
        }
        let flag = match discriminator {
            Some(d) if cases.len() > 1 => d,
            _ => self.switch_value(body, 0),
        };
        let (_, default) = cases.pop().expect("至少一个目的地");
        let default_args = case_args.pop().unwrap_or_default();
        let sw = Self::switch_op(body, flag, default, &default_args, &cases, &case_args, loc);
        body.insert(sw, m, Some(0));
        m
    }

    /// `transformToStructuredCFBranches`：`entry` 处的第一处条件分支结构化；返回要接着处理的块，失败是 `None`。
    #[allow(clippy::too_many_lines)]
    fn branches(&mut self, body: &mut Body<'_>, entry: BlockId) -> Option<Vec<BlockId>> {
        let succs = Self::successors(body, entry);
        if succs.is_empty() {
            return Some(Vec::new());
        }
        if succs.len() == 1 {
            // 单后继：拼起来
            let s = succs[0];
            let ops = Self::succ_operands(body, Edge { from: entry, index: 0 });
            for (old, new) in body[s].args.clone().into_iter().zip(ops) {
                body.replace_all_uses(old, new);
            }
            let t = Self::term(body, entry);
            body.erase(t);
                        body.splice(s, None, entry, None);
            body.remove_block(s);
            return Some(vec![entry]);
        }
        let (_, children) = self.dominators(body, entry);
        let mut not_continuation: BTreeSet<BlockId> = BTreeSet::from([entry]);
        let mut regions: Vec<Vec<BlockId>> = vec![Vec::new(); succs.len()];
        for (r, &s) in regions.iter_mut().zip(&succs) {
            if self.single_pred(body, s) != Some(entry) {
                continue;
            }
            for b in Self::dominated(&children, s) {
                r.push(b);
                not_continuation.insert(b);
            }
        }
        let mut continuation_edges: Vec<Edge> = Vec::new();
        let mut post_dominates_all = true;
        let mut no_continuation_edge = true;
        for (i, r) in regions.iter().enumerate() {
            if r.is_empty() {
                continuation_edges.push(Edge { from: entry, index: i });
                no_continuation_edge = false;
                continue;
            }
            for &b in r {
                if Self::successors(body, b).is_empty() {
                    post_dominates_all = false;
                    continuation_edges.extend(self.preds(body, b));
                    continue;
                }
                for e in Self::edges(body, b) {
                    if not_continuation.contains(&Self::successors(body, e.from)[e.index]) {
                        continue;
                    }
                    continuation_edges.push(e);
                    no_continuation_edge = false;
                }
            }
        }
        if no_continuation_edge {
            return Some(succs);
        }
        let targets: BTreeSet<BlockId> = continuation_edges.iter().map(|e| Self::successors(body, e.from)[e.index]).collect();
        let mut continuation = (targets.len() == 1).then(|| *targets.iter().next().expect("一个"));
        if continuation.is_none() || !post_dominates_all {
            continuation = Some(self.multiplex(body, &continuation_edges));
        }
        if !post_dominates_all {
            return Some(vec![entry]);
        }
        let continuation = continuation.expect("有接续块");

        // 建条件区域
        let cond = Self::term(body, entry);
        let result_types: Vec<Type<'_>> = body[continuation].args.iter().map(|a| body[*a].ty.clone()).collect();
        let structured = self.structured_op(body, cond, &result_types)?;
        let new_regions: Vec<RegionId> = body[structured].regions.to_vec();
        let mut empty_blocks: Vec<(BlockId, Vec<ValueId>)> = Vec::new();
        let mut sub_entries = Vec::new();
        for (i, (r, target)) in regions.iter().zip(&new_regions).enumerate() {
            if r.is_empty() {
                let b = self.new_block_like(body, None);
                Self::move_block(body, b, *target);
                empty_blocks.push((b, Self::succ_operands(body, Edge { from: entry, index: i })));
                continue;
            }
            // 单出口：多于一条边到接续块时，建一个空块收拢
            let mut single_exit: Option<BlockId> = None;
            let mut previous: Option<Edge> = None;
            for &b in r {
                for e in Self::edges(body, b) {
                    if Self::successors(body, e.from)[e.index] != continuation {
                        continue;
                    }
                    let Some(p) = previous else {
                        previous = Some(e);
                        continue;
                    };
                    let s = match single_exit {
                        Some(s) => s,
                        None => {
                            let s = self.new_block_like(body, Some(continuation));
                            body.remove_block(s);
                            Self::set_successor(body, p, s);
                            let args = body[s].args.to_vec();
                            empty_blocks.push((s, args));
                            single_exit = Some(s);
                            s
                        }
                    };
                    Self::set_successor(body, e, s);
                }
                Self::move_block(body, b, *target);
            }
            if let Some(s) = single_exit {
                let at = body[*target].blocks.len();
                body.region_insert(*target, at, s);
                body[s].parent = Some(*target);
            }
            // 区域入口的块参数换成入口边的操作数
            let sub = body[*target].blocks[0];
            let ops = Self::succ_operands(body, Edge { from: entry, index: i });
            for (old, new) in body[sub].args.clone().into_iter().zip(ops) {
                body.replace_all_uses(old, new);
            }
            body[sub].args.clear();
            sub_entries.push(sub);
        }
        body.erase(cond);
        let sloc = body[structured].loc.clone();
        for (b, vals) in &empty_blocks {
            let y = Self::yield_op(body, vals, sloc.clone());
            body.insert(y, *b, None);
        }
        // 剩下的、指向接续块的无条件分支换成 yield
        for r in &new_regions {
            for b in body.blocks(*r) {
                let Some(t) = body.terminator(b) else { continue };
                if body[t].successors.first() == Some(&continuation) && body[t].successors.len() == 1 {
                    let vals = Self::succ_operands(body, Edge { from: b, index: 0 });
                    let loc = body[t].loc.clone();
                    let y = Self::yield_op(body, &vals, loc);
                    body.insert_before(y, t);
                    body.erase(t);
                }
            }
        }
        for (old, new) in body[continuation].args.clone().into_iter().zip(body[structured].results.clone()) {
            body.replace_all_uses(old, new);
        }
                body.splice(continuation, None, entry, None);
        body.remove_block(continuation);
        sub_entries.push(entry);
        Some(sub_entries)
    }

    fn yield_op<'a>(body: &mut Body<'a>, vals: &[ValueId], loc: Option<mlirformat::Str<'a>>) -> OpId {
        let mut d = OpData::build(Kind::ScfYield.name()).operands(vals);
        d.loc = loc;
        body.create(d, &[])
    }

    /// `createStructuredBranchRegionOp`：cond_br ⇒ scf.if，switch ⇒ `arith.index_castui` + scf.index_switch；插在终结符之前，区域空着。
    fn structured_op<'a>(&mut self, body: &mut Body<'a>, cond: OpId, results: &[Type<'a>]) -> Option<OpId> {
        let loc = body[cond].loc.clone();
        let results: Vec<Type<'_>> = results.to_vec();
        match body.kind(cond) {
            Some(Kind::CfCondBr) => {
                let c = body.opd(cond, 0);
                let mut d = OpData::build(Kind::ScfIf.name()).operands(&[c]);
                d.loc = loc;
                let op = body.create(d, &results);
                body.insert_before(op, cond);
                body.add_region(op);
                body.add_region(op);
                Some(op)
            }
            Some(Kind::CfSwitch) => {
                let flag = body.opd(cond, 0);
                let mut c = OpData::build(Kind::ArithIndexCastui.name()).operands(&[flag]);
                c.loc.clone_from(&loc);
                let cast = body.create(c, &[Type::Index]);
                body.insert_before(cast, cond);
                let cases: Vec<String> = match body[cond].get("case_values") {
                    Some(Attribute::Builtin { body: text, .. }) => text.trim_matches(|c| c == '<' || c == '>' || c == '[' || c == ']').split(',').map(|s| s.trim().to_string()).filter(|s| !s.is_empty()).collect(),
                    _ => Vec::new(),
                };
                let n = cases.len();
                let mut d = OpData::build(Kind::ScfIndexSwitch.name()).operands(&[body.res(cast, 0)]).with("cases", Attribute::DenseArray { ty: int(64), values: cases.into_iter().map(Into::into).collect() });
                d.loc = loc;
                let op = body.create(d, &results);
                body.insert_before(op, cond);
                for _ in 0..=n {
                    body.add_region(op);
                }
                Some(op)
            }
            _ => None,
        }
    }
}
