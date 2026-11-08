//! `tt` 里语法写在 Triton 的 C++ 里（或 ODS 用了 mlirformat 的格式引擎不认的指令：`oilist`、`functional-type(operands, …)`、
//! 结果类型要从指针类型推）的 op：手写后按名字注入（`MlirOpt::inject`），盖过 `tt.gen.rs` 里只有通用形式的那一份，生成的文件不动。
//!
//! 各 op 的写法照 Triton 3.7.1 `lib/Dialect/Triton/IR/Ops.cpp` 与 `TritonOps.td` 的 `assemblyFormat`。
use core::fmt::{self, Write};

use mlirformat::{Attribute, BlockArg, FunctionType, NamedAttr, Op, Parse, Parser, Print, Printer, R, Region, Type, Value, mlir};

use super::tt::{CacheModifier, EvictionPolicy, InputPrecision, MemSemantic, MemSyncScope, PaddingOption, RMWOp};

/// `!tt.ptr<T>` / `!tt.ptr<T, 地址空间>` 的指向类型；张量的指针换成张量的指向类型（`getPointeeType`）。不是指针原样给回。
pub fn pointee(ty: &Type<'_>) -> Type<'static> {
    let elem = ty.element_type();
    let Type::Extended(e) = elem else { return ty.owned() };
    if e.name != "tt.ptr" {
        return ty.owned();
    }
    let inner = match (&e.body, e.params.first()) {
        (_, Some(Attribute::Type(t))) => t.owned(),
        (Some(body), _) => {
            let body = body.trim();
            let text = body.strip_prefix('<').and_then(|b| b.strip_suffix('>')).unwrap_or(body);
            let first = top_level_first(text);
            match Parser::read(first, |p| p.ty()) {
                Ok(t) => t.owned(),
                Err(_) => return ty.owned(),
            }
        }
        _ => return ty.owned(),
    };
    match ty {
        Type::Shaped(_) => ty.owned().with_element(inner),
        _ => inner,
    }
}

/// `a, b` 里第一个顶层（不在尖括号、方括号、圆括号里）逗号之前的那段。
fn top_level_first(text: &str) -> &str {
    let mut depth = 0i32;
    for (i, c) in text.char_indices() {
        match c {
            '<' | '(' | '[' | '{' => depth += 1,
            '>' | ')' | ']' | '}' => depth -= 1,
            ',' if depth == 0 => return text[..i].trim(),
            _ => {}
        }
    }
    text.trim()
}

/// `DefaultValuedAttr<DenseI32ArrayAttr, {}>`：空的 `array<i32>`。
fn empty_i32_array() -> Attribute<'static> {
    Attribute::DenseArray { ty: Type::Integer { signedness: mlirformat::Signedness::Signless, width: 32 }, values: Vec::new() }
}

/// 自定义形式里印不印这个缺省值属性：等于缺省值的不印（`printOptionalAttrDict` 跳过取缺省值的 property）。
fn non_default<'x, 'a>(v: &'x Option<Attribute<'a>>, default: &Attribute<'_>) -> Option<&'x Attribute<'a>> {
    v.as_ref().filter(|a| a.owned() != default.owned())
}

/// `%a, %b`
fn print_values(p: &mut Printer<'_, '_>, values: &[Value<'_>]) -> fmt::Result {
    for (i, v) in values.iter().enumerate() {
        write!(p, "{}{v}", if i > 0 { ", " } else { "" })?;
    }
    Ok(())
}

/// `(T, U) -> R`：`functional-type(operands, results)`；单个、不是函数类型的结果不带括号。
fn print_functional(p: &mut Printer<'_, '_>, inputs: &[&Type<'_>], results: &[&Type<'_>]) -> fmt::Result {
    p.write_char('(')?;
    for (i, t) in inputs.iter().enumerate() {
        write!(p, "{}{t}", if i > 0 { ", " } else { "" })?;
    }
    p.write_str(") -> ")?;
    match results {
        [t] if !matches!(t, Type::Function(_)) => write!(p, "{t}"),
        ts => {
            p.write_char('(')?;
            for (i, t) in ts.iter().enumerate() {
                write!(p, "{}{t}", if i > 0 { ", " } else { "" })?;
            }
            p.write_char(')')
        }
    }
}

/// `oilist(`cacheModifier` `=` $cache | `evictionPolicy` `=` $evict)`：缺省值不印。
fn print_cache_evict(p: &mut Printer<'_, '_>, cache: Option<CacheModifier>, evict: Option<EvictionPolicy>) -> fmt::Result {
    if let Some(c) = cache.filter(|c| *c != CacheModifier::None) {
        write!(p, " cacheModifier = {}", erased::name(&c)?)?;
    }
    if let Some(e) = evict.filter(|e| *e != EvictionPolicy::EvictNormal) {
        write!(p, " evictionPolicy = {}", erased::name(&e)?)?;
    }
    Ok(())
}

/// attr-dict 里写着的固有属性（`{cache = 1 : i32}`）取出来：MLIR 读入时按名字搬进 property。
fn take_attr<'a>(attrs: &mut Vec<NamedAttr<'a>>, name: &str) -> Option<Attribute<'static>> {
    let i = attrs.iter().position(|a| a.name == name)?;
    attrs.remove(i).value.map(|v| v.owned())
}

/// 同上，整数取值按枚举的 case 读（`CacheModifier::try_from(1)` 是 `none`）。
fn take_case<T: TryFrom<i64>>(p: &Parser<'_, '_>, attrs: &mut Vec<NamedAttr<'_>>, name: &str) -> R<Option<T>> {
    let Some(a) = take_attr(attrs, name) else { return Ok(None) };
    let v = a.int().ok().and_then(|v| i64::try_from(v).ok()).and_then(|v| T::try_from(v).ok());
    v.map_or_else(|| p.err(format!("`{name}`：取值不认识")), |v| Ok(Some(v)))
}

