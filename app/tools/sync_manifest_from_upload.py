#!/usr/bin/env python3
"""Rebuild firebase_sound_manifest.json from upload-source folder."""

from __future__ import annotations

import json
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT / "upload-source"
MANIFEST = Path(__file__).resolve().parent / "firebase_sound_manifest.json"
GENERATOR = Path(__file__).resolve().parent / "generate_firebase_catalog.py"
CATALOG = Path(__file__).resolve().parent / "generate_catalog_json.py"

FOLDERS = ["Background", "Classical", "National", "Relaxing"]


def main() -> None:
    if not SOURCE.is_dir():
        raise SystemExit(f"Missing upload source: {SOURCE}")

    manifest: dict[str, list[str]] = {}
    total = 0
    for folder in FOLDERS:
        local_dir = SOURCE / folder
        filenames = sorted(p.name for p in local_dir.glob("*.mp3")) if local_dir.is_dir() else []
        manifest[folder] = filenames
        total += len(filenames)
        print(f"{folder}: {len(filenames)} mp3")

    MANIFEST.write_text(json.dumps(manifest, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(f"Wrote {MANIFEST} ({total} files)")

    subprocess.run([sys.executable, str(GENERATOR)], check=True)
    subprocess.run([sys.executable, str(CATALOG)], check=True)


if __name__ == "__main__":
    main()
