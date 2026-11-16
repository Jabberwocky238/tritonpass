//! IR 的类型检查。mlirpass 的 `Body::verify`（`verify_each` 在每个 pass 之后跑的那个）只查分支与 affine：类型对不上的 IR
//! 照样往下走、照样印出来，而 MLIR（参照 dope-opt 也是）在这里就报错了。这里补上 MLIR / Triton 各 op 的 verifier 里与类型
//! 有关的那几条，报错的措辞照 MLIR：
//!
//! - ODS trait（`OpTrait::impl::verify…`）：`SameOperandsAndResultType`、`SameTypeOperands`、`SameOperandsAndResultShape`、
//!   `SameOperandsAndResultElementType`，按 mlirformat 的 op 表（`OpInfo::traits`）认；
//! - 区域的终结符与 op 的类型：scf.for / scf.while / scf.if / scf.index_switch / scf.execute_region，func.func / tt.func 的入口块
//!   参数与 return，func.call / tt.call 与被调函数的签名；
//! - 个别 op 的 `TypesMatchWith` / `AllTypesMatch`：tt.addptr、tt.load、tt.store、arith.select、arith.cmpi / cmpf。
//!
//! [`verify`] 查一棵 op 树；`triton-verify` pass 在流水线里调它；[`run_chunk_verified`] 是读入之后、跑完之后各查一遍的
//! `Invocation::run_chunk`（opt 示例与夹具测试用它）。
use core::fmt::{Display, Write};

use mlirformat::{Attribute, Dim, Error, FunctionType, Trait, Type};
use mlirpass::{Body, Ctx, Invocation, OpId, ValueId, pass};

use crate::{Ir, Kind, pointee};

/// 查 `root` 及其中所有的 op（先序），第一处不对的地方报错。
pub fn verify(body: &Body<'_>, root: OpId) -> Result<(), Error> {
    let mut out = Ok(());
    body.walk(root, &mut |op| {
        if out.is_ok() {
            out = Checker { b: body }.op(op);
        }
    });
    out
}

/// `Invocation::run_chunk` 加上类型检查：读入之后查一遍输入，跑完流水线查一遍结果（`--verify-each=false` 时都不查，同 MLIR）。
pub fn run_chunk_verified(inv: &Invocation, ctx: Ctx<'_>, chunk: &str) -> Result<String, Error> {
    let mut body = inv.read(ctx, chunk)?;
    let root = body.root;
    let check = inv.pipeline.verify_each;
    if check {
        verify(&body, root)?;
    }
    if let Err(e) = inv.pipeline.run_on(&mut body, root, &inv.executor()) {
        // pass 的诊断在前，同 `Invocation::run_chunk`
        let mut text = String::new();
        for d in body.take_diagnostics() {
            let _ = writeln!(text, "{d}");
        }
        text.push_str(&e.0);
        return Err(Error::from(text));
    }
    if check {
        verify(&body, root)?;
    }
    Ok(inv.print(&mut body))
}

/// 流水线里的类型检查：`builtin.module(…, triton-verify)`。
#[pass("triton-verify", on = "builtin.module", ty = Verify)]
pub fn triton_verify<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    verify(body, op)
}

struct Checker<'b, 'a> {
    b: &'b Body<'a>,
}