/// 读 `oilist(`cacheModifier` `=` $cache | `evictionPolicy` `=` $evict)`（次序不限，各至多一次）。
fn parse_cache_evict(p: &mut Parser<'_, '_>) -> R<(Option<CacheModifier>, Option<EvictionPolicy>)> {
    let (mut cache, mut evict) = (None, None);
    loop {
        if cache.is_none() && p.eat_kw("cacheModifier") {
            p.expect("=")?;
            cache = Some(erased::keyword(p)?);
        } else if evict.is_none() && p.eat_kw("evictionPolicy") {
            p.expect("=")?;
            evict = Some(erased::keyword(p)?);
        } else {
            return Ok((cache, evict));
        }
    }
}

/// 读 `: (T, U) -> R` 的函数类型（冒号已经读过）。
fn parse_functional<'a>(p: &mut Parser<'a, '_>) -> R<FunctionType<'a>> {
    p.fn_ty()
}

/// `tt.func [visibility] @name(%arg: T {attrs} loc(..), ...) -> R attributes {...} { body }`：
/// 与 `func.func` 同一种写法（`function_interface_impl`），区域里的 op 一律写全名。
#[mlir::op("tt.func", custom)]
pub struct FuncOp<'a> {
    pub sym_name: String,
    #[attr]
    pub function_type: Type<'a>,
    pub sym_visibility: Option<String>,
    pub arg_attrs: Option<Attribute<'a>>,
    pub res_attrs: Option<Attribute<'a>>,
    pub body: Region<'a>,
}

impl<'a> FuncOp<'a> {
    fn nth<'x>(attrs: &'x Option<Attribute<'a>>, i: usize) -> Option<&'x Attribute<'a>> {
        match attrs {
            Some(Attribute::Array(ds)) => ds.get(i).filter(|d| !matches!(d, Attribute::Dict(xs) if xs.is_empty())),
            _ => None,
        }
    }

    fn dicts(ds: Vec<Vec<NamedAttr<'a>>>) -> Option<Attribute<'a>> {
        ds.iter().any(|d| !d.is_empty()).then(|| Attribute::Array(ds.into_iter().map(Attribute::Dict).collect()))
    }
}

impl Print for FuncOp<'_> {
    fn print(&self, p: &mut Printer<'_, '_>) -> fmt::Result {
        let Type::Function(ty) = &self.function_type else { return Err(fmt::Error) };
        p.op_name(Self::NAME)?;
        if let Some(v) = &self.sym_visibility {
            write!(p, " {v}")?;
        }
        p.write_char(' ')?;
        p.sym_name(&self.sym_name)?;
        p.write_char('(')?;
        let entry = self.body.blocks.first();
        for (i, t) in ty.inputs.iter().enumerate() {
            p.write_str(if i > 0 { ", " } else { "" })?;
            let arg = entry.and_then(|b| b.args.get(i));
            match arg {
                Some(a) => write!(p, "%{}: {t}", a.name)?,
                None => write!(p, "{t}")?,
            }
            if let Some(d) = Self::nth(&self.arg_attrs, i) {
                write!(p, " {d}")?;
            }
            p.loc(&arg.and_then(|a| a.loc.clone()))?;
        }
        p.write_char(')')?;
        match ty.results.as_slice() {
            [] => {}
            [t] if Self::nth(&self.res_attrs, 0).is_none() && !matches!(t, Type::Function(_)) => write!(p, " -> {t}")?,
            ts => {
                p.write_str(" -> (")?;
                for (i, t) in ts.iter().enumerate() {
                    write!(p, "{}{t}", if i > 0 { ", " } else { "" })?;
                    if let Some(d) = Self::nth(&self.res_attrs, i) {
                        write!(p, " {d}")?;
                    }
                }
                p.write_char(')')?;
            }
        }
        p.attr_dict("attributes ", &self.attrs, &[])?;
        if !self.body.blocks.is_empty() {
            p.write_char(' ')?;
            p.region_in(None, &self.body, false)?;
        }
        p.loc(&self.loc)
    }
}

impl Parse for FuncOp<'_> {
    fn parse(p: &mut Parser<'_, '_>) -> R<Self> {
        let sym_visibility = ["private", "public", "nested"].into_iter().find(|v| p.eat_kw(v)).map(String::from);
        let sym_name = p.sym_name()?;
        p.expect("(")?;
        let entries = p.list(")", |p| {
            let named = if p.at(b'%') {
                let name = p.sigil('%')?.into();
                p.expect(":")?;
                Some(name)
            } else {
                None
            };
            let ty = p.ty()?;
            let attrs = p.opt_dict()?;
            let loc = p.opt_loc()?;
            Ok((named.map(|name| BlockArg { name, ty: ty.clone(), loc }), ty, attrs))
        })?;
        let results = if !p.eat("->") {
            Vec::new()
        } else if p.eat("(") {
            p.list(")", |p| Ok((p.ty()?, p.opt_dict()?)))?
        } else {
            vec![(p.ty()?, Vec::new())]
        };
        let attrs = if p.eat_kw("attributes") { p.dict()? } else { Vec::new() };
        let mut body = if p.at(b'{') { p.region_in(None)? } else { Region { blocks: Vec::new() } };
        let mut args = Vec::new();
        let (mut inputs, mut arg_dicts) = (Vec::new(), Vec::new());
        for (arg, ty, d) in entries {
            args.extend(arg);
            inputs.push(ty);
            arg_dicts.push(d);
        }
        if let Some(b) = body.blocks.first_mut() {
            b.label = (!args.is_empty()).then(|| "bb0".into());
            b.args = args;
        }
        let (results, res_dicts): (Vec<_>, Vec<_>) = results.into_iter().unzip();
        let op = FuncOp {
            sym_name,
            function_type: Type::Function(FunctionType { inputs, results }),
            sym_visibility,
            arg_attrs: FuncOp::dicts(arg_dicts),
            res_attrs: FuncOp::dicts(res_dicts),
            body,
            attrs,
            loc: p.opt_loc()?,
        };
        Self::owned(op, p)
    }
}

