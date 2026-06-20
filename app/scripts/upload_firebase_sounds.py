#!/usr/bin/env python3
"""Upload MP3 library to Firebase Storage using firebase_sound_manifest.json."""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

TOOLS = Path(__file__).resolve().parents[1] / "tools"
MANIFEST = TOOLS / "firebase_sound_manifest.json"
CATALOG_JSON = Path(__file__).resolve().parents[1] / "assets" / "catalog_fallback.json"
CATALOG_REMOTE_PATH = "sounds/catalog.json"
BUCKET = "baby-sleep-sounds-482b5.appspot.com"

SOURCE_FOLDERS = {
    "Background": "Background",
    "Classical": "Classical",
    "National": "National",
    "Relaxing": "Relaxing",
}

STORAGE_FOLDERS = {
    "Background": "background",
    "Classical": "classic",
    "National": "national",
    "Relaxing": "relaxing",
}

NATIONAL_SKIP_PREFIX = "TR_"


def load_manifest() -> dict[str, list[str]]:
    return json.loads(MANIFEST.read_text(encoding="utf-8"))


def collect_uploads(source_root: Path, manifest: dict[str, list[str]]) -> list[tuple[Path, str]]:
    uploads: list[tuple[Path, str]] = []
    missing: list[str] = []

    for category, filenames in manifest.items():
        local_dir = source_root / SOURCE_FOLDERS[category]
        storage_dir = STORAGE_FOLDERS[category]

        for filename in filenames:
            if category == "National" and filename.startswith(NATIONAL_SKIP_PREFIX):
                continue

            local_file = local_dir / filename
            remote_path = f"sounds/{storage_dir}/{filename}"

            if local_file.is_file():
                uploads.append((local_file, remote_path))
            else:
                missing.append(str(local_file))

    return uploads, missing


def upload_all(uploads: list[tuple[Path, str]], dry_run: bool, credentials_path: Path | None) -> None:
    if dry_run:
        print(f"Dry run — {len(uploads)} files would be uploaded to gs://{BUCKET}/")
        for local_file, remote_path in uploads[:5]:
            print(f"  {local_file} -> {remote_path}")
        if len(uploads) > 5:
            print(f"  ... and {len(uploads) - 5} more")
        return

    try:
        from google.cloud import storage
    except ImportError:
        print(
            "google-cloud-storage not installed.\n"
            "Run: python3 -m pip install --user google-cloud-storage",
            file=sys.stderr,
        )
        sys.exit(1)

    if credentials_path:
        from google.oauth2 import service_account

        credentials = service_account.Credentials.from_service_account_file(
            str(credentials_path),
            scopes=["https://www.googleapis.com/auth/cloud-platform"],
        )
        client = storage.Client(project="baby-sleep-sounds-482b5", credentials=credentials)
    else:
        client = storage.Client(project="baby-sleep-sounds-482b5")
    bucket = client.bucket(BUCKET)

    total = len(uploads)
    for index, (local_file, remote_path) in enumerate(uploads, start=1):
        blob = bucket.blob(remote_path)
        blob.upload_from_filename(str(local_file), content_type="audio/mpeg")
        print(f"[{index}/{total}] {remote_path}")


def upload_catalog(dry_run: bool, credentials_path: Path | None) -> None:
    if not CATALOG_JSON.is_file():
        print(f"Warning: missing {CATALOG_JSON} — run app/tools/generate_catalog_json.py", file=sys.stderr)
        return

    if dry_run:
        print(f"Dry run — would upload {CATALOG_JSON.name} -> gs://{BUCKET}/{CATALOG_REMOTE_PATH}")
        return

    try:
        from google.cloud import storage
    except ImportError:
        print("google-cloud-storage not installed.", file=sys.stderr)
        sys.exit(1)

    if credentials_path:
        from google.oauth2 import service_account

        credentials = service_account.Credentials.from_service_account_file(
            str(credentials_path),
            scopes=["https://www.googleapis.com/auth/cloud-platform"],
        )
        client = storage.Client(project="baby-sleep-sounds-482b5", credentials=credentials)
    else:
        client = storage.Client(project="baby-sleep-sounds-482b5")

    bucket = client.bucket(BUCKET)
    blob = bucket.blob(CATALOG_REMOTE_PATH)
    blob.upload_from_filename(str(CATALOG_JSON), content_type="application/json")
    print(f"Uploaded {CATALOG_REMOTE_PATH}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Upload sound library to Firebase Storage.")
    parser.add_argument(
        "source",
        type=Path,
        help="Root folder containing Background/, Classical/, National/, Relaxing/",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="List files without uploading",
    )
    parser.add_argument(
        "--credentials",
        type=Path,
        help="Path to Firebase service account JSON (Project settings → Service accounts)",
    )
    args = parser.parse_args()

    source_root = args.source.expanduser().resolve()
    if not source_root.is_dir():
        print(f"Source folder not found: {source_root}", file=sys.stderr)
        sys.exit(1)

    manifest = load_manifest()
    uploads, missing = collect_uploads(source_root, manifest)

    if missing:
        print(f"Warning: {len(missing)} files missing locally:", file=sys.stderr)
        for path in missing[:10]:
            print(f"  - {path}", file=sys.stderr)
        if len(missing) > 10:
            print(f"  ... and {len(missing) - 10} more", file=sys.stderr)

    if not uploads:
        print("No files to upload.", file=sys.stderr)
        sys.exit(1)

    print(f"Ready: {len(uploads)} files from {source_root}")
    upload_all(uploads, dry_run=args.dry_run, credentials_path=args.credentials)
    upload_catalog(dry_run=args.dry_run, credentials_path=args.credentials)
    print("Done.")


if __name__ == "__main__":
    main()
