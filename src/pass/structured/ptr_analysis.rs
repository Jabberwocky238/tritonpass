//! triton-shared `PtrAnalysis`（改过的那份）：从 tt.addptr / splat / broadcast 起把指针算术还原成 [`PtrState`]，落成
//! `tts.make_tptr`，tt.load / tt.store 换成 `tts.load` / `tts.store`（mask 经 [`MaskState`] 读成各维的有效个数）；scf.for 携带的
//! 指针按 prepass 留下的 `tts.get_structured_state` 接上偏移与行距。认不出的访存原样留着（P6 点名）。
use std::collections::{BTreeMap, BTreeSet, VecDeque};

use mlirformat::Type;
use mlirpass::{Body, OpData, OpId, ValueId};

use crate::pass::mask::MaskState;
use crate::pass::ofr::Ofr;
use crate::pass::ptr_state::PtrState;
use crate::ir::{Cursor, dense_i32, dense_i64};
use crate::{Ir, Kind};

pub struct PtrAnalysis {
    pub gather_scatter: bool,
    pub modulo: bool,
    unstructured: bool,
    pub known: BTreeMap<ValueId, PtrState>,
    pub ptr_map: BTreeMap<ValueId, ValueId>,
    maybe_structured: BTreeSet<ValueId>,
}

fn is_ptr_like(t: &Type<'_>) -> bool {
    matches!(t.element_type(), Type::Extended(e) if e.name == "tt.ptr")
}

impl PtrAnalysis {
    pub fn new(gather_scatter: bool, modulo: bool) -> Self {
        Self { gather_scatter, modulo, unstructured: false, known: BTreeMap::new(), ptr_map: BTreeMap::new(), maybe_structured: BTreeSet::new() }
    }

    /// `initializeMaybeStructuredArgs`：从 get_structured_state 的第一个结果起广度优先走，经 scf.for 的初值到迭代参数与结果，
    /// 经别的 op 到同类型的结果。
    pub fn init_maybe_structured(&mut self, b: &Body<'_>, root: OpId) {
        let mut q = VecDeque::new();
        let mut visited = BTreeSet::new();
        b.walk_post(root, &mut |o| {
            if b.is(o, Kind::TtsGetStructuredState) {
                let v = b.res(o, 0);
                visited.insert(v);
                q.push_back(v);
            }
        });
        while let Some(v) = q.pop_front() {
            for u in b[v].uses.iter().rev() {
                let user = u.op;
                if b.is(user, Kind::ScfFor) {
                    let inits = b[user].operands[3..].to_vec();
                    for (i, a) in inits.iter().enumerate() {
                        if *a != v {
                            continue;
                        }
                        let it = b[b.entry(user, 0)].args[i + 1];
                        let r = b.res(user, i);
                        for n in [it, r] {
                            self.maybe_structured.insert(n);
                            if visited.insert(n) {
                                q.push_back(n);
                            }
                        }
                    }
                } else {
                    for &r in &b[user].results {
                        if b.ty(r) != b.ty(v) {
                            continue;
                        }
                        self.maybe_structured.insert(r);
                        if visited.insert(r) {
                            q.push_back(r);
                        }
                    }
                }
            }
        }
    }