/// `tt.call @callee(%a, %b) : (T, U) -> R`（`call_interface_impl`）。
#[mlir::op("tt.call", format = "$callee `(` $operands `)` attr-dict `:` functional-type($operands, $result)", results(result))]
pub struct CallOp<'a> {
    pub callee: Attribute<'a>,
    #[slot(operands_ty)]
    pub operands: Vec<Value<'a>>,
    pub arg_attrs: Option<Attribute<'a>>,
    pub res_attrs: Option<Attribute<'a>>,
    pub operands_ty: Vec<Type<'a>>,
    pub result: Vec<Type<'a>>,
}

/// `tt.load %ptr (, %mask)? (, %other)? oilist(cacheModifier = …| evictionPolicy = …) attr-dict : type($ptr)`；
/// 结果与 `other` 是指针的指向类型，`mask` 是同形的 `i1`。
#[mlir::op("tt.load", custom, results(result))]
pub struct LoadOp<'a> {
    #[slot(ptr_ty)]
    pub ptr: Value<'a>,
    #[slot(mask_ty)]
    pub mask: Vec<Value<'a>>,
    #[slot(other_ty)]
    pub other: Vec<Value<'a>>,
    #[attr(name = "boundaryCheck", dense = "i32")]
    pub boundary_check: Option<Attribute<'a>>,
    #[attr(int = "i32")]
    pub padding: Option<Attribute<'a>>,
    #[attr(int = "i32", default = "1")]
    pub cache: Option<CacheModifier>,
    #[attr(int = "i32", default = "1")]
    pub evict: Option<EvictionPolicy>,
    #[attr(name = "isVolatile", default = "false")]
    pub is_volatile: Option<Attribute<'a>>,
    pub ptr_ty: Type<'a>,
    pub mask_ty: Vec<Type<'a>>,
    pub other_ty: Vec<Type<'a>>,
    pub result: Type<'a>,
}

impl Print for LoadOp<'_> {
    fn print(&self, p: &mut Printer<'_, '_>) -> fmt::Result {
        p.op_name(Self::NAME)?;
        write!(p, " {}", self.ptr)?;
        for v in self.mask.iter().chain(&self.other) {
            write!(p, ", {v}")?;
        }
        print_cache_evict(p, self.cache, self.evict)?;
        let mut attrs = self.attrs.clone();
        if let Some(b) = non_default(&self.boundary_check, &empty_i32_array()) {
            attrs.push(NamedAttr::of("boundaryCheck", b.owned()));
        }
        if let Some(pad) = &self.padding {
            attrs.push(NamedAttr::of("padding", pad.owned()));
        }
        if let Some(v) = non_default(&self.is_volatile, &Attribute::Bool(false)) {
            attrs.push(NamedAttr::of("isVolatile", v.owned()));
        }
        attrs.sort_by(|a, b| a.name.cmp(&b.name));
        p.attr_dict("", &attrs, &[])?;
        write!(p, " : {}", self.ptr_ty)?;
        p.loc(&self.loc)
    }
}

impl Parse for LoadOp<'_> {
    fn parse(p: &mut Parser<'_, '_>) -> R<Self> {
        let ptr = p.value()?;
        let mut rest = Vec::new();
        while p.eat(",") {
            rest.push(p.value()?);
        }
        let (cache, evict) = parse_cache_evict(p)?;
        let mut attrs = p.opt_dict()?;
        p.expect(":")?;
        let ptr_ty = p.ty()?;
        let boundary_check = Some(take_attr(&mut attrs, "boundaryCheck").unwrap_or_else(empty_i32_array));
        let is_volatile = Some(take_attr(&mut attrs, "isVolatile").unwrap_or(Attribute::Bool(false)));
        let padding = take_attr(&mut attrs, "padding");
        let cache = cache.or(take_case(p, &mut attrs, "cache")?);
        let evict = evict.or(take_case(p, &mut attrs, "evict")?);
        let value = pointee(&ptr_ty);
        let mut it = rest.into_iter();
        let mask: Vec<_> = it.next().into_iter().collect();
        let other: Vec<_> = it.next().into_iter().collect();
        let op = LoadOp {
            mask_ty: mask.iter().map(|_| value.i1_like()).collect(),
            other_ty: other.iter().map(|_| value.clone()).collect(),
            ptr,
            mask,
            other,
            boundary_check,
            padding,
            cache: Some(cache.unwrap_or(CacheModifier::None)),
            evict: Some(evict.unwrap_or(EvictionPolicy::EvictNormal)),
            is_volatile,
            result: value,
            ptr_ty,
            attrs,
            loc: p.opt_loc()?,
        };
        Self::owned(op, p)
    }
}

/// `tt.store %ptr, %value (, %mask)? oilist(…) attr-dict : type($ptr)`。
#[mlir::op("tt.store", custom)]
pub struct StoreOp<'a> {
    #[slot(ptr_ty)]
    pub ptr: Value<'a>,
    #[slot(value_ty)]
    pub value: Value<'a>,
    #[slot(mask_ty)]
    pub mask: Vec<Value<'a>>,
    #[attr(name = "boundaryCheck", dense = "i32")]
    pub boundary_check: Option<Attribute<'a>>,
    #[attr(int = "i32", default = "1")]
    pub cache: Option<CacheModifier>,
    #[attr(int = "i32", default = "1")]
    pub evict: Option<EvictionPolicy>,
    pub ptr_ty: Type<'a>,
    pub value_ty: Type<'a>,
    pub mask_ty: Vec<Type<'a>>,
}

impl Print for StoreOp<'_> {
    fn print(&self, p: &mut Printer<'_, '_>) -> fmt::Result {
        p.op_name(Self::NAME)?;
        write!(p, " {}, {}", self.ptr, self.value)?;
        for v in &self.mask {
            write!(p, ", {v}")?;
        }
        print_cache_evict(p, self.cache, self.evict)?;
        let mut attrs = self.attrs.clone();
        if let Some(b) = non_default(&self.boundary_check, &empty_i32_array()) {
            attrs.push(NamedAttr::of("boundaryCheck", b.owned()));
        }
        p.attr_dict("", &attrs, &[])?;
        write!(p, " : {}", self.ptr_ty)?;
        p.loc(&self.loc)
    }
}

