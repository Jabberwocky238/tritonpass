//! 结构化访存的窗口：`tts.make_tptr` 的平坦偏移拆回逐维下标偏移，行距分类，建视图前的规划。
//! structured-to-memref 建视图用它；下游的拒收、访问摘要也可以复用。
use mlirformat::Type;
use mlirpass::{Body, Def, OpId, ValueId};

use super::ofr::Ofr;
use crate::ir::{DYNAMIC, dense_values};
use crate::pass::ofr::OfrBuilder;
use crate::{Ir, Kind};

/// 无界维的大小（指针没有长度）。
pub const UNBOUNDED: i64 = 1 << 40;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum StrideKind {
    Const,
    Zero,
    Negative,
    Runtime,
    Bad,
}

#[derive(Debug, Clone, Copy)]
pub struct StrideInfo {
    pub kind: StrideKind,
    pub value: i64,
    pub runtime: Option<ValueId>,
    pub arg_index: Option<u32>,
    pub ofr: Ofr,
}

/// 一个 tts.make_tptr 的视图。
pub struct Tptr {
    pub base: ValueId,
    pub sizes: Vec<i64>,
    pub strides: Vec<Ofr>,
    pub offsets: Vec<Ofr>,
    pub shape: Vec<Ofr>,
    pub order: Vec<i64>,
}

impl Tptr {
    pub fn of(b: &Body<'_>, op: OpId) -> Self {
        let seg = dense_values(b[op].get("operandSegmentSizes"));
        let ops = &b[op].operands;
        let n = |i: usize| seg.get(i).copied().unwrap_or(0) as usize;
        let (s, o, sh) = (n(1), n(2), n(3));
        Self {
            base: b.opd(op, 0),
            sizes: dense_values(b[op].get("sizes")),
            strides: Self::mixed(b, op, "static_strides", &ops[1..1 + s]),
            offsets: Self::mixed(b, op, "static_offsets", &ops[1 + s..1 + s + o]),
            shape: Self::mixed(b, op, "static_shape", &ops[1 + s + o..1 + s + o + sh]),
            order: dense_values(b[op].get("order")),
        }
    }

    /// 静态数组 `name` 与动态操作数拼成 mixed 列表（`getMixedValues`）。
    pub fn mixed(b: &Body<'_>, op: OpId, name: &str, dynv: &[ValueId]) -> Vec<Ofr> {
        let mut it = dynv.iter();
        dense_values(b[op].get(name)).into_iter().map(|x| if x == DYNAMIC { Ofr::V(*it.next().expect("动态项")) } else { Ofr::idx(x) }).collect()
    }

    pub fn is_block_ptr(&self) -> bool {
        !self.order.is_empty()
    }

    /// 没有取模（shape 全是 0）。
    pub fn is_structured_ptr(&self) -> bool {
        self.shape.iter().all(|s| s.int() == Some(0))
    }
}

/// 窗口的拆分计划。
pub struct WindowPlan {
    pub idx_terms: Vec<Vec<Ofr>>,
    pub remainder: Vec<Ofr>,
    pub absorb: Option<usize>,
    pub strides: Vec<StrideInfo>,
}

pub struct Window;

impl Window {
    /// `getConstantIntValue`：整数属性，或常量 op（标量或 splat）。
    pub fn const_int(b: &Body<'_>, o: Ofr) -> Option<i64> {
        match o {
            Ofr::I(v, _) => Some(v),
            Ofr::V(v) => {
                b.def_of(v, Kind::ArithConstant)?;
                b.const_int(v).and_then(|x| i64::try_from(x).ok())
            }
        }
    }

    fn lossless(b: &Body<'_>, op: OpId) -> bool {
        matches!(b.kind(op), Some(Kind::ArithIndexCast | Kind::ArithIndexCastui | Kind::ArithExtsi | Kind::ArithExtui | Kind::ArithTrunci))
    }

    /// 剥掉无损转换。
    pub fn root(b: &Body<'_>, mut v: ValueId) -> ValueId {
        while let Some(d) = b.def_op(v) {
            if !Self::lossless(b, d) {
                break;
            }
            v = b.opd(d, 0);
        }
        v
    }

