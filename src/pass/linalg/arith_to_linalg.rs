//! `triton-arith-to-linalg`（triton-shared `TritonArithToLinalgPass.cpp` + `ConversionPatterns.hpp`，带下游的改动）：
//! 先跑 cmp + select ⇒ min / max 的贪婪改写；再方言转换：tt 的张量 op 换成 linalg / tensor，张量上的 arith / math 换成
//! `linalg.generic`（上游 `ElementwiseToLinalg`，最后才试），program id 换成 gpu.block_id / gpu.grid_dim；转换后贪婪跑一遍
//! （折叠、常量提到入口），最后 tt.func / tt.return 换成 func.func / func.return。
//!
//! 只移植了语料与合同用得到的模式：cat、split、join、mulhiui、argmin / argmax、assert、call 没有（P0 已拒收）。

use mlirformat::{AffineExpr, AffineMap, Attribute, Error, NamedAttr, Scalar, Type};
use mlirpass::{
    Action, Body, ConversionConfig, ConversionPattern, ConversionPatterns, ConversionRewriter, ConversionTarget, Converter, GreedyConfig, Mode, OpData, OpId, Pattern, PatternSet, Rewriter, Run, Trait, ValueId, pass, patterns,
};

use crate::ir::{dense_i64, dense_values, i64_attr};
use crate::{Build, GridEncoding, Ir, Kind};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

#[pass("triton-arith-to-linalg", on = "builtin.module")]
pub struct TritonArithToLinalg {
    #[opt("grid-encoding")]
    grid: String,
}

/// cmpf / cmpi 谓词。
const CMPF_OGT: i128 = 2;
const CMPF_OGE: i128 = 3;
const CMPF_OLT: i128 = 4;
const CMPF_OLE: i128 = 5;
const CMPI_SLT: i128 = 2;
const CMPI_SGT: i128 = 4;
const CMPI_ULT: i128 = 6;
const CMPI_UGT: i128 = 8;

/// `MinMaxConverter`：cmp 与只用它的 select 换成 min / max（benefit 10）。
struct MinMax(Kind);

impl Pattern for MinMax {
    fn name(&self) -> &str {
        "MinMaxConverter"
    }

    fn root(&self) -> Option<&str> {
        Some(self.0.name())
    }

    fn benefit(&self) -> u16 {
        10
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let c = b.res(op, 0);
        let Some(sel) = b[c].uses.single().map(|u| u.op) else { return false };
        if !b.is(sel, Kind::ArithSelect) || b.opd(sel, 0) != c || b.opd(op, 0) != b.opd(sel, 1) || b.opd(op, 1) != b.opd(sel, 2) {
            return false;
        }
        let p = b.int_attr(op, "predicate").unwrap_or(-1);
        let k = match (self.0, p) {
            (Kind::ArithCmpf, CMPF_OGT | CMPF_OGE) => Kind::ArithMaximumf,
            (Kind::ArithCmpf, CMPF_OLT | CMPF_OLE) => Kind::ArithMinimumf,
            (Kind::ArithCmpi, CMPI_SGT) => Kind::ArithMaxsi,
            (Kind::ArithCmpi, CMPI_UGT) => Kind::ArithMaxui,
            (Kind::ArithCmpi, CMPI_SLT) => Kind::ArithMinsi,
            (Kind::ArithCmpi, CMPI_ULT) => Kind::ArithMinui,
            _ => return false,
        };
        let (l, r) = (b.opd(op, 0), b.opd(op, 1));
        let ty = b.ty(b.res(sel, 0)).clone();
        let mut d = OpData::build(k.name()).operands(&[l, r]);
        d.loc.clone_from(&b[sel].loc);
        rw.set_before(sel);
        let n = rw.create(d, &[ty]);
        let nv = rw.body.res(n, 0);
        rw.replace_op(sel, &[nv]);
        rw.erase_op(op);
        true
    }
}


/// 建 linalg / tensor op 的小工具。
struct L;

impl L {
    fn ty<'a>(cr: &Cr<'_, 'a, '_>, v: ValueId) -> Type<'a> {
        cr.rw.body[v].ty.clone()
    }

    fn rty<'a>(cr: &Cr<'_, 'a, '_>, op: OpId) -> Type<'a> {
        let r = cr.rw.body[op].results[0];
        Self::ty(cr, r)
    }

    fn par(n: usize) -> Vec<bool> {
        vec![true; n]
    }

    /// `linalg.fill`。
    fn fill<'a>(cr: &mut Cr<'_, 'a, '_>, value: ValueId, init: ValueId) -> ValueId {
        let ty = Self::ty(cr, init);
        let o = cr.structured("linalg.fill", &[value], &[init], &[ty.clone()], Vec::new(), &mut |cr, a| {
            let et = ty.element_type().clone();
            vec![cr.cast_scalar(a[0], &et, false)]
        });
        cr.rw.body[o].results[0]
    }

    /// 标量 `arith.constant`。
    fn constant<'a>(cr: &mut Cr<'_, 'a, '_>, value: Scalar, ty: &Type<'a>) -> ValueId {
        let d = <Body<'a> as Build<'a>>::constant_data(value, ty);
        let o = cr.rw.create(d, &[ty.clone()]);
        cr.rw.body[o].results[0]
    }

    fn dims(t: &Type<'_>) -> Vec<i64> {
        t.dims().unwrap_or_default()
    }
}

