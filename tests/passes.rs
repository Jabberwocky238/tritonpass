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
//! 每一块要么 exact，要么登记在 `tests/divergences/*.txt` 里（一行一块：`<stem>#<块号>  <原因>`，`#` 开头的行是注释）。
//! 没登记的块不 exact 是退步；登记了的块变 exact（或已经没有这一块）是清单过时，删掉那一行；unsupported 一律不行。
//! 三种都让测试失败。登记的都是有原因的分歧：参照是旧 LLVM 上的 C++ 输出（README 写明差在哪），或参照自己的毛病。
//!
//! tritonpass 一侧每块读入之后、跑完之后都过一遍 [`tritonpass::verify`]（参照的 MLIR 也在这两处查）：类型对不上算失败。
//!
//! `--nocapture` 印按组的计数；`FILTER=<子串>` 只跑一部分，`SHOW=1` 印每处不 exact 的第一行差异（`SHOW=full` 两边全文）。

use std::collections::{BTreeMap, BTreeSet};
use std::fs;
use std::path::{Path, PathBuf};

use mlirpass::mlirformat::MlirOpt;
use mlirpass::{Body, Ctx, Interfaces, Invocation, Passes};
use tritonpass::{TritonPasses, TtInterfaces, load_triton, run_chunk_verified};

#[derive(Default, Clone, Copy)]
struct Tally {
    exact: usize,
    mismatch: usize,
    error: usize,
    unsupported: usize,
    /// 不 exact 但登记在 `tests/divergences` 里的块。
    known: usize,
}

