#!/usr/bin/env python3
"""Generate sounds/catalog.json for Firebase Storage and app fallback asset."""

from __future__ import annotations

import json
import re
from datetime import datetime, timezone
from pathlib import Path

TOOLS = Path(__file__).resolve().parent
MANIFEST = TOOLS / "firebase_sound_manifest.json"
OUT_STORAGE = TOOLS.parent / "assets" / "catalog_fallback.json"

CATEGORY_META = {
    "Background": ("background", "bg", "assets/images/app/background-music.png"),
    "Classical": ("classic", "cl", "assets/images/app/classic-music.png"),
    "National": ("national", "na", "assets/images/app/national-music.png"),
    "Relaxing": ("relaxing", "re", "assets/images/app/relaxing-music.png"),
}

STORAGE_FOLDER = {
    "Background": "background",
    "Classical": "classic",
    "National": "national",
    "Relaxing": "relaxing",
}


def slugify(name: str) -> str:
    base = Path(name).stem
    slug = re.sub(r"[^a-zA-Z0-9]+", "_", base).strip("_").lower()
    return slug or "sound"


def display_name(filename: str) -> str:
    base = Path(filename).stem.replace("_", " ").replace("-", " ")
    return re.sub(r"\s+", " ", base).strip()


def build_catalog(manifest: dict[str, list[str]]) -> dict:
    sounds: list[dict[str, str]] = []
    seen_ids: set[str] = set()

    for folder, filenames in manifest.items():
        if folder not in CATEGORY_META:
            continue
        category, prefix, image = CATEGORY_META[folder]
        storage_dir = STORAGE_FOLDER[folder]

        for filename in sorted(filenames):
            if folder == "National" and filename.startswith("TR_"):
                continue

            sound_id = f"{prefix}_{slugify(filename)}"
            if sound_id in seen_ids:
                sound_id = f"{sound_id}_{len(seen_ids)}"
            seen_ids.add(sound_id)

            sounds.append(
                {
                    "id": sound_id,
                    "name": display_name(filename),
                    "category": category,
                    "storagePath": f"sounds/{storage_dir}/{filename}",
                    "imagePath": image,
                }
            )

    return {
        "version": 1,
        "updatedAt": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "sounds": sounds,
    }


def main() -> None:
    if not MANIFEST.exists():
        raise SystemExit(f"Missing manifest: {MANIFEST}")

    manifest = json.loads(MANIFEST.read_text(encoding="utf-8"))
    catalog = build_catalog(manifest)
    OUT_STORAGE.parent.mkdir(parents=True, exist_ok=True)
    OUT_STORAGE.write_text(json.dumps(catalog, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(f"Wrote {OUT_STORAGE} ({len(catalog['sounds'])} sounds)")


if __name__ == "__main__":
    main()
