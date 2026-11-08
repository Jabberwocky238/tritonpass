#!/usr/bin/env python3
"""生成 src/dialect/traits.gen.rs：tt / tts 各 op 的 trait、接口、内存效应与固有属性（mlirformat 的 OpInfo 行）。

记录经 `mlirformat tblgen --dump-json` 读（与 mlirformat 自己的 scripts/traits.py 同一套走法，直接复用它的 Records）；
只留 mlirformat 的 `Trait` 枚举认得的名字（Triton 自己的 trait，如 SameOperandsAndResultEncoding，mlirpass 不问，丢掉）。

    python3 scripts/gen_traits.py --mlirformat <mlirformat> --mlirformat-src <mlirformat 源码> \
        --mlir-include <LLVM 的 include>

Triton 的 ODS 取自子模块 third_party/triton（钉 v3.7.1），tts 的取自子模块 third_party/triton-shared（钉 9424867）。
"""
import argparse
import importlib.util
import json
import re
import subprocess
from pathlib import Path


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--mlirformat", required=True)
    ap.add_argument("--mlirformat-src", required=True)
    ap.add_argument("--triton", default=str(Path(__file__).resolve().parent.parent / "third_party" / "triton"), help="缺省：子模块 third_party/triton（钉 v3.7.1）")
    ap.add_argument("--mlir-include", required=True)
    ap.add_argument("--tts-td", default=str(Path(__file__).resolve().parent.parent / "third_party/triton-shared/include/triton-shared/Dialect/TritonStructured/IR/TritonStructuredDialect.td"))
    ap.add_argument("-o", default=str(Path(__file__).resolve().parent.parent / "src" / "dialect" / "traits.gen.rs"))
    o = ap.parse_args()
    src = Path(o.mlirformat_src)
    spec = importlib.util.spec_from_file_location("traits", src / "scripts" / "traits.py")
    traits_py = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(traits_py)
    known = set(re.findall(r"^\s+(\w+),$", (src / "src" / "traits.gen.rs").read_text().split("traits! {", 1)[1].split("}", 1)[0], re.M))
    tri = Path(o.triton)
    tds = [tri / "include/triton/Dialect/Triton/IR/TritonOps.td", Path(o.tts_td)]
    incs = [o.mlir_include, str(tri / "include"), str(Path(o.tts_td).parents[4])]
    ops = {}
    for td in tds:
        args = [o.mlirformat, "tblgen", "--dump-json", str(td)]
        for i in incs + [str(td.parent)]:
            args += ["-I", i]
        out = subprocess.run(args, capture_output=True, text=True)
        if out.returncode != 0:
            raise SystemExit(f"{td}: {out.stderr.strip()}")
        for name, traits, effects, inherent in traits_py.Records(json.loads(out.stdout)).ops():
            if name.split(".", 1)[0] in ("tt", "tts"):
                ops[name] = (sorted(t for t in traits if t in known), effects, inherent)
    lines = [
        "//! 由 `scripts/gen_traits.py` 从 Triton 3.7.1 与 triton-shared 的 ODS 生成，不手改。",
        "",
        "use mlirformat::{Effect, EffectKind, EffectOn, Effects, OpInfo, OpInfos, Trait};",
        "",
        "/// tt / tts 各 op 的 trait、接口、内存效应与固有属性。",
        "pub fn register(infos: &mut OpInfos) {",
    ]
    for name in sorted(ops):
        traits, effects, inherent = ops[name]
        ts = ", ".join(f"Trait::{t}" for t in traits)
        if effects is None:
            eff = "Effects::Unknown"
        elif effects == "custom":
            eff = "Effects::Custom"
        else:
            def on(x):
                return "EffectOn::Op" if x == "Op" else "EffectOn::" + x
            es = ", ".join(f"Effect {{ kind: EffectKind::{k}, on: {on(w)}, resource: \"{r}\" }}" for k, w, r in effects)
            eff = f"Effects::Known(&[{es}])"
        attrs = ", ".join(f'"{a}"' for a in inherent)
        lines.append(f"    infos.insert(OpInfo {{ name: \"{name}\", traits: &[{ts}], effects: {eff}, inherent: &[{attrs}] }});")
    lines.append("}")
    Path(o.o).write_text("\n".join(lines) + "\n")
    print(f"{len(ops)} ops")


if __name__ == "__main__":
    main()
