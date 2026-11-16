## What and why

<!-- What was wrong or missing, and why this change is the right fix. Link the issue if there is one. -->

## How it was checked

- [ ] `cargo test --release --test passes` passes
- [ ] `cargo fmt --check` and `cargo clippy --all-targets` are clean for the changed code
- [ ] a bug fix comes with a regression input in `tests/regress/` (expected output generated with dope-opt)
- [ ] any chunk that now deliberately differs from the reference is listed in `tests/divergences/` with the reason