    #[allow(clippy::too_many_lines)]
    pub fn visit(&mut self, v: ValueId, s: &mut PtrState, c: &mut Cursor<'_, '_>) -> bool {
        if !self.unstructured
            && let Some(k) = self.known.get(&v)
        {
            *s = k.clone();
            return true;
        }
        let ty = c.body.ty(v).clone();
        if matches!(ty, Type::Integer { .. }) {
            let def = c.body.def_op(v);
            let saved = c.at;
            if let Some(d) = def {
                c.at = crate::ir::At::After(d);
            }
            let cast = c.value(Kind::ArithIndexCast, &[v], Type::Index);
            c.at = saved;
            s.scalar = Some(cast);
            return true;
        }
        if matches!(ty, Type::Index) {
            s.scalar = Some(v);
            return true;
        }
        let def = c.body.def_op(v);
        if matches!(ty, Type::Extended(ref e) if e.name == "tt.ptr") {
            let Some(d) = def else {
                s.source = Some(v);
                return true;
            };
            return match c.body.kind(d) {
                Some(Kind::TtAddptr) => self.visit_addptr(d, s, c),
                Some(Kind::TtBitcast) => {
                    s.source = Some(v);
                    true
                }
                Some(Kind::TtIntToPtr) => {
                    s.source = Some(v);
                    true
                }
                Some(Kind::ScfIf) => {
                    s.source = Some(v);
                    true
                }
                _ => false,
            };
        }
        let Some(d) = def else {
            if let Some(k) = self.known.get(&v) {
                *s = k.clone();
                return true;
            }
            return false;
        };
        match c.body.kind(d) {
            Some(Kind::ArithAddi) => self.visit_add(d, s, c),
            Some(Kind::ArithMuli) => self.visit_mul(d, s, c),
            Some(Kind::TtMakeRange) => {
                let shape = c.body.ty(v).dims().unwrap_or_default();
                let (st, en) = (c.body.int_attr(d, "start").unwrap_or(0) as i64, c.body.int_attr(d, "end").unwrap_or(0) as i64);
                let stride = (en - st + shape[0] - 1) / shape[0];
                s.offsets.push(Ofr::idx(st));
                s.sizes.push(Ofr::idx(shape[0]));
                s.strides.push(Ofr::idx(stride));
                s.shape.push(Ofr::idx(0));
                true
            }
            Some(Kind::TtBroadcast) => self.visit_broadcast(d, s, c),
            Some(Kind::TtSplat) => self.visit_splat(d, s, c),
            Some(Kind::TtExpandDims) => {
                let src = c.body.opd(d, 0);
                if !self.visit(src, s, c) {
                    return false;
                }
                let axis = c.body.int_attr(d, "axis").unwrap_or(0) as usize;
                s.offsets.insert(axis, Ofr::idx(0));
                s.sizes.insert(axis, Ofr::idx(1));
                s.strides.insert(axis, Ofr::idx(0));
                s.shape.insert(axis, Ofr::idx(0));
                !(s.has_modulo() && s.rank() > 2)
            }
            Some(Kind::TtAddptr) => self.visit_addptr(d, s, c),
            Some(Kind::ArithConstant) => {
                let Some(k) = c.body.constant(v) else { return false };
                if !k.values.windows(2).all(|w| w[0] == w[1]) || !matches!(k.ty.element_type(), Type::Integer { .. }) {
                    return false;
                }
                let x = c.body.const_int(v).unwrap_or(0) as i64;
                let cv = c.index(x);
                s.scalar = Some(cv);
                for (i, n) in c.body.ty(v).dims().unwrap_or_default().iter().enumerate() {
                    s.offsets.push(if i == 0 { Ofr::V(cv) } else { Ofr::idx(0) });
                    s.sizes.push(Ofr::idx(*n));
                    s.strides.push(Ofr::idx(0));
                    s.shape.push(Ofr::idx(0));
                }
                true
            }
            Some(Kind::ArithRemsi) => self.visit_rem(d, s, c),
            Some(Kind::ArithExtsi) => {
                let i = c.body.opd(d, 0);
                self.visit(i, s, c)
            }
            Some(Kind::ScfFor) => {
                let index = c.body[d].results.iter().position(|r| *r == v).unwrap_or(0);
                match self.loop_state(c.body, d, index, false) {
                    Some(st) => {
                        *s = st;
                        true
                    }
                    None => false,
                }
            }
            _ => self.gather_scatter && s.rebuild_as_unsupported(c.body, v),
        }
    }

    fn visit_add(&mut self, op: OpId, s: &mut PtrState, c: &mut Cursor<'_, '_>) -> bool {
        let (lv, rv) = (c.body.opd(op, 0), c.body.opd(op, 1));
        let mut l = PtrState::default();
        if !self.visit(lv, &mut l, c) {
            return false;
        }
        let mut r = PtrState::default();
        if !self.visit(rv, &mut r, c) {
            return false;
        }
        if (l.rank() == 1 && l.has_modulo()) || (r.rank() == 1 && r.has_modulo()) {
            return false;
        }
        if !self.fix_modulo(c.body, &mut l, &mut r, lv, rv) {
            return false;
        }
        let loc = c.body[op].loc.clone();
        let saved = core::mem::replace(&mut c.loc, loc);
        let ok = s.add_state(&l, &r, self.unstructured, c);
        c.loc = saved;
        ok
    }