impl Parse for StoreOp<'_> {
    fn parse(p: &mut Parser<'_, '_>) -> R<Self> {
        let ptr = p.value()?;
        p.expect(",")?;
        let value = p.value()?;
        let mask: Vec<_> = if p.eat(",") { vec![p.value()?] } else { Vec::new() };
        let (cache, evict) = parse_cache_evict(p)?;
        let mut attrs = p.opt_dict()?;
        p.expect(":")?;
        let ptr_ty = p.ty()?;
        let boundary_check = Some(take_attr(&mut attrs, "boundaryCheck").unwrap_or_else(empty_i32_array));
        let cache = cache.or(take_case(p, &mut attrs, "cache")?);
        let evict = evict.or(take_case(p, &mut attrs, "evict")?);
        let value_ty = pointee(&ptr_ty);
        let op = StoreOp {
            mask_ty: mask.iter().map(|_| value_ty.i1_like()).collect(),
            ptr,
            value,
            mask,
            boundary_check,
            cache: Some(cache.unwrap_or(CacheModifier::None)),
            evict: Some(evict.unwrap_or(EvictionPolicy::EvictNormal)),
            value_ty,
            ptr_ty,
            attrs,
            loc: p.opt_loc()?,
        };
        Self::owned(op, p)
    }
}

/// `tt.atomic_rmw <op>, <sem>, <scope>, %ptr, %val (, %mask)? attr-dict : (operands) -> R`。
#[mlir::op("tt.atomic_rmw", custom, results(result))]
pub struct AtomicRMWOp<'a> {
    #[slot(ptr_ty)]
    pub ptr: Value<'a>,
    #[slot(val_ty)]
    pub val: Value<'a>,
    #[slot(mask_ty)]
    pub mask: Vec<Value<'a>>,
    #[attr(int = "i32")]
    pub atomic_rmw_op: RMWOp,
    #[attr(int = "i32")]
    pub sem: MemSemantic,
    #[attr(int = "i32")]
    pub scope: MemSyncScope,
    pub ptr_ty: Type<'a>,
    pub val_ty: Type<'a>,
    pub mask_ty: Vec<Type<'a>>,
    pub result: Type<'a>,
}

impl Print for AtomicRMWOp<'_> {
    fn print(&self, p: &mut Printer<'_, '_>) -> fmt::Result {
        p.op_name(Self::NAME)?;
        write!(p, " {}, {}, {}, {}, {}", erased::name(&self.atomic_rmw_op)?, erased::name(&self.sem)?, erased::name(&self.scope)?, self.ptr, self.val)?;
        for v in &self.mask {
            write!(p, ", {v}")?;
        }
        p.attr_dict("", &self.attrs, &[])?;
        p.write_str(" : ")?;
        let mut inputs = vec![&self.ptr_ty, &self.val_ty];
        inputs.extend(&self.mask_ty);
        print_functional(p, &inputs, &[&self.result])?;
        p.loc(&self.loc)
    }
}

impl Parse for AtomicRMWOp<'_> {
    fn parse(p: &mut Parser<'_, '_>) -> R<Self> {
        let atomic_rmw_op = erased::keyword(p)?;
        p.expect(",")?;
        let sem = erased::keyword(p)?;
        p.expect(",")?;
        let scope = erased::keyword(p)?;
        p.expect(",")?;
        let ptr = p.value()?;
        p.expect(",")?;
        let val = p.value()?;
        let mask: Vec<_> = if p.eat(",") { vec![p.value()?] } else { Vec::new() };
        let attrs = p.opt_dict()?;
        p.expect(":")?;
        let FunctionType { mut inputs, mut results } = parse_functional(p)?;
        if inputs.len() != 2 + mask.len() || results.len() != 1 {
            return p.err("`tt.atomic_rmw`：函数类型与操作数个数对不上");
        }
        let mask_ty = inputs.split_off(2);
        let val_ty = inputs.pop().unwrap_or(Type::NoneType);
        let ptr_ty = inputs.pop().unwrap_or(Type::NoneType);
        let op = AtomicRMWOp { ptr, val, mask, atomic_rmw_op, sem, scope, ptr_ty, val_ty, mask_ty, result: results.remove(0), attrs, loc: p.opt_loc()? };
        Self::owned(op, p)
    }
}

/// `tt.atomic_cas <sem>, <scope>, %ptr, %cmp, %val attr-dict : (operands) -> R`。
#[mlir::op("tt.atomic_cas", custom, results(result))]
pub struct AtomicCASOp<'a> {
    #[slot(ptr_ty)]
    pub ptr: Value<'a>,
    #[slot(cmp_ty)]
    pub cmp: Value<'a>,
    #[slot(val_ty)]
    pub val: Value<'a>,
    #[attr(int = "i32")]
    pub sem: MemSemantic,
    #[attr(int = "i32")]
    pub scope: MemSyncScope,
    pub ptr_ty: Type<'a>,
    pub cmp_ty: Type<'a>,
    pub val_ty: Type<'a>,
    pub result: Type<'a>,
}

impl Print for AtomicCASOp<'_> {
    fn print(&self, p: &mut Printer<'_, '_>) -> fmt::Result {
        p.op_name(Self::NAME)?;
        write!(p, " {}, {}, {}, {}, {}", erased::name(&self.sem)?, erased::name(&self.scope)?, self.ptr, self.cmp, self.val)?;
        p.attr_dict("", &self.attrs, &[])?;
        p.write_str(" : ")?;
        print_functional(p, &[&self.ptr_ty, &self.cmp_ty, &self.val_ty], &[&self.result])?;
        p.loc(&self.loc)
    }
}

impl Parse for AtomicCASOp<'_> {
    fn parse(p: &mut Parser<'_, '_>) -> R<Self> {
        let sem = erased::keyword(p)?;
        p.expect(",")?;
        let scope = erased::keyword(p)?;
        p.expect(",")?;
        let ptr = p.value()?;
        p.expect(",")?;
        let cmp = p.value()?;
        p.expect(",")?;
        let val = p.value()?;
        let attrs = p.opt_dict()?;
        p.expect(":")?;
        let FunctionType { inputs, mut results } = parse_functional(p)?;
        let [ptr_ty, cmp_ty, val_ty]: [Type<'_>; 3] = inputs.try_into().or_else(|_| p.err("`tt.atomic_cas`：要三个操作数类型"))?;
        if results.len() != 1 {
            return p.err("`tt.atomic_cas`：要一个结果");
        }
        let op = AtomicCASOp { ptr, cmp, val, sem, scope, ptr_ty, cmp_ty, val_ty, result: results.remove(0), attrs, loc: p.opt_loc()? };
        Self::owned(op, p)
    }
}

