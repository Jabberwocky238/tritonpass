//! `structured-to-memref`（triton-shared `StructuredToMemref*.cpp`，改过的形态）：指针实参的类型换成一维动态的
//! `memref<?xT>`（经 `builtin.unrealized_conversion_cast`）；`tts.make_tptr` 只剩根视图（一维行距 1 是参数本身的
//! `memref.cast`，其余 `memref.reinterpret_cast` 到 `[UNB, …]`）；`tts.load` ⇒ 静态 tile 的 `memref.alloc` + 根上一次
//! subview + `linalg.copy` + `bufferization.to_tensor`，`tts.store` ⇒ subview + `bufferization.materialize_in_destination`；
//! 写法 G 的标量 `tts.gather` ⇒ `memref.load`。gather / scatter 的行指针 P6 已拒收，这里不移植。
use mlirformat::{Attribute, Dim, Error, Shaped, ShapedKind, StridedLayout, Type};
use mlirpass::{Body, ConversionConfig, ConversionPatterns, ConversionRewriter, ConversionTarget, Converter, MemrefLayout, Mode, OpData, OpId, Rewriter, TypeConverter, ValueId, pass, patterns};

use crate::ir::{TtBuilder, dense_i32, dense_i64, dense_values};
use crate::pass::ofr::{Ofr, OfrBuilder};
use crate::pass::window::{StrideKind, Tptr, UNBOUNDED, Window};
use crate::{Ir, Kind, pointee};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

#[pass("structured-to-memref", on = "builtin.module", ty = StructuredToMemref)]
pub fn structured_to_memref<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let tc = Mem::converter();
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    WithTc::populate(&mut patterns, i);
    NoTc::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    for d in ["func", "arith", "math", "linalg", "affine", "scf", "cf", "tensor", "bufferization", "memref"] {
        target.legal_dialect(d);
    }
    target.illegal_op(Kind::TtsLoad.name()).illegal_op(Kind::TtsStore.name()).illegal_op(Kind::TtsMakeTptr.name());
    target.dynamic_op(Kind::TtsGather.name(), |b, op| Some(!Mem::scalar_gather(b, op)));
    target.legal_op("builtin.unrealized_conversion_cast");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}

/// memref 类型与 OpFoldResult 的小工具。
pub(crate) struct Mem;