    /// 一边有取模、另一边不结构化：有取模的那边当 gather/scatter 重建。
    fn fix_modulo(&self, b: &Body<'_>, l: &mut PtrState, r: &mut PtrState, lv: ValueId, rv: ValueId) -> bool {
        if !l.is_structured(b) && r.has_modulo() {
            let d = l.non_structured_dim(b);
            if !self.gather_scatter || !r.rebuild_as_gather_scatter(b, rv, d) {
                return false;
            }
        } else if l.has_modulo() && !r.is_structured(b) {
            let d = r.non_structured_dim(b);
            if !self.gather_scatter || !l.rebuild_as_gather_scatter(b, lv, d) {
                return false;
            }
        }
        true
    }

    fn visit_mul(&mut self, op: OpId, s: &mut PtrState, c: &mut Cursor<'_, '_>) -> bool {
        let (lv, rv) = (c.body.opd(op, 0), c.body.opd(op, 1));
        let mut l = PtrState::default();
        if !self.visit(lv, &mut l, c) {
            return false;
        }
        let mut r = PtrState::default();
        if !self.visit(rv, &mut r, c) {
            return false;
        }
        if !self.fix_modulo(c.body, &mut l, &mut r, lv, rv) {
            return false;
        }
        let loc = c.body[op].loc.clone();
        let saved = core::mem::replace(&mut c.loc, loc);
        let ok = s.mul_state(&l, &r, self.unstructured, c);
        c.loc = saved;
        ok
    }

    fn visit_rem(&mut self, op: OpId, s: &mut PtrState, c: &mut Cursor<'_, '_>) -> bool {
        if !self.modulo {
            return false;
        }
        let res = c.body.res(op, 0);
        if self.unstructured {
            return s.rebuild_as_unsupported(c.body, res);
        }
        let mut r = PtrState::default();
        let rv = c.body.opd(op, 1);
        if !self.visit(rv, &mut r, c) || r.scalar.is_none() {
            return false;
        }
        let lv = c.body.opd(op, 0);
        if !self.visit(lv, s, c) {
            return false;
        }
        if !s.is_structured(c.body) {
            let d = s.non_structured_dim(c.body);
            return s.rebuild_as_gather_scatter(c.body, res, d);
        }
        if s.has_modulo() {
            return s.rank() == 1 && self.gather_scatter && s.rebuild_as_gather_scatter(c.body, res, 0);
        }
        let m = Ofr::V(r.scalar.expect("有标量"));
        match s.rank() {
            1 => *s.shape.last_mut().expect("一维") = m,
            2 => {
                let shape = c.body.ty(res).dims().unwrap_or_default();
                if shape[0] == 1 {
                    s.shape[1] = m;
                } else if shape[1] == 1 {
                    s.shape[0] = m;
                } else {
                    return false;
                }
            }
            _ => return false,
        }
        true
    }

    fn visit_broadcast(&mut self, op: OpId, s: &mut PtrState, c: &mut Cursor<'_, '_>) -> bool {
        let src = c.body.opd(op, 0);
        if !matches!(c.body.ty(src), Type::Shaped(_)) {
            return false;
        }
        let ss = c.body.ty(src).dims().unwrap_or_default();
        let ds = c.body.ty(c.body.res(op, 0)).dims().unwrap_or_default();
        if !self.visit(src, s, c) {
            return false;
        }
        for i in 0..ds.len() {
            if ss[i] < ds[i] {
                s.sizes[i] = Ofr::idx(ds[i]);
            }
        }
        true
    }