/// tt 张量 op 的转换模式。
struct Tt;

#[patterns]
impl Tt {
    #[convert("tt.splat")]
    fn splat(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let t = L::rty(cr, op);
        let init = cr.empty(&L::dims(&t), t.element_type().clone(), &[]);
        let f = L::fill(cr, o[0][0], init);
        cr.replace_values(op, &[f]);
        true
    }

    #[convert("tt.unsplat")]
    fn unsplat(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let src = o[0][0];
        let rank = L::dims(&L::ty(cr, src)).len();
        let mut operands = vec![src];
        if rank > 0 {
            let z = cr.rw.create_or_fold(OpData::build(Kind::ArithConstant.name()).with("value", Attribute::index(0)), &[Type::Index])[0];
            operands.extend(std::iter::repeat_n(z, rank));
        }
        let rt = L::rty(cr, op);
        let e = cr.rw.create(OpData::build(Kind::TensorExtract.name()).operands(&operands), &[rt]);
        let ev = cr.rw.body[e].results[0];
        cr.replace_values(op, &[ev]);
        true
    }

    #[convert("tt.broadcast")]
    fn broadcast(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let src = o[0][0];
        let (st, rt) = (L::ty(cr, src), L::rty(cr, op));
        let (sd, rd) = (L::dims(&st), L::dims(&rt));
        let diff = rd.len() - sd.len();
        let results = (diff..rd.len()).map(|i| if sd[i - diff] == 1 { AffineExpr::Const(0) } else { AffineExpr::Dim(i as u32) }).collect();
        let maps = [AffineMap { dims: rd.len() as u32, syms: 0, results }, AffineMap::identity(rd.len() as u32)];
        let init = cr.empty(&rd, rt.element_type().clone(), &[]);
        let g = cr.generic(&[rt.clone()], &[src], &[init], &maps, &L::par(rd.len()), &mut |_, a| vec![a[0]]);
        let bdims: Vec<i64> = (0..sd.len()).filter(|i| rd[*i] != sd[*i]).map(|i| i as i64).collect();
        cr.rw.body[g].set("broadcastDims", dense_i64(&bdims));
        let gv = cr.rw.body[g].results[0];
        cr.replace_values(op, &[gv]);
        true
    }

    #[convert("tt.expand_dims")]
    fn expand_dims(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let src = o[0][0];
        let rank = L::dims(&L::ty(cr, src)).len() as i64;
        let axis = cr.rw.body.int_attr(op, "axis").unwrap_or(0) as i64;
        let mut groups = Vec::new();
        let mut c = 0i64;
        for i in 0..rank {
            let mut g = vec![c];
            c += 1;
            if axis == i || (axis == i + 1 && i == rank - 1) {
                g.push(c);
                c += 1;
            }
            groups.push(g);
        }
        let rt = L::rty(cr, op);
        let e = Self::expand(cr, src, &groups, rt);
        cr.replace_values(op, &[e]);
        true
    }

    #[convert("tt.trans")]
    fn trans(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let src = o[0][0];
        let st = L::ty(cr, src);
        let sd = L::dims(&st);
        let order = dense_values(cr.rw.body[op].get("order"));
        let rank = sd.len();
        let (perm, shape): (Vec<i64>, Vec<i64>) = if order.is_empty() {
            let mut p: Vec<i64> = (0..rank as i64).collect();
            p.swap(rank - 1, rank - 2);
            let mut sh = sd.clone();
            sh.swap(rank - 1, rank - 2);
            (p, sh)
        } else {
            (order.clone(), order.iter().map(|i| sd[*i as usize]).collect())
        };
        let et = st.element_type().clone();
        let init = cr.empty(&shape, et.clone(), &[]);
        let t = cr.structured("linalg.transpose", &[src], &[init], &[Type::tensor(&shape, et)], vec![("permutation", dense_i64(&perm))], &mut |_, a| vec![a[0]]);
        let tv = cr.rw.body[t].results[0];
        cr.replace_values(op, &[tv]);
        true
    }