/// `tt.gather %src[%indices] attr-dict : (S, I) -> R`。
#[mlir::op("tt.gather", custom, results(result))]
pub struct GatherOp<'a> {
    #[slot(src_ty)]
    pub src: Value<'a>,
    #[slot(indices_ty)]
    pub indices: Value<'a>,
    #[attr(int = "i32")]
    pub axis: Attribute<'a>,
    pub efficient_layout: bool,
    pub src_ty: Type<'a>,
    pub indices_ty: Type<'a>,
    pub result: Type<'a>,
}

impl Print for GatherOp<'_> {
    fn print(&self, p: &mut Printer<'_, '_>) -> fmt::Result {
        p.op_name(Self::NAME)?;
        write!(p, " {}[{}]", self.src, self.indices)?;
        let mut attrs = self.attrs.clone();
        attrs.push(NamedAttr::of("axis", self.axis.owned()));
        if self.efficient_layout {
            attrs.push(NamedAttr { name: "efficient_layout".into(), value: None });
        }
        p.attr_dict("", &attrs, &[])?;
        p.write_str(" : ")?;
        print_functional(p, &[&self.src_ty, &self.indices_ty], &[&self.result])?;
        p.loc(&self.loc)
    }
}

impl Parse for GatherOp<'_> {
    fn parse(p: &mut Parser<'_, '_>) -> R<Self> {
        let src = p.value()?;
        p.expect("[")?;
        let indices = p.value()?;
        p.expect("]")?;
        let mut attrs = p.opt_dict()?;
        p.expect(":")?;
        let FunctionType { inputs, mut results } = parse_functional(p)?;
        let [src_ty, indices_ty]: [Type<'_>; 2] = inputs.try_into().or_else(|_| p.err("`tt.gather`：要两个操作数类型"))?;
        let axis_at = attrs.iter().position(|a| a.name == "axis");
        let Some(axis) = axis_at.and_then(|i| attrs.remove(i).value.map(|v| v.owned())) else { return p.err("`tt.gather`：缺 axis") };
        let efficient_at = attrs.iter().position(|a| a.name == "efficient_layout");
        let efficient_layout = efficient_at.map(|i| attrs.remove(i)).is_some();
        if results.len() != 1 {
            return p.err("`tt.gather`：要一个结果");
        }
        let op = GatherOp { src, indices, axis, efficient_layout, src_ty, indices_ty, result: results.remove(0), attrs, loc: p.opt_loc()? };
        Self::owned(op, p)
    }
}

/// `tt.extern_elementwise %a, %b attr-dict : (A, B) -> R`。
#[mlir::op("tt.extern_elementwise", custom, results(result))]
pub struct ExternElementwiseOp<'a> {
    #[slot(srcs_ty)]
    pub srcs: Vec<Value<'a>>,
    pub libname: Attribute<'a>,
    pub libpath: Attribute<'a>,
    pub symbol: Attribute<'a>,
    pub pure: Attribute<'a>,
    pub srcs_ty: Vec<Type<'a>>,
    pub result: Type<'a>,
}

impl Print for ExternElementwiseOp<'_> {
    fn print(&self, p: &mut Printer<'_, '_>) -> fmt::Result {
        p.op_name(Self::NAME)?;
        p.write_char(' ')?;
        print_values(p, &self.srcs)?;
        let mut attrs = self.attrs.clone();
        for (name, v) in [("libname", &self.libname), ("libpath", &self.libpath), ("pure", &self.pure), ("symbol", &self.symbol)] {
            attrs.push(NamedAttr::of(name, v.owned()));
        }
        attrs.sort_by(|a, b| a.name.cmp(&b.name));
        p.attr_dict("", &attrs, &[])?;
        p.write_str(" : ")?;
        let inputs: Vec<&Type<'_>> = self.srcs_ty.iter().collect();
        print_functional(p, &inputs, &[&self.result])?;
        p.loc(&self.loc)
    }
}

impl Parse for ExternElementwiseOp<'_> {
    fn parse(p: &mut Parser<'_, '_>) -> R<Self> {
        let mut srcs = Vec::new();
        if p.at(b'%') {
            srcs.push(p.value()?);
            while p.eat(",") {
                srcs.push(p.value()?);
            }
        }
        let mut attrs = p.opt_dict()?;
        p.expect(":")?;
        let FunctionType { inputs, mut results } = parse_functional(p)?;
        let mut take = |name: &str| attrs.iter().position(|a| a.name == name).map(|i| attrs.remove(i)).and_then(|a| a.value.map(|v| v.owned()));
        let (Some(libname), Some(libpath), Some(symbol), Some(pure)) = (take("libname"), take("libpath"), take("symbol"), take("pure")) else {
            return p.err("`tt.extern_elementwise`：缺 libname / libpath / symbol / pure");
        };
        if results.len() != 1 || inputs.len() != srcs.len() {
            return p.err("`tt.extern_elementwise`：函数类型与操作数个数对不上");
        }
        let op = ExternElementwiseOp { srcs, libname, libpath, symbol, pure, srcs_ty: inputs, result: results.remove(0), attrs, loc: p.opt_loc()? };
        Self::owned(op, p)
    }
}

/// `tt.unsplat %src attr-dict : type($src)`：结果是张量的元素类型。
#[mlir::op("tt.unsplat", custom, results(result))]
pub struct UnsplatOp<'a> {
    #[slot(src_ty)]
    pub src: Value<'a>,
    pub src_ty: Type<'a>,
    pub result: Type<'a>,
}

impl Print for UnsplatOp<'_> {
    fn print(&self, p: &mut Printer<'_, '_>) -> fmt::Result {
        p.op_name(Self::NAME)?;
        write!(p, " {}", self.src)?;
        p.attr_dict("", &self.attrs, &[])?;
        write!(p, " : {}", self.src_ty)?;
        p.loc(&self.loc)
    }
}