    fn visit_splat(&mut self, op: OpId, s: &mut PtrState, c: &mut Cursor<'_, '_>) -> bool {
        let src = c.body.opd(op, 0);
        let ds = c.body.ty(c.body.res(op, 0)).dims().unwrap_or_default();
        if !self.visit(src, s, c) {
            return false;
        }
        let st = c.body.ty(src);
        if !(matches!(st, Type::Integer { .. } | Type::Index) || matches!(st, Type::Extended(e) if e.name == "tt.ptr")) {
            return false;
        }
        for n in &ds {
            s.offsets.push(Ofr::idx(0));
            s.sizes.push(Ofr::idx(*n));
            s.strides.push(Ofr::idx(0));
            s.shape.push(Ofr::idx(0));
        }
        if let Some(sc) = s.scalar {
            s.offsets[0] = Ofr::V(sc);
        }
        !(s.has_modulo() && s.rank() > 2)
    }

    fn visit_addptr(&mut self, op: OpId, s: &mut PtrState, c: &mut Cursor<'_, '_>) -> bool {
        let (pv, ov) = (c.body.opd(op, 0), c.body.opd(op, 1));
        let loc = c.body[op].loc.clone();
        let saved = core::mem::replace(&mut c.loc, loc);
        let mut p = PtrState::default();
        let ok = self.visit(pv, &mut p, c);
        if !ok {
            c.loc = saved;
            return false;
        }
        let mut o = PtrState::default();
        if !self.visit(ov, &mut o, c) {
            c.loc = saved;
            return false;
        }
        let r = p.source.is_some() && p.rank() == o.rank() && s.add_state(&p, &o, self.unstructured, c);
        c.loc = saved;
        r
    }

    /// 循环第 `index` 个初值的状态（`getLoopInitArgPtrState`）。
    fn init_state(&self, b: &Body<'_>, l: OpId, index: usize) -> Option<PtrState> {
        let ptr = b.opd(l, 3 + index);
        if let Some(g) = b.def_of(ptr, Kind::TtsGetStructuredState)
            && let Some(k) = self.known.get(&b.opd(g, 0))
        {
            return Some(k.clone());
        }
        if let Some(f) = b.def_of(ptr, Kind::ScfFor) {
            return self.loop_state(b, f, index, false);
        }
        self.known.get(&ptr).cloned()
    }

    /// 迭代参数（`iter = true`）或结果的状态：偏移与行距换成随后那几个携带值（`reconcileLoopPtrState`）。
    fn loop_state(&self, b: &Body<'_>, l: OpId, index: usize, iter: bool) -> Option<PtrState> {
        let st = self.init_state(b, l, index)?;
        if !st.is_structured(b) {
            return None;
        }
        let get = |k: usize| if iter { b[b.entry(l, 0)].args[k + 1] } else { b.res(l, k) };
        let mut n = st;
        let mut cnt = index + 1;
        if n.rank() == 0 {
            n.scalar = Some(get(cnt));
        } else {
            for o in &mut n.offsets {
                *o = Ofr::V(get(cnt));
                cnt += 1;
            }
            for s in &mut n.strides {
                *s = Ofr::V(get(cnt));
                cnt += 1;
            }
        }
        Some(n)
    }

    fn rewrite_addptr(&mut self, b: &mut Body<'_>, op: OpId) -> bool {
        let mut c = Cursor::before(b, op);
        let mut st = PtrState::default();
        if !self.visit_addptr(op, &mut st, &mut c) {
            return false;
        }
        let r = c.body.res(op, 0);
        self.known.insert(r, st.clone());
        if matches!(c.body.ty(c.body.opd(op, 0)), Type::Shaped(_)) {
            if st.is_structured(c.body) {
                let t = st.make_tptr(&mut c);
                self.ptr_map.insert(r, t);
            } else if self.gather_scatter {
                let mut u = PtrState::default();
                self.unstructured = true;
                let ok = self.visit_addptr(op, &mut u, &mut c);
                self.unstructured = false;
                if !ok || !st.merge_unstructured(c.body, &u) {
                    return false;
                }
                let t = st.make_gather_scatter(&mut c);
                self.known.insert(r, st);
                self.ptr_map.insert(r, t);
            } else {
                return false;
            }
        } else {
            self.ptr_map.insert(r, r);
        }
        true
    }