    #[convert("tt.make_range")]
    fn make_range(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let rt = L::rty(cr, op);
        let et = rt.element_type().clone();
        let start = cr.rw.body.int_attr(op, "start").unwrap_or(0);
        let init = cr.empty(&L::dims(&rt), et.clone(), &[]);
        let k = (start != 0).then(|| L::constant(cr, crate::ir::integer(et.bit_width().unwrap_or(32), start), &et));
        let g = cr.generic(&[rt.clone()], &[], &[init], &[AffineMap::identity(1)], &[true], &mut |cr, _| {
            let i = cr.op1(Kind::LinalgIndex.name(), &[], Type::Index);
            let last = cr.rw.body.def_op(i).expect("linalg.index");
            cr.rw.body[last].set("dim", Attribute::integer(0, Type::int(64)));
            let mut r = cr.op1(Kind::ArithIndexCast.name(), &[i], et.clone());
            if let Some(k) = k {
                r = cr.op1(Kind::ArithAddi.name(), &[r, k], et.clone());
            }
            vec![r]
        });
        let gv = cr.rw.body[g].results[0];
        cr.replace_values(op, &[gv]);
        true
    }

    #[convert("tt.bitcast")]
    fn bitcast(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let rt = L::rty(cr, op);
        if matches!(rt.element_type(), Type::Extended(e) if e.name == "tt.ptr") {
            return false;
        }
        let src = cr.rw.body[op].operands[0];
        let v = cr.op1(Kind::ArithBitcast.name(), &[src], rt);
        cr.replace_values(op, &[v]);
        true
    }

    #[convert("tt.fp_to_fp")]
    fn fp_to_fp(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let src = cr.rw.body[op].operands[0];
        let rt = L::rty(cr, op);
        let w = |t: &Type<'_>| t.element_type().bit_width().unwrap_or(0);
        let k = if w(&L::ty(cr, src)) > w(&rt) { Kind::ArithTruncf } else { Kind::ArithExtf };
        let v = cr.op1(k.name(), &[src], rt);
        cr.replace_values(op, &[v]);
        true
    }

    #[convert("tt.clampf")]
    fn clampf(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        // PropagateNan::ALL 是 0xFFFF，NONE 是 0
        let all = cr.rw.body.int_attr(op, "propagateNan").is_some_and(|v| v != 0);
        let (mx, mn) = if all { (Kind::ArithMaximumf, Kind::ArithMinimumf) } else { (Kind::ArithMaxnumf, Kind::ArithMinnumf) };
        let t = L::ty(cr, o[0][0]);
        let a = cr.op1(mx.name(), &[o[0][0], o[1][0]], t.clone());
        let v = cr.op1(mn.name(), &[a, o[2][0]], t);
        cr.replace_values(op, &[v]);
        true
    }

    #[convert("tt.precise_sqrt")]
    fn precise_sqrt(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::one_to_one(cr, op, o, Kind::MathSqrt)
    }

    #[convert("tt.precise_divf")]
    fn precise_divf(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::one_to_one(cr, op, o, Kind::ArithDivf)
    }

    #[convert("tt.extern_elementwise")]
    fn extern_elementwise(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let pure = matches!(b[op].get("pure"), Some(Attribute::Bool(true)) | Some(Attribute::Unit));
        let symbol = b[op].get("symbol").and_then(|a| a.text().ok()).map(|t| t.to_string()).unwrap_or_default();
        let srcs = b[op].operands.clone();
        let Some(k) = Extern::of(&symbol, srcs.len()) else { return false };
        if !pure {
            return false;
        }
        let rt = L::rty(cr, op);
        let v = cr.op1(k.name(), &srcs, rt);
        cr.replace_values(op, &[v]);
        true
    }

    #[convert("tt.dot")]
    fn dot(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let (a, bb, c) = {
            let ops = &cr.rw.body[op].operands;
            (ops[0], ops[1], ops[2])
        };
        let rt = L::rty(cr, op);
        let et = rt.element_type().clone();
        let integers = matches!(et, Type::Integer { .. });
        let mut acc = c;
        if Self::zero_tensor(cr.rw.body, c) {
            let init = cr.empty(&L::dims(&rt), et.clone(), &[]);
            let z = if integers { crate::ir::integer(et.bit_width().unwrap_or(32), 0) } else { crate::ir::float(crate::ir::float_kind(&et).expect("浮点"), 0.0) };
            let zero = L::constant(cr, z, &et);
            acc = L::fill(cr, zero, init);
        }
        let rank = L::dims(&rt).len();
        let (name, maps) = match rank {
            2 => ("linalg.matmul", ["(d0, d1, d2) -> (d0, d2)", "(d0, d1, d2) -> (d2, d1)", "(d0, d1, d2) -> (d0, d1)"]),
            3 => ("linalg.batch_matmul", ["(d0, d1, d2, d3) -> (d0, d1, d3)", "(d0, d1, d2, d3) -> (d0, d3, d2)", "(d0, d1, d2, d3) -> (d0, d1, d2)"]),
            _ => return false,
        };
        let maps = Attribute::Array(maps.iter().map(|m| Attribute::from(&AffineMap::parse(m).expect("affine map"))).collect());
        let m = cr.structured(name, &[a, bb], &[acc], &[rt.clone()], vec![("indexing_maps", maps)], &mut |cr, x| {
            let ot = cr.rw.body[x[2]].ty.clone();
            let v1 = cr.cast_scalar(x[0], &ot, false);
            let v2 = cr.cast_scalar(x[1], &ot, false);
            let (mul, add) = if integers { (Kind::ArithMuli, Kind::ArithAddi) } else { (Kind::ArithMulf, Kind::ArithAddf) };
            let p = cr.op1(mul.name(), &[v1, v2], ot.clone());
            vec![cr.op1(add.name(), &[x[2], p], ot)]
        });
        let mv = cr.rw.body[m].results[0];
        cr.replace_values(op, &[mv]);
        true
    }