impl Mem {
    fn converter<'c>() -> TypeConverter<'c> {
        let mut tc = TypeConverter::default();
        tc.conversion(|t| Some(Some(vec![t.clone()])));
        tc.conversion(|t| match t {
            Type::Extended(e) if e.name == "tt.ptr" => Some(Some(vec![Self::memref(&[Dim::DYNAMIC], pointee(t), None)])),
            _ => None,
        });
        fn cast<'a>(rw: &mut Rewriter<'_, 'a>, ty: &Type<'a>, inputs: &[ValueId]) -> Option<ValueId> {
            let c = rw.create(OpData::named("builtin.unrealized_conversion_cast").operands(inputs), core::slice::from_ref(ty));
            Some(rw.body[c].results[0])
        }
        tc.target(|rw, tys, inputs, _| match tys {
            [ty] => cast(rw, ty, inputs).map(|v| vec![v]),
            _ => None,
        });
        tc.source(|rw, ty, inputs| cast(rw, ty, inputs));
        tc
    }

    /// `MemRefType::get(shape, elem, layout)`。
    pub(crate) fn memref<'a>(dims: &[i64], elem: Type<'a>, layout: Option<StridedLayout>) -> Type<'a> {
        let shape = dims.iter().map(|d| if *d == Dim::DYNAMIC { Dim::Dynamic } else { Dim::Static(*d) }).collect();
        Type::Shaped(Shaped { kind: ShapedKind::MemRef, shape: Some(shape), elem: elem.into(), extras: layout.into_iter().map(Attribute::from).collect() })
    }

    fn scalar_gather(b: &Body<'_>, op: OpId) -> bool {
        b[op].operands.len() == 2 && !matches!(b.ty(b.opd(op, 1)), Type::Shaped(_)) && !matches!(b.ty(b.res(op, 0)), Type::Shaped(_))
    }

    /// `memref::SubViewOp::inferResultType`（不丢维）。
    fn subview_type<'a>(src: &Type<'a>, offsets: &[Ofr], sizes: &[Ofr]) -> Type<'a> {
        let Type::Shaped(s) = src else { unreachable!("memref") };
        let (strides, off) = s.strides_and_offset().expect("strided");
        let c = |o: &Ofr| o.int().unwrap_or(Dim::DYNAMIC);
        let mut offset = off;
        // SaturatedInteger：0 乘什么都是 0，否则有一个动态就是动态
        for (o, st) in offsets.iter().map(c).zip(&strides) {
            let term = if o == 0 || *st == 0 { 0 } else if o == Dim::DYNAMIC || *st == Dim::DYNAMIC { Dim::DYNAMIC } else { o * st };
            offset = if offset == Dim::DYNAMIC || term == Dim::DYNAMIC { Dim::DYNAMIC } else { offset + term };
        }
        Self::memref(&sizes.iter().map(c).collect::<Vec<_>>(), (*s.elem).clone(), Some(StridedLayout { strides, offset }))
    }

    /// `memref::SubViewOp::inferResultType`，行距也照算（动态的行距让结果的行距也动态）。
    fn subview_type_strided<'a>(src: &Type<'a>, offsets: &[Ofr], sizes: &[Ofr], strides: &[Ofr]) -> Type<'a> {
        let Type::Shaped(s) = src else { unreachable!("memref") };
        let (src_strides, off) = s.strides_and_offset().expect("strided");
        let c = |o: &Ofr| o.int().unwrap_or(Dim::DYNAMIC);
        let mul = |a: i64, b: i64| if a == 0 || b == 0 { 0 } else if a == Dim::DYNAMIC || b == Dim::DYNAMIC { Dim::DYNAMIC } else { a * b };
        let add = |a: i64, b: i64| if a == Dim::DYNAMIC || b == Dim::DYNAMIC { Dim::DYNAMIC } else { a + b };
        let mut offset = off;
        for (o, st) in offsets.iter().map(c).zip(&src_strides) {
            offset = add(offset, mul(o, *st));
        }
        let out_strides: Vec<i64> = src_strides.iter().zip(strides.iter().map(c)).map(|(a, b)| mul(*a, b)).collect();
        Self::memref(&sizes.iter().map(c).collect::<Vec<_>>(), (*s.elem).clone(), Some(StridedLayout { strides: out_strides, offset }))
    }

    /// 带 offsets / sizes / strides 三段的 op（subview、reinterpret_cast、extract_slice）。
    fn sliced<'a>(name: &str, src: ValueId, lists: [&[Ofr]; 3]) -> OpData<'a> {
        let mut operands = vec![src];
        let mut seg = vec![1i64];
        for l in lists {
            let d: Vec<ValueId> = l.iter().filter_map(|o| o.value()).collect();
            seg.push(d.len() as i64);
            operands.extend(d);
        }
        let st = |l: &[Ofr]| dense_i64(&l.iter().map(|o| o.static_value()).collect::<Vec<_>>());
        OpData::build(name).operands(&operands).with("operandSegmentSizes", dense_i32(&seg)).with("static_offsets", st(lists[0])).with("static_sizes", st(lists[1])).with("static_strides", st(lists[2]))
    }

    fn create<'a>(cr: &mut Cr<'_, 'a, '_>, d: OpData<'a>, ty: Type<'a>) -> ValueId {
        let o = cr.rw.create(d, &[ty]);
        cr.rw.body[o].results[0]
    }

    /// `isPositiveZero`：+0.0 或整数 0（标量或 splat）。
    fn positive_zero(b: &Body<'_>, v: ValueId) -> bool {
        let Some(c) = b.constant(v) else { return false };
        c.values.first().is_some_and(|x| c.values.iter().all(|y| y == x) && match x {
            mlirformat::Scalar::Int(i) => i.signed() == 0,
            mlirformat::Scalar::Float(f) => f.to_f64() == 0.0 && !f.to_f64().is_sign_negative(),
        })
    }

    /// 窗口的各维偏移（`materializeWindowOffsets`）。
    fn offsets(cr: &mut Cr<'_, '_, '_>, op: OpId, plan: &crate::pass::window::WindowPlan) -> Vec<Ofr> {
        let mut q = mlirpass::Quiet;
        let mut c = Rewriter::new(&mut *cr.rw.body, &mut q);
        c.before_op(op);
        Window::materialize_offsets(plan, &mut c)
    }
}

