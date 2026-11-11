//! 各 pass 共用的 IR 小工具：按 [`Kind`] 认 op、取属性、建常量。`Body` 是 mlirpass 的类型，这里以扩展 trait 的方法给出。
use mlirformat::{ApFloat, ApInt, Attribute, Const, FloatKind, Scalar, Type};
use mlirpass::{BlockId, Body, Def, OpData, OpId, RegionId, ValueId};

use crate::Kind;

/// 一组相同元素的整数类型。
pub fn int(width: u32) -> Type<'static> {
    Type::Integer { signedness: mlirformat::Signedness::Signless, width }
}

/// `Body` 上按 [`Kind`] 与常用属性读 IR 的方法。
pub trait Ir<'a> {
    /// 认 op 名：认不出（不在 [`Kind`] 表里）是 `None`。
    fn kind(&self, op: OpId) -> Option<Kind>;
    /// op 是不是 `k`。
    fn is(&self, op: OpId, k: Kind) -> bool {
        self.kind(op) == Some(k)
    }
    /// 定义 `v` 的 op 的种类（块参数是 `None`）。
    fn def_kind(&self, v: ValueId) -> Option<Kind>;
    /// 定义 `v` 的 op，若它是 `k`。
    fn def_of(&self, v: ValueId, k: Kind) -> Option<OpId>;
    /// 值的类型。
    fn ty(&self, v: ValueId) -> &Type<'a>;
    /// 第 `i` 个结果。
    fn res(&self, op: OpId, i: usize) -> ValueId;
    /// 第 `i` 个操作数。
    fn opd(&self, op: OpId, i: usize) -> ValueId;
    /// 整数属性（`axis = 0 : i32`、`predicate = 2 : i64`）。
    fn int_attr(&self, op: OpId, name: &str) -> Option<i128>;
    /// 第 `r` 个区域的入口块。
    fn entry(&self, op: OpId, r: usize) -> BlockId;
    /// 块里的 op（拷一份 id 表，改 IR 时不借着 body）。
    fn block_ops(&self, b: BlockId) -> Vec<OpId>;
    /// 块的终结符。
    fn terminator(&self, b: BlockId) -> Option<OpId>;
    /// 区域里的块。
    fn blocks(&self, r: RegionId) -> Vec<BlockId>;
    /// 值是不是块参数。
    fn is_arg(&self, v: ValueId) -> bool;
    /// `arith.constant` 的值。
    fn constant(&self, v: ValueId) -> Option<Const<'a>>;
    /// 整数常量（标量或 splat）。
    fn const_int(&self, v: ValueId) -> Option<i128>;
    /// 用户（每次使用一条，可能重复）。
    fn users(&self, v: ValueId) -> Vec<OpId>;
}

impl<'a> Ir<'a> for Body<'a> {
    fn kind(&self, op: OpId) -> Option<Kind> {
        Kind::try_from(&*self[op].name).ok()
    }

    fn def_kind(&self, v: ValueId) -> Option<Kind> {
        self.def_op(v).and_then(|o| self.kind(o))
    }

    fn def_of(&self, v: ValueId, k: Kind) -> Option<OpId> {
        self.def_op(v).filter(|o| self.is(*o, k))
    }

    fn ty(&self, v: ValueId) -> &Type<'a> {
        &self[v].ty
    }

    fn res(&self, op: OpId, i: usize) -> ValueId {
        self[op].results[i]
    }

    fn opd(&self, op: OpId, i: usize) -> ValueId {
        self[op].operands[i]
    }

    fn int_attr(&self, op: OpId, name: &str) -> Option<i128> {
        self[op].get(name)?.int().ok()
    }

    fn entry(&self, op: OpId, r: usize) -> BlockId {
        self[self[op].regions[r]].blocks[0]
    }

    fn block_ops(&self, b: BlockId) -> Vec<OpId> {
        self.ops(b).collect()
    }

    fn terminator(&self, b: BlockId) -> Option<OpId> {
        self.last_op(b)
    }

    fn blocks(&self, r: RegionId) -> Vec<BlockId> {
        self[r].blocks.to_vec()
    }

    fn is_arg(&self, v: ValueId) -> bool {
        matches!(self[v].def, Def::Arg(..))
    }

    fn constant(&self, v: ValueId) -> Option<Const<'a>> {
        let op = self.def_of(v, Kind::ArithConstant)?;
        Const::try_from(self[op].get("value")?).ok()
    }

    fn const_int(&self, v: ValueId) -> Option<i128> {
        let c = self.constant(v)?;
        let first = c.values.first()?;
        if c.values.iter().any(|x| x != first) {
            return None;
        }
        match first {
            Scalar::Int(i) => Some(i.signed()),
            _ => None,
        }
    }

    fn users(&self, v: ValueId) -> Vec<OpId> {
        self[v].uses.iter().map(|u| u.op).collect()
    }
}