    fn rewrite_splat_or_broadcast(&mut self, b: &mut Body<'_>, op: OpId, splat: bool) {
        let rty = b.ty(b.res(op, 0)).clone();
        if !matches!(rty, Type::Shaped(_)) {
            return;
        }
        if splat {
            let st = b.ty(b.opd(op, 0));
            if !matches!(st, Type::Extended(e) if e.name == "tt.ptr") {
                return;
            }
        } else if !is_ptr_like(&rty) {
            return;
        }
        let mut c = Cursor::before(b, op);
        let mut st = PtrState::default();
        let ok = if splat { self.visit_splat(op, &mut st, &mut c) } else { self.visit_broadcast(op, &mut st, &mut c) };
        if !ok {
            return;
        }
        let r = c.body.res(op, 0);
        self.known.insert(r, st.clone());
        if !st.is_structured(c.body) {
            return;
        }
        let t = st.make_tptr(&mut c);
        self.ptr_map.insert(r, t);
    }

    fn rewrite_for(&mut self, b: &mut Body<'_>, l: OpId) {
        let n = b[l].operands.len() - 3;
        for i in 0..n {
            let arg = b[b.entry(l, 0)].args[i + 1];
            if !self.maybe_structured.contains(&arg) {
                continue;
            }
            let Some(st) = self.loop_state(b, l, i, true) else { continue };
            if st.no_structured_dim(b) {
                continue;
            }
            self.known.insert(arg, st.clone());
            if is_ptr_like(b.ty(arg)) && st.rank() != 0 {
                let blk = b.entry(l, 0);
                let loc = b[l].loc.clone();
                let mut c = Cursor::start(b, blk, loc);
                let t = st.make_tptr(&mut c);
                self.ptr_map.insert(arg, t);
            }
        }
        self.rewrite_ops(b, l);
    }

    /// 整块 mask 是标量条件时折进第 0 维的有效个数（`foldScalarConditionIntoDims`）。
    fn fold_scalar_condition(m: &MaskState, c: &mut Cursor<'_, '_>) -> Vec<Ofr> {
        let mut dims = m.dims.clone();
        let Some(s) = m.scalar else { return dims };
        if dims.is_empty() {
            return dims;
        }
        let constant = s.int().or_else(|| s.value().and_then(|v| {
            c.body.def_of(v, Kind::ArithConstant)?;
            c.body.const_int(v).map(|x| x as i64)
        }));
        if let Some(k) = constant {
            if k != 0 {
                return dims;
            }
            dims[0] = Ofr::idx(0);
            return dims;
        }
        dims[0] = c.select_ofr(s, dims[0], Ofr::idx(0));
        dims
    }

