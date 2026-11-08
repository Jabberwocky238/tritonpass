//! `triton-to-structured`（triton-shared `TritonToStructuredPass.cpp`）：prepass 把 scf 携带的指针、整型偏移张量展开成
//! （值, 各维偏移, 各维行距）放进 `tts.get_structured_state` 的占位里，再由 [`PtrAnalysis`] 改写指针算术与读写。
//!
//! prepass 在 C++ 里是两轮 1→N 的方言转换（先转成 tuple、canonicalize，再拆开、reconcile）；这里直接做出它的净效果：先跑
//! canonicalize，再按先序把每个 scf.for 的这类携带值展开——初值与 yield 的值各在定义处之后补一条 `tts.get_structured_state`，
//! 迭代参数与结果的用处换成那组的第一个。
use std::collections::BTreeMap;

use mlirformat::{Error, Type};
use mlirpass::{Body, Def, OpData, OpId, ValueId, pass};

use crate::pass::ptr_analysis::PtrAnalysis;
use crate::ir::{At, Cursor, dense_i32};
use crate::pass::uniform_lanes::Canon;
use crate::{Ir, Kind, pointee};

/// 选项同 triton-shared 的 `Passes.td`，名字与缺省值一样（dope-opt 的产品流水线另传 `enable-modulo-support=false`）。
#[pass("triton-to-structured", on = "builtin.module")]
pub struct TritonToStructured {
    /// 认不出结构的读写改用 `tts.make_gather_scatter_tptr`
    #[opt("enable-make-gather-scatter", default = true)]
    gather_scatter: bool,
    /// 指针分析认取模（回绕的窗口）
    #[opt("enable-modulo-support", default = true)]
    modulo: bool,
    /// 只跑 prepass（插入 scf.for 用的 `tts.get_structured_state`）
    #[opt("run-prepass-only")]
    prepass_only: bool,
    /// 跳过 prepass
    #[opt("skip-prepass")]
    skip_prepass: bool,
    /// 假定 mask 的上界不小于起始偏移（可能出错）
    #[opt("use-unsafe-mask")]
    unsafe_mask: bool,
}

impl mlirpass::Run for TritonToStructured {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        if self.unsafe_mask {
            body.emit_error(op, "triton-to-structured：use-unsafe-mask 还没移植");
            return Err(Error::from("triton-to-structured：use-unsafe-mask 还没移植"));
        }
        if !self.skip_prepass {
            Canon::run(body, op)?;
            Prepass::default().run(body, op);
        }
        if self.prepass_only {
            return Ok(());
        }
        let mut pa = PtrAnalysis::new(self.gather_scatter, self.modulo);
        pa.init_maybe_structured(body, op);
        pa.rewrite_ops(body, op);
        pa.rewrite_get_states(body, op);
        Ok(())
    }
}

/// 展开的状态：旧值 ⇒ 新的一组（值, 偏移…, 行距…）；初值、yield 值的 get_structured_state 按值缓存。
#[derive(Default)]
struct Prepass {
    groups: BTreeMap<ValueId, Vec<ValueId>>,
    /// 展开过的循环的 yield 与哪几个位置要展开：全部循环展开完再改（内层循环的结果那时已经有组，外层 yield 直接取，同 C++ 的 1→N 转换）
    yields: Vec<(OpId, Vec<bool>)>,
}

impl Prepass {
    /// 要展开成几个偏移、几个行距（`getOffsetAndStrideSegmentSizes`）；不展开是 `None`。
    fn segments(t: &Type<'_>) -> Option<(usize, usize)> {
        match t {
            Type::Shaped(_) => {
                let e = t.element_type();
                let r = t.dims()?.len();
                let int_like = matches!(e, Type::Integer { width, .. } if *width != 1) || matches!(e, Type::Index);
                let ptr = matches!(e, Type::Extended(x) if x.name == "tt.ptr");
                (int_like || ptr).then_some((r, r))
            }
            Type::Extended(x) if x.name == "tt.ptr" => match pointee(t) {
                p @ Type::Shaped(_) => p.dims().map(|d| (d.len(), d.len())),
                _ => Some((1, 0)),
            },
            _ => None,
        }
    }