/// 建 op 用的小工具：常量。
pub trait Build<'a> {
    /// `arith.constant` 的 OpData：整数或浮点标量，或（`ty` 是张量时）splat。
    fn constant_data(value: Scalar, ty: &Type<'a>) -> OpData<'a>;
    /// ⭐ 在 `at` 用一个 mlirpass [`mlirpass::Rewriter`] 建 op（没写位置的新 op 取 `loc`）：`OpBuilder` 定好插入点再交给 `f`。
    fn build<R>(&mut self, at: At, loc: Option<mlirformat::Str<'a>>, f: impl FnOnce(&mut mlirpass::Rewriter<'_, 'a>) -> R) -> R;
}

impl<'a> Build<'a> for Body<'a> {
    fn build<R>(&mut self, at: At, loc: Option<mlirformat::Str<'a>>, f: impl FnOnce(&mut mlirpass::Rewriter<'_, 'a>) -> R) -> R {
        let mut q = mlirpass::Quiet;
        let mut rw = mlirpass::Rewriter::new(self, &mut q);
        match at {
            At::Before(o) => rw.set_before(o),
            At::After(o) => rw.set_after(o),
            At::Start(b) => rw.set_start(b),
            At::End(b) => rw.set_end(b),
        }
        rw.loc = loc;
        f(&mut rw)
    }

    fn constant_data(value: Scalar, ty: &Type<'a>) -> OpData<'a> {
        let attr: Attribute<'a> = match ty {
            Type::Shaped(_) => Const::splat(value, ty.clone()).into(),
            _ => Const::scalar(value, ty.clone()).into(),
        };
        OpData::build(Kind::ArithConstant.name()).with("value", attr)
    }
}

/// 浮点标量。
pub fn float(kind: FloatKind, x: f64) -> Scalar {
    Scalar::Float(ApFloat::from_f64(kind, x).unwrap_or_else(|| ApFloat::nan(kind)))
}

/// 整数标量。
pub fn integer(width: u32, v: i128) -> Scalar {
    Scalar::Int(ApInt::new(width, v))
}

/// 浮点元素类型的种类。
pub fn float_kind(ty: &Type<'_>) -> Option<FloatKind> {
    match ty.element_type() {
        Type::Float(k) => Some(*k),
        _ => None,
    }
}

/// 插入点：某条 op 之前，某块的开头 / 末尾，或某条 op 之后（`setInsertionPointAfter`：每次都紧挨在它后面）。
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum At {
    Before(OpId),
    Start(BlockId),
    End(BlockId),
    After(OpId),
}

