#!/usr/bin/env python3
"""生成 tests/fixtures：每条保留的 RUN 行一份 `<stem>.args` / `<stem>.in.mlir` / `<stem>.generic.mlir`。

参照是这些 pass 移植所本的 C++ 实现（dope-opt，triton-shared 的分叉，钉 Triton 3.7.1 与它的 LLVM）：对同一份输入、同一条流水线
跑一遍，按 `-split-input-file` 逐块印通用形式；跑不过的块写空（测试里 tritonpass 也该失败）。参照里 pass 叫 `dope-*`，
tritonpass 里叫 `triton-*`，`.args` 写的是 tritonpass 的名字。

两组：
  lit：参照仓 test/Pass 里通用 pass 的用例与 test/Conversion 全部（每条 RUN 行一份）
  pipeline：参照仓 test 下全部 .ttir 过整条通用流水线 [`PIPELINE`]

    python3 -I scripts/fixtures.py --ref <dope-opt 可执行文件> --tests <dope-opt 的 test 目录>
"""
import argparse
import re
import shlex
import subprocess
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / "tests" / "fixtures"

# 参照里的名字 ⇒ tritonpass 的名字（只列改了名的；triton-to-structured 等原样）
RENAME = {f"dope-{n}": f"triton-{n}" for n in (
    "lift-cf-to-scf drop-dead-exit-switch binary-search-to-for drop-thread-barrier drop-assume loop-lower-bound-zero "
    "fold-uniform-lanes fold-iota-integers split-row-axis normalize-loop-index lower-bool-ptr scalar-ptr squeeze-unit-dims "
    "conditional-fold-unit-dims loop-unit-step carried-buffers-in-place").split()}

LIT_PASS = ("binary_search_to_for bool_ptr carried_buffers_in_place drop_dead_exit_switch drop_thread_barrier fold_iota_integers "
            "fold_uniform_lanes lift_cf_to_scf loop_lower_bound_zero loop_unit_step normalize_loop_index scalar_ptr split_row_axis "
            "squeeze_unit_dims").split()

# 整条通用流水线（参照的名字）：dope-triton-to-std 去掉合同的收拒、访问摘要、数值与收尾那几步
PIPELINE = ("builtin.module(dope-lift-cf-to-scf, dope-drop-dead-exit-switch, dope-binary-search-to-for, dope-drop-thread-barrier, "
            "dope-drop-assume, dope-loop-lower-bound-zero, dope-fold-uniform-lanes, dope-fold-iota-integers, dope-split-row-axis, "
            "dope-normalize-loop-index, dope-lower-bool-ptr, dope-scalar-ptr, triton-to-structured, cse, canonicalize, "
            "triton-to-unstructured, dope-squeeze-unit-dims, triton-arith-to-linalg{pids-to-func-args=false pids-to-gpu=true}, "
            "structured-to-memref, triton-ptr-to-memref, reconcile-unrealized-casts, remove-dead-values, cse, canonicalize)")
# triton-shared 的 pids 选项 ⇒ tritonpass 的 grid-encoding（缺省 pids-to-func-args=true 即 args）
GPU_REF = "pids-to-func-args=false pids-to-gpu=true"

MARKER = "// -----"


def rename(text):
    text = re.sub(r"dope-[a-z0-9-]+", lambda m: RENAME.get(m.group(0), m.group(0)), text)
    text = text.replace(GPU_REF, "grid-encoding=gpu")
    return "--triton-arith-to-linalg=grid-encoding=args" if text == "--triton-arith-to-linalg" else text


def chunks(src, split):
    if not split:
        return [src]
    out, cur = [], []
    for line in src.splitlines(keepends=True):
        if line.rstrip() == MARKER:
            out.append("".join(cur))
            cur = []
        else:
            cur.append(line)
    out.append("".join(cur))
    return out