    /// `applyUnstructuredMask`。
    #[allow(clippy::too_many_lines)]
    fn apply_unstructured_mask(ptr: ValueId, m: &mut MaskState, c: &mut Cursor<'_, '_>) -> Option<ValueId> {
        let masks = m.unstructured();
        if masks.is_empty() {
            return Some(ptr);
        }
        if masks.len() > 1 {
            return None;
        }
        let (dim, um) = masks[0];
        if dim >= m.dims.len() {
            return None;
        }
        let def = c.body.def_op(ptr)?;
        let new = match c.body.kind(def) {
            Some(Kind::TtsMakeGatherScatterTptr) => {
                let b = &*c.body;
                if b.int_attr(def, "gather_scatter_dim").map(|x| x as usize) != Some(dim) {
                    return None;
                }
                let (base, off) = (b.opd(def, 0), b.opd(def, 1));
                let sizes = crate::ir::dense_values(b[def].get("sizes"));
                let (strides, offsets) = Self::mixed_gs(b, def);
                PtrState::gather_scatter_op(c, base, off, Some(um), dim, &sizes, &strides, &offsets)
            }
            Some(Kind::TtsMakeTptr) => {
                let b = &*c.body;
                let base = b.opd(def, 0);
                let sizes = crate::ir::dense_values(b[def].get("sizes"));
                let (strides, offsets, _) = Self::mixed_tptr(b, def);
                let to_i32 = |o: Ofr, c: &mut Cursor<'_, '_>| {
                    let mut v = c.ofr_value(o);
                    if matches!(c.body.ty(v), Type::Index) {
                        v = c.value(Kind::ArithIndexCast, &[v], crate::ir::int(32));
                    } else if matches!(c.body.ty(v), Type::Integer { width: 64, .. }) {
                        v = c.value(Kind::ArithTrunci, &[v], crate::ir::int(32));
                    }
                    v
                };
                let offset = to_i32(offsets[dim], c);
                let row_ty = Type::tensor(&[sizes[dim]], c.body.ty(offset).clone());
                let stride = to_i32(strides[dim], c);
                let offset = c.binary(Kind::ArithDivui, offset, stride);
                let gso = c.value(Kind::TensorSplat, &[offset], row_ty.clone());
                let range = c.value_with(Kind::TtMakeRange, &[], &[("end", mlirformat::Attribute::of_int(i128::from(sizes[dim]), crate::ir::int(32))), ("start", mlirformat::Attribute::of_int(0, crate::ir::int(32)))], row_ty);
                let gso = c.binary(Kind::ArithAddi, gso, range);
                PtrState::gather_scatter_op(c, base, gso, Some(um), dim, &sizes, &strides, &offsets)
            }
            _ => return None,
        };
        m.dims[dim] = Ofr::I(0, 32);
        Some(new)
    }

    /// tts.make_tptr 的 mixed strides / offsets / shape。
    fn mixed_tptr(b: &Body<'_>, op: OpId) -> (Vec<Ofr>, Vec<Ofr>, Vec<Ofr>) {
        let seg = crate::ir::dense_values(b[op].get("operandSegmentSizes"));
        let ops = &b[op].operands;
        let mut at = 1usize;
        let mut mix = |name: &str, n: usize| {
            let dynv = &ops[at..at + n];
            at += n;
            let mut it = dynv.iter();
            crate::ir::dense_values(b[op].get(name)).into_iter().map(|x| if x == crate::ir::DYNAMIC { Ofr::V(*it.next().expect("动态项")) } else { Ofr::idx(x) }).collect::<Vec<_>>()
        };
        let s = mix("static_strides", seg.get(1).copied().unwrap_or(0) as usize);
        let o = mix("static_offsets", seg.get(2).copied().unwrap_or(0) as usize);
        let sh = mix("static_shape", seg.get(3).copied().unwrap_or(0) as usize);
        (s, o, sh)
    }

    fn mixed_gs(b: &Body<'_>, op: OpId) -> (Vec<Ofr>, Vec<Ofr>) {
        let seg = crate::ir::dense_values(b[op].get("operandSegmentSizes"));
        let ops = &b[op].operands;
        let mut at = 2usize;
        let mut mix = |name: &str, n: usize| {
            let dynv = &ops[at..at + n];
            at += n;
            let mut it = dynv.iter();
            crate::ir::dense_values(b[op].get(name)).into_iter().map(|x| if x == crate::ir::DYNAMIC { Ofr::V(*it.next().expect("动态项")) } else { Ofr::idx(x) }).collect::<Vec<_>>()
        };
        let s = mix("static_strides", seg.get(2).copied().unwrap_or(0) as usize);
        let o = mix("static_offsets", seg.get(3).copied().unwrap_or(0) as usize);
        (s, o)
    }

    /// `tts.load` / `tts.store` 的 mask_dims：静态的进数组，动态的进操作数。
    fn dims_split(dims: &[Ofr]) -> (Vec<ValueId>, Vec<i64>) {
        (dims.iter().filter_map(|d| d.value()).collect(), dims.iter().map(|d| d.static_value()).collect())
    }

