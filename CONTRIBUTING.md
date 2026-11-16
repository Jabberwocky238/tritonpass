# Contributing

## Build and test

Rust 1.95 or newer (`rust-version` in `Cargo.toml`; the floor comes from mlirformat).

```sh
cargo build --release
cargo test --release --test passes -- --nocapture    # every fixture, chunk by chunk, against the C++ reference
cargo fmt --check
cargo clippy --all-targets
```

`FILTER=<substring>` runs only the fixtures whose name contains it; `SHOW=1` prints the first differing line of each
chunk that does not match, `SHOW=full` both sides in full.

To run a pass by hand: `cargo run --release --example opt -- <input> --pass-pipeline='builtin.module(...)'`
(`--mlir-print-op-generic`, `--split-input-file` and `--verify-each=false` work as in `mlir-opt`).

## Fixtures and the reference

The expected outputs in `tests/fixtures` come from the C++ implementation these passes were ported from (dope-opt, a
fork of triton-shared pinned to Triton 3.7.1 and its LLVM), through `scripts/fixtures.py`. Without that binary you can
still run and extend the tests, but not regenerate expected outputs.

- Every chunk must match exactly, unless it is listed in `tests/divergences/*.txt` with the reason. The test also fails
  when a listed chunk matches again or no longer exists, so delete its line then.
- A new input that the reference's own tests do not cover goes in `tests/regress/<area>/<name>.mlir`, written like a lit
  test (see `tests/regress/README.md`). Generate its expected output with
  `python3 -I scripts/fixtures.py --ref <dope-opt> --only regress`; `--check` compares without writing.
- Where tritonpass deliberately differs from the reference (the reference crashes, fails its own verifier, or computes a
  wrong result), list the chunk in `tests/divergences/<area>.txt` and say why.

## Code

- Source comments are in Chinese for now; ported code names its C++ counterpart (`addOFRs`, `MaskAnalysis`, …) so it
  can be read side by side with triton-shared.
- Recognize ops through the `Kind` enum, not by comparing names.
- `src/dialect/*.gen.rs` are generated (`mlirformat tblgen`, `scripts/gen_traits.py`); do not edit them by hand.
- A valid input must not panic: return an error, or leave the IR unchanged when a rewrite does not apply.
- A pass's output must pass `tritonpass::verify`.

## Commits and pull requests

- Branch from `main` and open a pull request; CI runs formatting, clippy and the tests.
- One logical change per commit, and every commit builds and passes the tests.
- Commit subjects follow [Conventional Commits](https://www.conventionalcommits.org/): `fix(<scope>): …`, `feat`,
  `perf`, `refactor`, `test`, `docs`, `build`, `ci`, `style`, `chore`. The body says what was wrong and why the change
  is right; a bug fix comes with a regression input.
- A formatting-only commit goes into `.git-blame-ignore-revs`.
