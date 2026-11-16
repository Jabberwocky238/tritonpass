//! 开发用：mlir-opt 的命令行，带上 tritonpass 的方言、接口与 pass（单跑某个 pass、看出错时的诊断）。
//! 用法：cargo run --release --example opt -- <输入，`-` 或不给是标准输入> --pass-pipeline='builtin.module(...)' [--mlir-print-op-generic]
//!
//! 同 mlir-opt，每块读入之后、跑完之后都做类型检查（[`tritonpass::verify`]），`--verify-each=false` 关掉。
use std::io::Read;

use mlirpass::mlirformat::MlirOpt;
use mlirpass::{Ctx, Interfaces, Invocation, Passes, SPLIT_MARKER};
use tritonpass::{TritonPasses, TtInterfaces, load_triton, run_chunk_verified};

fn main() -> std::process::ExitCode {
    let args: Vec<String> = std::env::args().skip(1).collect();
    let mut opt = MlirOpt::upstream();
    load_triton(&mut opt);
    let mut interfaces = Interfaces::upstream();
    interfaces.register(&TtInterfaces);
    let mut passes = Passes::upstream();
    passes.with(TritonPasses::add);
    let inv = match Invocation::parse(&passes, &args) {
        Ok(i) => i,
        Err(e) => {
            eprintln!("opt: {e}");
            return std::process::ExitCode::from(1);
        }
    };
    let input = inv.input.clone().unwrap_or_else(|| "-".into());
    let read = if input == "-" {
        let mut s = String::new();
        std::io::stdin().read_to_string(&mut s).map(|_| s)
    } else {
        std::fs::read_to_string(&input)
    };
    let src = match read {
        Ok(s) => s,
        Err(e) => {
            eprintln!("opt: 读不了输入 `{input}`：{e}");
            return std::process::ExitCode::from(1);
        }
    };
    let ctx = Ctx::new(&opt, &interfaces);
    let outs: Result<Vec<String>, _> = inv.chunks(&src).into_iter().map(|c| run_chunk_verified(&inv, ctx, c)).collect();
    match outs {
        Ok(outs) => {
            print!("{}", outs.join(&format!("{SPLIT_MARKER}\n")));
            std::process::ExitCode::SUCCESS
        }
        Err(e) => {
            eprintln!("{e}");
            std::process::ExitCode::from(1)
        }
    }
}