impl Parse for UnsplatOp<'_> {
    fn parse(p: &mut Parser<'_, '_>) -> R<Self> {
        let src = p.value()?;
        let attrs = p.opt_dict()?;
        p.expect(":")?;
        let src_ty = p.ty()?;
        let result = src_ty.element_type().clone();
        let op = UnsplatOp { src, result, src_ty, attrs, loc: p.opt_loc()? };
        Self::owned(op, p)
    }
}

/// `tt.descriptor_load %desc[%i, %j] oilist(…) attr-dict : D -> R`。
#[mlir::op("tt.descriptor_load", custom, results(result))]
pub struct DescriptorLoadOp<'a> {
    #[slot(desc_ty)]
    pub desc: Value<'a>,
    #[slot(indices_ty)]
    pub indices: Vec<Value<'a>>,
    #[attr(int = "i32", default = "1")]
    pub cache: Option<CacheModifier>,
    #[attr(int = "i32", default = "1")]
    pub evict: Option<EvictionPolicy>,
    pub desc_ty: Type<'a>,
    pub indices_ty: Vec<Type<'a>>,
    pub result: Type<'a>,
}

impl Print for DescriptorLoadOp<'_> {
    fn print(&self, p: &mut Printer<'_, '_>) -> fmt::Result {
        p.op_name(Self::NAME)?;
        write!(p, " {}[", self.desc)?;
        print_values(p, &self.indices)?;
        p.write_char(']')?;
        print_cache_evict(p, self.cache, self.evict)?;
        p.attr_dict("", &self.attrs, &[])?;
        write!(p, " : {} -> {}", self.desc_ty, self.result)?;
        p.loc(&self.loc)
    }
}

impl Parse for DescriptorLoadOp<'_> {
    fn parse(p: &mut Parser<'_, '_>) -> R<Self> {
        let desc = p.value()?;
        p.expect("[")?;
        let indices = p.list("]", Parser::value)?;
        let (cache, evict) = parse_cache_evict(p)?;
        let mut attrs = p.opt_dict()?;
        let cache = cache.or(take_case(p, &mut attrs, "cache")?);
        let evict = evict.or(take_case(p, &mut attrs, "evict")?);
        p.expect(":")?;
        let desc_ty = p.ty()?;
        p.expect("->")?;
        let result = p.ty()?;
        let i32_ty = Type::Integer { signedness: mlirformat::Signedness::Signless, width: 32 };
        let (cache, evict) = (Some(cache.unwrap_or(CacheModifier::None)), Some(evict.unwrap_or(EvictionPolicy::EvictNormal)));
        let op = DescriptorLoadOp { indices_ty: indices.iter().map(|_| i32_ty.clone()).collect(), desc, indices, cache, evict, desc_ty, result, attrs, loc: p.opt_loc()? };
        Self::owned(op, p)
    }
}

/// `tt.descriptor_gather %desc[%x, %y] attr-dict : (D, X, Y) -> R`。
#[mlir::op("tt.descriptor_gather", custom, results(result))]
pub struct DescriptorGatherOp<'a> {
    #[slot(desc_ty)]
    pub desc: Value<'a>,
    #[slot(x_offsets_ty)]
    pub x_offsets: Value<'a>,
    #[slot(y_offset_ty)]
    pub y_offset: Value<'a>,
    pub desc_ty: Type<'a>,
    pub x_offsets_ty: Type<'a>,
    pub y_offset_ty: Type<'a>,
    pub result: Type<'a>,
}

impl Print for DescriptorGatherOp<'_> {
    fn print(&self, p: &mut Printer<'_, '_>) -> fmt::Result {
        p.op_name(Self::NAME)?;
        write!(p, " {}[{}, {}]", self.desc, self.x_offsets, self.y_offset)?;
        p.attr_dict("", &self.attrs, &[])?;
        p.write_str(" : ")?;
        print_functional(p, &[&self.desc_ty, &self.x_offsets_ty, &self.y_offset_ty], &[&self.result])?;
        p.loc(&self.loc)
    }
}

impl Parse for DescriptorGatherOp<'_> {
    fn parse(p: &mut Parser<'_, '_>) -> R<Self> {
        let desc = p.value()?;
        p.expect("[")?;
        let x_offsets = p.value()?;
        p.expect(",")?;
        let y_offset = p.value()?;
        p.expect("]")?;
        let attrs = p.opt_dict()?;
        p.expect(":")?;
        let FunctionType { inputs, mut results } = parse_functional(p)?;
        let [desc_ty, x_offsets_ty, y_offset_ty]: [Type<'_>; 3] = inputs.try_into().or_else(|_| p.err("`tt.descriptor_gather`：要三个操作数类型"))?;
        if results.len() != 1 {
            return p.err("`tt.descriptor_gather`：要一个结果");
        }
        let op = DescriptorGatherOp { desc, x_offsets, y_offset, desc_ty, x_offsets_ty, y_offset_ty, result: results.remove(0), attrs, loc: p.opt_loc()? };
        Self::owned(op, p)
    }
}

/// `tt.descriptor_scatter %desc[%x, %y], %src attr-dict : D, X, Y, S`（`type(operands)`）。
#[mlir::op("tt.descriptor_scatter", custom)]
pub struct DescriptorScatterOp<'a> {
    #[slot(desc_ty)]
    pub desc: Value<'a>,
    #[slot(x_offsets_ty)]
    pub x_offsets: Value<'a>,
    #[slot(y_offset_ty)]
    pub y_offset: Value<'a>,
    #[slot(src_ty)]
    pub src: Value<'a>,
    pub desc_ty: Type<'a>,
    pub x_offsets_ty: Type<'a>,
    pub y_offset_ty: Type<'a>,
    pub src_ty: Type<'a>,
}