    fn rewrite_load(&mut self, b: &mut Body<'_>, op: OpId) -> bool {
        let Some(mut ptr) = self.ptr_map.get(&b.opd(op, 0)).copied() else { return false };
        let pt = b.ty(ptr).clone();
        if matches!(&pt, Type::Extended(_)) && !matches!(crate::pointee(&pt), Type::Shaped(_)) {
            return false;
        }
        let mask = (b[op].operands.len() >= 2).then(|| b.opd(op, 1));
        let other = (b[op].operands.len() >= 3).then(|| b.opd(op, 2));
        let mut c = Cursor::before(b, op);
        let mut dims = Vec::new();
        if let Some(m) = mask {
            let mut ms = MaskState::default();
            if !ms.parse(m, &mut c) {
                return false;
            }
            if !self.gather_scatter && !ms.unstructured().is_empty() {
                return false;
            }
            let Some(p) = Self::apply_unstructured_mask(ptr, &mut ms, &mut c) else { return false };
            ptr = p;
            dims = Self::fold_scalar_condition(&ms, &mut c);
        }
        let mut scalar_other = None;
        if let Some(o) = other {
            let Some(s) = Self::scalar_value(o, &mut c) else { return false };
            scalar_other = Some(s);
        }
        let res_ty = c.body.ty(c.body.res(op, 0)).clone();
        let (dynd, statd) = Self::dims_split(&dims);
        let mut operands = vec![ptr];
        operands.extend(&dynd);
        operands.extend(scalar_other);
        let d = OpData::build(Kind::TtsLoad.name()).operands(&operands).with("operandSegmentSizes", dense_i32(&[1, dynd.len() as i64, i64::from(scalar_other.is_some())])).with("static_mask_dims", dense_i64(&statd));
        let l = c.create(d, &[res_ty]);
        let lv = c.body.res(l, 0);
        b.replace_op(op, &[lv]);
        true
    }

    fn rewrite_store(&mut self, b: &mut Body<'_>, op: OpId) -> bool {
        let Some(mut ptr) = self.ptr_map.get(&b.opd(op, 0)).copied() else { return false };
        let pt = b.ty(ptr).clone();
        if matches!(&pt, Type::Extended(_)) && !matches!(crate::pointee(&pt), Type::Shaped(_)) {
            return false;
        }
        let val = b.opd(op, 1);
        let mask = (b[op].operands.len() >= 3).then(|| b.opd(op, 2));
        let mut c = Cursor::before(b, op);
        let mut dims = Vec::new();
        if let Some(m) = mask {
            let mut ms = MaskState::default();
            if !ms.parse(m, &mut c) {
                return false;
            }
            let Some(p) = Self::apply_unstructured_mask(ptr, &mut ms, &mut c) else { return false };
            ptr = p;
            dims = Self::fold_scalar_condition(&ms, &mut c);
        }
        let (dynd, statd) = Self::dims_split(&dims);
        let mut operands = vec![ptr, val];
        operands.extend(&dynd);
        c.create(OpData::build(Kind::TtsStore.name()).operands(&operands).with("static_mask_dims", dense_i64(&statd)), &[]);
        b.erase(op);
        true
    }

    /// [`Self::scalar_value`]（给 triton-to-unstructured 用）。
    pub fn scalar_value_pub(v: ValueId, c: &mut Cursor<'_, '_>) -> Option<ValueId> {
        Self::scalar_value(v, c)
    }

    /// `utils::getScalarValue`：splat / sitofp / truncf 链上取出标量，在当前位置重建同样的链（常量就地物化）。
    fn scalar_value(mut v: ValueId, c: &mut Cursor<'_, '_>) -> Option<ValueId> {
        let mut chain: Vec<OpId> = Vec::new();
        loop {
            if !matches!(c.body.ty(v), Type::Shaped(_)) {
                return Some(Self::rebuild_chain(v, &chain, c));
            }
            let d = c.body.def_op(v)?;
            match c.body.kind(d) {
                Some(Kind::ArithConstant) => {
                    let k = c.body.constant(v)?;
                    if !k.values.windows(2).all(|w| w[0] == w[1]) {
                        return None;
                    }
                    let saved = c.loc.clone();
                    c.loc.clone_from(&c.body[d].loc);
                    let cv = c.constant(k.values[0], k.ty.element_type().clone());
                    c.loc = saved;
                    return Some(Self::rebuild_chain(cv, &chain, c));
                }
                Some(Kind::TtSplat) => v = c.body.opd(d, 0),
                Some(Kind::ArithSitofp | Kind::ArithTruncf) => {
                    chain.push(d);
                    v = c.body.opd(d, 0);
                }
                _ => return None,
            }
        }
    }