    #[convert("tt.reduce")]
    fn reduce(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        if b[op].operands.len() != 1 {
            return false;
        }
        let blk = b.entry(op, 0);
        let body_ops = &b.block_ops(blk);
        if body_ops.len() != 2 {
            return false;
        }
        let rop = body_ops[0];
        let Some(rk) = b.kind(rop).filter(|k| Reduce::supported(*k)) else { return false };
        let src = o[0][0];
        let st = L::ty(cr, src);
        let et = st.element_type().clone();
        let rt = L::rty(cr, op);
        let axis = cr.rw.body.int_attr(op, "axis").unwrap_or(0) as i64;
        let vector = L::dims(&st).len() == 1;
        let f32_acc = Reduce::needs_f32(&et, rk);
        let ct = if f32_acc { Type::Float(mlirformat::FloatKind::F32) } else { et.clone() };
        let rloc = cr.rw.body[rop].loc.clone();
        let base = L::constant(cr, Reduce::base(rk, &ct), &ct);
        let bop = cr.rw.body.def_op(base).expect("常量");
        cr.rw.body[bop].loc = rloc;
        let shape = if vector { Vec::new() } else { L::dims(&rt) };
        let init = cr.empty(&shape, ct.clone(), &[]);
        let filled = L::fill(cr, base, init);
        let it = Type::tensor(&shape, ct.clone());
        let r = cr.structured("linalg.reduce", &[src], &[filled], &[it], vec![("dimensions", dense_i64(&[axis]))], &mut |cr, x| {
            let mut lhs = x[0];
            if f32_acc {
                lhs = cr.op1(Kind::ArithExtf.name(), &[lhs], Type::Float(mlirformat::FloatKind::F32));
            }
            let t = cr.rw.body[lhs].ty.clone();
            vec![cr.op1(rk.name(), &[lhs, x[1]], t)]
        });
        let mut v = cr.rw.body[r].results[0];
        if vector {
            v = cr.op1(Kind::TensorExtract.name(), &[v], ct.clone());
        }
        if f32_acc {
            v = cr.op1(Kind::ArithTruncf.name(), &[v], rt);
        }
        cr.replace_values(op, &[v]);
        true
    }

    #[convert("tt.reshape")]
    fn reshape(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let src = cr.rw.body[op].operands[0];
        let (it, ot) = (L::ty(cr, src), L::rty(cr, op));
        let (id, od) = (L::dims(&it), L::dims(&ot));
        if od.contains(&mlirformat::Dim::DYNAMIC) {
            return false;
        }
        let v = match Reassoc::for_reshape(&id, &od) {
            Some(groups) if od.len() < id.len() => {
                let d = OpData::build(Kind::TensorCollapseShape.name()).operands(&[src]).with("reassociation", Reassoc::attr(&groups));
                let c = cr.rw.create(d, &[ot]);
                cr.rw.body[c].results[0]
            }
            Some(groups) => Self::expand(cr, src, &groups, ot),
            None => {
                let st = Type::tensor(&[od.len() as i64], Type::int(64));
                let shape: Attribute<'_> = mlirformat::Const { ty: st.clone(), values: od.iter().map(|x| crate::ir::integer(64, i128::from(*x))).collect(), elements: true }.into();
                let k = cr.rw.create(OpData::build(Kind::ArithConstant.name()).with("value", shape), &[st]);
                let kv = cr.rw.body[k].results[0];
                let r = cr.rw.create(OpData::build(Kind::TensorReshape.name()).operands(&[src, kv]), &[ot]);
                cr.rw.body[r].results[0]
            }
        };
        cr.replace_values(op, &[v]);
        true
    }

