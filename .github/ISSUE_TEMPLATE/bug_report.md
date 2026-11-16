---
name: Bug report
about: A pass crashes, rejects valid IR, or produces wrong or invalid IR
labels: bug
---

**Input**

<!-- The smallest TTIR / MLIR that shows the problem, inline or attached. -->

**Command**

```sh
cargo run --release --example opt -- input.mlir --pass-pipeline='builtin.module(...)'
```

**What happened, and what you expected**

<!-- The output or error. If you have the reference (dope-opt), what it produces for the same input. -->

**Version**

<!-- tritonpass commit or version, and `rustc --version`. -->
