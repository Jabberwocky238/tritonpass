//! 上游方言里 mlirformat 还没有自定义形式、而 TTIR 里会出现的 op：手写后注入，写法照 MLIR 的 C++ 打印器。
use core::fmt::{self, Write};

use mlirformat::{Attribute, Block, BlockArg, FunctionType, Op, Parse, Parser, Print, Printer, R, Region, Type, Value, mlir};

/// `scf.while (%a = %init, …) : (T…) -> (R…) { before } do { ^bb0(%x: R, …): after }`（`WhileOp::print` / `parse`）：
/// before 的入口块参数写在头部，after 的入口块照常带标签与参数。
#[mlir::op("scf.while", custom, results(results))]
pub struct WhileOp<'a> {
    #[slot(inits_ty)]
    pub inits: Vec<Value<'a>>,
    pub before: Region<'a>,
    pub after: Region<'a>,
    pub inits_ty: Vec<Type<'a>>,
    pub results: Vec<Type<'a>>,
}

impl Print for WhileOp<'_> {
    fn print(&self, p: &mut Printer<'_, '_>) -> fmt::Result {
        let Some(entry) = self.before.blocks.first().filter(|b| b.args.len() == self.inits.len()) else { return self.print_generic(p) };
        p.op_name(Self::NAME)?;
        p.write_str(" (")?;
        for (i, (a, v)) in entry.args.iter().zip(&self.inits).enumerate() {
            write!(p, "{}%{} = {v}", if i > 0 { ", " } else { "" }, a.name)?;
        }
        p.write_str(") : ")?;
        p.write_char('(')?;
        for (i, t) in self.inits_ty.iter().enumerate() {
            write!(p, "{}{t}", if i > 0 { ", " } else { "" })?;
        }
        p.write_str(") -> ")?;
        match self.results.as_slice() {
            [t] if !matches!(t, Type::Function(_)) => write!(p, "{t}")?,
            ts => {
                p.write_char('(')?;
                for (i, t) in ts.iter().enumerate() {
                    write!(p, "{}{t}", if i > 0 { ", " } else { "" })?;
                }
                p.write_char(')')?;
            }
        }
        p.write_char(' ')?;
        p.region(&self.before, false)?;
        p.write_str(" do ")?;
        p.region(&self.after, true)?;
        p.attr_dict(" attributes", &self.attrs, &[])?;
        p.loc(&self.loc)
    }
}

impl Parse for WhileOp<'_> {
    fn parse(p: &mut Parser<'_, '_>) -> R<Self> {
        p.expect("(")?;
        let pairs = p.list(")", |p| {
            let name = p.sigil('%')?;
            p.expect("=")?;
            Ok((name, p.value()?))
        })?;
        p.expect(":")?;
        let FunctionType { inputs, results } = p.fn_ty()?;
        if inputs.len() != pairs.len() {
            return p.err("`scf.while`：初值个数与类型个数对不上");
        }
        let mut before = p.region()?;
        if !p.eat_kw("do") {
            return p.err("`scf.while`：要 do");
        }
        let after = p.region()?;
        let attrs = if p.eat_kw("attributes") { p.dict()? } else { Vec::new() };
        let args: Vec<BlockArg<'_>> = pairs.iter().zip(&inputs).map(|((n, _), t)| BlockArg { name: (*n).into(), ty: t.clone(), loc: None }).collect();
        match before.blocks.first_mut() {
            Some(b) => {
                b.label = Some("bb0".into());
                b.args = args;
            }
            None => before.blocks.push(Block { label: Some("bb0".into()), args, ops: Vec::new() }),
        }
        let op = WhileOp { inits: pairs.into_iter().map(|(_, v)| v).collect(), before, after, inits_ty: inputs, results, attrs, loc: p.opt_loc()? };
        Self::owned(op, p)
    }
}

/// `llvm.intr.assume %c : i1`（不带 op bundle 的写法；带 bundle 的走通用形式）。
#[mlir::op("llvm.intr.assume", custom)]
pub struct AssumeOp<'a> {
    #[slot(cond_ty)]
    pub cond: Value<'a>,
    #[slot(op_bundle_operands_ty)]
    pub op_bundle_operands: Vec<Value<'a>>,
    #[attr(dense = "i32")]
    pub op_bundle_sizes: Attribute<'a>,
    pub op_bundle_tags: Option<Attribute<'a>>,
    pub cond_ty: Type<'a>,
    pub op_bundle_operands_ty: Vec<Type<'a>>,
}

impl Print for AssumeOp<'_> {
    fn print(&self, p: &mut Printer<'_, '_>) -> fmt::Result {
        if !self.op_bundle_operands.is_empty() || self.op_bundle_tags.is_some() {
            return self.print_generic(p);
        }
        p.op_name(Self::NAME)?;
        write!(p, " {}", self.cond)?;
        p.attr_dict("", &self.attrs, &[])?;
        write!(p, " : {}", self.cond_ty)?;
        p.loc(&self.loc)
    }
}

impl Parse for AssumeOp<'_> {
    fn parse(p: &mut Parser<'_, '_>) -> R<Self> {
        let cond = p.value()?;
        let attrs = p.opt_dict()?;
        p.expect(":")?;
        let cond_ty = p.ty()?;
        let sizes = Attribute::DenseArray { ty: Type::Integer { signedness: mlirformat::Signedness::Signless, width: 32 }, values: Vec::new().into() };
        let op = AssumeOp { cond, op_bundle_operands: Vec::new(), op_bundle_sizes: sizes, op_bundle_tags: None, cond_ty, op_bundle_operands_ty: Vec::new(), attrs, loc: p.opt_loc()? };
        Self::owned(op, p)
    }
}