    /// `CallConverter`：tt.call ⇒ func.call。被调函数要的参数比给的多（args 写法给它追加了 grid 参数）时，
    /// 缺的那几个取所在函数入口块的最后几个参数。
    #[convert("tt.call")]
    fn call(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let mut args: Vec<ValueId> = o.iter().flatten().copied().collect();
        let callee = b[op].get("callee").cloned();
        let name = callee.as_ref().and_then(|c| c.text().ok()).map(|n| n.trim_start_matches('@').to_owned());
        let parent = {
            let mut at = b.parent_op(op);
            while let Some(p) = at.filter(|p| !b.is(*p, Kind::TtFunc)) {
                at = b.parent_op(p);
            }
            at
        };
        if let (Some(parent), Some(name)) = (parent, name)
            && let Some(f) = b.find_symbol(b.root, &name).filter(|f| b.is(*f, Kind::TtFunc))
            && let Some(Attribute::Type(Type::Function(ft))) = b[f].get("function_type")
        {
            let need = ft.inputs.len();
            let inputs = b[b.entry(parent, 0)].args.to_vec();
            if need > args.len() {
                let missing = need - args.len();
                args.extend_from_slice(&inputs[inputs.len() - missing..]);
            }
        }
        let rts: Vec<Type<'_>> = b[op].results.iter().map(|r| b.ty(*r).clone()).collect();
        let mut d = OpData::build(Kind::FuncCall.name()).operands(&args);
        if let Some(c) = callee {
            d.set("callee", c);
        }
        let c = cr.rw.create(d, &rts);
        let rs = cr.rw.body[c].results.to_vec();
        cr.replace_values(op, &rs);
        true
    }

    #[convert("tt.get_program_id")]
    fn program_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        Self::grid(cr, op, Kind::GpuBlockId)
    }

    #[convert("tt.get_num_programs")]
    fn num_programs(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        Self::grid(cr, op, Kind::GpuGridDim)
    }

    #[convert("arith.constant")]
    fn dense_constant(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let v = cr.rw.body[op].results[0];
        let Some(c) = cr.rw.body.constant(v) else { return false };
        let Some(first) = c.values.first().cloned() else { return false };
        let rt = L::rty(cr, op);
        let et = rt.element_type().clone();
        let k = L::constant(cr, first, &et);
        let init = cr.empty(&L::dims(&rt), et, &[]);
        let f = L::fill(cr, k, init);
        cr.replace_values(op, &[f]);
        true
    }
}

impl Tt {
    fn one_to_one(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>], k: Kind) -> bool {
        let ops: Vec<ValueId> = o.iter().map(|x| x[0]).collect();
        let t = L::ty(cr, ops[0]);
        let v = cr.op1(k.name(), &ops, t);
        cr.replace_values(op, &[v]);
        true
    }

    fn expand<'a>(cr: &mut Cr<'_, 'a, '_>, src: ValueId, groups: &[Vec<i64>], rt: Type<'a>) -> ValueId {
        let d = OpData::build(Kind::TensorExpandShape.name()).operands(&[src]).with("reassociation", Reassoc::attr(groups)).with("static_output_shape", dense_i64(&L::dims(&rt)));
        let e = cr.rw.create(d, &[rt]);
        cr.rw.body[e].results[0]
    }

    fn grid(cr: &mut Cr<'_, '_, '_>, op: OpId, k: Kind) -> bool {
        let axis = cr.rw.body.int_attr(op, "axis").unwrap_or(0);
        let dim = ["<dim x>", "<dim y>", "<dim z>"][axis.clamp(0, 2) as usize];
        let g = cr.rw.create(OpData::build(k.name()).with("dimension", Attribute::dialect("gpu", dim)), &[Type::Index]);
        let gv = cr.rw.body[g].results[0];
        let v = cr.op1(Kind::ArithIndexCast.name(), &[gv], Type::int(32));
        cr.replace_values(op, &[v]);
        true
    }

    /// `isZeroTensor`。
    fn zero_tensor(b: &Body<'_>, v: ValueId) -> bool {
        let zero = |v: ValueId| {
            b.constant(v).is_some_and(|c| {
                c.values.first().is_some_and(|x| match x {
                    Scalar::Int(i) => i.signed() == 0,
                    Scalar::Float(f) => f.to_f64() == 0.0,
                })
            })
        };
        if let Some(s) = b.def_of(v, Kind::TtSplat) {
            let src = b.opd(s, 0);
            return !matches!(b.ty(src), Type::Shaped(_)) && zero(src);
        }
        b.def_of(v, Kind::ArithConstant).is_some_and(|_| b.constant(v).is_some_and(|c| c.elements && c.values.windows(2).all(|w| w[0] == w[1])) && zero(v))
    }
}

/// 上游 `ConvertAnyElementwiseMappableOpOnRankedTensors`（任意 op，最后试；用原操作数，照 RewritePattern）。
struct Elementwise;