/// ⭐ 在 mlirpass 的 [`Rewriter`] 上建 tt / tts / arith / scf op 的小工具（`OpBuilder` 的那几个便捷构造）：插入点、位置、
/// 监听都是 rewriter 的（新 op 没写位置的取 `rw.loc`，即被改写的 op 的位置）。`#[rewrite]` 模式里直接对 `rw` 调。
pub trait TtBuilder<'a> {
    /// 插入点设在 `op` 之前，新 op 的位置取 `op` 的（`OpBuilder(op)`）。
    fn before_op(&mut self, op: OpId);
    /// 建一条单结果的 op，返回结果。
    fn value(&mut self, k: Kind, operands: &[ValueId], ty: Type<'a>) -> ValueId;
    /// 带属性的单结果 op。
    fn value_with(&mut self, k: Kind, operands: &[ValueId], attrs: &[(&str, Attribute<'a>)], ty: Type<'a>) -> ValueId;
    /// `arith.constant`（标量，或 `ty` 是张量时 splat）。
    fn scalar(&mut self, value: Scalar, ty: Type<'a>) -> ValueId;
    /// `arith.constant N : i32`。
    fn i32(&mut self, n: i64) -> ValueId;
    /// `arith.cmpi <pred>`。
    fn cmpi(&mut self, pred: mlirformat::arith::CmpIPredicate, l: ValueId, r: ValueId) -> ValueId;
    /// 二元 op，结果类型同左操作数。
    fn binary(&mut self, k: Kind, l: ValueId, r: ValueId) -> ValueId;
    /// `arith.select`。
    fn select(&mut self, c: ValueId, t: ValueId, f: ValueId) -> ValueId;
    /// `scf.for %lb to %ub step %s iter_args(inits)`（`scf::ForOp::build`）：区域与入口块建好，归纳变量取 `lb` 的类型、
    /// 循环的位置，携带值取各初值的位置；块里是空的。
    fn for_loop(&mut self, lb: ValueId, ub: ValueId, step: ValueId, inits: &[ValueId]) -> (OpId, BlockId);
    /// `tts.make_tptr %base to sizes: … , strides: …, offsets: …, shape: …, order: …`。
    #[expect(clippy::too_many_arguments, reason = "tts.make_tptr 的各段")]
    fn make_tptr(&mut self, base: ValueId, sizes: &[i64], strides: &[Ofr], offsets: &[Ofr], shape: &[Ofr], order: &[i64], ty: Type<'a>) -> ValueId;
}

impl<'a, L: mlirpass::Listener<'a> + ?Sized> TtBuilder<'a> for mlirpass::Rewriter<'_, 'a, L> {
    fn before_op(&mut self, op: OpId) {
        self.set_before(op);
        self.loc = self.body[op].loc.clone();
    }

    fn value(&mut self, k: Kind, operands: &[ValueId], ty: Type<'a>) -> ValueId {
        let o = self.create(OpData::build(k.name()).operands(operands), &[ty]);
        self.body.res(o, 0)
    }

    fn value_with(&mut self, k: Kind, operands: &[ValueId], attrs: &[(&str, Attribute<'a>)], ty: Type<'a>) -> ValueId {
        let mut d = OpData::build(k.name()).operands(operands);
        for (n, a) in attrs {
            d.set(n, a.clone());
        }
        let o = self.create(d, &[ty]);
        self.body.res(o, 0)
    }

    fn scalar(&mut self, value: Scalar, ty: Type<'a>) -> ValueId {
        let o = self.create(Body::constant_data(value, &ty), &[ty]);
        self.body.res(o, 0)
    }

    fn i32(&mut self, n: i64) -> ValueId {
        self.scalar(integer(32, i128::from(n)), int(32))
    }

    fn cmpi(&mut self, pred: mlirformat::arith::CmpIPredicate, l: ValueId, r: ValueId) -> ValueId {
        let ty = self.body.ty(l).i1_like();
        self.value_with(Kind::ArithCmpi, &[l, r], &[("predicate", Attribute::of_int(pred as i128, int(64)))], ty)
    }

    fn binary(&mut self, k: Kind, l: ValueId, r: ValueId) -> ValueId {
        let ty = self.body.ty(l).clone();
        self.value(k, &[l, r], ty)
    }

    fn select(&mut self, c: ValueId, t: ValueId, f: ValueId) -> ValueId {
        let ty = self.body.ty(t).clone();
        self.value(Kind::ArithSelect, &[c, t, f], ty)
    }

    fn for_loop(&mut self, lb: ValueId, ub: ValueId, step: ValueId, inits: &[ValueId]) -> (OpId, BlockId) {
        let mut operands = vec![lb, ub, step];
        operands.extend_from_slice(inits);
        let tys = self.body.types(inits);
        let iv: Vec<(Type<'a>, Option<mlirformat::Str<'a>>)> = vec![(self.body.ty(lb).clone(), self.loc.clone())];
        let carried = inits.iter().zip(&tys).map(|(v, t)| (t.clone(), self.body.value_loc(*v)));
        let args: Vec<_> = iv.into_iter().chain(carried).collect();
        let f = self.create_with(OpData::build(Kind::ScfFor.name()).operands(&operands), &tys, |b, o| {
            let r = b.add_region(o);
            b.add_block(r, &args);
        });
        let block = self.body.top_block(f);
        (f, block)
    }

    fn make_tptr(&mut self, base: ValueId, sizes: &[i64], strides: &[Ofr], offsets: &[Ofr], shape: &[Ofr], order: &[i64], ty: Type<'a>) -> ValueId {
        let mut operands = vec![base];
        let dyn_of = |xs: &[Ofr]| xs.iter().filter_map(|x| x.value()).collect::<Vec<_>>();
        let (s, o, sh) = (dyn_of(strides), dyn_of(offsets), dyn_of(shape));
        operands.extend(&s);
        operands.extend(&o);
        operands.extend(&sh);
        let statics = |xs: &[Ofr]| xs.iter().map(|x| x.static_value()).collect::<Vec<_>>();
        let d = OpData::build(Kind::TtsMakeTptr.name())
            .operands(&operands)
            .with("operandSegmentSizes", dense_i32(&[1, s.len() as i64, o.len() as i64, sh.len() as i64]))
            .with("order", dense_i32(order))
            .with("sizes", dense_i64(sizes))
            .with("static_offsets", dense_i64(&statics(offsets)))
            .with("static_shape", dense_i64(&statics(shape)))
            .with("static_strides", dense_i64(&statics(strides)));
        let op = self.create(d, &[ty]);
        self.body.res(op, 0)
    }
}

/// MLIR 印 i64 的 IntegerAttr 不带类型（`25` 而不是 `25 : i64`）：`I64ArrayAttr` 的元素就是这样。
pub fn i64_attr(v: i64) -> Attribute<'static> {
    Attribute::Int { lit: v.to_string().into(), ty: None }
}

/// `ShapedType::kDynamic`：静态数组里表示「这一项是动态的」。
pub const DYNAMIC: i64 = i64::MIN;

/// `OpFoldResult`：常量或 SSA 值。
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Ofr {
    C(i64),
    V(ValueId),
}

impl Ofr {
    /// 静态数组里的那一项（动态的写 [`DYNAMIC`]）。
    pub fn static_value(self) -> i64 {
        match self {
            Ofr::C(c) => c,
            Ofr::V(_) => DYNAMIC,
        }
    }

    /// 动态操作数（常量没有）。
    pub fn value(self) -> Option<ValueId> {
        match self {
            Ofr::V(v) => Some(v),
            Ofr::C(_) => None,
        }
    }
}

/// `array<i64: …>`
pub fn dense_i64(values: &[i64]) -> Attribute<'static> {
    Attribute::DenseArray { ty: int(64), values: values.iter().map(|v| v.to_string().into()).collect() }
}

/// `array<i32: …>`
pub fn dense_i32(values: &[i64]) -> Attribute<'static> {
    Attribute::DenseArray { ty: int(32), values: values.iter().map(|v| v.to_string().into()).collect() }
}

/// 读 `array<i64: …>` / `array<i32: …>`。
pub fn dense_values(a: Option<&Attribute<'_>>) -> Vec<i64> {
    match a {
        Some(Attribute::DenseArray { values, .. }) => values.iter().filter_map(|v| v.parse().ok()).collect(),
        _ => Vec::new(),
    }
}