impl Print for DescriptorScatterOp<'_> {
    fn print(&self, p: &mut Printer<'_, '_>) -> fmt::Result {
        p.op_name(Self::NAME)?;
        write!(p, " {}[{}, {}], {}", self.desc, self.x_offsets, self.y_offset, self.src)?;
        p.attr_dict("", &self.attrs, &[])?;
        write!(p, " : {}, {}, {}, {}", self.desc_ty, self.x_offsets_ty, self.y_offset_ty, self.src_ty)?;
        p.loc(&self.loc)
    }
}

impl Parse for DescriptorScatterOp<'_> {
    fn parse(p: &mut Parser<'_, '_>) -> R<Self> {
        let desc = p.value()?;
        p.expect("[")?;
        let x_offsets = p.value()?;
        p.expect(",")?;
        let y_offset = p.value()?;
        p.expect("]")?;
        p.expect(",")?;
        let src = p.value()?;
        let attrs = p.opt_dict()?;
        p.expect(":")?;
        let desc_ty = p.ty()?;
        p.expect(",")?;
        let x_offsets_ty = p.ty()?;
        p.expect(",")?;
        let y_offset_ty = p.ty()?;
        p.expect(",")?;
        let src_ty = p.ty()?;
        let op = DescriptorScatterOp { desc, x_offsets, y_offset, src, desc_ty, x_offsets_ty, y_offset_ty, src_ty, attrs, loc: p.opt_loc()? };
        Self::owned(op, p)
    }
}

/// 同方言类型的「去掉前缀」写法（`type($x)` 对 TypeDef 约束的类型印成 `<…>`，不带 `!tt.ptr`）。
fn print_stripped(p: &mut Printer<'_, '_>, ty: &Type<'_>) -> fmt::Result {
    match ty {
        Type::Extended(e) if e.body.is_some() => p.write_str(e.body.as_deref().unwrap_or_default()),
        t => write!(p, "{t}"),
    }
}

/// `tt.dot %a, %b, %c (, inputPrecision = …)? attr-dict : A * B -> D`：可选组挂在取缺省值（ieee）的枚举上，缺省值不印。
#[mlir::op("tt.dot", custom, results(d))]
pub struct DotOp<'a> {
    #[slot(a_ty)]
    pub a: Value<'a>,
    #[slot(b_ty)]
    pub b: Value<'a>,
    #[slot(d)]
    pub c: Value<'a>,
    #[attr(name = "inputPrecision", int = "i32", default = "2")]
    pub input_precision: Option<InputPrecision>,
    #[attr(name = "maxNumImpreciseAcc", int = "i32", default = "0")]
    pub max_num_imprecise_acc: Option<Attribute<'a>>,
    pub a_ty: Type<'a>,
    pub b_ty: Type<'a>,
    pub d: Type<'a>,
}

impl Print for DotOp<'_> {
    fn print(&self, p: &mut Printer<'_, '_>) -> fmt::Result {
        p.op_name(Self::NAME)?;
        write!(p, " {}, {}, {}", self.a, self.b, self.c)?;
        if let Some(ip) = self.input_precision.filter(|ip| *ip != InputPrecision::Ieee) {
            write!(p, ", inputPrecision = {}", erased::name(&ip)?)?;
        }
        let mut attrs = self.attrs.clone();
        let zero = Attribute::of_int(0, Type::Integer { signedness: mlirformat::Signedness::Signless, width: 32 });
        if let Some(m) = non_default(&self.max_num_imprecise_acc, &zero) {
            attrs.push(NamedAttr::of("maxNumImpreciseAcc", m.owned()));
        }
        p.attr_dict("", &attrs, &[])?;
        write!(p, " : {} * {} -> {}", self.a_ty, self.b_ty, self.d)?;
        p.loc(&self.loc)
    }
}

impl Parse for DotOp<'_> {
    fn parse(p: &mut Parser<'_, '_>) -> R<Self> {
        let a = p.value()?;
        p.expect(",")?;
        let b = p.value()?;
        p.expect(",")?;
        let c = p.value()?;
        let input_precision = if p.eat(",") {
            if !p.eat_kw("inputPrecision") {
                return p.err("`tt.dot`：逗号之后要 inputPrecision");
            }
            p.expect("=")?;
            erased::keyword(p)?
        } else {
            InputPrecision::Ieee
        };
        let mut attrs = p.opt_dict()?;
        // 写进 attr-dict 的 inputPrecision（整数）也认
        let input_precision = match attrs.iter().position(|x| x.name == "inputPrecision") {
            Some(i) => {
                let v = attrs.remove(i).value.and_then(|v| v.int().ok()).unwrap_or(2);
                i64::try_from(v).ok().and_then(|v| InputPrecision::try_from(v).ok()).map_or_else(|| p.err("`tt.dot`：inputPrecision 取值不认识"), Ok)?
            }
            None => input_precision,
        };
        let at = attrs.iter().position(|x| x.name == "maxNumImpreciseAcc");
        let zero = Attribute::of_int(0, Type::Integer { signedness: mlirformat::Signedness::Signless, width: 32 });
        let max_num_imprecise_acc = Some(at.and_then(|i| attrs.remove(i).value.map(|v| v.owned())).unwrap_or(zero));
        p.expect(":")?;
        let a_ty = p.ty()?;
        p.expect("*")?;
        let b_ty = p.ty()?;
        p.expect("->")?;
        let d = p.ty()?;
        let op = DotOp { a, b, c, input_precision: Some(input_precision), max_num_imprecise_acc, a_ty, b_ty, d, attrs, loc: p.opt_loc()? };
        Self::owned(op, p)
    }
}

/// `tt.make_tensor_ptr %base, [%shape…], [%strides…], [%offsets…] attr-dict : <tensor<…>>`（结果类型去掉 `!tt.ptr` 前缀）。
/// 三组变长操作数个数相同（`SameVariadicOperandSize`，没有 `operandSegmentSizes`）：存成一组，印时三等分。
#[mlir::op("tt.make_tensor_ptr", custom, results(result))]
pub struct MakeTensorPtrOp<'a> {
    #[slot(base_ty)]
    pub base: Value<'a>,
    #[slot(rest_ty)]
    pub rest: Vec<Value<'a>>,
    #[attr(dense = "i32")]
    pub order: Attribute<'a>,
    pub base_ty: Type<'a>,
    pub rest_ty: Vec<Type<'a>>,
    pub result: Type<'a>,
}