def reference(ref, args, src):
    """参照逐块跑，印通用形式；失败的块是空串。"""
    split = "--split-input-file" in args or "-split-input-file" in args
    flags = [a for a in args if a not in ("--split-input-file", "-split-input-file")]
    outs = []
    with tempfile.TemporaryDirectory() as d:
        for i, c in enumerate(chunks(src, split)):
            f = Path(d) / f"{i}.mlir"
            f.write_text(c)
            r = subprocess.run([ref, *flags, "--mlir-print-op-generic", str(f)], capture_output=True, text=True, timeout=60)
            outs.append(r.stdout if r.returncode == 0 else "")
    return (MARKER + "\n").join(outs)


def split_file(src):
    """lit 的 split-file：`//--- 名字` 分段。"""
    parts, name = {}, None
    for line in src.splitlines(keepends=True):
        m = re.match(r"^//--- (\S+)", line)
        if m:
            name = m.group(1)
            parts[name] = ""
        elif name:
            parts[name] += line
    return parts


def runs(path):
    """文件里的 RUN 命令（续行合并），只留调参照的那一段（第一个 `|` 之前）。"""
    text = path.read_text()
    lines = [m.group(1) for m in re.finditer(r"^// RUN:(.*)$", text, re.M)]
    cmds, cur = [], ""
    for l in lines:
        cur += l.strip()
        if cur.endswith("\\"):
            cur = cur[:-1] + " "
            continue
        cmds.append(cur)
        cur = ""
    return text, cmds


def lit(ref, tests):
    files = [tests / "Pass" / f"{n}.mlir" for n in LIT_PASS] + sorted((tests / "Conversion").rglob("*.mlir"))
    for path in files:
        text, cmds = runs(path)
        parts = split_file(text) if "split-file" in text else {}
        k = 0
        for cmd in cmds:
            seg = cmd.split("|")[0]
            if "dope-opt" not in seg or "%expect_rc" in seg or "dope-triton-to-std" in seg or "verify-diagnostics" in seg:
                continue
            toks = shlex.split(seg)
            toks = toks[toks.index("dope-opt") + 1:]
            src, args = None, []
            for t in toks:
                if t == "%s":
                    src = text
                elif t.startswith("%t/"):
                    src = parts[t[3:]]
                elif t == "-o":
                    break
                else:
                    args.append(t)
            if src is None:
                continue
            base = "__".join(path.relative_to(tests).with_suffix("").parts)
            yield f"{base}.{k}", [rename(a) for a in args], src, reference(ref, args, src)
            k += 1
            if "--triton-arith-to-linalg" in args:
                # 同一条 RUN 换成 gpu 写法再来一份：tritonpass 还没有 args 写法，这份保证转换本身有对拍
                gpu = [f"--triton-arith-to-linalg={GPU_REF}" if a == "--triton-arith-to-linalg" else a for a in args]
                yield f"{base}.{k}", [rename(a) for a in gpu], src, reference(ref, gpu, src)
                k += 1


def pipeline(ref, tests):
    for path in sorted(tests.rglob("*.ttir")):
        stem = "pipeline__" + "__".join(path.relative_to(tests).parts).replace(".ttir", "")
        src = path.read_text()
        args = [f"--pass-pipeline={PIPELINE}"]
        yield stem, [rename(a) for a in args], src, reference(ref, args, src)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--ref", required=True)
    ap.add_argument("--tests", required=True)
    o = ap.parse_args()
    OUT.mkdir(parents=True, exist_ok=True)
    for old in OUT.iterdir():
        old.unlink()
    n = 0
    for gen in (lit, pipeline):
        for stem, args, src, expect in gen(o.ref, Path(o.tests)):
            (OUT / f"{stem}.args").write_text("".join(a + "\n" for a in args))
            (OUT / f"{stem}.in.mlir").write_text(src)
            (OUT / f"{stem}.generic.mlir").write_text(expect)
            n += 1
    print(f"{n} runs")


if __name__ == "__main__":
    main()
