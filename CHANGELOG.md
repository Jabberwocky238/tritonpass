# Changelog

Notable changes to tritonpass. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and versions
follow [Semantic Versioning](https://semver.org/).

## [Unreleased]

## [0.2.1] - 2026-11-17

Compatible with 0.2.0: every public signature of 0.2.0 is unchanged.

### Added

- `tritonpass::verify`, the `triton-verify` pass and `run_chunk_verified`: the type checks MLIR's verifiers make and
  mlirpass's own verifier skips (the ODS `Same*` traits; `scf` region, result and yield types; `func.func` / `tt.func`
  returns and `func.call` / `tt.call` signatures; `tt.addptr`, `tt.load` / `tt.store`, `arith.select`, comparisons).
  The `opt` example and the fixture test check every chunk's input and result, so IR whose types do not line up is an
  error instead of being printed with exit code 0.
- `try_float` and `Tptr::try_of`, which return `None` where `float` / `Tptr::of` panic (a float kind without a layout,
  such as f8E4M3FNUZ; a negative segment size), and `Window::written_bases`, which finds every written base in one walk
  instead of one `Window::is_written` scan per load.
- tt canonicalization: `TransOp::fold` for `trans(trans)` and transposes of splat constants, `AdvanceOp::fold` for
  all-zero offsets.
- `opt` example: `-` reads standard input; warnings the passes report are printed when the pipeline succeeds.
- Tests: every chunk must match the reference or be listed with its reason in `tests/divergences/`; regression inputs in
  `tests/regress/`, whose expected output `scripts/fixtures.py --only regress` generates with the reference (`--check`
  compares without writing); coverage of the default `pids-to-func-args` encoding through the whole pipeline.
- `rust-version = "1.95"`, `rustfmt.toml`, `.git-blame-ignore-revs`, `CONTRIBUTING.md`, pull request and issue templates,
  and CI (formatting, clippy with warnings denied, tests on 1.95 and stable).

### Changed

- The fixture test no longer passes on a minimum count of exact chunks (`FLOOR`), which let a regression in one chunk hide
  behind an improvement in another.
- Lossy integer casts became checked conversions: an out-of-range attribute value now makes an analysis give up on the op
  instead of wrapping.

### Fixed

- `triton-arith-to-linalg`
  - In the default `pids-to-func-args` encoding, calls to quoted symbols (`@"…c-1"`) got no grid arguments while the
    callee did, giving calls of the wrong arity.
  - `tt.fp_to_fp` with `rounding = rtz` was lowered to round-to-nearest; it is now rejected, as the reference does.
  - `tt.fp_to_fp` between two float types of the same width produced an invalid `arith.extf`; now rejected.
  - `tt.cat` was left as `tensor.concat`; it is decomposed into `tensor.insert_slice` like the reference.
  - `tt.func` in nested modules was not converted to `func.func`; a declaration in the args encoding panicked.
- `structured-to-memref`: constant gather/scatter strides stayed dynamic and an `index_cast` was placed after the
  allocation (both differed from the reference); a rank-0 `tts.make_tptr` panicked; checking whether a base is written
  was repeated for every load (8000 loads of one base: 3.4 s, now 0.19 s).
- `triton-ptr-to-memref`: pointer block arguments of non-entry blocks were rejected; a function returning a pointer
  produced invalid IR and is now rejected.
- `triton-to-structured`: `tt.advance` of a non-block-pointer state built a malformed rank-0 pointer; the prepass also
  expanded `vector` and `memref` values; static `tts.make_tptr` entries were materialized as `index` instead of `i64`;
  mask and loop-carried state lookups could index out of range and panic.
- `triton-to-unstructured`: a `tts.make_tptr` with only static offsets and a rank-0 `tt.make_tensor_ptr` panicked.
- `triton-lower-bool-ptr`: block arguments outside the entry block (loop-carried bool pointers) and function results kept
  `ptr<i1>`, leaving invalid IR; the default address space is dropped so `!tt.ptr<i1, 1>` becomes `!tt.ptr<i8>`.
- `triton-fold-iota-integers`: terms of different lengths on one axis were silently truncated, and i64 overflow could
  panic or fold wrong constants; both now leave the op unchanged.
- `triton-split-row-axis`: a failure in the last row leaf went unnoticed and produced invalid IR; the rewrite is rolled back.
- Dialects: `tt.make_tensor_descriptor` duplicated `padding`; `scf.while` without loop-carried values did not parse;
  `llvm.intr.assume` put its attributes before the type; a rank-0 `tt.make_tensor_ptr` printed unreadable text; custom
  attribute dictionaries were not sorted; f8 FNUZ constants panicked; pure `tt.extern_elementwise` /
  `tt.elementwise_inline_asm` were treated as side-effecting; `isVolatile = 1 : i1` was not treated as volatile.
- The README example pipeline used an option `triton-arith-to-linalg` does not have.

[Unreleased]: https://github.com/Jabberwocky238/tritonpass/compare/v0.2.1...HEAD
[0.2.1]: https://github.com/Jabberwocky238/tritonpass/compare/v0.2.0...v0.2.1