    /// 追到入口函数入口块的整数参数。
    pub fn entry_arg(b: &Body<'_>, v: ValueId) -> Option<(ValueId, u32)> {
        let r = Self::root(b, v);
        let Def::Arg(blk, i) = b[r].def else { return None };
        if !matches!(b.ty(r), Type::Integer { .. }) {
            return None;
        }
        let f = b.block_owner(blk)?;
        (matches!(b.kind(f), Some(Kind::TtFunc | Kind::FuncFunc)) && b.entry(f, 0) == blk).then_some((r, i))
    }

    pub fn classify(b: &Body<'_>, s: Ofr) -> StrideInfo {
        let mut info = StrideInfo { kind: StrideKind::Bad, value: 0, runtime: None, arg_index: None, ofr: s };
        if let Some(c) = Self::const_int(b, s) {
            info.value = c;
            info.kind = match c.cmp(&0) {
                core::cmp::Ordering::Greater => StrideKind::Const,
                core::cmp::Ordering::Equal => StrideKind::Zero,
                core::cmp::Ordering::Less => StrideKind::Negative,
            };
            return info;
        }
        let v = s.value().expect("不是常数就是值");
        if let Some((_, i)) = Self::entry_arg(b, v) {
            info.kind = StrideKind::Runtime;
            info.runtime = Some(v);
            info.arg_index = Some(i);
        }
        info
    }

    fn factor_matches(b: &Body<'_>, f: ValueId, s: &StrideInfo) -> bool {
        match s.kind {
            StrideKind::Const => Self::const_int(b, Ofr::V(f)) == Some(s.value),
            StrideKind::Runtime => Self::root(b, f) == Self::root(b, s.runtime.expect("运行期行距")),
            _ => false,
        }
    }

    fn addends(b: &Body<'_>, flat: Ofr, out: &mut Vec<Ofr>) {
        if let Some(c) = Self::const_int(b, flat) {
            if c != 0 {
                out.push(Ofr::idx(c));
            }
            return;
        }
        let v = flat.value().expect("值");
        if let Some(a) = b.def_of(v, Kind::ArithAddi) {
            Self::addends(b, Ofr::V(b.opd(a, 0)), out);
            Self::addends(b, Ofr::V(b.opd(a, 1)), out);
            return;
        }
        out.push(Ofr::V(v));
    }