/// 带类型转换器的模式。
struct WithTc;

#[patterns(converter)]
impl WithTc {
    #[convert("tts.make_tptr")]
    fn make_tptr(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let t = Tptr::of(cr.rw.body, op);
        let Ok(plan) = Window::plan(cr.rw.body, &t) else { return false };
        let base = o[0][0];
        let rank = t.sizes.len();
        let s0 = plan.strides[0];
        let v = if rank == 1 && s0.kind == StrideKind::Const && s0.value == 1 {
            let ty = cr.rw.body[base].ty.clone();
            Mem::create(cr, OpData::build(Kind::MemrefCast.name()).operands(&[base]), ty)
        } else {
            let elem = pointee(cr.rw.body.ty(t.base));
            let strides = Window::root_strides(&t, &plan);
            let layout = StridedLayout { strides: strides.iter().map(|o| o.static_value()).collect(), offset: 0 };
            let ty = Mem::memref(&vec![UNBOUNDED; rank], elem, Some(layout));
            let sizes = vec![Ofr::idx(UNBOUNDED); rank];
            Mem::create(cr, Mem::sliced(Kind::MemrefReinterpretCast.name(), base, [&[Ofr::idx(0)], &sizes, &strides]), ty)
        };
        cr.replace_values(op, &[v]);
        true
    }

    /// `MakeGatherScatterTensorPtrConverter`：只剩转换过的基指针（同型的 unrealized cast），读写时再按行拆。
    #[convert("tts.make_gather_scatter_tptr")]
    fn make_gather_scatter_tptr(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let base = o[0][0];
        let ty = cr.rw.body[base].ty.clone();
        let v = Mem::create(cr, OpData::named("builtin.unrealized_conversion_cast").operands(&[base]), ty);
        cr.replace_values(op, &[v]);
        true
    }

    #[convert("tts.gather")]
    fn scalar_gather(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        if !Mem::scalar_gather(cr.rw.body, op) {
            return false;
        }
        let ptr = cr.rw.body.opd(op, 0);
        let mut off = cr.rw.body.opd(op, 1);
        if !matches!(cr.rw.body.ty(off), Type::Index) {
            off = Mem::create(cr, OpData::build(Kind::ArithIndexCast.name()).operands(&[off]), Type::Index);
        }
        let elem = pointee(cr.rw.body.ty(ptr));
        let rt = Mem::memref(&[UNBOUNDED], elem.clone(), Some(StridedLayout { strides: vec![1], offset: 0 }));
        let root = Mem::create(cr, Mem::sliced(Kind::MemrefReinterpretCast.name(), o[0][0], [&[Ofr::idx(0)], &[Ofr::idx(UNBOUNDED)], &[Ofr::idx(1)]]), rt);
        let v = Mem::create(cr, OpData::build(Kind::MemrefLoad.name()).operands(&[root, off]), elem);
        cr.replace_values(op, &[v]);
        true
    }
}

/// 不带类型转换器的模式（读写）。
struct NoTc;

