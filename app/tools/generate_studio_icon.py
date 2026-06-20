#!/usr/bin/env python3
"""Generate Tngr Studio developer assets — simple, elegant profile icon + header."""

from __future__ import annotations

from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[2]
OUT_DIR = ROOT / "store/tngr-studio"

BG_TOP = (0xEE, 0xF1, 0xF6)
BG_BOTTOM = (0xD5, 0xDE, 0xEA)
INK = (0x24, 0x34, 0x47)
INK_SOFT = (0x4A, 0x5C, 0x70)
ACCENT = (0x6B, 0x8A, 0xA8)


def _font(path: str, size: int) -> ImageFont.FreeTypeFont | ImageFont.ImageFont:
    p = Path(path)
    if p.is_file():
        return ImageFont.truetype(str(p), size=size)
    return ImageFont.load_default()


def _lerp(a: int, b: int, t: float) -> int:
    return int(a * (1 - t) + b * t)


def _lerp_rgb(c1: tuple[int, int, int], c2: tuple[int, int, int], t: float) -> tuple[int, int, int]:
    return (_lerp(c1[0], c2[0], t), _lerp(c1[1], c2[1], t), _lerp(c1[2], c2[2], t))


def _soft_background(size: int) -> Image.Image:
    img = Image.new("RGB", (size, size), BG_BOTTOM)
    draw = ImageDraw.Draw(img)
    cx = cy = size / 2
    for i in range(60, 0, -1):
        t = i / 60
        r = size * 0.72 * t
        color = _lerp_rgb(BG_TOP, BG_BOTTOM, 1 - t * 0.7)
        draw.ellipse((cx - r, cy - r, cx + r, cy + r), fill=color)
    return img


def _draw_wordmark(
    draw: ImageDraw.ImageDraw,
    cx: float,
    cy: float,
    scale: float,
    *,
    title_size: float,
    subtitle_size: float,
) -> None:
    title_font = _font("/usr/share/fonts/truetype/liberation/LiberationSans-Bold.ttf", int(scale * title_size))
    sub_font = _font("/usr/share/fonts/truetype/liberation/LiberationSansNarrow-Regular.ttf", int(scale * subtitle_size))

    title = "Tngr"
    subtitle = "STUDIO"

    title_bbox = draw.textbbox((0, 0), title, font=title_font)
    title_w = title_bbox[2] - title_bbox[0]
    title_h = title_bbox[3] - title_bbox[1]

    sub_bbox = draw.textbbox((0, 0), subtitle, font=sub_font)
    sub_w = sub_bbox[2] - sub_bbox[0]

    title_y = cy - scale * 0.10
    draw.text((cx - title_w / 2, title_y), title, font=title_font, fill=INK)

    line_y = title_y + title_h + scale * 0.04
    line_w = scale * 0.18
    draw.line([(cx - line_w / 2, line_y), (cx + line_w / 2, line_y)], fill=ACCENT, width=max(2, int(scale * 0.008)))

    sub_y = line_y + scale * 0.035
    draw.text((cx - sub_w / 2, sub_y), subtitle, font=sub_font, fill=INK_SOFT)


def render_icon(size: int) -> Image.Image:
    img = _soft_background(size)
    draw = ImageDraw.Draw(img)
    _draw_wordmark(draw, size * 0.5, size * 0.5, size * 0.55, title_size=0.18, subtitle_size=0.058)
    return img


def render_header(width: int, height: int) -> Image.Image:
    img = Image.new("RGB", (width, height), BG_TOP)
    draw = ImageDraw.Draw(img)

    for y in range(height):
        t = y / height
        color = _lerp_rgb(BG_TOP, BG_BOTTOM, t * 0.45)
        draw.line([(0, y), (width, y)], fill=color)

    accent_x = int(width * 0.72)
    accent_y = int(height * 0.5)
    accent_r = int(height * 0.28)
    draw.ellipse(
        (accent_x - accent_r, accent_y - accent_r, accent_x + accent_r, accent_y + accent_r),
        fill=_lerp_rgb(BG_BOTTOM, ACCENT, 0.35),
    )
    draw.ellipse(
        (accent_x - accent_r * 0.55, accent_y - accent_r * 0.55, accent_x + accent_r * 0.55, accent_y + accent_r * 0.55),
        fill=BG_TOP,
    )

    scale = height * 0.55
    _draw_wordmark(draw, width * 0.22, height * 0.52, scale, title_size=0.22, subtitle_size=0.07)
    return img


def main() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)

    outputs = (
        (512, "icon-512.png"),
        (1024, "icon-1024.png"),
    )
    for size, name in outputs:
        path = OUT_DIR / name
        render_icon(size).save(path, format="PNG", optimize=True)
        print(f"Wrote {path}")

    header_path = OUT_DIR / "developer-header-4096x2304.png"
    render_header(4096, 2304).save(header_path, format="PNG", optimize=True)
    print(f"Wrote {header_path}")


if __name__ == "__main__":
    main()