    /// `planWindow`。
    pub fn plan(b: &Body<'_>, t: &Tptr) -> Result<WindowPlan, &'static str> {
        if t.is_block_ptr() {
            return Err("块指针不是合同的访存写法");
        }
        if !t.is_structured_ptr() {
            return Err("回绕（取模）的指针窗口是两段，合同的 valid 逐维前缀表达不了");
        }
        let rank = t.offsets.len();
        let mut plan = WindowPlan { idx_terms: vec![Vec::new(); rank], remainder: Vec::new(), absorb: None, strides: t.strides.iter().map(|s| Self::classify(b, *s)).collect() };
        for d in 0..rank {
            if plan.strides[d].kind == StrideKind::Const && plan.strides[d].value == 1 {
                plan.absorb = Some(d);
            }
        }
        for d in 0..rank {
            let s = plan.strides[d];
            let mut adds = Vec::new();
            Self::addends(b, t.offsets[d], &mut adds);
            if t.sizes[d] == 1 && matches!(s.kind, StrideKind::Negative | StrideKind::Bad) {
                plan.remainder.extend(adds);
                continue;
            }
            match s.kind {
                StrideKind::Const if s.value == 1 => plan.idx_terms[d] = adds,
                StrideKind::Const | StrideKind::Runtime => {
                    for a in adds {
                        if let Some(c) = Self::const_int(b, a) {
                            if s.kind == StrideKind::Const && c % s.value == 0 {
                                plan.idx_terms[d].push(Ofr::idx(c / s.value));
                            } else {
                                plan.remainder.push(a);
                            }
                            continue;
                        }
                        let v = a.value().expect("值");
                        if let Some(m) = b.def_of(v, Kind::ArithMuli) {
                            if Self::factor_matches(b, b.opd(m, 1), &s) {
                                plan.idx_terms[d].push(Ofr::V(b.opd(m, 0)));
                                continue;
                            }
                            if Self::factor_matches(b, b.opd(m, 0), &s) {
                                plan.idx_terms[d].push(Ofr::V(b.opd(m, 1)));
                                continue;
                            }
                        } else if Self::factor_matches(b, v, &s) {
                            plan.idx_terms[d].push(Ofr::idx(1));
                            continue;
                        }
                        plan.remainder.push(a);
                    }
                }
                StrideKind::Zero => plan.remainder.extend(adds),
                StrideKind::Negative => return Err("负行距一期不做"),
                StrideKind::Bad => return Err("行距来自数据或复杂表达式，不是整数标量实参或常量"),
            }
        }
        if !plan.remainder.is_empty() && plan.absorb.is_none()
            && let Some(d) = (0..rank).rev().find(|d| t.sizes[*d] == 1)
        {
            plan.absorb = Some(d);
            plan.strides[d] = StrideInfo { kind: StrideKind::Const, value: 1, runtime: None, arg_index: None, ofr: Ofr::idx(1) };
        }
        if !plan.remainder.is_empty() && plan.absorb.is_none() {
            return Err("有标量偏移归不到任何一维：没有静态行距为 1 的维可以吸收它");
        }
        Ok(plan)
    }

    /// 计划建成逐维下标偏移。
    pub fn materialize_offsets(plan: &WindowPlan, c: &mut impl OfrBuilder) -> Vec<Ofr> {
        let mut out = Vec::new();
        for d in 0..plan.idx_terms.len() {
            let mut sum = Ofr::idx(0);
            for t in &plan.idx_terms[d] {
                sum = c.add_ofr(sum, *t);
            }
            if plan.absorb == Some(d) {
                for r in &plan.remainder {
                    sum = c.add_ofr(sum, *r);
                }
            }
            out.push(sum);
        }
        out
    }

    /// 根视图每维的行距。
    pub fn root_strides(t: &Tptr, plan: &WindowPlan) -> Vec<Ofr> {
        let mut out = vec![Ofr::idx(0); plan.strides.len()];
        let mut acc = 1i64;
        for d in (0..plan.strides.len()).rev() {
            let s = plan.strides[d];
            out[d] = if t.sizes[d] == 1 && matches!(s.kind, StrideKind::Zero | StrideKind::Negative | StrideKind::Bad) {
                Ofr::idx(acc)
            } else if s.kind == StrideKind::Runtime {
                Ofr::V(s.runtime.expect("运行期"))
            } else {
                Ofr::idx(if s.kind == StrideKind::Zero { 0 } else { s.value })
            };
            acc *= t.sizes[d];
        }
        out
    }

    /// 同一个基址在任何地方被 tts.store 写，都算被写。
    pub fn is_written(b: &Body<'_>, op: OpId) -> bool {
        let base = b.opd(op, 0);
        b[base].uses.iter().any(|u| b.is(u.op, Kind::TtsMakeTptr) && b[b.res(u.op, 0)].uses.iter().any(|w| b.is(w.op, Kind::TtsStore)))
    }

    /// mask 的各维恰好等于 tile 的静态尺寸。
    pub fn is_full(b: &Body<'_>, dims: &[Ofr], shape: &[i64]) -> bool {
        dims.len() == shape.len() && dims.iter().zip(shape).all(|(d, s)| Self::const_int(b, *d) == Some(*s))
    }

    /// 预检：问题按出现次序记进 `found`，返回能不能成窗口。
    pub fn check(b: &Body<'_>, op: OpId, write: bool, found: &mut Vec<WindowIssue>) -> bool {
        let t = Tptr::of(b, op);
        let plan = Self::plan(b, &t);
        let mut ok = true;
        if t.is_structured_ptr() {
            for (d, s) in t.strides.iter().enumerate() {
                if t.sizes[d] == 1 {
                    continue;
                }
                let s = Self::classify(b, *s);
                let why = match s.kind {
                    StrideKind::Bad => Some(format!("第 {d} 维的行距来自数据或复杂表达式，不是整数标量实参或常量")),
                    StrideKind::Negative => Some(format!("第 {d} 维的行距是负常数 {}，负行距一期不做", s.value)),
                    StrideKind::Zero if write && t.sizes[d] > 1 => Some(format!("第 {d} 维的行距为 0 且这个指针被写：零行距只许只读广播")),
                    _ => None,
                };
                if let Some(w) = why {
                    found.push(WindowIssue::Stride(w));
                    ok = false;
                }
            }
        }
        if ok && let Err(why) = plan {
            found.push(WindowIssue::Form(why));
            ok = false;
        }
        ok
    }
}

/// [`Window::check`] 发现的问题：行距不合用（入口签名的事），或拼不成窗口（形态的事）。
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum WindowIssue {
    Stride(String),
    Form(&'static str),
}
