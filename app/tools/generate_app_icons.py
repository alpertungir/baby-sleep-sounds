#!/usr/bin/env python3
"""Build square launcher icons from app-icon-source.png.

- Crops landscape source to a centered square
- Uses app background #2D1B69 for adaptive icon background
- Scales artwork into Android adaptive-icon safe zone (~66%)
- Exports transparent foreground for adaptive icons
"""

from __future__ import annotations

from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "assets/icons/app-icon-source.png"
OUT_DIR = ROOT / "assets/icons"

CANVAS = 1024
APP_BG = (0x2D, 0x1B, 0x69, 255)
SAFE_SCALE = 0.64
BG_TOLERANCE = 52


def _color_dist(a: tuple[int, ...], b: tuple[int, ...]) -> float:
    return ((a[0] - b[0]) ** 2 + (a[1] - b[1]) ** 2 + (a[2] - b[2]) ** 2) ** 0.5


def _is_background(pixel: tuple[int, ...], refs: list[tuple[int, int, int]]) -> bool:
    rgb = pixel[:3]
    if _color_dist(rgb, APP_BG[:3]) <= BG_TOLERANCE:
        return True
    return min(_color_dist(rgb, ref) for ref in refs) <= BG_TOLERANCE


def _center_square(image: Image.Image) -> Image.Image:
    width, height = image.size
    side = min(width, height)
    left = (width - side) // 2
    top = (height - side) // 2
    cropped = image.crop((left, top, left + side, top + side))
    if side != CANVAS:
        cropped = cropped.resize((CANVAS, CANVAS), Image.LANCZOS)
    return cropped


def _extract_foreground(square: Image.Image) -> Image.Image:
    refs = [
        square.getpixel((8, 8))[:3],
        square.getpixel((CANVAS - 9, 8))[:3],
        square.getpixel((8, CANVAS - 9))[:3],
        square.getpixel((CANVAS - 9, CANVAS - 9))[:3],
    ]

    foreground = Image.new("RGBA", (CANVAS, CANVAS), (0, 0, 0, 0))
    src_px = square.load()
    out_px = foreground.load()
    for y in range(CANVAS):
        for x in range(CANVAS):
            pixel = src_px[x, y]
            if not _is_background(pixel, refs):
                out_px[x, y] = pixel
    return foreground


def _fit_safe_zone(foreground: Image.Image) -> Image.Image:
    safe = int(CANVAS * SAFE_SCALE)
    resized = foreground.resize((safe, safe), Image.LANCZOS)
    canvas = Image.new("RGBA", (CANVAS, CANVAS), (0, 0, 0, 0))
    offset = (CANVAS - safe) // 2
    canvas.paste(resized, (offset, offset), resized)
    return canvas


def main() -> None:
    if not SOURCE.is_file():
        raise SystemExit(f"Missing source icon: {SOURCE}")

    square = _center_square(Image.open(SOURCE).convert("RGBA"))
    foreground = _fit_safe_zone(_extract_foreground(square))

    full = Image.new("RGBA", (CANVAS, CANVAS), APP_BG)
    full.alpha_composite(foreground)

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    foreground.save(OUT_DIR / "app-icon-foreground.png")
    full.save(OUT_DIR / "app-icon.png")
    print(f"Wrote {OUT_DIR / 'app-icon-foreground.png'}")
    print(f"Wrote {OUT_DIR / 'app-icon.png'}")


if __name__ == "__main__":
    main()