impl Elementwise {
    fn scalar_like(t: &Type<'_>) -> bool {
        matches!(t, Type::Integer { .. } | Type::Float(_) | Type::Index | Type::Complex(_))
    }

    fn ranked(t: &Type<'_>) -> bool {
        matches!(t, Type::Shaped(s) if s.kind == mlirformat::ShapedKind::Tensor && s.shape.is_some())
    }

    fn mappable(b: &Body<'_>, op: OpId) -> bool {
        if ![Trait::Elementwise, Trait::Scalarizable, Trait::Vectorizable, Trait::Tensorizable].iter().all(|t| b.has(op, *t)) {
            return false;
        }
        let tys: Vec<&Type<'_>> = b[op].operands.iter().map(|v| b.ty(*v)).collect();
        tys.iter().any(|t| Self::ranked(t)) && tys.iter().all(|t| Self::ranked(t) || Self::scalar_like(t))
    }
}

impl ConversionPattern for Elementwise {
    fn name(&self) -> &str {
        "ConvertAnyElementwiseMappableOpOnRankedTensors"
    }

    fn root(&self) -> Option<&str> {
        None
    }

    fn rewrite(&self, cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if !Self::mappable(cr.rw.body, op) {
            return false;
        }
        let d = cr.rw.body[op].clone();
        let rts: Vec<Type<'_>> = d.results.iter().map(|r| L::ty(cr, *r)).collect();
        let rank = L::dims(&rts[0]).len() as u32;
        let id = AffineMap::identity(rank);
        let scalar = AffineMap { dims: rank, syms: 0, results: Vec::new() };
        let mut maps: Vec<AffineMap> = d.operands.iter().map(|v| if Self::scalar_like(&L::ty(cr, *v)) { scalar.clone() } else { id.clone() }).collect();
        maps.extend(std::iter::repeat_n(id, rts.len()));
        let mut outs = Vec::new();
        for t in &rts {
            if let Some(v) = d.operands.iter().find(|v| L::ty(cr, **v) == *t) {
                outs.push(*v);
            } else {
                let first = L::ty(cr, d.operands[0]);
                outs.push(cr.empty(&L::dims(&first), t.element_type().clone(), &[]));
            }
        }
        let n = d.operands.len();
        let ets: Vec<Type<'_>> = rts.iter().map(|t| t.element_type().clone()).collect();
        let g = cr.generic(&rts, &d.operands, &outs, &maps, &L::par(rank as usize), &mut |cr, a| {
            let mut data = OpData::named(d.name.clone()).operands(&a[..n]);
            data.properties.clone_from(&d.properties);
            data.attributes.clone_from(&d.attributes);
            let o = cr.rw.create(data, &ets);
            cr.rw.body[o].results.to_vec()
        });
        let gv = cr.rw.body[g].results.to_vec();
        cr.replace_values(op, &gv);
        true
    }
}

/// 归约。
struct Reduce;

impl Reduce {
    fn supported(k: Kind) -> bool {
        use Kind as K;
        matches!(k, K::ArithAddf | K::ArithAddi | K::ArithAndi | K::ArithMaximumf | K::ArithMulf | K::ArithMuli | K::ArithMaxnumf | K::ArithMinimumf | K::ArithMinnumf | K::ArithMinsi | K::ArithMinui | K::ArithMaxsi | K::ArithMaxui | K::ArithOri | K::ArithXori)
    }

    /// 窄浮点输入的浮点 combiner 一律升 f32 累加。
    fn needs_f32(et: &Type<'_>, k: Kind) -> bool {
        matches!(et, Type::Float(_)) && et.bit_width().is_some_and(|w| w < 32) && matches!(k, Kind::ArithAddf | Kind::ArithMulf | Kind::ArithMaximumf | Kind::ArithMaxnumf | Kind::ArithMinimumf | Kind::ArithMinnumf)
    }

    fn base(k: Kind, t: &Type<'_>) -> Scalar {
        use Kind as K;
        let w = t.bit_width().unwrap_or(32);
        let fk = crate::ir::float_kind(t);
        let f = |x: f64| crate::ir::float(fk.expect("浮点"), x);
        let i = |x: i128| crate::ir::integer(w, x);
        match k {
            K::ArithAddf => f(0.0),
            K::ArithMaximumf | K::ArithMaxnumf => f(f64::NEG_INFINITY),
            K::ArithMinimumf | K::ArithMinnumf => f(f64::INFINITY),
            K::ArithMulf => f(1.0),
            K::ArithMinsi => i((1i128 << (w - 1)) - 1),
            K::ArithMinui => i((1i128 << w) - 1),
            K::ArithMaxsi => i(-(1i128 << (w - 1))),
            K::ArithMuli | K::ArithAndi => i(1),
            _ => i(0),
        }
    }
}

