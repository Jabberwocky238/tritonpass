//! `triton-to-structured`（triton-shared `TritonToStructuredPass.cpp`）：prepass 把 scf 携带的指针、整型偏移张量展开成
//! （值, 各维偏移, 各维行距）放进 `tts.get_structured_state` 的占位里，再由 [`PtrAnalysis`] 改写指针算术与读写。
//!
//! prepass 照 C++ 是两轮 1→N 的方言转换（mlirpass 的 [`ScfStructural`]）：先把这类值换成 tuple 再 canonicalize，再把
//! tuple 拆平、要的地方补 `tts.get_structured_state`，最后 reconcile-unrealized-casts。
use mlirformat::{Error, Type};
use mlirpass::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpData, OpId, PassManager, Passes, Rewriter, ScfStructural, TypeConverter, ValueId, pass};

use crate::pass::ptr_analysis::PtrAnalysis;
use crate::ir::dense_i32;
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
            Prepass::run(body, op)?;
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

/// prepass（`runTritonToStructuredPrepass`）：两轮 1→N 的方言转换，类型转换器各一个。
struct Prepass;

impl Prepass {
    /// 要展开成几个偏移、几个行距（`GetStructuredStateOp::getOffsetAndStrideTypes`）；不展开是 `None`。
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

    /// `getStructuredStateTupleType`：tuple<t, 各维偏移, 各维行距>（都是 index）。
    fn tuple<'a>(t: &Type<'a>) -> Option<Type<'a>> {
        let (no, ns) = Self::segments(t)?;
        let mut ts = vec![t.clone()];
        ts.extend(core::iter::repeat_n(Type::Index, no + ns));
        Some(Type::Tuple(ts))
    }

    /// 一个类型转换器下的 scf 结构转换（`populateSCFStructuralTypeConversionsAndLegality` + `applyPartialConversion`）。
    fn convert(body: &mut Body<'_>, op: OpId, tc: &TypeConverter<'_>) -> Result<(), Error> {
        let mut target = ConversionTarget::default();
        ScfStructural::target(&mut target, tc);
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(tc);
        ScfStructural::populate(&mut patterns, i);
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }

    /// 一个 unrealized_conversion_cast。
    fn cast<'a>(rw: &mut Rewriter<'_, 'a>, types: &[Type<'a>], inputs: &[ValueId]) -> Vec<ValueId> {
        let o = rw.create(OpData::build("builtin.unrealized_conversion_cast").operands(inputs), types);
        rw.body[o].results.to_vec()
    }

    fn run(body: &mut Body<'_>, op: OpId) -> Result<(), Error> {
        // `convertToPointerTupleWithOffsetsAndStrides`：指针 / 整型张量换成 tuple，再 canonicalize
        let mut tc = TypeConverter::default();
        tc.conversion(|t| Some(Some(vec![t.clone()])));
        tc.conversion(|t| match t {
            Type::Shaped(_) | Type::Extended(_) => Self::tuple(t).map(|u| Some(vec![u])),
            _ => None,
        });
        tc.source(|rw, ty, inputs| Self::cast(rw, core::slice::from_ref(ty), inputs).first().copied());
        tc.target(|rw, tys, inputs, _| Some(Self::cast(rw, tys, &inputs[..1])));
        Self::convert(body, op, &tc)?;
        Canon::run(body, op)?;
        // `decomposePointerTuple`：tuple 拆平；要的地方补 get_structured_state（取 tuple 来源 cast 的操作数），再消掉 cast
        let mut tc = TypeConverter::default();
        tc.conversion(|t| Some(Some(vec![t.clone()])));
        tc.conversion(|t| match t {
            Type::Tuple(ts) => Some(Some(ts.clone())),
            _ => None,
        });
        tc.source(|rw, ty, inputs| Self::cast(rw, core::slice::from_ref(ty), &inputs[..1]).first().copied());
        tc.target(|rw, tys, inputs, _| {
            let def = rw.body.def_op(inputs[0])?;
            let src = rw.body[def].operands[0];
            let (no, ns) = Self::segments(rw.body.ty(src))?;
            let d = OpData::build(Kind::TtsGetStructuredState.name()).operands(&[src]).with("resultSegmentSizes", dense_i32(&[1, no as i64, ns as i64]));
            let o = rw.create(d, tys);
            Some(rw.body[o].results.to_vec())
        });
        Self::convert(body, op, &tc)?;
        let mut passes = Passes::new();
        passes.register::<mlirpass::ReconcileUnrealizedCasts>();
        PassManager::parse(&passes, &format!("{}(reconcile-unrealized-casts)", body[op].name))?.run_on(body, op, &moremath::ThreadSingle)
    }
}