#[patterns]
impl NoTc {
    #[convert("tts.load")]
    fn load(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        if let Some(gs) = b.def_of(b.opd(op, 0), Kind::TtsMakeGatherScatterTptr) {
            return GatherScatter::of(b, gs).load(cr, op, o[0][0]);
        }
        let Some(make) = b.def_of(b.opd(op, 0), Kind::TtsMakeTptr) else { return false };
        if !Window::check(b, make, Window::is_written(b, make), &mut Vec::new()) {
            return false;
        }
        let t = Tptr::of(b, make);
        let Ok(plan) = Window::plan(b, &t) else { return false };
        let tt = b.ty(b.res(op, 0)).clone();
        let shape = tt.dims().unwrap_or_default();
        let elem = tt.element_type().clone();
        let mask = Self::mask(b, op, true);
        let other = Self::other(b, op);
        let root = o[0][0];
        let offsets = Mem::offsets(cr, op, &plan);
        let (dims, full) = Self::dims(cr.rw.body, mask, &shape);
        let alloc = Mem::create(cr, OpData::build(Kind::MemrefAlloc.name()).with("operandSegmentSizes", dense_i32(&[0, 0])), Mem::memref(&shape, elem.clone(), None));
        if let Some(x) = other.filter(|x| !Mem::positive_zero(cr.rw.body, *x)) {
            Self::fill(cr, x, alloc);
        } else if !full {
            let d = <Body<'_> as crate::Build<'_>>::constant_data(Self::zero(&elem), &elem);
            let z = Mem::create(cr, d, elem.clone());
            Self::fill(cr, z, alloc);
        }
        let ones = vec![Ofr::idx(1); shape.len()];
        let rty = cr.rw.body[root].ty.clone();
        let src = Mem::create(cr, Mem::sliced(Kind::MemrefSubview.name(), root, [&offsets, &dims, &ones]), Mem::subview_type(&rty, &offsets, &dims));
        let mut dst = alloc;
        if !full {
            let zeros = vec![Ofr::idx(0); shape.len()];
            let aty = cr.rw.body[alloc].ty.clone();
            dst = Mem::create(cr, Mem::sliced(Kind::MemrefSubview.name(), alloc, [&zeros, &dims, &ones]), Mem::subview_type(&aty, &zeros, &dims));
        }
        cr.structured(Kind::LinalgCopy.name(), &[src], &[dst], &[], Vec::new(), &mut |_, a| vec![a[0]]);
        let tv = Mem::create(cr, OpData::build(Kind::BufferizationToTensor.name()).operands(&[alloc]).with("restrict", Attribute::Unit).with("writable", Attribute::Unit), tt);
        cr.replace_values(op, &[tv]);
        true
    }

    #[convert("tts.store")]
    fn store(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        if let Some(gs) = b.def_of(b.opd(op, 0), Kind::TtsMakeGatherScatterTptr) {
            return GatherScatter::of(b, gs).store(cr, op, o[0][0], o[1][0]);
        }
        let Some(make) = b.def_of(b.opd(op, 0), Kind::TtsMakeTptr) else { return false };
        if !Window::check(b, make, true, &mut Vec::new()) {
            return false;
        }
        let t = Tptr::of(b, make);
        let Ok(plan) = Window::plan(b, &t) else { return false };
        let value = b.opd(op, 1);
        let vt = b.ty(value).clone();
        let shape = vt.dims().unwrap_or_default();
        let mask = Self::mask(b, op, false);
        let root = o[0][0];
        let offsets = Mem::offsets(cr, op, &plan);
        let (dims, full) = Self::dims(cr.rw.body, mask, &shape);
        let ones = vec![Ofr::idx(1); shape.len()];
        let mut source = value;
        if !full {
            let zeros = vec![Ofr::idx(0); shape.len()];
            let st = Type::tensor(&dims.iter().map(|d| d.int().unwrap_or(Dim::DYNAMIC)).collect::<Vec<_>>(), vt.element_type().clone());
            source = Mem::create(cr, Mem::sliced(Kind::TensorExtractSlice.name(), value, [&zeros, &dims, &ones]), st);
        }
        let rty = cr.rw.body[root].ty.clone();
        let dst = Mem::create(cr, Mem::sliced(Kind::MemrefSubview.name(), root, [&offsets, &dims, &ones]), Mem::subview_type(&rty, &offsets, &dims));
        cr.rw.create(OpData::build(Kind::BufferizationMaterializeInDestination.name()).operands(&[source, dst]).with("writable", Attribute::Unit), &[]);
        cr.erase(op);
        true
    }
}

impl NoTc {
    fn mask(b: &Body<'_>, op: OpId, load: bool) -> Option<Vec<Ofr>> {
        let n = dense_values(b[op].get("static_mask_dims")).len();
        if n == 0 {
            return None;
        }
        let ops = &b[op].operands;
        let dynv = if load {
            let seg = dense_values(b[op].get("operandSegmentSizes"));
            &ops[1..1 + seg.get(1).copied().unwrap_or(0) as usize]
        } else {
            &ops[2..]
        };
        Some(Tptr::mixed(b, op, "static_mask_dims", dynv))
    }

