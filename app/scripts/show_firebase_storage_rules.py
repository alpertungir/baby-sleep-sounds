#!/usr/bin/env python3
"""Print Firebase Storage rules for manual publish in Firebase Console."""

from pathlib import Path

RULES = Path(__file__).resolve().parents[2] / "firebase" / "storage.rules"

print("Firebase Console → Storage → Rules → yapıştır → Publish\n")
print(RULES.read_text(encoding="utf-8"))
