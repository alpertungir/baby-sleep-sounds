#!/usr/bin/env python3
"""Generate Tngr Studio brand icon (512 and 1024)."""

from __future__ import annotations

from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[2]
OUT_DIR = ROOT / "store/tngr-studio"

BG = (0x2D, 0x1B, 0x69, 255)
BG_LIGHT = (0x3F, 0x2B, 0x7A, 255)
ACCENT = (0xFF, 0xB7, 0x4D, 255)
TEXT = (0xFF, 0xF8, 0xE1, 255)
MUTED = (0xCE, 0x93, 0xD8, 255)


def _load_font(size: int, bold: bool = False) -> ImageFont.FreeTypeFont | ImageFont.ImageFont:
    candidates = [
        "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf"
        if bold
        else "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
        "/usr/share/fonts/truetype/liberation/LiberationSans-Bold.ttf"
        if bold
        else "/usr/share/fonts/truetype/liberation/LiberationSans-Regular.ttf",
    ]
    for path in candidates:
        p = Path(path)
        if p.is_file():
            return ImageFont.truetype(str(p), size=size)
    return ImageFont.load_default()


def _draw_starfield(draw: ImageDraw.ImageDraw, size: int, seed: int = 7) -> None:
    points = [
        (size * 0.12, size * 0.18, 2),
        (size * 0.82, size * 0.14, 2),
        (size * 0.74, size * 0.72, 3),
        (size * 0.18, size * 0.78, 2),
        (size * 0.9, size * 0.46, 2),
    ]
    for x, y, r in points:
        draw.ellipse((x - r, y - r, x + r, y + r), fill=(255, 255, 255, 180))


def _draw_moon(draw: ImageDraw.ImageDraw, cx: float, cy: float, radius: float) -> None:
    draw.ellipse(
        (cx - radius, cy - radius, cx + radius, cy + radius),
        fill=ACCENT,
    )
    cut = radius * 0.72
    draw.ellipse(
        (cx - cut * 0.35, cy - radius, cx + cut * 1.35, cy + radius),
        fill=BG,
    )


def render_icon(size: int) -> Image.Image:
    img = Image.new("RGBA", (size, size), BG)
    draw = ImageDraw.Draw(img)

    for y in range(size):
        t = y / size
        r = int(BG[0] * (1 - t) + BG_LIGHT[0] * t)
        g = int(BG[1] * (1 - t) + BG_LIGHT[1] * t)
        b = int(BG[2] * (1 - t) + BG_LIGHT[2] * t)
        draw.line([(0, y), (size, y)], fill=(r, g, b, 255))

    _draw_starfield(draw, size)
    _draw_moon(draw, size * 0.34, size * 0.36, size * 0.11)

    title_font = _load_font(int(size * 0.19), bold=True)
    sub_font = _load_font(int(size * 0.075), bold=False)

    title = "Tngr"
    sub = "Studio"

    title_bbox = draw.textbbox((0, 0), title, font=title_font)
    title_w = title_bbox[2] - title_bbox[0]
    title_h = title_bbox[3] - title_bbox[1]
    sub_bbox = draw.textbbox((0, 0), sub, font=sub_font)
    sub_w = sub_bbox[2] - sub_bbox[0]

    text_x = size * 0.52
    title_y = size * 0.43
    draw.text((text_x, title_y), title, font=title_font, fill=TEXT)
    draw.text(
        (text_x + (title_w - sub_w) / 2, title_y + title_h + size * 0.03),
        sub,
        font=sub_font,
        fill=MUTED,
    )

    inset = int(size * 0.045)
    draw.rounded_rectangle(
        (inset, inset, size - inset, size - inset),
        radius=int(size * 0.12),
        outline=(255, 255, 255, 40),
        width=max(2, size // 256),
    )

    return img


def main() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for size, name in ((512, "icon-512.png"), (1024, "icon-1024.png")):
        path = OUT_DIR / name
        render_icon(size).save(path, optimize=True)
        print(f"Wrote {path}")


if __name__ == "__main__":
    main()
