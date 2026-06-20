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
        "sound_count_19": "19 sounds",
        "sound_count_27": "27 sounds",
        "sleep_timer": "Sleep Timer",
        "favorites": "Favorites",
        "language": "Language",
        "english": "English",
        "fan": "Fan",
    },
    "tr": {
        "white_noise": "Beyaz Gürültü",
        "lullabies": "Ninniler",
        "sound_count_19": "19 ses",
        "sound_count_27": "27 ses",
        "sleep_timer": "Uyku Zamanlayıcısı",
        "favorites": "Favoriler",
        "language": "Dil",
        "english": "English",
        "fan": "Fan",
    },
}


def adb(*args: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(["adb", *args], check=True, text=True, capture_output=True)


def tap(x: int, y: int) -> None:
    adb("shell", "input", "tap", str(x), str(y))
    time.sleep(0.9)


def back() -> None:
    adb("shell", "input", "keyevent", "4")
    time.sleep(0.9)


def switch_locale_via_ui(xml: str, s: dict[str, str], target: str) -> str:
    """Open language sheet and pick target locale by menu label."""
    if target == "en" and find_bounds(xml, s["white_noise"], s["sound_count_19"]):
        return xml
    if target == "tr" and find_bounds(xml, STRINGS["tr"]["white_noise"], STRINGS["tr"]["sound_count_19"]):
        return xml

    for language_label in ("Language", "Dil", s["language"]):
        if find_bounds(xml, language_label):
            xml = tap_desc(xml, language_label)
            break
    else:
        raise RuntimeError("Language button not found")

    time.sleep(0.6)
    menu_label = s["english"] if target == "en" else STRINGS["tr"]["english"]
    if target == "tr":
        menu_label = "Türkçe"
    elif target != "en":
        raise RuntimeError(f"Unsupported UI locale switch: {target}")

    xml = tap_desc(xml, menu_label)
    time.sleep(1.2)
    return wait_for(xml, s["white_noise"], s["sound_count_19"])


def launch() -> None:
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


def find_bounds(xml: str, *needles: str) -> tuple[int, int, int, int] | None:
    for node in re.finditer(
        r'content-desc="([^"]*)"[^>]*bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"', xml
    ):
        desc, x1, y1, x2, y2 = node.group(1), *map(int, node.groups()[1:])
        normalized = desc.replace("&#10;", "\n")
        if all(n in normalized for n in needles):
            return x1, y1, x2, y2
    return None


def tap_desc(xml: str, *needles: str, retries: int = 8) -> str:
    for _ in range(retries):
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


def wait_for(xml: str, *needles: str, timeout: float = 12) -> str:
    deadline = time.time() + timeout
    while time.time() < deadline:
        if find_bounds(xml, *needles):
            return xml
        time.sleep(0.5)
        xml = dump_ui()
    raise RuntimeError(f"Timed out waiting for: {needles!r}")


def switch_to_english_if_needed(xml: str, s: dict[str, str]) -> str:
    return switch_locale_via_ui(xml, s, "en")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--locale", default="en", choices=sorted(STRINGS))
    args = parser.parse_args()
    s = STRINGS[args.locale]

    launch()
    xml = dump_ui()
    if args.locale == "en":
        xml = switch_to_english_if_needed(xml, s)
    else:
        xml = wait_for(xml, s["white_noise"], s["sound_count_19"])
    shot("01-home.png")

    xml = tap_desc(xml, s["white_noise"], s["sound_count_19"])
    xml = wait_for(xml, s["fan"])
    shot("02-white-noise.png")

    back()
    xml = dump_ui()
    xml = wait_for(xml, s["lullabies"], s["sound_count_27"])
    xml = tap_desc(xml, s["lullabies"], s["sound_count_27"])
    xml = wait_for(xml, s["sound_count_27"])
    shot("03-lullaby.png")

    back()
    xml = dump_ui()
    xml = wait_for(xml, s["white_noise"], s["sound_count_19"])
    xml = tap_desc(xml, s["white_noise"], s["sound_count_19"])
    xml = wait_for(xml, s["fan"])
    fan = find_bounds(xml, s["fan"])
    if not fan:
        raise RuntimeError("Fan sound row not found")
    tap(936, fan[1] + (fan[3] - fan[1]) // 2)
    time.sleep(3)
    xml = dump_ui()
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
