//! `ttg` 的最小登记：只有 `ttg.barrier`（`tl.debug_barrier()` 的产物），只认这一个 op。
//! TritonGPU 的别的 op 照旧读不进（原文留着，入 Body 时报错，fail-closed）：它们只在 TTGIR 之后才出现。
use core::fmt::{self, Write};

use mlirformat::{Attribute, NamedAttr, Op, Parse, Parser, Print, Printer, R, mlir};

/// `ttg.barrier <地址空间>[|<地址空间>…]`：没有操作数、没有结果；关键字原样存进 `addr_space`（字符串，attr-dict 里）。
#[mlir::op("ttg.barrier", custom)]
pub struct BarrierOp {}

impl Print for BarrierOp {
    fn print(&self, p: &mut Printer<'_, '_>) -> fmt::Result {
        p.op_name(Self::NAME)?;
        let spaces = self.attrs.iter().find(|a| a.name == "addr_space").and_then(|a| a.value.as_ref()).and_then(|v| v.text().ok());
        write!(p, " {}", spaces.as_deref().unwrap_or("all"))?;
        let rest: Vec<NamedAttr<'_>> = self.attrs.iter().filter(|a| a.name != "addr_space").cloned().collect();
        p.attr_dict("", &rest, &[])?;
        p.loc(&self.loc)
    }
}

impl Parse for BarrierOp {
    fn parse(p: &mut Parser<'_, '_>) -> R<Self> {
        let mut spaces = String::from(p.ident()?);
        while p.eat("|") {
            spaces.push('|');
            spaces.push_str(p.ident()?);
        }
        let mut attrs = vec![NamedAttr::of("addr_space", Attribute::str(&spaces))];
        attrs.extend(p.opt_dict()?.into_iter().map(|a| NamedAttr { name: a.name.into_owned().into(), value: a.value.map(|v| v.owned()) }));
        Ok(BarrierOp { attrs, loc: p.opt_loc()?.map(|l| l.into_owned().into()) })
    }
}

/// 只有 `barrier` 一个 op 的 `ttg` 方言。
#[mlir::dialect("ttg", ops = [BarrierOp])]
pub struct TtgDialect;