/// tt.extern_elementwise 的符号 ⇒ math op。
struct Extern;

impl Extern {
    const UNARY: [(&'static str, Kind); 47] = [
        ("__nv_fabsf", Kind::MathAbsf), ("__nv_fabs", Kind::MathAbsf), ("__nv_sinf", Kind::MathSin), ("__nv_sin", Kind::MathSin),
        ("__nv_cosf", Kind::MathCos), ("__nv_cos", Kind::MathCos), ("__nv_tanf", Kind::MathTan), ("__nv_tan", Kind::MathTan),
        ("__nv_asinf", Kind::MathAsin), ("__nv_asin", Kind::MathAsin), ("__nv_acosf", Kind::MathAcos), ("__nv_acos", Kind::MathAcos),
        ("__nv_atanf", Kind::MathAtan), ("__nv_atan", Kind::MathAtan), ("__nv_sinhf", Kind::MathSinh), ("__nv_sinh", Kind::MathSinh),
        ("__nv_coshf", Kind::MathCosh), ("__nv_cosh", Kind::MathCosh), ("__nv_tanhf", Kind::MathTanh), ("__nv_acoshf", Kind::MathAcosh),
        ("__nv_acosh", Kind::MathAcosh), ("__nv_asinhf", Kind::MathAsinh), ("__nv_asinh", Kind::MathAsinh), ("__nv_atanhf", Kind::MathAtanh),
        ("__nv_logf", Kind::MathLog), ("__nv_log", Kind::MathLog), ("__nv_log10f", Kind::MathLog10), ("__nv_log10", Kind::MathLog10),
        ("__nv_log1pf", Kind::MathLog1p), ("__nv_log1p", Kind::MathLog1p), ("__nv_expf", Kind::MathExp), ("__nv_exp", Kind::MathExp),
        ("__nv_exp2f", Kind::MathExp2), ("__nv_exp2", Kind::MathExp2), ("__nv_erff", Kind::MathErf), ("__nv_erf", Kind::MathErf),
        ("__nv_sqrtf", Kind::MathSqrt), ("__nv_sqrt", Kind::MathSqrt), ("__nv_rsqrtf", Kind::MathRsqrt), ("__nv_rsqrt", Kind::MathRsqrt),
        ("__nv_ceilf", Kind::MathCeil), ("__nv_ceil", Kind::MathCeil), ("__nv_floorf", Kind::MathFloor), ("__nv_floor", Kind::MathFloor),
        ("__nv_truncf", Kind::MathTrunc), ("__nv_trunc", Kind::MathTrunc), ("__nv_tanh", Kind::MathTanh),
    ];
    const BINARY: [(&'static str, Kind); 4] = [("__nv_atan2f", Kind::MathAtan2), ("__nv_atan2", Kind::MathAtan2), ("__nv_powf", Kind::MathPowf), ("__nv_pow", Kind::MathPowf)];

    fn of(symbol: &str, n: usize) -> Option<Kind> {
        let table: &[(&str, Kind)] = match n {
            1 => &Self::UNARY,
            2 => &Self::BINARY,
            _ => return None,
        };
        table.iter().find(|(s, _)| *s == symbol).map(|(_, k)| *k)
    }
}

/// `getReassociationIndicesForReshape`（静态形状）。
struct Reassoc;

impl Reassoc {
    fn for_reshape(src: &[i64], dst: &[i64]) -> Option<Vec<Vec<i64>>> {
        match src.len().cmp(&dst.len()) {
            core::cmp::Ordering::Greater => Self::collapse(src, dst),
            core::cmp::Ordering::Less => Self::collapse(dst, src),
            core::cmp::Ordering::Equal => None,
        }
    }

    fn collapse(src: &[i64], dst: &[i64]) -> Option<Vec<Vec<i64>>> {
        if dst.is_empty() {
            return src.iter().all(|d| *d == 1).then(Vec::new);
        }
        let mut map: Vec<Vec<i64>> = Vec::new();
        let mut cur = Vec::new();
        let mut prod = 1i64;
        let mut s = 0usize;
        while s < src.len() && map.len() < dst.len() {
            let target = dst[map.len()];
            while s < src.len() - 1 && prod * src[s] < target {
                prod *= src[s];
                cur.push(s as i64);
                s += 1;
            }
            if prod * src[s] != target {
                return None;
            }
            cur.push(s as i64);
            s += 1;
            map.push(core::mem::take(&mut cur));
            prod = 1;
        }
        if map.len() != dst.len() {
            return None;
        }
        for d in s..src.len() {
            if src[d] != 1 {
                return None;
            }
            map.last_mut().expect("至少一组").push(d as i64);
        }
        Some(map)
    }

    fn attr(groups: &[Vec<i64>]) -> Attribute<'static> {
        Attribute::Array(groups.iter().map(|g| Attribute::Array(g.iter().map(|i| i64_attr(*i)).collect())).collect())
    }
}

impl TritonArithToLinalg {
    fn target(&self) -> ConversionTarget<'static> {
        let mut t = ConversionTarget::default();
        for d in ["func", "linalg", "affine", "scf", "cf", "tensor", "bufferization", "tts", "gpu"] {
            t.legal_dialect(d);
        }
        let dynamic = || {
            Action::Dynamic(Box::new(|b: &Body<'_>, op: OpId| {
                if b.is(op, Kind::ArithConstant) {
                    let v = b.res(op, 0);
                    if !matches!(b.ty(v), Type::Shaped(_)) {
                        return Some(true);
                    }
                    let splat = b.constant(v).is_some_and(|c| c.elements && c.values.windows(2).all(|w| w[0] == w[1]) && matches!(c.ty.element_type(), Type::Integer { .. } | Type::Float(_)));
                    return Some(!splat);
                }
                Some(!b[op].operands.iter().all(|v| Elementwise::ranked(b.ty(*v))))
            }))
        };
        t.dialect("arith", dynamic());
        t.dialect("math", dynamic());
        t.legal_op("builtin.module").legal_op(Kind::TtFunc.name()).legal_op(Kind::TtReturn.name());
        if GridEncoding::try_from(self.grid.as_str()) == Ok(GridEncoding::Gpu) {
            t.illegal_op(Kind::TtGetProgramId.name()).illegal_op(Kind::TtGetNumPrograms.name());
        }
        t.dynamic_op(Kind::TtAddptr.name(), |b, op| Some(!matches!(b.ty(b.res(op, 0)), Type::Shaped(_))));
        t.dynamic_op(Kind::TtBitcast.name(), |b, op| Some(matches!(b.ty(b.res(op, 0)).element_type(), Type::Extended(e) if e.name == "tt.ptr")));
        t
    }