    fn other(b: &Body<'_>, op: OpId) -> Option<ValueId> {
        let seg = dense_values(b[op].get("operandSegmentSizes"));
        (seg.get(2).copied().unwrap_or(0) > 0).then(|| *b[op].operands.last().expect("other"))
    }

    /// 各维的有效个数（整块有效时是静态 tile 尺寸）与是不是整块。
    fn dims(b: &Body<'_>, mask: Option<Vec<Ofr>>, shape: &[i64]) -> (Vec<Ofr>, bool) {
        let full = mask.as_ref().is_none_or(|m| Window::is_full(b, m, shape));
        if full {
            return (shape.iter().map(|s| Ofr::idx(*s)).collect(), true);
        }
        (mask.expect("有 mask"), false)
    }

    fn zero(t: &Type<'_>) -> mlirformat::Scalar {
        match crate::ir::float_kind(t) {
            Some(k) => crate::ir::float(k, 0.0),
            None => crate::ir::integer(t.bit_width().unwrap_or(32), 0),
        }
    }

    fn fill(cr: &mut Cr<'_, '_, '_>, value: ValueId, alloc: ValueId) {
        let et = cr.rw.body[alloc].ty.element_type().clone();
        cr.structured(Kind::LinalgFill.name(), &[value], &[alloc], &[], Vec::new(), &mut |cr, a| vec![cr.cast_scalar(a[0], &et, false)]);
    }
}

/// `tts.make_gather_scatter_tptr` 读出来的样子：按行取的偏移张量与 mask、gather 维、各维尺寸、行距、偏移。
struct GatherScatter {
    offset: ValueId,
    mask: Option<ValueId>,
    dim: usize,
    sizes: Vec<i64>,
    strides: Vec<Ofr>,
    offsets: Vec<Ofr>,
    result: Type<'static>,
}

impl GatherScatter {
    fn of(b: &Body<'_>, op: OpId) -> Self {
        let seg = dense_values(b[op].get("operandSegmentSizes"));
        let ops = &b[op].operands;
        let n = |i: usize| seg.get(i).copied().unwrap_or(0) as usize;
        let (ns, no) = (n(2), n(3));
        let strides = Tptr::mixed(b, op, "static_strides", &ops[2..2 + ns]);
        let offsets = Tptr::mixed(b, op, "static_offsets", &ops[2 + ns..2 + ns + no]);
        let mask = (n(4) > 0).then(|| ops[2 + ns + no]);
        Self {
            offset: ops[1],
            mask,
            dim: b.int_attr(op, "gather_scatter_dim").unwrap_or(0) as usize,
            sizes: dense_values(b[op].get("sizes")),
            strides,
            offsets,
            result: b.ty(b.res(op, 0)).owned(),
        }
    }

    /// `getMixedStridesForMemref`：尺寸为 1、行距为常量 0 的维换成累乘的尺寸（从最内一维往外）。
    fn memref_strides(&self) -> Vec<Ofr> {
        let mut out = Vec::new();
        let mut acc = 1i64;
        for (size, stride) in self.sizes.iter().zip(&self.strides).rev() {
            out.push(if *size == 1 && stride.int() == Some(0) { Ofr::idx(acc) } else { *stride });
            acc *= size;
        }
        out.reverse();
        out
    }

