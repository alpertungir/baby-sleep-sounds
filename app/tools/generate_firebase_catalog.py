#!/usr/bin/env python3
"""Generate Dart sound catalogs from app/tools/firebase_sound_manifest.json."""

from __future__ import annotations

import json
import re
from pathlib import Path

TOOLS = Path(__file__).resolve().parent
MANIFEST = TOOLS / "firebase_sound_manifest.json"
OUT = TOOLS.parent / "lib" / "data" / "sounds"

CATEGORY_MAP = {
    "Background": ("background", "SoundCategoryId.background", "assets/images/app/background-music.png"),
    "Classical": ("classic", "SoundCategoryId.classic", "assets/images/app/classic-music.png"),
    "National": ("national", "SoundCategoryId.national", "assets/images/app/national-music.png"),
    "Relaxing": ("relaxing", "SoundCategoryId.relaxing", "assets/images/app/relaxing-music.png"),
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


def emit_remote_file(
    category_folder: str,
    dart_file: str,
    const_name: str,
    cat_id: str,
    image: str,
    prefix: str,
    filenames: list[str],
    exclude: set[str] | None = None,
) -> None:
    storage_dir = STORAGE_FOLDER[category_folder]
    items: list[str] = []
    seen_ids: set[str] = set()
    for filename in sorted(filenames):
        if exclude and filename in exclude:
            continue
        sound_id = f"{prefix}_{slugify(filename)}"
        if sound_id in seen_ids:
            sound_id = f"{sound_id}_{len(seen_ids)}"
        seen_ids.add(sound_id)
        storage = f"sounds/{storage_dir}/{filename}"
        name = display_name(filename).replace("'", "\\'")
        items.append(
            f"  SoundItem(id: '{sound_id}', name: '{name}', categoryId: {cat_id}, "
            f"storagePath: '{storage}', imagePath: '{image}'),"
        )

    content = f"""import '../../models/sound_category.dart';
import '../../models/sound_item.dart';

const _image = '{image}';

const {const_name} = <SoundItem>[
{chr(10).join(items)}
];
"""
    OUT.joinpath(f"{dart_file}.dart").write_text(content, encoding="utf-8")
    print(f"Wrote {dart_file}.dart ({len(items)} sounds)")


def main() -> None:
    if not MANIFEST.exists():
        raise SystemExit(f"Missing manifest: {MANIFEST}")

    manifest: dict[str, list[str]] = json.loads(MANIFEST.read_text(encoding="utf-8"))

    jobs = [
        ("Background", "background_sounds", "backgroundSounds", "bg"),
        ("Classical", "classic_sounds", "classicSounds", "cl"),
        ("National", "national_sounds", "nationalSounds", "na"),
        ("Relaxing", "relaxing_sounds", "relaxingSounds", "re"),
    ]
    national_exclude = {name for name in manifest.get("National", []) if name.startswith("TR_")}
    for folder, dart_file, const_name, prefix in jobs:
        cat_id, image = CATEGORY_MAP[folder][1], CATEGORY_MAP[folder][2]
        exclude = national_exclude if folder == "National" else None
        emit_remote_file(
            folder,
            dart_file,
            const_name,
            cat_id,
            image,
            prefix,
            manifest.get(folder, []),
            exclude=exclude,
        )


if __name__ == "__main__":
    main()