    /// tt.func ⇒ func.func，tt.return ⇒ func.return。
    fn to_func<'a>(b: &mut Body<'a>, module: OpId) {
        let top = b.top_block(module);
        for f in b.block_ops(top) {
            if !b.is(f, Kind::TtFunc) {
                continue;
            }
            let mut d: OpData<'a> = OpData::named(Kind::FuncFunc.name());
            for name in ["function_type", "sym_name"] {
                if let Some(a) = b[f].get(name) {
                    d.properties.push(NamedAttr { name: name.into(), value: Some(a.clone()) });
                }
            }
            if let Some(v) = b[f].get("sym_visibility").filter(|v| v.text().is_ok_and(|t| t != "public")) {
                d.properties.push(NamedAttr { name: "sym_visibility".into(), value: Some(v.clone()) });
            }
            for name in ["arg_attrs", "res_attrs"] {
                if let Some(Attribute::Array(xs)) = b[f].get(name)
                    && xs.iter().any(|x| !matches!(x, Attribute::Dict(d) if d.is_empty()))
                {
                    d.properties.push(NamedAttr { name: name.into(), value: Some(Attribute::Array(xs.clone())) });
                }
            }
            d.properties.sort_by(|x, y| x.name.cmp(&y.name));
            d.loc.clone_from(&b[f].loc);
            let n = b.create(d, &[]);
            let regions = b[f].regions.clone();
            for r in regions.iter() {
                b[*r].parent = n;
            }
            b[n].regions = regions;
            b[f].regions = mlirpass::Ids::new();
            b.insert_before(n, f);
            b.erase(f);
            let loc = b[n].loc.clone();
            for blk in b.blocks(b[n].regions[0]) {
                let Some(t) = b.terminator(blk).filter(|t| b.is(*t, Kind::TtReturn)) else { continue };
                let mut r = OpData::build(Kind::FuncReturn.name()).operands(&b[t].operands.clone());
                r.loc.clone_from(&loc);
                let r = b.create(r, &[]);
                b.insert_before(r, t);
                b.erase(t);
            }
        }
    }
}

impl Run for TritonArithToLinalg {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        if GridEncoding::try_from(self.grid.as_str())? == GridEncoding::Args {
            return Err(Error::from("triton-arith-to-linalg：后备写法 B′（grid-encoding=args）还没移植"));
        }
        let region = body[op].regions[0];
        let mut minmax = PatternSet::default();
        minmax.add(MinMax(Kind::ArithCmpf)).add(MinMax(Kind::ArithCmpi));
        body.apply_greedily(region, &minmax, &GreedyConfig::default());
        let target = self.target();
        let mut patterns = ConversionPatterns::default();
        Tt::populate(&mut patterns);
        patterns.add(Elementwise);
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)?;
        body.apply_greedily(region, &PatternSet::default(), &GreedyConfig::default());
        Self::to_func(body, op);
        Ok(())
    }
}
