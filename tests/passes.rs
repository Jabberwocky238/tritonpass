//! ⭐ 每条夹具 RUN 行过一遍 tritonpass，按 `-split-input-file` 逐块对拍参照（这些 pass 移植所本的 C++ 实现，见
//! `scripts/fixtures.py`）。两边都经 `Body` 印通用形式，只比 IR：
//!
//! ```text
//! exact        同一份 IR（或参照失败、tritonpass 也失败）
//! mismatch     IR 不同
//! error        参照成功、tritonpass 失败
//! unsupported  参数里有 tritonpass 不认的 pass 或选项
//! ```
//!
//! `--nocapture` 印按组的计数；`FILTER=<子串>` 只跑一部分，`SHOW=1` 印每处失败的第一行差异（`SHOW=full` 两边全文）。
//! `FLOOR` 只升不降。

use std::collections::BTreeMap;
use std::fs;
use std::path::{Path, PathBuf};

use mlirpass::mlirformat::MlirOpt;
use mlirpass::{Body, Ctx, Interfaces, Invocation, Passes};
use tritonpass::{TritonPasses, TtInterfaces, load_triton};

/// 逐字节对上的块数：哪次改动让更多块对上就调高它。
const FLOOR: usize = 682;

#[derive(Default, Clone, Copy)]
struct Tally {
    exact: usize,
    mismatch: usize,
    error: usize,
    unsupported: usize,
}

impl Tally {
    fn add(&mut self, o: &Tally) {
        self.exact += o.exact;
        self.mismatch += o.mismatch;
        self.error += o.error;
        self.unsupported += o.unsupported;
    }
}

struct Fixtures;

impl Fixtures {
    fn dir() -> PathBuf {
        Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures")
    }

    /// `(stem, args)`，按 stem 排序。
    fn runs() -> Vec<(String, Vec<String>)> {
        let mut out: Vec<_> = fs::read_dir(Self::dir())
            .unwrap()
            .filter_map(|e| {
                let name = e.ok()?.file_name().into_string().ok()?;
                let stem = name.strip_suffix(".args")?.to_owned();
                let args = fs::read_to_string(Self::dir().join(&name)).ok()?.lines().map(str::to_owned).collect();
                Some((stem, args))
            })
            .collect();
        out.sort();
        out
    }

    fn read(stem: &str, kind: &str) -> String {
        fs::read_to_string(Self::dir().join(format!("{stem}.{kind}.mlir"))).unwrap()
    }

    /// `pipeline__…` ⇒ `pipeline`；`Conversion__TritonToStructured__x` ⇒ `Conversion/TritonToStructured`；`Pass__x` ⇒ `Pass/x`。
    fn group(stem: &str) -> String {
        let parts: Vec<_> = stem.split("__").collect();
        match parts.as_slice() {
            ["pipeline", ..] => "pipeline".into(),
            [a, b, ..] => format!("{a}/{}", b.split('.').next().unwrap()),
            _ => stem.into(),
        }
    }
}

/// 两份印法第一处不同的行。
fn first_diff(a: &str, b: &str) -> String {
    a.lines().zip(b.lines()).find(|(x, y)| x != y).map(|(x, y)| format!("\n      参照：{}\n      tritonpass：{}", x.trim(), y.trim())).unwrap_or_else(|| "\n      （一份是另一份的前缀）".into())
}

#[test]
fn passes() {
    let mut opt = MlirOpt::upstream();
    load_triton(&mut opt);
    let mut interfaces = Interfaces::upstream();
    interfaces.register(&TtInterfaces);
    let ctx = Ctx::new(&opt, &interfaces);
    let mut passes = Passes::upstream();
    passes.with(TritonPasses::add);
    let filter = std::env::var("FILTER").ok();
    let show = std::env::var_os("SHOW").is_some();
    let full = std::env::var("SHOW").is_ok_and(|s| s == "full");
    let mut groups: BTreeMap<String, Tally> = BTreeMap::new();
    for (stem, args) in Fixtures::runs() {
        if filter.as_deref().is_some_and(|f| !stem.contains(f)) {
            continue;
        }
        let input = Fixtures::read(&stem, "in");
        let expected = Fixtures::read(&stem, "generic");
        let t = groups.entry(Fixtures::group(&stem)).or_default();
        let mut inv = match Invocation::parse(&passes, args.as_slice()) {
            Ok(inv) => inv,
            Err(e) => {
                t.unsupported += 1;
                if show {
                    eprintln!("  unsupported {stem}: {}", e.0);
                }
                continue;
            }
        };
        inv.generic = true;
        inv.threading = false;
        let ins = inv.chunks(&input);
        let outs = inv.chunks(&expected);
        assert_eq!(ins.len(), outs.len(), "{stem}: 块数不同");
        for (i, (chunk, want)) in ins.into_iter().zip(outs).enumerate() {
            let want = if want.trim().is_empty() { String::new() } else { inv.print(&mut Body::parse(ctx, want).unwrap_or_else(|e| panic!("{stem} #{i}: 参照的输出读不进：{e}"))) };
            match inv.run_chunk(ctx, chunk) {
                Ok(got) if got == want => t.exact += 1,
                Err(_) if want.is_empty() => t.exact += 1,
                Ok(got) => {
                    t.mismatch += 1;
                    if show {
                        eprintln!("  mismatch {stem} #{i}:{}", first_diff(&want, &got));
                        if full {
                            eprintln!("--- 参照\n{want}--- tritonpass\n{got}---");
                        }
                    }
                }
                Err(e) => {
                    t.error += 1;
                    if show {
                        eprintln!("  error {stem} #{i}: {e}");
                    }
                }
            }
        }
    }
    let mut total = Tally::default();
    eprintln!("{:<40} {:>6} {:>8} {:>6} {:>11}", "", "exact", "mismatch", "error", "unsupported");
    for (g, t) in &groups {
        total.add(t);
        eprintln!("{g:<40} {:>6} {:>8} {:>6} {:>11}", t.exact, t.mismatch, t.error, t.unsupported);
    }
    eprintln!("{:<40} {:>6} {:>8} {:>6} {:>11}", "total", total.exact, total.mismatch, total.error, total.unsupported);
    assert!(total.exact >= FLOOR, "exact {} 低于下限 {FLOOR}", total.exact);
}