    fn run(&mut self, b: &mut Body<'_>, root: OpId) {
        let mut fors = Vec::new();
        b.walk(root, &mut |o| {
            if b.is(o, Kind::ScfFor) {
                fors.push(o);
            }
        });
        for f in fors {
            self.expand_for(b, f);
        }
        for (y, conv) in core::mem::take(&mut self.yields) {
            let ys = b[y].operands.to_vec();
            let mut nys = Vec::new();
            for (v, c) in ys.iter().zip(&conv) {
                if *c {
                    nys.extend(self.group(b, *v));
                } else {
                    nys.push(*v);
                }
            }
            b.set_operands(y, nys);
        }
    }

    /// `v` 的一组：已经展开过就是那组，否则在它定义之后补一条 get_structured_state。
    fn group(&mut self, b: &mut Body<'_>, v: ValueId) -> Vec<ValueId> {
        if let Some(g) = self.groups.get(&v) {
            return g.clone();
        }
        let t = b.ty(v).clone();
        let (no, ns) = Self::segments(&t).expect("可展开");
        let mut tys = vec![t];
        tys.extend(core::iter::repeat_n(Type::Index, no + ns));
        let d = OpData::build(Kind::TtsGetStructuredState.name()).operands(&[v]).with("resultSegmentSizes", dense_i32(&[1, no as i64, ns as i64]));
        let (at, loc) = match b[v].def {
            Def::Result(o, _) => (At::After(o), b[o].loc.clone()),
            Def::Arg(blk, _) => match b.first_op(blk) {
                Some(first) => (At::Before(first), b[v].loc.clone()),
                None => (At::End(blk), b[v].loc.clone()),
            },
        };
        let mut c = Cursor { body: b, at, loc };
        let o = c.create(d, &tys);
        let g = b[o].results.to_vec();
        self.groups.insert(v, g.clone());
        g
    }

    fn expand_for(&mut self, b: &mut Body<'_>, f: OpId) {
        let inits = b[f].operands[3..].to_vec();
        let conv: Vec<bool> = inits.iter().map(|v| Self::segments(b.ty(*v)).is_some()).collect();
        if !conv.iter().any(|x| *x) {
            return;
        }
        // 新初值
        let mut new_inits = Vec::new();
        for (v, c) in inits.iter().zip(&conv) {
            if *c {
                new_inits.extend(self.group(b, *v));
            } else {
                new_inits.push(*v);
            }
        }
        let (lb, ub, step) = (b.opd(f, 0), b.opd(f, 1), b.opd(f, 2));
        let mut cur = Cursor::before(b, f);
        let (nf, nblk) = cur.for_loop(lb, ub, step, &new_inits);
        // 搬循环体：旧块参数 ⇒ 新块参数（展开的取那组）
        let oblk = b.entry(f, 0);
        let oargs = b[oblk].args.to_vec();
        let nargs = b[nblk].args.to_vec();
        b.replace_all_uses(oargs[0], nargs[0]);
        let mut k = 1;
        for (i, c) in conv.iter().enumerate() {
            let n = if *c { 1 + Self::segments(b.ty(inits[i])).map_or(0, |(a, s)| a + s) } else { 1 };
            let g = nargs[k..k + n].to_vec();
            b.replace_all_uses(oargs[i + 1], g[0]);
            if *c {
                self.groups.insert(g[0], g.clone());
            }
            k += n;
        }
                b.splice(oblk, None, nblk, None);
        // yield
        if let Some(y) = b.terminator(nblk).filter(|y| b.is(*y, Kind::ScfYield)) {
            self.yields.push((y, conv.clone()));
        }
        // 结果
        let ores = b[f].results.to_vec();
        let nres = b[nf].results.to_vec();
        let mut k = 0;
        for (i, c) in conv.iter().enumerate() {
            let n = if *c { 1 + Self::segments(b.ty(inits[i])).map_or(0, |(a, s)| a + s) } else { 1 };
            let g = nres[k..k + n].to_vec();
            b.replace_all_uses(ores[i], g[0]);
            if *c {
                self.groups.insert(g[0], g.clone());
            }
            k += n;
        }
        b.erase(f);
    }
}