    /// `rewriteGatherScatterPtrElement`：第 `elt` 行的视图（gather 维尺寸 1）。
    fn element(&self, cr: &mut Cr<'_, '_, '_>, memref: ValueId, elt: ValueId) -> ValueId {
        let strides = self.memref_strides();
        let mut offsets = self.offsets.clone();
        offsets[self.dim] = Ofr::V(elt);
        let mut target = Ofr::idx(0);
        for (i, o) in offsets.iter().enumerate() {
            let o = if i == self.dim { cr.rw.mul_ofr(*o, strides[i]) } else { *o };
            target = cr.rw.add_ofr(target, o);
        }
        let mut sizes = self.sizes.clone();
        sizes[self.dim] = 1;
        let elem = pointee(&self.result).element_type().clone();
        let layout = StridedLayout { strides: strides.iter().map(|s| s.static_value()).collect(), offset: target.int().unwrap_or(Dim::DYNAMIC) };
        let ty = Mem::memref(&sizes, elem, Some(layout));
        let size_ofr: Vec<Ofr> = sizes.iter().map(|s| Ofr::idx(*s)).collect();
        Mem::create(cr, Mem::sliced(Kind::MemrefReinterpretCast.name(), memref, [&[target], &size_ofr, &strides]), ty)
    }

    fn index(cr: &mut Cr<'_, '_, '_>, v: i64) -> ValueId {
        Mem::create(cr, OpData::build(Kind::ArithConstant.name()).with("value", Attribute::index(v)), Type::Index)
    }

    /// 偏移转成 index、循环上界（mask 收窄）、空循环与（有非结构化 mask 时）其中的 scf.if；插入点留在体的开头（或 then 里）。
    /// 返回（循环，0，1，归纳变量，偏移张量，各维尺寸）。
    #[expect(clippy::type_complexity, reason = "几样一起交出")]
    fn begin(&self, cr: &mut Cr<'_, '_, '_>, mask: Option<Vec<Ofr>>) -> (OpId, ValueId, ValueId, ValueId, ValueId, Vec<Ofr>) {
        let ot = cr.rw.body.ty(self.offset).clone();
        let oshape = ot.dims().unwrap_or_default();
        let mut size = oshape[0];
        let offset = Mem::create(cr, OpData::build(Kind::ArithIndexCast.name()).operands(&[self.offset]), Type::tensor(&oshape, Type::Index));
        let mut sizes: Vec<Ofr> = self.sizes.iter().map(|s| Ofr::idx(*s)).collect();
        sizes[self.dim] = Ofr::idx(1);
        let lb = Self::index(cr, 0);
        let mut ub = Self::index(cr, size);
        if let Some(dims) = &mask {
            match dims[self.dim] {
                Ofr::I(v, _) => {
                    let v = if v == 0 && self.mask.is_some() { size } else { v };
                    size = size.min(v);
                    ub = Self::index(cr, size);
                }
                Ofr::V(d) => {
                    let s = Self::index(cr, size);
                    ub = Mem::create(cr, OpData::build(Kind::ArithMinsi.name()).operands(&[d, s]), Type::Index);
                }
            }
        }
        let step = Self::index(cr, 1);
        let loc = cr.rw.loc.clone();
        let l = cr.rw.create_with(OpData::build(Kind::ScfFor.name()).operands(&[lb, ub, step]), &[], |b, o| {
            let r = b.add_region(o);
            let blk = b.add_block(r, &[(Type::Index, loc.clone())]);
            let y = b.create(OpData::build(Kind::ScfYield.name()), &[]);
            b.insert(y, blk, None);
        });
        (l, lb, step, cr.rw.body[cr.rw.body.top_block(l)].args[0], offset, sizes)
    }

    /// 插入点移进循环体（有非结构化 mask 时再进 `scf.if` 的 then）。
    fn enter(&self, cr: &mut Cr<'_, '_, '_>, l: OpId, iv: ValueId) {
        let blk = cr.rw.body.top_block(l);
        cr.rw.set_start(blk);
        if let Some(m) = self.mask {
            let et = cr.rw.body.ty(m).element_type().clone();
            let mv = Mem::create(cr, OpData::build(Kind::TensorExtract.name()).operands(&[m, iv]), et);
            let i = cr.rw.create_with(OpData::build(Kind::ScfIf.name()).operands(&[mv]), &[], |b, o| {
                let r = b.add_region(o);
                b.add_region(o);
                let blk = b.add_block(r, &[]);
                let y = b.create(OpData::build(Kind::ScfYield.name()), &[]);
                b.insert(y, blk, None);
            });
            let then = cr.rw.body.top_block(i);
            cr.rw.set_start(then);
        }
    }

