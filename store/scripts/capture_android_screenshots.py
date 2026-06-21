#!/usr/bin/env python3
"""Capture Play Store screenshots via adb + uiautomator (1080x2400)."""

from __future__ import annotations

import argparse
import re
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "store" / "screenshots" / "android"
PKG = "com.tngrstudio.babysleepsounds"
ACTIVITY = f"{PKG}/.MainActivity"

STRINGS = {
    "en": {
        "white_noise": "White Noise",
        "lullabies": "Lullabies",
        "sleep_timer": "Sleep Timer",
        "favorites": "Favorites",
        "language": "Language",
        "english": "English",
        "fan": "Fan",
        "home_ready": "White Noise",
    },
    "tr": {
        "white_noise": "Beyaz Gürültü",
        "lullabies": "Ninniler",
        "sleep_timer": "Uyku Zamanlayıcısı",
        "favorites": "Favoriler",
        "language": "Dil",
        "english": "English",
        "fan": "Fan",
        "home_ready": "Beyaz Gürültü",
    },
}


def adb(*args: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(["adb", *args], check=True, text=True, capture_output=True)


def wake_device() -> None:
    adb("shell", "input", "keyevent", "224")  # KEYCODE_WAKEUP
    time.sleep(0.4)
    adb("shell", "wm", "dismiss-keyguard")
    time.sleep(0.4)
    adb("shell", "input", "keyevent", "82")  # KEYCODE_MENU / unlock helper on some devices
    time.sleep(0.3)


def tap(x: int, y: int) -> None:
    adb("shell", "input", "tap", str(x), str(y))
    time.sleep(0.9)


def back() -> None:
    adb("shell", "input", "keyevent", "4")
    time.sleep(0.9)


def launch() -> None:
    wake_device()
    adb("shell", "am", "force-stop", PKG)
    time.sleep(0.8)
    adb("shell", "am", "start", "-n", ACTIVITY)
    time.sleep(5)


def dump_ui() -> str:
    adb("shell", "uiautomator", "dump", "/sdcard/ui.xml")
    return subprocess.check_output(["adb", "exec-out", "cat", "/sdcard/ui.xml"]).decode(
        "utf-8", errors="replace"
    )


def center(bounds: tuple[int, int, int, int]) -> tuple[int, int]:
    x1, y1, x2, y2 = bounds
    return (x1 + x2) // 2, (y1 + y2) // 2


def _normalize(label: str) -> str:
    return label.replace("&#10;", "\n")


def find_node(
    xml: str,
    *needles: str,
    attr: str = "content-desc",
    clickable: bool | None = None,
) -> tuple[int, int, int, int] | None:
    pattern = (
        rf'{attr}="([^"]*)"[^>]*'
        rf'(?:clickable="(true|false)")?[^>]*'
        rf'bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"'
    )
    for node in re.finditer(pattern, xml):
        value = _normalize(node.group(1))
        is_clickable = node.group(2)
        if clickable is True and is_clickable != "true":
            continue
        if clickable is False and is_clickable == "true":
            continue
        if all(needle in value for needle in needles):
            return int(node.group(3)), int(node.group(4)), int(node.group(5)), int(node.group(6))
    return None


def find_bounds(xml: str, *needles: str, clickable: bool | None = None) -> tuple[int, int, int, int] | None:
    bounds = find_node(xml, *needles, attr="content-desc", clickable=clickable)
    if bounds:
        return bounds
    return find_node(xml, *needles, attr="text", clickable=clickable)


def tap_desc(xml: str, *needles: str, retries: int = 10) -> str:
    for _ in range(retries):
        bounds = find_bounds(xml, *needles, clickable=True)
        if not bounds:
            bounds = find_bounds(xml, *needles)
        if bounds:
            x, y = center(bounds)
            tap(x, y)
            return dump_ui()
        time.sleep(0.5)
        xml = dump_ui()
    raise RuntimeError(f"UI node not found: {needles!r}")


def shot(name: str, delay: float = 0.8) -> None:
    time.sleep(delay)
    OUT.mkdir(parents=True, exist_ok=True)
    png = subprocess.check_output(["adb", "exec-out", "screencap", "-p"])
    path = OUT / name
    path.write_bytes(png)
    print(f"Saved {name} ({len(png)} bytes)")


def wait_for(xml: str, *needles: str, timeout: float = 15) -> str:
    deadline = time.time() + timeout
    while time.time() < deadline:
        if find_bounds(xml, *needles):
            return xml
        time.sleep(0.5)
        xml = dump_ui()
    raise RuntimeError(f"Timed out waiting for: {needles!r}")


def ensure_locale(xml: str, s: dict[str, str], target: str) -> str:
    if find_bounds(xml, s["home_ready"]):
        return xml

    xml = tap_desc(xml, s["language"])
    time.sleep(0.6)
    menu_label = "English" if target == "en" else "Türkçe"
    xml = tap_desc(xml, menu_label)
    time.sleep(1.5)
    return wait_for(xml, s["home_ready"])


def tap_play_on_row(xml: str, sound_name: str) -> str:
    row = find_bounds(xml, sound_name)
    if not row:
        raise RuntimeError(f"Sound row not found: {sound_name!r}")
    x1, y1, x2, y2 = row
    tap(x2 - 72, (y1 + y2) // 2)
    time.sleep(3)
    return dump_ui()


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--locale", default="en", choices=sorted(STRINGS))
    args = parser.parse_args()
    s = STRINGS[args.locale]

    launch()
    xml = dump_ui()
    xml = ensure_locale(xml, s, args.locale)
    shot("01-home.png")

    xml = tap_desc(xml, s["white_noise"])
    xml = wait_for(xml, s["fan"])
    shot("02-white-noise.png")

    back()
    xml = dump_ui()
    xml = wait_for(xml, s["lullabies"])
    xml = tap_desc(xml, s["lullabies"])
    xml = wait_for(xml, s["lullabies"])
    shot("03-lullaby.png")

    back()
    xml = dump_ui()
    xml = wait_for(xml, s["white_noise"])
    xml = tap_desc(xml, s["white_noise"])
    xml = wait_for(xml, s["fan"])
    xml = tap_play_on_row(xml, s["fan"])
    shot("04-player.png")

    xml = tap_desc(xml, s["sleep_timer"])
    time.sleep(1.2)
    shot("05-timer.png")
    back()

    back()
    xml = dump_ui()
    xml = wait_for(xml, s["favorites"])
    xml = tap_desc(xml, s["favorites"])
    time.sleep(1)
    shot("06-favorites.png")

    print(f"Done ({args.locale}) -> {OUT}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except subprocess.CalledProcessError as exc:
        print(exc.stderr or exc.stdout or exc, file=sys.stderr)
        raise
