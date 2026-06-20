#!/usr/bin/env bash
# Gerçek MP3'leri files/baby-sleep-sounds/ → app/assets/sounds/ kopyalar.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/../files/baby-sleep-sounds"
APP="$ROOT/assets/sounds"

if [[ ! -d "$SRC" ]]; then
  echo "Kaynak bulunamadı: $SRC"
  exit 1
fi

mkdir -p "$APP/whitenoise" "$APP/lullaby" "$APP/turkish_lullaby"
cp "$SRC/WhiteNoise/Cutted_10"/*.mp3 "$APP/whitenoise/"
cp "$SRC/Lullaby"/*.mp3 "$APP/lullaby/"
cp "$SRC/National"/TR_*.mp3 "$APP/turkish_lullaby/"

echo "Kopyalandı:"
du -sh "$APP/whitenoise" "$APP/lullaby" "$APP/turkish_lullaby"