fn int_ty(width: u32) -> Type<'static> {
    Type::Integer { signedness: mlirformat::Signedness::Signless, width }
}

/// `[%a, %b], [%c, %d]`：`values` 分成 `groups` 等份，各写一对方括号。
fn print_groups(p: &mut Printer<'_, '_>, values: &[Value<'_>], groups: usize) -> fmt::Result {
    let n = values.len() / groups.max(1);
    for (i, g) in values.chunks(n.max(1)).take(groups).enumerate() {
        p.write_str(if i > 0 { ", [" } else { "[" })?;
        print_values(p, if n == 0 { &[] } else { g })?;
        p.write_char(']')?;
    }
    if n == 0 {
        for i in 1..groups {
            p.write_str(if i > 0 { ", []" } else { "[]" })?;
        }
    }
    Ok(())
}

impl Print for MakeTensorPtrOp<'_> {
    fn print(&self, p: &mut Printer<'_, '_>) -> fmt::Result {
        p.op_name(Self::NAME)?;
        write!(p, " {}, ", self.base)?;
        print_groups(p, &self.rest, 3)?;
        let mut attrs = self.attrs.clone();
        attrs.push(NamedAttr::of("order", self.order.owned()));
        p.attr_dict("", &attrs, &[])?;
        p.write_str(" : ")?;
        print_stripped(p, &self.result)?;
        p.loc(&self.loc)
    }
}

impl Parse for MakeTensorPtrOp<'_> {
    fn parse(p: &mut Parser<'_, '_>) -> R<Self> {
        let base = p.value()?;
        let mut rest = Vec::new();
        let mut rest_ty = Vec::new();
        for width in [64, 64, 32] {
            p.expect(",")?;
            p.expect("[")?;
            let g = p.list("]", Parser::value)?;
            rest_ty.extend(g.iter().map(|_| int_ty(width)));
            rest.extend(g);
        }
        let mut attrs = p.opt_dict()?;
        let at = attrs.iter().position(|x| x.name == "order");
        let Some(order) = at.and_then(|i| attrs.remove(i).value.map(|v| v.owned())) else { return p.err("`tt.make_tensor_ptr`：缺 order") };
        p.expect(":")?;
        let result = p.stripped_ty("tt.ptr")?;
        // base 是指向块张量元素的指针：`!tt.ptr<元素>`
        let elem = pointee(&result).element_type().owned();
        let text = format!("!tt.ptr<{elem}>");
        let base_ty = Parser::read(&text, |q| q.ty()).map(|t| t.owned()).or_else(|e| p.err(format!("{e}")))?;
        let op = MakeTensorPtrOp { base, rest, order, base_ty, rest_ty, result, attrs, loc: p.opt_loc()? };
        Self::owned(op, p)
    }
}

/// `tt.make_tensor_descriptor %base, [%shape…], [%strides…] attr-dict : <base>, <desc>`（两个类型都去掉前缀）；
/// 两组变长操作数个数相同，存成一组。
#[mlir::op("tt.make_tensor_descriptor", custom, results(result))]
pub struct MakeTensorDescOp<'a> {
    #[slot(base_ty)]
    pub base: Value<'a>,
    #[slot(rest_ty)]
    pub rest: Vec<Value<'a>>,
    #[attr(int = "i32", default = "1")]
    pub padding: Option<PaddingOption>,
    pub base_ty: Type<'a>,
    pub rest_ty: Vec<Type<'a>>,
    pub result: Type<'a>,
}

impl Print for MakeTensorDescOp<'_> {
    fn print(&self, p: &mut Printer<'_, '_>) -> fmt::Result {
        p.op_name(Self::NAME)?;
        write!(p, " {}, ", self.base)?;
        print_groups(p, &self.rest, 2)?;
        let mut attrs = self.attrs.clone();
        if let Some(pad) = self.padding.filter(|x| *x != PaddingOption::Zero) {
            attrs.push(NamedAttr::of("padding", Attribute::of_int(pad as i128, int_ty(32))));
        }
        p.attr_dict("", &attrs, &[])?;
        p.write_str(" : ")?;
        print_stripped(p, &self.base_ty)?;
        p.write_str(", ")?;
        print_stripped(p, &self.result)?;
        p.loc(&self.loc)
    }
}

impl Parse for MakeTensorDescOp<'_> {
    fn parse(p: &mut Parser<'_, '_>) -> R<Self> {
        let base = p.value()?;
        let mut rest = Vec::new();
        let mut rest_ty = Vec::new();
        for width in [32, 64] {
            p.expect(",")?;
            p.expect("[")?;
            let g = p.list("]", Parser::value)?;
            rest_ty.extend(g.iter().map(|_| int_ty(width)));
            rest.extend(g);
        }
        let attrs = p.opt_dict()?;
        p.expect(":")?;
        let base_ty = p.stripped_ty("tt.ptr")?;
        p.expect(",")?;
        let result = p.stripped_ty("tt.tensordesc")?;
        let op = MakeTensorDescOp { base, rest, padding: Some(PaddingOption::Zero), base_ty, rest_ty, result, attrs, loc: p.opt_loc()? };
        Self::owned(op, p)
    }
}

/// 枚举取值的关键字（`ca`、`acq_rel`、`gpu` …）：生成的枚举经 serde 按 rename 的名字读写。
mod erased {
    use mlirformat::__serde::{Serialize, de::DeserializeOwned};
    use mlirformat::{Content, Parser, R};

    /// 枚举值的关键字。
    pub fn name<T: Serialize>(v: &T) -> Result<&'static str, core::fmt::Error> {
        match Content::of(v) {
            Ok(Content::Variant(_, _, name, _)) => Ok(name),
            _ => Err(core::fmt::Error),
        }
    }

    /// 读一个关键字成枚举值。
    pub fn keyword<T: DeserializeOwned>(p: &mut Parser<'_, '_>) -> R<T> {
        let kw = p.ident()?;
        Content::Str(kw.into()).to().or_else(|e| p.err(e.0))
    }
}