impl<'a> Checker<'_, 'a> {
    fn op(&self, op: OpId) -> Result<(), Error> {
        self.traits(op)?;
        match self.b.kind(op) {
            Some(Kind::ScfFor) => self.scf_for(op),
            Some(Kind::ScfWhile) => self.scf_while(op),
            Some(Kind::ScfIf | Kind::ScfIndexSwitch | Kind::ScfExecuteRegion) => self.yields_match_results(op),
            Some(Kind::FuncFunc | Kind::TtFunc) => self.function(op),
            Some(Kind::FuncCall | Kind::TtCall) => self.call(op),
            Some(Kind::TtAddptr) => match (self.result(op, 0), self.operand(op, 0)) {
                (Some(r), Some(p)) => self.expect_same(op, r, p, "result type matches ptr type"),
                _ => self.err(op, "expected a pointer operand and a result"),
            },
            Some(Kind::TtLoad) => match (self.result(op, 0), self.operand(op, 0)) {
                (Some(r), Some(p)) => self.expect_same(op, r, &pointee(p), "result matches ptr type"),
                _ => self.err(op, "expected a pointer operand and a result"),
            },
            Some(Kind::TtStore) => match (self.operand(op, 1), self.operand(op, 0)) {
                (Some(v), Some(p)) => self.expect_same(op, v, &pointee(p), "value type matches ptr type"),
                _ => self.err(op, "expected a pointer and a value"),
            },
            Some(Kind::ArithSelect) => self.select(op),
            Some(Kind::ArithCmpi | Kind::ArithCmpf) => match (self.result(op, 0), self.operand(op, 0)) {
                (Some(r), Some(l)) => self.expect_same(op, r, &l.i1_like(), "result type has i1 element type and same shape as operands"),
                _ => self.err(op, "expected operands and a result"),
            },
            _ => Ok(()),
        }
    }

    fn ty(&self, v: ValueId) -> &Type<'a> {
        &self.b[v].ty
    }

    /// 第 `i` 个操作数的类型（畸形的 IR 少了操作数时是 `None`，检查本身不 panic）。
    fn operand(&self, op: OpId, i: usize) -> Option<&Type<'a>> {
        self.b[op].operands.get(i).map(|v| self.ty(*v))
    }

    fn result(&self, op: OpId, i: usize) -> Option<&Type<'a>> {
        self.b[op].results.get(i).map(|v| self.ty(*v))
    }

    fn types(&self, vs: &[ValueId]) -> Vec<&Type<'a>> {
        vs.iter().map(|v| self.ty(*v)).collect()
    }

    /// `'<op>' op <msg>`，后面带上所在的函数。
    fn err(&self, op: OpId, msg: impl Display) -> Result<(), Error> {
        let mut at = Some(op);
        let mut func = None;
        while let Some(o) = at {
            if matches!(self.b.kind(o), Some(Kind::FuncFunc | Kind::TtFunc)) {
                func = self.b.sym_name(o).map(str::to_owned);
                break;
            }
            at = self.b.parent_op(o);
        }
        let place = func.map(|f| format!(" (in @{f})")).unwrap_or_default();
        Err(Error::from(format!("'{}' op {msg}{place}", self.b[op].name)))
    }

    fn expect_same(&self, op: OpId, got: &Type<'_>, want: &Type<'_>, what: &str) -> Result<(), Error> {
        if same(got, want) { Ok(()) } else { self.err(op, format!("failed to verify that {what}: '{got}' vs '{want}'")) }
    }

    /// ODS 的四条类型 trait（`OpTrait::impl::verifySameOperandsAndResultType` 等）。缺操作数或结果的不查（MLIR 另有
    /// `verifyAtLeastNOperands` 报错，这里不管数目）。
    fn traits(&self, op: OpId) -> Result<(), Error> {
        let Some(info) = self.b.ctx.opt.op_info(&self.b[op].name) else { return Ok(()) };
        let operands = self.types(&self.b[op].operands);
        let results = self.types(&self.b[op].results);
        if info.has(Trait::SameOperandsAndResultType)
            && let Some(first) = results.first()
            && !operands.is_empty()
        {
            let elem = first.element_type();
            if results.iter().chain(&operands).any(|t| !same(t.element_type(), elem) || !compatible_shape(t, first)) {
                return self.err(op, "requires the same type for all operands and results");
            }
        }
        if info.has(Trait::SameTypeOperands)
            && let Some(first) = operands.first()
            && operands.iter().any(|t| !same(t, first))
        {
            return self.err(op, "requires all operands to have the same type");
        }
        if info.has(Trait::SameOperandsAndResultShape)
            && let Some(first) = operands.first()
            && results.iter().chain(&operands).any(|t| !compatible_shape(t, first))
        {
            return self.err(op, "requires the same shape for all operands and results");
        }
        if info.has(Trait::SameOperandsAndResultElementType)
            && let Some(first) = results.first()
        {
            let elem = first.element_type();
            if results.iter().chain(&operands).any(|t| !same(t.element_type(), elem)) {
                return self.err(op, "requires the same element type for all operands and results");
            }
        }
        Ok(())
    }

    /// 区域 `r` 入口块的参数。
    fn entry_args(&self, op: OpId, r: usize) -> Option<&[ValueId]> {
        let region = *self.b[op].regions.get(r)?;
        let block = *self.b[region].blocks.first()?;
        Some(&self.b[block].args)
    }

    /// 区域 `r` 入口块的终结符，若它是 `k`。
    fn terminator(&self, op: OpId, r: usize, k: Kind) -> Option<OpId> {
        let region = *self.b[op].regions.get(r)?;
        let block = *self.b[region].blocks.first()?;
        self.b.last_op(block).filter(|t| self.b.is(*t, k))
    }

    /// 两串类型个数相同、逐个同型；不对时报 `what`（个数不同，或第几个的两个类型）。
    fn same_list(&self, op: OpId, a: &[&Type<'_>], b: &[&Type<'_>], what: &str) -> Result<(), Error> {
        if a.len() != b.len() {
            return self.err(op, format!("{what}: {} vs {} values", a.len(), b.len()));
        }
        match a.iter().zip(b).position(|(x, y)| !same(x, y)) {
            Some(i) => self.err(op, format!("{what} #{i}: '{}' != '{}'", a[i], b[i])),
            None => Ok(()),
        }
    }

    /// `ForOp::verify` / `verifyRegions`：上下界、步长与归纳变量同型；初值、迭代参数、yield、结果逐个同型。
    fn scf_for(&self, op: OpId) -> Result<(), Error> {
        let operands = &self.b[op].operands;
        if operands.len() < 3 {
            return self.err(op, "expected lower bound, upper bound and step");
        }
        let (lb, ub, step) = (self.ty(operands[0]), self.ty(operands[1]), self.ty(operands[2]));
        if !same(lb, ub) || !same(lb, step) {
            return self.err(op, "failed to verify that all of {lowerBound, upperBound, step} have same type");
        }
        let Some(args) = self.entry_args(op, 0) else { return Ok(()) };
        if let Some(iv) = args.first()
            && !same(self.ty(*iv), lb)
        {
            return self.err(op, "expected induction variable to be same type as bounds and step");
        }
        let inits = self.types(&operands[3..]);
        let iters = self.types(args.get(1..).unwrap_or_default());
        let results = self.types(&self.b[op].results);
        self.same_list(op, &inits, &iters, "type mismatch between iter operand and region iter_arg")?;
        self.same_list(op, &inits, &results, "type mismatch between iter operand and result")?;
        if let Some(y) = self.terminator(op, 0, Kind::ScfYield) {
            let yields = self.types(&self.b[y].operands);
            self.same_list(op, &iters, &yields, "region iter_arg and yielded value have different type")?;
        }
        Ok(())
    }

    /// `WhileOp::verify`：初值与 before 的参数、condition 带出的值与 after 的参数及结果、after 的 yield 与 before 的参数逐个同型。
    fn scf_while(&self, op: OpId) -> Result<(), Error> {
        let inits = self.types(&self.b[op].operands);
        let results = self.types(&self.b[op].results);
        if let Some(before) = self.entry_args(op, 0) {
            let before = self.types(before);
            self.same_list(op, &inits, &before, "type mismatch between init operand and 'before' region argument")?;
            if let Some(y) = self.terminator(op, 1, Kind::ScfYield) {
                let yields = self.types(&self.b[y].operands);
                self.same_list(op, &yields, &before, "type mismatch between value yielded by 'after' and 'before' region argument")?;
            }
        }
        if let Some(c) = self.terminator(op, 0, Kind::ScfCondition) {
            let forwarded = self.types(self.b[c].operands.get(1..).unwrap_or_default());
            self.same_list(op, &forwarded, &results, "type mismatch between value forwarded by scf.condition and result")?;
            if let Some(after) = self.entry_args(op, 1) {
                let after = self.types(after);
                self.same_list(op, &forwarded, &after, "type mismatch between value forwarded by scf.condition and 'after' region argument")?;
            }
        }
        Ok(())
    }

    /// scf.if / scf.index_switch / scf.execute_region：每个非空区域的 scf.yield 与结果逐个同型。
    fn yields_match_results(&self, op: OpId) -> Result<(), Error> {
        let results = self.types(&self.b[op].results);
        for r in 0..self.b[op].regions.len() {
            if let Some(y) = self.terminator(op, r, Kind::ScfYield) {
                let yields = self.types(&self.b[y].operands);
                self.same_list(op, &yields, &results, &format!("type mismatch between value yielded by region #{r} and result"))?;
            }
        }
        Ok(())
    }

    fn function_type(&self, op: OpId) -> Option<&FunctionType<'a>> {
        match self.b[op].get("function_type") {
            Some(Attribute::Type(Type::Function(ft))) => Some(ft),
            _ => None,
        }
    }

    /// `FunctionOpInterface` 的入口块参数与签名、`func.return` / `tt.return` 与签名的结果（`ReturnOp::verify`）。
    fn function(&self, op: OpId) -> Result<(), Error> {
        let Some(ft) = self.function_type(op) else { return Ok(()) };
        let inputs: Vec<&Type<'_>> = ft.inputs.iter().collect();
        let results: Vec<&Type<'_>> = ft.results.iter().collect();
        if let Some(args) = self.entry_args(op, 0) {
            self.same_list(op, &self.types(args), &inputs, "type of entry block argument must match the type of the corresponding argument in function signature")?;
        }
        for region in &self.b[op].regions {
            for block in &self.b[*region].blocks {
                if let Some(ret) = self.b.last_op(*block).filter(|t| matches!(self.b.kind(*t), Some(Kind::FuncReturn | Kind::TtReturn))) {
                    let got = self.types(&self.b[ret].operands);
                    self.same_list(op, &got, &results, "type of return operand doesn't match function result type")?;
                }
            }
        }
        Ok(())
    }

    /// `CallOp::verifySymbolUses`：实参、结果与被调函数的签名逐个同型。被调函数找不到时不查（外部声明、正在改写的符号）。
    fn call(&self, op: OpId) -> Result<(), Error> {
        let Some(Attribute::SymbolRef(path)) = self.b[op].get("callee") else { return Ok(()) };
        let mut table = self.b.parent_op(op);
        while let Some(t) = table.filter(|t| !self.b.is_symbol_table(*t)) {
            table = self.b.parent_op(t);
        }
        let Some(mut at) = table else { return Ok(()) };
        for seg in path {
            let name = seg.strip_prefix('"').and_then(|s| s.strip_suffix('"')).unwrap_or(seg);
            let Some(next) = self.b.find_symbol(at, name) else { return Ok(()) };
            at = next;
        }
        let Some(ft) = self.function_type(at) else { return Ok(()) };
        let inputs: Vec<&Type<'_>> = ft.inputs.iter().collect();
        let results: Vec<&Type<'_>> = ft.results.iter().collect();
        self.same_list(op, &self.types(&self.b[op].operands), &inputs, "operand type mismatch with callee")?;
        self.same_list(op, &self.types(&self.b[op].results), &results, "result type mismatch with callee")
    }

    /// arith.select：两个取值与结果同型（`AllTypesMatch`），条件是 i1 或与结果同形的 i1 张量。
    fn select(&self, op: OpId) -> Result<(), Error> {
        let (Some(c), Some(t), Some(f), Some(r)) = (self.operand(op, 0), self.operand(op, 1), self.operand(op, 2), self.result(op, 0)) else {
            return self.err(op, "expected a condition, two values and a result");
        };
        if !same(t, f) || !same(t, r) {
            return self.err(op, "failed to verify that all of {true_value, false_value, result} have same type");
        }
        let i1 = Type::Integer { signedness: mlirformat::Signedness::Signless, width: 1 };
        if !same(c, &i1) && !same(c, &r.i1_like()) {
            return self.err(op, format!("expected condition to be a signless i1, or an i1 with the shape of the result, but got '{c}'"));
        }
        Ok(())
    }
}

