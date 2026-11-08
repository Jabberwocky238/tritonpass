//! 开发用：mlir-opt 的命令行，带上 tritonpass 的方言、接口与 pass（单跑某个 pass、看出错时的诊断）。
//! 用法：cargo run --release --example opt -- <输入> --pass-pipeline='builtin.module(...)' [--mlir-print-op-generic]
use mlirpass::mlirformat::MlirOpt;
use mlirpass::{Ctx, Interfaces, Invocation, Passes};
use tritonpass::{TritonPasses, TtInterfaces, load_triton};

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
    let src = std::fs::read_to_string(&input).expect("读不了输入");
    match inv.run(Ctx::new(&opt, &interfaces), &src) {
        Ok(text) => {
            print!("{text}");
            std::process::ExitCode::SUCCESS
        }
        Err(e) => {
            eprintln!("{e}");
            std::process::ExitCode::from(1)
        }
    }
}
