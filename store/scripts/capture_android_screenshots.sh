#!/usr/bin/env bash
# Capture Play Store screenshots on connected Android device (1080x2400).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT="$ROOT/store/screenshots/android"
PKG=com.tngrstudio.babysleepsounds
ACTIVITY=$PKG/.MainActivity

mkdir -p "$OUT"

shot() {
  local file="$1"
  sleep "$2"
  adb exec-out screencap -p > "$OUT/$file"
  echo "Saved $file ($(file "$OUT/$file" | cut -d, -f2 | tr -d ' '))"
}

tap() { adb shell input tap "$1" "$2"; sleep 0.7; }
back() { adb shell input keyevent 4; sleep 0.9; }
home_app() {
  adb shell am start -n "$ACTIVITY" --activity-clear-top
  sleep 3
}

adb shell am force-stop "$PKG" || true
sleep 1
adb shell am start -n "$ACTIVITY"
sleep 5

shot "01-home.png" 0.8

# Category cards (from uiautomator bounds)
tap 283 822
shot "02-white-noise.png" 1

back
tap 796 822
shot "03-lullaby.png" 1

back
tap 283 822
sleep 0.8
# Fan row play button
tap 936 1160
sleep 3
shot "04-player.png" 0.5

# Sleep timer icon in app bar
tap 1008 191
sleep 1.2
shot "05-timer.png" 0.5
back

back
tap 864 191
sleep 1
shot "06-favorites.png" 0.5

echo "Done. Files in $OUT"