/// 类型相同。mlirformat 按原文存方言类型：`!tt.ptr<T, 1>` 与 `!tt.ptr<T>` 是同一个类型（地址空间 1 是缺省，Triton 印时省掉），
/// 原文不同时按印法去掉这个缺省再比。
fn same(a: &Type<'_>, b: &Type<'_>) -> bool {
    a == b || {
        let (x, y) = (a.to_string(), b.to_string());
        x.contains("!tt.ptr<") && default_address_space(&x) == default_address_space(&y)
    }
}

/// 印法里每个 `!tt.ptr<…, 1>` 的 `, 1` 去掉（只动 `!tt.ptr` 自己那一层）。
fn default_address_space(text: &str) -> String {
    const OPEN: &str = "!tt.ptr<";
    let mut out = String::with_capacity(text.len());
    let mut rest = text;
    while let Some(at) = rest.find(OPEN) {
        out.push_str(&rest[..at + OPEN.len()]);
        rest = &rest[at + OPEN.len()..];
        // 找这一层的 `>`，记下最后一个顶层逗号
        let (mut depth, mut comma, mut end) = (0i32, None, None);
        for (i, ch) in rest.char_indices() {
            match ch {
                '<' | '(' | '[' | '{' => depth += 1,
                '>' if depth == 0 => {
                    end = Some(i);
                    break;
                }
                '>' | ')' | ']' | '}' => depth -= 1,
                ',' if depth == 0 => comma = Some(i),
                _ => {}
            }
        }
        let Some(end) = end else { break };
        match comma.filter(|c| rest[*c + 1..end].trim() == "1") {
            Some(c) => out.push_str(&rest[..c]),
            None => out.push_str(&rest[..end]),
        }
        rest = &rest[end..];
    }
    out.push_str(rest);
    out
}

/// `verifyCompatibleShape(Type, Type)`：都不是 shaped 时相容，只有一边是时不相容；有一边无秩时相容；否则秩相同、每一维相等或有一边动态。
fn compatible_shape(a: &Type<'_>, b: &Type<'_>) -> bool {
    match (a, b) {
        (Type::Shaped(sa), Type::Shaped(sb)) => match (&sa.shape, &sb.shape) {
            (Some(da), Some(db)) => {
                da.len() == db.len()
                    && da.iter().zip(db).all(|(x, y)| {
                        let (x, y) = (i64::from(x), i64::from(y));
                        x == y || x == Dim::DYNAMIC || y == Dim::DYNAMIC
                    })
            }
            _ => true,
        },
        (Type::Shaped(_), _) | (_, Type::Shaped(_)) => false,
        _ => true,
    }
}