    /// `LoadConverter::rewriteGather`。
    fn load(&self, cr: &mut Cr<'_, '_, '_>, op: OpId, memref: ValueId) -> bool {
        let b = &*cr.rw.body;
        let rt = b.ty(b.res(op, 0)).clone();
        let shape = rt.dims().unwrap_or_default();
        let elem = rt.element_type().clone();
        let mask = NoTc::mask(b, op, true);
        let other = NoTc::other(b, op);
        let atype = Mem::memref(&shape, elem, None);
        let alloc = Mem::create(cr, OpData::build(Kind::MemrefAlloc.name()).with("operandSegmentSizes", dense_i32(&[0, 0])), atype.clone());
        if let Some(x) = other {
            NoTc::fill(cr, x, alloc);
        }
        let (l, lb, step, iv, offset, mut sizes) = self.begin(cr, mask.clone());
        let tv = Mem::create(cr, OpData::build(Kind::BufferizationToTensor.name()).operands(&[alloc]).with("restrict", Attribute::Unit).with("writable", Attribute::Unit), rt);
        cr.replace_values(op, &[tv]);
        self.enter(cr, l, iv);
        let elt = Mem::create(cr, OpData::build(Kind::TensorExtract.name()).operands(&[offset, iv]), Type::Index);
        let mut src = self.element(cr, memref, elt);
        let rank = self.sizes.len();
        let ones = vec![Ofr::V(step); rank];
        if let Some(mut dims) = mask {
            dims[self.dim] = sizes[self.dim];
            sizes = dims;
            let zeros = vec![Ofr::V(lb); rank];
            let sty = cr.rw.body[src].ty.clone();
            src = Mem::create(cr, Mem::sliced(Kind::MemrefSubview.name(), src, [&zeros, &sizes, &ones]), Mem::subview_type_strided(&sty, &zeros, &sizes, &ones));
        }
        let mut at = vec![Ofr::V(lb); rank];
        at[self.dim] = Ofr::V(iv);
        let dst = Mem::create(cr, Mem::sliced(Kind::MemrefSubview.name(), alloc, [&at, &sizes, &ones]), Mem::subview_type_strided(&atype, &at, &sizes, &ones));
        cr.rw.create(OpData::build(Kind::MemrefCopy.name()).operands(&[src, dst]), &[]);
        true
    }

    /// `StoreConverter::rewriteScatter`。
    fn store(&self, cr: &mut Cr<'_, '_, '_>, op: OpId, memref: ValueId, value: ValueId) -> bool {
        let mask = NoTc::mask(cr.rw.body, op, false);
        let (l, lb, step, iv, offset, mut sizes) = self.begin(cr, mask.clone());
        let _ = l;
        self.enter(cr, l, iv);
        let elt = Mem::create(cr, OpData::build(Kind::TensorExtract.name()).operands(&[offset, iv]), Type::Index);
        let rank = self.sizes.len();
        let mut at = vec![Ofr::V(lb); rank];
        at[self.dim] = Ofr::V(iv);
        if let Some(mut dims) = mask.clone() {
            dims[self.dim] = sizes[self.dim];
            sizes = dims;
        }
        let ones = vec![Ofr::V(step); rank];
        let vt = cr.rw.body.ty(value).clone();
        let st = Type::tensor(&sizes.iter().map(|d| d.int().unwrap_or(Dim::DYNAMIC)).collect::<Vec<_>>(), vt.element_type().clone());
        let slice = Mem::create(cr, Mem::sliced(Kind::TensorExtractSlice.name(), value, [&at, &sizes, &ones]), st);
        let mut dst = self.element(cr, memref, elt);
        if mask.is_some() {
            let zeros = vec![Ofr::V(lb); rank];
            let dty = cr.rw.body[dst].ty.clone();
            dst = Mem::create(cr, Mem::sliced(Kind::MemrefSubview.name(), dst, [&zeros, &sizes, &ones]), Mem::subview_type_strided(&dty, &zeros, &sizes, &ones));
        }
        cr.rw.create(OpData::build(Kind::BufferizationMaterializeInDestination.name()).operands(&[slice, dst]).with("writable", Attribute::Unit), &[]);
        cr.erase(op);
        true
    }
}