impl Tally {
    fn add(&mut self, o: &Tally) {
        self.exact += o.exact;
        self.mismatch += o.mismatch;
        self.error += o.error;
        self.unsupported += o.unsupported;
        self.known += o.known;
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Outcome {
    Exact,
    Mismatch,
    Error,
}

struct Fixtures;

impl Fixtures {
    fn root() -> &'static Path {
        Path::new(env!("CARGO_MANIFEST_DIR"))
    }

    fn dir() -> PathBuf {
        Self::root().join("tests/fixtures")
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

    /// `pipeline__…` ⇒ `pipeline`；`Conversion__TritonToStructured__x` ⇒ `Conversion/TritonToStructured`；`Pass__x` ⇒ `Pass/x`；
    /// `regress__structured__x` ⇒ `regress/structured`。
    fn group(stem: &str) -> String {
        let parts: Vec<_> = stem.split("__").collect();
        match parts.as_slice() {
            ["pipeline", ..] => "pipeline".into(),
            [a, b, ..] => format!("{a}/{}", b.split('.').next().unwrap()),
            _ => stem.into(),
        }
    }

    /// `tests/divergences/*.txt`：`<stem>#<块号>` ⇒ 原因。同一块登记两次、写法不对都直接报错。
    fn divergences() -> BTreeMap<String, String> {
        let dir = Self::root().join("tests/divergences");
        let mut files: Vec<PathBuf> = fs::read_dir(&dir).unwrap().filter_map(|e| Some(e.ok()?.path())).filter(|p| p.extension().is_some_and(|x| x == "txt")).collect();
        files.sort();
        let mut out = BTreeMap::new();
        for f in files {
            for (n, line) in fs::read_to_string(&f).unwrap().lines().enumerate() {
                let line = line.trim();
                if line.is_empty() || line.starts_with('#') {
                    continue;
                }
                let (key, why) = line.split_once(char::is_whitespace).unwrap_or((line, ""));
                assert!(key.rsplit_once('#').is_some_and(|(_, i)| i.parse::<usize>().is_ok()), "{}:{}: 要写成 `<stem>#<块号>  <原因>`", f.display(), n + 1);
                let old = out.insert(key.to_owned(), why.trim().to_owned());
                assert!(old.is_none(), "{}:{}: `{key}` 登记了两次", f.display(), n + 1);
            }
        }
        out
    }
}

/// 两份印法第一处不同的行。
fn first_diff(a: &str, b: &str) -> String {
    a.lines().zip(b.lines()).find(|(x, y)| x != y).map_or_else(|| "\n      （一份是另一份的前缀）".into(), |(x, y)| format!("\n      参照：{}\n      tritonpass：{}", x.trim(), y.trim()))
}

/// 至多列出前 `n` 条。
fn listing(items: &[String], n: usize) -> String {
    use std::fmt::Write;
    let mut s = String::new();
    for x in items.iter().take(n) {
        let _ = write!(s, "\n  {x}");
    }
    if items.len() > n {
        let _ = write!(s, "\n  …… 共 {} 条", items.len());
    }
    s
}

#[test]
#[allow(clippy::too_many_lines)]
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
    let divergences = Fixtures::divergences();
    let mut seen = BTreeSet::new();
    let (mut regressed, mut stale, mut unsupported) = (Vec::new(), Vec::new(), Vec::new());
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
                unsupported.push(format!("{stem}：{}", e.0));
                continue;
            }
        };
        inv.generic = true;
        inv.threading = false;
        let ins = inv.chunks(&input);
        let outs = inv.chunks(&expected);
        assert_eq!(ins.len(), outs.len(), "{stem}: 块数不同");
        for (i, (chunk, want)) in ins.into_iter().zip(outs).enumerate() {
            let key = format!("{stem}#{i}");
            let listed = divergences.contains_key(&key);
            seen.insert(key.clone());
            let want = if want.trim().is_empty() { String::new() } else { inv.print(&mut Body::parse(ctx, want).unwrap_or_else(|e| panic!("{key}: 参照的输出读不进：{e}"))) };
            let mark = if listed { "（已登记）" } else { "" };
            let outcome = match run_chunk_verified(&inv, ctx, chunk) {
                Ok(got) if got == want => Outcome::Exact,
                Err(_) if want.is_empty() => Outcome::Exact,
                Ok(got) => {
                    if show {
                        eprintln!("  mismatch{mark} {key}:{}", first_diff(&want, &got));
                        if full {
                            eprintln!("--- 参照\n{want}--- tritonpass\n{got}---");
                        }
                    }
                    Outcome::Mismatch
                }
                Err(e) => {
                    if show {
                        eprintln!("  error{mark} {key}: {e}");
                    }
                    Outcome::Error
                }
            };
            match outcome {
                Outcome::Exact => t.exact += 1,
                Outcome::Mismatch => t.mismatch += 1,
                Outcome::Error => t.error += 1,
            }
            match (outcome, listed) {
                (Outcome::Exact, true) => stale.push(format!("{key}（已经 exact）")),
                (Outcome::Exact, false) => {}
                (_, true) => t.known += 1,
                (o, false) => regressed.push(format!("{key}（{}）", if o == Outcome::Mismatch { "mismatch" } else { "error" })),
            }
        }
    }
    if filter.is_none() {
        stale.extend(divergences.keys().filter(|k| !seen.contains(*k)).map(|k| format!("{k}（没有这一块）")));
    }
    let mut total = Tally::default();
    eprintln!("{:<40} {:>6} {:>8} {:>6} {:>11} {:>6}", "", "exact", "mismatch", "error", "unsupported", "known");
    for (g, t) in &groups {
        total.add(t);
        eprintln!("{g:<40} {:>6} {:>8} {:>6} {:>11} {:>6}", t.exact, t.mismatch, t.error, t.unsupported, t.known);
    }
    eprintln!("{:<40} {:>6} {:>8} {:>6} {:>11} {:>6}", "total", total.exact, total.mismatch, total.error, total.unsupported, total.known);
    assert!(unsupported.is_empty(), "{} 条 RUN 的参数 tritonpass 不认：{}", unsupported.len(), listing(&unsupported, 20));
    assert!(regressed.is_empty(), "{} 块不 exact，也没登记在 tests/divergences（SHOW=1 看差在哪）：{}", regressed.len(), listing(&regressed, 40));
    assert!(stale.is_empty(), "{} 块登记在 tests/divergences，但已经 exact 或不存在，删掉对应的行：{}", stale.len(), listing(&stale, 40));
}