    fn rebuild_chain(mut src: ValueId, chain: &[OpId], c: &mut Cursor<'_, '_>) -> ValueId {
        for &op in chain.iter().rev() {
            let k = c.body.kind(op).expect("认得");
            let rt = c.body.ty(c.body.res(op, 0)).element_type().clone();
            src = c.value(k, &[src], rt);
        }
        src
    }

    fn rewrite_get_state(&mut self, b: &mut Body<'_>, op: OpId) {
        let tv = b.opd(op, 0);
        let results = b[op].results.to_vec();
        let Some(st) = self.known.get(&tv).cloned().filter(|s| s.is_structured(b)) else {
            b.replace_all_uses(results[0], tv);
            return;
        };
        let remapped = self.ptr_map.get(&tv).copied().unwrap_or(tv);
        let mut reps = vec![remapped];
        let mut c = Cursor::before(b, op);
        if st.rank() == 0 {
            match st.scalar {
                Some(s) => reps.push(s),
                None => reps.push(c.index(0)),
            }
        } else {
            for o in st.offsets.iter().chain(&st.strides) {
                reps.push(match o {
                    Ofr::I(v, _) => c.index(*v),
                    Ofr::V(v) => *v,
                });
            }
        }
        b.replace_op(op, &reps);
    }

    /// `rewriteOp`：先序走 `root` 的区域（scf.for 交给 [`Self::rewrite_for`] 递归、读写改写之后不进去）。
    /// 照 MLIR 的 walk：处理一条 op 之前先记下它后面那条，处理完从那条接着走（处理途中在它之前插的 op 不再走到）。
    pub fn rewrite_ops(&mut self, b: &mut Body<'_>, root: OpId) {
        for r in b[root].regions.clone() {
            for blk in b.blocks(r) {
                let mut cur = b.first_op(blk);
                while let Some(op) = cur {
                    let next = b.next_op(op);
                    let skip = self.rewrite_one(b, op);
                    if !skip && b[op].parent.is_some() {
                        self.rewrite_ops(b, op);
                    }
                    cur = next;
                }
            }
        }
    }

    /// 处理一条 op；返回要不要跳过它的区域。
    fn rewrite_one(&mut self, b: &mut Body<'_>, op: OpId) -> bool {
        match b.kind(op) {
            Some(Kind::TtAddptr) => {
                self.rewrite_addptr(b, op);
                false
            }
            Some(Kind::TtSplat) => {
                self.rewrite_splat_or_broadcast(b, op, true);
                false
            }
            Some(Kind::TtBroadcast) => {
                self.rewrite_splat_or_broadcast(b, op, false);
                false
            }
            Some(Kind::TtLoad) => self.rewrite_load(b, op),
            Some(Kind::TtStore) => self.rewrite_store(b, op),
            Some(Kind::ScfFor) => {
                self.rewrite_for(b, op);
                true
            }
            Some(Kind::TtsGetStructuredState) => {
                let tv = b.opd(op, 0);
                if !self.known.contains_key(&tv) {
                    let mut c = Cursor::before(b, op);
                    let mut st = PtrState::default();
                    if self.visit(tv, &mut st, &mut c) && st.is_structured(c.body) {
                        self.known.insert(tv, st);
                    }
                }
                true
            }
            _ => false,
        }
    }

    /// 全部状态都有了之后，把 prepass 留下的 get_structured_state 接上（模块里先序走）。
    pub fn rewrite_get_states(&mut self, b: &mut Body<'_>, root: OpId) {
        let mut ops = Vec::new();
        b.walk_post(root, &mut |o| {
            if b.is(o, Kind::TtsGetStructuredState) {
                ops.push(o);
            }
        });
        for o in ops {
            self.rewrite_get_state(b, o);
        }
    }
}
