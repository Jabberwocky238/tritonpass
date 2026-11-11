//! `triton-ptr-to-memref`（triton-shared `TritonPtrToMemrefPass.cpp`，改过签名）：函数签名里的指针换成一维动态的
//! `memref<?xT>`（指针张量换成同形的 memref），块参数一并换；旧用处经源物化的 `builtin.unrealized_conversion_cast` 接上，
//! 之后 canonicalize + cse 把成对的转换折掉。
use mlirformat::{Attribute, Dim, Error, FunctionType, Type};
use mlirpass::{ConversionConfig, ConversionPatterns, ConversionRewriter, ConversionTarget, Converter, Mode, OpData, OpId, PassManager, Passes, Rewriter, SignatureConversion, TypeConverter, ValueId, pass, patterns};

use super::structured_to_memref::Mem;
use crate::{Kind, pointee};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

#[pass("triton-ptr-to-memref", on = "builtin.module", ty = TritonPtrToMemref)]
pub fn triton_ptr_to_memref<'a>(body: &mut mlirpass::Body<'a>, op: OpId) -> Result<(), Error> {
    let tc = Sig::converter();
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    Sig::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    let legal = |b: &mlirpass::Body<'_>, f: OpId| Some(Sig::function_type(b, f).is_none_or(|ft| Sig::converter().is_signature_legal(&ft.inputs, &ft.results)));
    target.dynamic_op(Kind::FuncFunc.name(), legal).dynamic_op(Kind::TtFunc.name(), legal);
    target.dynamic_op(Kind::FuncCall.name(), |b, op| Some(Sig::converter().is_legal_op(b, op)));
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)?;
    let mut passes = Passes::new();
    passes.register::<mlirpass::Canonicalize>().register::<mlirpass::Cse>();
    PassManager::parse(&passes, &format!("{}(canonicalize, cse)", body[op].name))?.run_on(body, op, &moremath::ThreadSingle)
}

/// 签名转换。
struct Sig;

impl Sig {
    fn converter<'c>() -> TypeConverter<'c> {
        let mut tc = TypeConverter::default();
        tc.conversion(|t| Some(Some(vec![t.clone()])));
        tc.conversion(|t| match t {
            Type::Extended(e) if e.name == "tt.ptr" => Some(Some(vec![Mem::memref(&[Dim::DYNAMIC], pointee(t), None)])),
            _ => None,
        });
        tc.conversion(|t| match t {
            Type::Shaped(s) if s.kind == mlirformat::ShapedKind::Tensor && matches!(&*s.elem, Type::Extended(e) if e.name == "tt.ptr") => Some(Some(vec![Mem::memref(&t.dims().unwrap_or_default(), pointee(&s.elem), None)])),
            _ => None,
        });
        tc.source(|rw: &mut Rewriter<'_, '_>, ty, inputs| {
            let c = rw.create(OpData::named("builtin.unrealized_conversion_cast").operands(inputs), core::slice::from_ref(ty));
            Some(rw.body[c].results[0])
        });
        tc
    }

    fn function_type<'a>(b: &mlirpass::Body<'a>, f: OpId) -> Option<FunctionType<'a>> {
        match b[f].get("function_type") {
            Some(Attribute::Type(Type::Function(ft))) => Some(*ft.clone()),
            _ => None,
        }
    }
}

#[patterns(converter)]
impl Sig {
    /// `FunctionOpInterfaceSignatureConversion`。
    #[convert("func.func", "tt.func")]
    fn function(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(ft) = Self::function_type(cr.rw.body, op) else { return false };
        let Some(tc) = cr.type_converter() else { return false };
        let mut sig = SignatureConversion::new(ft.inputs.len());
        for (i, t) in ft.inputs.iter().enumerate() {
            let Some(ts) = tc.convert_types(t) else { return false };
            sig.add_inputs(i, ts);
        }
        let Some(results) = tc.convert_all(&ft.results) else { return false };
        let converter = cr.current.expect("转换器");
        let region = cr.rw.body[op].regions[0];
        if cr.convert_region_types(region, converter, Some(&sig)).is_none() {
            return false;
        }
        let nt = FunctionType { inputs: sig.converted_types().to_vec(), results, ..ft };
        cr.modify(op, |b| b[op].set("function_type", Attribute::Type(Type::Function(Box::new(nt)))));
        true
    }

    /// `CallOpSignatureConversion`。
    #[convert("func.call")]
    fn call(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(tc) = cr.type_converter() else { return false };
        let rts: Vec<Type<'_>> = cr.rw.body[op].results.iter().map(|r| cr.rw.body[*r].ty.clone()).collect();
        let Some(nts) = tc.convert_all(&rts) else { return false };
        let operands: Vec<ValueId> = o.iter().flatten().copied().collect();
        let mut d = OpData::build(Kind::FuncCall.name()).operands(&operands);
        d.properties.clone_from(&cr.rw.body[op].properties);
        d.attributes.clone_from(&cr.rw.body[op].attributes);
        d.loc.clone_from(&cr.rw.body[op].loc);
        cr.replace_new(op, d, &nts);
        true
    }
}
