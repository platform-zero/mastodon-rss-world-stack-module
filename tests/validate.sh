#!/usr/bin/env bash
set -euo pipefail
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
python3 - "$repo_root/stack.module.json" "$repo_root" <<'PY'
import json
import pathlib
import sys

metadata_path = pathlib.Path(sys.argv[1])
repo_root = pathlib.Path(sys.argv[2])
metadata = json.loads(metadata_path.read_text(encoding="utf-8"))

for key in ("runtimeDependencies", "contracts", "overlays"):
    if key not in metadata:
        raise SystemExit(f"missing metadata key: {key}")
if metadata["runtimeDependencies"] != metadata.get("dependencies", []):
    raise SystemExit("content-pack runtime dependencies must match dependencies")
if "module-contract" not in metadata["contracts"]:
    raise SystemExit("missing module-contract declaration")
for overlay in metadata["overlays"]:
    if not (repo_root / overlay).exists():
        raise SystemExit(f"missing overlay: {overlay}")
PY
