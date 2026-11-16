# Regression inputs

Inputs for bugs and gaps found outside the corpus that `scripts/fixtures.py` takes from the reference's own test
directory. Each `.mlir` file is written like a lit test: one or more `// RUN: dope-opt %s <args>` lines (the reference's pass
names, `dope-*`), optionally `--split-input-file` with `// -----` between chunks. Comments explaining the case go at the top.

`scripts/fixtures.py` turns every RUN line into a fixture `tests/fixtures/regress__<dir>__<name>.<k>.{args,in.mlir,generic.mlir}`,
with the expected output produced by the reference (dope-opt):

```sh
python3 -I scripts/fixtures.py --ref <dope-opt> --only regress           # (re)generate the regress fixtures
python3 -I scripts/fixtures.py --ref <dope-opt> --only regress --check   # compare only, exit 1 on any difference
```

`tests/passes.rs` then runs them like every other fixture. A case where tritonpass deliberately differs from the reference
(for example, the reference crashes or fails its own verifier) is listed in `tests/divergences/` with the reason.

| directory | what it covers |
|---|---|
| `args-mode/` | the full pipeline with `triton-arith-to-linalg`'s default `pids-to-func-args` encoding (the pipeline group only runs the gpu encoding) |
| `dialect/` | custom syntax round trips (`scf.while`, `llvm.intr.assume`, `tt.make_tensor_descriptor`, …), tt folds and memory effects, FNUZ floats |
| `linalg/` | `triton-arith-to-linalg`, `structured-to-memref` and `triton-ptr-to-memref` cases: quoted callees, rounding modes, `tt.cat`, gather/scatter, nested modules, rank-0 pointers |
| `norm/` | the normalization passes: bool pointers carried by loops, `fold-iota-integers` term lengths and overflow, `split-row-axis` rollback |
| `structured/` | `triton-to-structured` / `triton-to-unstructured`: block pointers, ranked-tensor-only prepass, static offsets, mask and loop-state bounds |
| `verify/` | invalid IR that both the reference and `tritonpass::verify` must reject |
